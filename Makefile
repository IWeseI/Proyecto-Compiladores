# Makefile

OBJS	= bison.o lex.o main.o

CC	= g++
CFLAGS	= -g -Wall -ansi -pedantic

ce:		$(OBJS)
		$(CC) $(CFLAGS) $(OBJS) -o ce -lfl

lex.o:		lex.c
		$(CC) $(CFLAGS) -c lex.c -o lex.o

lex.c:		ce.l 
		flex ce.l
		cp lex.yy.c lex.c

bison.o:	bison.c
		$(CC) $(CFLAGS) -c bison.c -o bison.o

bison.c:	ce.y
		bison -d -v ce.y
		cp ce.tab.c bison.c
		cmp -s ce.tab.h tok.h || cp ce.tab.h tok.h

main.o:		main.cc
		$(CC) $(CFLAGS) -c main.cc -o main.o

lex.o bison.o main.o	: heading.h
lex.o main.o			: tok.h

clean:
	rm -f *.o *~ lex.c lex.yy.c bison.c tok.h ce.tab.c ce.tab.h ce.output ce
