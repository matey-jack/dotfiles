# ~/.bashrc: executed by bash(1) for non-login shells.
# see /usr/share/doc/bash/examples/startup-files (in the package bash-doc)
# for examples

# If not running interactively, don't do anything
case $- in
    *i*) ;;
      *) return;;
esac

alias ack=ack-grep

# don't put duplicate lines or lines starting with space in the history.
# See bash(1) for more options
HISTCONTROL=ignoreboth

# append to the history file, don't overwrite it
shopt -s histappend

# for setting history length see HISTSIZE and HISTFILESIZE in bash(1)
HISTSIZE=1000
HISTFILESIZE=2000

# check the window size after each command and, if necessary,
# update the values of LINES and COLUMNS.
shopt -s checkwinsize

# If set, the pattern "**" used in a pathname expansion context will
# match all files and zero or more directories and subdirectories.
#shopt -s globstar

# make less more friendly for non-text input files, see lesspipe(1)
[ -x /usr/bin/lesspipe ] && eval "$(SHELL=/bin/sh lesspipe)"

# set variable identifying the chroot you work in (used in the prompt below)
if [ -z "${debian_chroot:-}" ] && [ -r /etc/debian_chroot ]; then
    debian_chroot=$(cat /etc/debian_chroot)
fi

# set a fancy prompt (non-color, unless we know we "want" color)
case "$TERM" in
    xterm-color) color_prompt=yes;;
esac

# uncomment for a colored prompt, if the terminal has the capability; turned
# off by default to not distract the user: the focus in a terminal window
# should be on the output of commands, not on the prompt
force_color_prompt=yes

if [ -n "$force_color_prompt" ]; then
    if [ -x /usr/bin/tput ] && tput setaf 1 >&/dev/null; then
	# We have color support; assume it's compliant with Ecma-48
	# (ISO/IEC-6429). (Lack of such support is extremely rare, and such
	# a case would tend to support setf rather than setaf.)
	color_prompt=yes
    else
	color_prompt=
    fi
fi

export GITAWAREPROMPT=~/.bash/git-aware-prompt
source "${GITAWAREPROMPT}/main.sh"

if [ "$color_prompt" = yes ]; then
    # PS1='\n${debian_chroot:+($debian_chroot)}\[\033[01;32m\]\u@\h\[\033[00m\]:\[\033[01;34m\]\w\[\033[00m\]\$ '
    PS1='\n\[\e[01;34m\]\w\[\e[00m\] \$ \[\e[1;35m\]'
    # Prompt for Git:
    PS1="\n\[$bldblu\]\w\[$txtrst\] \[$txtcyn\]\$git_branch\[$txtred\]\$git_dirty\[$txtrst\]\$ \[$bldpur\]"
    trap 'echo -ne "\e[0m"' DEBUG
else
    PS1='\n${debian_chroot:+($debian_chroot)}\u@\h:\w\$ '
fi
unset color_prompt force_color_prompt

# If this is an xterm set the title to user@host:dir
case "$TERM" in
xterm*|rxvt*)
    PS1="\[\e]0;${debian_chroot:+($debian_chroot)}\u@\h: \w\a\]$PS1"
    ;;
*)
    ;;
esac

# enable color support of ls and also add handy aliases
if [ -x /usr/bin/dircolors ]; then
    test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
    alias ls='ls --color=auto'
    #alias dir='dir --color=auto'
    #alias vdir='vdir --color=auto'

    alias grep='grep --color=auto'
    alias fgrep='fgrep --color=auto'
    alias egrep='egrep --color=auto'
fi

# some more ls aliases
alias ll='ls -alF'
alias la='ls -A'
alias l='ls -CF'
function idea() {
    XMODIFIERS="" ~/opt/idea-current/bin/idea.sh
}
alias ssx='ssh -X'
function go() {
    if [ -z $1 ]
    then
        ssh -X hamman01.rz.is
    else
        ssh -X $1.rz.is
    fi
}

function had() {
    BASE=/data/home/rwill/hadoop_conf/
    if [ -z $1 ]
    then
        echo "Current setting: " ${HADOOP_CONF_DIR#$BASE}
        echo "Possible settings: " `ls ${BASE}`
    else
        if [ -d ${BASE}$1 ]
        then
            HADOOP_CONF_DIR=${BASE}$1
            echo HADOOP_CONF_DIR=$HADOOP_CONF_DIR
        else
            echo "Setting not found: " $1
            echo "Possible settings: " `ls ${BASE}`
        fi
    fi
}

function print-pdf() {
    pdftops -paper A4 "$1" /dev/stdout | netcat c5235-02.iscout.local. 9100
}
alias rsync2='rsync -av -e "ssh -A hamman01 ssh -o BatchMode=yes -o StrictHostKeyChecking=no -o UserKnownHostsFile=/dev/null -q"'

# Add an "alert" alias for long running commands.  Use like so:
#   sleep 10; alert
alias alert='notify-send --urgency=low -i "$([ $? = 0 ] && echo terminal || echo error)" "$(history|tail -n1|sed -e '\''s/^\s*[0-9]\+\s*//;s/[;&|]\s*alert$//'\'')"'

# Alias definitions.
# You may want to put all your additions into a separate file like
# ~/.bash_aliases, instead of adding them here directly.
# See /usr/share/doc/bash-doc/examples in the bash-doc package.

if [ -f ~/.bash_aliases ]; then
    . ~/.bash_aliases
fi

# enable programmable completion features (you don't need to enable
# this, if it's already enabled in /etc/bash.bashrc and /etc/profile
# sources /etc/bash.bashrc).
if ! shopt -oq posix; then
  if [ -f /usr/share/bash-completion/bash_completion ]; then
    . /usr/share/bash-completion/bash_completion
  elif [ -f /etc/bash_completion ]; then
    . /etc/bash_completion
  fi
fi

# .profile doesn't get loaded....
export JDK_HOME=/usr/lib/jvm/java-8-oracle
export JAVA_HOME=/usr/lib/jvm/java-8-oracle
export IDEA_HOME=/data/home/rwill/idea-IU-141.178.9
export JBOSS_HOME=/data/home/rwill/opt/jbossesb-server-4.7_hsql
export GRADLE_HOME=/data/home/rwill/opt/gradle-2.2.1

# Hadoop + Spark
export HADOOP_CONF_DIR=/data/home/rwill/hadoop_conf/tuv
export MASTER=yarn-client
alias '+fs'='hadoop fs'
function sparkshell() {
    gnome-terminal -e "tail -f $HOME/spark.log"
    ~/opt/spark-1.5.1-bin-hadoop2.6/bin/spark-shell
}

export LC_CTYPE=en_US.UTF-8

alias mvnts='mvn -Dmaven.test.skip=true'
export PATH=~/opt/node-v4.2.2-linux-x64/bin/:~/bin:$GRADLE_HOME/bin:~/opt/hadoop-2.7.0/bin:$PATH
export JBOSS_HOME=/data/home/rwill/opt/jbossesb-server-4.7_hsql
export JBOSS_CONF=default
# mehr Speicher für Maven
export MAVEN_OPTS="-Xmx1024M"
export HISTTIMEFORMAT="%d/%m/%y %T "
export HISTSIZE=10000


function anaconda(){
    export PATH="/data/home/rwill/opt/anaconda/bin:$PATH"
}
export IBUS_ENABLE_SYNC_MODE=1

function fetch_datawario() {
    cd ~/tmp 
    rm -r datawario-0.1/
    tar xzvf ~/ss/datawario/target/datawario-0.1-bundle.tar.gz 
    source datawario-0.1/bin/bash_shortcuts
}

function dev_datawario() {
    cd ~/tmp/datawario-0.1/bin 
    rm bash_shortcuts 
    ln -s ~/ss/datawario/src/main/bash/bash_shortcuts.sh bash_shortcuts
}

# test "$(afp_minutes_left)" == EXPIRED && echo 'Es ist aus!'
alias sql-bench=~/opt/sql-workbench/sqlworkbench.sh

