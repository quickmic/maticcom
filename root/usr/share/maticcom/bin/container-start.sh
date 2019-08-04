#!/bin/bash
if [ -d "/run/maticcom-id/" ]
then
	for files in /run/maticcom-id/*
	do
		id="${files##*/}"
		/usr/share/maticcom/bin/container-permission-set.sh $id 1
	done
fi

if [ -e /sys/class/raw-uart/raw-uart/reset_radio_module ]
then
	echo 1 > /sys/class/raw-uart/raw-uart/reset_radio_module
fi

exit 0
