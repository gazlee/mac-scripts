#!/bin/sh
#This scripts installs Maya 2016 silently and with the option for a network license server. 
#It has only been tested on macOS 10.11, 10.12, 10.13 and 10.14 so far.
#Gary Lee 2017

if [[ -e /tmp/Install\ Maya\ 2016.app/Contents/MacOS/setup ]]; then
    /tmp/Install\ Maya\ 2016.app/Contents/MacOS/setup --noui --serial_number=560-xxxxxxxx --product_key=793H1 --license_type=kNetwork --server_name=your-server.net

    if [[ ! -e /Library/Application\ Support/Autodesk/CLM/LGS/657H1_2016.0.0.F ]]; then
        mkdir -p /Library/Application\ Support/Autodesk/CLM/LGS/657H1_2016.0.0.F
    fi

    cat<<EOF>/Library/Application\ Support/Autodesk/CLM/LGS/657H1_2016.0.0.F/LGS.data
_NETWORK
EOF

    cat<<EOF>/Library/Application\ Support/Autodesk/CLM/LGS/657H1_2016.0.0.F/LICPATH.lic
SERVER your-server.net 000000000000
USE_SERVER
EOF

    cat<<EOF>/Library/Application\ Support/Autodesk/CLM/LGS/657H1_2016.0.0.F/nw.cfg
done
EOF

else
    echo "ERROR: Maya installer not found."
    exit 1
fi

rm -rf /tmp/Install\ Maya\ 2016.app

exit 0
