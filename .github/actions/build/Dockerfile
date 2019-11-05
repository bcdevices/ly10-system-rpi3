FROM erlang:22.1.5

LABEL "com.github.actions.name"="Build System"
LABEL "com.github.actions.description"="Build Nerves System"
LABEL "com.github.actions.icon"="package"
LABEL "com.github.actions.color"="blue"

LABEL "repositoty"="https://github.com/bcdevices/ly10-system-rpi3"
LABEL "homepage"="https://github.com/bcdevices/ly10-system-rpi3"
LABEL "maintainer"="Blue Clover Devices"

#Setup locale
RUN apt-get update && DEBIAN_FRONTEND=noninteractive apt-get install -y locales

RUN sed -i -e 's/# en_US.UTF-8 UTF-8/en_US.UTF-8 UTF-8/' /etc/locale.gen && \
    dpkg-reconfigure --frontend=noninteractive locales && \
    update-locale LANG=en_US.UTF-8

ENV LANG en_US.UTF-8
ENV LANGUAGE en_US:en
ENV LC_ALL en_US.UTF-8

ENV LANG=C.UTF-8
RUN set -xe \
  && apt-get update \
  && apt-get -y install \
  zip \
  xz-utils \
  cpio \
  python \
  bc \
  subversion \
  build-essential \
  bash \
  rsync \
  git \
  curl \
  automake \
  gzip \
  fakeroot \
  &&  update-ca-certificates

ENV ELIXIR_VERSION=1.9.2-otp-22

#Install Elixir
RUN wget https://repo.hex.pm/builds/elixir/v$ELIXIR_VERSION.zip && \
      unzip -d /usr/local/elixir v$ELIXIR_VERSION.zip

ENV PATH /usr/local/elixir/bin:$PATH

#Create Work Directory
RUN mkdir -p /nerves-system

#Set Working Directory
WORKDIR /nerves-system

# COPY
COPY . /nerves-system

ADD entrypoint.sh /entrypoint.sh

CMD ["/entrypoint.sh"]
