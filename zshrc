#!/usr/bin/env zsh

# Configuration folder for zsh.
ZSH_CONFDIR="$HOME/.zsh"
[ -d "${ZSH_CONFDIR}" ] || mkdir "${ZSH_CONFDIR}"

#
[ $(hostname) = "spartan.hpc.unimelb.edu.au" ] && export SPARTAN=1

# Prompt for zsh.
export PROMPT="[%F{blue}%4~%F{default}] $ "
if [ -n "${SPARTAN+1}" ]; then
    RPROMPT="%F{yellow}%? %F{red}%m%F{default}"
else
    RPROMPT="%F{yellow}%? %F{8}%m%F{default}"
fi
export RPROMPT
