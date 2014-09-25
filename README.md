## Docker Base: Android


This repository contains **Dockerbase** of [Android](http://developer.android.com/) for [Docker](https://www.docker.com/)'s [Dockerbase build](https://registry.hub.docker.com/u/dockerbase/android/) published on the public [Docker Hub Registry](https://registry.hub.docker.com/).


### Depends on:

* [dockerbase/devbase-jdk](https://registry.hub.docker.com/u/dockerbase/devbase-jdk)


### Installation

1. Install [Docker](https://docs.docker.com/installation/).

2. Download [Dockerbase build](https://registry.hub.docker.com/u/dockerbase/android/) from public [Docker Hub Registry](https://registry.hub.docker.com/): `docker pull dockerbase/android`


### Usage

    docker run -it --rm --name dockerbase-android dockerbase/android

### Components & Versions

    Description:	Ubuntu 14.04.1 LTS
    git version 1.9.1
    sh: 1: ruby: not found
    OpenSSH_6.6.1p1 Ubuntu-2ubuntu2, OpenSSL 1.0.1f 6 Jan 2014
    GNU Make 3.81
    Copyright (C) 2006  Free Software Foundation, Inc.
    This is free software; see the source for copying conditions.
    There is NO warranty; not even for MERCHANTABILITY or FITNESS FOR A
    PARTICULAR PURPOSE.
    
    This program built for x86_64-pc-linux-gnu
    javac 1.8.0_20
    java version "1.8.0_20"
    Java(TM) SE Runtime Environment (build 1.8.0_20-b26)
    Java HotSpot(TM) 64-Bit Server VM (build 25.20-b23, mixed mode)
    Android SDK:/home/devbase/.android/android-sdk_r23.0.2-linux
    Android NDK:/home/devbase/.android/android-ndk-r10b
    Android build-tools:20.0.0
    Android platform-tools:Pkg.Revision=20
    Android platforms:android-19  android-20
    Android tools:Pkg.Revision=23.0.2
