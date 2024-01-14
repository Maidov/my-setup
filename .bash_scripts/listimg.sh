#!/bin/bash
 
result=$(( find . -type d -not -path '*/\.*' && find . -type f \( -iname '*.jpg' -o -iname '*.jpeg' -o -iname '*.png' -o -iname '*.gif' \) -not -path '*/\.*' ) | fzf)
sxiv -r -t "$result" &
