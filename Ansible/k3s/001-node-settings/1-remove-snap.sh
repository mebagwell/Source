#!/usr/bin/bash
ansible pi -b -K -m shell -a "snap remove lxd && snap remove core18 && snap remove snapd && apt automremove -y"
