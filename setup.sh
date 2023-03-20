#!/bin/sh

# Checkout submodules
git submodule init
git submodule update
git submodule sync

# Install plugins
mv ./zsh-autosuggestions ./.oh-my-zsh/custom/plugins/
mv ./zsh-syntax-highlighting ./.oh-my-zsh/custom/plugins/
mv ./fzf-zsh-plugin ./.oh-my-zsh/custom/plugins/

# Install themes
mv ./powerlevel10k ./.oh-my-zsh/custom/themes/

# install oh-my-zsh
mv ./.oh-my-zsh/ ~/
mv ./.zshrc ~/
