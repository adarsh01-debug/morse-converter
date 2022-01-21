# Problem Statement:

Write a morse code converter using bash. Bash script should accept a file as argument.
- if the file name ends with .morse, it should convert morse code into text.
- if the file name ends with .txt, it should convert text into morse code.

# Convention for morse:

Single space in morse - character change
Multiple spaces (tab character) - word change/line change

# How to execute:

### To convert text to morse code:
$ ./morse.sh fileName.txt

### To convert morse code to text:
$ ./morse.sh fileName.morse

# Algorithm:

### STEP 1:
Declare 2 associative arrays, i.e, morse and letters. Morse array will have letters/numbers as keys and their equivalent morse code as value. Letters array will have morse codes as keys and equivalent letters/numbers as value.

### STEP 2:
Take the argument from command line and check its validity, i.e., if file exists or not. If file does exist then check for its extention type, i.e., whether it is a txt or morse file.

### STEP 3:
Call txt_to_morse function with the file itself as the parameter if the file is of text type.
Call morse_to_txt function with the file itself as the parameter if the file is of morse type.

### STEP 4:
In txt_to_morse:
-Read the file content line by line and convert each character to its equivalent morse code from refering to the morse array.
-If we encounter space or new line then replace it by tab character.

In morse_to_txt:
-Read the file content line by line and if the character equals . or - then append it to an initially empty string str1.
-Keep on appending until we encounter new line character or tab character, in which case we will print the str1 and make str1 empty again.

--------------------------------------------------------------------
