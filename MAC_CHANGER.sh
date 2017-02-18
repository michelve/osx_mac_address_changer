#!/bin/bash -e

# generate random number:
mac=$(openssl rand -hex 6 | sed 's/\(..\)/\1:/g; s/.$//')
# echo ${mac}

ASK='Select the device you wish to change the MAC address: '
options=("EN0" "EN1" "Backup Original MAC" "Quit")
select opt in "${options[@]}"
do
    case $opt in
        "EN0")
            # Ethernet
            sudo ifconfig en0 ether $mac
            echo "EN0 MAC address changed to: ${mac}"
            networksetup -setairportpower airport off
            networksetup -setairportpower en0 off
            networksetup -setairportpower airport on
            networksetup -setairportpower en0 on
            ;;
        "EN1")
            # wifi
            sudo ifconfig en1 ether $mac
            echo "EN1 MAC address changed to: ${mac}"
            networksetup -setairportpower airport off
            networksetup -setairportpower en1 off
            networksetup -setairportpower airport on
            networksetup -setairportpower en1 on
            ;;
        "Backup Original MAC")
            # backup original MAC address
            ifconfig en0 | grep ether >> en.txt
            ifconfig en1 | grep ether >> en1.txt
            echo "you have saved your original mac address"
            ;;
        "Quit")
            break
            ;;
        *) echo invalid option;;
    esac
done


