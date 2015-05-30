.data
temp: .space 1064
var0: .space 4
var1: .space 4
var2: .space 4
var3: .space 7980
var4: .space 4
var5: .space 420
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

__num_of_sub:
add $8, $29, 0
sw $8, -4($sp)
add $8, $29, -224
sw $8, -12($sp)
lw $9, -12($sp)
move $8, $9
sw $8, -8($sp)
lw $9, -12($sp)
move $8, $9
sw $8, -16($sp)
li $8, 0
sw $8, -20($sp)
lw $8, -20($sp)
lw $9, -16($sp)
sw $8, 0($9)
label0:
lw $9, -8($sp)
lw $8, 0($9)
sw $8, -24($sp)
lw $9, -4($sp)
lw $8, 0($9)
sw $8, -32($sp)
lw $9, -32($sp)
mul $8, $9, 76
sw $8, -36($sp)
lw $9, 20($a3)
lw $10, -36($sp)
add $8, $9, $10
sw $8, -28($sp)
lw $9, -28($sp)
add $8, $9, 12
sw $8, -28($sp)
lw $9, -28($sp)
lw $8, 0($9)
sw $8, -28($sp)
lw $9, -24($sp)
lw $10, -28($sp)
sub $8, $9, $10
sw $8, -28($sp)
lw $8, -28($sp)
bgez $8, label1
lw $9, -4($sp)
lw $8, 0($9)
sw $8, -44($sp)
lw $9, -44($sp)
mul $8, $9, 76
sw $8, -48($sp)
lw $9, 20($a3)
lw $10, -48($sp)
add $8, $9, $10
sw $8, -40($sp)
lw $9, -40($sp)
add $8, $9, 16
sw $8, -40($sp)
lw $9, -8($sp)
lw $8, 0($9)
sw $8, -52($sp)
lw $9, -52($sp)
mul $8, $9, 4
sw $8, -56($sp)
lw $9, -40($sp)
lw $10, -56($sp)
add $8, $9, $10
sw $8, -40($sp)
lw $9, -40($sp)
lw $8, 0($9)
sw $8, -40($sp)
lw $9, -4($sp)
lw $8, 0($9)
sw $8, -64($sp)
lw $9, -64($sp)
mul $8, $9, 76
sw $8, -68($sp)
lw $9, 20($a3)
lw $10, -68($sp)
add $8, $9, $10
sw $8, -60($sp)
lw $9, -60($sp)
add $8, $9, 4
sw $8, -60($sp)
lw $9, -60($sp)
lw $8, 0($9)
sw $8, -60($sp)
lw $9, -40($sp)
lw $10, -60($sp)
sub $8, $9, $10
sw $8, -60($sp)
lw $8, -60($sp)
bnez $8, label3
j label2
label3:
lw $9, -4($sp)
lw $8, 0($9)
sw $8, -84($sp)
lw $9, -84($sp)
mul $8, $9, 76
sw $8, -88($sp)
lw $9, 20($a3)
lw $10, -88($sp)
add $8, $9, $10
sw $8, -76($sp)
lw $9, -76($sp)
add $8, $9, 16
sw $8, -76($sp)
lw $9, -8($sp)
lw $8, 0($9)
sw $8, -92($sp)
lw $9, -92($sp)
mul $8, $9, 4
sw $8, -96($sp)
lw $9, -76($sp)
lw $10, -96($sp)
add $8, $9, $10
sw $8, -76($sp)
lw $9, -76($sp)
lw $8, 0($9)
sw $8, -76($sp)
lw $9, -76($sp)
mul $8, $9, 76
sw $8, -80($sp)
lw $9, 20($a3)
lw $10, -80($sp)
add $8, $9, $10
sw $8, -72($sp)
lw $9, -72($sp)
add $8, $9, 4
sw $8, -72($sp)
lw $9, -4($sp)
lw $8, 0($9)
sw $8, -104($sp)
lw $9, -104($sp)
mul $8, $9, 76
sw $8, -108($sp)
lw $9, 20($a3)
lw $10, -108($sp)
add $8, $9, $10
sw $8, -100($sp)
lw $9, -100($sp)
add $8, $9, 0
sw $8, -100($sp)
lw $9, -100($sp)
lw $8, 0($9)
sw $8, -100($sp)
lw $8, -100($sp)
lw $9, -72($sp)
sw $8, 0($9)
lw $9, -4($sp)
lw $8, 0($9)
sw $8, -124($sp)
lw $9, -124($sp)
mul $8, $9, 76
sw $8, -128($sp)
lw $9, 20($a3)
lw $10, -128($sp)
add $8, $9, $10
sw $8, -116($sp)
lw $9, -116($sp)
add $8, $9, 16
sw $8, -116($sp)
lw $9, -8($sp)
lw $8, 0($9)
sw $8, -132($sp)
lw $9, -132($sp)
mul $8, $9, 4
sw $8, -136($sp)
lw $9, -116($sp)
lw $10, -136($sp)
add $8, $9, $10
sw $8, -116($sp)
lw $9, -116($sp)
lw $8, 0($9)
sw $8, -116($sp)
lw $9, -116($sp)
mul $8, $9, 76
sw $8, -120($sp)
lw $9, 20($a3)
lw $10, -120($sp)
add $8, $9, $10
sw $8, -112($sp)
lw $9, -112($sp)
add $8, $9, 8
sw $8, -112($sp)
li $8, 1
sw $8, -140($sp)
lw $9, -112($sp)
lw $8, 0($9)
sw $8, -144($sp)
lw $9, -144($sp)
lw $10, -140($sp)
sub $8, $9, $10
sw $8, -144($sp)
lw $8, -144($sp)
lw $9, -112($sp)
sw $8, 0($9)
lw $9, -4($sp)
lw $8, 0($9)
sw $8, -152($sp)
lw $9, -152($sp)
mul $8, $9, 76
sw $8, -156($sp)
lw $9, 20($a3)
lw $10, -156($sp)
add $8, $9, $10
sw $8, -148($sp)
lw $9, -148($sp)
add $8, $9, 8
sw $8, -148($sp)
sw $31, -232($29)
lw $9, -4($sp)
lw $8, 0($9)
sw $8, -168($sp)
lw $9, -168($sp)
mul $8, $9, 76
sw $8, -172($sp)
lw $9, 20($a3)
lw $10, -172($sp)
add $8, $9, $10
sw $8, -164($sp)
lw $9, -164($sp)
add $8, $9, 16
sw $8, -164($sp)
lw $9, -8($sp)
lw $8, 0($9)
sw $8, -176($sp)
lw $9, -176($sp)
mul $8, $9, 4
sw $8, -180($sp)
lw $9, -164($sp)
lw $10, -180($sp)
add $8, $9, $10
sw $8, -164($sp)
add $8, $29, -236
sw $8, -184($sp)
lw $9, -164($sp)
lw $8, 0($9)
sw $8, -164($sp)
lw $8, -164($sp)
lw $9, -184($sp)
sw $8, 0($9)
add $29, $29, -236
jal __num_of_sub
sub $29, $29, -236
lw $31, -232($29)
add $8, $29, -228
sw $8, -188($sp)
lw $9, -188($sp)
lw $8, 0($9)
sw $8, -160($sp)
li $8, 1
sw $8, -192($sp)
lw $9, -160($sp)
lw $10, -192($sp)
sub $8, $9, $10
sw $8, -160($sp)
lw $9, -148($sp)
lw $8, 0($9)
sw $8, -196($sp)
lw $9, -196($sp)
lw $10, -160($sp)
add $8, $9, $10
sw $8, -196($sp)
lw $8, -196($sp)
lw $9, -148($sp)
sw $8, 0($9)
label2:
lw $9, -8($sp)
move $8, $9
sw $8, -204($sp)
lw $9, -8($sp)
lw $8, 0($9)
sw $8, -200($sp)
lw $9, -200($sp)
add $8, $9, 1
sw $8, -200($sp)
lw $8, -200($sp)
lw $9, -204($sp)
sw $8, 0($9)
j label0
label1:
lw $9, -4($sp)
lw $8, 0($9)
sw $8, -212($sp)
lw $9, -212($sp)
mul $8, $9, 76
sw $8, -216($sp)
lw $9, 20($a3)
lw $10, -216($sp)
add $8, $9, $10
sw $8, -208($sp)
lw $9, -208($sp)
add $8, $9, 8
sw $8, -208($sp)
add $8, $29, 8
sw $8, -220($sp)
lw $9, -208($sp)
lw $8, 0($9)
sw $8, -208($sp)
lw $8, -208($sp)
lw $9, -220($sp)
sw $8, 0($9)
jr $ra
jr $ra
__alloc_node:
add $8, $29, 0
sw $8, -4($sp)
add $8, $29, -140
sw $8, -12($sp)
lw $9, -12($sp)
add $8, $9, 8
sw $8, -16($sp)
li $8, 1
sw $8, -20($sp)
lw $8, -20($sp)
lw $9, -16($sp)
sw $8, 0($9)
lw $9, -12($sp)
add $8, $9, 4
sw $8, -24($sp)
li $8, 0
sw $8, -28($sp)
lw $8, -28($sp)
lw $9, -24($sp)
sw $8, 0($9)
lw $9, -12($sp)
add $8, $9, 0
sw $8, -32($sp)
lw $9, -4($sp)
lw $8, 0($9)
sw $8, -36($sp)
lw $8, -36($sp)
lw $9, -32($sp)
sw $8, 0($9)
lw $9, -12($sp)
add $8, $9, 12
sw $8, -40($sp)
li $8, 0
sw $8, -44($sp)
lw $8, -44($sp)
lw $9, -40($sp)
sw $8, 0($9)
add $8, $29, 8
sw $8, -52($sp)
lw $9, -52($sp)
move $8, $9
sw $8, -56($sp)
lw $9, -12($sp)
lw $8, 0($9)
sw $8, -64($sp)
lw $8, -64($sp)
lw $9, -56($sp)
sw $8, 0($9)
lw $9, -56($sp)
add $8, $9, 4
sw $8, -56($sp)
lw $9, -12($sp)
add $8, $9, 4
sw $8, -60($sp)
lw $9, -60($sp)
lw $8, 0($9)
sw $8, -64($sp)
lw $8, -64($sp)
lw $9, -56($sp)
sw $8, 0($9)
lw $9, -56($sp)
add $8, $9, 4
sw $8, -56($sp)
lw $9, -60($sp)
add $8, $9, 4
sw $8, -60($sp)
lw $9, -60($sp)
lw $8, 0($9)
sw $8, -64($sp)
lw $8, -64($sp)
lw $9, -56($sp)
sw $8, 0($9)
lw $9, -56($sp)
add $8, $9, 4
sw $8, -56($sp)
lw $9, -60($sp)
add $8, $9, 4
sw $8, -60($sp)
lw $9, -60($sp)
lw $8, 0($9)
sw $8, -64($sp)
lw $8, -64($sp)
lw $9, -56($sp)
sw $8, 0($9)
lw $9, -56($sp)
add $8, $9, 4
sw $8, -56($sp)
lw $9, -60($sp)
add $8, $9, 4
sw $8, -60($sp)
lw $9, -60($sp)
lw $8, 0($9)
sw $8, -64($sp)
lw $8, -64($sp)
lw $9, -56($sp)
sw $8, 0($9)
lw $9, -56($sp)
add $8, $9, 4
sw $8, -56($sp)
lw $9, -60($sp)
add $8, $9, 4
sw $8, -60($sp)
lw $9, -60($sp)
lw $8, 0($9)
sw $8, -64($sp)
lw $8, -64($sp)
lw $9, -56($sp)
sw $8, 0($9)
lw $9, -56($sp)
add $8, $9, 4
sw $8, -56($sp)
lw $9, -60($sp)
add $8, $9, 4
sw $8, -60($sp)
lw $9, -60($sp)
lw $8, 0($9)
sw $8, -64($sp)
lw $8, -64($sp)
lw $9, -56($sp)
sw $8, 0($9)
lw $9, -56($sp)
add $8, $9, 4
sw $8, -56($sp)
lw $9, -60($sp)
add $8, $9, 4
sw $8, -60($sp)
lw $9, -60($sp)
lw $8, 0($9)
sw $8, -64($sp)
lw $8, -64($sp)
lw $9, -56($sp)
sw $8, 0($9)
lw $9, -56($sp)
add $8, $9, 4
sw $8, -56($sp)
lw $9, -60($sp)
add $8, $9, 4
sw $8, -60($sp)
lw $9, -60($sp)
lw $8, 0($9)
sw $8, -64($sp)
lw $8, -64($sp)
lw $9, -56($sp)
sw $8, 0($9)
lw $9, -56($sp)
add $8, $9, 4
sw $8, -56($sp)
lw $9, -60($sp)
add $8, $9, 4
sw $8, -60($sp)
lw $9, -60($sp)
lw $8, 0($9)
sw $8, -64($sp)
lw $8, -64($sp)
lw $9, -56($sp)
sw $8, 0($9)
lw $9, -56($sp)
add $8, $9, 4
sw $8, -56($sp)
lw $9, -60($sp)
add $8, $9, 4
sw $8, -60($sp)
lw $9, -60($sp)
lw $8, 0($9)
sw $8, -64($sp)
lw $8, -64($sp)
lw $9, -56($sp)
sw $8, 0($9)
lw $9, -56($sp)
add $8, $9, 4
sw $8, -56($sp)
lw $9, -60($sp)
add $8, $9, 4
sw $8, -60($sp)
lw $9, -60($sp)
lw $8, 0($9)
sw $8, -64($sp)
lw $8, -64($sp)
lw $9, -56($sp)
sw $8, 0($9)
lw $9, -56($sp)
add $8, $9, 4
sw $8, -56($sp)
lw $9, -60($sp)
add $8, $9, 4
sw $8, -60($sp)
lw $9, -60($sp)
lw $8, 0($9)
sw $8, -64($sp)
lw $8, -64($sp)
lw $9, -56($sp)
sw $8, 0($9)
lw $9, -56($sp)
add $8, $9, 4
sw $8, -56($sp)
lw $9, -60($sp)
add $8, $9, 4
sw $8, -60($sp)
lw $9, -60($sp)
lw $8, 0($9)
sw $8, -64($sp)
lw $8, -64($sp)
lw $9, -56($sp)
sw $8, 0($9)
lw $9, -56($sp)
add $8, $9, 4
sw $8, -56($sp)
lw $9, -60($sp)
add $8, $9, 4
sw $8, -60($sp)
lw $9, -60($sp)
lw $8, 0($9)
sw $8, -64($sp)
lw $8, -64($sp)
lw $9, -56($sp)
sw $8, 0($9)
lw $9, -56($sp)
add $8, $9, 4
sw $8, -56($sp)
lw $9, -60($sp)
add $8, $9, 4
sw $8, -60($sp)
lw $9, -60($sp)
lw $8, 0($9)
sw $8, -64($sp)
lw $8, -64($sp)
lw $9, -56($sp)
sw $8, 0($9)
lw $9, -56($sp)
add $8, $9, 4
sw $8, -56($sp)
lw $9, -60($sp)
add $8, $9, 4
sw $8, -60($sp)
lw $9, -60($sp)
lw $8, 0($9)
sw $8, -64($sp)
lw $8, -64($sp)
lw $9, -56($sp)
sw $8, 0($9)
lw $9, -56($sp)
add $8, $9, 4
sw $8, -56($sp)
lw $9, -60($sp)
add $8, $9, 4
sw $8, -60($sp)
lw $9, -60($sp)
lw $8, 0($9)
sw $8, -64($sp)
lw $8, -64($sp)
lw $9, -56($sp)
sw $8, 0($9)
lw $9, -56($sp)
add $8, $9, 4
sw $8, -56($sp)
lw $9, -60($sp)
add $8, $9, 4
sw $8, -60($sp)
lw $9, -60($sp)
lw $8, 0($9)
sw $8, -64($sp)
lw $8, -64($sp)
lw $9, -56($sp)
sw $8, 0($9)
lw $9, -56($sp)
add $8, $9, 4
sw $8, -56($sp)
lw $9, -60($sp)
add $8, $9, 4
sw $8, -60($sp)
jr $ra
jr $ra
__is_digit:
add $8, $29, 0
sw $8, -4($sp)
lw $9, -4($sp)
lb $8, 0($9)
sw $8, -8($sp)
li $8, 48
sw $8, -12($sp)
lw $9, -8($sp)
lw $10, -12($sp)
sub $8, $9, $10
sw $8, -12($sp)
li $8, 1
sw $8, -8($sp)
lw $8, -12($sp)
bgez $8, label4
li $8, 0
sw $8, -8($sp)
label4:
lw $8, -8($sp)
beqz $8, label5
lw $9, -4($sp)
lb $8, 0($9)
sw $8, -8($sp)
li $8, 57
sw $8, -16($sp)
lw $9, -8($sp)
lw $10, -16($sp)
sub $8, $9, $10
sw $8, -16($sp)
li $8, 1
sw $8, -8($sp)
lw $8, -16($sp)
blez $8, label6
li $8, 0
sw $8, -8($sp)
label6:
label5:
lw $9, -8($sp)
andi $8, $9, 1
sw $8, -8($sp)
add $8, $29, 8
sw $8, -20($sp)
lw $8, -8($sp)
lw $9, -20($sp)
sw $8, 0($9)
jr $ra
jr $ra
__get_d:
add $8, $29, -116
sw $8, -8($sp)
lw $9, -8($sp)
move $8, $9
sw $8, -4($sp)
sw $31, -124($29)
add $29, $29, -124
jal __getchar
sub $29, $29, -124
lw $31, -124($29)
add $8, $29, -120
sw $8, -16($sp)
lw $9, -16($sp)
lw $8, 0($9)
sw $8, -12($sp)
lw $8, -12($sp)
lw $9, -4($sp)
sw $8, 0($9)
add $8, $29, -120
sw $8, -24($sp)
lw $9, -24($sp)
move $8, $9
sw $8, -20($sp)
li $8, 0
sw $8, -28($sp)
lw $8, -28($sp)
lw $9, -20($sp)
sw $8, 0($9)
label7:
sw $31, -128($29)
add $8, $29, -132
sw $8, -40($sp)
lw $9, -4($sp)
lb $8, 0($9)
sw $8, -36($sp)
lw $8, -36($sp)
lw $9, -40($sp)
sb $8, 0($9)
add $29, $29, -132
jal __is_digit
sub $29, $29, -132
lw $31, -128($29)
add $8, $29, -124
sw $8, -44($sp)
lw $9, -44($sp)
lw $8, 0($9)
sw $8, -32($sp)
lw $9, -32($sp)
li $8, 1
beqz $9, lnot0
li $8, 0
lnot0:
sw $8, -32($sp)
lw $8, -32($sp)
beqz $8, label8
lw $9, -4($sp)
move $8, $9
sw $8, -48($sp)
sw $31, -128($29)
add $29, $29, -128
jal __getchar
sub $29, $29, -128
lw $31, -128($29)
add $8, $29, -124
sw $8, -56($sp)
lw $9, -56($sp)
lw $8, 0($9)
sw $8, -52($sp)
lw $8, -52($sp)
lw $9, -48($sp)
sw $8, 0($9)
j label7
label8:
label9:
sw $31, -128($29)
add $8, $29, -132
sw $8, -68($sp)
lw $9, -4($sp)
lb $8, 0($9)
sw $8, -64($sp)
lw $8, -64($sp)
lw $9, -68($sp)
sb $8, 0($9)
add $29, $29, -132
jal __is_digit
sub $29, $29, -132
lw $31, -128($29)
add $8, $29, -124
sw $8, -72($sp)
lw $9, -72($sp)
lw $8, 0($9)
sw $8, -60($sp)
lw $8, -60($sp)
beqz $8, label10
lw $9, -20($sp)
move $8, $9
sw $8, -76($sp)
lw $9, -20($sp)
lw $8, 0($9)
sw $8, -80($sp)
li $8, 10
sw $8, -84($sp)
lw $9, -80($sp)
lw $10, -84($sp)
mul $8, $9, $10
sw $8, -80($sp)
lw $9, -4($sp)
lw $8, 0($9)
sw $8, -88($sp)
lw $9, -80($sp)
lw $10, -88($sp)
add $8, $9, $10
sw $8, -80($sp)
li $8, 48
sw $8, -92($sp)
lw $9, -80($sp)
lw $10, -92($sp)
sub $8, $9, $10
sw $8, -80($sp)
lw $8, -80($sp)
lw $9, -76($sp)
sw $8, 0($9)
lw $9, -4($sp)
move $8, $9
sw $8, -96($sp)
sw $31, -128($29)
add $29, $29, -128
jal __getchar
sub $29, $29, -128
lw $31, -128($29)
add $8, $29, -124
sw $8, -104($sp)
lw $9, -104($sp)
lw $8, 0($9)
sw $8, -100($sp)
lw $8, -100($sp)
lw $9, -96($sp)
sw $8, 0($9)
j label9
label10:
add $8, $29, 4
sw $8, -112($sp)
lw $9, -20($sp)
lw $8, 0($9)
sw $8, -108($sp)
lw $8, -108($sp)
lw $9, -112($sp)
sw $8, 0($9)
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
sw $t0, 1048($a3)
add $8, $29, -612
sw $8, -8($sp)
lw $9, -8($sp)
move $8, $9
sw $8, -4($sp)
lw $9, 8($a3)
move $8, $9
sw $8, -12($sp)
add $29, $29, -620
jal __get_d
sub $29, $29, -620
add $8, $29, -616
sw $8, -20($sp)
lw $9, -20($sp)
lw $8, 0($9)
sw $8, -16($sp)
lw $8, -16($sp)
lw $9, -12($sp)
sw $8, 0($9)
lw $9, -8($sp)
move $8, $9
sw $8, -24($sp)
li $8, 0
sw $8, -28($sp)
lw $8, -28($sp)
lw $9, -24($sp)
sw $8, 0($9)
label11:
lw $9, -4($sp)
lw $8, 0($9)
sw $8, -32($sp)
lw $9, 8($a3)
lw $8, 0($9)
sw $8, -36($sp)
li $8, 1
sw $8, -40($sp)
lw $9, -36($sp)
lw $10, -40($sp)
sub $8, $9, $10
sw $8, -36($sp)
lw $9, -32($sp)
lw $10, -36($sp)
sub $8, $9, $10
sw $8, -36($sp)
lw $8, -36($sp)
bgez $8, label12
lw $9, 12($a3)
move $8, $9
sw $8, -44($sp)
add $29, $29, -620
jal __get_d
sub $29, $29, -620
add $8, $29, -616
sw $8, -52($sp)
lw $9, -52($sp)
lw $8, 0($9)
sw $8, -48($sp)
lw $8, -48($sp)
lw $9, -44($sp)
sw $8, 0($9)
lw $9, 16($a3)
move $8, $9
sw $8, -56($sp)
add $29, $29, -620
jal __get_d
sub $29, $29, -620
add $8, $29, -616
sw $8, -64($sp)
lw $9, -64($sp)
lw $8, 0($9)
sw $8, -60($sp)
lw $8, -60($sp)
lw $9, -56($sp)
sw $8, 0($9)
lw $9, 12($a3)
lw $8, 0($9)
sw $8, -72($sp)
lw $9, -72($sp)
mul $8, $9, 4
sw $8, -76($sp)
lw $9, 28($a3)
lw $10, -76($sp)
add $8, $9, $10
sw $8, -68($sp)
lw $9, -68($sp)
lw $8, 0($9)
sw $8, -68($sp)
lw $9, -68($sp)
li $8, 1
beqz $9, lnot1
li $8, 0
lnot1:
sw $8, -68($sp)
lw $8, -68($sp)
beqz $8, label14
lw $9, 12($a3)
lw $8, 0($9)
sw $8, -84($sp)
lw $9, -84($sp)
mul $8, $9, 76
sw $8, -88($sp)
lw $9, 20($a3)
lw $10, -88($sp)
add $8, $9, $10
sw $8, -80($sp)
add $8, $29, -696
sw $8, -100($sp)
lw $9, 12($a3)
lw $8, 0($9)
sw $8, -96($sp)
lw $8, -96($sp)
lw $9, -100($sp)
sw $8, 0($9)
add $29, $29, -696
jal __alloc_node
sub $29, $29, -696
add $8, $29, -688
sw $8, -104($sp)
lw $9, -104($sp)
move $8, $9
sw $8, -92($sp)
lw $9, -80($sp)
move $8, $9
sw $8, -108($sp)
lw $9, -104($sp)
lw $8, 0($9)
sw $8, -116($sp)
lw $8, -116($sp)
lw $9, -108($sp)
sw $8, 0($9)
lw $9, -108($sp)
add $8, $9, 4
sw $8, -108($sp)
lw $9, -104($sp)
add $8, $9, 4
sw $8, -112($sp)
lw $9, -112($sp)
lw $8, 0($9)
sw $8, -116($sp)
lw $8, -116($sp)
lw $9, -108($sp)
sw $8, 0($9)
lw $9, -108($sp)
add $8, $9, 4
sw $8, -108($sp)
lw $9, -112($sp)
add $8, $9, 4
sw $8, -112($sp)
lw $9, -112($sp)
lw $8, 0($9)
sw $8, -116($sp)
lw $8, -116($sp)
lw $9, -108($sp)
sw $8, 0($9)
lw $9, -108($sp)
add $8, $9, 4
sw $8, -108($sp)
lw $9, -112($sp)
add $8, $9, 4
sw $8, -112($sp)
lw $9, -112($sp)
lw $8, 0($9)
sw $8, -116($sp)
lw $8, -116($sp)
lw $9, -108($sp)
sw $8, 0($9)
lw $9, -108($sp)
add $8, $9, 4
sw $8, -108($sp)
lw $9, -112($sp)
add $8, $9, 4
sw $8, -112($sp)
lw $9, -112($sp)
lw $8, 0($9)
sw $8, -116($sp)
lw $8, -116($sp)
lw $9, -108($sp)
sw $8, 0($9)
lw $9, -108($sp)
add $8, $9, 4
sw $8, -108($sp)
lw $9, -112($sp)
add $8, $9, 4
sw $8, -112($sp)
lw $9, -112($sp)
lw $8, 0($9)
sw $8, -116($sp)
lw $8, -116($sp)
lw $9, -108($sp)
sw $8, 0($9)
lw $9, -108($sp)
add $8, $9, 4
sw $8, -108($sp)
lw $9, -112($sp)
add $8, $9, 4
sw $8, -112($sp)
lw $9, -112($sp)
lw $8, 0($9)
sw $8, -116($sp)
lw $8, -116($sp)
lw $9, -108($sp)
sw $8, 0($9)
lw $9, -108($sp)
add $8, $9, 4
sw $8, -108($sp)
lw $9, -112($sp)
add $8, $9, 4
sw $8, -112($sp)
lw $9, -112($sp)
lw $8, 0($9)
sw $8, -116($sp)
lw $8, -116($sp)
lw $9, -108($sp)
sw $8, 0($9)
lw $9, -108($sp)
add $8, $9, 4
sw $8, -108($sp)
lw $9, -112($sp)
add $8, $9, 4
sw $8, -112($sp)
lw $9, -112($sp)
lw $8, 0($9)
sw $8, -116($sp)
lw $8, -116($sp)
lw $9, -108($sp)
sw $8, 0($9)
lw $9, -108($sp)
add $8, $9, 4
sw $8, -108($sp)
lw $9, -112($sp)
add $8, $9, 4
sw $8, -112($sp)
lw $9, -112($sp)
lw $8, 0($9)
sw $8, -116($sp)
lw $8, -116($sp)
lw $9, -108($sp)
sw $8, 0($9)
lw $9, -108($sp)
add $8, $9, 4
sw $8, -108($sp)
lw $9, -112($sp)
add $8, $9, 4
sw $8, -112($sp)
lw $9, -112($sp)
lw $8, 0($9)
sw $8, -116($sp)
lw $8, -116($sp)
lw $9, -108($sp)
sw $8, 0($9)
lw $9, -108($sp)
add $8, $9, 4
sw $8, -108($sp)
lw $9, -112($sp)
add $8, $9, 4
sw $8, -112($sp)
lw $9, -112($sp)
lw $8, 0($9)
sw $8, -116($sp)
lw $8, -116($sp)
lw $9, -108($sp)
sw $8, 0($9)
lw $9, -108($sp)
add $8, $9, 4
sw $8, -108($sp)
lw $9, -112($sp)
add $8, $9, 4
sw $8, -112($sp)
lw $9, -112($sp)
lw $8, 0($9)
sw $8, -116($sp)
lw $8, -116($sp)
lw $9, -108($sp)
sw $8, 0($9)
lw $9, -108($sp)
add $8, $9, 4
sw $8, -108($sp)
lw $9, -112($sp)
add $8, $9, 4
sw $8, -112($sp)
lw $9, -112($sp)
lw $8, 0($9)
sw $8, -116($sp)
lw $8, -116($sp)
lw $9, -108($sp)
sw $8, 0($9)
lw $9, -108($sp)
add $8, $9, 4
sw $8, -108($sp)
lw $9, -112($sp)
add $8, $9, 4
sw $8, -112($sp)
lw $9, -112($sp)
lw $8, 0($9)
sw $8, -116($sp)
lw $8, -116($sp)
lw $9, -108($sp)
sw $8, 0($9)
lw $9, -108($sp)
add $8, $9, 4
sw $8, -108($sp)
lw $9, -112($sp)
add $8, $9, 4
sw $8, -112($sp)
lw $9, -112($sp)
lw $8, 0($9)
sw $8, -116($sp)
lw $8, -116($sp)
lw $9, -108($sp)
sw $8, 0($9)
lw $9, -108($sp)
add $8, $9, 4
sw $8, -108($sp)
lw $9, -112($sp)
add $8, $9, 4
sw $8, -112($sp)
lw $9, -112($sp)
lw $8, 0($9)
sw $8, -116($sp)
lw $8, -116($sp)
lw $9, -108($sp)
sw $8, 0($9)
lw $9, -108($sp)
add $8, $9, 4
sw $8, -108($sp)
lw $9, -112($sp)
add $8, $9, 4
sw $8, -112($sp)
lw $9, -112($sp)
lw $8, 0($9)
sw $8, -116($sp)
lw $8, -116($sp)
lw $9, -108($sp)
sw $8, 0($9)
lw $9, -108($sp)
add $8, $9, 4
sw $8, -108($sp)
lw $9, -112($sp)
add $8, $9, 4
sw $8, -112($sp)
lw $9, -112($sp)
lw $8, 0($9)
sw $8, -116($sp)
lw $8, -116($sp)
lw $9, -108($sp)
sw $8, 0($9)
lw $9, -108($sp)
add $8, $9, 4
sw $8, -108($sp)
lw $9, -112($sp)
add $8, $9, 4
sw $8, -112($sp)
label14:
lw $9, 16($a3)
lw $8, 0($9)
sw $8, -124($sp)
lw $9, -124($sp)
mul $8, $9, 4
sw $8, -128($sp)
lw $9, 28($a3)
lw $10, -128($sp)
add $8, $9, $10
sw $8, -120($sp)
lw $9, -120($sp)
lw $8, 0($9)
sw $8, -120($sp)
lw $9, -120($sp)
li $8, 1
beqz $9, lnot2
li $8, 0
lnot2:
sw $8, -120($sp)
lw $8, -120($sp)
beqz $8, label15
lw $9, 16($a3)
lw $8, 0($9)
sw $8, -136($sp)
lw $9, -136($sp)
mul $8, $9, 76
sw $8, -140($sp)
lw $9, 20($a3)
lw $10, -140($sp)
add $8, $9, $10
sw $8, -132($sp)
add $8, $29, -696
sw $8, -152($sp)
lw $9, 16($a3)
lw $8, 0($9)
sw $8, -148($sp)
lw $8, -148($sp)
lw $9, -152($sp)
sw $8, 0($9)
add $29, $29, -696
jal __alloc_node
sub $29, $29, -696
add $8, $29, -688
sw $8, -156($sp)
lw $9, -156($sp)
move $8, $9
sw $8, -144($sp)
lw $9, -132($sp)
move $8, $9
sw $8, -160($sp)
lw $9, -156($sp)
lw $8, 0($9)
sw $8, -168($sp)
lw $8, -168($sp)
lw $9, -160($sp)
sw $8, 0($9)
lw $9, -160($sp)
add $8, $9, 4
sw $8, -160($sp)
lw $9, -156($sp)
add $8, $9, 4
sw $8, -164($sp)
lw $9, -164($sp)
lw $8, 0($9)
sw $8, -168($sp)
lw $8, -168($sp)
lw $9, -160($sp)
sw $8, 0($9)
lw $9, -160($sp)
add $8, $9, 4
sw $8, -160($sp)
lw $9, -164($sp)
add $8, $9, 4
sw $8, -164($sp)
lw $9, -164($sp)
lw $8, 0($9)
sw $8, -168($sp)
lw $8, -168($sp)
lw $9, -160($sp)
sw $8, 0($9)
lw $9, -160($sp)
add $8, $9, 4
sw $8, -160($sp)
lw $9, -164($sp)
add $8, $9, 4
sw $8, -164($sp)
lw $9, -164($sp)
lw $8, 0($9)
sw $8, -168($sp)
lw $8, -168($sp)
lw $9, -160($sp)
sw $8, 0($9)
lw $9, -160($sp)
add $8, $9, 4
sw $8, -160($sp)
lw $9, -164($sp)
add $8, $9, 4
sw $8, -164($sp)
lw $9, -164($sp)
lw $8, 0($9)
sw $8, -168($sp)
lw $8, -168($sp)
lw $9, -160($sp)
sw $8, 0($9)
lw $9, -160($sp)
add $8, $9, 4
sw $8, -160($sp)
lw $9, -164($sp)
add $8, $9, 4
sw $8, -164($sp)
lw $9, -164($sp)
lw $8, 0($9)
sw $8, -168($sp)
lw $8, -168($sp)
lw $9, -160($sp)
sw $8, 0($9)
lw $9, -160($sp)
add $8, $9, 4
sw $8, -160($sp)
lw $9, -164($sp)
add $8, $9, 4
sw $8, -164($sp)
lw $9, -164($sp)
lw $8, 0($9)
sw $8, -168($sp)
lw $8, -168($sp)
lw $9, -160($sp)
sw $8, 0($9)
lw $9, -160($sp)
add $8, $9, 4
sw $8, -160($sp)
lw $9, -164($sp)
add $8, $9, 4
sw $8, -164($sp)
lw $9, -164($sp)
lw $8, 0($9)
sw $8, -168($sp)
lw $8, -168($sp)
lw $9, -160($sp)
sw $8, 0($9)
lw $9, -160($sp)
add $8, $9, 4
sw $8, -160($sp)
lw $9, -164($sp)
add $8, $9, 4
sw $8, -164($sp)
lw $9, -164($sp)
lw $8, 0($9)
sw $8, -168($sp)
lw $8, -168($sp)
lw $9, -160($sp)
sw $8, 0($9)
lw $9, -160($sp)
add $8, $9, 4
sw $8, -160($sp)
lw $9, -164($sp)
add $8, $9, 4
sw $8, -164($sp)
lw $9, -164($sp)
lw $8, 0($9)
sw $8, -168($sp)
lw $8, -168($sp)
lw $9, -160($sp)
sw $8, 0($9)
lw $9, -160($sp)
add $8, $9, 4
sw $8, -160($sp)
lw $9, -164($sp)
add $8, $9, 4
sw $8, -164($sp)
lw $9, -164($sp)
lw $8, 0($9)
sw $8, -168($sp)
lw $8, -168($sp)
lw $9, -160($sp)
sw $8, 0($9)
lw $9, -160($sp)
add $8, $9, 4
sw $8, -160($sp)
lw $9, -164($sp)
add $8, $9, 4
sw $8, -164($sp)
lw $9, -164($sp)
lw $8, 0($9)
sw $8, -168($sp)
lw $8, -168($sp)
lw $9, -160($sp)
sw $8, 0($9)
lw $9, -160($sp)
add $8, $9, 4
sw $8, -160($sp)
lw $9, -164($sp)
add $8, $9, 4
sw $8, -164($sp)
lw $9, -164($sp)
lw $8, 0($9)
sw $8, -168($sp)
lw $8, -168($sp)
lw $9, -160($sp)
sw $8, 0($9)
lw $9, -160($sp)
add $8, $9, 4
sw $8, -160($sp)
lw $9, -164($sp)
add $8, $9, 4
sw $8, -164($sp)
lw $9, -164($sp)
lw $8, 0($9)
sw $8, -168($sp)
lw $8, -168($sp)
lw $9, -160($sp)
sw $8, 0($9)
lw $9, -160($sp)
add $8, $9, 4
sw $8, -160($sp)
lw $9, -164($sp)
add $8, $9, 4
sw $8, -164($sp)
lw $9, -164($sp)
lw $8, 0($9)
sw $8, -168($sp)
lw $8, -168($sp)
lw $9, -160($sp)
sw $8, 0($9)
lw $9, -160($sp)
add $8, $9, 4
sw $8, -160($sp)
lw $9, -164($sp)
add $8, $9, 4
sw $8, -164($sp)
lw $9, -164($sp)
lw $8, 0($9)
sw $8, -168($sp)
lw $8, -168($sp)
lw $9, -160($sp)
sw $8, 0($9)
lw $9, -160($sp)
add $8, $9, 4
sw $8, -160($sp)
lw $9, -164($sp)
add $8, $9, 4
sw $8, -164($sp)
lw $9, -164($sp)
lw $8, 0($9)
sw $8, -168($sp)
lw $8, -168($sp)
lw $9, -160($sp)
sw $8, 0($9)
lw $9, -160($sp)
add $8, $9, 4
sw $8, -160($sp)
lw $9, -164($sp)
add $8, $9, 4
sw $8, -164($sp)
lw $9, -164($sp)
lw $8, 0($9)
sw $8, -168($sp)
lw $8, -168($sp)
lw $9, -160($sp)
sw $8, 0($9)
lw $9, -160($sp)
add $8, $9, 4
sw $8, -160($sp)
lw $9, -164($sp)
add $8, $9, 4
sw $8, -164($sp)
lw $9, -164($sp)
lw $8, 0($9)
sw $8, -168($sp)
lw $8, -168($sp)
lw $9, -160($sp)
sw $8, 0($9)
lw $9, -160($sp)
add $8, $9, 4
sw $8, -160($sp)
lw $9, -164($sp)
add $8, $9, 4
sw $8, -164($sp)
label15:
lw $9, 12($a3)
lw $8, 0($9)
sw $8, -176($sp)
lw $9, -176($sp)
mul $8, $9, 76
sw $8, -180($sp)
lw $9, 20($a3)
lw $10, -180($sp)
add $8, $9, $10
sw $8, -172($sp)
lw $9, -172($sp)
add $8, $9, 16
sw $8, -172($sp)
lw $9, 12($a3)
lw $8, 0($9)
sw $8, -192($sp)
lw $9, -192($sp)
mul $8, $9, 76
sw $8, -196($sp)
lw $9, 20($a3)
lw $10, -196($sp)
add $8, $9, $10
sw $8, -184($sp)
lw $9, -184($sp)
add $8, $9, 12
sw $8, -184($sp)
lw $9, -184($sp)
lw $8, 0($9)
sw $8, -184($sp)
lw $9, -184($sp)
mul $8, $9, 4
sw $8, -188($sp)
lw $9, -172($sp)
lw $10, -188($sp)
add $8, $9, $10
sw $8, -172($sp)
lw $9, 16($a3)
lw $8, 0($9)
sw $8, -200($sp)
lw $8, -200($sp)
lw $9, -172($sp)
sw $8, 0($9)
lw $9, 12($a3)
lw $8, 0($9)
sw $8, -208($sp)
lw $9, -208($sp)
mul $8, $9, 76
sw $8, -212($sp)
lw $9, 20($a3)
lw $10, -212($sp)
add $8, $9, $10
sw $8, -204($sp)
lw $9, -204($sp)
add $8, $9, 12
sw $8, -204($sp)
lw $9, -204($sp)
move $8, $9
sw $8, -216($sp)
lw $9, -204($sp)
lw $8, 0($9)
sw $8, -204($sp)
lw $9, -204($sp)
add $8, $9, 1
sw $8, -220($sp)
lw $8, -220($sp)
lw $9, -216($sp)
sw $8, 0($9)
lw $9, 12($a3)
lw $8, 0($9)
sw $8, -228($sp)
lw $9, -228($sp)
mul $8, $9, 76
sw $8, -232($sp)
lw $9, 20($a3)
lw $10, -232($sp)
add $8, $9, $10
sw $8, -224($sp)
lw $9, -224($sp)
add $8, $9, 8
sw $8, -224($sp)
lw $9, -224($sp)
move $8, $9
sw $8, -236($sp)
lw $9, -224($sp)
lw $8, 0($9)
sw $8, -224($sp)
lw $9, -224($sp)
add $8, $9, 1
sw $8, -240($sp)
lw $8, -240($sp)
lw $9, -236($sp)
sw $8, 0($9)
lw $9, 16($a3)
lw $8, 0($9)
sw $8, -248($sp)
lw $9, -248($sp)
mul $8, $9, 76
sw $8, -252($sp)
lw $9, 20($a3)
lw $10, -252($sp)
add $8, $9, $10
sw $8, -244($sp)
lw $9, -244($sp)
add $8, $9, 16
sw $8, -244($sp)
lw $9, 16($a3)
lw $8, 0($9)
sw $8, -264($sp)
lw $9, -264($sp)
mul $8, $9, 76
sw $8, -268($sp)
lw $9, 20($a3)
lw $10, -268($sp)
add $8, $9, $10
sw $8, -256($sp)
lw $9, -256($sp)
add $8, $9, 12
sw $8, -256($sp)
lw $9, -256($sp)
lw $8, 0($9)
sw $8, -256($sp)
lw $9, -256($sp)
mul $8, $9, 4
sw $8, -260($sp)
lw $9, -244($sp)
lw $10, -260($sp)
add $8, $9, $10
sw $8, -244($sp)
lw $9, 12($a3)
lw $8, 0($9)
sw $8, -272($sp)
lw $8, -272($sp)
lw $9, -244($sp)
sw $8, 0($9)
lw $9, 16($a3)
lw $8, 0($9)
sw $8, -280($sp)
lw $9, -280($sp)
mul $8, $9, 76
sw $8, -284($sp)
lw $9, 20($a3)
lw $10, -284($sp)
add $8, $9, $10
sw $8, -276($sp)
lw $9, -276($sp)
add $8, $9, 12
sw $8, -276($sp)
lw $9, -276($sp)
move $8, $9
sw $8, -288($sp)
lw $9, -276($sp)
lw $8, 0($9)
sw $8, -276($sp)
lw $9, -276($sp)
add $8, $9, 1
sw $8, -292($sp)
lw $8, -292($sp)
lw $9, -288($sp)
sw $8, 0($9)
lw $9, 16($a3)
lw $8, 0($9)
sw $8, -300($sp)
lw $9, -300($sp)
mul $8, $9, 76
sw $8, -304($sp)
lw $9, 20($a3)
lw $10, -304($sp)
add $8, $9, $10
sw $8, -296($sp)
lw $9, -296($sp)
add $8, $9, 8
sw $8, -296($sp)
lw $9, -296($sp)
move $8, $9
sw $8, -308($sp)
lw $9, -296($sp)
lw $8, 0($9)
sw $8, -296($sp)
lw $9, -296($sp)
add $8, $9, 1
sw $8, -312($sp)
lw $8, -312($sp)
lw $9, -308($sp)
sw $8, 0($9)
lw $9, 12($a3)
lw $8, 0($9)
sw $8, -320($sp)
lw $9, -320($sp)
mul $8, $9, 4
sw $8, -324($sp)
lw $9, 28($a3)
lw $10, -324($sp)
add $8, $9, $10
sw $8, -316($sp)
lw $9, 16($a3)
lw $8, 0($9)
sw $8, -332($sp)
lw $9, -332($sp)
mul $8, $9, 4
sw $8, -336($sp)
lw $9, 28($a3)
lw $10, -336($sp)
add $8, $9, $10
sw $8, -328($sp)
li $8, 1
sw $8, -340($sp)
lw $8, -340($sp)
lw $9, -328($sp)
sw $8, 0($9)
lw $9, -328($sp)
lw $8, 0($9)
sw $8, -328($sp)
lw $8, -328($sp)
lw $9, -316($sp)
sw $8, 0($9)
label13:
lw $9, -4($sp)
move $8, $9
sw $8, -348($sp)
lw $9, -4($sp)
lw $8, 0($9)
sw $8, -344($sp)
lw $9, -344($sp)
add $8, $9, 1
sw $8, -344($sp)
lw $8, -344($sp)
lw $9, -348($sp)
sw $8, 0($9)
j label11
label12:
li $8, 1
sw $8, -356($sp)
add $8, $29, -624
sw $8, -360($sp)
lw $8, -356($sp)
lw $9, -360($sp)
sw $8, 0($9)
add $29, $29, -624
jal __num_of_sub
sub $29, $29, -624
add $8, $29, -616
sw $8, -364($sp)
lw $9, -364($sp)
move $8, $9
sw $8, -352($sp)
lw $9, -4($sp)
move $8, $9
sw $8, -368($sp)
li $8, 1
sw $8, -372($sp)
lw $8, -372($sp)
lw $9, -368($sp)
sw $8, 0($9)
label16:
lw $9, -4($sp)
lw $8, 0($9)
sw $8, -376($sp)
lw $9, 8($a3)
lw $8, 0($9)
sw $8, -380($sp)
lw $9, -376($sp)
lw $10, -380($sp)
sub $8, $9, $10
sw $8, -380($sp)
lw $8, -380($sp)
bgtz $8, label17
add $8, $29, -688
sw $8, -388($sp)
lw $9, -388($sp)
move $8, $9
sw $8, -384($sp)
lw $9, -4($sp)
lw $8, 0($9)
sw $8, -396($sp)
lw $9, -396($sp)
mul $8, $9, 76
sw $8, -400($sp)
lw $9, 20($a3)
lw $10, -400($sp)
add $8, $9, $10
sw $8, -392($sp)
lw $9, -388($sp)
move $8, $9
sw $8, -404($sp)
lw $9, -392($sp)
lw $8, 0($9)
sw $8, -412($sp)
lw $8, -412($sp)
lw $9, -404($sp)
sw $8, 0($9)
lw $9, -404($sp)
add $8, $9, 4
sw $8, -404($sp)
lw $9, -392($sp)
add $8, $9, 4
sw $8, -408($sp)
lw $9, -408($sp)
lw $8, 0($9)
sw $8, -412($sp)
lw $8, -412($sp)
lw $9, -404($sp)
sw $8, 0($9)
lw $9, -404($sp)
add $8, $9, 4
sw $8, -404($sp)
lw $9, -408($sp)
add $8, $9, 4
sw $8, -408($sp)
lw $9, -408($sp)
lw $8, 0($9)
sw $8, -412($sp)
lw $8, -412($sp)
lw $9, -404($sp)
sw $8, 0($9)
lw $9, -404($sp)
add $8, $9, 4
sw $8, -404($sp)
lw $9, -408($sp)
add $8, $9, 4
sw $8, -408($sp)
lw $9, -408($sp)
lw $8, 0($9)
sw $8, -412($sp)
lw $8, -412($sp)
lw $9, -404($sp)
sw $8, 0($9)
lw $9, -404($sp)
add $8, $9, 4
sw $8, -404($sp)
lw $9, -408($sp)
add $8, $9, 4
sw $8, -408($sp)
lw $9, -408($sp)
lw $8, 0($9)
sw $8, -412($sp)
lw $8, -412($sp)
lw $9, -404($sp)
sw $8, 0($9)
lw $9, -404($sp)
add $8, $9, 4
sw $8, -404($sp)
lw $9, -408($sp)
add $8, $9, 4
sw $8, -408($sp)
lw $9, -408($sp)
lw $8, 0($9)
sw $8, -412($sp)
lw $8, -412($sp)
lw $9, -404($sp)
sw $8, 0($9)
lw $9, -404($sp)
add $8, $9, 4
sw $8, -404($sp)
lw $9, -408($sp)
add $8, $9, 4
sw $8, -408($sp)
lw $9, -408($sp)
lw $8, 0($9)
sw $8, -412($sp)
lw $8, -412($sp)
lw $9, -404($sp)
sw $8, 0($9)
lw $9, -404($sp)
add $8, $9, 4
sw $8, -404($sp)
lw $9, -408($sp)
add $8, $9, 4
sw $8, -408($sp)
lw $9, -408($sp)
lw $8, 0($9)
sw $8, -412($sp)
lw $8, -412($sp)
lw $9, -404($sp)
sw $8, 0($9)
lw $9, -404($sp)
add $8, $9, 4
sw $8, -404($sp)
lw $9, -408($sp)
add $8, $9, 4
sw $8, -408($sp)
lw $9, -408($sp)
lw $8, 0($9)
sw $8, -412($sp)
lw $8, -412($sp)
lw $9, -404($sp)
sw $8, 0($9)
lw $9, -404($sp)
add $8, $9, 4
sw $8, -404($sp)
lw $9, -408($sp)
add $8, $9, 4
sw $8, -408($sp)
lw $9, -408($sp)
lw $8, 0($9)
sw $8, -412($sp)
lw $8, -412($sp)
lw $9, -404($sp)
sw $8, 0($9)
lw $9, -404($sp)
add $8, $9, 4
sw $8, -404($sp)
lw $9, -408($sp)
add $8, $9, 4
sw $8, -408($sp)
lw $9, -408($sp)
lw $8, 0($9)
sw $8, -412($sp)
lw $8, -412($sp)
lw $9, -404($sp)
sw $8, 0($9)
lw $9, -404($sp)
add $8, $9, 4
sw $8, -404($sp)
lw $9, -408($sp)
add $8, $9, 4
sw $8, -408($sp)
lw $9, -408($sp)
lw $8, 0($9)
sw $8, -412($sp)
lw $8, -412($sp)
lw $9, -404($sp)
sw $8, 0($9)
lw $9, -404($sp)
add $8, $9, 4
sw $8, -404($sp)
lw $9, -408($sp)
add $8, $9, 4
sw $8, -408($sp)
lw $9, -408($sp)
lw $8, 0($9)
sw $8, -412($sp)
lw $8, -412($sp)
lw $9, -404($sp)
sw $8, 0($9)
lw $9, -404($sp)
add $8, $9, 4
sw $8, -404($sp)
lw $9, -408($sp)
add $8, $9, 4
sw $8, -408($sp)
lw $9, -408($sp)
lw $8, 0($9)
sw $8, -412($sp)
lw $8, -412($sp)
lw $9, -404($sp)
sw $8, 0($9)
lw $9, -404($sp)
add $8, $9, 4
sw $8, -404($sp)
lw $9, -408($sp)
add $8, $9, 4
sw $8, -408($sp)
lw $9, -408($sp)
lw $8, 0($9)
sw $8, -412($sp)
lw $8, -412($sp)
lw $9, -404($sp)
sw $8, 0($9)
lw $9, -404($sp)
add $8, $9, 4
sw $8, -404($sp)
lw $9, -408($sp)
add $8, $9, 4
sw $8, -408($sp)
lw $9, -408($sp)
lw $8, 0($9)
sw $8, -412($sp)
lw $8, -412($sp)
lw $9, -404($sp)
sw $8, 0($9)
lw $9, -404($sp)
add $8, $9, 4
sw $8, -404($sp)
lw $9, -408($sp)
add $8, $9, 4
sw $8, -408($sp)
lw $9, -408($sp)
lw $8, 0($9)
sw $8, -412($sp)
lw $8, -412($sp)
lw $9, -404($sp)
sw $8, 0($9)
lw $9, -404($sp)
add $8, $9, 4
sw $8, -404($sp)
lw $9, -408($sp)
add $8, $9, 4
sw $8, -408($sp)
lw $9, -408($sp)
lw $8, 0($9)
sw $8, -412($sp)
lw $8, -412($sp)
lw $9, -404($sp)
sw $8, 0($9)
lw $9, -404($sp)
add $8, $9, 4
sw $8, -404($sp)
lw $9, -408($sp)
add $8, $9, 4
sw $8, -408($sp)
lw $9, -408($sp)
lw $8, 0($9)
sw $8, -412($sp)
lw $8, -412($sp)
lw $9, -404($sp)
sw $8, 0($9)
lw $9, -404($sp)
add $8, $9, 4
sw $8, -404($sp)
lw $9, -408($sp)
add $8, $9, 4
sw $8, -408($sp)
add $8, $29, -692
sw $8, -420($sp)
lw $9, -420($sp)
move $8, $9
sw $8, -416($sp)
lw $9, 24($a3)
move $8, $9
sw $8, -424($sp)
li $8, 1
sw $8, -428($sp)
lw $8, -428($sp)
lw $9, -424($sp)
sw $8, 0($9)
lw $9, 32($a3)
move $8, $9
sw $8, -432($sp)
li $8, 0
sw $8, -436($sp)
lw $8, -436($sp)
lw $9, -432($sp)
sw $8, 0($9)
lw $9, -420($sp)
move $8, $9
sw $8, -440($sp)
li $8, 0
sw $8, -444($sp)
lw $8, -444($sp)
lw $9, -440($sp)
sw $8, 0($9)
label19:
lw $9, -416($sp)
lw $8, 0($9)
sw $8, -448($sp)
lw $9, -384($sp)
add $8, $9, 12
sw $8, -452($sp)
lw $9, -452($sp)
lw $8, 0($9)
sw $8, -452($sp)
lw $9, -448($sp)
lw $10, -452($sp)
sub $8, $9, $10
sw $8, -452($sp)
lw $8, -452($sp)
bgez $8, label20
lw $9, -384($sp)
add $8, $9, 16
sw $8, -456($sp)
lw $9, -416($sp)
lw $8, 0($9)
sw $8, -460($sp)
lw $9, -460($sp)
mul $8, $9, 4
sw $8, -464($sp)
lw $9, -456($sp)
lw $10, -464($sp)
add $8, $9, $10
sw $8, -456($sp)
lw $9, -456($sp)
lw $8, 0($9)
sw $8, -456($sp)
lw $9, -384($sp)
add $8, $9, 4
sw $8, -468($sp)
lw $9, -468($sp)
lw $8, 0($9)
sw $8, -468($sp)
lw $9, -456($sp)
lw $10, -468($sp)
sub $8, $9, $10
sw $8, -468($sp)
lw $8, -468($sp)
bnez $8, label22
j label21
label22:
lw $9, -384($sp)
add $8, $9, 16
sw $8, -476($sp)
lw $9, -416($sp)
lw $8, 0($9)
sw $8, -484($sp)
lw $9, -484($sp)
mul $8, $9, 4
sw $8, -488($sp)
lw $9, -476($sp)
lw $10, -488($sp)
add $8, $9, $10
sw $8, -476($sp)
lw $9, -476($sp)
lw $8, 0($9)
sw $8, -476($sp)
lw $9, -476($sp)
mul $8, $9, 76
sw $8, -480($sp)
lw $9, 20($a3)
lw $10, -480($sp)
add $8, $9, $10
sw $8, -472($sp)
lw $9, -472($sp)
add $8, $9, 8
sw $8, -472($sp)
lw $9, -472($sp)
lw $8, 0($9)
sw $8, -472($sp)
lw $9, 8($a3)
lw $8, 0($9)
sw $8, -492($sp)
li $8, 2
sw $8, -496($sp)
lw $9, -492($sp)
lw $10, -496($sp)
div $8, $9, $10
sw $8, -492($sp)
lw $9, -472($sp)
lw $10, -492($sp)
sub $8, $9, $10
sw $8, -492($sp)
lw $8, -492($sp)
blez $8, label23
lw $9, 24($a3)
move $8, $9
sw $8, -500($sp)
li $8, 0
sw $8, -504($sp)
lw $8, -504($sp)
lw $9, -500($sp)
sw $8, 0($9)
j label20
label23:
lw $9, 32($a3)
move $8, $9
sw $8, -508($sp)
lw $9, -384($sp)
add $8, $9, 16
sw $8, -516($sp)
lw $9, -416($sp)
lw $8, 0($9)
sw $8, -524($sp)
lw $9, -524($sp)
mul $8, $9, 4
sw $8, -528($sp)
lw $9, -516($sp)
lw $10, -528($sp)
add $8, $9, $10
sw $8, -516($sp)
lw $9, -516($sp)
lw $8, 0($9)
sw $8, -516($sp)
lw $9, -516($sp)
mul $8, $9, 76
sw $8, -520($sp)
lw $9, 20($a3)
lw $10, -520($sp)
add $8, $9, $10
sw $8, -512($sp)
lw $9, -512($sp)
add $8, $9, 8
sw $8, -512($sp)
lw $9, 32($a3)
lw $8, 0($9)
sw $8, -532($sp)
lw $9, -512($sp)
lw $8, 0($9)
sw $8, -512($sp)
lw $9, -532($sp)
lw $10, -512($sp)
add $8, $9, $10
sw $8, -532($sp)
lw $8, -532($sp)
lw $9, -508($sp)
sw $8, 0($9)
label21:
lw $9, -416($sp)
move $8, $9
sw $8, -540($sp)
lw $9, -416($sp)
lw $8, 0($9)
sw $8, -536($sp)
lw $9, -536($sp)
add $8, $9, 1
sw $8, -536($sp)
lw $8, -536($sp)
lw $9, -540($sp)
sw $8, 0($9)
j label19
label20:
lw $9, 32($a3)
move $8, $9
sw $8, -544($sp)
lw $9, 8($a3)
lw $8, 0($9)
sw $8, -548($sp)
li $8, 1
sw $8, -552($sp)
lw $9, -548($sp)
lw $10, -552($sp)
sub $8, $9, $10
sw $8, -548($sp)
lw $9, 32($a3)
lw $8, 0($9)
sw $8, -556($sp)
lw $9, -548($sp)
lw $10, -556($sp)
sub $8, $9, $10
sw $8, -548($sp)
lw $8, -548($sp)
lw $9, -544($sp)
sw $8, 0($9)
lw $9, 32($a3)
lw $8, 0($9)
sw $8, -560($sp)
lw $9, 8($a3)
lw $8, 0($9)
sw $8, -564($sp)
li $8, 2
sw $8, -568($sp)
lw $9, -564($sp)
lw $10, -568($sp)
div $8, $9, $10
sw $8, -564($sp)
lw $9, -560($sp)
lw $10, -564($sp)
sub $8, $9, $10
sw $8, -564($sp)
lw $8, -564($sp)
blez $8, label24
lw $9, 24($a3)
move $8, $9
sw $8, -572($sp)
li $8, 0
sw $8, -576($sp)
lw $8, -576($sp)
lw $9, -572($sp)
sw $8, 0($9)
label24:
lw $9, 24($a3)
lw $8, 0($9)
sw $8, -580($sp)
lw $8, -580($sp)
beqz $8, label25
add $8, $29, -700
sw $8, -592($sp)
lw $9, -4($sp)
lw $8, 0($9)
sw $8, -588($sp)
lw $8, -588($sp)
lw $9, -592($sp)
sw $8, 0($9)
lw $9, 1048($a3)
move $8, $9
sw $8, -596($sp)
add $8, $29, -704
sw $8, -600($sp)
lw $8, -596($sp)
lw $9, -600($sp)
sw $8, 0($9)
add $29, $29, -704
jal __printf
sub $29, $29, -704
label25:
label18:
lw $9, -4($sp)
move $8, $9
sw $8, -608($sp)
lw $9, -4($sp)
lw $8, 0($9)
sw $8, -604($sp)
lw $9, -604($sp)
add $8, $9, 1
sw $8, -604($sp)
lw $8, -604($sp)
lw $9, -608($sp)
sw $8, 0($9)
j label16
label17:
j __main_end
__main_end:
li $v0, 10
syscall
#global $2 4
#global $3 4
#global $4 4
#global $5 7980
#global $6 4
#global $7 420
#global $8 4
#string $262 #%d\n
#----------------------------
#func #num_of_sub
#addi $9 $0 0
#addi $11 $0 -224
#move $10 $11
#move $12 $11
#li $13 0
#sw $13 $12 0
#label l:0
####move $14 $10
#lw $14 $10 0
####move $15 $5
####move $16 $9
#lw $16 $9 0
#muli $17 $16 76
#add $15 $5 $17
#addi $15 $15 12
#lw $15 $15 0
#sub $15 $14 $15
#bgez $15 l:1
####move $18 $5
####move $19 $9
#lw $19 $9 0
#muli $20 $19 76
#add $18 $5 $20
#addi $18 $18 16
####move $21 $10
#lw $21 $10 0
#muli $22 $21 4
#add $18 $18 $22
#lw $18 $18 0
####move $23 $5
####move $24 $9
#lw $24 $9 0
#muli $25 $24 76
#add $23 $5 $25
#addi $23 $23 4
#lw $23 $23 0
#sub $23 $18 $23
#bnez $23 l:3
#goto l:2
#label l:3
####move $26 $5
####move $27 $5
####move $29 $9
#lw $29 $9 0
#muli $30 $29 76
#add $27 $5 $30
#addi $27 $27 16
####move $31 $10
#lw $31 $10 0
#muli $32 $31 4
#add $27 $27 $32
#lw $27 $27 0
#muli $28 $27 76
#add $26 $5 $28
#addi $26 $26 4
####move $33 $5
####move $34 $9
#lw $34 $9 0
#muli $35 $34 76
#add $33 $5 $35
#addi $33 $33 0
#lw $33 $33 0
#sw $33 $26 0
####move $36 $5
####move $37 $5
####move $39 $9
#lw $39 $9 0
#muli $40 $39 76
#add $37 $5 $40
#addi $37 $37 16
####move $41 $10
#lw $41 $10 0
#muli $42 $41 4
#add $37 $37 $42
#lw $37 $37 0
#muli $38 $37 76
#add $36 $5 $38
#addi $36 $36 8
#li $43 1
#lw $44 $36 0
#sub $44 $44 $43
#sw $44 $36 0
####move $45 $5
####move $46 $9
#lw $46 $9 0
#muli $47 $46 76
#add $45 $5 $47
#addi $45 $45 8
#sw $1 $0 -232
####move $49 $5
####move $50 $9
#lw $50 $9 0
#muli $51 $50 76
#add $49 $5 $51
#addi $49 $49 16
####move $52 $10
#lw $52 $10 0
#muli $53 $52 4
#add $49 $49 $53
#addi $54 $0 -236
#lw $49 $49 0
#sw $49 $54 0
#addi $0 $0 -236
#call #num_of_sub
#subi $0 $0 -236
#lw $1 $0 -232
#addi $55 $0 -228
####move $48 $55
#lw $48 $55 0
#li $56 1
#sub $48 $48 $56
#lw $57 $45 0
#add $57 $57 $48
#sw $57 $45 0
#label l:2
####move $58 $10
#move $59 $10
#lw $58 $10 0
#addi $58 $58 1
#sw $58 $59 0
#goto l:0
#label l:1
####move $60 $5
####move $61 $9
#lw $61 $9 0
#muli $62 $61 76
#add $60 $5 $62
#addi $60 $60 8
#addi $63 $0 8
#lw $60 $60 0
#sw $60 $63 0
#return
#return
#----------------------------
#func #alloc_node
#addi $64 $0 0
#addi $66 $0 -140
####move $65 $66
####move $67 $66
#addi $67 $66 8
#li $68 1
#sw $68 $67 0
####move $69 $66
#addi $69 $66 4
#li $70 0
#sw $70 $69 0
####move $71 $66
#addi $71 $66 0
####move $72 $64
#lw $72 $64 0
#sw $72 $71 0
####move $73 $66
#addi $73 $66 12
#li $74 0
#sw $74 $73 0
####move $75 $66
#addi $76 $0 8
#move $77 $76
####move $78 $66
#lw $79 $66 0
#sw $79 $77 0
#addi $77 $77 4
#addi $78 $66 4
#lw $79 $78 0
#sw $79 $77 0
#addi $77 $77 4
#addi $78 $78 4
#lw $79 $78 0
#sw $79 $77 0
#addi $77 $77 4
#addi $78 $78 4
#lw $79 $78 0
#sw $79 $77 0
#addi $77 $77 4
#addi $78 $78 4
#lw $79 $78 0
#sw $79 $77 0
#addi $77 $77 4
#addi $78 $78 4
#lw $79 $78 0
#sw $79 $77 0
#addi $77 $77 4
#addi $78 $78 4
#lw $79 $78 0
#sw $79 $77 0
#addi $77 $77 4
#addi $78 $78 4
#lw $79 $78 0
#sw $79 $77 0
#addi $77 $77 4
#addi $78 $78 4
#lw $79 $78 0
#sw $79 $77 0
#addi $77 $77 4
#addi $78 $78 4
#lw $79 $78 0
#sw $79 $77 0
#addi $77 $77 4
#addi $78 $78 4
#lw $79 $78 0
#sw $79 $77 0
#addi $77 $77 4
#addi $78 $78 4
#lw $79 $78 0
#sw $79 $77 0
#addi $77 $77 4
#addi $78 $78 4
#lw $79 $78 0
#sw $79 $77 0
#addi $77 $77 4
#addi $78 $78 4
#lw $79 $78 0
#sw $79 $77 0
#addi $77 $77 4
#addi $78 $78 4
#lw $79 $78 0
#sw $79 $77 0
#addi $77 $77 4
#addi $78 $78 4
#lw $79 $78 0
#sw $79 $77 0
#addi $77 $77 4
#addi $78 $78 4
#lw $79 $78 0
#sw $79 $77 0
#addi $77 $77 4
#addi $78 $78 4
#lw $79 $78 0
#sw $79 $77 0
#addi $77 $77 4
#addi $78 $78 4
#lw $79 $78 0
#sw $79 $77 0
#addi $77 $77 4
#addi $78 $78 4
#return
#return
#----------------------------
#func #is_digit
#addi $80 $0 0
####move $81 $80
#lb $81 $80 0
#li $82 48
#sub $82 $81 $82
#li $81 1
#bgez $82 l:4
#li $81 0
#label l:4
#beqz $81 l:5
####move $81 $80
#lb $81 $80 0
#li $83 57
#sub $83 $81 $83
#li $81 1
#blez $83 l:6
#li $81 0
#label l:6
#label l:5
#andi $81 $81 1
#addi $84 $0 8
#sw $81 $84 0
#return
#return
#----------------------------
#func #get_d
#addi $86 $0 -116
#move $85 $86
#sw $1 $0 -124
#addi $0 $0 -124
#call #getchar
#subi $0 $0 -124
#lw $1 $0 -124
#addi $88 $0 -120
####move $87 $88
#lw $87 $88 0
#sw $87 $85 0
#addi $90 $0 -120
#move $89 $90
#li $91 0
#sw $91 $89 0
#label l:7
#sw $1 $0 -128
####move $93 $85
#addi $94 $0 -132
#lb $93 $85 0
#sb $93 $94 0
#addi $0 $0 -132
#call #is_digit
#subi $0 $0 -132
#lw $1 $0 -128
#addi $95 $0 -124
####move $92 $95
#lw $92 $95 0
#lnot $92 $92
#beqz $92 l:8
#move $96 $85
#sw $1 $0 -128
#addi $0 $0 -128
#call #getchar
#subi $0 $0 -128
#lw $1 $0 -128
#addi $98 $0 -124
####move $97 $98
#lw $97 $98 0
#sw $97 $96 0
#goto l:7
#label l:8
#label l:9
#sw $1 $0 -128
####move $100 $85
#addi $101 $0 -132
#lb $100 $85 0
#sb $100 $101 0
#addi $0 $0 -132
#call #is_digit
#subi $0 $0 -132
#lw $1 $0 -128
#addi $102 $0 -124
####move $99 $102
#lw $99 $102 0
#beqz $99 l:10
#move $103 $89
####move $104 $89
#lw $104 $89 0
#li $105 10
#mul $104 $104 $105
####move $106 $85
#lw $106 $85 0
#add $104 $104 $106
#li $107 48
#sub $104 $104 $107
#sw $104 $103 0
#move $108 $85
#sw $1 $0 -128
#addi $0 $0 -128
#call #getchar
#subi $0 $0 -128
#lw $1 $0 -128
#addi $110 $0 -124
####move $109 $110
#lw $109 $110 0
#sw $109 $108 0
#goto l:9
#label l:10
####move $111 $89
#addi $112 $0 4
#lw $111 $89 0
#sw $111 $112 0
#return
#return
#----------------------------
#func #main
#addi $114 $0 -612
#move $113 $114
#move $115 $2
#addi $0 $0 -620
#call #get_d
#subi $0 $0 -620
#addi $117 $0 -616
####move $116 $117
#lw $116 $117 0
#sw $116 $115 0
#move $118 $114
#li $119 0
#sw $119 $118 0
#label l:11
####move $120 $113
#lw $120 $113 0
####move $121 $2
#lw $121 $2 0
#li $122 1
#sub $121 $121 $122
#sub $121 $120 $121
#bgez $121 l:12
#move $123 $3
#addi $0 $0 -620
#call #get_d
#subi $0 $0 -620
#addi $125 $0 -616
####move $124 $125
#lw $124 $125 0
#sw $124 $123 0
#move $126 $4
#addi $0 $0 -620
#call #get_d
#subi $0 $0 -620
#addi $128 $0 -616
####move $127 $128
#lw $127 $128 0
#sw $127 $126 0
####move $129 $7
####move $130 $3
#lw $130 $3 0
#muli $131 $130 4
#add $129 $7 $131
#lw $129 $129 0
#lnot $129 $129
#beqz $129 l:14
####move $132 $5
####move $133 $3
#lw $133 $3 0
#muli $134 $133 76
#add $132 $5 $134
####move $136 $3
#addi $137 $0 -696
#lw $136 $3 0
#sw $136 $137 0
#addi $0 $0 -696
#call #alloc_node
#subi $0 $0 -696
#addi $138 $0 -688
#move $135 $138
#move $139 $132
####move $140 $138
#lw $141 $138 0
#sw $141 $139 0
#addi $139 $139 4
#addi $140 $138 4
#lw $141 $140 0
#sw $141 $139 0
#addi $139 $139 4
#addi $140 $140 4
#lw $141 $140 0
#sw $141 $139 0
#addi $139 $139 4
#addi $140 $140 4
#lw $141 $140 0
#sw $141 $139 0
#addi $139 $139 4
#addi $140 $140 4
#lw $141 $140 0
#sw $141 $139 0
#addi $139 $139 4
#addi $140 $140 4
#lw $141 $140 0
#sw $141 $139 0
#addi $139 $139 4
#addi $140 $140 4
#lw $141 $140 0
#sw $141 $139 0
#addi $139 $139 4
#addi $140 $140 4
#lw $141 $140 0
#sw $141 $139 0
#addi $139 $139 4
#addi $140 $140 4
#lw $141 $140 0
#sw $141 $139 0
#addi $139 $139 4
#addi $140 $140 4
#lw $141 $140 0
#sw $141 $139 0
#addi $139 $139 4
#addi $140 $140 4
#lw $141 $140 0
#sw $141 $139 0
#addi $139 $139 4
#addi $140 $140 4
#lw $141 $140 0
#sw $141 $139 0
#addi $139 $139 4
#addi $140 $140 4
#lw $141 $140 0
#sw $141 $139 0
#addi $139 $139 4
#addi $140 $140 4
#lw $141 $140 0
#sw $141 $139 0
#addi $139 $139 4
#addi $140 $140 4
#lw $141 $140 0
#sw $141 $139 0
#addi $139 $139 4
#addi $140 $140 4
#lw $141 $140 0
#sw $141 $139 0
#addi $139 $139 4
#addi $140 $140 4
#lw $141 $140 0
#sw $141 $139 0
#addi $139 $139 4
#addi $140 $140 4
#lw $141 $140 0
#sw $141 $139 0
#addi $139 $139 4
#addi $140 $140 4
#lw $141 $140 0
#sw $141 $139 0
#addi $139 $139 4
#addi $140 $140 4
#label l:14
####move $142 $7
####move $143 $4
#lw $143 $4 0
#muli $144 $143 4
#add $142 $7 $144
#lw $142 $142 0
#lnot $142 $142
#beqz $142 l:15
####move $145 $5
####move $146 $4
#lw $146 $4 0
#muli $147 $146 76
#add $145 $5 $147
####move $149 $4
#addi $150 $0 -696
#lw $149 $4 0
#sw $149 $150 0
#addi $0 $0 -696
#call #alloc_node
#subi $0 $0 -696
#addi $151 $0 -688
#move $148 $151
#move $152 $145
####move $153 $151
#lw $154 $151 0
#sw $154 $152 0
#addi $152 $152 4
#addi $153 $151 4
#lw $154 $153 0
#sw $154 $152 0
#addi $152 $152 4
#addi $153 $153 4
#lw $154 $153 0
#sw $154 $152 0
#addi $152 $152 4
#addi $153 $153 4
#lw $154 $153 0
#sw $154 $152 0
#addi $152 $152 4
#addi $153 $153 4
#lw $154 $153 0
#sw $154 $152 0
#addi $152 $152 4
#addi $153 $153 4
#lw $154 $153 0
#sw $154 $152 0
#addi $152 $152 4
#addi $153 $153 4
#lw $154 $153 0
#sw $154 $152 0
#addi $152 $152 4
#addi $153 $153 4
#lw $154 $153 0
#sw $154 $152 0
#addi $152 $152 4
#addi $153 $153 4
#lw $154 $153 0
#sw $154 $152 0
#addi $152 $152 4
#addi $153 $153 4
#lw $154 $153 0
#sw $154 $152 0
#addi $152 $152 4
#addi $153 $153 4
#lw $154 $153 0
#sw $154 $152 0
#addi $152 $152 4
#addi $153 $153 4
#lw $154 $153 0
#sw $154 $152 0
#addi $152 $152 4
#addi $153 $153 4
#lw $154 $153 0
#sw $154 $152 0
#addi $152 $152 4
#addi $153 $153 4
#lw $154 $153 0
#sw $154 $152 0
#addi $152 $152 4
#addi $153 $153 4
#lw $154 $153 0
#sw $154 $152 0
#addi $152 $152 4
#addi $153 $153 4
#lw $154 $153 0
#sw $154 $152 0
#addi $152 $152 4
#addi $153 $153 4
#lw $154 $153 0
#sw $154 $152 0
#addi $152 $152 4
#addi $153 $153 4
#lw $154 $153 0
#sw $154 $152 0
#addi $152 $152 4
#addi $153 $153 4
#lw $154 $153 0
#sw $154 $152 0
#addi $152 $152 4
#addi $153 $153 4
#label l:15
####move $155 $5
####move $156 $3
#lw $156 $3 0
#muli $157 $156 76
#add $155 $5 $157
#addi $155 $155 16
####move $158 $5
####move $160 $3
#lw $160 $3 0
#muli $161 $160 76
#add $158 $5 $161
#addi $158 $158 12
#lw $158 $158 0
#muli $159 $158 4
#add $155 $155 $159
####move $162 $4
#lw $162 $4 0
#sw $162 $155 0
####move $163 $5
####move $164 $3
#lw $164 $3 0
#muli $165 $164 76
#add $163 $5 $165
#addi $163 $163 12
#move $166 $163
#lw $163 $163 0
#addi $167 $163 1
#sw $167 $166 0
####move $168 $5
####move $169 $3
#lw $169 $3 0
#muli $170 $169 76
#add $168 $5 $170
#addi $168 $168 8
#move $171 $168
#lw $168 $168 0
#addi $172 $168 1
#sw $172 $171 0
####move $173 $5
####move $174 $4
#lw $174 $4 0
#muli $175 $174 76
#add $173 $5 $175
#addi $173 $173 16
####move $176 $5
####move $178 $4
#lw $178 $4 0
#muli $179 $178 76
#add $176 $5 $179
#addi $176 $176 12
#lw $176 $176 0
#muli $177 $176 4
#add $173 $173 $177
####move $180 $3
#lw $180 $3 0
#sw $180 $173 0
####move $181 $5
####move $182 $4
#lw $182 $4 0
#muli $183 $182 76
#add $181 $5 $183
#addi $181 $181 12
#move $184 $181
#lw $181 $181 0
#addi $185 $181 1
#sw $185 $184 0
####move $186 $5
####move $187 $4
#lw $187 $4 0
#muli $188 $187 76
#add $186 $5 $188
#addi $186 $186 8
#move $189 $186
#lw $186 $186 0
#addi $190 $186 1
#sw $190 $189 0
####move $191 $7
####move $192 $3
#lw $192 $3 0
#muli $193 $192 4
#add $191 $7 $193
####move $194 $7
####move $195 $4
#lw $195 $4 0
#muli $196 $195 4
#add $194 $7 $196
#li $197 1
#sw $197 $194 0
#lw $194 $194 0
#sw $194 $191 0
#label l:13
####move $198 $113
#move $199 $113
#lw $198 $113 0
#addi $198 $198 1
#sw $198 $199 0
#goto l:11
#label l:12
#li $201 1
#addi $202 $0 -624
#sw $201 $202 0
#addi $0 $0 -624
#call #num_of_sub
#subi $0 $0 -624
#addi $203 $0 -616
#move $200 $203
#move $204 $113
#li $205 1
#sw $205 $204 0
#label l:16
####move $206 $113
#lw $206 $113 0
####move $207 $2
#lw $207 $2 0
#sub $207 $206 $207
#bgtz $207 l:17
#addi $209 $0 -688
#move $208 $209
####move $210 $5
####move $211 $113
#lw $211 $113 0
#muli $212 $211 76
#add $210 $5 $212
#move $213 $209
####move $214 $210
#lw $215 $210 0
#sw $215 $213 0
#addi $213 $213 4
#addi $214 $210 4
#lw $215 $214 0
#sw $215 $213 0
#addi $213 $213 4
#addi $214 $214 4
#lw $215 $214 0
#sw $215 $213 0
#addi $213 $213 4
#addi $214 $214 4
#lw $215 $214 0
#sw $215 $213 0
#addi $213 $213 4
#addi $214 $214 4
#lw $215 $214 0
#sw $215 $213 0
#addi $213 $213 4
#addi $214 $214 4
#lw $215 $214 0
#sw $215 $213 0
#addi $213 $213 4
#addi $214 $214 4
#lw $215 $214 0
#sw $215 $213 0
#addi $213 $213 4
#addi $214 $214 4
#lw $215 $214 0
#sw $215 $213 0
#addi $213 $213 4
#addi $214 $214 4
#lw $215 $214 0
#sw $215 $213 0
#addi $213 $213 4
#addi $214 $214 4
#lw $215 $214 0
#sw $215 $213 0
#addi $213 $213 4
#addi $214 $214 4
#lw $215 $214 0
#sw $215 $213 0
#addi $213 $213 4
#addi $214 $214 4
#lw $215 $214 0
#sw $215 $213 0
#addi $213 $213 4
#addi $214 $214 4
#lw $215 $214 0
#sw $215 $213 0
#addi $213 $213 4
#addi $214 $214 4
#lw $215 $214 0
#sw $215 $213 0
#addi $213 $213 4
#addi $214 $214 4
#lw $215 $214 0
#sw $215 $213 0
#addi $213 $213 4
#addi $214 $214 4
#lw $215 $214 0
#sw $215 $213 0
#addi $213 $213 4
#addi $214 $214 4
#lw $215 $214 0
#sw $215 $213 0
#addi $213 $213 4
#addi $214 $214 4
#lw $215 $214 0
#sw $215 $213 0
#addi $213 $213 4
#addi $214 $214 4
#lw $215 $214 0
#sw $215 $213 0
#addi $213 $213 4
#addi $214 $214 4
#addi $217 $0 -692
#move $216 $217
#move $218 $6
#li $219 1
#sw $219 $218 0
#move $220 $8
#li $221 0
#sw $221 $220 0
#move $222 $217
#li $223 0
#sw $223 $222 0
#label l:19
####move $224 $216
#lw $224 $216 0
####move $225 $208
#addi $225 $208 12
#lw $225 $225 0
#sub $225 $224 $225
#bgez $225 l:20
####move $226 $208
#addi $226 $208 16
####move $227 $216
#lw $227 $216 0
#muli $228 $227 4
#add $226 $226 $228
#lw $226 $226 0
####move $229 $208
#addi $229 $208 4
#lw $229 $229 0
#sub $229 $226 $229
#bnez $229 l:22
#goto l:21
#label l:22
####move $230 $5
####move $231 $208
#addi $231 $208 16
####move $233 $216
#lw $233 $216 0
#muli $234 $233 4
#add $231 $231 $234
#lw $231 $231 0
#muli $232 $231 76
#add $230 $5 $232
#addi $230 $230 8
#lw $230 $230 0
####move $235 $2
#lw $235 $2 0
#li $236 2
#div $235 $235 $236
#sub $235 $230 $235
#blez $235 l:23
#move $237 $6
#li $238 0
#sw $238 $237 0
#goto l:20
#label l:23
#move $239 $8
####move $240 $5
####move $241 $208
#addi $241 $208 16
####move $243 $216
#lw $243 $216 0
#muli $244 $243 4
#add $241 $241 $244
#lw $241 $241 0
#muli $242 $241 76
#add $240 $5 $242
#addi $240 $240 8
#lw $245 $8 0
#lw $240 $240 0
#add $245 $245 $240
#sw $245 $239 0
#label l:21
####move $246 $216
#move $247 $216
#lw $246 $216 0
#addi $246 $246 1
#sw $246 $247 0
#goto l:19
#label l:20
#move $248 $8
####move $249 $2
#lw $249 $2 0
#li $250 1
#sub $249 $249 $250
####move $251 $8
#lw $251 $8 0
#sub $249 $249 $251
#sw $249 $248 0
####move $252 $8
#lw $252 $8 0
####move $253 $2
#lw $253 $2 0
#li $254 2
#div $253 $253 $254
#sub $253 $252 $253
#blez $253 l:24
#move $255 $6
#li $256 0
#sw $256 $255 0
#label l:24
####move $257 $6
#lw $257 $6 0
#beqz $257 l:25
####move $259 $113
#addi $260 $0 -700
#lw $259 $113 0
#sw $259 $260 0
#move $261 $262
#addi $263 $0 -704
#sw $261 $263 0
#addi $0 $0 -704
#call #printf
#subi $0 $0 -704
#label l:25
#label l:18
####move $264 $113
#move $265 $113
#lw $264 $113 0
#addi $264 $264 1
#sw $264 $265 0
#goto l:16
#label l:17
#return
