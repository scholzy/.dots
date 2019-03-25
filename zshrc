#!/usr/bin/env zsh

# Configuration folder for zsh.
ZSH_CONFDIR="$HOME/.zsh"
[ -d "${ZSH_CONFDIR}" ] || mkdir "${ZSH_CONFDIR}"

# Check if on the spartan HPC cluster.
[[ "$(hostname)" =~ spartan.+ ]] && export SPARTAN=1

# Prompt for zsh.
export PROMPT="[%F{blue}%4~%F{default}] $ "
if [ -n "${SPARTAN+1}" ]; then
    HOSTCOL="%F{red}"
else
    HOSTCOL="%F{8}"
fi
export RPROMPT="%F{yellow}%? ${HOSTCOL}%m%F{default}"

# Set the EDITOR.
if [ -n "${INSIDE_EMACS+1}" ]; then
    EDITOR="emacsclient"
else
    if command -v nvim > /dev/null; then
        EDITOR=nvim
        alias vim=nvim
    else
        EDITOR=vim
    fi
fi

# Finally, if inside Emacs, make sure we can log in using TRAMP by setting a
# simple to parse prompt.
[ "${TERM}" = "dumb" ] && export PS1="$ " && return
