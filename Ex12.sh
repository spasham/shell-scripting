#! /bin/bash

<<Comment
Exercise_12 - Write a shell script that consists of a function that displays the number of files in the present working directory.
Name this function “file_count” and call it in your script. If you use variable in your function, remember to make it a local variable.
Comment


file_count() {

local_var=$(ls -lrth |wc -l)
echo $local_var
}

echo -n "Total number of files are:"
file_count

