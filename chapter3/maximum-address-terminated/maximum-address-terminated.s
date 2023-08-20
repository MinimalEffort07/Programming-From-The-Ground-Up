# Purpose: 
#   To find the maximum value of a given array of numbers, using a calculated 
#   address to determine when to stop reading from the data list. 
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
#   %edx = Length of data items (counting from 0)
#   %edi = Current index value into items

.globl _start

.section .data

len_items:
.long 0

items:
.long 1,32,42,2,4,200,2,0,253

.section .text

_start: 
    movl len_items, %edx            # Store value at len_items in edx
    movl $1, %ebx                   # Set return value in case of early exit
    cmpl $0, %edx                   # Compare len_items against 0
    je exit                         # Jump to exit if len_items == 0
    leal items(, %edx, 4), %ecx     # Load the address after the last item in 
                                    # items into %ecx i.e. &items[len_items*4]

    movl $0, %edi                   # Initialize items index to 0
    leal items(, %edi, 4), %eax     # Store the address of items[index*4] into 
                                    # eax
    movl (%eax), %ebx               # Store the value at eax in ebx

start_loop:
    cmpl %ecx, %eax                 # Compare address of items[index*4] i.e. eax
                                    # against terminating address stored in ecx

    je exit                         # Jump to exit symbol if address of 
                                    # items[index*4] and terminating address are 
                                    # equal. 

    incl %edi                       # Increment index value
    leal items(, %edi, 4), %eax     # Store address of items[index*4] in eax

    cmpl %ebx, (%eax)               # Compare current value i.e items[index*4] 
                                    # against maximum
    jle start_loop                  # Jump back to start of loop if current 
                                    # value is <= max

    movl (%eax), %ebx               # Current value is greater than max, update 
                                    # max to current val
    jmp start_loop                  # Jump to start of loop

exit:
    movl $1, %eax                   # Move value 1 syscall (exit) into eax
    int $0x80                       # Syscall interrupt
