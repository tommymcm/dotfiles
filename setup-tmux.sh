#!/bin/bash

DIR=$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )

CONFIG=$HOME/.config

# Copy over all the tmux configurations
cp -r $DIR/tmux/ $CONFIG

# Setup plugins.
mkdir -p $CONFIG/tmux/plugins

## Pull tpm.
git clone https://github.com/tmux-plugins/tpm $CONFIG/tmux/plugins/tpm
