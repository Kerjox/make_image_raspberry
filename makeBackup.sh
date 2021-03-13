#!/bin/bash

function logWarn() {
	START='\033[01;33m'
	END='\033[00;00m'
	MESSAGE=${@:-""}
	echo -e "${START}${MESSAGE}${END}"
}

function logInfo() {
	START='\033[01;32m'
	END='\033[00;00m'
	MESSAGE=${@:-""}
	echo -e "${START}${MESSAGE}${END}"
}

function logError() {
	START='\033[01;31m'
	END='\033[00;00m'
	MESSAGE=${@:-""}
	echo -e "${START}${MESSAGE}${END}"
}

function log() {
        MESSAGE=${@:-""}
        echo -e "${MESSAGE}"
}

if ! [ $USER == 'root' ]; then 
    logError "ERROR: Please execute as root"
    exit 1 
fi

dt=`date +%d%m%y`

sudo dd bs=4M if=/dev/mmcblk0 |pv| dd of=/media/usb0/homeAssistant-$dt.img
sudo ./pishrink.sh /media/usb0/homeAssistant-$dt.img

logInfo "All tasks finish successfully"