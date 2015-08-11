#include <asm/unistd.h>
#include <syscall.h>
#define STDOUT_FILENO 1
#define STDIN_FILENO 0
#define LEN 50

  .file "second2.S"
  .globl data
  .bss
  .align 32
  .type data, @object
  .size data, 100
data:
  .zero 100 
  .text
  .globl _start

_start:
       movl  $(SYS_read), %eax
       movq  $(STDIN_FILENO), %rdi
       movq  $data, %rsi
       movq  $LEN, %rdx
       syscall
#
       movl  $(SYS_write), %eax     # eax <-- 1 (wrire)
                                    # parameters to write
       movq  $(STDOUT_FILENO), %rdi # rdi <-- 1 (stdout)
       movq  $data, %rsi            # rsi <-- starting 
                                    #  address of string
       movq  $LEN, %rdx             # rdx <-- LEN
                                    #   string length
       syscall                      # software interrupt
                                    #  user process requesting
                                    #  OS for service 
       movl  $(SYS_exit), %eax      # eax <-- 60 (exit)
                                    #   parameters to exit
       movq  $0, %rdi               # rdi <-- 0
       syscall                      # software interrupt
       ret                          # return
