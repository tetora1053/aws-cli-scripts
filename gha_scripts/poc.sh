#!/bin/bash

echo "---------------------------------------------------------------------list.txt-------------------------------------------------------------------"
cat list.txt

echo "---------------------------------------------------------------------poc.yml--------------------------------------------------------------------"
cat poc.yml

echo "---------------------------------------------------------------------stopped--------------------------------------------------------------------"


echo "---------------------------------------------------------------------loop!!!--------------------------------------------------------------------"
while read -r line; do
  echo "line: $line"
  if [[ $line =~ ([0-9]{4}-[0-9]{2}-[0-9]{2}) ]]; then
    extracted_date="${BASH_REMATCH[1]}"
    formatted_date=$(date -d "$extracted_date" +"%Y/%m/%d")

    if [[ $(date -d "$formatted_date" +%s) -lt $(date -d "-30 days" +%s) ]]; then
      echo "hello world"
    else
      echo "skip"
    fi
  fi
done < list.txt