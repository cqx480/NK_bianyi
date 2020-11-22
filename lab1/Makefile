.PHONY:pre,ast,ir,asm,obj,exe,antiobj,antiexe

pre:
	gcc main.c -E -o main.i

ast:
	gcc -fdump-tree-original-raw main.c

cfg:
	gcc -O0 -fdump-tree-all-graph main.c

ir:
	gcc -O0 -fdump-rtl-all-graph main.c

asm: pre
	gcc -O0 -o main.S -S -masm=att main.i

obj: asm
	gcc -O0 -c -o main.o main.S

antiobj:
	objdump -d main.o >main-anti-obj.S
	nm main.o > main-nm-obj.txt

exe:
	gcc -O0 -o main main.o

antiexe:
	objdump -d main > main-anti-exe.S
	nm main > main-nm-exe.txt

clean:
	rm *.c.*

clean-all:
	rm *.c.* *.o *.S *.dot *.out *.txt main