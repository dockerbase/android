# Run the build scripts
dpkg --add-architecture i386
apt-get update
apt-get install -y --no-install-recommends libc6:i386 libncurses5:i386 libstdc++6:i386
apt-get install -y --no-install-recommends lib32z1
apt-get clean
