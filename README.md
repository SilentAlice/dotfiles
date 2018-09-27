SilentAlice's dotfiles

vim config files

1. All plugins are managed via git submodule. Init them before use it.

  ```
  cd ~/.vim
  cp .vimrc ~/.vimrc
  git submodule update --init
  ```
2. ftags is used to generate filenametags which is used for lookupfiles plugin. copy it to your bin dir

  ```
  cp ftags /usr/local/bin/
  ```
