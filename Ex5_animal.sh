<<COMMENT
Exercise_5 - Write a shell script that displays “man”,”bear”,”pig”,”dog”,”cat”,and “sheep”
 on the screen with each appearing on a separate line. 
Try to do this in as few lines as possible.
COMMENT

#!/bin/bash

for i in man bear pig dog cat sheep;
do
	echo $i
done

ANIMALS="Man bear pig dog cat sheep"

for animal in $ANIMALS
do
       echo $animal
done
