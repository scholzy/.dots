#!/usr/bin/env zsh

# Configuration folder for zsh.
ZSH_CONFDIR="$HOME/.zsh"
[ -d "${ZSH_CONFDIR}" ] || mkdir "${ZSH_CONFDIR}"

# Install a nicer theme.
[ -d "${ZSH_CONFDIR}/powerlevel10k" ] || git clone https://github.com/romkatv/powerlevel10k "${ZSH_CONFDIR}/powerlevel10k"
[ -f "${ZSH_CONFDIR}/purepower.zsh" ] || curl -L https://raw.githubusercontent.com/romkatv/dotfiles-public/master/.purepower > "${ZSH_CONFDIR}/purepower.zsh"
source "${ZSH_CONFDIR}/powerlevel10k/powerlevel10k.zsh-theme"
source "${ZSH_CONFDIR}/purepower.zsh"
