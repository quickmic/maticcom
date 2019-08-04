#!/bin/bash
if [ "$2" ]
then

	if ! [ -d "/run/maticcom-id/" ]
	then
		mkdir /run/maticcom-id/
	fi

	touch /run/maticcom-id/$2
	/usr/share/maticcom/bin/container-permission-set.sh $2 1

	if [ $1 == "raw-uart" ]
	then
		modprobe eq3_char_loop
	fi

        if [ $1 == "hmip_rfusb" ]
        then
                modprobe cp210x
                echo "1b1f c020" > /sys/bus/usb-serial/drivers/cp210x/new_id
        fi
fi

exit 0
