#!/bin/bash

PROGNAME=pyrocket
VERSION=0.6
RELEASE_NAME=$PROGNAME-$VERSION
DISTRIBUTABLE_NAME=${PROGNAME}_$VERSION

cd src
dch -m
cd ..
svn export src $RELEASE_NAME.orig
cd $RELEASE_NAME.orig
chmod a-x pyrocket.png pyrocket.xpm msnmissile.png
rm -r icons
rm -r debian
cd ..
svn export src $RELEASE_NAME
cd $RELEASE_NAME
chmod a-x pyrocket.png pyrocket.xpm msnmissile.png
rm -r icons
chmod a-x debian/*
chmod a+x debian/rules
debuild -S -sa
cd ..
rm -r $RELEASE_NAME


echo -n "Do you want to upload the orig.tar.gz to kostmo.ath.cx? [Y/n] "
read character
case $character in
    [Yy] | "" ) echo "You responded in the affirmative."
	scp $DISTRIBUTABLE_NAME.orig.tar.gz kostmo.ath.cx:/Library/WebServer/Documents/software/pyrocket/$RELEASE_NAME.tar.gz
        ;;
    * ) echo "Fine, then."
esac


echo "Alternatively, I will upload a new release to Google Code."
echo -n "Do you want me to? [Y/n]: "
read character
case $character in
    [Yy] | "" ) echo "You responded in the affirmative."
	wget http://support.googlecode.com/svn/trunk/scripts/googlecode_upload.py
	chmod a+x googlecode_upload.py
	./googlecode_upload.py -s "source code" -p $PROGNAME $DISTRIBUTABLE_NAME.orig.tar.gz
	rm googlecode_upload.py
    * ) echo "Fine, then."
esac

CHANGES_FILE=${DISTRIBUTABLE_NAME}_source.changes

echo "You might want to run 'dput my-ppa $CHANGES_FILE' next"
echo "-or-"
echo "run 'dput revu $CHANGES_FILE'"
