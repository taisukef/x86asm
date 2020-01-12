nasm -f macho32 main.s
ld -lSystem main.o
./a.out
echo $?
