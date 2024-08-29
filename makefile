
CC=gcc

connect4: connect4.m
	rumur connect4.m --output connect4.c
	$(CC) -mcx16 -std=c11 -O3 connect4.c -lpthread
	./a.out
