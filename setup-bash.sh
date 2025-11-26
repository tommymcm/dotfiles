#!/bin/bash

# Append/create all files
for file in $(find bash/ -name ".bash*")
do
    name=$(basename ${file})
    
    touch ${HOME}/${name}
    cat ${file} >> ${HOME}/${name}
done

# Append to .bashrc
>>${HOME}/.bash_profile cat <<EOF
# Profile definitions.
if [ -f ~/.bash_user ] ; then
    . ~/.bash_user ]
fi

# Alias definitions.
if [ -f ~/.bash_aliases ]; then
    . ~/.bash_aliases
fi
EOF
	    
