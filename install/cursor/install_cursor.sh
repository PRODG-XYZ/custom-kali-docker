#!/usr/bin/env bash
set -ex
ARCH=$(arch | sed 's/aarch64/arm64/g' | sed 's/x86_64/x64/g')
wget -q https://update.code.visualstudio.com/latest/linux-deb-${ARCH}/stable -O cursor.deb
apt-get update
apt-get install -y ./cursor.deb
mkdir -p /usr/share/icons/hicolor/apps
wget -O /usr/share/icons/hicolor/apps/cursor.svg https://kasm-static-content.s3.amazonaws.com/icons/cursor.svg
sed -i '/Icon=/c\Icon=/usr/share/icons/hicolor/apps/cursor.svg' /usr/share/applications/cursor.desktop
sed -i 's#/usr/share/code/code#/usr/share/code/code --no-sandbox##' /usr/share/applications/cursor.desktop
cp /usr/share/applications/cursor.desktop $HOME/Desktop
chmod +x $HOME/Desktop/cursor.desktop
chown 1000:1000 $HOME/Desktop/cursor.desktop
rm cursor.deb

# Cleanup
apt-get autoclean
rm -rf \
    /var/lib/apt/lists/* \
    /var/tmp/* \
    /tmp/*
