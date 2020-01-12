nasm -f macho64 main.s
ld -lSystem main.o
./a.out
echo $?
