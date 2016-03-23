###########################################################
# Compile on example of use the libftdi in linux 32-bits
# The libftdi is not compiled because it can be install
# in ubuntu by means of apt-get install
###########################################################

BUILD=x86-unknown-linux-gnu
HOST=i686-linux-gnu
TARGET=i686-linux-gnu

NAME=libftdi
ARCH=linux_i686
PREFIX=$HOME/.$ARCH
VERSION=3
PACKNAME=$NAME-$ARCH-$VERSION

BUILD_DIR=build_$ARCH
BUILD_DATA_DIR=build-data
PACK_DIR=packages

TARBALL=$PWD/$BUILD_DIR/$PACKNAME.tar.gz
ZIPBALL=$PWD/$BUILD_DIR/$PACKNAME.zip
TAREXAMPLE=find_all-example-$ARCH-$VERSION.tar.gz

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
sudo apt-get install  zip gcc-multilib g++-multilib libudev-dev:i386 libftdi-dev:i386 libftdi1:i386

# download libftdi
git -C $NAME pull || git clone  $GITREPO

# Create the packages directory
mkdir -p $PACK_DIR

# Enter into the build directory
mkdir -p $BUILD_DIR ; cd $BUILD_DIR

# Copy the upstream libftdi into the build dir
cp -r $WORK/$NAME .

# Cross compile one example
cd $NAME/examples
gcc -m32 find_all.c -o find_all -static  -L /usr/lib/i386-linux-gnu  -lftdi -lusb

# Zip the .exe file and move it to the main directory
tar vzcf $TAREXAMPLE find_all
mv $TAREXAMPLE $WORK/$PACK_DIR
