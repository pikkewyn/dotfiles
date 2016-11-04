# If not running interactively, don't do anything
[[ $- != *i* ]] && return

alias pm-suspend='killall skype; slock & sudo pm-suspend'
alias gcc='gcc -Wall --pedantic --std=gnu11'
alias g++='g++ -Wall --pedantic -std=c++11'
alias clang='clang -Weverything'
#alias chromium='chromium --proxy-server="192.168.144.37:8080"'
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
alias now='date "+%d-%m-%y"'

function myip () { curl http://ipecho.net/plain; echo; }
#function man () { man $1 } TODO: cppman
function gedit () { nohup gedit $1 2> /dev/null & }
function okular () { nohup okular $1 2> /dev/null & }
function geany () { nohup geany $1 &> /dev/null & }

function notify()
{
  for (( i = 0; i < $#; ++i )); do
    echo -e "$1" | osd_cat -c red -l 8 -i 10 -o 10 -f -*-*-bold-*-*-*-42-120-*-*-*-*-*-*  -p bottom -A center -s 1
  done
}

function man() {
    env LESS_TERMCAP_mb=$'\E[01;31m' \
    LESS_TERMCAP_md=$'\E[01;38;5;74m' \
    LESS_TERMCAP_me=$'\E[0m' \
    LESS_TERMCAP_se=$'\E[0m' \
    LESS_TERMCAP_so=$'\E[38;5;246m' \
    LESS_TERMCAP_ue=$'\E[0m' \
    LESS_TERMCAP_us=$'\E[04;38;5;146m' \
    man "$@"
}

function bcp () {
    if [[ "${1}" == "-r" && $# -eq 2 ]]; then
        local originname="${2}"
    fi

    local newname="${1}-$(date +%H%M%d%m%y).bak"
    cp -r "${1}" "$newname";
    chmod -w "$newname";
}

function okular () { nohup okular "$1" &>/dev/null & }

function kill_bridge () {
    #local pid=$(ps aux | grep -Po '(?<=[a-z+]  )[0-9]+(?= )(?=.*?1080 bridge)(?!.*?grep)') #TODO: multiple spaces before pid
    local pid=$(ps aux | grep -Po '^[a-z+ ]*\K([0-9]+)(?= )(?=.*?1080 bridge)(?!.*?grep)')

    if [[ ! -z "$pid" ]]; then
        echo "Reset bridge"
        kill -9 $pid
    else
        echo "No bridge available"
    fi
}

function ack () {
    /bin/grep -Rn --color --include=\*.{h,hpp,c,cc,cpp} "$@"
}

function bridge () {
    kill_bridge
    ssh -f -N -D 1080 bridge 2> /dev/null
    ( [[ $? -eq 0 ]] && echo "OK" ) || echo "FAIL"
}

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
export CDPATH=:/home/jcerkaski/development
export PATH="${PATH}:/opt/gcc-arm-none-eabi-4_8-2014q2/bin/"

PS1="$(if [[ ${EUID} == 0 ]]; then echo '\[\e[0;31m\][\u@\h:\w ]#\[\e[m\] '; else echo '\[\e[0;32m\][\u@\h:\w ]$\[\e[m\] '; fi)"

PROMPT_COMMAND="history -a; $PROMPT_COMMAND"
eval $(keychain --eval --quiet id_rsa)

command_not_found_handle() {
    echo "Hello $1!"
 }

#git config --global https.proxy 'socks5://127.0.0.1:7070'
#git init
#git remote add origin PATH/TO/REPO
#git fetch
#git checkout -t origin/master
