# # syntax=docker/dockerfile:1


# Base image
FROM nvidia/cuda:11.7.0-cudnn8-devel-ubuntu22.04 as cuda_base

# Install necessary packages for ROS
RUN apt-get update && apt-get install -y \
    curl \
    gnupg2 \
    lsb-release

# ROS base image
FROM ros:humble-ros-core

# Copy CUDA installation from cuda_base
COPY --from=cuda_base / /

# Source bashrc like in ROS
RUN echo "source /opt/ros/humble/setup.bash" >> /root/.bashrc

# update and install essentials
RUN apt update -y

RUN apt install -y \
            software-properties-common \
            wget \
            zsh \
            git \
            gcc

#create a new user
RUN useradd -m -s /bin/bash 

# Switch to the new user
USER tript

# Set the root folder as the entry point
WORKDIR /

CMD ["bash"]
LABEL author="triptsharma"