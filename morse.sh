#!/bin/bash

# Author: 1929196
# Created: 17.01.2022

<< comment
--------------------------------------------------------------------
Problem Statement:

Write a bash script to remove c comments from given c file i.e. 
the script should accept a filename as argument and it should remove 
both single line and multi lines comments from the given file content 
and print the output in stdout.

--------------------------------------------------------------------
How to execute:

To convert text to morse code:
$ ./2.sh fileName.c

--------------------------------------------------------------------
Algorithm:

The idea is to maintain two flag variables, one to indicate that a single line comment is started,
another to indicate that a multiline comment is started. When a flag is set,
we look for the end of comment and ignore all characters between start and end.

--------------------------------------------------------------------
comment

# Check given file exists
program=`echo $0|sed -e 's:.*/::'`
if [ "$#" = 1 ] && [ "$1" != "-" ] && [ ! -f "$1" ]
then
        printf "$program: $1 does not exist\n"
        exit 2
fi

prgm=`cat $1` #storing file content to a variable

n=${#prgm} #number of characters in the file
res=''

#Flags to indicate that single line and multiple line comments have started or not.
s_cmt="false"
m_cmt="false"

#Traverse the given program
for (( i=0; i<$n; i++ ))
do
	if [[ "$s_cmt" == "false" && "$m_cmt" == "false" && "${prgm:$i:6}" == "printf" ]]
	then
		while [[ "${prgm:$i:1}" != ';' ]]
		do
			res=$res${prgm:$i:1}
			((i++))
		done
	fi
	
	if [[ "$s_cmt" == "true" && "${prgm:$i:1}" == $'\n' ]] #If single line comment flag is on, then check for end of it
	then
		s_cmt="false"
	elif [[ "$m_cmt" == "true" && "${prgm:$i:1}" == '*' && "${prgm:$((i+1)):1}" == '/' && $i -lt $(( n-1 )) && "${prgm:$((i+2)):1}" != '/' ]] #If multiple line comment is on, then check for end of it
	then
		m_cmt="false"
		((i++))
	elif [[ "$s_cmt" == "true" || "$m_cmt" == "true" ]] #If this character is in a comment, ignore it
	then
		continue
	elif [[ "${prgm:$i:1}" == '/' && "${prgm:$((i+1)):1}" == '/' ]] #Check for beginning of comments and set the appropriate flags
	then
		s_cmt="true"
		((i++))
	elif [[ "${prgm:$i:1}" == '/' && "${prgm:$((i+1)):1}" == '*' ]] #Check for beginning of comments and set the appropriate flags
	then
		m_cmt="true"
		((i++))
	else
		res=$res${prgm:$i:1} #If current character is a non-comment character, append it to res
	fi
done

echo "$res"
