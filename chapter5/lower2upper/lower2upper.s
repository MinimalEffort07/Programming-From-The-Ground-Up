# PURPOSE
#   Reads text from a file and convert all lower case letters to uppercase.
#
# AUTHOR
#   Emmanuel Christianos
#
#   Programming-From-The-Ground-Up style reverse plan of program:
#   ------------------------------------------------------------- 
#
#   We need to convert all alphabet characters in a buffer to upper case. And 
#   then write out that buffer to a file.
#
#   Before we write the data out we need to convert only alphabetical 
#   characters to uppercase if they aren't already. Will need a function to 
#   check if character is a lowercase alphabet character or not. We also need
#   to open the file we want to write to. 
#  
#   To be able to convert the data in the buffer we need to first have read in 
#   data into that buffer.
#
#   To read in data to that buffer we will need to have open the file with which
#   we want to read from.
#
# DATA
#   This program will try and ready from an existing file in the same directory
#   as the program, with the name "readmein.txt". It will write out to a file 
#   with the name "writtenout.txt"

.globl _start

.section .data

.equ SYS_CLOSE,     0x6
.equ SYS_OPEN,      0x5
.equ SYS_WRITE,     0x4
.equ SYS_READ,      0x3
.equ SYS_EXIT,      0x1
.equ LINUX_SYSCALL, 0x80

read_in:
.asciiz "readmein.txt"

write_out:
.asciiz "writemeout.txt"

.section .bss

.lcomm BUFFER, 500

.section .text

.type _start, @function
_start:
    movl $SYS_OPEN, %eax                # Move 'open' syscall number in eax
    movl $read_in, %ebx                 # Move input file name string into ebx
    movl 

