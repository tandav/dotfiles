#!/bin/bash

# nvidia toolkit
export CUDA_HOME=/usr/local/cuda
export PATH=${CUDA_HOME}/bin:${PATH}
export LD_LIBRARY_PATH=${CUDA_HOME}/lib64:$LD_LIBRARY_PATH
# , or, add /usr/local/cuda-11.7/lib64 to /etc/ld.so.conf and run ldconfig as root

# ffmpeg compile from source in the ~/Downloads/ffmpeg
FFMPEG_HOME=/home/tandav/Downloads/ffmpeg
export LD_LIBRARY_PATH=$FFMPEG_HOME/libavdevice:$FFMPEG_HOME/libavfilter:$FFMPEG_HOME/libavformat:$FFMPEG_HOME/libavcodec:$FFMPEG_HOME/libswresample:$FFMPEG_HOME/libswscale:$FFMPEG_HOME/libavutil:$LD_LIBRARY_PATH
