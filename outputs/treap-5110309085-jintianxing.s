.data
temp: .space 904
var0: .space 4
var1: .space 4
var2: .space 4
var3: .space 4
var4: .space 4
var5: .space 4
var6: .space 4
var7: .asciiz "%d\n"
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

__get_random:
add $11, $29, -44
move $16, $11
lw $12, 16($a3)
lw $11, 0($12)
lw $14, 36($a3)
lw $12, 0($14)
mul $11, $11, $12
lw $13, 20($a3)
lw $12, 0($13)
add $11, $11, $12
sw $11, 0($16)
move $11, $14
lw $12, 0($16)
lw $15, 28($a3)
lw $13, 0($15)
rem $12, $12, $13
sw $12, 0($11)
add $11, $29, 4
lw $12, 0($16)
sw $12, 0($11)
jr $ra
jr $ra
__sum_of:
add $11, $29, 0
lw $12, 0($11)
li $13, 0
sub $13, $12, $13
bnez $13, l0
li $12, 0
add $13, $29, 8
sw $12, 0($13)
jr $ra
l0:
lw $12, 0($11)
add $12, $12, 8
add $11, $29, 8
lw $12, 0($12)
sw $12, 0($11)
jr $ra
jr $ra
__update:
add $11, $29, 0
lw $12, 0($11)
add $12, $12, 8
sw $31, -52($29)
lw $13, 0($11)
add $13, $13, 12
add $14, $29, -56
lw $13, 0($13)
sw $13, 0($14)
add $29, $29, -56
sw $11, 52($sp)
sw $12, 48($sp)
jal __sum_of
lw $11, 52($sp)
lw $12, 48($sp)
sub $29, $29, -56
lw $31, -52($29)
add $13, $29, -48
lw $14, 0($13)
sw $31, -52($29)
lw $13, 0($11)
add $13, $13, 16
add $11, $29, -56
lw $13, 0($13)
sw $13, 0($11)
add $29, $29, -56
sw $12, 48($sp)
sw $14, 44($sp)
jal __sum_of
lw $12, 48($sp)
lw $14, 44($sp)
sub $29, $29, -56
lw $31, -52($29)
add $11, $29, -48
lw $13, 0($11)
add $14, $14, $13
add $14, $14, 1
sw $14, 0($12)
jr $ra
__rotate_left:
add $11, $29, 0
add $12, $29, -68
move $13, $12
lw $12, 0($11)
add $12, $12, 16
lw $12, 0($12)
sw $12, 0($13)
lw $12, 0($11)
add $12, $12, 16
lw $14, 0($13)
add $14, $14, 12
lw $14, 0($14)
sw $14, 0($12)
lw $12, 0($13)
add $12, $12, 12
lw $14, 0($11)
sw $14, 0($12)
sw $31, -72($29)
add $12, $29, -76
lw $14, 0($11)
sw $14, 0($12)
add $29, $29, -76
sw $13, 68($sp)
jal __update
lw $13, 68($sp)
sub $29, $29, -76
lw $31, -72($29)
sw $31, -72($29)
add $11, $29, -76
lw $12, 0($13)
sw $12, 0($11)
add $29, $29, -76
sw $13, 68($sp)
jal __update
lw $13, 68($sp)
sub $29, $29, -76
lw $31, -72($29)
add $11, $29, 8
lw $12, 0($13)
sw $12, 0($11)
jr $ra
jr $ra
__rotate_right:
add $11, $29, 0
add $12, $29, -68
move $13, $12
lw $12, 0($11)
add $12, $12, 12
lw $12, 0($12)
sw $12, 0($13)
lw $12, 0($11)
add $12, $12, 12
lw $14, 0($13)
add $14, $14, 16
lw $14, 0($14)
sw $14, 0($12)
lw $12, 0($13)
add $12, $12, 16
lw $14, 0($11)
sw $14, 0($12)
sw $31, -72($29)
add $12, $29, -76
lw $14, 0($11)
sw $14, 0($12)
add $29, $29, -76
sw $13, 68($sp)
jal __update
lw $13, 68($sp)
sub $29, $29, -76
lw $31, -72($29)
sw $31, -72($29)
add $11, $29, -76
lw $12, 0($13)
sw $12, 0($11)
add $29, $29, -76
sw $13, 68($sp)
jal __update
lw $13, 68($sp)
sub $29, $29, -76
lw $31, -72($29)
add $11, $29, 8
lw $12, 0($13)
sw $12, 0($11)
jr $ra
jr $ra
__insert_node:
add $11, $29, 0
add $12, $29, 4
lw $13, 0($11)
li $14, 0
sub $14, $13, $14
bnez $14, l1
add $13, $29, 12
lw $14, 0($12)
sw $14, 0($13)
jr $ra
l1:
lw $13, 0($11)
add $13, $13, 0
lw $13, 0($13)
lw $14, 0($12)
add $14, $14, 0
lw $14, 0($14)
sub $14, $13, $14
blez $14, l2
lw $13, 0($11)
add $13, $13, 12
sw $31, -188($29)
add $14, $29, -192
lw $15, 0($12)
sw $15, 0($14)
lw $14, 0($11)
add $14, $14, 12
add $15, $29, -196
lw $14, 0($14)
sw $14, 0($15)
add $29, $29, -196
sw $11, 192($sp)
sw $12, 188($sp)
sw $13, 160($sp)
jal __insert_node
lw $11, 192($sp)
lw $12, 188($sp)
lw $13, 160($sp)
sub $29, $29, -196
lw $31, -188($29)
add $14, $29, -184
lw $15, 0($14)
sw $15, 0($13)
j l3
l2:
lw $13, 0($11)
add $13, $13, 16
sw $31, -188($29)
add $14, $29, -192
lw $15, 0($12)
sw $15, 0($14)
lw $12, 0($11)
add $12, $12, 16
add $14, $29, -196
lw $12, 0($12)
sw $12, 0($14)
add $29, $29, -196
sw $11, 192($sp)
sw $13, 132($sp)
jal __insert_node
lw $11, 192($sp)
lw $13, 132($sp)
sub $29, $29, -196
lw $31, -188($29)
add $12, $29, -184
lw $14, 0($12)
sw $14, 0($13)
l3:
sw $31, -184($29)
add $12, $29, -188
lw $13, 0($11)
sw $13, 0($12)
add $29, $29, -188
sw $11, 184($sp)
jal __update
lw $11, 184($sp)
sub $29, $29, -188
lw $31, -184($29)
lw $12, 0($11)
add $12, $12, 12
lw $12, 0($12)
li $13, 0
sub $13, $12, $13
beqz $13, l4
lw $12, 0($11)
add $12, $12, 12
lw $12, 0($12)
add $12, $12, 4
lw $12, 0($12)
lw $13, 0($11)
add $13, $13, 4
lw $13, 0($13)
sub $13, $12, $13
blez $13, l4
sw $31, -188($29)
add $12, $29, -192
lw $13, 0($11)
sw $13, 0($12)
add $29, $29, -192
sw $11, 188($sp)
jal __rotate_right
lw $11, 188($sp)
sub $29, $29, -192
lw $31, -188($29)
add $12, $29, -184
add $13, $29, 12
lw $14, 0($12)
sw $14, 0($13)
jr $ra
l4:
lw $12, 0($11)
add $12, $12, 16
lw $12, 0($12)
li $13, 0
sub $13, $12, $13
beqz $13, l5
lw $12, 0($11)
add $12, $12, 16
lw $12, 0($12)
add $12, $12, 4
lw $12, 0($12)
lw $13, 0($11)
add $13, $13, 4
lw $13, 0($13)
sub $13, $12, $13
blez $13, l5
sw $31, -188($29)
add $12, $29, -192
lw $13, 0($11)
sw $13, 0($12)
add $29, $29, -192
sw $11, 188($sp)
jal __rotate_left
lw $11, 188($sp)
sub $29, $29, -192
lw $31, -188($29)
add $12, $29, -184
add $13, $29, 12
lw $14, 0($12)
sw $14, 0($13)
jr $ra
l5:
add $12, $29, 12
lw $13, 0($11)
sw $13, 0($12)
jr $ra
jr $ra
__get_kth_element:
add $11, $29, 0
add $12, $29, 4
add $13, $29, -128
move $14, $13
li $13, 0
sw $13, 0($14)
lw $13, 0($11)
add $13, $13, 12
lw $13, 0($13)
li $15, 0
sub $15, $13, $15
beqz $15, l6
move $13, $14
lw $15, 0($11)
add $15, $15, 12
lw $15, 0($15)
add $15, $15, 8
lw $15, 0($15)
sw $15, 0($13)
l6:
lw $13, 0($14)
lw $15, 0($12)
sub $15, $13, $15
blez $15, l7
sw $31, -136($29)
add $13, $29, -140
lw $15, 0($12)
sw $15, 0($13)
lw $13, 0($11)
add $13, $13, 12
add $15, $29, -144
lw $13, 0($13)
sw $13, 0($15)
add $29, $29, -144
sw $11, 140($sp)
sw $12, 136($sp)
sw $14, 132($sp)
jal __get_kth_element
lw $11, 140($sp)
lw $12, 136($sp)
lw $14, 132($sp)
sub $29, $29, -144
lw $31, -136($29)
add $13, $29, -132
add $15, $29, 12
lw $16, 0($13)
sw $16, 0($15)
jr $ra
l7:
lw $13, 0($14)
lw $15, 0($12)
sub $15, $13, $15
bgez $15, l8
sw $31, -136($29)
lw $13, 0($12)
lw $12, 0($14)
sub $13, $13, $12
sub $13, $13, 1
add $12, $29, -140
sw $13, 0($12)
lw $12, 0($11)
add $12, $12, 16
add $13, $29, -144
lw $12, 0($12)
sw $12, 0($13)
add $29, $29, -144
sw $11, 140($sp)
jal __get_kth_element
lw $11, 140($sp)
sub $29, $29, -144
lw $31, -136($29)
add $12, $29, -132
add $13, $29, 12
lw $14, 0($12)
sw $14, 0($13)
jr $ra
l8:
lw $12, 0($11)
add $12, $12, 0
add $11, $29, 12
lw $12, 0($12)
sw $12, 0($11)
jr $ra
jr $ra
__alloc_node:
add $11, $29, -80
move $12, $11
sw $31, -88($29)
li $11, 20
add $13, $29, -92
sw $11, 0($13)
add $29, $29, -92
sw $12, 88($sp)
jal __malloc
lw $12, 88($sp)
sub $29, $29, -92
lw $31, -88($29)
add $11, $29, -84
lw $13, 0($11)
sw $13, 0($12)
lw $11, 0($12)
add $11, $11, 12
lw $13, 0($12)
add $13, $13, 16
li $14, 0
sw $14, 0($13)
lw $13, 0($13)
sw $13, 0($11)
lw $11, 0($12)
add $11, $11, 8
li $13, 1
sw $13, 0($11)
lw $11, 0($12)
add $11, $11, 4
sw $31, -88($29)
add $29, $29, -88
sw $11, 40($sp)
sw $12, 84($sp)
jal __get_random
lw $11, 40($sp)
lw $12, 84($sp)
sub $29, $29, -88
lw $31, -88($29)
add $13, $29, -84
lw $14, 0($13)
sw $14, 0($11)
lw $11, 0($12)
add $11, $11, 0
sw $31, -88($29)
add $29, $29, -88
sw $11, 28($sp)
sw $12, 84($sp)
jal __get_random
lw $11, 28($sp)
lw $12, 84($sp)
sub $29, $29, -88
lw $31, -88($29)
add $13, $29, -84
lw $14, 0($13)
sw $14, 0($11)
add $11, $29, 4
lw $13, 0($12)
sw $13, 0($11)
jr $ra
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
sw $t0, 28($a3)
la $t0, var4
sw $t0, 36($a3)
la $t0, var5
sw $t0, 44($a3)
la $t0, var6
sw $t0, 48($a3)
la $t0, var7
sw $t0, 876($a3)
li $8, 2000
sw $8, 12($a3)
lw $8, 12($a3)
lw $9, 8($a3)
sw $8, 0($9)
li $8, 12345
sw $8, 24($a3)
lw $8, 24($a3)
lw $9, 20($a3)
sw $8, 0($9)
li $8, 32768
sw $8, 32($a3)
lw $8, 32($a3)
lw $9, 28($a3)
sw $8, 0($9)
li $8, 86421
sw $8, 40($a3)
lw $8, 40($a3)
lw $9, 36($a3)
sw $8, 0($9)
lw $11, 16($a3)
move $12, $11
li $11, 10000
add $29, $29, -236
sw $11, 228($sp)
sw $12, 232($sp)
jal __getchar
lw $11, 228($sp)
lw $12, 232($sp)
sub $29, $29, -236
add $17, $29, -232
lw $18, 0($17)
sub $18, $18, 48
mul $11, $11, $18
li $17, 1000
add $29, $29, -236
sw $11, 228($sp)
sw $12, 232($sp)
sw $17, 212($sp)
jal __getchar
lw $11, 228($sp)
lw $12, 232($sp)
lw $17, 212($sp)
sub $29, $29, -236
add $18, $29, -232
lw $19, 0($18)
sub $19, $19, 48
mul $17, $17, $19
add $11, $11, $17
li $17, 100
add $29, $29, -236
sw $11, 228($sp)
sw $12, 232($sp)
sw $17, 196($sp)
jal __getchar
lw $11, 228($sp)
lw $12, 232($sp)
lw $17, 196($sp)
sub $29, $29, -236
add $18, $29, -232
lw $19, 0($18)
sub $19, $19, 48
mul $17, $17, $19
add $11, $11, $17
li $17, 10
add $29, $29, -236
sw $11, 228($sp)
sw $12, 232($sp)
sw $17, 180($sp)
jal __getchar
lw $11, 228($sp)
lw $12, 232($sp)
lw $17, 180($sp)
sub $29, $29, -236
add $18, $29, -232
lw $19, 0($18)
sub $19, $19, 48
mul $17, $17, $19
add $11, $11, $17
add $29, $29, -236
sw $11, 228($sp)
sw $12, 232($sp)
jal __getchar
lw $11, 228($sp)
lw $12, 232($sp)
sub $29, $29, -236
add $17, $29, -232
lw $18, 0($17)
add $11, $11, $18
sub $11, $11, 48
sw $11, 0($12)
lw $16, 48($a3)
move $11, $16
add $29, $29, -236
sw $11, 152($sp)
sw $16, 48($a3)
jal __alloc_node
lw $11, 152($sp)
lw $16, 48($a3)
sub $29, $29, -236
add $12, $29, -232
lw $17, 0($12)
sw $17, 0($11)
lw $15, 44($a3)
move $11, $15
li $12, 0
sw $12, 0($11)
l9:
lw $11, 0($15)
lw $14, 8($a3)
lw $12, 0($14)
sub $12, $11, $12
bgez $12, l10
move $11, $16
add $29, $29, -248
sw $11, 136($sp)
sw $14, 8($a3)
sw $15, 44($a3)
sw $16, 48($a3)
jal __alloc_node
lw $11, 136($sp)
lw $14, 8($a3)
lw $15, 44($a3)
lw $16, 48($a3)
sub $29, $29, -248
add $12, $29, -244
add $17, $29, -240
lw $18, 0($12)
sw $18, 0($17)
add $12, $29, -244
lw $17, 0($16)
sw $17, 0($12)
add $29, $29, -244
sw $11, 132($sp)
sw $14, 8($a3)
sw $15, 44($a3)
sw $16, 48($a3)
jal __insert_node
lw $11, 132($sp)
lw $14, 8($a3)
lw $15, 44($a3)
lw $16, 48($a3)
sub $29, $29, -244
add $12, $29, -232
lw $17, 0($12)
sw $17, 0($11)
l11:
move $11, $15
lw $12, 0($15)
add $17, $12, 1
sw $17, 0($11)
j l9
l10:
move $11, $15
li $12, 0
sw $12, 0($11)
l12:
lw $11, 0($15)
lw $12, 0($14)
sub $12, $11, $12
bgtz $12, l13
add $11, $29, -248
lw $12, 0($15)
sw $12, 0($11)
add $11, $29, -252
lw $12, 0($16)
sw $12, 0($11)
add $29, $29, -252
sw $14, 8($a3)
sw $15, 44($a3)
sw $16, 48($a3)
jal __get_kth_element
lw $14, 8($a3)
lw $15, 44($a3)
lw $16, 48($a3)
sub $29, $29, -252
add $11, $29, -240
add $12, $29, -236
lw $17, 0($11)
sw $17, 0($12)
lw $13, 876($a3)
move $11, $13
add $12, $29, -240
sw $11, 0($12)
add $29, $29, -240
jal __printf
sub $29, $29, -240
l14:
move $11, $15
lw $12, 0($15)
add $17, $12, 1
sw $17, 0($11)
j l12
l13:
li $11, 0
add $12, $29, 4
sw $11, 0($12)
j __main_end
j __main_end
__main_end:
li $v0, 10
syscall
