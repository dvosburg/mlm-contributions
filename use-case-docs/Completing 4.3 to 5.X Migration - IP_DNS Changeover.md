Changing the new MLM server to use the original IP/FQDN is the last step in migration.  It is best if you can re-use the IP address of the original server, and these instructions detail the steps to complete it

1. Migrate the oldserver (4.3) to the new one, where the new one has a temporary IP/FQDN, following the steps in the documentation.  
2. Validate all the services start on the new one
 `mgradm status`
3.  and test going to the webUI on the temporary IP.  
5. Shut down the 5.X server
   `mgradm stop && shutdown \-h now`  
6. Change the oldserver FQDN and IP address to something different \- for emergency access to anything missing.  Keep a line in '/etc/hosts' for the original IP/FQDN so if you need to start the services again they will work.  Reboot the 4.3 server so it has the new IP in place.   
7. Boot up the 5.X server.  Change the 5.X server IP and hostname to the original FQDN and IP.  Hostname change should be done two ways on the container host:  hostnamectl set-hostname \<\<original-FQDN\>\> and by adding a line to '/etc/hosts' for IP, FQDN, and short name.  
8. Restart the 5.X server mgradm stop && shutdown \-r now  
9. Validate that client systems now are connecting to the new server \- test with some action scheduled from the new MLM.
