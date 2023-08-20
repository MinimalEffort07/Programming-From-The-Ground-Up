# PURPOSE
#   Takes the number 4 and squares it and returns the result as the status code. 
#
# AUTHOR
#   Emmanuel Christianos

.globl _start

.section .data
.section .text

_start:
   pushl $4
   call square
   addl $4, %esp

   movl %eax, %ebx
   movl $1, %eax
   int $0x80

.type square,@function
square:
    pushl %ebp
    movl %esp, %ebp

    movl 8(%ebp), %eax
    imull %eax, %eax

    movl %ebp, %esp
    popl %ebp
    ret
