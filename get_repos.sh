#!/usr/bin/env bash

mkdir repos
cd repos
git clone https://github.com/axiomcat/dotfiles
git clone https://github.com/axiomcat/setup
git clone https://github.com/axiomcat/neovim nvim
mv nvim dotfiles/.config/nvim
