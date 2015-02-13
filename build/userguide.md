### Install path of Android SDK/NDK

    $ ls ~/.android/android-sdk.linux
    $ readlink ~/.android/android-sdk.linux
    $ ls ~/.android/android-ndk.linux
    $ readlink ~/.android/android-ndk.linux

### Check components version of Android SDK

    $ ls ~/.android/android-sdk.linux/build-tools/
    $ cat ~/.android/android-sdk.linux/platform-tools/source.properties | grep Pkg.Revision
    $ ls ~/.android/android-sdk.linux/platforms/
    $ cat ~/.android/android-sdk.linux/tools/source.properties | grep Pkg.Revision

### List/Install/Update components in Android SDK

    $ android list sdk --all --extended
    $ android update sdk --filter build-tools-20.0.0 --no-ui

### Create a sample gradle project - helloworld

    $ android create project --activity helloworld --package com.example.helloworld --target android-19 --path helloworld --gradle --gradle-version 1.+
    $ cd helloworld
    $ # modify gradle/wrapper/gradle-wrapper.properties, change to 'gradle-2.2.1-all.zip'
    $ # modify build.gradle, change 'runProguard' to 'minifyEnabled'
    $ ./gradlew clean build
