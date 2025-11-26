#!/bin/bash

git config --global alias.co checkout
git config --global alias.sw switch
git config --global alias.st status
git config --global alias.ci commit
git config --global alias.br branch
git config --global alias.unstage 'reset HEAD --'
git config --global alias.last 'log -1 HEAD'
git config --global alias.root 'rev-parse --show-toplevel'
git config --global alias.uno 'status -uno'
git config --global alias.url 'remote show origin'
git config --global alias.stu 'status -uno'
git config --global alias.make '!make -C `git rev-parse --show-toplevel`'
git config --global alias.enable '![ ! -d `git root`/enable ] && source `git root`/enable  '
git config --global alias.graph 'log --graph --decorate --oneline'
