#!/usr/bin/bash
ansible pi -b -K -m shell -a "sed -i '$ s/$/ cgroup_enable=cpuset cgroup_enable=memory cgroup_memory=1 swapaccount=1/' /boot/firmware/cmdline.txt"

