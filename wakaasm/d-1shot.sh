nasm -o main-1shot.bin main-1shot.s
ls -l main-1shot.bin
nasm -f macho32 main-1shot.s
objdump -d main-1shot.o
