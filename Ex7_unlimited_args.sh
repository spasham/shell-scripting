<<COMMENT
Exercise_6 - write a shell script that prompts the user for a name of a file or directory and reports if it is a regular file, a directory, or another type of file. 
Also perform an ls command against the file or directory with the long listing option.
COMMENT

#!/bin/bash


#echo "Enter a file path:"

file=$@

for arg in $file
  do
	if [ -e $arg ]
	then
		echo "$arg exists"
		ls -lrth $arg
			if [ -f $arg ]
			then
				echo "$arg is regular file"
			elif [ -d $arg ]
			then
				echo "$arg is a directory file"
			else
				echo "cannot determine the type of file"
			fi
	else
		echo "$arg doesn't exists"
	fi
  done
