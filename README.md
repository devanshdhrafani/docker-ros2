Dockerfile to build ROS2 Foxy on top of Ubuntu:20.04. 

1. Clone the repo, build the image:
```bash
    git clone https://github.com/devanshdhrafani/docker-ros2.git
    cd docker-ros2
    docker build .
```
2. Tag the image:
```bash
    docker tag <image-id> <image-tag>
```
3. Modify `run_ros2.sh `, replace `dd_ros2` with your <image-tag>

4. Make a container:
```bash
    ./run_ros2.sh
```

