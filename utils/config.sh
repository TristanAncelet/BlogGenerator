#!/usr/bin/bash

PROJ_DIR=~/Blog
BLOG_DIR=$PROJ_DIR/blog
UTILS=$PROJ_DIR/utils
LIBS=$UTILS/libs


function include () {
    local LIB_NAME="${1:?"include : a lib name was not provided"}"
    [[ ! "$LIB_NAME" == *.sh ]] && LIB_NAME="$LIB_NAME.sh"
    local LIB_PATH=""

    if [[ ! -f $LIBS/$LIB_NAME ]]; then
        echo "include : $LIBS/$LIB_NAME does not exist."
        exit 1
    else
        LIB_PATH=$LIBS/$LIB_NAME
    fi

    . $LIB_PATH
}
