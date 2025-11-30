# Install

```bash
mkdir -p $HOME/Android/sdk
cd $HOME/Android/sdk
wget https://dl.google.com/android/repository/commandlinetools-linux-13114758_latest.zip
unzip commandlinetools-linux-13114758_latest.zip
mkdir -p cmdline-tools/latest
mv cmdline-tools/* cmdline-tools/latest/ 2>/dev/null || true
rm commandlinetools-linux-13114758_latest.zip

sdkmanager --licenses
sdkmanager "platform-tools" "emulator"
sdkmanager "system-images;android-35;google_apis_playstore;x86_64"
```

## zshrc

```bash
    export ANDROID_HOME="$HOME/Android/sdk"
    # in PATH
    $ANDROID_HOME/cmdline-tools/latest/bin
    $ANDROID_HOME/platform-tools
    $ANDROID_HOME/emulator
```

## Create AVD

```bash
avdmanager create avd \
    -n pixel9-emulator \
    -k "system-images;android-35;google_apis_playstore;x86_64" \
    -d "pixel_9"
```

### Listing devices

```bash
avdmanager list device
```

## Config avd

Edit $HOME/.android/avd/pixel9-emulator.avd/config.ini

```ini
PlayStore.enabled = yes
...
disk.dataPartition.size = 40G
...
hw.gpu.enabled = yes
hw.gpu.mode = host 
...
hw.ramSize = 8G
...
hw.keyboard=yes
hw.dPad=yes
hw.mainKeys=yes

```

If not first run AND editing the PlayStore/dataPartition => run emulator with the `-wipe-data` flag

## Run avd

```bash
emulator -avd pixel9-emulator
```

## Install desktop entry

- copy .desktop into .local/share/application
- copy svg into  .local/share/icons
