PKG_INSTALL_PATH=.
[ ! -z "$1" ] && {
  PKG_INSTALL_PATH=$1 
  mkdir -p $PKG_INSTALL_PATH
}

# Information Of Package
PKG_ALIAS=android-ndk.linux
PKG_VERSION=android-ndk-r10d
PKG_PACKAGE=android-ndk-r10d-linux-x86_64.bin
PKG_LINK=http://dl.google.com/android/ndk/$PKG_PACKAGE

# Install Android NDK
cd /tmp && \
curl -O -L $PKG_LINK && \
chmod a+x /tmp/$PKG_PACKAGE && \
cd $PKG_INSTALL_PATH && \
/tmp/$PKG_PACKAGE && \
ln -s $PKG_INSTALL_PATH/$PKG_VERSION $PKG_INSTALL_PATH/$PKG_ALIAS

# Clean up system
rm -rf /tmp/* /var/tmp/*
