#!/usr/bin/bash

function get_blog_pages () {
    ## Getting the variable to set the list to externally
	local VAR_NAME="${1:?"get_blog_pages : No variable was provided to lod the pages into"}"
	local -n VAR="$VAR_NAME"

    ## Setting the list to the available blog files.
    if ls -1 $BLOG_DIR/*.wiki >/dev/null 2>&1; then
        VAR=( $(ls -1 $BLOG_DIR/*.wiki | grep -Ev 'index.wiki|about-me.wiki' ) )
    fi

}

function get_last_5_pages (){
    ## Index to use in the iterrations later
    local INDEX

    ## Local variable to store pages (locally)
	local -a pages

    ## Variable name to dump list items into
    local VAR_NAME="${1:?"get_last_5_pages : A variable name was not passed into the function"}"
    ## Reference variable to handle setting value of external variable
    local -n VAR="$VAR_NAME"

    ## Page Count Variable
	local PAGES
    ## Grabbing pages from above function
	get_blog_pages pages

    ## Getting page count
	PAGES=${#pages[@]};

    # if the count is less than the minimum, then just set the list as the one grabbed above
	if [[ $PAGES -lt 5 ]]; then
        VAR=( ${pages[@]} )
	else
        ## Otherwise, itterate through the last 5 blog posts
        INDEX=-5
        while [[ $INDEX -ne 0 ]]; do
            VAR+=( "${pages[$INDEX]}" )
            ## Increment the index so that we get closer and closer to end of the list
            ((INDEX++))
        done
	fi
}

