#!/bin/bash

if [ "$EUID" -ne 0 ]
  then echo "Please run as root"
  exit
fi

apt install build-essential cmake libpci-dev git -y
git clone https://github.com/FlyGoat/RyzenAdj.git
cd RyzenAdj
rm -r win32
mkdir build && cd build
cmake -DCMAKE_BUILD_TYPE=Release ..
make

if [ -d /usr/local/sbin ]; then ln -s ryzenadj /usr/local/bin/ryzenadj && echo "symlinked to /usr/local/bin/ryzenadj"; fi

ryzenadj --apu-slow-limit=6000 --max-socclk-frequency=3000 --apu-skin-temp=80 --power-saving
