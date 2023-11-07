#!/bin/bash


# BEGIN: Variables

## This is assuming you're using a linux/unix OS (or at least WSL for windows)
VIM_DIR=~/.vim
VIMRC_FILE=~/.vimrc
VIM_AUTOLOAD_DIR=$VIM_DIR/autoload

## Retrieved from github
### GitHub: https://github.com/junegunn/vim-plug
PLUG_DOWNLOAD_URL='https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'
## Removing proceding path just to get filename
PLUG_FILENAME="${PLUG_DOWNLOAD_URL/*\/}"
PLUG_DOWNLOAD_PATH=$VIM_AUTOLOAD_DIR/$PLUG_FILENAME

# END: Variables



# BEGIN: Pre-Work Check

if ! test vim; then
	echo "Vim is not installed. You will need to install it before you can use vimwiki"
fi

if [[ ! -d $VIM_AUTOLOAD_DIR ]]; then
	mkdir -p $VIM_AUTOLOAD_DIR
fi

# END: Pre-Work Check



# BEGIN: Work

## If plug isn't already installed
if [[ ! -f $VIM_AUTOLOAD_DIR/$PLUG_FILENAME ]]; then
	curl "$PLUG_DOWNLOAD_URL" -o $PLUG_DOWNLOAD_PATH
fi



# END: Work
