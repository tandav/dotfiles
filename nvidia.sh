
# nvidia toolkit
export CUDA_HOME=/usr/local/cuda
export PATH=${CUDA_HOME}/bin:${PATH}
export LD_LIBRARY_PATH=${CUDA_HOME}/lib64:$LD_LIBRARY_PATH
# , or, add /usr/local/cuda-11.7/lib64 to /etc/ld.so.conf and run ldconfig as root

# ffmpeg compile from source in the ~/Downloads/ffmpeg
export LD_LIBRARY_PATH=\
/home/tandav/Downloads/ffmpeg/libavdevice:\
/home/tandav/Downloads/ffmpeg/libavfilter:\
/home/tandav/Downloads/ffmpeg/libavformat:\
/home/tandav/Downloads/ffmpeg/libavcodec:\
/home/tandav/Downloads/ffmpeg/libswresample:\
/home/tandav/Downloads/ffmpeg/libswscale:\
/home/tandav/Downloads/ffmpeg/libavutil:\
$LD_LIBRARY_PATH
