#!/bin/bash

SIAB_XROOTD_REDIRECTOR="siab-1.colorado.edu:1095"
#SIAB_XROOTD_CACHE="siab-1.hep.uprm.edu:4095"

# First, check for proxy certificates
if [ "x${X509_USER_PROXY}" == "x" ] && [ ! -f "/tmp/x509up_u$(id -u)" ]; then
    echo "[Error] Proxy certificate could not be found."
    echo "Please, execute:"
    echo "voms-proxy-init -voms cms -valid 192:00"
    exit 201
else
    timeleft=$(voms-proxy-info -timeleft)
    if [ $timeleft -lt 60 ]; then
        echo "Your proxy has or is about to expire in the next minute. Please renew"
        exit 202
    fi
fi

#export X509_USER_PROXY="/tmp/x509up_u$(id -u)"

echo -e "\n\n--------Starting XRootD test to read a file--------"
echo "Command to run:"
echo -e "xrdcp -d 2 root://${SIAB_XROOTD_REDIRECTOR}//uclhc/colorado/user/khurtado/test.txt -f test.txt \n"
xrdcp -d 2 root://${SIAB_XROOTD_REDIRECTOR}//uclhc/colorado/user/khurtado/test.txt -f test.txt
result=$?
echo -e "--------Finishing XRootD test--------\n"

if [ $result -eq 0 ] ; then
    echo "Successfully used the XRootD redirector + data server."
else
    echo "xrdcp failed with error code: $result"
    exit $result
fi

# Delete root file, so we don't waste bandwidth transferring file back to the submit host
if [ -f test.txt ]; then rm test.txt; fi

echo "Test completed!"
