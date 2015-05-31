.data
temp: .space 476
var0: .space 40400
var1: .space 4
var2: .asciiz "%d "
.align 2
var3: .asciiz "\n"
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

__qsrt:
add $12, $29, 0
add $13, $29, 4
add $14, $29, -292
move $15, $14
lw $14, 0($12)
sw $14, 0($15)
add $14, $29, -296
move $16, $14
lw $14, 0($13)
sw $14, 0($16)
add $14, $29, -300
move $17, $14
lw $14, 0($12)
lw $18, 0($13)
add $14, $14, $18
div $14, $14, 2
mul $18, $14, 4
lw $11, 8($a3)
add $14, $11, $18
lw $14, 0($14)
sw $14, 0($17)
l0:
lw $14, 0($15)
lw $18, 0($16)
sub $18, $14, $18
bgtz $18, l1
l2:
lw $14, 0($15)
mul $18, $14, 4
add $14, $11, $18
lw $14, 0($14)
lw $18, 0($17)
sub $18, $14, $18
bgez $18, l3
move $14, $15
lw $18, 0($15)
add $19, $18, 1
sw $19, 0($14)
j l2
l3:
l4:
lw $14, 0($16)
mul $18, $14, 4
add $14, $11, $18
lw $14, 0($14)
lw $18, 0($17)
sub $18, $14, $18
blez $18, l5
move $14, $16
lw $18, 0($16)
sub $19, $18, 1
sw $19, 0($14)
j l4
l5:
lw $14, 0($15)
lw $18, 0($16)
sub $18, $14, $18
bgtz $18, l6
add $14, $29, -304
move $18, $14
lw $14, 0($15)
mul $19, $14, 4
add $14, $11, $19
lw $14, 0($14)
sw $14, 0($18)
lw $14, 0($15)
mul $19, $14, 4
add $14, $11, $19
lw $19, 0($16)
mul $20, $19, 4
add $19, $11, $20
lw $19, 0($19)
sw $19, 0($14)
lw $14, 0($16)
mul $19, $14, 4
add $14, $11, $19
lw $19, 0($18)
sw $19, 0($14)
move $14, $15
lw $18, 0($15)
add $19, $18, 1
sw $19, 0($14)
move $14, $16
lw $18, 0($16)
sub $19, $18, 1
sw $19, 0($14)
l6:
j l0
l1:
lw $11, 0($12)
lw $14, 0($16)
sub $14, $11, $14
bgez $14, l7
sw $31, -308($29)
add $11, $29, -312
lw $14, 0($16)
sw $14, 0($11)
add $11, $29, -316
lw $14, 0($12)
sw $14, 0($11)
add $29, $29, -316
sw $13, 308($sp)
sw $15, 304($sp)
sw $17, 280($sp)
jal __qsrt
lw $13, 308($sp)
lw $15, 304($sp)
lw $17, 280($sp)
sub $29, $29, -316
lw $31, -308($29)
add $11, $29, -304
move $12, $11
l7:
lw $11, 0($15)
lw $12, 0($13)
sub $12, $11, $12
bgez $12, l8
sw $31, -308($29)
add $11, $29, -312
lw $12, 0($13)
sw $12, 0($11)
add $11, $29, -316
lw $12, 0($15)
sw $12, 0($11)
add $29, $29, -316
sw $17, 280($sp)
jal __qsrt
lw $17, 280($sp)
sub $29, $29, -316
lw $31, -308($29)
add $11, $29, -304
move $12, $11
l8:
li $11, 0
add $12, $29, 12
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
sw $t0, 432($a3)
la $t0, var3
sw $t0, 460($a3)
li $8, 10000
sw $8, 16($a3)
lw $8, 16($a3)
lw $9, 12($a3)
sw $8, 0($9)
add $11, $29, -164
move $16, $11
move $17, $11
li $11, 1
sw $11, 0($17)
l9:
lw $11, 0($16)
lw $14, 12($a3)
lw $17, 0($14)
sub $17, $11, $17
bgtz $17, l10
lw $11, 0($16)
mul $17, $11, 4
lw $13, 8($a3)
add $11, $13, $17
lw $17, 0($14)
add $17, $17, 1
lw $18, 0($16)
sub $17, $17, $18
sw $17, 0($11)
l11:
move $11, $16
lw $17, 0($16)
add $18, $17, 1
sw $18, 0($11)
j l9
l10:
add $11, $29, -176
lw $17, 0($14)
sw $17, 0($11)
li $11, 1
add $17, $29, -180
sw $11, 0($17)
add $29, $29, -180
sw $13, 8($a3)
sw $14, 12($a3)
sw $16, 176($sp)
jal __qsrt
lw $13, 8($a3)
lw $14, 12($a3)
lw $16, 176($sp)
sub $29, $29, -180
add $11, $29, -168
move $17, $11
move $11, $16
li $17, 1
sw $17, 0($11)
l12:
lw $11, 0($16)
lw $17, 0($14)
sub $17, $11, $17
bgtz $17, l13
lw $11, 0($16)
mul $17, $11, 4
add $11, $13, $17
add $17, $29, -172
lw $11, 0($11)
sw $11, 0($17)
lw $12, 432($a3)
move $11, $12
add $17, $29, -176
sw $11, 0($17)
add $29, $29, -176
jal __printf
sub $29, $29, -176
l14:
move $11, $16
lw $17, 0($16)
add $18, $17, 1
sw $18, 0($11)
j l12
l13:
lw $15, 460($a3)
move $11, $15
add $12, $29, -172
sw $11, 0($12)
add $29, $29, -172
jal __printf_single
sub $29, $29, -172
li $11, 0
add $12, $29, 4
sw $11, 0($12)
j __main_end
j __main_end
__main_end:
li $v0, 10
syscall
