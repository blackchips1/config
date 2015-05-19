#!/bin/zsh
# The following lines were added by compinstall

# LIST_ROWS_FIRST
#line 5821/16269

# autocompletion
zstyle ':completion:*' completer _expand _complete _ignored _correct _approximate
zstyle ':completion:*:match:*' original only
zstyle ':completion:*' ignore-parents parent
zstyle ':completion:*' matcher-list 'm:{[:lower:]}={[:upper:]} r:|[._-]=** r:|=**' '' '' 'm:{[:lower:][:upper:]}={[:upper:][:lower:]}'
zstyle :compinstall filename '/home/campre_d/.zshrc'
zstyle ':completion::complete:*' use-cache 1


# Autocompletion miscs

zstyle ':completion:*:rm:*' ignore-line yes
zstyle ':completion:*:mv:*' ignore-line yes
zstyle ':completion:*:cp:*' ignore-line yes


#autocompletion des pids
zstyle ':completion:*:*:kill:*' menu yes select
zstyle ':completion:*:kill:*' force-list always


autoload -Uz compinit
compinit
# End of lines added by compinstall
# Lines configured by zsh-newuser-install

#diverses trucs d'historique
# histoire de ne pas avoir de truc dupique dans k'historique et plein d'autres choses
HISTFILE=~/.histfile
HISTSIZE=1000
SAVEHIST=1000
setopt appendhistory notify
setopt append_history
setopt inc_append_history
setopt extended_history
setopt hist_find_no_dups
setopt hist_ignore_all_dups
setopt hist_reduce_blanks
setopt hist_ignore_space
setopt hist_no_store
setopt hist_no_functions
setopt no_hist_beep
setopt hist_save_no_dups
setopt HIST_REDUCE_BLANKS
setopt HIST_IGNORE_SPACE


#??? regarder ce que c'est
export LISTMAX=-100

#met les executables par defaukt
export PAGER=less
export EDITOR="emacs"
export BROWSER="links"

#pour ne pas avoir a faire ./a.out mais juste a.out
export PATH=$PATH:./

#regarder ce que ca fait
bindkey -e

#???
eval `dircolors -b`


#ajouter la d'autres fichiers a ouvrir par defaut avec tel ou tel type de logiciel
alias -s tex="emacs"
alias -s html="emacs"
alias -s org="emacs"
alias -s "*[Mm]akefile"="emacs"
alias -s c="emacs"
alias -s h="emacs"
alias -s pdf="emacs"

#si on met un nom de dossier y va imediatement
setopt autocd


#au lieu de me taper un > ...
alias -g W=' | wc -l'
alias -g L=' | less'
alias -g N='2&>/dev/null'

#modifier le layout keyboard
alias fr="setxkbmap fr"
alias en="setxkbmap us"

#pour eviter les fautes de frappe
alias amek="make"
alias ake="make"
alias amke="make"
alias maek="make"
alias mak="make"
alias wpd="pwd"
alias sl="ls"
alias s="ls"
alias l="ls"
alias ks="ls"
alias fgfg="fg"

# alias biens utiles
alias j="jobs"
alias emacs="emacs"
alias ne="emacs"
alias new="emacs"
alias ls="ls -l"
alias ll="ls -loh --color -B --file-type"
alias la="ls -A -B --file-type"
alias ls="ls --color --file-type"
alias less="less -Q"
alias source="source ~/.zshrc"
alias grep="grep --color"
alias mkdir="mkdir -p"

#quand on fait * o au lieu de *.o : un petit warning
setopt RM_STAR_WAIT



#permet d'utiliser les executables dans le dossier courant

# THE PROMPT
autoload colors; colors # pour avoir des couleurs
export PS1="%{$bg[black]%}% %{$fg[white]%}%B%b"
export PS2="%{$fg[blue]%}$ >%{$reset_color%}"

# prompt a droite
export RPS1="%{$fg[green]%}%(4~_%-1~/.../%2~_%~)%{$reset_color%} %B[ %{$fg[red]%}%W %{$fg[cyan]%}:%{$fg[yellow]%}%t%{$fg[white]%} ]%b%(0?.. %{$bg[cyan]%}%{$fg[red]%}%?)%{$reset_color%}"
export RPS2="%{$reset_color%}"


#defini les mots
export WORDCHARS='qwertyuiopasdfghjklzxcvbnmQWERTYUIOPASDFGHJKLZXCVBNM1234567890'
export SHELL='/bin/zsh'

#liste de bindkey (pour faire comme emacs
bindkey '^[[1;5D' emacs-backward-word
bindkey '^[[1;5C' emacs-forward-word

bindkey '^[[1;5A' history-search-backward
bindkey '^[[1;5B' history-search-forward

bindkey '\e[3~' delete-char
bindkey "^[[3;5~" delete-word
bindkey '^[[H' beginning-of-line # Home
bindkey '^[[F' end-of-line # End
bindkey -s "^[[15~" "make\n"
bindkey -s "^[[17~" "clear; make re\n"




# Tetris

autoload -U tetris
zle -N tetris
bindkey -s "^[[18~" "tetris\n"




##
##
## FUNCTIONS
##
##

#extrait les programmes
function ex()      # Handy Extract Program.
{
    if [ -f $1 ] ; then
	case $1 in
	    *.tar.bz2)   tar xvjf $1     ;;
            *.tar.gz)    tar xvzf $1     ;;
	    *.bz2)       bunzip2 $1      ;;
	    *.rar)       unrar x $1      ;;
	    *.gz)        gunzip $1       ;;
	    *.tar)       tar xvf $1      ;;
	    *.tbz2)      tar xvjf $1     ;;
	    *.tgz)       tar xvzf $1     ;;
	    *.zip)       unzip $1        ;;
	    *.Z)         uncompress $1   ;;
	    *.7z)        p7zip -d $1     ;;
	    *)           echo "'$1' cannot be extracted via >extract<" ;;
	esac
    else
	echo "'$1' is not a valid file"
    fi
}


#affiche le nom du dossier sur la fenetre du terminal
chpwd() {
    [[ -o interactive ]] || return
    case $TERM in
	sun-cmd) print -Pn "\e]1%~\e\\"
	    ;;
	*zterm*|rxtv|(x|dt|k|E)term) print -Pn "\e]2;%~\a"
	;;
    esac
}


#TODO

export TIMEFMT="%J
	user:%*U kernel:%*S CPU:%P total:%*Es"




##
## les trucs qui sont passe a chaque changement
##
##
rm -f ~/.lesshst
rm -rf ./portraits/

# pour mon fichier test.c
rm -f ~/a.out
rm -f ~/test.c
echo -e "int\t\tmain(int ac, char **av)\n{\n  return (0);\n}" > ~/test.c

emacs --daemon

# pour finir
clear

# coproc while read line; do
# print '\e[91m'${(q)line}'\e[0m' > /dev/tty
# print -n $'\0'
# done


#ignore file completion
fignore=(.o .s .i .ii .s \~ \#)