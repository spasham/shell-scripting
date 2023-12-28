<<COMMENT
Exercise_6 - write a shell script that prompts the user for a name of a file or directory and reports if it is a regular file, a directory, or another type of file. 
Also perform an ls command against the file or directory with the long listing option.
COMMENT

#!/bin/bash


#echo "Enter a file path:"

 file=$1


if [ -e $file ]
then
	echo "$file exists"

		if [ -f $file ]
		then
			echo "$file is a regular file"

		elif [ -d $file ]
		then
			echo "$file is a directory file"
		elif [ -b $file ]
		then
			echo "$file is a block file"
		elif [ -c $file ]
		then
			echo "$file is a character file"
		elif [ -h $file ]
		then
			echo "$file is a link file"
		else
			echo "Cannot determine the type of file"
		fi
else
	echo "$file doesn't exist"
fi

ls -lrth $file
