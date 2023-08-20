# PURPOSE
#   Compute the factorial of the number 5 and return the value as a status code
#
# AUTHOR
#   Emmanuel Christianos
#

.globl _start

.section .data
.section .text

_start:
    pushl $5                # Push argument 5 to factorial
    call factorial          # Call factorial function
    addl $4, %esp           # Clean up argument to factorial from the stack

    movl %eax, %ebx         # Move function result into ebx for exit call status
    movl $1, %eax           # Move exit syscall into eax 
    int $0x80               # Syscall interrupt

# 'factorial' function
#
# PURPOSE
#   Compute the factorial of a given number
#
# INPUT
#   factorial(a) - 'a' Integer
#
# OUTPUT
#   a! in eax

.type factorial, @function

factorial: 
    pushl %ebp              # Save previous base pointer
    movl %esp, %ebp         # Create new stack frame

    movl 8(%ebp), %eax      # Move argument to factorial into ecx
    cmpl $1, %eax           # Compare argument against 1 (BASE CASE)
    je end_recursion        # Jump to end_recursion if argument is 1

    decl %eax               # decrement the argument value
    pushl %eax              # push decremented value onto stack for next call to 
                            # factorial
    call factorial          # call factorial
    addl $4, %esp           # cleanup argument to factorial function from stack
    imull 8(%ebp), %eax     # multiple result from factorial(a-1) with a

end_recursion:
    movl %ebp, %esp         # tear down stack frame
    popl %ebp               # restore base pointer of previous frame
    ret                     # return to calling address
