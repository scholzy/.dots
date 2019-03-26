#!/usr/bin/env zsh

# Configuration folder for zsh.
ZSH_CONFDIR="$HOME/.zsh"
[ -d "${ZSH_CONFDIR}" ] || mkdir "${ZSH_CONFDIR}"

# Check if on the spartan HPC cluster.
[[ "$(hostname)" =~ spartan.+ ]] && export SPARTAN=1

# Load up conda if not on spartan.
[ ! -n "${SPARTAN+1}" ] && source /Users/mscholz/.miniconda3/etc/profile.d/conda.sh

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

# Make it faster and easier to background/foreground vim.
fancy-ctrl-z () {
  if [[ $#BUFFER -eq 0 ]]; then
    BUFFER="fg"
    zle accept-line
  else
    zle push-input
    zle clear-screen
  fi
}
zle -N fancy-ctrl-z
bindkey '^Z' fancy-ctrl-z

# Use a menu-style completion interface.
fpath=(/usr/local/share/zsh-completions $fpath)
autoload -Uz compinit
compinit

zstyle ':completion:*' menu select

# Autocompletion for scp from remote computers.
if [ "x$CASE_SENSITIVE" = "xtrue" ]; then
  zstyle ':completion:*' matcher-list 'r:|[._-]=* r:|=*' 'l:|=* r:|=*'
  unset CASE_SENSITIVE
else
  zstyle ':completion:*' matcher-list 'm:{a-zA-Z}={A-Za-z}' 'r:|[._-]=* r:|=*' '
l:|=* r:|=*'
fi

# Save a better history.
if [ -z $HISTFILE ]; then
    HISTFILE=$HOME/.zsh_history
fi
HISTSIZE=100000
SAVEHIST=100000
HISTCONTROL=ignoredups

setopt append_history
setopt extended_history
setopt hist_expire_dups_first
setopt hist_ignore_dups
setopt hist_ignore_space
setopt hist_verify
setopt inc_append_history

# Finally, if inside Emacs and using TRAMP, make sure we can log in using TRAMP
# by setting a simple to parse prompt.
[ "${TERM}" = "dumb" ] && [ -n "${SSH_TTY+1}" ] && export PS1="%4~ $ " && return
