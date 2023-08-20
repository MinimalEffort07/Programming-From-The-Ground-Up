# Purpose: 
#   To find the maximum value of a given array of numbers, using a count to  
#   determine when to stop reading from the data list. 
#
# Author:
#   Emmanuel Christianos
#
# Data:
#   items: array of 4 byte integers  
#   len_items: number of numbers in items  
#
# Variables:
#   %eax = address at the current index into the array of numbers (items)
#   %ebx = Current maximum value
#   %ecx = Address 1 after the last item of items
#   %edx = Length of data items
#   %edi = Current index value into items

.globl _start

.section .data

len_items:
.long 9

items:
.long 1,32,42,2,4,200,2,0,253

.section .text

_start: 
    movl len_items, %edx            # Store length of list in edx
    movl $0, %edi                   # Initialize the index variable 
    movl $1, %ebx                   # Initialise ebx in case of early exit
    cmpl %edx, %edi                 # Compare 0 with len_items
    je exit                         # Jump to exit if length of items is 0
    movl items(, %edi, 4), %eax     # Initializes %eax to store the address first value of items
    movl %eax, %ebx                 # Initializes %eax to store first item as current max

start_loop:
    cmpl %edx, %edi                 # Compare index value against length of list 
    je exit                         # Jump to exit symbol if index == len_items

    incl %edi                       # Increment the counter
    movl items(, %edi, 4), %eax     # Store data_list+edi in eax

    cmpl %ebx, %eax                 # Compare current value against maximum 
    jle start_loop                  # Jump back to start of loop if current value is <= max

    movl %eax, %ebx                 # Current val is greater than max, update max to current val
    jmp start_loop                  # Jump to start of loop

exit:
    movl $1, %eax                   # Move value 1 syscall (exit) into eax
    int $0x80                       # Syscall interrupt
