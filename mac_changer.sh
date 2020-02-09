#!/usr/bin/env bash
set -e
 
INTERFACE="en0"
 
function mac_add_delta() {
  local mac="0x${1//\:/}"
  local delta="$2"
  local new_mac="$(printf "%x" $((mac + delta)))"  # no 0x
  echo "${new_mac:0:2}:${new_mac:2:2}:${new_mac:4:2}:${new_mac:6:2}:${new_mac:8:2}:${new_mac:10:2}"
}
 
if [[ $1 == "-d" ]]; then
  DELTA="-1"
else
  DELTA="+1"
fi
 
MAC=$(ifconfig "$INTERFACE" | grep ether | tr -d ' \t' | cut -c 6-42)
NEW_MAC=$(mac_add_delta "$MAC" "$DELTA")
 
echo "$INTERFACE old mac: $MAC"
echo "$INTERFACE new mac: $NEW_MAC"
echo "Applying setting with sudo"
sudo ifconfig "$INTERFACE" ether "$NEW_MAC"