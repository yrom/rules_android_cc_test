#!/usr/bin/env sh
SCRIPT_PATH="$( cd "$(dirname "$0")" ; pwd -P )"

echo $SCRIPT_PATH
adb={adb}
$adb push $SCRIPT_PATH/{name} /data/local/tmp/{name}
$adb shell "/data/local/tmp/{name} $@; rm /data/local/tmp/{name}"