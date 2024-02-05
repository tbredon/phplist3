#!/usr/bin/env bash

from=$1
to=$2

[[ -z $from ]] || [[ ! -d $from ]] || [[ -z $to ]] || [[ ! -d $to ]] && exit;

echo $from $to

[[ -x $(which rsync) ]] || {
  apt install -y rsync
}

for plugin in $(find $from -type d -name phplist-plugin-*); do
  [[ ! -z "$(ls -A $plugin/plugins/)" ]] && {
    echo installing plugin $plugin
    rsync -a $plugin/plugins/* $to
  }
done
