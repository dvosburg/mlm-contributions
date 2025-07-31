## Migrating from Micro to SLES for MLM 5.0 Container Host

On SLE Micro SMLM 5.0 (old) Host \- ensure it is running the latest (as root) with:  
```
transactional-update
```  
Then reboot the host.    
Update MLM containers to the latest:  
```
mgradm upgrade
```

Stop MLM services on SLE-Micro:  
```
mgradm stop
```

On new Host (SLES15SP6) register to SCC, add the Containers Module and SUSE Manager Server 5.0 Extension, then fully update. Run these commands as root:

```
export OLD_HOST="old.host.fqdn"
```

```
zypper install podman netavark mgradm mgradm-bash-completion mgrctl mgrctl-bash-completion suse-manager-5.0-x86_64-server-image uyuni-storage-setup-server
```

```
mkdir -p /var/lib/containers/storage/volumes
```

Ensure persistent storage is mapped and mounted, for example:  
```
mgr-storage-server /dev/sdb
```
Copy the database and files from the old server:
```
rsync -avz $OLD_HOST:/etc/containers/ /etc/containers/
```
```
rsync -avz $OLD_HOST:/var/lib/containers/storage/volumes/ /var/lib/containers/storage/volumes/
```
```
rsync -avz $OLD_HOST:/etc/systemd/system/uyuni-* /etc/systemd/system/
``` 
```
rsync -avz $OLD_HOST:/etc/ssh/ssh_host_* /etc/ssh/
```

Uninstall with mgradm - keeping the data volumes, deleting the copied installation bits before proper installation  
```
mgradm uninstall --force
```
You may get one or more of the following (cosmetic) warnings: 

```WRN failed to get uyuni-hub-xmlrpc systemd service definition error="exit status 1"```
```WRN /etc/systemd/system/uyuni-server.service.d folder contains file created by the user. Please remove them when uninstallation is completed.```
```WRN Data have been kept, use podman volume commands to clear the volumes```

Shutdown the SLE-Micro Host, and keep it as an emergency fallback.

Return to the new (SLES15SP6) Host:  
 * Change IP of new Host to the original (SLE Micro) IP
 * Change Hostname of new host to the original (SLE Micro) Hostname

Install MLM properly on the new host, supplying the original SSL password and admin password  
```
mgradm install podman
```

You may get one or more of the following (cosmetic) warnings:  
```WRN Server appears to be already configured. Installation will continue, but installation options may be ignored.```  
```WRN Administration user already exists, but organization Organization could not be found```


Check that everything is running:   
```
mgradm status
```

Credit to [Bo Jin](mailto:bjin@suse.com) for the bulk of these steps.
