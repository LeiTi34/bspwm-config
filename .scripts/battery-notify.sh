#!/bin/sh

export DISPLAY=:0
export XAUTHORITY=/home/user/.Xauthority
export DBUS_SESSION_BUS_ADDRESS=unix:path=/run/user/1000/bus

batInfo=$(acpi -b)
chargingState=$(echo "$batInfo" | grep Discharging)
batPer=$(echo "$batInfo" | cut -f 4 -d " " | sed 's/%//g' | sed 's/,//g')

if [[ ! -z $chargingState ]]
then
    lowCnt=0
    critCnt=0

    while IFS= read -r line
    do
        if [ "$line" -lt 15 ]
        then
            ((lowCnt++))
        fi
        
        if [ "$line" -lt 5 ]
        then
            ((critCnt++))
        
        fi
    done <<< "$batPer"

    if [ $lowCnt -ge 2 ]
    then
        if [[ -f "$notifyFile" ]]
        then
            id=" -r $(<notifyFile)" 
        else
            id=""
        fi

        if [ $critCnt -ge 2 ]
        then
            /usr/bin/dunstify "Critical  Battery" "Suspending..." -u critical -r 444444
            echo "Battery is Critical, Suspending..."
            #systemctl suspend
        else
            /usr/bin/dunstify "Low Battery" "$batInfo"  -u critical -r 444444
            echo "Battery is Low"bash append string to command
        fi
    fi
fi
