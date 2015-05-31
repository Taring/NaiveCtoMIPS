.data
temp: .space 380
var0: .asciiz "move %c --> %c\n"
.align 2
var1: .asciiz "move %c --> %c\n"
.align 2
var2: .asciiz "%d\n"
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

__cd:
add $13, $29, 0
add $14, $29, 4
add $15, $29, 8
add $16, $29, 12
add $17, $29, 16
lw $18, 0($13)
li $19, 1
sub $19, $18, $19
bnez $19, l0
sw $31, -232($29)
add $18, $29, -236
lb $19, 0($16)
sb $19, 0($18)
add $18, $29, -240
lb $19, 0($14)
sb $19, 0($18)
lw $11, 60($a3)
move $18, $11
add $11, $29, -244
sw $18, 0($11)
add $29, $29, -244
jal __printf
sub $29, $29, -244
lw $31, -232($29)
move $11, $17
lw $18, 0($17)
add $19, $18, 1
sw $19, 0($11)
j l1
l0:
move $11, $17
sw $31, -236($29)
add $18, $29, -240
lw $19, 0($17)
sw $19, 0($18)
add $18, $29, -244
lb $19, 0($15)
sb $19, 0($18)
add $18, $29, -248
lb $19, 0($16)
sb $19, 0($18)
add $18, $29, -252
lb $19, 0($14)
sb $19, 0($18)
lw $18, 0($13)
sub $18, $18, 1
add $19, $29, -256
sw $18, 0($19)
add $29, $29, -256
sw $11, 184($sp)
sw $13, 252($sp)
sw $14, 248($sp)
sw $15, 244($sp)
sw $16, 240($sp)
sw $17, 236($sp)
jal __cd
lw $11, 184($sp)
lw $13, 252($sp)
lw $14, 248($sp)
lw $15, 244($sp)
lw $16, 240($sp)
lw $17, 236($sp)
sub $29, $29, -256
lw $31, -236($29)
add $18, $29, -232
lw $19, 0($18)
sw $19, 0($11)
sw $31, -232($29)
add $11, $29, -236
lb $18, 0($16)
sb $18, 0($11)
add $11, $29, -240
lb $18, 0($14)
sb $18, 0($11)
lw $12, 160($a3)
move $11, $12
add $12, $29, -244
sw $11, 0($12)
add $29, $29, -244
jal __printf
sub $29, $29, -244
lw $31, -232($29)
move $11, $17
sw $31, -236($29)
add $12, $29, -240
lw $18, 0($17)
sw $18, 0($12)
add $12, $29, -244
lb $18, 0($16)
sb $18, 0($12)
add $12, $29, -248
lb $16, 0($14)
sb $16, 0($12)
add $12, $29, -252
lb $14, 0($15)
sb $14, 0($12)
lw $12, 0($13)
sub $12, $12, 1
add $13, $29, -256
sw $12, 0($13)
add $29, $29, -256
sw $11, 100($sp)
sw $17, 236($sp)
jal __cd
lw $11, 100($sp)
lw $17, 236($sp)
sub $29, $29, -256
lw $31, -236($29)
add $12, $29, -232
lw $13, 0($12)
sw $13, 0($11)
move $11, $17
lw $12, 0($17)
add $13, $12, 1
sw $13, 0($11)
l1:
add $11, $29, 24
lw $12, 0($17)
sw $12, 0($11)
jr $ra
jr $ra
main:
la $a3, temp
la $t0, var0
sw $t0, 60($a3)
la $t0, var1
sw $t0, 160($a3)
la $t0, var2
sw $t0, 364($a3)
add $11, $29, -136
move $13, $11
li $11, 65
sw $11, 0($13)
add $11, $29, -140
move $14, $11
li $11, 66
sw $11, 0($14)
add $11, $29, -144
move $15, $11
li $11, 67
sw $11, 0($15)
add $11, $29, -148
move $16, $11
li $11, 10
sw $11, 0($16)
add $11, $29, -152
move $17, $11
li $11, 0
add $18, $29, -164
sw $11, 0($18)
add $11, $29, -168
lb $18, 0($15)
sb $18, 0($11)
add $11, $29, -172
lb $15, 0($14)
sb $15, 0($11)
add $11, $29, -176
lb $14, 0($13)
sb $14, 0($11)
add $11, $29, -180
lw $13, 0($16)
sw $13, 0($11)
add $29, $29, -180
sw $17, 128($sp)
jal __cd
lw $17, 128($sp)
sub $29, $29, -180
add $11, $29, -156
lw $13, 0($11)
sw $13, 0($17)
add $11, $29, -160
lw $13, 0($17)
sw $13, 0($11)
lw $12, 364($a3)
move $11, $12
add $12, $29, -164
sw $11, 0($12)
add $29, $29, -164
jal __printf
sub $29, $29, -164
li $11, 0
add $12, $29, 4
sw $11, 0($12)
j __main_end
j __main_end
__main_end:
li $v0, 10
syscall
