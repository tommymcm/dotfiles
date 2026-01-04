#!/bin/bash

DIR=$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )

CONFIG=$HOME/.config

# Copy over all the tmux configurations
cp -r $DIR/tmux/ $CONFIG

# Setup plugins.
mkdir -p $CONFIG/tmux/plugins

## Pull tpm.
TPM_DIR=$CONFIG/tmux/plugins/tpm
if [ ! -d "${TPM_DIR}" ] ; then
    git clone https://github.com/tmux-plugins/tpm ${TPM_DIR}
fi

# Link the config into home.
ln -s -f $CONFIG/tmux/tmux.conf $HOME/.tmux.conf
