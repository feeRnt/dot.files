#!/bin/bash

# A bash script to copy all of the dot files into their required
# directories.
# This assumes that all the dot files start with
# `comment-character`/absolute/path/to/config/file

# First make sure you are in the dot.files directory after cloning
# 1. cd `dot.files`
# then:

shopt -q extglob;
if [ "$?" == "1" ]; then #returns 1 if off
	_setoff=true
	shopt -s extglob
	#echo "Set extglob on"
fi

# for dot_files in "$(find !(.git|.gitignore|populate_dots*) \( -type f \) |\
find !(.git|.gitignore|populate_dots*) \( -type f \) |\
	while read -r dot_file;
 do
	dot_file_name="$(sed 's/.*\///' <<< "$dot_file")"
	dot_file_path="$(sed -n '1s/^.//p' "$dot_file")"
	dot_file_path="$(eval echo "$dot_file_path")";
	#echo "dot_file_trimmed is "$dot_file_trimmed""
	#echo -e "Current dot_file is $dot_file \n"
	echo "Copying "$dot_file_name" to "$dot_file_path"";
	cp -i "$dot_file" "$dot_file_path" < /dev/tty
done

if [ "$_setoff" == "true" ]; then
	shopt -u extglob
	#echo "Set extglob off"
	unset _setoff;
fi
# This part is unnecessary as it's running in a subshell,
# but kept in case someone wants to incorporate it in some main shell.
