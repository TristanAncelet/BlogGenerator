#!/usr/bin/bash

PROJ_DIR=~/Blog
CONFIG=$PROJ_DIR/utils/config.sh

## Loading in config
[[ -f $CONFIG ]] && . $CONFIG
include generate

usage () {
    cat <<EOF
main.sh [ -n | --new "<title>" "<filename>" ] [ -r | --regenerate ] 

Legend:
-n | --new             Create new blog post/wiki with provided information
-r | --regenerate      Regenerate your index.wiki file
EOF
}

while [[ $# -ne 0 ]]; do
    case $1 in
        -n | --new)
            shift
            : "
            $1 = Title
            $2 = Filename
            "
	    DATESTAMP=`date +%s`
            TITLE="${1:?"main.sh : Title was not provided"}"
            FILENAME="${2:?"main.sh : Filename was not provided"}"
            generate_blog_post "$TITLE" "$DATESTAMP-$FILENAME"
            sync
            generate_hook
            break
            ;;

        -r | --regenrate )
            ## This will run all generate scripts/functions in the generate_hook function
            generate_hook
            exit 0
            ;;
        *)
            usage
            exit 1
            ;;
    esac
done
