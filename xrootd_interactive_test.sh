#!/bin/bash

SIAB_XROOTD_CACHE="siab-1.colorado.edu:4095"
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

echo -e "\n\n--------Starting XRootD test--------"
echo "Command to run:"
#echo xrdfs ${SIAB_XROOTD_CACHE} stat -q IsReadable /store/mc/SAM/GenericTTbar/GEN-SIM-RECO/CMSSW_5_3_1_START53_V5-v1/0013/CE4D66EB-5AAE-E111-96D6-003048D37524.root
#XRD_LOGLEVEL="Debug" xrdfs ${SIAB_XROOTD_CACHE} stat -q IsReadable /store/mc/SAM/GenericTTbar/GEN-SIM-RECO/CMSSW_5_3_1_START53_V5-v1/0013/CE4D66EB-5AAE-E111-96D6-003048D37524.root 2>&1
echo -e "xrdcp -d 2 root://${SIAB_XROOTD_CACHE}//store/mc/SAM/GenericTTbar/GEN-SIM-RECO/CMSSW_5_3_1_START53_V5-v1/0013/CE4D66EB-5AAE-E111-96D6-003048D37524.root -f test.root \n"
xrdcp -d 2 root://${SIAB_XROOTD_CACHE}//store/mc/SAM/GenericTTbar/GEN-SIM-RECO/CMSSW_5_3_1_START53_V5-v1/0013/CE4D66EB-5AAE-E111-96D6-003048D37524.root -f test.root 2>&1
result=$?
echo -e "--------Finishing XRootD test--------\n"

if [ $result -eq 0 ] ; then
    echo "Successfully used XRootD Cache."
else
    echo "xrdcp failed with error code: $result"
    exit $result
fi

# Delete root file, so we don't waste bandwidth transferring file back to the submit host
if [ -f test.root ]; then rm test.root; fi

echo "Test completed!"
