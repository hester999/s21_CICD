C = gcc
FLAGS = -Wall -Werror -Wextra -std=c11

all: s21_cat


s21_cat: s21_cat.o parse.o
	$(C) $(FLAGS) s21_cat.o parse.o -o s21_cat
	rm -f *.o

s21_cat.o: s21_cat.c
	$(C) $(FLAGS) -c s21_cat.c

parse.o: parse.c
	$(C) $(FLAGS) -c parse.c

clean:
	rm -f *.o 
