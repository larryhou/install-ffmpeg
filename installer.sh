#!/bin/bash

brew list | grep ffmpeg
if [ ! $? -eq 0 ]
then
	brew install ffmpeg
fi

brew info ffmpeg | grep -i '\(Recommended\|Optional\|Build\):' \
	| awk -F: '{print $2}' | sed $'s/,/\\\n/g' \
	| sort -k 2 | grep '✘' | awk '{print $1}' | xargs

options=$(brew info ffmpeg | grep '^\--with-' | xargs)
echo ${options}

brew reinstall ffmpeg ${options}
