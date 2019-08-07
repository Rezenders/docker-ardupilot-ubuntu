# docker-ardupilot-ubuntu
Dockerfile for running ardupilot in ubuntu bionic

## Graphical Interface

Before using GUI with docker you must configure your display manager.

You can take a look at ros wiki : http://wiki.ros.org/docker/Tutorials/GUI

##NVIDIA

http://wiki.ros.org/docker/Tutorials/Hardware%20Acceleration#nvidia-docker2
https://github.com/NVIDIA/nvidia-docker

```
ENV NVIDIA_VISIBLE_DEVICES \
   ${NVIDIA_VISIBLE_DEVICES:-all}
ENV NVIDIA_DRIVER_CAPABILITIES \
   ${NVIDIA_DRIVER_CAPABILITIES:+$NVIDIA_DRIVER_CAPABILITIES,}graphics
```

```
$ docker run -it --rm --env="DISPLAY" --env="QT_X11_NO_MITSHM=1" --volume="/tmp/.X11-unix:/tmp/.X11-unix:rw" --runtime=nvidia --name gazebo --net ros_net gazebo-ardupilot
```

Ardupilot container:
```bash
$ docker run -it --rm --env="DISPLAY" --env="QT_X11_NO_MITSHM=1" --volume="/tmp/.X11-unix:/tmp/.X11-unix:rw" --name ardupilot --net ros_net rezenders/ardupilot-ubuntu sim_vehicle.py -v ArduCopter --console --map -L UFSC --out mavros:14551
```
