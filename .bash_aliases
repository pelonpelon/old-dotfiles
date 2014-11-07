#!/bin/bash

source ~/.local_aliases


alias ls="ls -G"

function mkd() { mkdir $1 && cd $1; }

alias vv="vim -c NERDTree"

alias ll="ls -Gl"
alias la="ls -Gla"

# Pretty git log
alias gitl="git log --all --graph --pretty=format:'%Cred%h%Creset -%C(auto)%d%Creset %s %Cgreen(%cr) %C(bold blue)<%an>%Creset' --abbrev-commit --date=relative"



function d() { echo "dash://$1"; }
function dj() { open dash://javascript:$1; }
function dq() { open dash://jquery:$1; }
function dw() { open dash://wordpress:$1; }
function dp() { open dash://php:$1; }
function dr() { echo dash://$1; }
