#!/usr/bin/bash
ansible pi -b -K -m apt -a "upgrade=yes update_cache=yes"
