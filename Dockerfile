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

CMD ["bash"]

