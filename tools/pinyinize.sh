#!/bin/bash

# requires: pypinyin


# Minecraft language file
MinecraftLangFile="tw.txt"

# Output. Use "BOPOMOFO" for Zhuyin, 

# Edit the original JSON file using jq
# jq '.key = "new value"' $MinecraftLangFile > tmp.$$.json && mv tmp.$$.json $MinecraftLangFile

# Process each line
function Process {
echo "\"$key\": \"$value\""
Pinyin=$(echo $value | pypinyin)
echo "Pinyin: $Pinyin"
}

# Read file line by line and process it
while read -r line; do
  key=$(echo $line | sed 's/.*"\([^"]*\)":.*/\1/')
  value=$(echo $line | sed 's/.*"\([^"]*\)": *"\([^"]*\)".*/\2/')
  Process $key $value
done <  $MinecraftLangFile

exit
while read -r line; do
  Process "$line"
done < <(jq -r 'values[]' $MinecraftLangFile)


exit

pypinyin
