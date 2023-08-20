# Purpose: 
#   To find the maximum value of a given array of numbers, using a calculated 
#   address to determine when to stop reading from the data list. 
#
# Author:
#   Emmanuel Christianos
#
# Data:
#   data_items: array of 4 byte integers  
#   length_data_items: number of numbers in data_items  
#
# Variables:
#   %eax = address at the current index into the array of numbers (data_items)
#   %ebx = Current maximum value
#   %ecx = Address 1 after the last item of data_items
#   %edx = Length of data items (counting from 0)
#   %edi = Current index value into data_items
#   %esi = scratch register used for holding temp value in calculating end address

.globl _start

.section .data

length_data_items:
.long 9

data_items:
.long 1,32,42,2,4,200,2,0,253

.section .text

_start: 
    mov length_data_items, %edx
    decl %edx
    mov $4, %esi
    leal data_items(%esi, %edx, 4), %ecx    # Load the address after the last item
                                            # in data_items into %ecx
    movl $0, %edi                           # Initialize the index variable 
    leal data_items(, %edi, 4), %eax        # Initializes %eax to store the address first value of data_items
    movl (%eax), %ebx                       # Initializes %eax to store first item as current max

start_loop:
        
    cmpl %ecx, %eax                         # Compare current value against 255
    je exit                                 # Jump to exit symbol if current value is 255

    incl %edi                               # Increment the counter
    leal data_items(, %edi, 4), %eax        # Store data_list+edi in eax

    cmpl %ebx, (%eax)                       # Compare current value against maximum 
    jle start_loop                          # Jump back to start of loop if current value is <= max

    movl (%eax), %ebx                       # Current val is greater than max, update max to current val
    jmp start_loop                          # Jump to start of loop

exit:
    movl $1, %eax                           # Move value 1 syscall (exit) into eax
    int $0x80                               # Syscall interrupt
