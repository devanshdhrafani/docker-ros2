docker run -it \
    -p $1:8800 \
    --env="DISPLAY=$DISPLAY" \
    --env="QT_X11_NO_MITSHM=1" \
    --volume="/tmp/.X11-unix:/tmp/.X11-unix:rw" \
    --env="XAUTHORITY=$XAUTH" \
    --volume="$XAUTH:$XAUTH" \
    --runtime=nvidia \
    -v /home/ipro/.gazebo:/root/.gazebo \
    -v /home/ipro/ros2_ws/src:/root/dd_ws/src \
    devanshdhrafani/ros2:2.1  \
    bash
