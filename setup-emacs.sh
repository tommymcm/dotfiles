#!/bin/bash

for file in $(find emacs -name "*.el")
do
    cp ${file} $HOME/.emacs.d/$(basename ${file})
done
