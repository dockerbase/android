# VERSION 1.0
# DOCKER-VERSION  1.2.0
# AUTHOR:         Richard Lee <lifuzu@gmail.com>
# DESCRIPTION:    Android Image Container

FROM dockerbase/devbase-jdk

ENV LC_ALL C
ENV DEBIAN_FRONTEND noninteractive

USER    root
# Run the build scripts
RUN	dpkg --add-architecture i386
RUN     apt-get update

RUN     apt-get install -y --no-install-recommends libc6:i386 libncurses5:i386 libstdc++6:i386
RUN     apt-get install -y --no-install-recommends lib32z1
# Clean up system
RUN     apt-get clean

USER    devbase
# Information Of Package
ENV     PKG_ALIAS   android-sdk.linux
ENV	PKG_VERSION android-sdk_r23.0.2-linux
ENV	PKG_PACKAGE $PKG_VERSION.tgz
ENV	PKG_LINK http://dl.google.com/android/$PKG_PACKAGE

# Create Package Install Folder
ENV     PKG_INSTALL_PATH $HOME/.android
RUN     mkdir -p $PKG_INSTALL_PATH

# Install Android SDK
RUN     cd /tmp && \
        curl -O -L $PKG_LINK && \
        tar -zxf /tmp/$PKG_PACKAGE -C $PKG_INSTALL_PATH && \
        mv $PKG_INSTALL_PATH/android-sdk-linux $PKG_INSTALL_PATH/$PKG_VERSION && \
        ln -s $PKG_INSTALL_PATH/$PKG_VERSION $PKG_INSTALL_PATH/$PKG_ALIAS

ENV     ANDROID_HOME $PKG_INSTALL_PATH/$PKG_ALIAS
ENV     PATH $PATH:$ANDROID_HOME/tools

# Install Android tools - latest versioon
RUN     echo y | android update sdk --filter tools --no-ui
# Install Android build-tools - specific version
RUN     echo y | android update sdk --filter build-tools-20.0.0 --no-ui
# Install Android platform-tools - latest version
RUN     echo y | android update sdk --filter platform-tools --no-ui
# Install Android Platforms - specific version(s)
RUN     echo y | android update sdk --filter android-20,android-19 --no-ui
# Install Android Addon - specific version(s)
#RUN     echo y | android update sdk --filter addon-google_apis-google-19 --no-ui
# Install Android Extra - specific version(s)
#RUN     echo y | android update sdk --filter extra-android-m2repository,extra-android-support --no-ui

# Information Of Package
ENV     PKG_ALIAS   android-ndk.linux
ENV     PKG_VERSION android-ndk-r10b
ENV     PKG_PACKAGE android-ndk32-r10b-linux-x86_64.tar.bz2
ENV     PKG_LINK http://dl.google.com/android/ndk/$PKG_PACKAGE

# Install Android NDK
RUN     cd /tmp && \
        curl -O -L $PKG_LINK && \
        tar -jxf /tmp/$PKG_PACKAGE -C $PKG_INSTALL_PATH && \
        ln -s $PKG_INSTALL_PATH/$PKG_VERSION $PKG_INSTALL_PATH/$PKG_ALIAS

ENV     ANDROID_NDK $PKG_INSTALL_PATH/$PKG_ALIAS
ENV     PATH $PATH:$ANDROID_NDK

# Clean up system
RUN     rm -rf /tmp/* /var/tmp/*

# Set environment variables.
ENV     HOME /home/devbase

# Define working directory.
WORKDIR /home/devbase

# Append User Guide.
ADD     build/userguide.md $HOME/UserGuide.md

# Define default command.
CMD ["bash"]
