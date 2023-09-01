#!/usr/bin/bash

function generate_blog_post () {
    ## Loading in required functions
    local BLOG_PAGE=~/Blog/utils/libs/blog-page.sh
    local BLOG_DIR=~/Blog/blog
    [[ -f $BLOG_PAGE ]] && . $BLOG_PAGE

    local PAGE_TITLE="${1:?"generate_blog_post : Page Title was not provided"}"
    local POST_FILENAME="${2:?"generate_blog_post : Filename not provided"}"
    local POST_FILE=$BLOG_DIR/$POST_FILENAME

    if [[ -f $POST_FILE ]]; then
        echo "This file ($POST_FILE) already exists. Faling program"
        return 1
    fi

    local -a last_few_posts
    get_last_5_pages last_few_posts


    cat > $POST_FILE <<EOF
%title $PAGE_TITLE


---------------------------
`
TITLES=""
for page in ${last_few_posts[@]}; do
    read JUNK TITLE <<< "$( grep '%title' $page )"
    TITLES="${TITLES} [[$page|$TITLE]]"
done
echo $TITLES
`
---------------------------

*Date:* `date +'%Y/%m/%d'`
*Author:* Tristan Ancelet
EOF

return 0
}
