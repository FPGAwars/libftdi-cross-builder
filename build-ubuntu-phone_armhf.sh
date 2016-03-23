#################################################
# libftdi builder for different Windows 64-bits #
#################################################

BUILD=x86-unknown-linux-gnu
HOST=arm-linux-gnueabihf
TARGET=arm-linux-gnueabihf

NAME=libftdi
ARCH=armhf
PREFIX=$HOME/.$ARCH
VERSION=2
PACKNAME=$NAME-$ARCH-$VERSION

BUILD_DIR=build_$ARCH
BUILD_DATA_DIR=build-data
PACK_DIR=packages

TARBALL=$PWD/$BUILD_DIR/$PACKNAME.tar.gz
ZIPBALL=$PWD/$BUILD_DIR/$PACKNAME.zip
ZIPEXAMPLE=find_all-example-$ARCH-$VERSION.tar.gz

GITREPO=git://developer.intra2net.com/libftdi

# Store current dir
WORK=$PWD

# -- TARGET: CLEAN. Remove the build dir and the generated packages
# --  then exit
if [ "$1" == "clean" ]; then
  echo "-----> CLEAN"

  # Remove the build directory
  rm -f -r $BUILD_DIR

  # Remove the packages generated
  rm -f $PWD/$PACK_DIR/$EXAMPLE-$ARCH-*.tar.gz

  # Remove the installed libftdi
  cd $PREFIX
  rm -f -r $PREFIX/include/libftdi1
  rm -f $PREFIX/lib/libftdi1.*
  rm -f $PREFIX/lib/pkgconfig/libftdi*

  exit
fi

# Install dependencies
echo "Installing dependencies..."
sudo apt-get install cmake  git-core gcc-arm-linux-gnueabihf g++-arm-linux-gnueabihf zip

# download libftdi
git -C $NAME pull || git clone  $GITREPO

# Create the packages directory
mkdir -p $PACK_DIR

# Enter into the build directory
mkdir -p $BUILD_DIR ; cd $BUILD_DIR

# Copy the upstream libftdi into the build dir
cp -r $WORK/$NAME .

# Prepare for building
echo "PREPARING FOR BUILDING........."
cd $NAME
cp $WORK/$BUILD_DATA_DIR/$ARCH/toolchain-armhf.cmake .
cp $WORK/$BUILD_DATA_DIR/$ARCH/CMakeLists.txt .

mkdir -p build; cd build

# Configure the cross compilation
cmake -DCMAKE_TOOLCHAIN_FILE=toolchain-armhf.cmake -DCMAKE_INSTALL_PREFIX=$PREFIX ..

# let's cross compile!
make

# Installation
make install

# Cross compile one example
cd ../examples
$HOST-gcc find_all.c -o find_all -I ../src $PREFIX/lib/libftdi1.a \
          $PREFIX/lib/libusb-1.0.a -L $PREFIX/lib -lpthread

# TAR the executable file and move it to the main directory
tar vzcf $ZIPEXAMPLE find_all
mv $ZIPEXAMPLE $WORK/$PACK_DIR

# Create the tarball
cd $PREFIX
tar vzcf $TARBALL *
mv $TARBALL $WORK/$PACK_DIR
