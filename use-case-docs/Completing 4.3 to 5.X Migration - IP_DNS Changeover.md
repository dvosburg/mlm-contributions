Changing the new MLM server to use the original IP/FQDN is the last step in migration.  It is best if you can re-use the IP address of the original server, and these instructions detail the steps to complete it

1. Migrate the oldserver (4.3) to the new one, where the new one has a temporary IP/FQDN, following the steps in the documentation.  
2. Validate all the services start on the new 5.X one
 ```
mgradm status
```
  and test going to the 5.X webUI on the temporary IP. 
  
3. Shut down the 5.X server
```
mgradm stop && shutdown -h now
```  
4. Change the oldserver (4.3) FQDN and IP address to something different \- for emergency access to anything missing.  You can do the IP change with
```
yast lan
```
   Edit '/etc/hosts' and keep a line there for the original IP/FQDN so if you need to start the now disabled services again they will work. Reboot the oldserver (4.3) so it has the new IP in place.
```
shutdown -r now
```
    
6. Boot up the 5.X server.  Change the 5.X server IP and hostname to the original FQDN and IP.  IP address change if using NetworkManager can be done with nmcli.  Here is an example:
```
nmcli connection modify "Wired connection 1" \
  ipv4.method manual \
  ipv4.addresses 172.17.20.40/24 \
  ipv4.gateway 172.17.20.1 \
  ipv4.dns 172.17.20.35,8.8.8.8
```
Hostname change should be done two ways on the container host:
```
hostnamectl set-hostname <<original-FQDN>>
```
and by adding a line to '/etc/hosts' for IP, FQDN, and short name.  

6. Restart the 5.X server
```
mgradm stop && shutdown -r now  
```
7. Validate that client systems now are connecting to the new server \- test with some action scheduled from the 5.X server.
