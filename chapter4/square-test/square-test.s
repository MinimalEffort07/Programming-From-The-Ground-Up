# PURPOSE
#   Test the square function I wrote by looping through test data (0-4) and 
#   comparing its results to test_data[index]^2. Returns index of faulting test
#   data item if there is one or 0 on success.
#
# AUTHOR
#   Emmanuel Christianos

.globl _start
.section .data

len_data:
.long 5

test_data:
.long 0,1,2,3,4

.section .text
_start:
    movl $0, %eax                   # Initialize return value in case of 0 
                                    # length data
                                    
    movl %eax, %ecx                 # Initialise index to 0

loop:
    movl $0, %eax                   # Set return value in case of successful
                                    # termination of program
    # Loop Condition
    cmpl len_data, %ecx             # Compare index and length of data
    je end_loop                     # Jump to end_loop if they are equal j

    movl test_data(,%ecx,4), %eax   # move test_data[index] into eax

    # Manufacturing actual result
    movl %eax, %edi                 # Copy test_data[index] into %edi
    imull %eax, %edi                # square test_data[index]
    pushl %edi                      # push result onto the stack

    # Calling power
    pushl %eax                      # push test_data[index] onto the stack
    call square                     # call square 
    addl $4,%esp                    # clean up argument to square from stack
    incl %ecx                       # increment index
    
    # Comparing power vs actual result
    popl %edi                       # Placing our manufactured result into edi
    cmpl %eax, %edi                 # Compare test_data[index] squared and 
                                    # result from square 
    je loop                         # jump to beginning of loop if they are 
                                    # equal

    decl %ecx                       # Revert the index increment
    movl %ecx, %eax                 # Move index of faulting data item into 
                                    # eax

end_loop:
   movl %eax, %ebx
   movl $1, %eax
   int $0x80

# 'square' function
# PURPOSE
#   Given a number, return the its square.
#
# INPUT
#   square(a) - a is a Int
#
# OUTPUT
#   a^2

.type square, @function 
square:
    pushl %ebp
    movl %esp, %ebp
    
    movl 8(%ebp), %eax
    imull %eax, %eax

    movl %ebp, %esp
    popl %ebp
    ret
