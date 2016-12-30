#! /bin/bash
# Compile index.html for kxsystems.github.io from XML source
# stephen@kx.com

xsltproc -o index.html repositories.xsl contributors.xml
if [ $?=0 ]; then
	echo "index.html compiled"
else
	echo "** Error: index.html not compiled"
fi