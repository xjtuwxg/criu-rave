CC	:= gcc
CFLAGS	:= -g -fno-omit-frame-pointer
LDFLAGS	:= -static

all: loop

loop: loop.c
	$(CC) $(CFLAGS) $(LDFLAGS) $^ -o $@

clean:
	rm -rf loop
