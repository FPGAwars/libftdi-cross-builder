###############################################
# libftdi builder for different architectures #
###############################################

BUILD=x86-unknown-linux-gnu
HOST=x86_64-w64-mingw32
TARGET=x86_64-w64-mingw32
PREFIX=$HOME/.win/libftdi

NAME=libftdi
ARCH=windows
VERSION=1
PACKNAME=$NAME-$ARCH-$VERSION
TARBALL=$PWD/dist/$PACKNAME.tar.gz

# Store current dir
WORK=$PWD

# Enter into the code directory
mkdir -p dist; cd dist

# Install dependencies
sudo apt-get install cmake  git-core mingw-w64 mingw-w64-tools

# download libftdi
git -C libftdi pull || git clone  git://developer.intra2net.com/libftdi

# Prepare for building
cd libftdi
cp $WORK/toolchain-mingw32.cmake .

mkdir -p build; cd build

# Configure the cross compilation
cmake -DCMAKE_TOOLCHAIN_FILE=toolchain-mingw32.cmake -DCMAKE_INSTALL_PREFIX=$PREFIX ..

# let's cross compile!
make

# Installation
make install

# Create the tarball
cd $PREFIX
tar vzcf $TARBALL *
mv $TARBALL $WORK
