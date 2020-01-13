nasm -o main.bin main.s
ls -l main.bin
nasm -f macho32 main.s
objdump -d main.o
