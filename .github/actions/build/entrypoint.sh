#!/bin/bash

set -e

mkdir -p /github/home/.nerves/dl
make dist

set +e

cp /github/home/.nerves/dl/ly10_system_rpi3* dist/

set -e

make dist-test-app

