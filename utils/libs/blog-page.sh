#!/usr/bin/bash

function get_blog_pages () {
	local BLOG_DIR=~/Blog
	local VAR_NAME="${1:?"No variable was provided to lod the pages into"}"
	local -n VAR="$VAR_NAME"
	VAR=( $(ls $BLOG_DIR/blog/????-??-??.wiki) )

}

function get_last_5_pages (){
	local -a pages
	local PAGES
	get_blog_pages pages

	PAGES=${#pages[@]};

	if [[ $PAGES -lt 5 ]]; then
		for (( i=$((PAGES-1)); i==0; i--)); do
			echo ${i}
		done
	else
		echo "Hi"
	fi
}


if [[ "$0" == *"blog-page.sh" ]]; then
	get_last_5_pages
fi
