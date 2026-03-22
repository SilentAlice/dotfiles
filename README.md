SilentAlice's dotfile

Each branch is a config

To use it, clone specific branch:

```
git clone --single-branch -b configname https://github.com/SilentAlice/dotfiles /path/to/dotfile
cd /path/to/dotfile
./setup.sh
```

or you could just change branch:

```
git clone https://github.com/SilentAlice/dotfiles
cd dotfiles

git checkout -t origin/configname #configname is specific item name
./setup.sh

```
