#!/bin/bash

source ~/.local_aliases


alias ls="ls -G"
alias mkd="mkdir $1 && cd $1"

alias vv="vim -c NERDTree"

alias ll="ls -Gl"
alias la="ls -Gla"

# Pretty git log
alias gitl="git log --all --graph --pretty=format:'%Cred%h%Creset -%C(auto)%d%Creset %s %Cgreen(%cr) %C(bold blue)<%an>%Creset' --abbrev-commit --date=relative"
