#!/usr/bin/bash

PROJ_DIR=~/Blog
CONFIG=$PROJ_DIR/utils/config.sh

## Loading in config
[[ -f $CONFIG ]] && . $CONFIG
include generate

usage () {
    cat <<EOF
main.sh [ -n | --new ] "<title>" "<filename>"  
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
            TITLE="${1:?"main.sh : Title was not provided"}"
            FILENAME="${2:?"main.sh : Filename was not provided"}"
            generate_blog_post "$TITLE" "$FILENAME"
            sync
            generate_index
            break
            ;;
        *)
            usage
            exit 1
            ;;
    esac
done
