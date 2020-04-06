#!/bin/sh

# Install pre-requisities
sudo apt install squashfs-tools genisoimage

#Obtain the base system
# 1 Download an official Desktop image from http://cdimage.ubuntu.com/daily-live/current/

# 2 Move or copy it into an empty directory

mkdir ~/livecdtmp
mv focal-desktop-amd64 ~/livecdtmp 