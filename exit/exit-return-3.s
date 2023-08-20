.section .data
.section .text
.globl _start

_start:
    movl $0x1, %eax
    movl $0x3, %ebx
    int $0x80
