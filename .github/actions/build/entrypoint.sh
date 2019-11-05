#!/bin/sh

sh -c 'mix local.hex --force'
sh -c 'mix archive.install hex nerves_bootstrap 1.6.1 --force'
sh -c 'mix deps.get'
sh -c 'mix compile'
fakeroot mix nerves.artifact --path ./dist
