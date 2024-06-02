#!/bin/sh

git submodule update --init

mkdir .vim
cp -r after .vim/
cp -r autoload .vim/
cp -r bundle .vim/
cp -r colors .vim/
cp -r syntax .vim/
cp -r template .vim/

mv .vim ~/
cp .vimrc ~/
