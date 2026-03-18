#!/bin/sh

# Checkout submodules
git submodule init
git submodule update
git submodule sync

# Install plugins
cp -r ./zsh-autosuggestions ./.oh-my-zsh/custom/plugins/
cp -r ./zsh-syntax-highlighting ./.oh-my-zsh/custom/plugins/
cp -r ./fzf-zsh-plugin ./.oh-my-zsh/custom/plugins/

# Install themes
cp -r ./powerlevel10k ./.oh-my-zsh/custom/themes/

# install oh-my-zsh
cp -r ./.oh-my-zsh ~/
cp -r ./.zshrc ~/
