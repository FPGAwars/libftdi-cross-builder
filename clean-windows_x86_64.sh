####################################################################
# Clean the cross-compilation file outputs for the Windows_x86_64
####################################################################

NAME=libftdi
ARCH=windows_x86_64
PACK_DIR=packages
BUILD_DIR=build_$ARCH
EXAMPLE=find_all-example
PREFIX=$HOME/.$ARCH



# Remove the build directory
rm -f -r $BUILD_DIR

# Removed the packages generated
rm -f $PWD/$PACK_DIR/$NAME-$ARCH-*.tar.gz
rm -f $PWD/$PACK_DIR/$NAME-$ARCH-*.zip
rm -f $PWD/$PACK_DIR/$EXAMPLE-$ARCH-*.zip

#-- Remove the installed libusb
cd $PREFIX
rm -f $PREFIX/bin/libftdi1-config
rm -f $PREFIX/bin/libftdi1.dll
rm -f -r $PREFIX/include/libftdi1
rm -f $PREFIX/lib/libftdi*
rm -f $PREFIX/lib/pkgconfig/libftdi*
rm -f -r $PREFIX/lib/cmake/libftdi1
