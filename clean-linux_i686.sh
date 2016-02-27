####################################################################
# Clean the cross-compilation file outputs for the Windows_i386
####################################################################

NAME=libftdi
ARCH=linux_i686
PACK_DIR=packages
BUILD_DIR=build_$ARCH
EXAMPLE=find_all-example



# Remove the build directory
rm -f -r $BUILD_DIR

# Removed the packages generated
rm -f $PWD/$PACK_DIR/$EXAMPLE-$ARCH-*.tar.gz
