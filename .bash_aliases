#!/usr/bin/env bash

function server() {
  local port="${1:-8000}"
  python -m SimpleHTTPServer "$port"
}

function open_file() {
   local file_name="$1"
   echo "Opening: $file_name"
   xdg-open "$file_name"
}

function lazygit() {
   local message="$1"
   local push_branch="${2:-$(git rev-parse --abbrev-ref HEAD)}"
   echo "Commit Message: $message"
   echo "Push Branch: ${push_branch}"
   git add --all
   git commit -m "$message"
   git push origin "$push_branch"
}

function clone() {
   local url="$1"
   echo "Cloning: $url"
   git clone "$url"
}

function delete_branch() {
   local branch_name="$1"
   echo "Deleting Branch: $branch_name"
   git push origin --delete "$branch_name"
}

function up() {
  times=$1
  while [ "$times" -gt "0" ]; do
    cd ..
    times=$(($times - 1))
  done
}

function countdown() {
   total=$1
   for ((i=total; i>0; i--)); do sleep 1; printf "Time remaining $i secs \r"; done
   echo -e "\a"
}

function extract () {
  if [ -f $1 ] ; then
    case $1 in
      *.tar.bz2)   tar xvjf $1    ;;
      *.tar.gz)    tar xvzf $1    ;;
      *.tar.xz)    tar Jxvf $1    ;;
      *.bz2)       bunzip2 $1     ;;
      *.rar)       rar x $1       ;;
      *.gz)        gunzip $1      ;;
      *.tar)       tar xvf $1     ;;
      *.tbz2)      tar xvjf $1    ;;
      *.tgz)       tar xvzf $1    ;;
      *.zip)       unzip -d `echo $1 | sed 's/\(.*\)\.zip/\1/'` $1;;
      *.Z)         uncompress $1  ;;
      *.7z)        7z x $1        ;;
      *)           echo "don't know how to extract '$1'" ;;
    esac
  else
    echo "'$1' is not a valid file!"
  fi
}

function compile() { 
    local object_name="$1"
    local file_name="$2"
    g++ -o "$object_name" "$file_name"
}

function compile11() {
    local object_name="$1"
    local file_name="$2"
    g++ -o "$object_name" "$file_name" --std=c++11
}

function compile14() {
    local object_name="$1"
    local file_name="$2"
    g++ -o "$object_name" "$file_name" --std=c++14
}

# alias vlead-emacs="cd ~/Projects/vlabs/emacs && make -k run"

# To start Simple Python Server
alias server=server

# IP addresses
alias publicip="curl http://ipecho.net/plain; echo"
alias localip="ifconfig | grep -Eo 'inet (addr:)?([0-9]*\.){3}[0-9]*' | grep -Eo '([0-9]*\.){3}[0-9]*' | grep -v '127.0.0.1'"

# To know the weather
alias weather="curl -s "wttr.in/$1?m1""

# Timer
alias countdown=countdown

# To go to any directory level
alias up=up

# Permission before deleting
alias rm="rm -i"

# For GIT Commands
alias lazygit=lazygit
alias delete_branch=delete_branch
alias st='git status'
alias ft='git fetch'
alias pull='git pull'
alias clone=clone

# To open any kind of file
alias f=open_file

# To extract any format of ZIP
alias extract=extract

# To compile with different versions of C++
alias compile=compile
alias c++11=compile11
alias c++14=compile14

# Updating and Upgrading Ubuntu
alias update='sudo apt-get update'
alias upgrade='sudo apt-get upgrade'
alias dist-upgrade='sudo apt-get dist-upgrade'
alias autoclean='sudo apt autoclean'
alias autoremove='sudo apt autoremove'
alias fullupdate='sudo apt-get update && sudo apt-get upgrade && sudo apt-get dist-upgrade'
alias fullclean='sudo apt autoclean && sudo apt autoremove'
alias fullupdateandclean='sudo apt-get update && sudo apt-get upgrade && sudo apt-get dist-upgrade && sudo apt autoclean && sudo apt autoremove'
