# PURPOSE
#   Compute the factorial of the number 5 (in a non-recursive manner) and return 
#   the value as a status code
#
# AUTHOR
#   Emmanuel Christianos
#

.globl _start

.section .data
.section .text

.type _start, @function
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
#   Compute the factorial of a given number in a non recursive manner
#
# INPUT
#   factorial(a) - 'a' Integer
#
# VARIABLES
#   ecx - The multiplier, To calculate a! we can do a x (a-1) x (a-2) etc, any 
#         given stage of this equation e.g. (a-3), or (a-7) we'll call the 
#         multiplier
#
#   eax - The running total
#
# OUTPUT
#   a! in eax


.type factorial, @function

factorial: 
    pushl %ebp              # Save previous base pointer
    movl %esp, %ebp         # Create new stack frame

    movl 8(%ebp), %ecx      # Move argument to factorial into ecx
    movl %ecx, %eax         # Initialise sum

start_loop: 
    decl %ecx               # Decrement the multiplier
    cmpl $1, %ecx           # Compare argument against 1 
    jle end_loop            # Jump to end_loop if multiplier is <= 1

    imull %ecx, %eax        # Multiply the running count with the multiplier
    jmp start_loop          # Jump back to the beginning of the loop

end_loop:
    movl %ebp, %esp         # Tear down stack frame
    popl %ebp               # Restore base pointer of previous frame
    ret                     # Return to calling address
