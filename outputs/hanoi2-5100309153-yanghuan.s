.data
temp: .space 276
var0: .asciiz "%c -> %c\n"
.align 2
var1: .asciiz "%c -> %c\n"
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
beq $a2, '%', __printf_format
beq $a2, '\\', __printf_trans
__printf_normal:
li $v0, 11
lb $a0, ($t1)
syscall
j __printf_loop

__printf_format:
lb $t0, 1($t1)
beq $t0, 'c', __printf_format_c
beq $t0, 'd', __printf_format_d
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

__hanoi:
add $12, $29, 0
add $14, $29, 4
add $15, $29, 8
add $16, $29, 12
lw $17, 0($16)
li $18, 1
sub $18, $17, $18
blez $18, l0
sw $31, -176($29)
lw $17, 0($16)
sub $17, $17, 1
add $18, $29, -180
sw $17, 0($18)
add $17, $29, -184
lb $18, 0($14)
sb $18, 0($17)
add $17, $29, -188
lb $18, 0($15)
sb $18, 0($17)
add $17, $29, -192
lb $18, 0($12)
sb $18, 0($17)
add $29, $29, -192
sw $12, 188($sp)
sw $14, 184($sp)
sw $15, 180($sp)
sw $16, 176($sp)
jal __hanoi
lw $12, 188($sp)
lw $14, 184($sp)
lw $15, 180($sp)
lw $16, 176($sp)
sub $29, $29, -192
lw $31, -176($29)
add $17, $29, -172
move $18, $17
sw $31, -172($29)
add $17, $29, -176
lb $18, 0($15)
sb $18, 0($17)
add $17, $29, -180
lb $18, 0($12)
sb $18, 0($17)
lw $11, 100($a3)
move $17, $11
add $11, $29, -184
sw $17, 0($11)
add $29, $29, -184
jal __printf
sub $29, $29, -184
lw $31, -172($29)
sw $31, -176($29)
lw $11, 0($16)
sub $11, $11, 1
add $16, $29, -180
sw $11, 0($16)
add $11, $29, -184
lb $16, 0($15)
sb $16, 0($11)
add $11, $29, -188
lb $16, 0($12)
sb $16, 0($11)
add $11, $29, -192
lb $16, 0($14)
sb $16, 0($11)
add $29, $29, -192
sw $12, 188($sp)
sw $15, 180($sp)
jal __hanoi
lw $12, 188($sp)
lw $15, 180($sp)
sub $29, $29, -192
lw $31, -176($29)
add $11, $29, -172
move $14, $11
j l1
l0:
sw $31, -172($29)
add $11, $29, -176
lb $14, 0($15)
sb $14, 0($11)
add $11, $29, -180
lb $14, 0($12)
sb $14, 0($11)
lw $13, 176($a3)
move $11, $13
add $12, $29, -184
sw $11, 0($12)
add $29, $29, -184
jal __printf
sub $29, $29, -184
lw $31, -172($29)
l1:
jr $ra
main:
la $a3, temp
la $t0, var0
sw $t0, 100($a3)
la $t0, var1
sw $t0, 176($a3)
add $11, $29, -96
move $12, $11
li $11, 10
add $29, $29, -104
sw $11, 92($sp)
sw $12, 100($sp)
jal __getchar
lw $11, 92($sp)
lw $12, 100($sp)
sub $29, $29, -104
add $13, $29, -100
lw $14, 0($13)
sub $14, $14, 48
mul $11, $11, $14
add $29, $29, -104
sw $11, 92($sp)
sw $12, 100($sp)
jal __getchar
lw $11, 92($sp)
lw $12, 100($sp)
sub $29, $29, -104
add $13, $29, -100
lw $14, 0($13)
add $11, $11, $14
sub $11, $11, 48
sw $11, 0($12)
lw $11, 0($12)
li $13, 0
sub $13, $11, $13
blez $13, l2
add $11, $29, -108
lw $13, 0($12)
sw $13, 0($11)
li $11, 99
add $12, $29, -112
sb $11, 0($12)
li $11, 98
add $12, $29, -116
sb $11, 0($12)
li $11, 97
add $12, $29, -120
sb $11, 0($12)
add $29, $29, -120
jal __hanoi
sub $29, $29, -120
add $11, $29, -100
move $12, $11
l2:
li $11, 0
add $12, $29, 4
sw $11, 0($12)
j __main_end
j __main_end
__main_end:
li $v0, 10
syscall
