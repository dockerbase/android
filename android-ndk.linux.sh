PKG_INSTALL_PATH=.
[ ! -z "$1" ] && {
  PKG_INSTALL_PATH=$1 
  mkdir -p $PKG_INSTALL_PATH
}

# Information Of Package
PKG_ALIAS=android-ndk.linux
PKG_VERSION=android-ndk-r10b
PKG_PACKAGE=android-ndk32-r10b-linux-x86_64.tar.bz2
PKG_LINK=http://dl.google.com/android/ndk/$PKG_PACKAGE

# Install Android NDK
cd /tmp && \
curl -O -L $PKG_LINK && \
tar -jxf /tmp/$PKG_PACKAGE -C $PKG_INSTALL_PATH && \
ln -s $PKG_INSTALL_PATH/$PKG_VERSION $PKG_INSTALL_PATH/$PKG_ALIAS

# Clean up system
rm -rf /tmp/* /var/tmp/*
