#!/bin/bash

# Symlink all the githooks.
# ln -s :: create symbolic link
# ln -v :: verbose mode- print detail
# ln -f :: overwrite target file if it exists

GITDIR="../.git/hooks"
CURDIR=$(basename "$PWD")

echo -e '\033[1;34m➡ Installing all the githooks...\033[0m'

if [[ $CURDIR != "hooks" ]]; then echo '\033[1;31m✘ You need to execute this command from the hooks/ directory\033[0m'
    exit 1
fi

# Create symlink for each githook into $GITDIR
for file in $(ls -A)
do 
	if [[ $file == "installhooks.sh" ]]; then 
		continue 
	elif [[ -x $file ]]; then 
		ln -svf "$PWD/$file" "$GITDIR"
    else 
		echo -e '\033[1;34m➡ Skipping' "$file" 'because you cannot execute it\033[0m'
    fi 
done 

echo -e '\033[1;32m✔︎ Githooks successfully installed...\033[0m'
