#!/bin/bash

b=$(git branch | grep -e "^*" | cut -d' ' -f 2)
jekyll build
rm push.sh
git checkout master
cp -r _site/* .
