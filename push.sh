#!/bin/bash

b=$(git branch | grep -e "^*" | cut -d' ' -f 2)
git checkout master
jekyll build
cp -r _site/* .
