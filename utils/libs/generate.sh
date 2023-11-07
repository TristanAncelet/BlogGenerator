#!/usr/bin/bash

function generate_blog_post () {
    include blog-page

    ## Loading in required functions
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
[[index.wiki|Index]]
---------------------------

last 5 posts
---------------------------
`
TITLES=""
for page in ${last_few_posts[@]}; do
    read JUNK TITLE <<< "$( grep '%title' $page )"
    TITLES="${TITLES}\n - [[$(basename $page)|$TITLE]]"
done
echo -e $TITLES
`

*Date:* `date +'%Y/%m/%d'`
*Author:* Tristan Ancelet

= $PAGE_TITLE =
EOF

return 0
}

function generate_index () {
    local -a blog_files
    local OUTPUT=$BLOG_DIR/index.wiki
    local TITLE DATE JUNK FILENAME

    include blog-page
    get_blog_pages blog_files

    cat >$OUTPUT <<EOF
%title Blog Index

--------
[[about-me.wiki|About Me]]
--------

## Blog Posts
-------------

`
for file in ${blog_files[@]}; do
    read JUNK TITLE <<< "$( grep '%title' $file )"
    FILENAME="$(basename $file)"
    DATE="$(grep -i 'date:' $file | grep -Eo '[0-9]{4}/[0-9]{2}/[0-9]{2}')"
    
    echo -e "- [[$FILENAME|$DATE - $TITLE ]] \n"
done
`

EOF
    
}

function generate_hook() {
	generate_index
}
