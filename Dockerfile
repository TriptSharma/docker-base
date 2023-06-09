# # syntax=docker/dockerfile:1

# Base image
FROM nvidia/cuda:11.7.0-cudnn8-devel-ubuntu20.04 as cuda_base

# Install necessary packages for ROS
RUN apt-get update && apt-get install -y \
    curl \
    gnupg2 \
    lsb-release

# ROS base image
# FROM ros:humble-ros-core as ros_base
FROM ros:noetic-ros-core as ros_base

RUN rosversion -d

# Copy CUDA installation from cuda_base
COPY --from=cuda_base / /

# Source bashrc like in ROS
RUN echo "source /opt/ros/noetic/setup.bash" >> /root/.bashrc

# update and install essentials
# RUN apt update -y

RUN apt install -y \
            software-properties-common \
            wget \
            zsh \
            git \
            gcc \
            sudo \
            python3-pip

RUN apt-get update && apt-get install ffmpeg libsm6 libxext6  -y
RUN pip install opencv-python pycocotools matplotlib onnxruntime onnx
RUN pip install torch torchvision torchaudio --index-url https://download.pytorch.org/whl/cu118

RUN export alias python='python3'

#create a new user
ARG username
ARG password=1020

RUN useradd -m -s /bin/bash $username -d /home/$username/ -G sudo  && \
    echo "$username:$password" | chpasswd

# Switch to the new user
USER $username

# Set the root folder as the entry point
WORKDIR /

CMD ["bash"]
LABEL author="triptsharma"