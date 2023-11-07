#!/bin/bash

## If user is not running this in the root of the project dir
if [[ ! -d utils ]]; then
	## Change directory to project dir
	cd `dirname $1`
	cd ..
fi


MESSAGE="${1:?"Message not provided"}"

git submodule foreach "git add .; git commit -m '$MESSAGE'; git push"

git add . 
git commit -m "$MESSAGE"
git push origin master
git push gitserver master
