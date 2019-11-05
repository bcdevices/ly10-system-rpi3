FROM erlang:22.1.5-alpine

LABEL "com.github.actions.name"="Build System"
LABEL "com.github.actions.description"="Build Nerves System"
LABEL "com.github.actions.icon"="package"
LABEL "com.github.actions.color"="blue"

LABEL "repositoty"="https://github.com/bcdevices/ly10-system-rpi3"
LABEL "homepage"="https://github.com/bcdevices/ly10-system-rpi3"
LABEL "maintainer"="Blue Clover Devices"

RUN apk update \
  && apk add ca-certificates wget \
  zip \
  xz \
  squashfs-tools \
  git \
  automake \
  autoconf \
  alpine-sdk \
  fakeroot \
  bash \
  subversion \
  rsync \
  python \
  &&  update-ca-certificates

ENV ELIXIR_VERSION=1.9.2-otp-22
ENV MIX_TAGET=ly10_rpi3


#Install Elixir
RUN wget https://repo.hex.pm/builds/elixir/v$ELIXIR_VERSION.zip && \
      unzip -d /usr/local/elixir v$ELIXIR_VERSION.zip

ENV PATH /usr/local/elixir/bin:$PATH

WORKDIR /usr/src

ADD entrypoint.sh /entrypoint.sh

CMD ["/entrypoint.sh"]
