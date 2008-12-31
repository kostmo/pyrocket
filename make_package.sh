#!/bin/bash

PROGNAME=pyrocket
VERSION=0.6
RELEASE_NAME=$PROGNAME-$VERSION

svn export src $RELEASE_NAME.orig
cd $RELEASE_NAME.orig
chmod a-x $PROGNAME.png $PROGNAME.xpm msnmissile.png
rm -r icons
rm -r debian
cd ..
svn export src $RELEASE_NAME
cd $RELEASE_NAME
chmod a-x $PROGNAME.png $PROGNAME.xpm msnmissile.png
rm -r icons
chmod a-x debian/*
chmod a+x debian/rules
debuild
cd ..
rm -r $RELEASE_NAME

echo -n "Do you want to install the new .deb? [Y/n]: "
read character
case $character in
    [Yy] | "" ) echo "You responded in the affirmative."
	sudo gdebi *.deb
        ;;
    * ) echo "Fine, then."
esac
