#
# Usage: From the "Docker Quickstart Terminal", execute:
#
#  docker build -t bcdevices/sd11-system-rpi3 .
#
# References:
# - https://docs.docker.com/reference/builder/
# - https://docs.docker.com/articles/dockerfile_best-practices/
#
# --
#
# Confidential!!!
# Source code property of Blue Clover Design LLC.
#
# Demonstration, distribution, replication, or other use of the
# source codes is NOT permitted without prior written consent
# from Blue Clover Design.
#

FROM erlang:21.2
MAINTAINER Blue Clover Devices DevTeam

# Setup environment
ENV DEBIAN_FRONTEND noninteractive
ENV ELIXIR_VERSION=1.8.1-otp-21
ENV PATH="/usr/local/elixir/bin:${PATH}"

#Setup locale
RUN apt-get update && DEBIAN_FRONTEND=noninteractive apt-get install -y locales

RUN sed -i -e 's/# en_US.UTF-8 UTF-8/en_US.UTF-8 UTF-8/' /etc/locale.gen && \
    dpkg-reconfigure --frontend=noninteractive locales && \
    update-locale LANG=en_US.UTF-8

ENV LANG en_US.UTF-8
ENV LANGUAGE en_US:en
ENV LC_ALL en_US.UTF-8

ENV LANG=C.UTF-8

# The container has no package lists, so need to update first
RUN set -xe \
  && apt-get update \
  && apt-get -y install \
	git \
	curl \
	build-essential \
	gperf \
	bison \
	flex \
	texinfo \
	wget \
	gawk \
	libtool \
	automake \
	libncurses5-dev \
	help2man \
	ca-certificates \
	unzip \
  cpio \
  python \
  bc \
  rsync \
	&& rm -rf /var/lib/apt/lists/*


#Install Elixir
RUN wget https://repo.hex.pm/builds/elixir/v$ELIXIR_VERSION.zip && \
      unzip -d /usr/local/elixir v$ELIXIR_VERSION.zip

#Create Work Directory
RUN mkdir -p /nerves-system

#Set Working Directory
WORKDIR /nerves-system

# COPY
COPY . /nerves-system

RUN mkdir -p /root/local
RUN mkdir -p /root/empty

