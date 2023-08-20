# PURPOSE
#   Return status code '2' to the kernel. 
#
# AUTHOR
#   Emmanuel Christianos
#
# INPUT
#   none
#
# OUTPUT
#   Returns status code '2' - Observed by $?
#
# VARIABLES
#   %eax holds syscall number for SYS_EXIT
#   %ebx holds status code value to be returned

.section .data
.section .text
.globl _start

_start:
    movl $0x1, %eax
    movl $0x2, %ebx
    int $0x80
