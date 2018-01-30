#!/usr/bin/env sh


warn() {
    echo "$1" >&2
}

die() {
    warn "$1"
    exit 1
}

rm $HOME/.vimrc
rm $HOME/.vimrc.local
rm $HOME/.vimrc.bundles
rm $HOME/.vimrc.legacy
rm $HOME/.vimrc.advance
rm $HOME/.ycm_extra_conf.py

rm -rf $HOME/.vim

