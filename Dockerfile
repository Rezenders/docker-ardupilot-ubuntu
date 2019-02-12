FROM ubuntu:bionic

ENV DEBIAN_FRONTEND noninteractive

RUN apt-get update && apt-get install -y \
	git \
	vim \
	python-opencv \
	python-wxgtk3.0 \
	python-pip \
	python-serial \
	python-scipy \
	python-lxml \
	python-matplotlib \
	python-pexpect \
	python-matplotlib \
	&& rm -rf /var/lib/apt/lists/

# Install ardupilot
RUN git clone https://github.com/ArduPilot/ardupilot.git
WORKDIR /ardupilot
RUN git submodule update --init --recursive; 
WORKDIR /

# Complete ardupilot install
RUN pip install pymavlink \
	MAVProxy

ENV PATH=$PATH:/ardupilot/Tools/autotest
ENV PATH=/usr/lib/ccache:$PATH

# Add location
RUN echo "UFSC=-27.604033,-48.518363,21,0" >> /ardupilot/Tools/autotest/locations.txt

# Gazebo
RUN apt-get update && apt-get install -y \
        wget \
        && rm -rf /var/lib/apt/lists/

RUN sh -c 'echo "deb http://packages.osrfoundation.org/gazebo/ubuntu bionic main" > /etc/apt/sources.list.d/gazebo-latest.list'
RUN wget http://packages.osrfoundation.org/gazebo.key -O - | apt-key add -
RUN apt-get update && apt-get install -y \
        gazebo9 \
	libgazebo9-dev \
        && rm -rf /var/lib/apt/lists/

RUN ["/bin/bash","-c","git clone https://github.com/khancyr/ardupilot_gazebo && \
                       cd ardupilot_gazebo && \
                       mkdir build && \
                       cd build && \
                       cmake .. && \
                       make -j4 && \
                       make install"]

CMD ["bash"]

