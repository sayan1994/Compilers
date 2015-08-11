#Name-Sayan Mukhopadhyay
#Roll -13CS30028
	.file	"ass1_13CS30028.c"						#filename
	.section	.rodata						#read only data section
.LC0:	
	.string	"Enter the order: "				#lablel LC0 for string for asking input for order
.LC1:
	.string	"%d"							#label LC1 for input int format
.LC2:
	.string	"Enter matix A in row-major: "	#label LC2 for asking matrix A as input
.LC3:
	.string	"Enter matix B in row-major: "	#label LC3 for asking matrix B as input
.LC4:
	.string	"The output matrix is:"			#Label LC4 for outputting matrix
.LC5:
	.string	"%d "							#label LC5 for input int format with a space
	.text									#ending of data part,,text part starts
	.globl	main							#defining main as global function
	.type	main, @function					#defining main as a function
main:										
.LFB0:
	.cfi_startproc
	pushq	%rbp				#push old base pointer to stack to save it
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	movq	%rsp, %rbp			#assign base pointer to current stack pointer
	.cfi_def_cfa_register 6 	
	subq	$4816, %rsp			#assign memory for 3 20*20 arrays and 3 integers
	movl	$.LC0, %edi 		#copy adress of string represented by label .LC0 in edi
	movl	$0, %eax
	call	printf				#calling printf
	leaq	-4812(%rbp), %rax 	#rax=adress of int n
	movq	%rax, %rsi			#2nd argument for scanffunction=address of int n
	movl	$.LC1, %edi 		#copy addrees of string "%d" in edi
	movl	$0, %eax
	call	__isoc99_scanf 		#call scanf
	movl	$.LC2, %edi 		#copy adress of string represented by label .LC2 in edi
	movl	$0, %eax
	call	printf				#call printf
	movl	-4812(%rbp), %eax	#assign value of n to eax
	leaq	-4800(%rbp), %rdx 	#assign address of A[0] to rdx
	movq	%rdx, %rsi			#rsi to save second parameter(address of matrix A) to function ReadMatrix
	movl	%eax, %edi 			#edi to save first parameter(value of n) to function ReadMatrix
	call	ReadMatrix			#calling ReadMatrix(n,A)
	movl	$.LC3, %edi         #load string "Enter matrix B in row-major: " in edi
	movl	$0, %eax
	call	printf				#call printf with parameter edi
	movl	-4812(%rbp), %eax   #eax=address of int n
	leaq	-3200(%rbp), %rdx 	#rdx=address of array B
	movq	%rdx, %rsi          #move adress of B to rsi(2nd parameter)
	movl	%eax, %edi          #move value of n to edi(1st parameter)
	call	ReadMatrix          #call ReadMatrix
	movl	-4812(%rbp), %eax   #assign to eax value of n
	leaq	-1600(%rbp), %rcx   #assign adress of C[0][0] to rcx
	leaq	-3200(%rbp), %rdx   #assign address of B[0][0] to rdx
	leaq	-4800(%rbp), %rsi   #assign address of A[0][0] to rsi
	movl	%eax, %edi          #assign value of n to edi(1st parameter)
	call	MultiplyMatrix      #call MultiplyMatrix
	movl	$.LC4, %edi 		#load string .LC4 in edi
	call	puts                #call putstring
	movl	$0, -4808(%rbp)     #assign i=0
	jmp	.L2                     #jump to L2
.L5:
	movl	$0, -4804(%rbp)    #assign j=0
	jmp	.L3 				   #jum to L3
.L4:
	movl	-4804(%rbp), %eax   #assign eax=j
	movslq	%eax, %rcx          #convert j to 64 bit and save to rcx
	movl	-4808(%rbp), %eax   #assign eax=i
	movslq	%eax, %rdx          #convert i to 64bit and save to rdx
	movq	%rdx, %rax          #assign i to rax
	salq	$2, %rax        	#rax=4*i
	addq	%rdx, %rax          #rax=4*i+i=5*i
	salq	$2, %rax            #rax=20*i
	addq	%rcx, %rax          #rax=20*i+j
	movl	-1600(%rbp,%rax,4), %eax #eax=address of C+4*(20*i+j)=adress of C[i][j]
	movl	%eax, %esi      #second paramter of first function printf
	movl	$.LC5, %edi     #load string "%d" in edi
	movl	$0, %eax
	call	printf         #call printf with 1st and 2nd parameters
	addl	$1, -4804(%rbp) #add 1 to j(j++)
.L3:
	movl	-4812(%rbp), %eax   #assign value of n to eax
	cmpl	%eax, -4804(%rbp)   #check if j<n
	jl	.L4      				#jump to L4
	movl	$10, %edi           #load newline character on edi
	call	putchar 			#call putchar
	addl	$1, -4808(%rbp)     #add 1 to i(i++)
.L2:
	movl	-4812(%rbp), %eax   #assign eax=n
	cmpl	%eax, -4808(%rbp)   #check i<n
	jl	.LC5                    #if yes jump to LC5
	movl	$0, %eax
	leave    				
	.cfi_def_cfa 7, 8
	ret
	.cfi_endproc  				#return
.LFE0:
	.size	main, .-main
	.section	.rodata
.LC6:
	.string	"The input matrix is:" #label LC6 for string "The input matrix is: "
	.text
	.globl	ReadMatrix			#ReadMatrix is a global function
	.type	ReadMatrix, @function #ReadMatrix is a function
ReadMatrix:
.LFB1:
	.cfi_startproc
	pushq	%rbp			#push old base pointer to stack
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	movq	%rsp, %rbp	  #assign base pointer to stack pointer
	.cfi_def_cfa_register 6
	subq	$32, %rsp     #assign 32 bits memory for 4 variables i,j,n,A
	movl	%edi, -20(%rbp)#store value of 1st parameter in given memory location
	movq	%rsi, -32(%rbp)#store value of 2nd parameter in M[rbp-32]
	movl	$0, -8(%rbp) #assign 0 to i
	jmp	.L8              #jump to label l8
.L11:
	movl	$0, -4(%rbp) #assign j=0(2nd line of nested loop)
	jmp	.L9              #jump to label L9
.L10:
	movl	-8(%rbp), %eax #store value of i in eax
	movslq	%eax, %rdx     #convert value of i to 64 bit and store in rdx
	movq	%rdx, %rax     #move value of rdx to rax
	salq	$2, %rax       #multiply rax by 4(rax=4*i)
	addq	%rdx, %rax     #rax=i+4*i=5*i
	salq	$4, %rax       #rax=16*5*i=80*i
	movq	%rax, %rdx     #rdx=80*i
	movq	-32(%rbp), %rax #rax=adrress of array data
	addq	%rax, %rdx     #rdx=rax+80*i
	movl	-4(%rbp), %eax #eax=j
	cltq				#convert eax to 64bit and assign to rax
	salq	$2, %rax   #rax=4*j
	addq	%rdx, %rax #rax=80*i+4*j
	movq	%rax, %rsi #assign 2nd paramter of scanf function to address of data[i][j]
	movl	$.LC1, %edi #load string "%d" in edi
	movl	$0, %eax    
	call	__isoc99_scanf #call scanf  with first parameter edi and 2nd parameter rsi
	addl	$1, -4(%rbp)   #add 1 to value of j(j++)
.L9:
	movl	-4(%rbp), %eax   #store value of j in eax
	cmpl	-20(%rbp), %eax  #compare j with n(-20(%rbp))
	jl	.L10				 #if j<n go to L10
	addl	$1, -8(%rbp)     #add 1 to i
.L8:
	movl	-8(%rbp), %eax    #move value of variable i to eax
	cmpl	-20(%rbp), %eax	  #compare value of 1st parameter(n) with i
	jl	.L11				  #IF i<n go to label L11(first line of nested loop)
	movl	$.LC6, %edi 	  #else load adrres of string "The input matrix is:\n" on edi
	call	puts              #print string represented by LC6
	movl	$0, -8(%rbp)      #assign i=0
	jmp	.L12        		  #jump to L12
.L15:
	movl	$0, -4(%rbp)   #initalize j=0
	jmp	.L13				#go to L13
.L14:
	movl	-8(%rbp), %eax #assign value of i to eax
	movslq	%eax, %rdx     #convert eax to 64 bit and store to rdx
	movq	%rdx, %rax     #move value of rdx to rax
	salq	$2, %rax       #rax-4*i
	addq	%rdx, %rax     #rax=4*i+i=5*i
	salq	$4, %rax       #rax=16*5*i=80*i
	movq	%rax, %rdx     #rdx=80*i
	movq	-32(%rbp), %rax #rax=adress of array data
	addq	%rax, %rdx      #rdx=rax+80*i
	movl	-4(%rbp), %eax  #assign value of j to eax
	cltq                    #convert eax to 64 bit and save to rax
	movl	(%rdx,%rax,4), %eax #eax=4*j+rdx=4*j+80*i
	movl	%eax, %esi   #assign esi=80*i+4*j
	movl	$.LC5, %edi  #load string "%d" on edi
	movl	$0, %eax     #assign j=0
	call	printf		 #call printf
	addl	$1, -4(%rbp) #add 1 to j(j++)
.L13:
	movl	-4(%rbp), %eax   #assign eax=j
	cmpl	-20(%rbp), %eax  #compare j<n
	jl	.L14                 #if yes go to L14
	movl	$10, %edi        #load "\n" on edi
	call	putchar			 #call putchar
	addl	$1, -8(%rbp)     #add 1 to i(i++)
.L12:
	movl	-8(%rbp), %eax #assign value of i to eax
	cmpl	-20(%rbp), %eax #compare i with n
	jl	.L15      #if i<n got to L15
	leave
	.cfi_def_cfa 7, 8
	ret
	.cfi_endproc #return from function
.LFE1:
	.size	ReadMatrix, .-ReadMatrix
	.section	.rodata      #section readonly data
.LC7:
	.string	"The transposed matrix is:" #assign string to LC7
	.text              
	.globl	TransposeMatrix    #TransposeMatrix is a global function
	.type	TransposeMatrix, @function   #TransposeMatrix is a function
TransposeMatrix:
.LFB2:
	.cfi_startproc
	pushq	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	movq	%rsp, %rbp   #assign current stack pointer to new base pointer
	.cfi_def_cfa_register 6
	subq	$32, %rsp    #allocate 32 bit stack memory
	movl	%edi, -20(%rbp) #save value of n in M[rbp-20]
	movq	%rsi, -32(%rbp) #move value of 2nd parameter to M[rbp-32]
	movl	$0, -12(%rbp) #initalize i=0
	jmp	.L17          #jump to L17
.L20:
	movl	$0, -8(%rbp)  #assign j=0
	jmp	.L18			#jump to L18
.L19:
	movl	-12(%rbp), %eax   #eax=i
	movslq	%eax, %rdx        #convert eax to 64 bit and store to rdx
	movq	%rdx, %rax        #assign value of rdx to rax.rax=i
	salq	$2, %rax          #rax=4*i
	addq	%rdx, %rax        #rax=4*i+i=5*i
	salq	$4, %rax          #rax=16*5*i=80*i
	movq	%rax, %rdx        #rdx=rax=80*i
	movq	-32(%rbp), %rax   #rax=address of date[0][0]
	addq	%rax, %rdx         #rdx=rax=address of data[0][0]+80*i
	movl	-8(%rbp), %eax    #assign eax=j
	cltq                      #convert eax to 64bit and assign to rax
	movl	(%rdx,%rax,4), %eax #eax=rdx+4*rax=address of(data+80*i+4*j)
	movl	%eax, -4(%rbp)    #assign value of eax to t
	movl	-12(%rbp), %eax   #assign value of i to eax
	movslq	%eax, %rdx        #convert eax to 64bit and store to rdx
	movq	%rdx, %rax       #assign rdx to rax.rax=i
	salq	$2, %rax         #rax=4*i
	addq	%rdx, %rax 			#rax=4*i+i=5*i
	salq	$4, %rax 		 #rax=16*5i=80*i
	movq	%rax, %rdx 		#rdx=rax=80*i
	movq	-32(%rbp), %rax 	#rax=address of date[0][0]
	leaq	(%rdx,%rax), %rcx   #rcx=rdx+rax=address of (80*i+data[0][0])
	movl	-8(%rbp), %eax      #assign eax=j
	movslq	%eax, %rdx          #convert eax to 64bit and save to rdx 
	movq	%rdx, %rax 			#rax=rdx=j
	salq	$2, %rax            #rac=4*j
	addq	%rdx, %rax          #rax=4*j+j=5*j
	salq	$4, %rax            #rax=16*5*j=80*j
	movq	%rax, %rdx 			#rdx=rax=80*j
	movq	-32(%rbp), %rax     #rax=adress of data[0][0]
	addq	%rax, %rdx          #rdx=rdx+rax=adress of data[0][0]+80*j
	movl	-12(%rbp), %eax     #assign eax=i
	cltq						#convert eax to 64bit and save to rax
	movl	(%rdx,%rax,4), %edx #edx=rdx+4*rax=address of data[0][0]+80*j+4*i
	movl	-8(%rbp), %eax      #eax=j
	cltq    					#convert eax to 64bit and store in rax.rax=j
	movl	%edx, (%rcx,%rax,4) #rcx+rax*4=address(data+80*i+j)=data[i][j]
	movl	-8(%rbp), %eax     #assign eax=j
	movslq	%eax, %rdx         #convert eax to 64bit and store in rdx.rdx=j
	movq	%rdx, %rax         #rax=rdx=j
	salq	$2, %rax 		   #rax=4*rax=4*j
	addq	%rdx, %rax         #rax=rdx+rax=5*j
	salq	$4, %rax           #rax=16*rax=80*j
	movq	%rax, %rdx         #rdx=rax=80*j
	movq	-32(%rbp), %rax    #rax=adress of data[0][0]
	leaq	(%rdx,%rax), %rcx  #rcx=rdx+rax=adress of(data[0][0]+80*j)
	movl	-12(%rbp), %eax    #assign eax=i
	cltq                       #convert eax to 64bit and assign to rax
	movl	-4(%rbp), %edx     #edx=M[rbp-4]=t
	movl	%edx, (%rcx,%rax,4)#rcx+4*rax=data+80*j+i=data[j][i]=t
	addl	$1, -8(%rbp)       #add 1 to j(j++)
.L18:
	movl	-8(%rbp), %eax    #assign eax value of j
	cmpl	-12(%rbp), %eax   #check if j<i
	jl	.L19                  #if yes jump to L19
	addl	$1, -12(%rbp)     #add 1 to i(i++)
.L17:
	movl	-12(%rbp), %eax #assign value of i to eax
	cmpl	-20(%rbp), %eax #check if i<n
	jl	.L20				#if yes then jump to L20
	movl	$.LC7, %edi     #load string LC7="The transposed matrix is:\n" on edi
	call	puts            #call puts
	movl	$0, -12(%rbp)   #assign i=0
	jmp	.L21                #jump to L21
.L24:
	movl	$0, -8(%rbp)   #assign j=0
	jmp	.L22               #jump to L224
.L23:
	movl	-12(%rbp), %eax  #assign eax=i.
	movslq	%eax, %rdx       #convert eax to 64 bit and store in rdx
	movq	%rdx, %rax       #move rdx to rax.rax=i
	salq	$2, %rax 		 #rax=4*rax=4*i
	addq	%rdx, %rax       #rax=rax+rdx=5*i
	salq	$4, %rax         #rax=16*5*i=80*i
	movq	%rax, %rdx       #move rax to rdx;rdx=80*i
	movq	-32(%rbp), %rax  #assign adress of data[0][0] to rax
	addq	%rax, %rdx       #rdx=rax+rdx.adress of(data[0][0]+80*i)
	movl	-8(%rbp), %eax   #assign eax=j
	cltq                     #convert eax to 64 bit and store in rax
	movl	(%rdx,%rax,4), %eax #eax=rdx+4*rax.eax=adress of(data[0][0]+80*i+4*j)
	movl	%eax, %esi       #load value of eax on esi(2nd parameter)
	movl	$.LC5, %edi      #load string "%d"
	movl	$0, %eax  		
	call	printf 			#call printf
	addl	$1, -8(%rbp)    #add j to 1.(j++)
.L22:
	movl	-8(%rbp), %eax   #assign eax to j.eax=j
	cmpl	-20(%rbp), %eax  #check if j<n
	jl	.L23                 #if yes then jump to L23
	movl	$10, %edi        #load "\n" on edi
	call	putchar          #call putchar
	addl	$1, -12(%rbp)     #add 1 to i.(i++)
.L21:
	movl	-12(%rbp), %eax   #assign eax to i.eax=i
	cmpl	-20(%rbp), %eax	  #check i<n
	jl	.L24                  #if yes jump to l24
	leave
	.cfi_def_cfa 7, 8
	ret
	.cfi_endproc			#return
.LFE2:
	.size	TransposeMatrix, .-TransposeMatrix
	.globl	VectorMultiply     #Declare VectorMultiply as global
	.type	VectorMultiply, @function #VectorMultiply is a 
VectorMultiply:
.LFB3:
	.cfi_startproc
	pushq	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16 
	movq	%rsp, %rbp     #assign base pointer to new stack pointer
	.cfi_def_cfa_register 6
	movl	%edi, -20(%rbp) #assign M[rbp-20]=edi=n
	movq	%rsi, -32(%rbp) #assign M[rbp-32]=rsi=L[j][0]
	movq	%rdx, -40(%rbp) #assign M[rbp-40]=rdx=R[i][0]
	movl	$0, -4(%rbp) 	#assign result to 0
	movl	$0, -8(%rbp)    #assign i to 0
	jmp	.L26   				#jump to L26
.L27:
	movl	-8(%rbp), %eax #assign eax to i
	cltq                   #convert to 64 bit and assign to rax.rax=i
	leaq	0(,%rax,4), %rdx #rdx=4*rax=4*i
	movq	-32(%rbp), %rax  #rax=M[rbp-32]=L[0]
	addq	%rdx, %rax      #rax=rax+rdx.rax=L[i]
	movl	(%rax), %edx   #edx=rax=L[i]
	movl	-8(%rbp), %eax #eax=M[rbp-8]=i
	cltq                   #convert to 64 bit and save in rax
	leaq	0(,%rax,4), %rcx #rcx=4*rax=4*i
	movq	-40(%rbp), %rax #rax=M[rbp-40]=starting adress of R
	addq	%rcx, %rax     #rax=rcx+rax.rax=R[i]
	movl	(%rax), %eax 	#assign eax to rax.eax=R[i]
	imull	%edx, %eax      #eax=eax*edx=R[i]*L[i]
	addl	%eax, -4(%rbp)  #M[rbp-4]=result=result+eax
	addl	$1, -8(%rbp)    #add 1 to i.(i++)
.L26:
	movl	-8(%rbp), %eax  #move M[rbp-8] to eax.eax=i
	cmpl	-20(%rbp), %eax #check if i<n
	jl	.L27 				#if yes then go to L27
	movl	-4(%rbp), %eax  #move M[rbp-4] to eax.eax=j
	popq	%rbp            #popping rbp from stack
	.cfi_def_cfa 7, 8
	ret
	.cfi_endproc
.LFE3:
	.size	VectorMultiply, .-VectorMultiply
	.globl	MultiplyMatrix             #MultiplyMatrix is global
	.type	MultiplyMatrix, @function  #MultiplyMatrix is a function
MultiplyMatrix:
.LFB4:
	.cfi_startproc
	pushq	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	movq	%rsp, %rbp      #assign base pointer to current stack pointer
	.cfi_def_cfa_register 6
	pushq	%rbx           
	subq	$56, %rsp      #assign 56 bit memory to function in stack
	.cfi_offset 3, -24
	movl	%edi, -36(%rbp)  #assign n to M[rbp-36]
	movq	%rsi, -48(%rbp)  #assign L to M[rbp-48]
	movq	%rdx, -56(%rbp)  #assign R to M[rbp-56]
	movq	%rcx, -64(%rbp)  #assign M to M[rbp-64]
	movq	-56(%rbp), %rdx #store address of R to rdx
	movl	-36(%rbp), %eax #store value of n to eax
	movq	%rdx, %rsi      #assign 2nd paramter to address of R[0][0]
	movl	%eax, %edi      #assign value of n to 1st parameter(eax)
	call	TransposeMatrix #call TransposeMatrix
	movl	$0, -24(%rbp)   #assign i=0
	jmp	.L30                #jump to L30
.L33:
	movl	$0, -20(%rbp)   #assign j=0
	jmp	.L31                #jump to L31
.L32:
	movl	-24(%rbp), %eax  #assign eax=i
	movslq	%eax, %rdx      #convert eax to 64 bit and save in rdx
	movq	%rdx, %rax      #move rdx to rax.rax=i
	salq	$2, %rax        #rax=4*i
	addq	%rdx, %rax      #rax=rdx+rax.rax=5*i
	salq	$4, %rax        #rax=16*5*i=80*i
	movq	%rax, %rdx      #assign value of rax to rdx
	movq	-64(%rbp), %rax #assign M[rbp-64]=address of matrix M to rax
	leaq	(%rdx,%rax), %rbx  #rbx=adress of M[0][0]+80*i
	movl	-20(%rbp), %eax   #assign eax=j
	movslq	%eax, %rdx       #convert eax to 64bit and asssign to rdx
	movq	%rdx, %rax       #assign rax to rdx=j
	salq	$2, %rax 		 #rax=4*rax=4*j
	addq	%rdx, %rax       #rax=rdx+rax=5*j
	salq	$4, %rax         #rax=16*rax=80*j
	movq	%rax, %rdx       #move rax to rdx.rdx=80*j
	movq	-56(%rbp), %rax  #assign adress of R[0][0] to rax
	addq	%rdx, %rax       #rax=rax+rdx=adress(80*j+R[0][0])
	movq	%rax, %rsi 		 #move value of rax to rsi
	movl	-24(%rbp), %eax  #assign eax=M[rbp-24]=value of i
	movslq	%eax, %rdx       #convert eax to 64bit and assign to rdx.rdx=i
	movq	%rdx, %rax       #assign rax=rdx.rax=i
	salq	$2, %rax        #rax=4*i
	addq	%rdx, %rax      #rax=rax+rdx=5*i
	salq	$4, %rax 		#rax=16*rax=80*i
	movq	%rax, %rdx  	#assign rax to rdx.rdx=80*i
	movq	-48(%rbp), %rax #assign adrress of L[0][0] to rax
	addq	%rdx, %rax     	#rax=rdx+rax=adress of L[0][0]+80*i
	movq	%rax, %rcx      #move rax to rcx.
	movl	-36(%rbp), %eax #eax=M[rbp-36]=value of n
	movq	%rsi, %rdx      #rdx=rsi=R[j][0]
	movq	%rcx, %rsi      #rsi=rcx=L[i][0]
	movl	%eax, %edi      #edi=eax=n
	call	VectorMultiply  #call VectorMultiply
	movl	-20(%rbp), %edx #assign edx to j.edx=j
	movslq	%edx, %rdx      #convert j to 64 bit and store in rdx
	movl	%eax, (%rbx,%rdx,4) #M+80*i+4*j=M[i][j]=eax=return value from Vector Multiply
	addl	$1, -20(%rbp)    #add 1 to j.(j++)
.L31:
	movl	-20(%rbp), %eax     #assign eax=j
	cmpl	-36(%rbp), %eax     #check if j<n
	jl	.L32                    #jump to L32
	addl	$1, -24(%rbp)        #add 1 to i.(i++)
.L30:
	movl	-24(%rbp), %eax   #assign eax=M[rbp-24]=i
	cmpl	-36(%rbp), %eax   #check if i<n
	jl	.L33                  #if yes jump to L33
	addq	$56, %rsp         #add 56 bits to current stack pointer
	popq	%rbx              #poping base pointer from stack
	popq	%rbp              #popping base pointer from stack
	.cfi_def_cfa 7, 8
	ret
	.cfi_endproc            #return
.LFE4:
	.size	MultiplyMatrix, .-MultiplyMatrix
	.ident	"GCC: (Ubuntu 4.8.4-2ubuntu1~14.04) 4.8.4"
	.section	.note.GNU-stack,"",@progbits
