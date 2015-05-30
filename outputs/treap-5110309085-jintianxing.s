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

__get_random:
add $8, $29, -44
sw $8, -8($sp)
lw $9, -8($sp)
move $8, $9
sw $8, -4($sp)
lw $9, 16($a3)
lw $8, 0($9)
sw $8, -12($sp)
lw $9, 36($a3)
lw $8, 0($9)
sw $8, -16($sp)
lw $9, -12($sp)
lw $10, -16($sp)
mul $8, $9, $10
sw $8, -12($sp)
lw $9, 20($a3)
lw $8, 0($9)
sw $8, -20($sp)
lw $9, -12($sp)
lw $10, -20($sp)
add $8, $9, $10
sw $8, -12($sp)
lw $8, -12($sp)
lw $9, -4($sp)
sw $8, 0($9)
lw $9, 36($a3)
move $8, $9
sw $8, -24($sp)
lw $9, -4($sp)
lw $8, 0($9)
sw $8, -28($sp)
lw $9, 28($a3)
lw $8, 0($9)
sw $8, -32($sp)
lw $9, -28($sp)
lw $10, -32($sp)
rem $8, $9, $10
sw $8, -28($sp)
lw $8, -28($sp)
lw $9, -24($sp)
sw $8, 0($9)
add $8, $29, 4
sw $8, -40($sp)
lw $9, -4($sp)
lw $8, 0($9)
sw $8, -36($sp)
lw $8, -36($sp)
lw $9, -40($sp)
sw $8, 0($9)
jr $ra
jr $ra
__sum_of:
add $8, $29, 0
sw $8, -4($sp)
lw $9, -4($sp)
lw $8, 0($9)
sw $8, -8($sp)
li $8, 0
sw $8, -12($sp)
lw $9, -8($sp)
lw $10, -12($sp)
sub $8, $9, $10
sw $8, -12($sp)
lw $8, -12($sp)
bnez $8, label0
li $8, 0
sw $8, -16($sp)
add $8, $29, 8
sw $8, -20($sp)
lw $8, -16($sp)
lw $9, -20($sp)
sw $8, 0($9)
jr $ra
label0:
lw $9, -4($sp)
lw $8, 0($9)
sw $8, -24($sp)
lw $9, -24($sp)
add $8, $9, 8
sw $8, -24($sp)
add $8, $29, 8
sw $8, -28($sp)
lw $9, -24($sp)
lw $8, 0($9)
sw $8, -24($sp)
lw $8, -24($sp)
lw $9, -28($sp)
sw $8, 0($9)
jr $ra
jr $ra
__update:
add $8, $29, 0
sw $8, -4($sp)
lw $9, -4($sp)
lw $8, 0($9)
sw $8, -8($sp)
lw $9, -8($sp)
add $8, $9, 8
sw $8, -8($sp)
sw $31, -52($29)
lw $9, -4($sp)
lw $8, 0($9)
sw $8, -16($sp)
lw $9, -16($sp)
add $8, $9, 12
sw $8, -16($sp)
add $8, $29, -56
sw $8, -20($sp)
lw $9, -16($sp)
lw $8, 0($9)
sw $8, -16($sp)
lw $8, -16($sp)
lw $9, -20($sp)
sw $8, 0($9)
add $29, $29, -56
jal __sum_of
sub $29, $29, -56
lw $31, -52($29)
add $8, $29, -48
sw $8, -24($sp)
lw $9, -24($sp)
lw $8, 0($9)
sw $8, -12($sp)
sw $31, -52($29)
lw $9, -4($sp)
lw $8, 0($9)
sw $8, -32($sp)
lw $9, -32($sp)
add $8, $9, 16
sw $8, -32($sp)
add $8, $29, -56
sw $8, -36($sp)
lw $9, -32($sp)
lw $8, 0($9)
sw $8, -32($sp)
lw $8, -32($sp)
lw $9, -36($sp)
sw $8, 0($9)
add $29, $29, -56
jal __sum_of
sub $29, $29, -56
lw $31, -52($29)
add $8, $29, -48
sw $8, -40($sp)
lw $9, -40($sp)
lw $8, 0($9)
sw $8, -28($sp)
lw $9, -12($sp)
lw $10, -28($sp)
add $8, $9, $10
sw $8, -12($sp)
li $8, 1
sw $8, -44($sp)
lw $9, -12($sp)
lw $10, -44($sp)
add $8, $9, $10
sw $8, -12($sp)
lw $8, -12($sp)
lw $9, -8($sp)
sw $8, 0($9)
jr $ra
__rotate_left:
add $8, $29, 0
sw $8, -4($sp)
add $8, $29, -68
sw $8, -12($sp)
lw $9, -12($sp)
move $8, $9
sw $8, -8($sp)
lw $9, -4($sp)
lw $8, 0($9)
sw $8, -16($sp)
lw $9, -16($sp)
add $8, $9, 16
sw $8, -16($sp)
lw $9, -16($sp)
lw $8, 0($9)
sw $8, -16($sp)
lw $8, -16($sp)
lw $9, -8($sp)
sw $8, 0($9)
lw $9, -4($sp)
lw $8, 0($9)
sw $8, -20($sp)
lw $9, -20($sp)
add $8, $9, 16
sw $8, -20($sp)
lw $9, -8($sp)
lw $8, 0($9)
sw $8, -24($sp)
lw $9, -24($sp)
add $8, $9, 12
sw $8, -24($sp)
lw $9, -24($sp)
lw $8, 0($9)
sw $8, -24($sp)
lw $8, -24($sp)
lw $9, -20($sp)
sw $8, 0($9)
lw $9, -8($sp)
lw $8, 0($9)
sw $8, -28($sp)
lw $9, -28($sp)
add $8, $9, 12
sw $8, -28($sp)
lw $9, -4($sp)
lw $8, 0($9)
sw $8, -32($sp)
lw $8, -32($sp)
lw $9, -28($sp)
sw $8, 0($9)
sw $31, -72($29)
add $8, $29, -76
sw $8, -44($sp)
lw $9, -4($sp)
lw $8, 0($9)
sw $8, -40($sp)
lw $8, -40($sp)
lw $9, -44($sp)
sw $8, 0($9)
add $29, $29, -76
jal __update
sub $29, $29, -76
lw $31, -72($29)
sw $31, -72($29)
add $8, $29, -76
sw $8, -56($sp)
lw $9, -8($sp)
lw $8, 0($9)
sw $8, -52($sp)
lw $8, -52($sp)
lw $9, -56($sp)
sw $8, 0($9)
add $29, $29, -76
jal __update
sub $29, $29, -76
lw $31, -72($29)
add $8, $29, 8
sw $8, -64($sp)
lw $9, -8($sp)
lw $8, 0($9)
sw $8, -60($sp)
lw $8, -60($sp)
lw $9, -64($sp)
sw $8, 0($9)
jr $ra
jr $ra
__rotate_right:
add $8, $29, 0
sw $8, -4($sp)
add $8, $29, -68
sw $8, -12($sp)
lw $9, -12($sp)
move $8, $9
sw $8, -8($sp)
lw $9, -4($sp)
lw $8, 0($9)
sw $8, -16($sp)
lw $9, -16($sp)
add $8, $9, 12
sw $8, -16($sp)
lw $9, -16($sp)
lw $8, 0($9)
sw $8, -16($sp)
lw $8, -16($sp)
lw $9, -8($sp)
sw $8, 0($9)
lw $9, -4($sp)
lw $8, 0($9)
sw $8, -20($sp)
lw $9, -20($sp)
add $8, $9, 12
sw $8, -20($sp)
lw $9, -8($sp)
lw $8, 0($9)
sw $8, -24($sp)
lw $9, -24($sp)
add $8, $9, 16
sw $8, -24($sp)
lw $9, -24($sp)
lw $8, 0($9)
sw $8, -24($sp)
lw $8, -24($sp)
lw $9, -20($sp)
sw $8, 0($9)
lw $9, -8($sp)
lw $8, 0($9)
sw $8, -28($sp)
lw $9, -28($sp)
add $8, $9, 16
sw $8, -28($sp)
lw $9, -4($sp)
lw $8, 0($9)
sw $8, -32($sp)
lw $8, -32($sp)
lw $9, -28($sp)
sw $8, 0($9)
sw $31, -72($29)
add $8, $29, -76
sw $8, -44($sp)
lw $9, -4($sp)
lw $8, 0($9)
sw $8, -40($sp)
lw $8, -40($sp)
lw $9, -44($sp)
sw $8, 0($9)
add $29, $29, -76
jal __update
sub $29, $29, -76
lw $31, -72($29)
sw $31, -72($29)
add $8, $29, -76
sw $8, -56($sp)
lw $9, -8($sp)
lw $8, 0($9)
sw $8, -52($sp)
lw $8, -52($sp)
lw $9, -56($sp)
sw $8, 0($9)
add $29, $29, -76
jal __update
sub $29, $29, -76
lw $31, -72($29)
add $8, $29, 8
sw $8, -64($sp)
lw $9, -8($sp)
lw $8, 0($9)
sw $8, -60($sp)
lw $8, -60($sp)
lw $9, -64($sp)
sw $8, 0($9)
jr $ra
jr $ra
__insert_node:
add $8, $29, 0
sw $8, -4($sp)
add $8, $29, 4
sw $8, -8($sp)
lw $9, -4($sp)
lw $8, 0($9)
sw $8, -12($sp)
li $8, 0
sw $8, -16($sp)
lw $9, -12($sp)
lw $10, -16($sp)
sub $8, $9, $10
sw $8, -16($sp)
lw $8, -16($sp)
bnez $8, label1
add $8, $29, 12
sw $8, -24($sp)
lw $9, -8($sp)
lw $8, 0($9)
sw $8, -20($sp)
lw $8, -20($sp)
lw $9, -24($sp)
sw $8, 0($9)
jr $ra
label1:
lw $9, -4($sp)
lw $8, 0($9)
sw $8, -28($sp)
lw $9, -28($sp)
add $8, $9, 0
sw $8, -28($sp)
lw $9, -28($sp)
lw $8, 0($9)
sw $8, -28($sp)
lw $9, -8($sp)
lw $8, 0($9)
sw $8, -32($sp)
lw $9, -32($sp)
add $8, $9, 0
sw $8, -32($sp)
lw $9, -32($sp)
lw $8, 0($9)
sw $8, -32($sp)
lw $9, -28($sp)
lw $10, -32($sp)
sub $8, $9, $10
sw $8, -32($sp)
lw $8, -32($sp)
blez $8, label2
lw $9, -4($sp)
lw $8, 0($9)
sw $8, -36($sp)
lw $9, -36($sp)
add $8, $9, 12
sw $8, -36($sp)
sw $31, -188($29)
add $8, $29, -192
sw $8, -48($sp)
lw $9, -8($sp)
lw $8, 0($9)
sw $8, -44($sp)
lw $8, -44($sp)
lw $9, -48($sp)
sw $8, 0($9)
lw $9, -4($sp)
lw $8, 0($9)
sw $8, -52($sp)
lw $9, -52($sp)
add $8, $9, 12
sw $8, -52($sp)
add $8, $29, -196
sw $8, -56($sp)
lw $9, -52($sp)
lw $8, 0($9)
sw $8, -52($sp)
lw $8, -52($sp)
lw $9, -56($sp)
sw $8, 0($9)
add $29, $29, -196
jal __insert_node
sub $29, $29, -196
lw $31, -188($29)
add $8, $29, -184
sw $8, -60($sp)
lw $9, -60($sp)
lw $8, 0($9)
sw $8, -40($sp)
lw $8, -40($sp)
lw $9, -36($sp)
sw $8, 0($9)
j label3
label2:
lw $9, -4($sp)
lw $8, 0($9)
sw $8, -64($sp)
lw $9, -64($sp)
add $8, $9, 16
sw $8, -64($sp)
sw $31, -188($29)
add $8, $29, -192
sw $8, -76($sp)
lw $9, -8($sp)
lw $8, 0($9)
sw $8, -72($sp)
lw $8, -72($sp)
lw $9, -76($sp)
sw $8, 0($9)
lw $9, -4($sp)
lw $8, 0($9)
sw $8, -80($sp)
lw $9, -80($sp)
add $8, $9, 16
sw $8, -80($sp)
add $8, $29, -196
sw $8, -84($sp)
lw $9, -80($sp)
lw $8, 0($9)
sw $8, -80($sp)
lw $8, -80($sp)
lw $9, -84($sp)
sw $8, 0($9)
add $29, $29, -196
jal __insert_node
sub $29, $29, -196
lw $31, -188($29)
add $8, $29, -184
sw $8, -88($sp)
lw $9, -88($sp)
lw $8, 0($9)
sw $8, -68($sp)
lw $8, -68($sp)
lw $9, -64($sp)
sw $8, 0($9)
label3:
sw $31, -184($29)
add $8, $29, -188
sw $8, -100($sp)
lw $9, -4($sp)
lw $8, 0($9)
sw $8, -96($sp)
lw $8, -96($sp)
lw $9, -100($sp)
sw $8, 0($9)
add $29, $29, -188
jal __update
sub $29, $29, -188
lw $31, -184($29)
lw $9, -4($sp)
lw $8, 0($9)
sw $8, -104($sp)
lw $9, -104($sp)
add $8, $9, 12
sw $8, -104($sp)
lw $9, -104($sp)
lw $8, 0($9)
sw $8, -104($sp)
li $8, 0
sw $8, -108($sp)
lw $9, -104($sp)
lw $10, -108($sp)
sub $8, $9, $10
sw $8, -108($sp)
lw $8, -108($sp)
beqz $8, label4
lw $9, -4($sp)
lw $8, 0($9)
sw $8, -112($sp)
lw $9, -112($sp)
add $8, $9, 12
sw $8, -112($sp)
lw $9, -112($sp)
lw $8, 0($9)
sw $8, -112($sp)
lw $9, -112($sp)
add $8, $9, 4
sw $8, -112($sp)
lw $9, -112($sp)
lw $8, 0($9)
sw $8, -112($sp)
lw $9, -4($sp)
lw $8, 0($9)
sw $8, -116($sp)
lw $9, -116($sp)
add $8, $9, 4
sw $8, -116($sp)
lw $9, -116($sp)
lw $8, 0($9)
sw $8, -116($sp)
lw $9, -112($sp)
lw $10, -116($sp)
sub $8, $9, $10
sw $8, -116($sp)
lw $8, -116($sp)
blez $8, label4
sw $31, -188($29)
add $8, $29, -192
sw $8, -128($sp)
lw $9, -4($sp)
lw $8, 0($9)
sw $8, -124($sp)
lw $8, -124($sp)
lw $9, -128($sp)
sw $8, 0($9)
add $29, $29, -192
jal __rotate_right
sub $29, $29, -192
lw $31, -188($29)
add $8, $29, -184
sw $8, -132($sp)
add $8, $29, 12
sw $8, -136($sp)
lw $9, -132($sp)
lw $8, 0($9)
sw $8, -120($sp)
lw $8, -120($sp)
lw $9, -136($sp)
sw $8, 0($9)
jr $ra
label4:
lw $9, -4($sp)
lw $8, 0($9)
sw $8, -140($sp)
lw $9, -140($sp)
add $8, $9, 16
sw $8, -140($sp)
lw $9, -140($sp)
lw $8, 0($9)
sw $8, -140($sp)
li $8, 0
sw $8, -144($sp)
lw $9, -140($sp)
lw $10, -144($sp)
sub $8, $9, $10
sw $8, -144($sp)
lw $8, -144($sp)
beqz $8, label5
lw $9, -4($sp)
lw $8, 0($9)
sw $8, -148($sp)
lw $9, -148($sp)
add $8, $9, 16
sw $8, -148($sp)
lw $9, -148($sp)
lw $8, 0($9)
sw $8, -148($sp)
lw $9, -148($sp)
add $8, $9, 4
sw $8, -148($sp)
lw $9, -148($sp)
lw $8, 0($9)
sw $8, -148($sp)
lw $9, -4($sp)
lw $8, 0($9)
sw $8, -152($sp)
lw $9, -152($sp)
add $8, $9, 4
sw $8, -152($sp)
lw $9, -152($sp)
lw $8, 0($9)
sw $8, -152($sp)
lw $9, -148($sp)
lw $10, -152($sp)
sub $8, $9, $10
sw $8, -152($sp)
lw $8, -152($sp)
blez $8, label5
sw $31, -188($29)
add $8, $29, -192
sw $8, -164($sp)
lw $9, -4($sp)
lw $8, 0($9)
sw $8, -160($sp)
lw $8, -160($sp)
lw $9, -164($sp)
sw $8, 0($9)
add $29, $29, -192
jal __rotate_left
sub $29, $29, -192
lw $31, -188($29)
add $8, $29, -184
sw $8, -168($sp)
add $8, $29, 12
sw $8, -172($sp)
lw $9, -168($sp)
lw $8, 0($9)
sw $8, -156($sp)
lw $8, -156($sp)
lw $9, -172($sp)
sw $8, 0($9)
jr $ra
label5:
add $8, $29, 12
sw $8, -180($sp)
lw $9, -4($sp)
lw $8, 0($9)
sw $8, -176($sp)
lw $8, -176($sp)
lw $9, -180($sp)
sw $8, 0($9)
jr $ra
jr $ra
__get_kth_element:
add $8, $29, 0
sw $8, -4($sp)
add $8, $29, 4
sw $8, -8($sp)
add $8, $29, -128
sw $8, -16($sp)
lw $9, -16($sp)
move $8, $9
sw $8, -12($sp)
li $8, 0
sw $8, -20($sp)
lw $8, -20($sp)
lw $9, -12($sp)
sw $8, 0($9)
lw $9, -4($sp)
lw $8, 0($9)
sw $8, -24($sp)
lw $9, -24($sp)
add $8, $9, 12
sw $8, -24($sp)
lw $9, -24($sp)
lw $8, 0($9)
sw $8, -24($sp)
li $8, 0
sw $8, -28($sp)
lw $9, -24($sp)
lw $10, -28($sp)
sub $8, $9, $10
sw $8, -28($sp)
lw $8, -28($sp)
beqz $8, label6
lw $9, -12($sp)
move $8, $9
sw $8, -32($sp)
lw $9, -4($sp)
lw $8, 0($9)
sw $8, -36($sp)
lw $9, -36($sp)
add $8, $9, 12
sw $8, -36($sp)
lw $9, -36($sp)
lw $8, 0($9)
sw $8, -36($sp)
lw $9, -36($sp)
add $8, $9, 8
sw $8, -36($sp)
lw $9, -36($sp)
lw $8, 0($9)
sw $8, -36($sp)
lw $8, -36($sp)
lw $9, -32($sp)
sw $8, 0($9)
label6:
lw $9, -12($sp)
lw $8, 0($9)
sw $8, -40($sp)
lw $9, -8($sp)
lw $8, 0($9)
sw $8, -44($sp)
lw $9, -40($sp)
lw $10, -44($sp)
sub $8, $9, $10
sw $8, -44($sp)
lw $8, -44($sp)
blez $8, label7
sw $31, -136($29)
add $8, $29, -140
sw $8, -56($sp)
lw $9, -8($sp)
lw $8, 0($9)
sw $8, -52($sp)
lw $8, -52($sp)
lw $9, -56($sp)
sw $8, 0($9)
lw $9, -4($sp)
lw $8, 0($9)
sw $8, -60($sp)
lw $9, -60($sp)
add $8, $9, 12
sw $8, -60($sp)
add $8, $29, -144
sw $8, -64($sp)
lw $9, -60($sp)
lw $8, 0($9)
sw $8, -60($sp)
lw $8, -60($sp)
lw $9, -64($sp)
sw $8, 0($9)
add $29, $29, -144
jal __get_kth_element
sub $29, $29, -144
lw $31, -136($29)
add $8, $29, -132
sw $8, -68($sp)
add $8, $29, 12
sw $8, -72($sp)
lw $9, -68($sp)
lw $8, 0($9)
sw $8, -48($sp)
lw $8, -48($sp)
lw $9, -72($sp)
sw $8, 0($9)
jr $ra
label7:
lw $9, -12($sp)
lw $8, 0($9)
sw $8, -76($sp)
lw $9, -8($sp)
lw $8, 0($9)
sw $8, -80($sp)
lw $9, -76($sp)
lw $10, -80($sp)
sub $8, $9, $10
sw $8, -80($sp)
lw $8, -80($sp)
bgez $8, label8
sw $31, -136($29)
lw $9, -8($sp)
lw $8, 0($9)
sw $8, -88($sp)
lw $9, -12($sp)
lw $8, 0($9)
sw $8, -92($sp)
lw $9, -88($sp)
lw $10, -92($sp)
sub $8, $9, $10
sw $8, -88($sp)
li $8, 1
sw $8, -96($sp)
lw $9, -88($sp)
lw $10, -96($sp)
sub $8, $9, $10
sw $8, -88($sp)
add $8, $29, -140
sw $8, -100($sp)
lw $8, -88($sp)
lw $9, -100($sp)
sw $8, 0($9)
lw $9, -4($sp)
lw $8, 0($9)
sw $8, -104($sp)
lw $9, -104($sp)
add $8, $9, 16
sw $8, -104($sp)
add $8, $29, -144
sw $8, -108($sp)
lw $9, -104($sp)
lw $8, 0($9)
sw $8, -104($sp)
lw $8, -104($sp)
lw $9, -108($sp)
sw $8, 0($9)
add $29, $29, -144
jal __get_kth_element
sub $29, $29, -144
lw $31, -136($29)
add $8, $29, -132
sw $8, -112($sp)
add $8, $29, 12
sw $8, -116($sp)
lw $9, -112($sp)
lw $8, 0($9)
sw $8, -84($sp)
lw $8, -84($sp)
lw $9, -116($sp)
sw $8, 0($9)
jr $ra
label8:
lw $9, -4($sp)
lw $8, 0($9)
sw $8, -120($sp)
lw $9, -120($sp)
add $8, $9, 0
sw $8, -120($sp)
add $8, $29, 12
sw $8, -124($sp)
lw $9, -120($sp)
lw $8, 0($9)
sw $8, -120($sp)
lw $8, -120($sp)
lw $9, -124($sp)
sw $8, 0($9)
jr $ra
jr $ra
__alloc_node:
add $8, $29, -80
sw $8, -8($sp)
lw $9, -8($sp)
move $8, $9
sw $8, -4($sp)
sw $31, -88($29)
li $8, 20
sw $8, -16($sp)
add $8, $29, -92
sw $8, -20($sp)
lw $8, -16($sp)
lw $9, -20($sp)
sw $8, 0($9)
add $29, $29, -92
jal __malloc
sub $29, $29, -92
lw $31, -88($29)
add $8, $29, -84
sw $8, -24($sp)
lw $9, -24($sp)
lw $8, 0($9)
sw $8, -12($sp)
lw $8, -12($sp)
lw $9, -4($sp)
sw $8, 0($9)
lw $9, -4($sp)
lw $8, 0($9)
sw $8, -28($sp)
lw $9, -28($sp)
add $8, $9, 12
sw $8, -28($sp)
lw $9, -4($sp)
lw $8, 0($9)
sw $8, -32($sp)
lw $9, -32($sp)
add $8, $9, 16
sw $8, -32($sp)
li $8, 0
sw $8, -36($sp)
lw $8, -36($sp)
lw $9, -32($sp)
sw $8, 0($9)
lw $9, -32($sp)
lw $8, 0($9)
sw $8, -32($sp)
lw $8, -32($sp)
lw $9, -28($sp)
sw $8, 0($9)
lw $9, -4($sp)
lw $8, 0($9)
sw $8, -40($sp)
lw $9, -40($sp)
add $8, $9, 8
sw $8, -40($sp)
li $8, 1
sw $8, -44($sp)
lw $8, -44($sp)
lw $9, -40($sp)
sw $8, 0($9)
lw $9, -4($sp)
lw $8, 0($9)
sw $8, -48($sp)
lw $9, -48($sp)
add $8, $9, 4
sw $8, -48($sp)
sw $31, -88($29)
add $29, $29, -88
jal __get_random
sub $29, $29, -88
lw $31, -88($29)
add $8, $29, -84
sw $8, -56($sp)
lw $9, -56($sp)
lw $8, 0($9)
sw $8, -52($sp)
lw $8, -52($sp)
lw $9, -48($sp)
sw $8, 0($9)
lw $9, -4($sp)
lw $8, 0($9)
sw $8, -60($sp)
lw $9, -60($sp)
add $8, $9, 0
sw $8, -60($sp)
sw $31, -88($29)
add $29, $29, -88
jal __get_random
sub $29, $29, -88
lw $31, -88($29)
add $8, $29, -84
sw $8, -68($sp)
lw $9, -68($sp)
lw $8, 0($9)
sw $8, -64($sp)
lw $8, -64($sp)
lw $9, -60($sp)
sw $8, 0($9)
add $8, $29, 4
sw $8, -76($sp)
lw $9, -4($sp)
lw $8, 0($9)
sw $8, -72($sp)
lw $8, -72($sp)
lw $9, -76($sp)
sw $8, 0($9)
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
lw $9, 16($a3)
move $8, $9
sw $8, -4($sp)
li $8, 10000
sw $8, -8($sp)
add $29, $29, -236
jal __getchar
sub $29, $29, -236
add $8, $29, -232
sw $8, -16($sp)
lw $9, -16($sp)
lw $8, 0($9)
sw $8, -12($sp)
li $8, 48
sw $8, -20($sp)
lw $9, -12($sp)
lw $10, -20($sp)
sub $8, $9, $10
sw $8, -12($sp)
lw $9, -8($sp)
lw $10, -12($sp)
mul $8, $9, $10
sw $8, -8($sp)
li $8, 1000
sw $8, -24($sp)
add $29, $29, -236
jal __getchar
sub $29, $29, -236
add $8, $29, -232
sw $8, -32($sp)
lw $9, -32($sp)
lw $8, 0($9)
sw $8, -28($sp)
li $8, 48
sw $8, -36($sp)
lw $9, -28($sp)
lw $10, -36($sp)
sub $8, $9, $10
sw $8, -28($sp)
lw $9, -24($sp)
lw $10, -28($sp)
mul $8, $9, $10
sw $8, -24($sp)
lw $9, -8($sp)
lw $10, -24($sp)
add $8, $9, $10
sw $8, -8($sp)
li $8, 100
sw $8, -40($sp)
add $29, $29, -236
jal __getchar
sub $29, $29, -236
add $8, $29, -232
sw $8, -48($sp)
lw $9, -48($sp)
lw $8, 0($9)
sw $8, -44($sp)
li $8, 48
sw $8, -52($sp)
lw $9, -44($sp)
lw $10, -52($sp)
sub $8, $9, $10
sw $8, -44($sp)
lw $9, -40($sp)
lw $10, -44($sp)
mul $8, $9, $10
sw $8, -40($sp)
lw $9, -8($sp)
lw $10, -40($sp)
add $8, $9, $10
sw $8, -8($sp)
li $8, 10
sw $8, -56($sp)
add $29, $29, -236
jal __getchar
sub $29, $29, -236
add $8, $29, -232
sw $8, -64($sp)
lw $9, -64($sp)
lw $8, 0($9)
sw $8, -60($sp)
li $8, 48
sw $8, -68($sp)
lw $9, -60($sp)
lw $10, -68($sp)
sub $8, $9, $10
sw $8, -60($sp)
lw $9, -56($sp)
lw $10, -60($sp)
mul $8, $9, $10
sw $8, -56($sp)
lw $9, -8($sp)
lw $10, -56($sp)
add $8, $9, $10
sw $8, -8($sp)
add $29, $29, -236
jal __getchar
sub $29, $29, -236
add $8, $29, -232
sw $8, -76($sp)
lw $9, -76($sp)
lw $8, 0($9)
sw $8, -72($sp)
lw $9, -8($sp)
lw $10, -72($sp)
add $8, $9, $10
sw $8, -8($sp)
li $8, 48
sw $8, -80($sp)
lw $9, -8($sp)
lw $10, -80($sp)
sub $8, $9, $10
sw $8, -8($sp)
lw $8, -8($sp)
lw $9, -4($sp)
sw $8, 0($9)
lw $9, 48($a3)
move $8, $9
sw $8, -84($sp)
add $29, $29, -236
jal __alloc_node
sub $29, $29, -236
add $8, $29, -232
sw $8, -92($sp)
lw $9, -92($sp)
lw $8, 0($9)
sw $8, -88($sp)
lw $8, -88($sp)
lw $9, -84($sp)
sw $8, 0($9)
lw $9, 44($a3)
move $8, $9
sw $8, -96($sp)
li $8, 0
sw $8, -100($sp)
lw $8, -100($sp)
lw $9, -96($sp)
sw $8, 0($9)
label9:
lw $9, 44($a3)
lw $8, 0($9)
sw $8, -104($sp)
lw $9, 8($a3)
lw $8, 0($9)
sw $8, -108($sp)
lw $9, -104($sp)
lw $10, -108($sp)
sub $8, $9, $10
sw $8, -108($sp)
lw $8, -108($sp)
bgez $8, label10
lw $9, 48($a3)
move $8, $9
sw $8, -112($sp)
add $29, $29, -248
jal __alloc_node
sub $29, $29, -248
add $8, $29, -244
sw $8, -124($sp)
add $8, $29, -240
sw $8, -128($sp)
lw $9, -124($sp)
lw $8, 0($9)
sw $8, -120($sp)
lw $8, -120($sp)
lw $9, -128($sp)
sw $8, 0($9)
add $8, $29, -244
sw $8, -136($sp)
lw $9, 48($a3)
lw $8, 0($9)
sw $8, -132($sp)
lw $8, -132($sp)
lw $9, -136($sp)
sw $8, 0($9)
add $29, $29, -244
jal __insert_node
sub $29, $29, -244
add $8, $29, -232
sw $8, -140($sp)
lw $9, -140($sp)
lw $8, 0($9)
sw $8, -116($sp)
lw $8, -116($sp)
lw $9, -112($sp)
sw $8, 0($9)
label11:
lw $9, 44($a3)
move $8, $9
sw $8, -148($sp)
lw $9, 44($a3)
lw $8, 0($9)
sw $8, -144($sp)
lw $9, -144($sp)
add $8, $9, 1
sw $8, -152($sp)
lw $8, -152($sp)
lw $9, -148($sp)
sw $8, 0($9)
j label9
label10:
lw $9, 44($a3)
move $8, $9
sw $8, -156($sp)
li $8, 0
sw $8, -160($sp)
lw $8, -160($sp)
lw $9, -156($sp)
sw $8, 0($9)
label12:
lw $9, 44($a3)
lw $8, 0($9)
sw $8, -164($sp)
lw $9, 8($a3)
lw $8, 0($9)
sw $8, -168($sp)
lw $9, -164($sp)
lw $10, -168($sp)
sub $8, $9, $10
sw $8, -168($sp)
lw $8, -168($sp)
bgtz $8, label13
add $8, $29, -248
sw $8, -184($sp)
lw $9, 44($a3)
lw $8, 0($9)
sw $8, -180($sp)
lw $8, -180($sp)
lw $9, -184($sp)
sw $8, 0($9)
add $8, $29, -252
sw $8, -192($sp)
lw $9, 48($a3)
lw $8, 0($9)
sw $8, -188($sp)
lw $8, -188($sp)
lw $9, -192($sp)
sw $8, 0($9)
add $29, $29, -252
jal __get_kth_element
sub $29, $29, -252
add $8, $29, -240
sw $8, -196($sp)
add $8, $29, -236
sw $8, -200($sp)
lw $9, -196($sp)
lw $8, 0($9)
sw $8, -176($sp)
lw $8, -176($sp)
lw $9, -200($sp)
sw $8, 0($9)
lw $9, 876($a3)
move $8, $9
sw $8, -204($sp)
add $8, $29, -240
sw $8, -208($sp)
lw $8, -204($sp)
lw $9, -208($sp)
sw $8, 0($9)
add $29, $29, -240
jal __printf
sub $29, $29, -240
label14:
lw $9, 44($a3)
move $8, $9
sw $8, -216($sp)
lw $9, 44($a3)
lw $8, 0($9)
sw $8, -212($sp)
lw $9, -212($sp)
add $8, $9, 1
sw $8, -220($sp)
lw $8, -220($sp)
lw $9, -216($sp)
sw $8, 0($9)
j label12
label13:
li $8, 0
sw $8, -224($sp)
add $8, $29, 4
sw $8, -228($sp)
lw $8, -224($sp)
lw $9, -228($sp)
sw $8, 0($9)
j __main_end
j __main_end
__main_end:
li $v0, 10
syscall
#global $2 4
#global $4 4
#global $5 4
#global $7 4
#global $9 4
#global $11 4
#global $12 4
#string $219 #%d\n
#li $3 2000
#sw $3 $2 0
#li $6 12345
#sw $6 $5 0
#li $8 32768
#sw $8 $7 0
#li $10 86421
#sw $10 $9 0
#----------------------------
#func #get_random
#addi $14 $0 -44
#move $13 $14
####move $15 $4
#lw $15 $4 0
####move $16 $9
#lw $16 $9 0
#mul $15 $15 $16
####move $17 $5
#lw $17 $5 0
#add $15 $15 $17
#sw $15 $13 0
#move $18 $9
####move $19 $13
#lw $19 $13 0
####move $20 $7
#lw $20 $7 0
#mod $19 $19 $20
#sw $19 $18 0
####move $21 $13
#addi $22 $0 4
#lw $21 $13 0
#sw $21 $22 0
#return
#return
#----------------------------
#func #sum_of
#addi $23 $0 0
####move $24 $23
#lw $24 $23 0
#li $25 0
#sub $25 $24 $25
#bnez $25 l:0
#li $26 0
#addi $27 $0 8
#sw $26 $27 0
#return
#label l:0
####move $28 $23
#lw $28 $23 0
#addi $28 $28 8
#addi $29 $0 8
#lw $28 $28 0
#sw $28 $29 0
#return
#return
#----------------------------
#func #update
#addi $30 $0 0
####move $31 $30
#lw $31 $30 0
#addi $31 $31 8
#sw $1 $0 -52
####move $33 $30
#lw $33 $30 0
#addi $33 $33 12
#addi $34 $0 -56
#lw $33 $33 0
#sw $33 $34 0
#addi $0 $0 -56
#call #sum_of
#subi $0 $0 -56
#lw $1 $0 -52
#addi $35 $0 -48
####move $32 $35
#lw $32 $35 0
#sw $1 $0 -52
####move $37 $30
#lw $37 $30 0
#addi $37 $37 16
#addi $38 $0 -56
#lw $37 $37 0
#sw $37 $38 0
#addi $0 $0 -56
#call #sum_of
#subi $0 $0 -56
#lw $1 $0 -52
#addi $39 $0 -48
####move $36 $39
#lw $36 $39 0
#add $32 $32 $36
#li $40 1
#add $32 $32 $40
#sw $32 $31 0
#return
#----------------------------
#func #rotate_left
#addi $41 $0 0
#addi $43 $0 -68
#move $42 $43
####move $44 $41
#lw $44 $41 0
#addi $44 $44 16
#lw $44 $44 0
#sw $44 $42 0
####move $45 $41
#lw $45 $41 0
#addi $45 $45 16
####move $46 $42
#lw $46 $42 0
#addi $46 $46 12
#lw $46 $46 0
#sw $46 $45 0
####move $47 $42
#lw $47 $42 0
#addi $47 $47 12
####move $48 $41
#lw $48 $41 0
#sw $48 $47 0
#sw $1 $0 -72
####move $50 $41
#addi $51 $0 -76
#lw $50 $41 0
#sw $50 $51 0
#addi $0 $0 -76
#call #update
#subi $0 $0 -76
#lw $1 $0 -72
#sw $1 $0 -72
####move $53 $42
#addi $54 $0 -76
#lw $53 $42 0
#sw $53 $54 0
#addi $0 $0 -76
#call #update
#subi $0 $0 -76
#lw $1 $0 -72
####move $55 $42
#addi $56 $0 8
#lw $55 $42 0
#sw $55 $56 0
#return
#return
#----------------------------
#func #rotate_right
#addi $57 $0 0
#addi $59 $0 -68
#move $58 $59
####move $60 $57
#lw $60 $57 0
#addi $60 $60 12
#lw $60 $60 0
#sw $60 $58 0
####move $61 $57
#lw $61 $57 0
#addi $61 $61 12
####move $62 $58
#lw $62 $58 0
#addi $62 $62 16
#lw $62 $62 0
#sw $62 $61 0
####move $63 $58
#lw $63 $58 0
#addi $63 $63 16
####move $64 $57
#lw $64 $57 0
#sw $64 $63 0
#sw $1 $0 -72
####move $66 $57
#addi $67 $0 -76
#lw $66 $57 0
#sw $66 $67 0
#addi $0 $0 -76
#call #update
#subi $0 $0 -76
#lw $1 $0 -72
#sw $1 $0 -72
####move $69 $58
#addi $70 $0 -76
#lw $69 $58 0
#sw $69 $70 0
#addi $0 $0 -76
#call #update
#subi $0 $0 -76
#lw $1 $0 -72
####move $71 $58
#addi $72 $0 8
#lw $71 $58 0
#sw $71 $72 0
#return
#return
#----------------------------
#func #insert_node
#addi $73 $0 0
#addi $74 $0 4
####move $75 $73
#lw $75 $73 0
#li $76 0
#sub $76 $75 $76
#bnez $76 l:1
####move $77 $74
#addi $78 $0 12
#lw $77 $74 0
#sw $77 $78 0
#return
#label l:1
####move $79 $73
#lw $79 $73 0
#addi $79 $79 0
#lw $79 $79 0
####move $80 $74
#lw $80 $74 0
#addi $80 $80 0
#lw $80 $80 0
#sub $80 $79 $80
#blez $80 l:2
####move $81 $73
#lw $81 $73 0
#addi $81 $81 12
#sw $1 $0 -188
####move $83 $74
#addi $84 $0 -192
#lw $83 $74 0
#sw $83 $84 0
####move $85 $73
#lw $85 $73 0
#addi $85 $85 12
#addi $86 $0 -196
#lw $85 $85 0
#sw $85 $86 0
#addi $0 $0 -196
#call #insert_node
#subi $0 $0 -196
#lw $1 $0 -188
#addi $87 $0 -184
####move $82 $87
#lw $82 $87 0
#sw $82 $81 0
#goto l:3
#label l:2
####move $88 $73
#lw $88 $73 0
#addi $88 $88 16
#sw $1 $0 -188
####move $90 $74
#addi $91 $0 -192
#lw $90 $74 0
#sw $90 $91 0
####move $92 $73
#lw $92 $73 0
#addi $92 $92 16
#addi $93 $0 -196
#lw $92 $92 0
#sw $92 $93 0
#addi $0 $0 -196
#call #insert_node
#subi $0 $0 -196
#lw $1 $0 -188
#addi $94 $0 -184
####move $89 $94
#lw $89 $94 0
#sw $89 $88 0
#label l:3
#sw $1 $0 -184
####move $96 $73
#addi $97 $0 -188
#lw $96 $73 0
#sw $96 $97 0
#addi $0 $0 -188
#call #update
#subi $0 $0 -188
#lw $1 $0 -184
####move $98 $73
#lw $98 $73 0
#addi $98 $98 12
#lw $98 $98 0
#li $99 0
#sub $99 $98 $99
#beqz $99 l:4
####move $100 $73
#lw $100 $73 0
#addi $100 $100 12
#lw $100 $100 0
#addi $100 $100 4
#lw $100 $100 0
####move $101 $73
#lw $101 $73 0
#addi $101 $101 4
#lw $101 $101 0
#sub $101 $100 $101
#blez $101 l:4
#sw $1 $0 -188
####move $103 $73
#addi $104 $0 -192
#lw $103 $73 0
#sw $103 $104 0
#addi $0 $0 -192
#call #rotate_right
#subi $0 $0 -192
#lw $1 $0 -188
#addi $105 $0 -184
####move $102 $105
#addi $106 $0 12
#lw $102 $105 0
#sw $102 $106 0
#return
#label l:4
####move $107 $73
#lw $107 $73 0
#addi $107 $107 16
#lw $107 $107 0
#li $108 0
#sub $108 $107 $108
#beqz $108 l:5
####move $109 $73
#lw $109 $73 0
#addi $109 $109 16
#lw $109 $109 0
#addi $109 $109 4
#lw $109 $109 0
####move $110 $73
#lw $110 $73 0
#addi $110 $110 4
#lw $110 $110 0
#sub $110 $109 $110
#blez $110 l:5
#sw $1 $0 -188
####move $112 $73
#addi $113 $0 -192
#lw $112 $73 0
#sw $112 $113 0
#addi $0 $0 -192
#call #rotate_left
#subi $0 $0 -192
#lw $1 $0 -188
#addi $114 $0 -184
####move $111 $114
#addi $115 $0 12
#lw $111 $114 0
#sw $111 $115 0
#return
#label l:5
####move $116 $73
#addi $117 $0 12
#lw $116 $73 0
#sw $116 $117 0
#return
#return
#----------------------------
#func #get_kth_element
#addi $118 $0 0
#addi $119 $0 4
#addi $121 $0 -128
#move $120 $121
#li $122 0
#sw $122 $120 0
####move $123 $118
#lw $123 $118 0
#addi $123 $123 12
#lw $123 $123 0
#li $124 0
#sub $124 $123 $124
#beqz $124 l:6
#move $125 $120
####move $126 $118
#lw $126 $118 0
#addi $126 $126 12
#lw $126 $126 0
#addi $126 $126 8
#lw $126 $126 0
#sw $126 $125 0
#label l:6
####move $127 $120
#lw $127 $120 0
####move $128 $119
#lw $128 $119 0
#sub $128 $127 $128
#blez $128 l:7
#sw $1 $0 -136
####move $130 $119
#addi $131 $0 -140
#lw $130 $119 0
#sw $130 $131 0
####move $132 $118
#lw $132 $118 0
#addi $132 $132 12
#addi $133 $0 -144
#lw $132 $132 0
#sw $132 $133 0
#addi $0 $0 -144
#call #get_kth_element
#subi $0 $0 -144
#lw $1 $0 -136
#addi $134 $0 -132
####move $129 $134
#addi $135 $0 12
#lw $129 $134 0
#sw $129 $135 0
#return
#label l:7
####move $136 $120
#lw $136 $120 0
####move $137 $119
#lw $137 $119 0
#sub $137 $136 $137
#bgez $137 l:8
#sw $1 $0 -136
####move $139 $119
#lw $139 $119 0
####move $140 $120
#lw $140 $120 0
#sub $139 $139 $140
#li $141 1
#sub $139 $139 $141
#addi $142 $0 -140
#sw $139 $142 0
####move $143 $118
#lw $143 $118 0
#addi $143 $143 16
#addi $144 $0 -144
#lw $143 $143 0
#sw $143 $144 0
#addi $0 $0 -144
#call #get_kth_element
#subi $0 $0 -144
#lw $1 $0 -136
#addi $145 $0 -132
####move $138 $145
#addi $146 $0 12
#lw $138 $145 0
#sw $138 $146 0
#return
#label l:8
####move $147 $118
#lw $147 $118 0
#addi $147 $147 0
#addi $148 $0 12
#lw $147 $147 0
#sw $147 $148 0
#return
#return
#----------------------------
#func #alloc_node
#addi $150 $0 -80
#move $149 $150
#sw $1 $0 -88
#li $152 20
#addi $153 $0 -92
#sw $152 $153 0
#addi $0 $0 -92
#call #malloc
#subi $0 $0 -92
#lw $1 $0 -88
#addi $154 $0 -84
####move $151 $154
#lw $151 $154 0
#sw $151 $149 0
####move $155 $149
#lw $155 $149 0
#addi $155 $155 12
####move $156 $149
#lw $156 $149 0
#addi $156 $156 16
#li $157 0
#sw $157 $156 0
#lw $156 $156 0
#sw $156 $155 0
####move $158 $149
#lw $158 $149 0
#addi $158 $158 8
#li $159 1
#sw $159 $158 0
####move $160 $149
#lw $160 $149 0
#addi $160 $160 4
#sw $1 $0 -88
#addi $0 $0 -88
#call #get_random
#subi $0 $0 -88
#lw $1 $0 -88
#addi $162 $0 -84
####move $161 $162
#lw $161 $162 0
#sw $161 $160 0
####move $163 $149
#lw $163 $149 0
#addi $163 $163 0
#sw $1 $0 -88
#addi $0 $0 -88
#call #get_random
#subi $0 $0 -88
#lw $1 $0 -88
#addi $165 $0 -84
####move $164 $165
#lw $164 $165 0
#sw $164 $163 0
####move $166 $149
#addi $167 $0 4
#lw $166 $149 0
#sw $166 $167 0
#return
#return
#----------------------------
#func #main
#move $168 $4
#li $169 10000
#addi $0 $0 -236
#call #getchar
#subi $0 $0 -236
#addi $171 $0 -232
####move $170 $171
#lw $170 $171 0
#li $172 48
#sub $170 $170 $172
#mul $169 $169 $170
#li $173 1000
#addi $0 $0 -236
#call #getchar
#subi $0 $0 -236
#addi $175 $0 -232
####move $174 $175
#lw $174 $175 0
#li $176 48
#sub $174 $174 $176
#mul $173 $173 $174
#add $169 $169 $173
#li $177 100
#addi $0 $0 -236
#call #getchar
#subi $0 $0 -236
#addi $179 $0 -232
####move $178 $179
#lw $178 $179 0
#li $180 48
#sub $178 $178 $180
#mul $177 $177 $178
#add $169 $169 $177
#li $181 10
#addi $0 $0 -236
#call #getchar
#subi $0 $0 -236
#addi $183 $0 -232
####move $182 $183
#lw $182 $183 0
#li $184 48
#sub $182 $182 $184
#mul $181 $181 $182
#add $169 $169 $181
#addi $0 $0 -236
#call #getchar
#subi $0 $0 -236
#addi $186 $0 -232
####move $185 $186
#lw $185 $186 0
#add $169 $169 $185
#li $187 48
#sub $169 $169 $187
#sw $169 $168 0
#move $188 $12
#addi $0 $0 -236
#call #alloc_node
#subi $0 $0 -236
#addi $190 $0 -232
####move $189 $190
#lw $189 $190 0
#sw $189 $188 0
#move $191 $11
#li $192 0
#sw $192 $191 0
#label l:9
####move $193 $11
#lw $193 $11 0
####move $194 $2
#lw $194 $2 0
#sub $194 $193 $194
#bgez $194 l:10
#move $195 $12
#addi $0 $0 -248
#call #alloc_node
#subi $0 $0 -248
#addi $198 $0 -244
####move $197 $198
#addi $199 $0 -240
#lw $197 $198 0
#sw $197 $199 0
####move $200 $12
#addi $201 $0 -244
#lw $200 $12 0
#sw $200 $201 0
#addi $0 $0 -244
#call #insert_node
#subi $0 $0 -244
#addi $202 $0 -232
####move $196 $202
#lw $196 $202 0
#sw $196 $195 0
#label l:11
####move $203 $11
#move $204 $11
#lw $203 $11 0
#addi $205 $203 1
#sw $205 $204 0
#goto l:9
#label l:10
#move $206 $11
#li $207 0
#sw $207 $206 0
#label l:12
####move $208 $11
#lw $208 $11 0
####move $209 $2
#lw $209 $2 0
#sub $209 $208 $209
#bgtz $209 l:13
####move $212 $11
#addi $213 $0 -248
#lw $212 $11 0
#sw $212 $213 0
####move $214 $12
#addi $215 $0 -252
#lw $214 $12 0
#sw $214 $215 0
#addi $0 $0 -252
#call #get_kth_element
#subi $0 $0 -252
#addi $216 $0 -240
####move $211 $216
#addi $217 $0 -236
#lw $211 $216 0
#sw $211 $217 0
#move $218 $219
#addi $220 $0 -240
#sw $218 $220 0
#addi $0 $0 -240
#call #printf
#subi $0 $0 -240
#label l:14
####move $221 $11
#move $222 $11
#lw $221 $11 0
#addi $223 $221 1
#sw $223 $222 0
#goto l:12
#label l:13
#li $224 0
#addi $225 $0 4
#sw $224 $225 0
#return
#return
