#!/bin/bash

#########################################
###       Bash script location        ###
#########################################

realpath() {
  OURPWD=$PWD
  cd "$(dirname "$1")"
  LINK=$(readlink "$(basename "$1")")
  while [ "$LINK" ]; do
    cd "$(dirname "$LINK")"
    LINK=$(readlink "$(basename "$1")")
  done
  REALPATH="$PWD/$(basename "$1")"
  cd "$OURPWD"
  echo "$REALPATH"
}

# current script command line call
#Work for GNU Linux and BSD and MacOSX
scriptCall="$(realpath "${BASH_SOURCE[0]}")"
scriptDir=$(dirname "$scriptCall")
scriptName=$(basename "$scriptCall")

#########################################
vaultPasswordFile=$scriptDir/.vault_password

if [ ! -f "$vaultPasswordFile" ]; then
    read -s -p "Vault Password: " vaultPassword
    echo $vaultPassword > $vaultPasswordFile
fi
