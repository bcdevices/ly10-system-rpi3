#!/bin/bash

mkdir -p "$HOME/.nerves/dl"
cp -R vendor/* "$HOME/.nerves/dl"
mix local.hex --force
mix archive.install hex nerves_bootstrap 1.6.1 --force
mix deps.get
mix compile
mkdir ./dist
if [ -f "$HOME/.nerves/dl/ly10_system_rpi3-portable-*" ]
then
  cp "$HOME/.nerves/dl/ly10_system_rpi3-portable-*" ./dist
else
  fakeroot mix nerves.artifact ly10_system_rpi3 --path ./dist
fi
