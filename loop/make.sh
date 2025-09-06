#!/bin/bash

#  компиляция программы
echo "=== Компиляция программы ==="
nasm -f elf64 main.asm -o main.o || exit 1
ld -o main main.o || exit 1

#  запуск программы

echo "=== Запуск программы ==="
./main
rm -f main.o main