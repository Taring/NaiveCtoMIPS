.data
temp: .space 72
var0: .space 4
var1: .asciiz "#include <stdio.h>%cchar*f=%c%s%c;int main(){printf(f,10,34,f,34,10);}%c"
.align 2

.text
__malloc:
lw $a0, ($sp)
li $v0, 9
syscall
sw $v0, 8($sp)
jr $ra

__getchar:
li $v0, 12
syscall
sw $v0, 4($sp)
jr $ra

__printf_single:
li $v0, 4
lw $a0, ($sp)
syscall
jr $ra

__printf:
add $t2, $sp, 4
lw $t1, ($sp)
add $t1, $t1, -1
__printf_loop:
add $t1, $t1, 1
lb $a2, ($t1)
beq $a2, 0, __printf_end
beq $a2, '%', __printf_format           # %04d, %d, %c, %s, %04d <-> only positve integer
beq $a2, '\\', __printf_trans            # \n, \t
__printf_normal:
li $v0, 11
lb $a0, ($t1)
syscall
j __printf_loop

__printf_format:
lb $t0, 1($t1)
beq $t0, 'd', __printf_format_d
beq $t0, 'c', __printf_format_c
beq $t0, 's', __printf_format_s
beq $t0, '0', __printf_format_04d
beq $t0, '.', __printf_format_dot_3d
j __printf_normal

__printf_format_d:
li $v0, 1
lw $a0, ($t2)
syscall
j __printf_format_cont

__printf_format_c:
li $v0, 11
lb $a0, ($t2)
syscall
j __printf_format_cont

__printf_format_s:
li $v0, 4
lw $a0, ($t2)
syscall
j __printf_format_cont

__printf_format_04d:
add $t1, $t1, 2
lw $a2, ($t2)
bge $a2, 1000, __printf_format_04d_1000
li $v0, 11
li $a0, '0'
syscall
__printf_format_04d_1000:
bge $a2, 100, __printf_format_04d_100
li $v0, 11
li $a0, '0'
syscall
__printf_format_04d_100:
bge $a2, 10, __printf_format_04d_10
li $v0, 11
li $a0, '0'
syscall
__printf_format_04d_10:
li $v0, 1
move $a0, $a2
syscall
j __printf_format_cont

__printf_format_dot_3d:
add $t1 $t1 2
lw $a2, ($t2)
bge $a2, 100, __printf_format_dot_3d_100
li $v0 11
li $a0 '0'
syscall
__printf_format_dot_3d_100:
bge $a2, 10, __printf_format_dot_3d_10
li $v0, 11
li $a0, '0'
syscall
__printf_format_dot_3d_10:
li $v0 1
move $a0, $a2
syscall

__printf_format_cont:
add $t2, $t2, 4
add $t1, $t1, 1
j __printf_loop

__printf_trans:
li $v0, 11
lb $a0, 1($t1)
syscall
add $t1, $t1, 1
j __printf_loop

__printf_end:
jr $ra

main:
la $a3, temp
la $t0, var0
sw $t0, 8($a3)
la $t0, var1
sw $t0, 16($a3)
lw $9, 16($a3)
move $8, $9
sw $8, 12($a3)
lw $8, 12($a3)
lw $9, 8($a3)
sw $8, 0($9)
li $8, 10
sw $8, -8($sp)
add $8, $29, -60
sw $8, -12($sp)
lw $8, -8($sp)
lw $9, -12($sp)
sw $8, 0($9)
li $8, 34
sw $8, -16($sp)
add $8, $29, -64
sw $8, -20($sp)
lw $8, -16($sp)
lw $9, -20($sp)
sw $8, 0($9)
add $8, $29, -68
sw $8, -28($sp)
lw $9, 8($a3)
lw $8, 0($9)
sw $8, -24($sp)
lw $8, -24($sp)
lw $9, -28($sp)
sw $8, 0($9)
li $8, 34
sw $8, -32($sp)
add $8, $29, -72
sw $8, -36($sp)
lw $8, -32($sp)
lw $9, -36($sp)
sw $8, 0($9)
li $8, 10
sw $8, -40($sp)
add $8, $29, -76
sw $8, -44($sp)
lw $8, -40($sp)
lw $9, -44($sp)
sw $8, 0($9)
add $8, $29, -80
sw $8, -52($sp)
lw $9, 8($a3)
lw $8, 0($9)
sw $8, -48($sp)
lw $8, -48($sp)
lw $9, -52($sp)
sw $8, 0($9)
add $29, $29, -80
jal __printf
sub $29, $29, -80
j __main_end
__main_end:
li $v0, 10
syscall
#global $2 4
#string $4 ##include <stdio.h>%cchar*f=%c%s%c;int main(){printf(f,10,34,f,34,10);}%c
#move $3 $4
#sw $3 $2 0
#----------------------------
#func #main
#li $6 10
#addi $7 $0 -60
#sw $6 $7 0
#li $8 34
#addi $9 $0 -64
#sw $8 $9 0
####move $10 $2
#addi $11 $0 -68
#lw $10 $2 0
#sw $10 $11 0
#li $12 34
#addi $13 $0 -72
#sw $12 $13 0
#li $14 10
#addi $15 $0 -76
#sw $14 $15 0
####move $16 $2
#addi $17 $0 -80
#lw $16 $2 0
#sw $16 $17 0
#addi $0 $0 -80
#call #printf
#subi $0 $0 -80
#return
