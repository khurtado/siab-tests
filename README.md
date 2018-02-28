# SiaB tests
 Different tests for SiaB targets

## Interactive tests
- xrootd\_interactive\_test.sh 
Simple test to stat an XRootD file from a given cache.
Just change SIAB\_XROOTD\_CACHE to the actual SiaB cache location.
Note: The interactive test depends on the SiaB firewall configuration. Please, make sure you can actually connect to the cache server (telnet, nmap, etc) from the machine you are testing from first.

## Condor tests
- submit\_basic.jdl
Test condor submission. Submits to UC and Comet by default.
The following classads control where the submission goes:

|Special classads|
|site\_local| Submit to local resources in this scheduler|
|local| Submit to the brick
|uc| Enable submission to UC targets
|sdsc| Enable submission to SDSC/Comet

E.g: To submit to UC Sites only, put the following in the submit file:
```
+site_local = False
+local = False
+uc = True
```
- submit\_xrootd.jdl
Test xrdcp using the CMS\_XROOTD\_CACHE environment variable, which is translated 
to the SiaB XrootD Cache once the pilots starts running.
