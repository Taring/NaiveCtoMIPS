.data
temp: .space 76
var0: .asciiz "%d\n"
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

__f:
add $8, $29, 0
sw $8, -4($sp)
li $8, 0
sw $8, -8($sp)
add $8, $29, 8
sw $8, -12($sp)
lw $8, -8($sp)
lw $9, -12($sp)
sw $8, 0($9)
jr $ra
jr $ra
main:
la $a3, temp
la $t0, var0
sw $t0, 60($a3)
add $8, $29, -56
sw $8, -8($sp)
lw $9, -8($sp)
move $8, $9
sw $8, -4($sp)
add $8, $29, -68
sw $8, -20($sp)
lw $9, -8($sp)
lw $8, 0($9)
sw $8, -16($sp)
lw $8, -16($sp)
lw $9, -20($sp)
sw $8, 0($9)
add $29, $29, -68
jal __f
sub $29, $29, -68
add $8, $29, -60
sw $8, -24($sp)
lw $9, -24($sp)
lw $8, 0($9)
sw $8, -12($sp)
lw $8, -12($sp)
lw $9, -4($sp)
sw $8, 0($9)
add $8, $29, -64
sw $8, -36($sp)
lw $9, -4($sp)
lw $8, 0($9)
sw $8, -32($sp)
lw $8, -32($sp)
lw $9, -36($sp)
sw $8, 0($9)
lw $9, 60($a3)
move $8, $9
sw $8, -40($sp)
add $8, $29, -68
sw $8, -44($sp)
lw $8, -40($sp)
lw $9, -44($sp)
sw $8, 0($9)
add $29, $29, -68
jal __printf
sub $29, $29, -68
add $8, $29, 4
sw $8, -52($sp)
lw $9, -4($sp)
lw $8, 0($9)
sw $8, -48($sp)
lw $8, -48($sp)
lw $9, -52($sp)
sw $8, 0($9)
j __main_end
j __main_end
__main_end:
li $v0, 10
syscall
#string $15 #%d\n
#----------------------------
#func #f
#addi $2 $0 0
#li $3 0
#addi $4 $0 8
#sw $3 $4 0
#return
#return
#----------------------------
#func #main
#addi $6 $0 -56
#move $5 $6
####move $8 $6
#addi $9 $0 -68
#lw $8 $6 0
#sw $8 $9 0
#addi $0 $0 -68
#call #f
#subi $0 $0 -68
#addi $10 $0 -60
####move $7 $10
#lw $7 $10 0
#sw $7 $5 0
####move $12 $5
#addi $13 $0 -64
#lw $12 $5 0
#sw $12 $13 0
#move $14 $15
#addi $16 $0 -68
#sw $14 $16 0
#addi $0 $0 -68
#call #printf
#subi $0 $0 -68
####move $17 $5
#addi $18 $0 4
#lw $17 $5 0
#sw $17 $18 0
#return
#return
