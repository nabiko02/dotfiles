#!/bin/bash
VID="04f2"
PID="b5ab"

BUSID=$(usbip list -l | awk -v vid="$VID" -v pid="$PID" '
  $0 ~ vid":"pid {print prev} {prev=$0}' | sed -E 's/.*busid ([^ ]+).*/\1/' | xargs)

if [ -z "$BUSID" ]; then
    echo "ℹ️ Can't unbind webcam"
    exit 0
fi

echo "🔄 Attempt to unbind : $BUSID"
sudo usbip unbind -b "$BUSID"
echo "✅ Webcam detached : $BUSID"


sudo systemctl stop usbipd
echo "✅ Service usbip stopped"
