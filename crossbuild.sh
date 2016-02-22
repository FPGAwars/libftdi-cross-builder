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
ZIPBALL=$PWD/dist/$PACKNAME.zip
ZIPEXAMPLE=find_all-example-$ARCH-$VERSION.zip

# Store current dir
WORK=$PWD

# Enter into the code directory
mkdir -p dist; cd dist

# Install dependencies
sudo apt-get install cmake  git-core mingw-w64 mingw-w64-tools zip

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

# Cross compile one example
cd ../examples
$HOST-gcc find_all.c -o find_all.exe -I ../src -L $PREFIX/lib -L $HOME/.win/libusb/lib -static -lftdi1 -lusb-1.0

# Zip the .exe file and move it to the main directory
zip $ZIPEXAMPLE find_all.exe
mv $ZIPEXAMPLE $WORK

# Create the tarball
cd $PREFIX
tar vzcf $TARBALL *
mv $TARBALL $WORK

# Create the zipball
zip -r $ZIPBALL *
mv $ZIPBALL $WORK
