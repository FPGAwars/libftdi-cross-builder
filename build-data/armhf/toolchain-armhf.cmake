# the name of the target operating system
SET(CMAKE_SYSTEM_NAME Ubuntu_phone_armhf)

# which compilers to use for C and C++
SET(CMAKE_C_COMPILER arm-linux-gnueabihf-gcc)
SET(CMAKE_CXX_COMPILER arm-linux-gnueabihf-g++)
#SET(CMAKE_RC_COMPILER x86_64-w64-mingw32-windres)

# here is the target environment located
SET(CMAKE_FIND_ROOT_PATH  /usr/arm-linux-gnueabihf/ ~/.armhf )

# adjust the default behaviour of the FIND_XXX() commands:
# search headers and libraries in the target environment, search
# programs in the host environment
set(CMAKE_FIND_ROOT_PATH_MODE_PROGRAM NEVER)
set(CMAKE_FIND_ROOT_PATH_MODE_LIBRARY ONLY)
set(CMAKE_FIND_ROOT_PATH_MODE_INCLUDE ONLY)

# Set the LIBUSB
set(LIBUSB_LIBRARIES /home/obijuan/.armhf/lib/libusb-1.0.so.0 /home/obijuan/.armhf/lib/libudev.so.1)
set(LIBUSB_INCLUDE_DIR ~/.armhf/include/libusb-1.0)

# Set the LIBFTDI
set(LIBFTDI_LIBRARY_DIRS ~/.armhf/lib)
