#!/usr/bin/bash
# Basic shell script to backup required LXD parts ##
## Backup and restore LXD config ##
## Today's date ##
NOW=$(date +'%m-%d-%Y')
 
## Dump LXD server config ##
echo "Dumping LXD server config"
lxd init --dump > "/backups/lxd/lxd.config.${NOW}"
 
## Dump all instances list ##
echo "Dump all instances list"
lxc list > "/backups/lxd/lxd.instances.list.${NOW}"
 
## Make sure we know LXD version too ##
echo "Getting LXD version"
snap list lxd > "/backups/lxd/lxd-version.${NOW}"
 
#Shutdown running instances
lxc list --format=json | jq -r '.[] | select(.state.status == "Running") | .name' > t.txt
for word in $(cat t.txt)
  do
    echo "Stopping instance $word"
    lxc stop $word
  done

sleep 120
echo "Waiting for instances to shutdown"

## Backup all Instances
for i in $(lxc list -c n --format csv)
  do
    echo "Making backup of ${i} ..."
    lxc export "${i}" "/backups/lxd/${i}-backup-$(date +'%m-%d-%Y').tar.xz" --optimized-storage
  done

# Restart instances
for word in $(cat t.txt)
  do
    echo "Starting instance $word"
    lxc start $word
  done
rm t.txt
