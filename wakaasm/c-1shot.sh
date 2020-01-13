nasm -f macho32 main-1shot.s
nasm -o main-1shot.bin main-1shot.s
ld -lSystem main-1shot.o
./a.out
echo
#echo $?
