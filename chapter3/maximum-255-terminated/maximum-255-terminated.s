# Purpose: 
#   To find the maximum value of a given array of numbers
#
# Author:
#   Emmanuel Christianos
#
# Data:
#   data_items: array of 4 byte integers with a trailing 255 to indicate the end 
#   of the array. 
#
# Variables:
#   %eax = Values at the current index into the array of numbers (data_items)
#   %edi = Current index value into data_items
#   %ebx = Current maximum value

.globl _start

.section .data

data_items:
.long 1,32,42,2,4,254,2,255

.section .text

_start: 
    movl $0, %edi                       # Initialize the index variable 
    movl data_items(,%edi,4), %eax      # Initializes %eax to store the first value of data_items
    movl %eax, %ebx                     # Initializes %eax to store first item as current max
    cmpl $255, %eax                     # Compare current value against 255
    je exit                             # Jump to exit symbol if current value is 255

start_loop:
    incl %edi                           # Increment the counter
    movl data_items(,%edi,4), %eax      # Store data_list[edi] in eax

    cmpl $255, %eax                     # Compare current value against 255
    je exit                             # Jump to exit symbol if current value is 255

    cmpl %ebx, %eax                     # Compare current value against maximum 
    jle start_loop                      # Jump back to start of loop if current value is <= max

    movl %eax, %ebx                     # Current val is greater than max, update max to current val
    jmp start_loop                      # Jump to start of loop

exit:
    movl $1, %eax                       # Move value 1 syscall (exit) into eax
    int $0x80                           # Syscall interrupt

