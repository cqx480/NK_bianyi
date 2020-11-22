CXX = g++
CXXFLAGS = -Wall -Werror -Wextra -pedantic -std=c++17 -g -fsanitize=address
LDFLAGS =  -fsanitize=address

SRC = 
OBJ = $(SRC:.cc=.o)
EXEC = main

all: $(EXEC)

$(EXEC): $(OBJ)
	$(CXX) $(LDFLAGS) -o $@ $(OBJ) $(LBLIBS)

t1:
	bison -d  test_1.y
	gcc test_1.tab.c -o test_1
	./test_1

clean1:
	rm -rf test_1.tab.c
	rm -rf test_1.tab.h
	rm -rf test_1

t11:
	bison -d  test_11.y
	gcc test_11.tab.c -o test_11
	./test_11

clean11:
	rm -rf test_11.tab.c
	rm -rf test_11.tab.h
	rm -rf test_11

t2:
	bison -d  test_2.y
	gcc test_2.tab.c -o test_2
	./test_2

clean2:
	rm -rf test_2.tab.c
	rm -rf test_2.tab.h
	rm -rf test_2

t3:
	bison -d  test_3.y
	gcc test_3.tab.c -o test_3
	./test_3

clean3:
	rm -rf test_3.tab.c
	rm -rf test_3.tab.h
	rm -rf test_3