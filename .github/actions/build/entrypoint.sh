#!/bin/sh

mix local.hex --force
mix archive.install hex nerves_bootstrap 1.6.1 --force
mix deps.get
mix compile
fakeroot mix nerves.artifact --path ./dist
