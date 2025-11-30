# ─────────────────────────────────────────────
# Performance Optimizations
# ─────────────────────────────────────────────
# Skip global compinit - we'll handle it manually
skip_global_compinit=1

# ─────────────────────────────────────────────
# Oh My Zsh Setup
# ─────────────────────────────────────────────
export ZSH="$HOME/.oh-my-zsh"
plugins=(zsh-autosuggestions zsh-syntax-highlighting fzf)

source "$ZSH/oh-my-zsh.sh"

# ─────────────────────────────────────────────
# Optimized Completions
# ─────────────────────────────────────────────
# Only run compinit once per day for better performance
autoload -Uz compinit
for dump in ~/.zcompdump(N.mh+24); do
    compinit -d ~/.zcompdump
done
[[ -f ~/.zcompdump ]] && compinit -C -d ~/.zcompdump

# ─────────────────────────────────────────────
# Environment Variables
# ─────────────────────────────────────────────
export EDITOR="nvim"
export KUBE_EDITOR="nvim"

export ANDROID_HOME="$HOME/Android/sdk"

# Optimize PATH building
typeset -U path  # Remove duplicates automatically
path=(
    $HOME/.cargo/bin
    $HOME/.local/bin
    ${KREW_ROOT:-$HOME/.krew}/bin
    $HOME/go/bin
    $ANDROID_HOME/cmdline-tools/latest/bin
    $ANDROID_HOME/platform-tools
    $ANDROID_HOME/emulator
    $HOME/bin
    /lib/qt6/bin
    $path
    $HOME/.config/emacs/bin
    $HOME/.bun/bin
)

# ─────────────────────────────────────────────
# Custom Functions
# ─────────────────────────────────────────────
# 'y' function to open Yazi and change to last visited dir
function y() {
	local tmp="$(mktemp -t "yazi-cwd.XXXXXX")" cwd
	yazi "$@" --cwd-file="$tmp"
	if cwd="$(<"$tmp")" && [ -n "$cwd" ] && [ "$cwd" != "$PWD" ]; then
		builtin cd -- "$cwd"
	fi
	rm -f -- "$tmp"
}

# ─────────────────────────────────────────────
# Aliases and Additional Config
# ─────────────────────────────────────────────
# Load bash aliases if present
[ -f ~/.bash_aliases ] && source ~/.bash_aliases

# ─────────────────────────────────────────────
# Plugins and Completions
# ─────────────────────────────────────────────

[ -f "$HOME/.zsh_autocomplete" ] && source "$HOME/.zsh_autocomplete"

# SDKMAN
export SDKMAN_DIR="$HOME/.sdkman"
[[ -s "$HOME/.sdkman/bin/sdkman-init.sh" ]] && source "$HOME/.sdkman/bin/sdkman-init.sh"

# starship init
if command -v starship &> /dev/null; then
    # Set config path if the file exists, otherwise let starship use defaults
    if [[ -f "$HOME/.config/starship/starship.toml" ]]; then
        export STARSHIP_CONFIG="$HOME/.config/starship/starship.toml"
    fi
    eval "$(starship init zsh)"
fi

# zoxide init
if command -v zoxide &> /dev/null; then
    eval "$(zoxide init zsh --cmd cd)"
fi

# ─────────────────────────────────────────────
# Deferred Loading (Background)
# ─────────────────────────────────────────────
# Load these after shell is ready
{
    # pipx autocomplete
    if command -v pipx &> /dev/null && command -v register-python-argcomplete &> /dev/null; then
        eval "$(register-python-argcomplete pipx)"
    fi


} &!
