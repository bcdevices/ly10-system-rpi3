#!/bin/sh

mkdir -p "$HOME/.nerves/dl"
cp -R vendor/* "$HOME/.nerves/dl"
mix local.hex --force
mix archive.install hex nerves_bootstrap 1.6.1 --force
mix deps.get
mix compile
fakeroot mix nerves.artifact ly10-system-rpi3 --path ./dist
