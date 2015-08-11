#include "myl.h"
#define SIZE 1000                           //defining max size of input buffer as 1000
int prints(char * str)						//function to print a string passed as parameter
{
	int len=0;
	while(str[len]!='\0')
	{
		len++;
	} 										//count number of characters to be printed
	__asm__ __volatile__ (
		"movl $1, %%eax \n\t"
		"movq $1, %%rdi \n\t"
		"syscall \n\t"
		:
		:"S"(str), "d"(len)
		) ;                                	//inline assembly code for printing a string
	return len;
}
int printi(int n)                          //function to print an integer
{
	char str[SIZE];                        //for mainting the string to be printed
	int len=0,i,j;
	if(n==0)
	{
		str[0]='0';
		len++;
	}                                      //if n=0 then just put a 0 in the string to printed
	if(n<0)
	{
		str[0]='-';
		len++;
		n=-n;
	}                                     //if n is negative append the string with a '-' sign
	while(n!=0)
	{
		int digit=n%10;
		str[len]=digit+'0';
		len++;
		n=n/10;
	}                                     //extract the digits one by one from n
	i=0;j=len-1;
	if(str[i]=='-')
		i++;
	for(;i<j;)
	{
		char t=str[j];
		str[j]=str[i];
		str[i]=t;
		i++;j--;
	}                                    //reverese the string to print n
	__asm__ __volatile__ (
		"movl $1, %%eax \n\t"
		"movq $1, %%rdi \n\t"
		"syscall \n\t"
		:
		:"S"(str), "d"(len)
		) ; 							//printing n which is stored as a string in str
	return len;
}
int readi(int *eP)                     //function to read an integer
{
	*eP=OK;                           //initializing error with OK
	char str[SIZE];
	__asm__ __volatile__(
		"movl $0 ,%%eax \n\t"
		"movq $0 ,%%rdi \n\t"
		"syscall \n\t"
		:
		: "S"(str) , "d"(SIZE)
	);                                //inline assembly code for reading a string as input in str and maximun size SIZE
	int i=0,flag=0;
	long long int n=0;
	if(str[i]=='-')                  //if read integer is negative
	{
		flag=1;i=1;
		if(str[i+1]=='\n')
		{
			*eP=ERR;
			prints("Invalid integer\n");
			return 0;
		}                           //only a '-' as input is invalid
	}
	while(str[i]!='\n')             //continue till the end of line
	{
		if(str[i]<'0' || str[i]>'9')
		{
			*eP=ERR;
			prints("Invalid character\n");
			return 0;
		}                          //invalid character as input
		int d=str[i]-'0'; 
		n=n*10+d;
		i++;
		if( n<-2147483648 || n>2147483647)
		{
			*eP=ERR;
			prints("Overflow\n");
			return 0;
		}                         //checking for possible overflow in a 32 bit signed integer
	}
	if(flag==1)
		n=-n;                      //if negative then n=-n;
	return n;

}
int readf(float *fP)
{
	int error=OK;
	char str[SIZE];
	__asm__ __volatile__(
		"movl $0 ,%%eax \n\t"
		"movq $0 ,%%rdi \n\t"
		"syscall \n\t"
		:
		: "S"(str) , "d"(SIZE)
	);                            //reading a string
	int i=0,flag=0;               //flag for checking if negative
	float n=0,prec=0.1;
	if(str[0]=='-')
	{
		flag=1;i=1;
		if(str[1]=='.' || str[1]=='\n')
		{
			error=ERR;
			prints("Invalid integer part before decimal\n");
			return error;
		}                         //only a "-" or "-." will be invalid input
	}
	while(str[i]!='\n' && str[i]!='.')
	{
		if(str[i]<'0' || str[i]>'9')
		{
			error=ERR;
			prints("Invalid character before decimal\n");
			return error;
		}                        //not a digit
		int d=str[i]-'0';
		n=n*10+d;
		i++;                      //converting a string to a floating point number
	}
	if(str[i]=='.')
		i++;
	while(str[i]!='\n')
	{
		if(str[i]<'0' || str[i]>'9')
		{
			error=ERR;
			prints("Invalid character after decimal\n");
			return error;
		}                         //not a digit after decimal
		int d=str[i]-'0';
		n=n+(float)d*prec;
		prec=prec*0.1;            //converting numbers after decimal point
		i++;
	}
	if(flag==1)
		n=-n;
	*fP=n;
	return error;
}
int printd(float f)               //function to print float
{
	char str[SIZE];
	int len=0;
	if(f==0)                       //check if input is 0 then just print 0
	{
		str[0]='0';
		len++;
		__asm__ __volatile__ (
		"movl $1, %%eax \n\t"
		"movq $1, %%rdi \n\t"
		"syscall \n\t"
		:
		:"S"(str), "d"(len)
		) ; 
		return len;
	} 
	if(f<0)          				//check if input is negative then just append a '-' sign             
	{
		str[len++]='-';
		f=-f;
	}
	int integer=(int)f;
	float decimal=f-integer;        //calculate the integer and fractional part of f
	if(integer==0)
	{
		str[len++]='0';
	}
	else
	{
		int i=len;
		while(integer)            //extracting the integer part digit by digit
		{
			int d=integer%10;
			str[len++]=d+'0';
			integer=integer/10;
		}
		int j=len-1;
		for(;i<j;)                  //reversing the digits
		{
			char t=str[j];
			str[j]=str[i];
			str[i]=t;
			i++;j--;
		}
	}
	if(decimal==0)                  //if decimal part is 0 no need to print a '.' symbol
	{
		__asm__ __volatile__ (
		"movl $1, %%eax \n\t"
		"movq $1, %%rdi \n\t"
		"syscall \n\t"
		:
		:"S"(str), "d"(len)
		) ; // $4: write, $1: on stdin
		return len;
		return len;
	}
	str[len++]='.';                 //decimal part non-zro
	decimal=decimal*10;
	int exec=1;
	while(decimal!=0 && exec<=6)    //printing uptil decimal part becomes zero or uptil 6 digits of precision
	{
		int d=(int)decimal;
		str[len++]=d+'0';
		decimal=decimal-d;
		decimal=decimal*10; 
		exec++;
	}
	__asm__ __volatile__ (
		"movl $1, %%eax \n\t"
		"movq $1, %%rdi \n\t"
		"syscall \n\t"
		:
		:"S"(str), "d"(len)
		) ;                        //print the string
		return len;
}