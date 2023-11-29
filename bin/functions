#!/usr/bin/env bash

#
# Set of utility functions used by Mendes and carried over from project to
# project.
#

BLUE='\033[1;34m'
GREEN='\033[1;32m'
RED='\033[1;91m'
BLUE_NB='\033[0;34m'
GREEN_NB='\033[0;32m'
RED_NB='\033[0;91m'
RESET='\033[0m'

# pretty print

pp() {
  printf "\n$1[$2]: $3${RESET}\n"
}

pp_info() {
  pp $BLUE "$1" "$2"
}

pp_success() {
  pp $GREEN "$1" "$2"
}

pp_error() {
  pp $RED "$1" "$2"
}

# print text

pt() {
  printf "\n$1$2${RESET}\n"
}

pt_info() {
  pt $BLUE_NB "$1"
}

pt_error() {
  pt $RED_NB "$1"
}

not_installed() {
  [ ! -x "$(command -v "$@")" ]
}

installed() {
  [ -x "$(command -v "$@")" ]
}

ensure_confirmation() {
  read -p "Please confirm you want to continue [y/n] (default: y) " confirmation
  confirmation=${confirmation:-"y"}

  if [ "$confirmation" != "y" ]; then
    exit 1
  fi
}

read_var() {
  read -p "$1 " result

  echo "$result"
}

replace_env_var(){
  env_var=$1
  env_value=$2
  env_file=${3:-".envrc"}
  os=$(get_os)

  if [[ "$os" == "mac" ]] && installed "gsed"; then
    sed_version="gsed"
  elif [[ "$os" == "linux" ]]; then
    sed_version="sed"
  else
    return 1
  fi

  $sed_version -i "s/\($env_var=\).*$/\1${env_value//\//\/}/g" $env_file
}

is_env_var_set() {
  env_var="$1"
  envrc=${2:-".envrc"}

  [ -f $envrc ] && grep -q "$env_var=..*" $envrc
}

prompt_and_set_env_var() {
  env_var="$1"
  envrc=${2:-".envrc"}

  env_value=$(read_var "Please input the value of $env_var:")

  replace_env_var "$env_var" "$env_value" $envrc

  if [ $? -eq 1 ]; then
    pt_error "Can't set $env_var in .envrc, you'll have to add this value manually: $env_value"
  fi
}

get_os() {
  result="$(uname -s)"

  case "$result" in
    Linux*)     os=linux;;
    Darwin*)    os=mac;;
    *)          os=unknown
  esac

  echo "$os"
}
