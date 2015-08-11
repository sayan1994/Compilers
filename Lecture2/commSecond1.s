   .file   "second1.c++"
   .text
   .globl   main
   .type   main, @function
main:
.LFB0:
   .cfi_startproc
   pushq   %rbp
   .cfi_def_cfa_offset 16
   .cfi_offset 6, -16
   movq   %rsp, %rbp
   .cfi_def_cfa_register 6
   subq   $32, %rsp            # 32-byte stack-frame
   movq   %fs:40, %rax         # Segment addressing
   movq   %rax, -8(%rbp)       # M[rbp-8] <-- rax
   xorl   %eax, %eax           # Clear eax
   movl   $1931508045, -32(%rbp)
          # 0111 0011 0010 0000 0111 1001 0100 1101
          # 73 20 79 4D - "s yM
   movl   $1852793701, -28(%rbp)
          # 0110 1110 0110 1111 0110 0011 0110 0101
          # 6E 6F 63 65 - "noce"
   movl   $1919950948, -24(%rbp)
          # 0111 0010 0111 0000 0010 0000 0110 0100
          # 72 70 20 64 - "rp d"
   movl   $1634887535, -20(%rbp)
          # 0110 0001 0111 0010 0110 0111 0110 1111
          # 61 72 67 6F - "argo"
   movw   $2669, -16(%rbp)
          # 0000 1010 0110 1101
          # 0A 6D - "\nm"
   movb   $0, -14(%rbp)
          # 0000 0000 
          # 00 - '\0' 
   leaq   -32(%rbp), %rax  # rax <-- (rbp-32) str
   movl   $19, %edx        # rdx <-- 19 LEN
   movq   %rax, %rsi       # rsi <-- rax (str)
   movl   $1, %edi         # rdi <-- 1 (stdout)
   call   write            # call write 
   movl   $0, %edi         # rdi <-- 0
   call   _exit            # call exit
   .cfi_endproc
.LFE0:
   .size   main, .-main
   .ident   "GCC: (Ubuntu/Linaro 4.6.3-1ubuntu5) 4.6.3"
   .section   .note.GNU-stack,"",@progbits
