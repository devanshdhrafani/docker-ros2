FROM ubuntu:20.04

MAINTAINER f20171569@hyderabad.bits-pilani.ac.in

#ROS2 Installation Starts
# setup timezone
RUN echo 'Etc/UTC' > /etc/timezone && \
    ln -s /usr/share/zoneinfo/Etc/UTC /etc/localtime && \
    apt-get update && apt-get install -q -y tzdata && rm -rf /var/lib/apt/lists/*

#locale
ENV LANG C.UTF-8
ENV LC_ALL C.UTF-8

#Setup Sources
RUN apt update && apt install -y curl gnupg2 lsb-release
RUN curl -sSL https://raw.githubusercontent.com/ros/rosdistro/master/ros.key  -o /usr/share/keyrings/ros-archive-keyring.gpg

RUN echo "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/ros-archive-keyring.gpg] http://packages.ros.org/ros2/ubuntu $(lsb_release -cs) main" | tee /etc/apt/sources.list.d/ros2.list > /dev/null

#Install ROS2 packages
RUN apt update
RUN DEBIAN_FRONTEND=noninteractive apt install -y ros-foxy-desktop

#argcomplete(optional)
RUN apt install -y python3-argcomplete

#End of ROS2 Installation

#Make ROS2 Workspace, build tutorials
WORKDIR /root/dev_ws/src
RUN git clone https://github.com/ros/ros_tutorials.git -b foxy-devel
WORKDIR /root/dev_ws
RUN apt-get install python3-rosdep -y
RUN rosdep init
RUN rosdep update
RUN rosdep install -i --from-path src --rosdistro foxy -y
RUN apt install python3-colcon-common-extensions -y


#RUN echo "source /opt/ros/foxy/setup.bash" >> /etc/.bashrc
#RUN /bin/bash -c "source /opt/ros/foxy/setup.bash"
#RUN /bin/bash -c "colcon build"

#entrypoint for ROS2
COPY ros2_entrypoint.sh /root/.
ENTRYPOINT ["/root/ros2_entrypoint.sh"]
CMD ["bash"]
