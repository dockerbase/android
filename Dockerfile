# VERSION 1.2
# DOCKER-VERSION  1.2.0
# AUTHOR:         Richard Lee <lifuzu@gmail.com>
# DESCRIPTION:    Android Image Container

FROM dockerbase/devbase-jdk

USER    root
# Run dockerbase script
ADD     android.sh /dockerbase/
RUN     /dockerbase/android.sh

USER    devbase
# Run dockerbase script
ADD     android-sdk.linux.sh /dockerbase/
RUN     /dockerbase/android-sdk.linux.sh $HOME/.android

# Run dockerbase script
ADD     android-ndk.linux.sh /dockerbase/
RUN     /dockerbase/android-ndk.linux.sh $HOME/.android

ENV     ANDROID_HOME $HOME/.android/android-sdk.linux
ENV     PATH $PATH:$ANDROID_HOME/tools:$ANDROID_HOME/platform-tools:$HOME/.android/android-ndk.linux

# Append User Guide.
ADD     build/userguide.md $HOME/UserGuide.md
