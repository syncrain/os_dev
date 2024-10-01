rm -rf bin/boot.o
rm -rf bin/kernel.o

nasm -felf32 src/kernel.asm -o bin/kernel.o
nasm -felf32 src/boot.asm -o bin/boot.o

i686-elf-gcc -T src/linker.ld -o myos.bin -ffreestanding -O2 -nostdlib bin/boot.o bin/kernel.o -lgcc
mkdir -p isodir/boot/grub
mv myos.bin isodir/boot/myos.bin

cp src/grub.cfg isodir/boot/grub/grub.cfg

grub-mkrescue -o myos.iso isodir
qemu-system-i386 -cdrom myos.iso
