#!/usr/bin/env bash
#
# secureboot-tpm-setup.sh
#
# Sets up Secure Boot (sbctl) + TPM2 auto-unlock of a LUKS2 root on a fresh
# Arch Linux install. The LUKS key is released by the TPM only when the
# Secure Boot chain is intact (PCR 7), so no passphrase is needed at boot.
#
# REQUIREMENTS (before running):
#   - Fresh Arch install, booted in UEFI mode
#   - Root filesystem on a LUKS2 partition (created with cryptsetup luksFormat)
#   - A TPM 2.0 chip
#   - Secure Boot in "Setup Mode" in firmware for phase 1
#     (firmware settings -> Secure Boot -> clear/delete keys, or "Setup Mode")
#
# USAGE:
#   Phase 1 (Secure Boot disabled or in Setup Mode):
#       ./secureboot-tpm-setup.sh phase1 /dev/nvme0n1p2
#   Then reboot, ENABLE Secure Boot in firmware, boot back into the system.
#   Phase 2 (Secure Boot now enabled):
#       ./secureboot-tpm-setup.sh phase2 /dev/nvme0n1p2
#
# Replace /dev/nvme0n1p2 with your LUKS2 partition.

set -euo pipefail

err()  { printf 'ERROR: %s\n' "$*" >&2; exit 1; }
info() { printf '==> %s\n' "$*"; }

[[ $EUID -eq 0 ]] || err "Run as root."
[[ $# -eq 2 ]] || err "Usage: $0 <phase1|phase2> <luks-partition>"

PHASE="$1"
LUKS_DEV="$2"

[[ -d /sys/firmware/efi ]] || err "Not booted in UEFI mode."
[[ -b "$LUKS_DEV" ]] || err "$LUKS_DEV is not a block device."
cryptsetup isLuks --type luks2 "$LUKS_DEV" \
    || err "$LUKS_DEV is not a LUKS2 device."
[[ -c /dev/tpmrm0 || -c /dev/tpm0 ]] || err "No TPM 2.0 device found."

LUKS_UUID="$(blkid -s UUID -o value "$LUKS_DEV")"
ESP=""
for candidate in /efi /boot /boot/efi; do
    if mountpoint -q "$candidate" 2>/dev/null \
       && [[ "$(findmnt -no FSTYPE "$candidate")" == "vfat" ]]; then
        ESP="$candidate"
        break
    fi
done
[[ -n "$ESP" ]] || err "No mounted vfat ESP found at /efi, /boot or /boot/efi. Mount your EFI System Partition first."
info "Using ESP: $ESP"
info "LUKS UUID: $LUKS_UUID"

phase1() {
    info "Installing required packages"
    pacman -S --needed --noconfirm sbctl systemd-ukify tpm2-tss efibootmgr

    info "Checking Secure Boot status"
    sb_status="$(sbctl status 2>&1 || true)"
    printf '%s\n' "$sb_status"
    if ! grep -qi 'setup mode.*enabled' <<< "$sb_status"; then
        err "Firmware is not in Setup Mode. Enter firmware settings and clear Secure Boot keys, then re-run phase1."
    fi

    info "Creating and enrolling Secure Boot keys (keeping Microsoft keys for firmware/option ROM compatibility)"
    sbctl create-keys
    sbctl enroll-keys --microsoft

    info "Writing kernel command line (/etc/kernel/cmdline)"
    # rd.luks.options=tpm2-device=auto makes the initramfs try TPM unlock,
    # falling back to passphrase prompt if the TPM refuses.
    cat > /etc/kernel/cmdline <<EOF
rd.luks.name=${LUKS_UUID}=root rd.luks.options=${LUKS_UUID}=tpm2-device=auto root=/dev/mapper/root rw quiet
EOF

    info "Switching mkinitcpio to systemd hooks (sd-encrypt)"
    # systemd-based initramfs is required for TPM2 LUKS unlocking
    sed -i \
        's/^HOOKS=.*/HOOKS=(base systemd autodetect microcode modconf kms keyboard sd-vconsole block sd-encrypt filesystems fsck)/' \
        /etc/mkinitcpio.conf

    info "Enabling UKI build in mkinitcpio presets"
    install -d "$ESP/EFI/Linux"
    shopt -s nullglob
    presets=(/etc/mkinitcpio.d/*.preset)
    shopt -u nullglob
    [[ ${#presets[@]} -gt 0 ]] || err "No mkinitcpio presets found in /etc/mkinitcpio.d/ - is a kernel package installed?"
    for preset in "${presets[@]}"; do
        kernel_name="$(basename "$preset" .preset)"
        cat > "$preset" <<EOF
ALL_kver="/boot/vmlinuz-${kernel_name}"

PRESETS=('default' 'fallback')

default_uki="${ESP}/EFI/Linux/arch-${kernel_name}.efi"
default_options="--splash /usr/share/systemd/bootctl/splash-arch.bmp"

fallback_uki="${ESP}/EFI/Linux/arch-${kernel_name}-fallback.efi"
fallback_options="-S autodetect"
EOF
    done

    info "Installing systemd-boot"
    bootctl install --esp-path="$ESP"

    info "Building UKIs"
    mkinitcpio -P

    info "Signing bootloader and UKIs"
    sbctl sign -s "$ESP/EFI/systemd/systemd-boot"*.efi
    sbctl sign -s "$ESP/EFI/BOOT/BOOTX64.EFI"
    for uki in "$ESP"/EFI/Linux/*.efi; do
        sbctl sign -s "$uki"
    done
    # verify is informational only; non-zero exit must not abort the script
    sbctl verify || info "Some files reported unsigned by sbctl verify - review the list above. Anything outside EFI/systemd and EFI/Linux is usually a leftover and can be ignored or deleted."

    cat <<'EOF'

Phase 1 complete.

NEXT STEPS:
  1. Reboot into firmware settings:  systemctl reboot --firmware-setup
  2. ENABLE Secure Boot (keys are already enrolled by sbctl).
  3. Boot back into Arch (you will be asked for the LUKS passphrase one
     last time).
  4. Run:  ./secureboot-tpm-setup.sh phase2 <luks-partition>
EOF
}

phase2() {
    info "Verifying Secure Boot is enabled"
    sb_status="$(sbctl status 2>&1 || true)"
    printf '%s\n' "$sb_status"
    if ! grep -qi 'secure boot.*enabled' <<< "$sb_status"; then
        err "Secure Boot is NOT enabled. Enable it in firmware first, then re-run phase2. Enrolling the TPM now would bind to the wrong PCR 7 state."
    fi

    info "Removing any stale TPM2 enrollment"
    systemd-cryptenroll --wipe-slot=tpm2 "$LUKS_DEV" || true

    info "Enrolling TPM2 (bound to PCR 7 - Secure Boot state). You will be asked for an existing LUKS passphrase."
    systemd-cryptenroll \
        --tpm2-device=auto \
        --tpm2-pcrs=7 \
        "$LUKS_DEV"

    info "Verifying enrollment"
    cryptsetup luksDump "$LUKS_DEV" | grep -A2 'systemd-tpm2' \
        || err "TPM2 token not found in LUKS header."

    cat <<'EOF'

Phase 2 complete. Reboot to test: the system should unlock the root
filesystem without a passphrase.

IMPORTANT - keep these in mind:
  - Your LUKS passphrase keyslot is still active. KEEP IT. It is your
    only recovery path if the TPM refuses to unseal.
  - PCR 7 changes (firmware update, Secure Boot toggled, key changes)
    will break auto-unlock until you re-run:
        systemd-cryptenroll --wipe-slot=tpm2 <dev>
        systemd-cryptenroll --tpm2-device=auto --tpm2-pcrs=7 <dev>
  - After every kernel/bootloader update, files must be re-signed.
    Install the sbctl pacman hook (installed by default with sbctl) -
    verify with:  sbctl verify
EOF
}

case "$PHASE" in
    phase1) phase1 ;;
    phase2) phase2 ;;
    *) err "Unknown phase: $PHASE (use phase1 or phase2)" ;;
esac
