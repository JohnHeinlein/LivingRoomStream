#/bin/bash

# CEC commands
#echo 'on 0.0.0.0' | cec-client -s -d 1
#echo 'standby 0.0.0.0' | cec-client -s -d 1


while true
do
	timeout 5s ffprobe -v quiet rtmp://192.168.1.24/live/test

	#ffprobe returns 0 if stream exists
	#timeout will return 124 if stream does not exist, since ffprobe will hang
	if [ $? -eq 0 ]; then
		echo "Stream is on!"
		
		# Check to see if VLC is already running.
		if kill -0 "$myPid" 2>/dev/null ; then # Suppress output of kill -0 so stdout isn't flooded with failed checks.
			echo "  VLC is already running"
		else
			# If VLC isn't already running, launch it in fullscreen and push to the background
			#   so we can continue to check for the stream to end.
			vlc  --fullscreen rtmp://192.168.1.24/live/test &
			echo 'on 0.0.0.0' | cec-client -s -d 1 # Turn the TV on.
			myPid=$! # Log PID of VLC's background process so we can kill it when the stream ends.
		fi
	else
		echo "Stream is off!"
		if kill -0 "$myPid" 2>/dev/null; then
			echo "  VLC is running. Killing."
			kill -9 "$myPid"
			echo 'standby 0.0.0.0' | cec-client -s -d 1S
		fi
	fi
done
