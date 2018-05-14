#!/bin/bash

porcelain=$(git status --porcelain)

if [ -n "$porcelain" ]
then
    echo "PLEASE COMMIT YOUR CHANGE FIRST!!!"
    exit 1
fi

branch=$(git branch | grep -e "^*" | cut -d' ' -f 2)
jekyll build
rm push.sh
git checkout master
cp -r _site/* .
git add .
git commit -m "AUTO COMMIT"
git push
git checkout $branch
