#!/bin/bash

VID="04f2"
PID="b5ab"

BUSID=$(usbip list -l | awk -v vid="$VID" -v pid="$PID" '
  $0 ~ vid":"pid {print prev} {prev=$0}' | sed -E 's/.*busid ([^ ]+).*/\1/' | xargs)

if [ -z "$BUSID" ]; then
  echo "❌ Can't find webcam (VID:PID = ${VID}:${PID})"
  exit 1
fi

echo "✅ Found webcam : busid $BUSID"

sudo modprobe usbip_host 2>/dev/null
sudo systemctl enable --now usbipd

echo "🔄 Attempt to bind..."
sudo usbip bind -b "$BUSID"

echo "✅ Webcam binded on $BUSID"
