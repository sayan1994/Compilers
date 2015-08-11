/* 
 * main_print_int.c++ 
 * A system call to print an integer 
 */
#include <iostream>
using namespace std;
#include "printInt.h"
int main() // mainPrintInt.c++
{ 
    int n;

    cout << "Enter an integer: ";     
    cin >> n;
    print_int(n);
    return 0;
}
