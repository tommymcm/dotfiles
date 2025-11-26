# Shortcut Aliases
alias emacs='emacs -nw'
alias em='emacs'
alias emac='emacs'
alias ll='ls -lF'
alias la='ls -A'
alias l='ls -CF'
alias cq='condor_q'
alias cqj='condor_q $(whoami)'
alias cqa='condor_q -all'
alias cr='condor_rm'
alias cw='watch condor_q $(whoami)'
alias cprio='condor_userprio'
alias makerr='make &> errors.txt ; tail -n 50 errors.txt'
alias sd='cd -'
alias src='source'
alias nfs='cd /nfs-scratch/$(whoami)'
alias tsq='cd /nfs-scratch/$(whoami)/tsq/spec-uses'
alias cg='cd $(git rev-parse --show-toplevel)'

# Quality of Life Aliases
alias cp="cp -i"
alias mv="mv -i"
alias ll='ls -lh --color'
alias du='du -h'
alias tree='tree -C'
alias df='df -h'
alias free='free -h'
alias vlock='vlock --all'

# SSH Aliases
alias peroni='ssh peroni'