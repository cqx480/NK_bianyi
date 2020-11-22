CXX = g++
CXXFLAGS = -Wall -Werror -Wextra -pedantic -std=c++17 -g -fsanitize=address
LDFLAGS =  -fsanitize=address

SRC = 
OBJ = $(SRC:.cc=.o)
EXEC = main

.PHONY:lc,lcc,clean

lcc:
	flex -+ testcc.l
	g++ lex.yy.cc -o lcc.out
	./lcc.out <testin >testout
clean:
	rm *.out lex.yy.cc