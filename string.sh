#!/bin/bash

# ASK USER FOR DIR TO SEARCH IN
echo "What directory do you want to search in?"
read -e strDIR

# ASK USER FOR INPUT AND SET TO VARIABLE FOR USE
echo "What string are you trying to search?"
read strINPUT

# GREP FOR USER SET VARIABLE IN DIR
strOUTPUT=$(grep --line-number --color=always -ri "$strINPUT" $strDIR 2>/dev/null)

# SHOW OUTPUT FROM GREP SEARCH
echo "$strOUTPUT"
