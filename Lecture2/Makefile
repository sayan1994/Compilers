a.out: mainPrintInt.o libprintInt.a
	c++ mainPrintInt.o -L. -lprintInt 

mainPrintInt.o:	mainPrintInt.c++ printInt.h
	c++ -Wall -c mainPrintInt.c++

libprintInt.a:	printInt.o
		ar -rcs libprintInt.a printInt.o

printInt.o:	printInt.c++ printInt.h
	c++ -Wall -c printInt.c++
clean:
	rm a.out mainPrintInt.o libprintInt.a printInt.o
