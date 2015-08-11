a.out: main.o libass2_13CS30028.a
	cc main.o -L. -lass2_13CS30028

mainPrintInt.o:	main.c myl.h
	cc -Wall -c main.c

libass2_13CS30028.a:	ass2_13CS30028.o
		ar -rcs libass2_13CS30028.a ass2_13CS30028.o

ass2_13CS30028.o:	ass2_13CS30028.c myl.h
	cc -Wall -c ass2_13CS30028.c
clean:
	rm a.out main.o libass2_13CS30028.a ass2_13CS30028.o
