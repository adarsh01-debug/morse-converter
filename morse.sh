#!/bin/bash

# Author: 1929196
# Created: 17.01.2022

<< comment
--------------------------------------------------------------------
Problem Statement:

Write a morse code converter using bash. Bash script should accept a file as argument.
- if the file name ends with .morse, it should convert morse code into text.
- if the file name ends with .txt, it should convert text into morse code.

--------------------------------------------------------------------
Convention for morse:

Single space in morse - character change
Multiple spaces (tab character) - word change/line change

--------------------------------------------------------------------
How to execute:

To convert text to morse code:
$ ./1.sh fileName.txt

To convert morse code to text:
$ ./1.sh fileName.morse

--------------------------------------------------------------------
Algorithm:

STEP 1:
Declare 2 associative arrays, i.e, morse and letters. Morse array will have letters/numbers as keys and their equivalent morse code as value. Letters array will have morse codes as keys and equivalent letters/numbers as value.

STEP 2:
Take the argument from command line and check its validity, i.e., if file exists or not. If file does exists then check for its extention type, i.e., whether it is a txt or morse file.

STEP 3:
Call txt_to_morse function with the file itself as the parameter if the file is of text type.
Call morse_to_txt function with the file itself as the parameter if the file is of morse type.

STEP 4:
In txt_to_morse:
-Read the file content line by line and convert each character to its equivalent morse code from refering to the morse array.
-If we encounter space of new line then replace it by tab character.

In morse_to_txt:
-Read the file content line by line and if the character equals . or - then append it to an initially empty string str1.
-Keep on appending until we encounter new line character or tab character, in which case we will print the str1 and make str1 empty again.

--------------------------------------------------------------------
comment

# ==================================================================
# Associative array (hash table) to store morse values of letters
# ==================================================================
declare -A morse
morse[A]='.-'
morse[B]='-...'
morse[C]='-.-.'
morse[D]='-..'
morse[E]='.'
morse[F]='..-.'
morse[G]='--.'
morse[H]='....'
morse[I]='..'
morse[J]='.---'
morse[K]='-.-'
morse[L]='.-..'
morse[M]='--'
morse[N]='-.'
morse[O]='---'
morse[P]='.--.'
morse[Q]='--.-'
morse[R]='.-.'
morse[S]='...'
morse[T]='-'
morse[U]='..-'
morse[V]='...-'
morse[W]='.--'
morse[X]='-..-'
morse[Y]='-.--'
morse[Z]='--..'
morse[0]='-----'
morse[1]='.----'
morse[2]='..---'
morse[3]='...--'
morse[4]='....-'
morse[5]='.....'
morse[6]='-....'
morse[7]='--...'
morse[8]='---..'
morse[9]='----.'
morse[.]='.-.-.-'
morse[,]='--..--'
morse[?]='..__..'
morse[=]='-...-'

# ==================================================================
# Associative array (hash table) to store letter values of morse codes
# ==================================================================

declare -A letter
letter[.-]='A'
letter[-...]='B'
letter[-.-.]='C'
letter[-..]='D'
letter[.]='E'
letter[..-.]='F'
letter[--.]='G'
letter[....]='H'
letter[..]='I'
letter[.---]='J'
letter[-.-]='K'
letter[.-..]='L'
letter[--]='M'
letter[-.]='N'
letter[---]='O'
letter[.--.]='P'
letter[--.-]='Q'
letter[.-.]='R'
letter[...]='S'
letter[-]='T'
letter[..-]='U'
letter[...-]='V'
letter[.--]='W'
letter[-..-]='X'
letter[-.--]='Y'
letter[--..]='Z'
letter[-----]='0'
letter[.----]='1'
letter[..---]='2'
letter[...--]='3'
letter[....-]='4'
letter[.....]='5'
letter[-....]='6'
letter[--...]='7'
letter[---..]='8'
letter[----.]='9'
letter[.-.-.-]='.'
letter[--..--]=','
letter[..--..]='?'
letter[-...-]='='

# ==================================================================

# custom function to convert morse code to text
function morse_to_txt()
{
	echo -e "Your morse code to text is : \n"
	str1='' #initial empty string to form proper morse code
    	while IFS= read -rN1 c #to read each line in the file character by character
    	do
		if [[ "$c" == '.' || "$c" == "-" ]]
		then
			str1=$str1$c #concatinating . and -
		elif [[ "$c" == $'\n' || "$c" == $'\t' ]]
		then
			printf " " #replacing \n and \t with an empty space
		else	
			if [[ "$str1" != '' ]]
			then
				printf '%s' "${letter[$str1]}" #printing letter if single space or anyting else is encountered
				str1='' #making string empty again for next letter
			fi
		fi
    	done < "$1"
    	printf "\n"
}

# custom function to convert text to morse code
function txt_to_morse()
{
	echo -e "Your text to morse code is : \n"
    	while IFS= read -rN1 c #to read each line in the file character by character
    	do
        	c=${c^} #capitalising each letter just in case
		if [[ $c == $'\n' || $c == ' ' ]]
		then
			printf "\t" #replacing \n and spaces with tab character
		else
			printf '%s ' "${morse[$c]}" #printing equivalent morse code for the character
		fi
    	done < "$1"
    	printf "\n"
}

# custom function to get extention of the file name passed
function grab_extension()
{
	fileName=$1
	extension=${fileName##*.} #seperates extension from the file name and stores it into variable name extension
	
	if [ "$extension" == 'txt' ]
	then
		txt_to_morse $fileName #calling txt_to_morse if extension is .txt
	elif [ "$extension" == 'morse' ]
	then
		morse_to_txt $fileName #calling morse_totxt if extension is .morse
	else
		echo "$extension ...what kind of extention is that\!\?" #telling user if some other extension is encountered
	fi
}

if [ -f "$1" ] #checking if file provided exists or not
then
    grab_extension $1 #calling function to get extension if the file exists
else
    echo "$1 doesn't exist" #telling user if file doesn't exists
fi
