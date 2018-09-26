SilentAlice's dotfiles

Zsh config file

`oh-my-zsh` is managed as submodule. I also add zsh-syntax-highlighting and zsh-autosuggestions plugin.

clone this branch and modify path of your ZSH in `.zshrc`. Then enjoy it:

```
git clone --single-branch -b zsh git@github.com:SilentAlice/dotfiles.git
cd dotfiles
git submodule update --init 
mv zsh-autosuggestions/ .oh-my-zsh/plugins/
mv zsh-syntax-highlighting/ .oh-my-zsh/plugins/
cp -r .oh-my-zsh ~/
cp .zshrc ~/
```

You need to modify the `ZSH` var in  `zshrc`.
