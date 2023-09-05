# Purpose: 
#   Find the maximum of 3 different lists. 
#
# Author:
#   Emmanuel Christianos
#
# Data:
#   data_items_1: array of 4 byte integers with a trailing 0 to indicate the end 
#   of the array. 
#
#   data_items_2: array of 4 byte integers with a trailing 0 to indicate the end 
#   of the array. 
#
#   data_items_3: array of 4 byte integers with a trailing 0 to indicate the end 
#   of the array. 
#

.globl _start

.section .data

data_items_1:
.long 1,32,42,2,4,254,2,0

data_items_2:
.long 10,3,18,22,1,2,2,0

data_items_3:
.long 234,232,242,22,24,54,22,0

.section .text

.type _start, @function
_start:
    pushl $data_items_1
    call find_maximum
    addl $0x4, %esp

    pushl $data_items_2
    call find_maximum
    addl $0x4, %esp

    pushl $data_items_3
    call find_maximum
    addl $0x4, %esp

    movl %eax, %ebx
    movl $1, %eax
    int $0x80

# Purpose: 
#   Given an address of a 0 terminated list of integers, return the largest 
#   integer in that list. 
#
# Variables:
#   %eax = Values at the current index into the array of numbers (data_items_x)
#   %ecx = Current index value into data_items_x
#   %ebx = Current maximum value

.type find_maximum, @function
find_maximum:
    pushl %ebp                          # Save previous frames base pointer
    movl %esp, %ebp                     # Create current frames base pointer

pre_loop_setup:
    movl $0, %ecx                       # Initialize the index variable 
    movl 8(%ebp), %esi                  # Move address of data_items_x into esi
    movl (%esi, %ecx, 4), %eax          # Initializes %eax to store the first value of data_items_x
    movl %eax, %ebx                     # Initializes %eax to store first item as current max

start_loop:
    cmpl $0, %eax                       # Compare current value against 0
    je exit                             # Jump to exit symbol if current value is 0

    incl %ecx                           # Increment the counter
    movl (%esi, %ecx, 4), %eax          # Store data_list_x[ecx] in eax
    cmpl %ebx, %eax                     # Compare current value against maximum 
    jle start_loop                      # Jump back to start of loop if current value is < max
    movl %eax, %ebx                     # Current val is greater than max, update max to current val
    jmp start_loop                      # Jump to start of loop

exit:
    movl %ebx, %eax                     # Move value 1 syscall (exit) into eax
    movl %ebp, %esp                     # Tear down stack frame
    popl %ebp                           # Restore previous frames base pointer
    ret                                 # Return to calling function
