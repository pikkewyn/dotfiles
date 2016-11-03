# If not running interactively, don't do anything
[[ $- != *i* ]] && return

alias gcc='gcc -Wall --pedantic --std=gnu11'
alias g++='g++ -Wall --pedantic -std=c++11'
alias clang='clang -Weverything'
alias valgrind='valgrind --leak-check=full --show-reachable=yes'
alias ls='ls -p --color=auto'
alias grep='grep --color=auto -I --exclude-dir=.svn'
alias cp='cp -i'
alias astyle='astyle --indent=spaces=4 \
--style=allman --pad-oper --unpad-paren \
--pad-paren-in --align-pointer=type \
--add-brackets --break-blocks  --convert-tabs \
--indent-cases --delete-empty-lines'

alias rm='rm -i'
alias tree='tree -C'
function myip () { curl http://ipecho.net/plain; echo; }
#function man () { man $1 } TODO: cppman
function gedit () { nohup gedit $1 2> /dev/null & }
function okular () { nohup okular $1 2> /dev/null & }
function geany () { nohup geany $1 &> /dev/null & }
function bp () { newname="${1}-$(date +%H%M%d%m%y).bak"; cp -r "${1}" $newname; chmod -Rw $newname; }
function notify()
{
  for (( i = 0; i < $#; ++i )); do
    echo -e "$1" | osd_cat -c red -l 8 -i 10 -o 10 -f -*-*-bold-*-*-*-42-120-*-*-*-*-*-*  -p bottom -A center -s 1
  done
}

#function translate () { echo "foo" > /dev/null } TODO: dictionary

set -o noclobber                 # Use >| operator to force the file to be overwritten

shopt -s histappend
shopt -s cdspell                 #Correct dir spellings
shopt -s nocaseglob
shopt -q -s checkwinsize         #make sure display get updated when terminal window get resized

bind 'set completion-ignore-case on'
bind 'set show-all-if-ambiguous on'

export EDITOR="vim"
export HISTCONTROL=ignoredups
export HISTIGNORE='ls:bg:fg:history'
export HISTFILESIZE=1000000
export HISTSIZE=1000000
export HISTTIMEFORMAT='%F %T '
export VAGRANT_HOME=/storage/.vagrant.d/

PS1="$(if [[ ${EUID} == 0 ]]; then echo '\[\e[0;31m\][\u@\h:\w ]#\[\e[m\] '; else echo '\[\e[0;32m\][\u@\h:\w ]$\[\e[m\] '; fi)"

PROMPT_COMMAND="history -a; $PROMPT_COMMAND"
eval $(keychain --eval --quiet id_rsa)

command_not_found_handle() {
    echo "Hello $1!"
 }



