# LivingRoomStream
Turn on living room TV to watch local OBS stream.

Requires local NGINX server with RTMP module. Reference: https://obsproject.com/forum/resources/how-to-set-up-your-own-private-rtmp-server-using-nginx.50/

When the streaming PC starts the stream to the RTMP server, the script looping on the pi connected to the TV via HDMI will launch VLC and connect to the RTMP stream. A signal is sent to the TV's CEC controller to turn it on. When the stream is over, the script will kill VLC and turn the TV off.
