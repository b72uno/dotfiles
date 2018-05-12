#!/bin/sh

# Source - https://askubuntu.com/questions/26498/choose-gcc-and-g-version
# =========================================================================
# First, remove old packages
# sudo update-alternatives --remove-all gcc 
# sudo update-alternatives --remove-all g++

# Install packages
# sudo apt-get install gcc-4.3 gcc-4.4 g++-4.3 g++-4.4

# Install alternatives
# sudo update-alternatives --install /usr/bin/gcc gcc /usr/bin/gcc-4.3 10
# sudo update-alternatives --install /usr/bin/gcc gcc /usr/bin/gcc-4.4 20

# sudo update-alternatives --install /usr/bin/g++ g++ /usr/bin/g++-4.3 10
# sudo update-alternatives --install /usr/bin/g++ g++ /usr/bin/g++-4.4 20

# sudo update-alternatives --install /usr/bin/cc cc /usr/bin/gcc 30
# sudo update-alternatives --set cc /usr/bin/gcc

# sudo update-alternatives --install /usr/bin/c++ c++ /usr/bin/g++ 30
# sudo update-alternatives --set c++ /usr/bin/g++

# use this cript to switch alternatives

if [ -z "$1" ]; then
    echo "usage: $0 version" 1>&2
    exit 1
fi

if [ ! -f "/usr/bin/gcc-$1" ] || [ ! -f "/usr/bin/g++-$1" ]; then
    echo "no such version gcc/g++ installed" 1>&2
    exit 1
fi

update-alternatives --set gcc "/usr/bin/gcc-$1"
update-alternatives --set g++ "/usr/bin/g++-$1"
