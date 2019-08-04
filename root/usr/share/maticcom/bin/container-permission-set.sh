#!/bin/bash
if [ -f "/usr/share/maticcom/id/container" ]
then
	if [ -s "/usr/share/maticcom/id/container" ]
	then
		containerid=`cat /usr/share/maticcom/id/container`

		if [ "$1" ] && [ "$2" ]
		then
			if [ -d "/sys/fs/cgroup/devices/lxc/"$containerid"/" ]
			then
				path=/sys/fs/cgroup/devices/lxc/$containerid
				count=1

				while [ -d "/sys/fs/cgroup/devices/lxc/"$containerid-$count"/" ]
				do
					path=/sys/fs/cgroup/devices/lxc/$containerid-$count
					((count++))
				done

				if [ $2 == "1" ]
				then
					echo "c "$1" rwm" > $path/devices.allow
					echo "c "$1" rwm" > $path/ns/devices.allow
					echo "c "$1" rwm" > $path/ns/system.slice/devices.allow
					echo "c "$1" rwm" > $path/ns/user.slice/devices.allow
				elif [ $2 == "0" ]
				then
					echo "c "$1" rwm" > $path/devices.deny
					echo "c "$1" rwm" > $path/ns/devices.deny
					echo "c "$1" rwm" > $path/ns/system.slice/devices.deny
					echo "c "$1" rwm" > $path/ns/user.slice/devices.deny
				fi
			fi
		fi
	fi
fi

exit 0
