#!/bin/sh
#rsync -rave "ssh -p 22" --delete --exclude ".git" ./ alice@haswell-sec:~/ftxen/
rsync -rave "ssh -p 22" --exclude "sync.sh" --exclude "*.gz" --exclude ".git" --exclude "filenametags" --exclude "tags" --exclude "*.out" ./ alice@vpn-ryzen:/Fidelius
#rsync -rave "ssh -p 22" --exclude "amd-a10.sh" --exclude "*.gz" --exclude ".git" --exclude "filenametags" --exclude "tags" --exclude "*.out" ./ alice@haswell-sec:~/Fidelius
