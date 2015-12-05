PKG_INSTALL_PATH=.
[ ! -z "$1" ] && {
  PKG_INSTALL_PATH=$1 
  mkdir -p $PKG_INSTALL_PATH
}

# Information Of Package
PKG_TYPE=linux
PKG_ALIAS=android-sdk.$PKG_TYPE
PKG_VERSION=android-sdk_r24.4.1-$PKG_TYPE
PKG_PACKAGE=$PKG_VERSION.tgz
PKG_LINK=http://dl.google.com/android/$PKG_PACKAGE

# Install Android SDK
cd /tmp && \
curl -O -L $PKG_LINK && \
tar -zxf /tmp/$PKG_PACKAGE -C $PKG_INSTALL_PATH && \
mv $PKG_INSTALL_PATH/android-sdk-$PKG_TYPE $PKG_INSTALL_PATH/$PKG_VERSION && \
ln -s $PKG_INSTALL_PATH/$PKG_VERSION $PKG_INSTALL_PATH/$PKG_ALIAS

export PATH=$PATH:$PKG_INSTALL_PATH/$PKG_ALIAS/tools

# Install Android tools - latest versioon
echo y | android update sdk --filter tools --no-ui
# Install Android build-tools - specific version
echo y | android update sdk --filter build-tools-23.0.1 --no-ui
# Install Android platform-tools - latest version
echo y | android update sdk --filter platform-tools --no-ui
# Install Android Platforms - specific version(s)
echo y | android update sdk --filter android-21,android-22,android-23 --no-ui
# Install Android Addon - specific version(s)
#echo y | android update sdk --filter addon-google_apis-google-19 --no-ui
# Install Android Extra - specific version(s)
#echo y | android update sdk --filter extra-android-m2repository,extra-android-support --no-ui

# Clean up system
rm -rf /tmp/* /var/tmp/*
