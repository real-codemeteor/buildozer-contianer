#!/bin/sh

SCRIPT_DIR=$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )

if [ ! -x "$(command -v docker)" ]; then
    echo "Docker is not installed!"
    exit 1
fi
 
if [ -z "$(docker images -q realcodemeteor/buildozer-container:v0.1.0 2> /dev/null)" ]; then
    echo "Docker image not found!"
    echo "Starting build"
    docker pull realcodemeteor/buildozer-container:v0.1.0
fi

if [ ! -d /tmp/.buildozer ]; then
    echo "Creating /tmp/.buildozer"
    mkdir /tmp/.buildozer
fi

docker run --interactive --privileged -v /dev/bus/usb:/dev/bus/usb --tty --rm --volume ${PWD}:/home/ubuntu/src --volume ${HOME}/.android:/home/ubuntu/.android --volume /tmp/.buildozer:/home/ubuntu/.buildozer realcodemeteor/buildozer-container:v0.1.0 buildozer $@

