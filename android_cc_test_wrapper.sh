#!/usr/bin/env bash
set -e
SCRIPT_PATH="$( cd "$(dirname "$0")" ; pwd -P )"

#echo $SCRIPT_PATH
# the symlink to adb
adb=external/androidsdk/platform-tools/adb
while (( "$#" )); do
  if [[ "$1" == "--adb" ]]; then
    adb="$2"
    shift;shift;
  elif [[ "$1" == "--" ]]; then
    #end args
    shift
    break
  elif [[ -n "$1" ]]; then
    local_file=$1
    shift
  else
    shift
  fi
done
if [[ -z "$local_file" ]]; then
    echo "No local file for testing?" >&2
    exit 1
fi
APP_ARGS=("${@}")
echo ${APP_ARGS[@]}
if [[ -L "$local_file" ]]; then
    local_file=`readlink $local_file`
fi
file_name=`basename $local_file`
remote_file=/data/local/tmp/${file_name}


if [[ ! -x "$adb" ]]; then
    echo "The adb '$adb' is not executable!" >&2
    exit 1
fi
pwd
$adb push $local_file $remote_file
$adb shell "chmod a+x $remote_file; $remote_file ${APP_ARGS[@]}; rm ${remote_file}"