.data
temp: .space 352
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

__tak:
add $11, $29, 0
add $12, $29, 4
add $13, $29, 8
lw $14, 0($12)
lw $15, 0($11)
sub $15, $14, $15
bgez $15, l0
li $14, 1
sw $31, -172($29)
sw $31, -184($29)
add $15, $29, -188
lw $16, 0($12)
sw $16, 0($15)
add $15, $29, -192
lw $16, 0($11)
sw $16, 0($15)
lw $15, 0($13)
sub $15, $15, 1
add $16, $29, -196
sw $15, 0($16)
add $29, $29, -196
sw $11, 192($sp)
sw $12, 188($sp)
sw $13, 184($sp)
sw $14, 172($sp)
jal __tak
lw $11, 192($sp)
lw $12, 188($sp)
lw $13, 184($sp)
lw $14, 172($sp)
sub $29, $29, -196
lw $31, -184($29)
add $15, $29, -180
add $16, $29, -176
lw $17, 0($15)
sw $17, 0($16)
sw $31, -188($29)
add $15, $29, -192
lw $16, 0($11)
sw $16, 0($15)
add $15, $29, -196
lw $16, 0($13)
sw $16, 0($15)
lw $15, 0($12)
sub $15, $15, 1
add $16, $29, -200
sw $15, 0($16)
add $29, $29, -200
sw $11, 196($sp)
sw $12, 192($sp)
sw $13, 188($sp)
sw $14, 176($sp)
jal __tak
lw $11, 196($sp)
lw $12, 192($sp)
lw $13, 188($sp)
lw $14, 176($sp)
sub $29, $29, -200
lw $31, -188($29)
add $15, $29, -184
add $16, $29, -180
lw $17, 0($15)
sw $17, 0($16)
sw $31, -192($29)
add $15, $29, -196
lw $16, 0($13)
sw $16, 0($15)
add $15, $29, -200
lw $16, 0($12)
sw $16, 0($15)
lw $12, 0($11)
sub $12, $12, 1
add $11, $29, -204
sw $12, 0($11)
add $29, $29, -204
sw $13, 192($sp)
sw $14, 180($sp)
jal __tak
lw $13, 192($sp)
lw $14, 180($sp)
sub $29, $29, -204
lw $31, -192($29)
add $11, $29, -188
add $12, $29, -184
lw $15, 0($11)
sw $15, 0($12)
add $29, $29, -184
sw $13, 172($sp)
sw $14, 160($sp)
jal __tak
lw $13, 172($sp)
lw $14, 160($sp)
sub $29, $29, -184
lw $31, -172($29)
add $11, $29, -168
lw $12, 0($11)
add $14, $14, $12
add $11, $29, 16
sw $14, 0($11)
jr $ra
j l1
l0:
add $11, $29, 16
lw $12, 0($13)
sw $12, 0($11)
jr $ra
l1:
jr $ra
main:
la $a3, temp
la $t0, var0
sw $t0, 336($a3)
add $11, $29, -180
add $13, $29, -184
add $14, $29, -188
move $15, $11
li $16, 10
add $29, $29, -196
sw $11, 188($sp)
sw $13, 180($sp)
sw $14, 172($sp)
sw $15, 168($sp)
sw $16, 164($sp)
jal __getchar
lw $11, 188($sp)
lw $13, 180($sp)
lw $14, 172($sp)
lw $15, 168($sp)
lw $16, 164($sp)
sub $29, $29, -196
add $17, $29, -192
lw $18, 0($17)
sub $18, $18, 48
mul $16, $16, $18
add $29, $29, -196
sw $11, 188($sp)
sw $13, 180($sp)
sw $14, 172($sp)
sw $15, 168($sp)
sw $16, 164($sp)
jal __getchar
lw $11, 188($sp)
lw $13, 180($sp)
lw $14, 172($sp)
lw $15, 168($sp)
lw $16, 164($sp)
sub $29, $29, -196
add $17, $29, -192
lw $18, 0($17)
add $16, $16, $18
sub $16, $16, 48
sw $16, 0($15)
add $29, $29, -196
sw $11, 188($sp)
sw $13, 180($sp)
sw $14, 172($sp)
jal __getchar
lw $11, 188($sp)
lw $13, 180($sp)
lw $14, 172($sp)
sub $29, $29, -196
add $15, $29, -192
move $15, $13
li $16, 10
add $29, $29, -196
sw $11, 188($sp)
sw $13, 180($sp)
sw $14, 172($sp)
sw $15, 128($sp)
sw $16, 124($sp)
jal __getchar
lw $11, 188($sp)
lw $13, 180($sp)
lw $14, 172($sp)
lw $15, 128($sp)
lw $16, 124($sp)
sub $29, $29, -196
add $17, $29, -192
lw $18, 0($17)
sub $18, $18, 48
mul $16, $16, $18
add $29, $29, -196
sw $11, 188($sp)
sw $13, 180($sp)
sw $14, 172($sp)
sw $15, 128($sp)
sw $16, 124($sp)
jal __getchar
lw $11, 188($sp)
lw $13, 180($sp)
lw $14, 172($sp)
lw $15, 128($sp)
lw $16, 124($sp)
sub $29, $29, -196
add $17, $29, -192
lw $18, 0($17)
add $16, $16, $18
sub $16, $16, 48
sw $16, 0($15)
add $29, $29, -196
sw $11, 188($sp)
sw $13, 180($sp)
sw $14, 172($sp)
jal __getchar
lw $11, 188($sp)
lw $13, 180($sp)
lw $14, 172($sp)
sub $29, $29, -196
add $15, $29, -192
move $15, $14
add $29, $29, -196
sw $11, 188($sp)
sw $13, 180($sp)
sw $14, 172($sp)
sw $15, 88($sp)
jal __getchar
lw $11, 188($sp)
lw $13, 180($sp)
lw $14, 172($sp)
lw $15, 88($sp)
sub $29, $29, -196
add $16, $29, -192
lw $17, 0($16)
sub $17, $17, 48
sw $17, 0($15)
add $15, $29, -208
lw $16, 0($14)
sw $16, 0($15)
add $14, $29, -212
lw $15, 0($13)
sw $15, 0($14)
add $13, $29, -216
lw $14, 0($11)
sw $14, 0($13)
add $29, $29, -216
jal __tak
sub $29, $29, -216
add $11, $29, -200
add $13, $29, -196
lw $14, 0($11)
sw $14, 0($13)
lw $12, 336($a3)
move $11, $12
add $12, $29, -200
sw $11, 0($12)
add $29, $29, -200
jal __printf
sub $29, $29, -200
li $11, 0
add $12, $29, 4
sw $11, 0($12)
j __main_end
j __main_end
__main_end:
li $v0, 10
syscall
