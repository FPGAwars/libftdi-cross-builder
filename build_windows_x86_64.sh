#################################################
# libftdi builder for different Windows 64-bits #
#################################################

BUILD=x86-unknown-linux-gnu
HOST=x86_64-w64-mingw32
TARGET=x86_64-w64-mingw32

NAME=libftdi
ARCH=windows_x86_64
PREFIX=$HOME/.$ARCH
VERSION=1
PACKNAME=$NAME-$ARCH-$VERSION

BUILD_DIR=build_$ARCH
PACK_DIR=packages

TARBALL=$PWD/$BUILD_DIR/$PACKNAME.tar.gz
ZIPBALL=$PWD/$BUILD_DIR/$PACKNAME.zip
ZIPEXAMPLE=find_all-example-$ARCH-$VERSION.zip

GITREPO=git://developer.intra2net.com/libftdi

# Store current dir
WORK=$PWD

# Install dependencies
echo "Installing dependencies..."
sudo apt-get install cmake  git-core mingw-w64 mingw-w64-tools zip

# download libftdi
git -C $NAME pull || git clone  $GITREPO

# Create the packages directory
mkdir -p $PACK_DIR

# Enter into the build directory
mkdir -p $BUILD_DIR ; cd $BUILD_DIR

# Copy the upstream libftdi into the build dir
cp -r $WORK/$NAME .

# Prepare for building
cd $NAME
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
$HOST-gcc find_all.c -o find_all.exe -I ../src -L $PREFIX/lib -static -lftdi1 -lusb-1.0

# Zip the .exe file and move it to the main directory
zip $ZIPEXAMPLE find_all.exe
mv $ZIPEXAMPLE $WORK/$PACK_DIR

# Create the tarball
cd $PREFIX
tar vzcf $TARBALL *
mv $TARBALL $WORK/$PACK_DIR

# Create the zipball
zip -r $ZIPBALL *
mv $ZIPBALL $WORK/$PACK_DIR
