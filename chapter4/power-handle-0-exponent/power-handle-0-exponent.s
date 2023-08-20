# PURPOSE
#   power.s will computer 2^0 and return the final value as the status code to 
# the kernel. 
#
# AUTHOR
#   Emmanuel Christianos
#
# INPUT
#   None
#
# VARIABLES
#    ebx - holds the running total from the calls to power 

.globl _start

.section .data

.section .text

_start:
    pushl $0            # Push exponent onto the stack
    pushl $2            # Push base onto the stack
    call power          # Call power function
    addl $8, %esp       # Clean up exponent and base from stack
                        # power again and don't want to overwrite the result. 

    movl %eax, %ebx     # copy the result of power into ebx for exit status 
    movl $1, %eax       # move exit syscall number into eax
    int $0x80           # syscall interrupt

# PURPOSE
#   power(a,b) takes two integers a, and b and returns a^b
#
# INPUT
#   a - base
#   b - exponent
#
# OUTPUT
#   a^b in eax. 
#
# NOTES 
#   1) The power must be 0 or greater.
#   2) Could have been done without local variable on stack, however was done
#      this way to demonstrate the create of stack space for local variables.
#
# VARIABLES
#   ebx - base parameter i.e. 'a' 
#   ecx - exponent parameter i.e. 'b'
#   eax/-4(%ebp) - running total

.type power, @function  # Specifies that the power symbol should be treated as a
                        # function
power:
    pushl %ebp          # Save the previous base pointer on the stack
    movl %esp, %ebp     # Setup the new stack frame
                         
    subl $4, %esp       # Create a double word of space on the stack for a local
                        # variable

    movl 8(%ebp), %ebx  # Move the base parameter into ebx
    movl 12(%ebp), %ecx # Move the exponent parameter into ecx

    movl $1, -4(%ebp)   # Set exit status in case exponent == 0
    cmpl $0, %ecx       # Check to see if exponent is 0
    je end_loop         # Jump to end if exponent is 0
    
    movl %ebx, -4(%ebp) # move the base parameter into the local 

start_loop:
    cmpl $1, %ecx       # Compare the exponent value to 1
    je end_loop         # Jump to exit if exponent is == to 1 

    movl -4(%ebp), %eax # Move the running count into eax 
    imul %ebx, %eax     # multiple the running count with the base parameter and 
                        # store the result in eax
    movl %eax, -4(%ebp) # move eax onto the local variable space on the stack 
    decl %ecx           # decrement exponent value
    jmp start_loop      # jump to beginning of loop

end_loop:
    movl -4(%ebp), %eax # move the running count into eax

    movl %ebp, %esp     # destroy the stack frame
    popl %ebp           # restore previous ebp
    ret                 # return to return address
