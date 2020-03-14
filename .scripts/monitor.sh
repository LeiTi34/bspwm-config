#!/bin/sh
tool=(/home/user/.scripts/dmenu_wrapper.sh)
#tool=dmenu

devices=$(xrandr | grep ' connected' | awk '{print $1}')

settings="orientation
resolution
off"

orientations="left
right
mirror
top
bottom"

#resolutions="auto"

selectedDevice=$(echo "$devices" | "${tool[@]}")
if [ -z "$selectedDevice" ]
then
 	exit 1
fi

selectedSetting=$(echo "$settings" | "${tool[@]}")
if [ -z "$selectedSetting" ]
then
 	exit 1
fi       

case "$selectedSetting" in
	orientation)
		selectedOrientation=$(echo "$orientations" | "${tool[@]}")
		if [ -z "$selectedOrientation" ]
		then
		 	exit 1
		fi  
		
		selectedSecondDevice=$(echo "$devices" | grep -v "$selectedDevice" | "${tool[@]}")
		if [ -z "$selectedSecondDevice" ]
		then
		 	exit 1
		fi
		
		case "$selectedOrientation" in
			left)
				xrandr --output "$selectedDevice" --left-of "$selectedSecondDevice"
				;;
			right)
				xrandr --output "$selectedDevice" --right-of "$selectedSecondDevice"
				;;
			mirror)
				xrandr --output "$selectedDevice" --same-as "$selectedSecondDevice"
				;;
			top)
				xrandr --output "$selectedDevice" --top-of "$selectedSecondDevice"
				;;
			bottom)
				xrandr --output "$selectedDevice" --bottom-of "$selectedSecondDevice"
				;;
		esac
		;;
	
	resolution)
		resolutions="$(xrandr | awk -v dev="$selectedDevice" '$0~dev,/connected/&&++k==2' | grep -v connected | awk '{print $1}')"
		resolutions="auto
${resolutions}"
		selectedResolution=$(echo "$resolutions" | "${tool[@]}")
		if [ "$selectedResolution" == "auto" ]
		then
			xrandr --output "$selectedDevice" --auto
		else
			xrandr --output "$selectedDevice" --mode "$selectedResolution"	
		fi
		;;
	off)
		xrandr --output "$selectedDevice" --off
		;;
esac
