#!/bin/sh
#This scripts installs Maya 2019 silently and with the option for a network license server.
#Easiest way to deploy is to create a package that will copy "Install Maya 2019.app" into /tmp/ then run this script as a post-install task.
#Tested with macOS 10.13, 10.14 and 10.15 beta using a Jamf Composer package.
#Created by Gary Lee 2019
############################################################################################


#Set your serial number and network license server below.
#Key shouldn't need to be altered as it is not license specific.
SERIAL="123-12345678"
SERVER="your.server.net"
KEY="657K1"

#No need to alter below this line
############################################################################################

if [[ -e /tmp/Install\ Maya\ 2019.app/Contents/MacOS/setup ]]; then
    /tmp/Install\ Maya\ 2019.app/Contents/MacOS/setup --noui --serial_number=$SERIAL --product_key=$KEY --license_type=kNetwork --server_name=$SERVER

    if [[ ! -e /Library/Application\ Support/Autodesk/CLM/LGS/657K1_2019.0.0.F ]]; then
        mkdir -p /Library/Application\ Support/Autodesk/CLM/LGS/657K1_2019.0.0.F
    fi

    cat<<EOF>/Library/Application\ Support/Autodesk/CLM/LGS/657K1_2019.0.0.F/LGS.data
_NETWORK
EOF

    cat<<EOF>/Library/Application\ Support/Autodesk/CLM/LGS/657K1_2019.0.0.F/LICPATH.lic
SERVER $SERVER 000000000000
USE_SERVER
EOF

    cat<<EOF>/Library/Application\ Support/Autodesk/CLM/LGS/657K1_2019.0.0.F/nw.cfg
done
EOF

else
    echo "ERROR: Maya installer not found in tmp."
    exit 1
fi

rm -rf /tmp/Install\ Maya\ 2019.app

exit 0