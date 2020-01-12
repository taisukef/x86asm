nasm -f macho64 hello.s
ld -o hello -lSystem hello.o
./hello
echo $?
