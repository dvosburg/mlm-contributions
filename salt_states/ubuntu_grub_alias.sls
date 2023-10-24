ubuntu_grub_mkconfig_alias:
  file.symlink:
    - name: /usr/sbin/grub2-mkconfig
    - target: /usr/sbin/grub-mkconfig
    - onlyif:
      - test -f /usr/sbin/grub-mkconfig
      - test ! -L  /usr/sbin/grub2-mkconfig

ubuntu_grub_directory_alias:
  file.symlink:
    - name: /boot/grub2
    - target: /boot/grub
    - onlyif:
      - test -f /boot/grub
      - test ! -L /boot/grub2
