#!/bin/sh

FIRMWARE_DIRS="/lib/firmware /lib/firmware/postmarketos"

exec >>/var/log/firmwareload.log 2>&1

if [ ! -e /sys/$DEVPATH/loading ]; then
    echo "Firmware loader misses sysfs directory"
    exit 1
fi

for DIR in $FIRMWARE_DIRS; do
    [ -e "$DIR/$FIRMWARE" ] || continue
    echo "Loading $DIR/$FIRMWARE"
    echo 1 > /sys/$DEVPATH/loading
    cat "$DIR/$FIRMWARE" > /sys/$DEVPATH/data
    echo 0 > /sys/$DEVPATH/loading
    exit
done

echo -1 > /sys/$DEVPATH/loading
echo "Cannot find firmware file '$FIRMWARE'"
exit 1
