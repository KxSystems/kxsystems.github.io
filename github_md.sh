#! /bin/bash
# Compile index.html for kxsystems.github.io from XML source
# stephen@kx.com

xsltproc -o ~/Projects/kx/code/qref/docs/github.md github_md.xsl contributors.xml
if [ $?=0 ]; then
	echo "github.md compiled"
else
	echo "** Error: github.md not compiled"
fi