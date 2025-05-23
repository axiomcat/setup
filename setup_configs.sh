#!/usr/bin/env bash

script_dir="$(cd $(dirname "${BASH_SOURCE[0]}") && pwd)"
dry="0"

while [[ $# > 0 ]]; do
    if [[ "$1" == "--dry" ]]; then
        dry="1"
    fi
    shift
done

log() {
    if [[ $dry == "1" ]]; then
        echo "[DRY_RUN]: $@"
    else
        echo "$@"
    fi
}

execute() {
    log "execute: $@"
    if [[ $dry == "1" ]]; then
        return
    fi

    "$@"
}

copy_dir() {
	from=$1
    to=$2

	pushd $from > /dev/null

    dirs=$(find . -maxdepth 1 -mindepth 1 -type d -not -iwholename '*.git')
    for dir in $dirs; do
        execute rm -rf $to/$dir
        execute cp -r $dir $to/$dir
    done
    popd
}

copy_dir $HOME/repos/dotfiles/.config $HOME

copy_file() {
    from=$1
    to=$2
    name=$(basename $from)
    execute rm $to/$name 
    execute cp $from $to/$name
}

copy_file $HOME/repos/dotfiles/.tmux.conf ~/
