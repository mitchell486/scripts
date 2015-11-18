#!/bin/bash

# search in my user directory. should be the only one with
# any .git folders that need to have the status checked.

# damnit OnlineCop, you're too damn good.
results=$(find ~ -name \*.git 2>/dev/null | grep -oP '^(.*)(?=\/\.git$)' | while read line ; do pushd "$line"; git status; printf "\n"; popd; printf "\n"; done)

echo "

Your current git status is:
----------------------------

$results


Thanks!
"
