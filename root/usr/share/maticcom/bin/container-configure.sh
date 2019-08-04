#!/bin/bash
read -r -p "Please enter the Container ID of you CCU: " containerid

if [ -f "/etc/pve/lxc/"$containerid".conf" ]
then
	timestamp=`date "+%Y%m%d-%H%M%S"`

	if [ -f "/usr/share/maticcom/id/container" ]
	then
		if [ -s "/usr/share/maticcom/id/container" ]
		then
			containeridprevious=`cat /usr/share/maticcom/id/container`

			if [ -f "/etc/pve/lxc/"$containeridprevious".conf" ]
			then
				cp '/etc/pve/lxc/'$containeridprevious'.conf' '/usr/share/maticcom/backups/'$timestamp'_'$containeridprevious'.conf'
				sed '/lxc.hook.pre-mount: \/usr\/share\/maticcom\/bin\/container-start.sh/d' '/usr/share/maticcom/backups/'$timestamp'_'$containeridprevious'.conf' > '/etc/pve/lxc/'$containeridprevious'.conf'
			fi
		fi
	fi

	cp '/etc/pve/lxc/'$containerid'.conf' '/usr/share/maticcom/backups/'$timestamp'_'$containerid'.conf'

	data=`cat /etc/pve/lxc/300.conf`

        if ! [[ $data =~ "lxc.hook.pre-mount: /usr/share/maticcom/bin/container-start.sh" ]]
        then
		echo "lxc.hook.pre-mount: /usr/share/maticcom/bin/container-start.sh" >> "/etc/pve/lxc/"$containerid".conf"
	fi

	echo $containerid > /usr/share/maticcom/id/container
fi

#read -r -p "Are you using RPI-RF-MOD? [y/n]: " RF-MOD-USB

exit 0
