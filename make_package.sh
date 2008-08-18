#!/bin/bash
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
debuild
cd ..
rm -r pyrocket-0.5
