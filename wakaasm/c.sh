nasm -f macho32 main.s
nasm -o main.bin main.s
ld -lSystem main.o
./a.out
echo
#echo $?
