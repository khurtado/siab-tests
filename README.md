# SiaB tests
 Different tests for SiaB targets

## Interactive tests
### xrootd\_cmsproxy_interactive\_test.sh
Simple test to copy an XRootD file from a given cache.  
Just change [SIAB\_XROOTD\_CACHE](https://github.com/khurtado/siab-tests/blob/master/xrootd_interactive_test.sh#L3) to the actual SiaB cache location.

**Note**: This test depends on the SiaB firewall configuration. Please, make sure you can actually connect to the cache server (telnet, nmap, etc) from the machine you are testing from first.

### xrootd\_server\_interactive\_test.sh
Will test the XrootD redirector + data server service in the box.
Usage:

```
xrootd_server_interactive.test </path/to/file/to/read>
E.g: At Colorado:

xrootd_server_interactive.test /uclhc/colorado/user/khurtado/test.txt
```
**Note**: The file to read has to exists in the brick in `/data/uclhc/....` for the test to work.

## Condor tests
### submit\_basic.jdl
Test condor submission. Submits to UC and Comet by default.

The following classads control where the submission goes:

|Special classad|Description|
|----------------|-----|
|+site\_local| Run in the local resources of this batch system|
|+local| Run on the local SiaB, if condor startd is enabled in the brick|
|+uc| Run on all UC targets|
|+sdsc| Run at Comet|

*E.g*: To submit to UC Sites only, put the following in the submit file:
```
+site_local = False
+local = False
+uc = True
```
### submit\_xrootd.jdl
Test xrdcp using the CMS\_XROOTD\_CACHE environment variable, which is translated to the SiaB XrootD Cache once the pilots starts running. Use the special classads above to define where you want to run.
