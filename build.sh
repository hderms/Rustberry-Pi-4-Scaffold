#!/usr/bin/env bash
usage(){
	echo "Usage: $0 RASPBERRY_PI_IP"
	exit 1
}

[[ $# -eq 0 ]] && usage

PI_IP=$1 
TARGET=armv7-unknown-linux-musleabihf
PROJECT_NAME="rbpi-scaffold"

# build binary
cargo build --target $TARGET

# upload binary
sshpass -p 'raspberry' scp -r ./target/$TARGET/debug/$PROJECT_NAME pi@$PI_IP:/home/pi

# execute binary
sshpass -p 'raspberry' ssh pi@$PI_IP "./$PROJECT_NAME"
