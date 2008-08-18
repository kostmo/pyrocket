#!/bin/bash

cd src
dch -m
cd ..
svn export src pyrocket-0.5.orig
cd pyrocket-0.5.orig
chmod a-x pyrocket.png pyrocket.xpm msnmissile.png
rm -r icons
rm -r debian
cd ..
svn export src pyrocket-0.5
cd pyrocket-0.5
chmod a-x pyrocket.png pyrocket.xpm msnmissile.png
rm -r icons
chmod a-x debian/*
chmod a+x debian/rules
debuild -S -sa
cd ..
rm -r pyrocket-0.5

scp pyrocket_0.5.orig.tar.gz kostmo.ath.cx:/Library/WebServer/Documents/software/pyrocket/pyrocket-0.5.tar.gz

echo "You might want to run 'dput my-ppa pyrocket_0.5_source.changes' next"
echo "-or-"
echo "run 'dput revu pyrocket_0.5-0ubuntu1_source.changes'"
