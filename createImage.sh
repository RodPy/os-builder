#!/bin/sh

# Install pre-requisities
sudo apt install squashfs-tools genisoimage

#Obtain the base system
# 1 Download an official Desktop image from http://cdimage.ubuntu.com/daily-live/current/

# 2 Move or copy it into an empty directory

mkdir ~/livecdtmp
mv focal-desktop-amd64.iso ~/livecdtmp

#Extract the CD .iso contents
#Mount the Desktop .iso
cd livecdtmp
mkdir mnt
sudo mount -o loop focal-desktop-amd64.iso mnt


#Extract .iso contents into dir 'extract-cd'
mkdir extract-cd
sudo rsync --exclude=/casper/filesystem.squashfs -a mnt/ extract-cd

# Extract the Desktop system
sudo unsquashfs mnt/casper/filesystem.squashfs
sudo mv squashfs-root edit

#Producing the CD image
#Assembling the file system
#Regenerate manifest
chmod +w extract-cd/casper/filesystem.manifest
sudo cp extract-cd/casper/filesystem.manifest extract-cd/casper/filesystem.manifest-desktop
sudo sed -i '/ubiquity/d' extract-cd/casper/filesystem.manifest-desktop
sudo sed -i '/casper/d' extract-cd/casper/filesystem.manifest-desktop

#Compress filesystem
sudo mksquashfs edit extract-cd/casper/filesystem.squashfs -nolzma

#To get the most compression possible at the cost of compression time, you can use the xz method and it is best to exclude the edit / boot directory entirely:

sudo mksquashfs edit extract-cd/casper/filesystem.squashfs -comp xz -e edit/boot

#Update the filesystem.size file, which is needed by the installer:

sudo su
printf $(du -sx --block-size=1 edit | cut -f1) > extract-cd/casper/filesystem.size
exit

#Remove old md5sum.txt and calculate new md5 sums

cd extract-cd
sudo rm md5sum.txt
find -type f -print0 | sudo xargs -0 md5sum | grep -v isolinux/boot.cat | sudo tee md5sum.txt

#Create the ISO image
sudo mkisofs -D -r -V "$IMAGE_NAME" -cache-inodes -J -l -b isolinux/isolinux.bin -c isolinux/boot.cat -no-emul-boot -boot-load-size 4 -boot-info-table -o ../ubuntu-20.04-custom.iso .
#test image qemu-system-x86_64 -cdrom ubuntu-20.04-custom.iso