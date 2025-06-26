# Procedure example for growing MLM 5.X persistent storage

1. Shutdown the container host

`mgradm stop && shutdown -h now`

2. Expand the size of the virtual disk with your hypervisor tools

3. Power on the container host

4. View available disk space

`df -Th | grep volumes`  
This will show you the partition you need to expand, and in this example it is ‘/dev/vdb1’

5. Stop the MLM services:

`mgradm stop`

6. Unmount your partition:

`umount /dev/vdb1`

7. Grow the partition, showing the before and after sizes:

`parted -s -a opt /dev/vdb "print free" "resizepart 1 100%" "print free"`

8. Mount your partition again:

`mount -a`

9. Grow the filesystem in your newly expanded partition to match:

`xfs_growfs /dev/vdb1`

10. View your free space again:

`df -Th | grep volumes`

11. Start up the MLM services:

`mgradm start`

