.data
temp: .space 360
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

main:
la $a3, temp
la $t0, var0
sw $t0, 352($a3)
add $11, $29, -40348
move $13, $11
add $11, $29, -40352
move $14, $11
add $15, $29, -40356
move $16, $15
add $15, $29, -40360
move $17, $15
li $15, 0
sw $15, 0($17)
move $15, $11
li $11, 0
sw $11, 0($15)
l0:
lw $11, 0($14)
li $15, 100
sub $15, $11, $15
bgez $15, l1
move $11, $16
li $15, 0
sw $15, 0($11)
l3:
lw $11, 0($16)
li $15, 100
sub $15, $11, $15
bgez $15, l4
lw $11, 0($14)
mul $15, $11, 400
add $11, $13, $15
lw $15, 0($16)
mul $18, $15, 4
add $11, $11, $18
li $15, 0
sw $15, 0($11)
l5:
move $11, $16
lw $15, 0($16)
add $18, $15, 1
sw $18, 0($11)
j l3
l4:
l2:
move $11, $14
lw $15, 0($14)
add $18, $15, 1
sw $18, 0($11)
j l0
l1:
move $11, $14
li $15, 0
sw $15, 0($11)
l6:
lw $11, 0($14)
li $15, 100
sub $15, $11, $15
bgez $15, l7
lw $11, 0($14)
li $15, 20
sub $15, $11, $15
blez $15, l9
lw $11, 0($14)
li $15, 80
sub $15, $11, $15
bgez $15, l9
add $11, $29, -40364
move $15, $11
lw $11, 0($14)
mul $18, $11, 400
add $11, $13, $18
sw $11, 0($15)
move $11, $16
li $18, 0
sw $18, 0($11)
l10:
lw $11, 0($16)
li $18, 100
sub $18, $11, $18
bgez $18, l11
lw $11, 0($16)
li $18, 5
sub $18, $11, $18
bgtz $18, l14
lw $11, 0($14)
li $18, 90
sub $18, $11, $18
bgez $18, l13
l14:
lw $11, 0($15)
lw $18, 0($16)
mul $18, $18, 4
mul $18, $18, 4
add $11, $11, $18
lw $18, 0($16)
add $18, $18, 50
sw $18, 0($11)
l13:
l12:
move $11, $16
lw $18, 0($16)
add $19, $18, 1
sw $19, 0($11)
j l10
l11:
l9:
l8:
move $11, $14
lw $15, 0($14)
add $18, $15, 1
sw $18, 0($11)
j l6
l7:
move $11, $14
li $15, 0
sw $15, 0($11)
l15:
lw $11, 0($14)
li $15, 100
sub $15, $11, $15
bgez $15, l16
move $11, $16
li $15, 0
sw $15, 0($11)
l18:
lw $11, 0($16)
li $15, 100
sub $15, $11, $15
bgez $15, l19
move $11, $17
lw $15, 0($14)
mul $18, $15, 400
add $15, $13, $18
lw $18, 0($16)
mul $19, $18, 4
add $15, $15, $19
lw $18, 0($17)
lw $15, 0($15)
add $18, $18, $15
sw $18, 0($11)
l20:
move $11, $16
lw $15, 0($16)
add $18, $15, 1
sw $18, 0($11)
j l18
l19:
l17:
move $11, $14
lw $15, 0($14)
add $18, $15, 1
sw $18, 0($11)
j l15
l16:
add $11, $29, -40368
lw $13, 0($17)
sw $13, 0($11)
lw $12, 352($a3)
move $11, $12
add $12, $29, -40372
sw $11, 0($12)
add $29, $29, -40372
jal __printf
sub $29, $29, -40372
j __main_end
__main_end:
li $v0, 10
syscall
