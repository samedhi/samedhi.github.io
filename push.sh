#!/bin/bash

branch=$(git branch | grep -e "^*" | cut -d' ' -f 2)
jekyll build
rm push.sh
git checkout master
cp -r _site/* .
git add .
git commit -m "AUTO COMMIT"
git push
git checkout $branch
