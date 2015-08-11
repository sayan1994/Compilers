#include <asm/unistd.h>
#include <syscall.h>
#define STDOUT_FILENO 1
#define STDIN_FILENO 0
#define STKSZ 128
#define LEN 30

  .file "second4.S"
  .text
  .globl _start

_start:
       pushq   %rbp
       movq    %rsp, %rbp
       subq    $STKSZ, %rsp    # create stack   
       movl    $LEN, -8(%rbp)  # M[rbp-8] (n) <-- LEN
       movl    $0,  -12(%rbp)  # M[rbp-12] (i) <-- 0
       leaq    -STKSZ(%rbp), %rsi # rsi <-- starting
                               # addr. of the buffer
.L1:                           # loop starts
       movl    -12(%rbp), %eax # eax <-- i
       cmpl    -8(%rbp), %eax  # if i > LEN
       jg      .L2             # go out of loop
       cltq                    # rax <-- signExt(i)
       addq    %rsi, %rax      # rax <-- buff + 4*i
       movb    $0, (%rax)      # buff[i] <-- 0
       addl    $1, -12(%rbp)   # i <-- i+1
       jmp     .L1             # goto .L1
       movb    $10, -STKSZ+LEN(%rbp) # \n 
# Read LEN bytes
.L2:
       movl  $(SYS_read), %eax
       movq  $(STDIN_FILENO), %rdi
       leaq  -STKSZ(%rbp), %rsi
       movq  $LEN, %rdx
       syscall
# Write LEN bytes
       movl  $(SYS_write), %eax     # eax <-- 1 (wrire)
                                    # parameters to write
       movq  $(STDOUT_FILENO), %rdi # rdi <-- 1 (stdout)
       leaq  -STKSZ(%rbp), %rsi     # rsi <-- starting 
                                    #  address of string
       movq  $LEN, %rdx             # rdx <-- LEN
                                    #   string length
       syscall                      # software interrupt
                                    #  user process requesting
                                    #  OS for service 
# exit
       movl  $(SYS_exit), %eax      # eax <-- 60 (exit)
                                    #   parameters to exit
       movq  $0, %rdi               # rdi <-- 0
       syscall                      # software interrupt
       ret                          # return
