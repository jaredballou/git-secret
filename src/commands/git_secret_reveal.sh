#!/usr/bin/env bash


function reveal {

  OPTIND=1
  local homedir=""
  local passphrase=""
  local force=0

  while getopts "hfd:p:" opt; do
    case "$opt" in
      h) _show_manual_for "reveal";;

      f) force=1;;

      p) passphrase=$OPTARG;;

      d) homedir=$OPTARG;;
    esac
  done

  shift $((OPTIND-1))
  [ "$1" = "--" ] && shift

   _user_required

  local counter=0
  while read line; do
    # the parameters are: filename, force, homedir, passphrase
    _decrypt "$line" "1" "$force" "$homedir" "$passphrase"

    counter=$((counter+1))
  done < "$SECRETS_DIR_PATHS_MAPPING"

  echo "done. all $counter files are revealed."
}
