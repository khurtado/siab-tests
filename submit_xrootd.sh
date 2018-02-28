#!/bin/bash

printf "Start time: "; /bin/date
printf "Job is running on node: "; /bin/hostname
printf "Job running as user: "; /usr/bin/id
printf "Job is running in directory: "; /bin/pwd

echo "------Worker node environment-------"
env
echo -e "------Worker node environment-------\n\n"

echo "----------Testing XrootD Cache------------"
if [ "x${CMS_XROOTD_CACHE}" == "x" ]; then
    echo "[Error]: Could not find XrootD cache location"
    exit 101
else
    echo "Found Xrootd Cache. Location is: $CMS_XROOTD_CACHE"
fi

echo "===========Directory before executing xrdcp============"
ls -lsh
echo xrdcp root://${CMS_XROOTD_CACHE}//store/mc/SAM/GenericTTbar/GEN-SIM-RECO/CMSSW_5_3_1_START53_V5-v1/0013/CE4D66EB-5AAE-E111-96D6-003048D37524.root -f test.root
xrdcp -d 2 root://${CMS_XROOTD_CACHE}//store/mc/SAM/GenericTTbar/GEN-SIM-RECO/CMSSW_5_3_1_START53_V5-v1/0013/CE4D66EB-5AAE-E111-96D6-003048D37524.root -f test.root 2>&1
result=$?
if [ $result -eq 0 ] ; then
    echo "Successfully used XRootD Cache."
else
    echo "xrdcp failed with error code: $result"
    exit $result
fi
echo "===========Directory after executing xrdcp============"
ls -lsh

# Delete root file, so we don't waste bandwidth transferring file back to the submit host
rm test.root

echo "Test completed!"
