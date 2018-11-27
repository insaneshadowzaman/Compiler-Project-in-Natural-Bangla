a.out: main.tab.c lex.yy.c
	gcc main.tab.c lex.yy.c -w -o a.out -lm

main.tab.c: main.y
	bison -d main.y

main.tab.h: main.y
	bison -d main.y

lex.yy.c: main.l
	flex main.l

clean:
	rm *.c *.h *.out

run: a.out input.txt output.txt
	./a.out