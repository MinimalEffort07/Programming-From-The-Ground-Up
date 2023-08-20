# Purpose: 
#   maximum_list find the maximum value of a given array of 0 terminated number
#   array size must be at least of size 1 i.e. the 0 terminator
#
# Author:
#   Emmanuel Christianos
#
# Data:
#   list_1: array of 4 byte integers with a trailing 0 to indicate the end 
#   of the array. 
#
#   list_2: array of 4 byte integers with a trailing 0 to indicate the end 
#   of the array. 
#
#   list_3: array of 4 byte integers with a trailing 0 to indicate the end 
#   of the array. 
#
# Variables:
#   %eax = Values at the current index into the array of numbers (data_items)
#   %edi = Current index value into data_items
#   %ebx = Current maximum value

.globl _start

.section .data

list_1:
.long 1,32,42,2,4,254,2,0

list_2:
.long 12,111,12,8,0

list_3:
.long 210,2,0

.section .text

_start:
    pushl list_1
    call maximum
    addl $4, %esp

    pushl list_2
    call maximum
    addl $4, %esp

    pushl list_3
    call maximum
    addl $4, %esp

    movl %eax, %ebx
    movl $1, %eax
    int $0x80

# 'maximum' Function
# 
# PURPOSE
#   Given an address of a 0 terminated array, find the maximum element of the array. 
#
# INPUTS
#   maximum(address of array)
#
# OUTPUT
#   largest element in the array in %eax

.type maximum,@function
maximum:
    pushl %ebp
    movl %esp,%ebp

    movl $0, %edi                       # Initialize the index variable 
    leal 8(%ebp), %ecx                  # Move address of first element into ecx
    movl (%ecx,%edi,4), %eax            # Initializes %eax to store the first value of data_items
    movl %eax, %ebx                     # Initializes %eax to store first item as current max

start_loop:
    cmpl $0, %eax                       # Compare current value against 0
    je exit                             # Jump to exit symbol if current value is 0

    incl %edi                           # Increment the counter
    movl (%ecx,%edi,4), %eax            # Store data_list[edi] in eax
    cmpl %ebx, %eax                     # Compare current value against maximum 
    jle start_loop                      # Jump back to start of loop if current value is < max
    movl %eax, %ebx                     # Current val is greater than max, update max to current val
    jmp start_loop                      # Jump to start of loop

exit:
    movl %ebx, %eax                     # Store max in eax

    movl %ebp, %esp                     # destroy stack frame
    popl %ebp                           # restore previous base pointer
    ret                                 # return to calling function

