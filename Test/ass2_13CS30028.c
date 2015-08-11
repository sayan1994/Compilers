#include "myl.h"
#define SIZE 1000
int prints(char * str)
{
	int len=0;
	while(str[len]!='\0')
	{
		len++;
	}
	__asm__ __volatile__ (
		"movl $1, %%eax \n\t"
		"movq $1, %%rdi \n\t"
		"syscall \n\t"
		:
		:"S"(str), "d"(len)
		) ; // $4: write, $1: on stdin
	return len;
}
int printi(int n)
{
	char str[SIZE];
	int len=0,i,j;
	if(n==0)
	{
		str[0]='0';
		len++;
	}
	if(n<0)
	{
		str[0]='-';
		len++;
		n=-n;
	}
	while(n!=0)
	{
		int digit=n%10;
		str[len]=digit+'0';
		len++;
		n=n/10;
	}
	i=0;j=len-1;
	if(str[i]=='-')
		i++;
	for(;i<j;)
	{
		char t=str[j];
		str[j]=str[i];
		str[i]=t;
		i++;j--;
	}
	__asm__ __volatile__ (
		"movl $1, %%eax \n\t"
		"movq $1, %%rdi \n\t"
		"syscall \n\t"
		:
		:"S"(str), "d"(len)
		) ; // $4: write, $1: on stdin
	return len;
}
int readi(int *eP)
{
	*eP=OK;
	char str[SIZE];
	__asm__ __volatile__(
		"movl $0 ,%%eax \n\t"
		"movq $0 ,%%rdi \n\t"
		"syscall \n\t"
		:
		: "S"(str) , "d"(SIZE)
	);
	int i=0,flag=0;
	long long int n=0;
	if(str[i]=='-')
	{
		flag=1;i=1;
		if(str[i+1]=='\n')
		{
			*eP=ERR;
			prints("Invalid integer\n");
			return 0;
		}
	}
	while(str[i]!='\n')
	{
		if(str[i]<'0' || str[i]>'9')
		{
			*eP=ERR;
			prints("Invalid character\n");
			return 0;
		}
		int d=str[i]-'0';
		n=n*10+d;
		i++;
		if( n<-2147483648 || n>2147483647)
		{
			*eP=ERR;
			prints("Overflow\n");
			return 0;
		}
	}
	if(flag==1)
		n=-n;
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
	);
	int i=0,flag=0;
	float n=0,prec=0.1;
	if(str[0]=='-')
	{
		flag=1;i=1;
		if(str[1]=='.' || str[1]=='\n')
		{
			error=ERR;
			prints("Invalid integer part before decimal\n");
			return error;
		}
	}
	while(str[i]!='\n' && str[i]!='.')
	{
		if(str[i]<'0' || str[i]>'9')
		{
			error=ERR;
			prints("Invalid character before decimal\n");
			return error;
		}
		int d=str[i]-'0';
		n=n*10+d;
		i++;
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
		}
		int d=str[i]-'0';
		n=n+(float)d*prec;
		prec=prec*0.1;
		i++;
	}
	if(flag==1)
		n=-n;
	*fP=n;
	return error;
}
int printd(float f)
{
	char str[SIZE];
	int len=0;
	if(f==0)
	{
		str[0]='0';
		len++;
		__asm__ __volatile__ (
		"movl $1, %%eax \n\t"
		"movq $1, %%rdi \n\t"
		"syscall \n\t"
		:
		:"S"(str), "d"(len)
		) ; // $4: write, $1: on stdin
		return len;
	}
	if(f<0)
	{
		str[len++]='-';
		f=-f;
	}
	int integer=(int)f;
	float decimal=f-integer;
	if(integer==0)
	{
		str[len++]='0';
	}
	else
	{
		int i=len;
		while(integer)
		{
			int d=integer%10;
			str[len++]=d+'0';
			integer=integer/10;
		}
		int j=len-1;
		for(;i<j;)
		{
			char t=str[j];
			str[j]=str[i];
			str[i]=t;
			i++;j--;
		}
	}
	if(decimal==0)
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
	str[len++]='.';
	decimal=decimal*10;
	int exec=1;
	while(decimal!=0 && exec<=6)
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
		) ; // $4: write, $1: on stdin
		return len;
}