.data
temp: .space 884
var0: .space 48400
var1: .space 4
var2: .space 440
var3: .space 440
var4: .space 440
var5: .space 4
var6: .space 4
var7: .space 4
var8: .space 4
var9: .asciiz "%d \n"
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

__build:
add $12, $29, 0
add $15, $29, 4
lw $14, 28($a3)
move $16, $14
li $17, 1
sw $17, 0($16)
l0:
lw $16, 0($14)
li $17, 49
sub $17, $16, $17
bgtz $17, l1
lw $11, 32($a3)
move $16, $11
li $17, 50
sw $17, 0($16)
l3:
lw $16, 0($11)
li $17, 98
lw $18, 0($14)
sub $17, $17, $18
add $17, $17, 1
sub $17, $16, $17
bgtz $17, l4
lw $16, 0($14)
mul $17, $16, 440
lw $13, 8($a3)
add $16, $13, $17
lw $17, 0($11)
mul $18, $17, 4
add $16, $16, $18
li $17, 1
sw $17, 0($16)
l5:
move $16, $11
lw $17, 0($11)
add $18, $17, 1
sw $18, 0($16)
j l3
l4:
l2:
move $16, $14
lw $17, 0($14)
add $18, $17, 1
sw $18, 0($16)
j l0
l1:
move $11, $14
li $16, 1
sw $16, 0($11)
l6:
lw $11, 0($14)
li $16, 49
sub $16, $11, $16
bgtz $16, l7
lw $11, 0($12)
mul $16, $11, 440
add $11, $13, $16
lw $16, 0($14)
mul $17, $16, 4
add $11, $11, $17
li $16, 1
sw $16, 0($11)
l8:
move $11, $14
lw $16, 0($14)
add $17, $16, 1
sw $17, 0($11)
j l6
l7:
move $11, $14
li $12, 50
sw $12, 0($11)
l9:
lw $11, 0($14)
li $12, 98
sub $12, $11, $12
bgtz $12, l10
lw $11, 0($14)
mul $12, $11, 440
add $11, $13, $12
lw $12, 0($15)
mul $16, $12, 4
add $11, $11, $16
li $12, 1
sw $12, 0($11)
l11:
move $11, $14
lw $12, 0($14)
add $16, $12, 1
sw $16, 0($11)
j l9
l10:
li $11, 0
add $12, $29, 12
sw $11, 0($12)
jr $ra
jr $ra
__find:
add $19, $29, 0
add $20, $29, 4
add $21, $29, 8
lw $18, 36($a3)
move $22, $18
li $23, 0
sw $23, 0($22)
lw $17, 40($a3)
move $22, $17
li $23, 1
sw $23, 0($22)
lw $16, 28($a3)
move $22, $16
li $23, 1
sw $23, 0($22)
l12:
lw $22, 0($16)
lw $23, 0($19)
sub $23, $22, $23
bgtz $23, l13
lw $22, 0($16)
mul $23, $22, 4
lw $15, 16($a3)
add $22, $15, $23
li $23, 0
sw $23, 0($22)
l14:
move $22, $16
lw $23, 0($16)
add $24, $23, 1
sw $24, 0($22)
j l12
l13:
li $22, 1
mul $23, $22, 4
lw $14, 24($a3)
add $22, $14, $23
lw $23, 0($20)
sw $23, 0($22)
lw $22, 0($20)
mul $23, $22, 4
add $22, $15, $23
li $23, 1
sw $23, 0($22)
lw $22, 0($20)
mul $20, $22, 4
lw $13, 20($a3)
add $22, $13, $20
li $20, 0
sw $20, 0($22)
move $20, $21
li $22, 0
sw $22, 0($20)
l15:
lw $20, 0($18)
lw $22, 0($17)
sub $22, $20, $22
bgez $22, l16
lw $20, 0($21)
li $22, 0
sub $22, $20, $22
bnez $22, l16
move $20, $18
lw $22, 0($18)
add $23, $22, 1
sw $23, 0($20)
move $20, $16
lw $22, 0($18)
mul $23, $22, 4
add $22, $14, $23
lw $22, 0($22)
sw $22, 0($20)
lw $12, 32($a3)
move $20, $12
li $22, 1
sw $22, 0($20)
l17:
lw $20, 0($12)
lw $22, 0($19)
sub $22, $20, $22
bgtz $22, l18
lw $20, 0($16)
mul $22, $20, 440
lw $11, 8($a3)
add $20, $11, $22
lw $22, 0($12)
mul $23, $22, 4
add $20, $20, $23
lw $20, 0($20)
li $22, 0
sub $22, $20, $22
blez $22, l20
lw $20, 0($12)
mul $22, $20, 4
add $20, $15, $22
lw $20, 0($20)
li $22, 0
sub $22, $20, $22
bnez $22, l20
lw $20, 0($12)
mul $22, $20, 4
add $20, $15, $22
li $22, 1
sw $22, 0($20)
move $20, $17
lw $22, 0($17)
add $23, $22, 1
sw $23, 0($20)
lw $20, 0($17)
mul $22, $20, 4
add $20, $14, $22
lw $22, 0($12)
sw $22, 0($20)
lw $20, 0($12)
mul $22, $20, 4
add $20, $13, $22
lw $22, 0($16)
sw $22, 0($20)
lw $20, 0($17)
lw $22, 0($19)
sub $22, $20, $22
bnez $22, l21
move $20, $21
li $22, 1
sw $22, 0($20)
l21:
l20:
l19:
move $20, $12
lw $22, 0($12)
add $23, $22, 1
sw $23, 0($20)
j l17
l18:
j l15
l16:
add $11, $29, 16
lw $12, 0($21)
sw $12, 0($11)
jr $ra
jr $ra
__improve:
add $11, $29, 0
lw $16, 28($a3)
move $17, $16
lw $18, 0($11)
sw $18, 0($17)
lw $12, 12($a3)
move $11, $12
lw $17, 0($12)
add $12, $17, 1
sw $12, 0($11)
l22:
lw $11, 0($16)
mul $12, $11, 4
lw $15, 20($a3)
add $11, $15, $12
lw $11, 0($11)
li $12, 0
sub $12, $11, $12
blez $12, l23
lw $14, 32($a3)
move $11, $14
lw $12, 0($16)
mul $17, $12, 4
add $12, $15, $17
lw $12, 0($12)
sw $12, 0($11)
lw $11, 0($14)
mul $12, $11, 440
lw $13, 8($a3)
add $11, $13, $12
lw $12, 0($16)
mul $17, $12, 4
add $11, $11, $17
move $12, $11
lw $11, 0($11)
sub $17, $11, 1
sw $17, 0($12)
lw $11, 0($16)
mul $12, $11, 440
add $11, $13, $12
lw $12, 0($14)
mul $17, $12, 4
add $11, $11, $17
move $12, $11
lw $11, 0($11)
add $17, $11, 1
sw $17, 0($12)
move $11, $16
lw $12, 0($14)
sw $12, 0($11)
j l22
l23:
li $11, 0
add $12, $29, 8
sw $11, 0($12)
jr $ra
jr $ra
main:
la $a3, temp
la $t0, var0
sw $t0, 8($a3)
la $t0, var1
sw $t0, 12($a3)
la $t0, var2
sw $t0, 16($a3)
la $t0, var3
sw $t0, 20($a3)
la $t0, var4
sw $t0, 24($a3)
la $t0, var5
sw $t0, 28($a3)
la $t0, var6
sw $t0, 32($a3)
la $t0, var7
sw $t0, 36($a3)
la $t0, var8
sw $t0, 40($a3)
la $t0, var9
sw $t0, 868($a3)
add $11, $29, -180
move $14, $11
add $14, $29, -184
move $15, $14
add $16, $29, -188
move $17, $16
add $18, $29, -192
move $19, $18
add $20, $29, -196
move $21, $20
move $20, $11
li $11, 0
sw $11, 0($20)
move $11, $14
li $20, 99
sw $20, 0($11)
move $11, $16
li $20, 100
sw $20, 0($11)
move $11, $18
li $18, 0
sw $18, 0($11)
add $11, $29, -208
lw $18, 0($16)
sw $18, 0($11)
add $11, $29, -212
lw $16, 0($14)
sw $16, 0($11)
add $29, $29, -212
sw $15, 200($sp)
sw $17, 192($sp)
sw $19, 184($sp)
jal __build
lw $15, 200($sp)
lw $17, 192($sp)
lw $19, 184($sp)
sub $29, $29, -212
add $11, $29, -200
move $14, $11
l24:
add $11, $29, -208
lw $14, 0($19)
sw $14, 0($11)
add $11, $29, -212
lw $14, 0($15)
sw $14, 0($11)
add $11, $29, -216
lw $14, 0($17)
sw $14, 0($11)
add $29, $29, -216
sw $15, 204($sp)
sw $17, 196($sp)
sw $19, 188($sp)
jal __find
lw $15, 204($sp)
lw $17, 196($sp)
lw $19, 188($sp)
sub $29, $29, -216
add $11, $29, -200
lw $14, 0($11)
li $11, 0
sub $11, $14, $11
blez $11, l25
add $11, $29, -208
lw $14, 0($17)
sw $14, 0($11)
add $29, $29, -208
sw $15, 196($sp)
sw $17, 188($sp)
sw $19, 180($sp)
jal __improve
lw $15, 196($sp)
lw $17, 188($sp)
lw $19, 180($sp)
sub $29, $29, -208
add $11, $29, -200
move $14, $11
j l24
l25:
add $11, $29, -204
lw $12, 12($a3)
lw $14, 0($12)
sw $14, 0($11)
lw $13, 868($a3)
move $11, $13
add $12, $29, -208
sw $11, 0($12)
add $29, $29, -208
jal __printf
sub $29, $29, -208
li $11, 0
add $12, $29, 4
sw $11, 0($12)
j __main_end
j __main_end
__main_end:
li $v0, 10
syscall
