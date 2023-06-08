docker build --build-arg username=tript -t triptsharma/base:v0 .

docker run --gpus all -it --name=pose_estimation_env  --privileged --env="DISPLAY" \
            --net=host \
            -v /mnt/d/ws/:/ws \
            -v /tmp/.X11-unix/:/tmp/.X11-unix/ \
            -v /mnt/c/Users/z004tbjv/.cache/:/home/user/.cache/ \
            triptsharma/base:v0