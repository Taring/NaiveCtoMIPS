.data
temp: .space 280
var0: .space 4
var1: .space 15004
var2: .space 4
var3: .asciiz "%d %d\n"
.align 2
var4: .asciiz "Total: %d\n"
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

main:
la $a3, temp
la $t0, var0
sw $t0, 8($a3)
la $t0, var1
sw $t0, 16($a3)
la $t0, var2
sw $t0, 20($a3)
la $t0, var3
sw $t0, 184($a3)
la $t0, var4
sw $t0, 264($a3)
li $8, 15000
sw $8, 12($a3)
lw $8, 12($a3)
lw $9, 8($a3)
sw $8, 0($9)
li $8, 0
sw $8, 24($a3)
lw $8, 24($a3)
lw $9, 20($a3)
sw $8, 0($9)
add $11, $29, -248
move $17, $11
move $18, $11
li $11, 1
sw $11, 0($18)
l0:
lw $11, 0($17)
lw $14, 8($a3)
lw $18, 0($14)
sub $18, $11, $18
bgtz $18, l1
lw $11, 0($17)
mul $18, $11, 1
lw $13, 16($a3)
add $11, $13, $18
li $18, 1
sb $18, 0($11)
l2:
move $11, $17
lw $18, 0($17)
add $19, $18, 1
sw $19, 0($11)
j l0
l1:
move $11, $17
li $18, 2
sw $18, 0($11)
l3:
lw $11, 0($17)
lw $18, 0($14)
sub $18, $11, $18
bgtz $18, l4
lw $11, 0($17)
mul $18, $11, 1
add $11, $13, $18
lb $11, 0($11)
beqz $11, l6
add $11, $29, -252
move $18, $11
li $11, 2
sw $11, 0($18)
lw $11, 0($17)
li $19, 3
sub $19, $11, $19
blez $19, l7
lw $11, 0($17)
sub $11, $11, 2
mul $19, $11, 1
add $11, $13, $19
lb $11, 0($11)
beqz $11, l7
lw $15, 20($a3)
move $11, $15
lw $19, 0($15)
add $20, $19, 1
sw $20, 0($11)
add $11, $29, -260
lw $19, 0($17)
sw $19, 0($11)
lw $11, 0($17)
sub $11, $11, 2
add $19, $29, -264
sw $11, 0($19)
lw $12, 184($a3)
move $11, $12
add $19, $29, -268
sw $11, 0($19)
add $29, $29, -268
jal __printf
sub $29, $29, -268
l7:
l8:
lw $11, 0($17)
lw $19, 0($18)
mul $11, $11, $19
lw $19, 0($14)
sub $19, $11, $19
bgtz $19, l9
lw $11, 0($17)
lw $19, 0($18)
mul $11, $11, $19
mul $19, $11, 1
add $11, $13, $19
li $19, 0
sb $19, 0($11)
move $11, $18
lw $19, 0($18)
add $20, $19, 1
sw $20, 0($11)
j l8
l9:
l6:
l5:
move $11, $17
lw $18, 0($17)
add $19, $18, 1
sw $19, 0($11)
j l3
l4:
add $11, $29, -256
lw $12, 0($15)
sw $12, 0($11)
lw $16, 264($a3)
move $11, $16
add $12, $29, -260
sw $11, 0($12)
add $29, $29, -260
jal __printf
sub $29, $29, -260
li $11, 0
add $12, $29, 4
sw $11, 0($12)
j __main_end
j __main_end
__main_end:
li $v0, 10
syscall
