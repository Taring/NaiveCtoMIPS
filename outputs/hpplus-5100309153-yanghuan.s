.data
temp: .space 668
var0: .space 4
var1: .space 60
var2: .space 60
var3: .space 120
var4: .space 4
var5: .space 4
var6: .asciiz "%d"
.align 2
var7: .asciiz "\n"
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

__plus:
add $8, $29, 0
sw $8, -4($sp)
add $8, $29, -204
sw $8, -12($sp)
lw $9, -12($sp)
move $8, $9
sw $8, -8($sp)
add $8, $29, -208
sw $8, -20($sp)
lw $9, -20($sp)
move $8, $9
sw $8, -16($sp)
lw $9, -12($sp)
move $8, $9
sw $8, -24($sp)
li $8, 0
sw $8, -28($sp)
lw $8, -28($sp)
lw $9, -24($sp)
sw $8, 0($9)
lw $9, -20($sp)
move $8, $9
sw $8, -32($sp)
li $8, 0
sw $8, -36($sp)
lw $8, -36($sp)
lw $9, -32($sp)
sw $8, 0($9)
label0:
lw $9, -16($sp)
lw $8, 0($9)
sw $8, -40($sp)
lw $9, -4($sp)
lw $8, 0($9)
sw $8, -44($sp)
lw $9, -40($sp)
lw $10, -44($sp)
sub $8, $9, $10
sw $8, -44($sp)
lw $8, -44($sp)
bgez $8, label1
lw $9, -16($sp)
lw $8, 0($9)
sw $8, -52($sp)
lw $9, -52($sp)
mul $8, $9, 4
sw $8, -56($sp)
lw $9, 24($a3)
lw $10, -56($sp)
add $8, $9, $10
sw $8, -48($sp)
lw $9, -16($sp)
lw $8, 0($9)
sw $8, -64($sp)
lw $9, -64($sp)
mul $8, $9, 4
sw $8, -68($sp)
lw $9, 16($a3)
lw $10, -68($sp)
add $8, $9, $10
sw $8, -60($sp)
lw $9, -60($sp)
lw $8, 0($9)
sw $8, -60($sp)
lw $9, -16($sp)
lw $8, 0($9)
sw $8, -76($sp)
lw $9, -76($sp)
mul $8, $9, 4
sw $8, -80($sp)
lw $9, 20($a3)
lw $10, -80($sp)
add $8, $9, $10
sw $8, -72($sp)
lw $9, -72($sp)
lw $8, 0($9)
sw $8, -72($sp)
lw $9, -60($sp)
lw $10, -72($sp)
add $8, $9, $10
sw $8, -60($sp)
lw $9, -8($sp)
lw $8, 0($9)
sw $8, -84($sp)
lw $9, -60($sp)
lw $10, -84($sp)
add $8, $9, $10
sw $8, -60($sp)
lw $8, -60($sp)
lw $9, -48($sp)
sw $8, 0($9)
lw $9, -8($sp)
move $8, $9
sw $8, -88($sp)
li $8, 0
sw $8, -92($sp)
lw $8, -92($sp)
lw $9, -88($sp)
sw $8, 0($9)
lw $9, -16($sp)
lw $8, 0($9)
sw $8, -100($sp)
lw $9, -100($sp)
mul $8, $9, 4
sw $8, -104($sp)
lw $9, 24($a3)
lw $10, -104($sp)
add $8, $9, $10
sw $8, -96($sp)
lw $9, -96($sp)
lw $8, 0($9)
sw $8, -96($sp)
li $8, 9
sw $8, -108($sp)
lw $9, -96($sp)
lw $10, -108($sp)
sub $8, $9, $10
sw $8, -108($sp)
lw $8, -108($sp)
blez $8, label2
lw $9, -16($sp)
lw $8, 0($9)
sw $8, -116($sp)
lw $9, -116($sp)
mul $8, $9, 4
sw $8, -120($sp)
lw $9, 24($a3)
lw $10, -120($sp)
add $8, $9, $10
sw $8, -112($sp)
lw $9, -16($sp)
lw $8, 0($9)
sw $8, -128($sp)
lw $9, -128($sp)
mul $8, $9, 4
sw $8, -132($sp)
lw $9, 24($a3)
lw $10, -132($sp)
add $8, $9, $10
sw $8, -124($sp)
lw $9, -124($sp)
lw $8, 0($9)
sw $8, -124($sp)
li $8, 10
sw $8, -136($sp)
lw $9, -124($sp)
lw $10, -136($sp)
sub $8, $9, $10
sw $8, -124($sp)
lw $8, -124($sp)
lw $9, -112($sp)
sw $8, 0($9)
lw $9, -8($sp)
move $8, $9
sw $8, -140($sp)
li $8, 1
sw $8, -144($sp)
lw $8, -144($sp)
lw $9, -140($sp)
sw $8, 0($9)
label2:
lw $9, -16($sp)
move $8, $9
sw $8, -152($sp)
lw $9, -16($sp)
lw $8, 0($9)
sw $8, -148($sp)
lw $9, -148($sp)
add $8, $9, 1
sw $8, -156($sp)
lw $8, -156($sp)
lw $9, -152($sp)
sw $8, 0($9)
j label0
label1:
lw $9, -8($sp)
lw $8, 0($9)
sw $8, -160($sp)
li $8, 0
sw $8, -164($sp)
lw $9, -160($sp)
lw $10, -164($sp)
sub $8, $9, $10
sw $8, -164($sp)
lw $8, -164($sp)
blez $8, label3
lw $9, -16($sp)
lw $8, 0($9)
sw $8, -172($sp)
lw $9, -172($sp)
mul $8, $9, 4
sw $8, -176($sp)
lw $9, 24($a3)
lw $10, -176($sp)
add $8, $9, $10
sw $8, -168($sp)
li $8, 1
sw $8, -180($sp)
lw $8, -180($sp)
lw $9, -168($sp)
sw $8, 0($9)
add $8, $29, 8
sw $8, -188($sp)
lw $9, -16($sp)
lw $8, 0($9)
sw $8, -184($sp)
lw $8, -184($sp)
lw $9, -188($sp)
sw $8, 0($9)
jr $ra
j label4
label3:
lw $9, -16($sp)
lw $8, 0($9)
sw $8, -192($sp)
li $8, 1
sw $8, -196($sp)
lw $9, -192($sp)
lw $10, -196($sp)
sub $8, $9, $10
sw $8, -192($sp)
add $8, $29, 8
sw $8, -200($sp)
lw $8, -192($sp)
lw $9, -200($sp)
sw $8, 0($9)
jr $ra
label4:
jr $ra
__printIntA:
add $8, $29, 0
sw $8, -4($sp)
label5:
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
bltz $8, label6
sw $31, -68($29)
lw $9, -4($sp)
lw $8, 0($9)
sw $8, -24($sp)
lw $9, -24($sp)
mul $8, $9, 4
sw $8, -28($sp)
lw $9, 16($a3)
lw $10, -28($sp)
add $8, $9, $10
sw $8, -20($sp)
add $8, $29, -72
sw $8, -32($sp)
lw $9, -20($sp)
lw $8, 0($9)
sw $8, -20($sp)
lw $8, -20($sp)
lw $9, -32($sp)
sw $8, 0($9)
lw $9, 272($a3)
move $8, $9
sw $8, -36($sp)
add $8, $29, -76
sw $8, -40($sp)
lw $8, -36($sp)
lw $9, -40($sp)
sw $8, 0($9)
add $29, $29, -76
jal __printf
sub $29, $29, -76
lw $31, -68($29)
lw $9, -4($sp)
move $8, $9
sw $8, -48($sp)
lw $9, -4($sp)
lw $8, 0($9)
sw $8, -44($sp)
lw $9, -44($sp)
sub $8, $9, 1
sw $8, -52($sp)
lw $8, -52($sp)
lw $9, -48($sp)
sw $8, 0($9)
j label5
label6:
sw $31, -68($29)
lw $9, 300($a3)
move $8, $9
sw $8, -60($sp)
add $8, $29, -72
sw $8, -64($sp)
lw $8, -60($sp)
lw $9, -64($sp)
sw $8, 0($9)
add $29, $29, -72
jal __printf_single
sub $29, $29, -72
lw $31, -68($29)
jr $ra
__printIntB:
add $8, $29, 0
sw $8, -4($sp)
label7:
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
bltz $8, label8
sw $31, -68($29)
lw $9, -4($sp)
lw $8, 0($9)
sw $8, -24($sp)
lw $9, -24($sp)
mul $8, $9, 4
sw $8, -28($sp)
lw $9, 20($a3)
lw $10, -28($sp)
add $8, $9, $10
sw $8, -20($sp)
add $8, $29, -72
sw $8, -32($sp)
lw $9, -20($sp)
lw $8, 0($9)
sw $8, -20($sp)
lw $8, -20($sp)
lw $9, -32($sp)
sw $8, 0($9)
lw $9, 272($a3)
move $8, $9
sw $8, -36($sp)
add $8, $29, -76
sw $8, -40($sp)
lw $8, -36($sp)
lw $9, -40($sp)
sw $8, 0($9)
add $29, $29, -76
jal __printf
sub $29, $29, -76
lw $31, -68($29)
lw $9, -4($sp)
move $8, $9
sw $8, -48($sp)
lw $9, -4($sp)
lw $8, 0($9)
sw $8, -44($sp)
lw $9, -44($sp)
sub $8, $9, 1
sw $8, -52($sp)
lw $8, -52($sp)
lw $9, -48($sp)
sw $8, 0($9)
j label7
label8:
sw $31, -68($29)
lw $9, 300($a3)
move $8, $9
sw $8, -60($sp)
add $8, $29, -72
sw $8, -64($sp)
lw $8, -60($sp)
lw $9, -64($sp)
sw $8, 0($9)
add $29, $29, -72
jal __printf_single
sub $29, $29, -72
lw $31, -68($29)
jr $ra
__printBigInt:
add $8, $29, 0
sw $8, -4($sp)
label9:
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
bltz $8, label10
sw $31, -68($29)
lw $9, -4($sp)
lw $8, 0($9)
sw $8, -24($sp)
lw $9, -24($sp)
mul $8, $9, 4
sw $8, -28($sp)
lw $9, 24($a3)
lw $10, -28($sp)
add $8, $9, $10
sw $8, -20($sp)
add $8, $29, -72
sw $8, -32($sp)
lw $9, -20($sp)
lw $8, 0($9)
sw $8, -20($sp)
lw $8, -20($sp)
lw $9, -32($sp)
sw $8, 0($9)
lw $9, 272($a3)
move $8, $9
sw $8, -36($sp)
add $8, $29, -76
sw $8, -40($sp)
lw $8, -36($sp)
lw $9, -40($sp)
sw $8, 0($9)
add $29, $29, -76
jal __printf
sub $29, $29, -76
lw $31, -68($29)
lw $9, -4($sp)
move $8, $9
sw $8, -48($sp)
lw $9, -4($sp)
lw $8, 0($9)
sw $8, -44($sp)
lw $9, -44($sp)
sub $8, $9, 1
sw $8, -52($sp)
lw $8, -52($sp)
lw $9, -48($sp)
sw $8, 0($9)
j label9
label10:
sw $31, -68($29)
lw $9, 300($a3)
move $8, $9
sw $8, -60($sp)
add $8, $29, -72
sw $8, -64($sp)
lw $8, -60($sp)
lw $9, -64($sp)
sw $8, 0($9)
add $29, $29, -72
jal __printf_single
sub $29, $29, -72
lw $31, -68($29)
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
sw $t0, 24($a3)
la $t0, var4
sw $t0, 28($a3)
la $t0, var5
sw $t0, 32($a3)
la $t0, var6
sw $t0, 272($a3)
la $t0, var7
sw $t0, 300($a3)
li $8, 15
sw $8, 12($a3)
lw $8, 12($a3)
lw $9, 8($a3)
sw $8, 0($9)
lw $9, 32($a3)
move $8, $9
sw $8, -4($sp)
li $8, 0
sw $8, -8($sp)
lw $8, -8($sp)
lw $9, -4($sp)
sw $8, 0($9)
label11:
lw $9, 32($a3)
lw $8, 0($9)
sw $8, -12($sp)
lw $9, 8($a3)
lw $8, 0($9)
sw $8, -16($sp)
lw $9, -12($sp)
lw $10, -16($sp)
sub $8, $9, $10
sw $8, -16($sp)
lw $8, -16($sp)
bgez $8, label12
lw $9, 32($a3)
lw $8, 0($9)
sw $8, -20($sp)
li $8, 9
sw $8, -24($sp)
lw $9, -20($sp)
lw $10, -24($sp)
sub $8, $9, $10
sw $8, -24($sp)
lw $8, -24($sp)
bgez $8, label14
lw $9, 32($a3)
lw $8, 0($9)
sw $8, -32($sp)
lw $9, -32($sp)
mul $8, $9, 4
sw $8, -36($sp)
lw $9, 16($a3)
lw $10, -36($sp)
add $8, $9, $10
sw $8, -28($sp)
lw $9, 32($a3)
lw $8, 0($9)
sw $8, -40($sp)
li $8, 1
sw $8, -44($sp)
lw $9, -40($sp)
lw $10, -44($sp)
add $8, $9, $10
sw $8, -40($sp)
lw $8, -40($sp)
lw $9, -28($sp)
sw $8, 0($9)
j label15
label14:
lw $9, 32($a3)
lw $8, 0($9)
sw $8, -52($sp)
lw $9, -52($sp)
mul $8, $9, 4
sw $8, -56($sp)
lw $9, 16($a3)
lw $10, -56($sp)
add $8, $9, $10
sw $8, -48($sp)
lw $9, 32($a3)
lw $8, 0($9)
sw $8, -60($sp)
li $8, 9
sw $8, -64($sp)
lw $9, -60($sp)
lw $10, -64($sp)
sub $8, $9, $10
sw $8, -60($sp)
lw $8, -60($sp)
lw $9, -48($sp)
sw $8, 0($9)
label15:
label13:
lw $9, 32($a3)
move $8, $9
sw $8, -72($sp)
lw $9, 32($a3)
lw $8, 0($9)
sw $8, -68($sp)
lw $9, -68($sp)
add $8, $9, 1
sw $8, -76($sp)
lw $8, -76($sp)
lw $9, -72($sp)
sw $8, 0($9)
j label11
label12:
lw $9, 8($a3)
lw $8, 0($9)
sw $8, -84($sp)
li $8, 1
sw $8, -88($sp)
lw $9, -84($sp)
lw $10, -88($sp)
sub $8, $9, $10
sw $8, -84($sp)
add $8, $29, -244
sw $8, -92($sp)
lw $8, -84($sp)
lw $9, -92($sp)
sw $8, 0($9)
add $29, $29, -244
jal __printIntA
sub $29, $29, -244
add $8, $29, -236
sw $8, -96($sp)
lw $9, -96($sp)
move $8, $9
sw $8, -80($sp)
lw $9, 32($a3)
move $8, $9
sw $8, -100($sp)
li $8, 0
sw $8, -104($sp)
lw $8, -104($sp)
lw $9, -100($sp)
sw $8, 0($9)
label16:
lw $9, 32($a3)
lw $8, 0($9)
sw $8, -108($sp)
lw $9, 8($a3)
lw $8, 0($9)
sw $8, -112($sp)
lw $9, -108($sp)
lw $10, -112($sp)
sub $8, $9, $10
sw $8, -112($sp)
lw $8, -112($sp)
bgez $8, label17
lw $9, 32($a3)
lw $8, 0($9)
sw $8, -116($sp)
lw $9, 8($a3)
lw $8, 0($9)
sw $8, -120($sp)
li $8, 2
sw $8, -124($sp)
lw $9, -120($sp)
lw $10, -124($sp)
div $8, $9, $10
sw $8, -120($sp)
lw $9, -116($sp)
lw $10, -120($sp)
sub $8, $9, $10
sw $8, -120($sp)
lw $8, -120($sp)
bgez $8, label19
lw $9, 32($a3)
lw $8, 0($9)
sw $8, -132($sp)
lw $9, -132($sp)
mul $8, $9, 4
sw $8, -136($sp)
lw $9, 20($a3)
lw $10, -136($sp)
add $8, $9, $10
sw $8, -128($sp)
li $8, 7
sw $8, -140($sp)
lw $8, -140($sp)
lw $9, -128($sp)
sw $8, 0($9)
j label20
label19:
lw $9, 32($a3)
lw $8, 0($9)
sw $8, -148($sp)
lw $9, -148($sp)
mul $8, $9, 4
sw $8, -152($sp)
lw $9, 20($a3)
lw $10, -152($sp)
add $8, $9, $10
sw $8, -144($sp)
li $8, 3
sw $8, -156($sp)
lw $8, -156($sp)
lw $9, -144($sp)
sw $8, 0($9)
label20:
label18:
lw $9, 32($a3)
move $8, $9
sw $8, -164($sp)
lw $9, 32($a3)
lw $8, 0($9)
sw $8, -160($sp)
lw $9, -160($sp)
add $8, $9, 1
sw $8, -168($sp)
lw $8, -168($sp)
lw $9, -164($sp)
sw $8, 0($9)
j label16
label17:
lw $9, 8($a3)
lw $8, 0($9)
sw $8, -176($sp)
li $8, 1
sw $8, -180($sp)
lw $9, -176($sp)
lw $10, -180($sp)
sub $8, $9, $10
sw $8, -176($sp)
add $8, $29, -244
sw $8, -184($sp)
lw $8, -176($sp)
lw $9, -184($sp)
sw $8, 0($9)
add $29, $29, -244
jal __printIntB
sub $29, $29, -244
add $8, $29, -236
sw $8, -188($sp)
lw $9, 28($a3)
move $8, $9
sw $8, -192($sp)
add $8, $29, -244
sw $8, -204($sp)
lw $9, 8($a3)
lw $8, 0($9)
sw $8, -200($sp)
lw $8, -200($sp)
lw $9, -204($sp)
sw $8, 0($9)
add $29, $29, -244
jal __plus
sub $29, $29, -244
add $8, $29, -236
sw $8, -208($sp)
lw $9, -208($sp)
lw $8, 0($9)
sw $8, -196($sp)
lw $8, -196($sp)
lw $9, -192($sp)
sw $8, 0($9)
add $8, $29, -244
sw $8, -220($sp)
lw $9, 28($a3)
lw $8, 0($9)
sw $8, -216($sp)
lw $8, -216($sp)
lw $9, -220($sp)
sw $8, 0($9)
add $29, $29, -244
jal __printBigInt
sub $29, $29, -244
add $8, $29, -236
sw $8, -224($sp)
li $8, 0
sw $8, -228($sp)
add $8, $29, 4
sw $8, -232($sp)
lw $8, -228($sp)
lw $9, -232($sp)
sw $8, 0($9)
j __main_end
j __main_end
__main_end:
li $v0, 10
syscall
#global $2 4
#global $4 60
#global $5 60
#global $6 120
#global $7 4
#global $8 4
#string $68 #%d
#string $75 #\n
#li $3 15
#sw $3 $2 0
#----------------------------
#func #plus
#addi $9 $0 0
#addi $11 $0 -204
#move $10 $11
#addi $13 $0 -208
#move $12 $13
#move $14 $11
#li $15 0
#sw $15 $14 0
#move $16 $13
#li $17 0
#sw $17 $16 0
#label l:0
####move $18 $12
#lw $18 $12 0
####move $19 $9
#lw $19 $9 0
#sub $19 $18 $19
#bgez $19 l:1
####move $20 $6
####move $21 $12
#lw $21 $12 0
#muli $22 $21 4
#add $20 $6 $22
####move $23 $4
####move $24 $12
#lw $24 $12 0
#muli $25 $24 4
#add $23 $4 $25
#lw $23 $23 0
####move $26 $5
####move $27 $12
#lw $27 $12 0
#muli $28 $27 4
#add $26 $5 $28
#lw $26 $26 0
#add $23 $23 $26
####move $29 $10
#lw $29 $10 0
#add $23 $23 $29
#sw $23 $20 0
#move $30 $10
#li $31 0
#sw $31 $30 0
####move $32 $6
####move $33 $12
#lw $33 $12 0
#muli $34 $33 4
#add $32 $6 $34
#lw $32 $32 0
#li $35 9
#sub $35 $32 $35
#blez $35 l:2
####move $36 $6
####move $37 $12
#lw $37 $12 0
#muli $38 $37 4
#add $36 $6 $38
####move $39 $6
####move $40 $12
#lw $40 $12 0
#muli $41 $40 4
#add $39 $6 $41
#lw $39 $39 0
#li $42 10
#sub $39 $39 $42
#sw $39 $36 0
#move $43 $10
#li $44 1
#sw $44 $43 0
#label l:2
####move $45 $12
#move $46 $12
#lw $45 $12 0
#addi $47 $45 1
#sw $47 $46 0
#goto l:0
#label l:1
####move $48 $10
#lw $48 $10 0
#li $49 0
#sub $49 $48 $49
#blez $49 l:3
####move $50 $6
####move $51 $12
#lw $51 $12 0
#muli $52 $51 4
#add $50 $6 $52
#li $53 1
#sw $53 $50 0
####move $54 $12
#addi $55 $0 8
#lw $54 $12 0
#sw $54 $55 0
#return
#goto l:4
#label l:3
####move $56 $12
#lw $56 $12 0
#li $57 1
#sub $56 $56 $57
#addi $58 $0 8
#sw $56 $58 0
#return
#label l:4
#return
#----------------------------
#func #printIntA
#addi $59 $0 0
#label l:5
####move $60 $59
#lw $60 $59 0
#li $61 0
#sub $61 $60 $61
#bltz $61 l:6
#sw $1 $0 -68
####move $63 $4
####move $64 $59
#lw $64 $59 0
#muli $65 $64 4
#add $63 $4 $65
#addi $66 $0 -72
#lw $63 $63 0
#sw $63 $66 0
#move $67 $68
#addi $69 $0 -76
#sw $67 $69 0
#addi $0 $0 -76
#call #printf
#subi $0 $0 -76
#lw $1 $0 -68
####move $70 $59
#move $71 $59
#lw $70 $59 0
#subi $72 $70 1
#sw $72 $71 0
#goto l:5
#label l:6
#sw $1 $0 -68
#move $74 $75
#addi $76 $0 -72
#sw $74 $76 0
#addi $0 $0 -72
#call #printf_single
#subi $0 $0 -72
#lw $1 $0 -68
#return
#----------------------------
#func #printIntB
#addi $77 $0 0
#label l:7
####move $78 $77
#lw $78 $77 0
#li $79 0
#sub $79 $78 $79
#bltz $79 l:8
#sw $1 $0 -68
####move $81 $5
####move $82 $77
#lw $82 $77 0
#muli $83 $82 4
#add $81 $5 $83
#addi $84 $0 -72
#lw $81 $81 0
#sw $81 $84 0
#move $85 $68
#addi $86 $0 -76
#sw $85 $86 0
#addi $0 $0 -76
#call #printf
#subi $0 $0 -76
#lw $1 $0 -68
####move $87 $77
#move $88 $77
#lw $87 $77 0
#subi $89 $87 1
#sw $89 $88 0
#goto l:7
#label l:8
#sw $1 $0 -68
#move $91 $75
#addi $92 $0 -72
#sw $91 $92 0
#addi $0 $0 -72
#call #printf_single
#subi $0 $0 -72
#lw $1 $0 -68
#return
#----------------------------
#func #printBigInt
#addi $93 $0 0
#label l:9
####move $94 $93
#lw $94 $93 0
#li $95 0
#sub $95 $94 $95
#bltz $95 l:10
#sw $1 $0 -68
####move $97 $6
####move $98 $93
#lw $98 $93 0
#muli $99 $98 4
#add $97 $6 $99
#addi $100 $0 -72
#lw $97 $97 0
#sw $97 $100 0
#move $101 $68
#addi $102 $0 -76
#sw $101 $102 0
#addi $0 $0 -76
#call #printf
#subi $0 $0 -76
#lw $1 $0 -68
####move $103 $93
#move $104 $93
#lw $103 $93 0
#subi $105 $103 1
#sw $105 $104 0
#goto l:9
#label l:10
#sw $1 $0 -68
#move $107 $75
#addi $108 $0 -72
#sw $107 $108 0
#addi $0 $0 -72
#call #printf_single
#subi $0 $0 -72
#lw $1 $0 -68
#return
#----------------------------
#func #main
#move $109 $8
#li $110 0
#sw $110 $109 0
#label l:11
####move $111 $8
#lw $111 $8 0
####move $112 $2
#lw $112 $2 0
#sub $112 $111 $112
#bgez $112 l:12
####move $113 $8
#lw $113 $8 0
#li $114 9
#sub $114 $113 $114
#bgez $114 l:14
####move $115 $4
####move $116 $8
#lw $116 $8 0
#muli $117 $116 4
#add $115 $4 $117
####move $118 $8
#lw $118 $8 0
#li $119 1
#add $118 $118 $119
#sw $118 $115 0
#goto l:15
#label l:14
####move $120 $4
####move $121 $8
#lw $121 $8 0
#muli $122 $121 4
#add $120 $4 $122
####move $123 $8
#lw $123 $8 0
#li $124 9
#sub $123 $123 $124
#sw $123 $120 0
#label l:15
#label l:13
####move $125 $8
#move $126 $8
#lw $125 $8 0
#addi $127 $125 1
#sw $127 $126 0
#goto l:11
#label l:12
####move $129 $2
#lw $129 $2 0
#li $130 1
#sub $129 $129 $130
#addi $131 $0 -244
#sw $129 $131 0
#addi $0 $0 -244
#call #printIntA
#subi $0 $0 -244
#addi $132 $0 -236
#move $128 $132
#move $133 $8
#li $134 0
#sw $134 $133 0
#label l:16
####move $135 $8
#lw $135 $8 0
####move $136 $2
#lw $136 $2 0
#sub $136 $135 $136
#bgez $136 l:17
####move $137 $8
#lw $137 $8 0
####move $138 $2
#lw $138 $2 0
#li $139 2
#div $138 $138 $139
#sub $138 $137 $138
#bgez $138 l:19
####move $140 $5
####move $141 $8
#lw $141 $8 0
#muli $142 $141 4
#add $140 $5 $142
#li $143 7
#sw $143 $140 0
#goto l:20
#label l:19
####move $144 $5
####move $145 $8
#lw $145 $8 0
#muli $146 $145 4
#add $144 $5 $146
#li $147 3
#sw $147 $144 0
#label l:20
#label l:18
####move $148 $8
#move $149 $8
#lw $148 $8 0
#addi $150 $148 1
#sw $150 $149 0
#goto l:16
#label l:17
####move $152 $2
#lw $152 $2 0
#li $153 1
#sub $152 $152 $153
#addi $154 $0 -244
#sw $152 $154 0
#addi $0 $0 -244
#call #printIntB
#subi $0 $0 -244
#addi $155 $0 -236
####move $151 $155
#move $156 $7
####move $158 $2
#addi $159 $0 -244
#lw $158 $2 0
#sw $158 $159 0
#addi $0 $0 -244
#call #plus
#subi $0 $0 -244
#addi $160 $0 -236
####move $157 $160
#lw $157 $160 0
#sw $157 $156 0
####move $162 $7
#addi $163 $0 -244
#lw $162 $7 0
#sw $162 $163 0
#addi $0 $0 -244
#call #printBigInt
#subi $0 $0 -244
#addi $164 $0 -236
####move $161 $164
#li $165 0
#addi $166 $0 4
#sw $165 $166 0
#return
#return
