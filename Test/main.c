#include "myl.h"
int main()
{
	int n,error=0;
	prints("Enter a 32bit signed integer: ");
	n=readi(&error);
	while(error==1)
	{
		prints("Error in reading integer\n");
		prints("Enter a 32bit signed integer: ");
		n=readi(&error);
	}
	if(error==0)
	{
		int characters=printi(n);
		prints("\n");
		prints("No of chaaracter printed = ");
		printi(characters);
		prints("\n");
	}
	prints("\n");
	prints("Enter a floating point number: ");
	float input;
	error=readf(&input);
	while(error==1)
	{
		prints("Enter a floating point number: ");
		error=readf(&input);
	}
	if(error==0)
	{
		int characters=printd(input);
		prints("\n");
		prints("No of chaaracter printed = ");
		printi(characters);
		prints("\n");
	}
	prints("\n");
	return 0;
}