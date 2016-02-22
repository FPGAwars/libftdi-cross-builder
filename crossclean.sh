##############################################
# Clean the cross-compilation file outputs
##############################################
NAME=libftdi
ARCH=windows
EXAMPLE=find_all-example

#-- Remove the dist folder
rm -f -r dist

#-- Remove the packages generated
rm -f $NAME-$ARCH-*.tar.gz $NAME-$ARCH-*.zip $EXAMPLE-$ARCH-*.zip

#-- Remove the installed libusb
cd $HOME/.win
rm -f -r $NAME
