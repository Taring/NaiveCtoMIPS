.data
temp: .space 952
var0: .space 72
var1: .space 4
var2: .space 26664
var3: .asciiz "%d\n"
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

__transform:
add $8, $29, 0
sw $8, -4($sp)
add $8, $29, 4
sw $8, -8($sp)
add $8, $29, -168
sw $8, -16($sp)
lw $9, -16($sp)
move $8, $9
sw $8, -12($sp)
add $8, $29, -172
sw $8, -24($sp)
lw $9, -24($sp)
move $8, $9
sw $8, -20($sp)
add $8, $29, -176
sw $8, -32($sp)
lw $9, -32($sp)
move $8, $9
sw $8, -28($sp)
lw $9, -24($sp)
move $8, $9
sw $8, -36($sp)
li $8, 0
sw $8, -40($sp)
lw $8, -40($sp)
lw $9, -36($sp)
sw $8, 0($9)
label0:
lw $9, -20($sp)
lw $8, 0($9)
sw $8, -44($sp)
li $8, 6
sw $8, -48($sp)
lw $9, -44($sp)
lw $10, -48($sp)
sub $8, $9, $10
sw $8, -48($sp)
lw $8, -48($sp)
bgez $8, label1
lw $9, -20($sp)
lw $8, 0($9)
sw $8, -56($sp)
lw $9, -56($sp)
mul $8, $9, 4
sw $8, -60($sp)
lw $9, -12($sp)
lw $10, -60($sp)
add $8, $9, $10
sw $8, -52($sp)
lw $9, -4($sp)
lw $8, 0($9)
sw $8, -64($sp)
lw $9, -20($sp)
lw $8, 0($9)
sw $8, -68($sp)
lw $9, -68($sp)
mul $8, $9, 4
sw $8, -72($sp)
lw $9, -64($sp)
lw $10, -72($sp)
add $8, $9, $10
sw $8, -64($sp)
lw $9, -64($sp)
lw $8, 0($9)
sw $8, -64($sp)
lw $8, -64($sp)
lw $9, -52($sp)
sw $8, 0($9)
label2:
lw $9, -20($sp)
move $8, $9
sw $8, -80($sp)
lw $9, -20($sp)
lw $8, 0($9)
sw $8, -76($sp)
lw $9, -76($sp)
add $8, $9, 1
sw $8, -76($sp)
lw $8, -76($sp)
lw $9, -80($sp)
sw $8, 0($9)
j label0
label1:
lw $9, -28($sp)
move $8, $9
sw $8, -84($sp)
li $8, 0
sw $8, -88($sp)
lw $8, -88($sp)
lw $9, -84($sp)
sw $8, 0($9)
label3:
lw $9, -28($sp)
lw $8, 0($9)
sw $8, -92($sp)
li $8, 6
sw $8, -96($sp)
lw $9, -92($sp)
lw $10, -96($sp)
sub $8, $9, $10
sw $8, -96($sp)
lw $8, -96($sp)
bgez $8, label4
lw $9, -4($sp)
lw $8, 0($9)
sw $8, -100($sp)
lw $9, -8($sp)
lw $8, 0($9)
sw $8, -112($sp)
lw $9, -112($sp)
mul $8, $9, 24
sw $8, -116($sp)
lw $9, 8($a3)
lw $10, -116($sp)
add $8, $9, $10
sw $8, -104($sp)
lw $9, -28($sp)
lw $8, 0($9)
sw $8, -120($sp)
lw $9, -120($sp)
mul $8, $9, 4
sw $8, -124($sp)
lw $9, -104($sp)
lw $10, -124($sp)
add $8, $9, $10
sw $8, -104($sp)
lw $9, -104($sp)
lw $8, 0($9)
sw $8, -104($sp)
lw $9, -104($sp)
mul $8, $9, 4
sw $8, -108($sp)
lw $9, -100($sp)
lw $10, -108($sp)
add $8, $9, $10
sw $8, -100($sp)
lw $9, -28($sp)
lw $8, 0($9)
sw $8, -132($sp)
lw $9, -132($sp)
mul $8, $9, 4
sw $8, -136($sp)
lw $9, -12($sp)
lw $10, -136($sp)
add $8, $9, $10
sw $8, -128($sp)
lw $9, -128($sp)
lw $8, 0($9)
sw $8, -128($sp)
lw $8, -128($sp)
lw $9, -100($sp)
sw $8, 0($9)
label5:
lw $9, -28($sp)
move $8, $9
sw $8, -144($sp)
lw $9, -28($sp)
lw $8, 0($9)
sw $8, -140($sp)
lw $9, -140($sp)
add $8, $9, 1
sw $8, -140($sp)
lw $8, -140($sp)
lw $9, -144($sp)
sw $8, 0($9)
j label3
label4:
jr $ra
__getInt:
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
label6:
lw $9, -4($sp)
lw $8, 0($9)
sw $8, -32($sp)
li $8, 48
sw $8, -36($sp)
lw $9, -32($sp)
lw $10, -36($sp)
sub $8, $9, $10
sw $8, -36($sp)
lw $8, -36($sp)
bltz $8, label8
lw $9, -4($sp)
lw $8, 0($9)
sw $8, -40($sp)
li $8, 57
sw $8, -44($sp)
lw $9, -40($sp)
lw $10, -44($sp)
sub $8, $9, $10
sw $8, -44($sp)
lw $8, -44($sp)
blez $8, label7
label8:
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
j label6
label7:
label9:
lw $9, -4($sp)
lw $8, 0($9)
sw $8, -60($sp)
li $8, 48
sw $8, -64($sp)
lw $9, -60($sp)
lw $10, -64($sp)
sub $8, $9, $10
sw $8, -64($sp)
lw $8, -64($sp)
bltz $8, label10
lw $9, -4($sp)
lw $8, 0($9)
sw $8, -68($sp)
li $8, 57
sw $8, -72($sp)
lw $9, -68($sp)
lw $10, -72($sp)
sub $8, $9, $10
sw $8, -72($sp)
lw $8, -72($sp)
bgtz $8, label10
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
sw $t0, 100($a3)
la $t0, var2
sw $t0, 104($a3)
la $t0, var3
sw $t0, 936($a3)
lw $9, 8($a3)
move $8, $9
sw $8, 12($a3)
lw $9, 12($a3)
move $8, $9
sw $8, 16($a3)
li $8, 5
sw $8, 20($a3)
lw $8, 20($a3)
lw $9, 16($a3)
sw $8, 0($9)
lw $9, 16($a3)
add $8, $9, 4
sw $8, 16($a3)
li $8, 4
sw $8, 24($a3)
lw $8, 24($a3)
lw $9, 16($a3)
sw $8, 0($9)
lw $9, 16($a3)
add $8, $9, 4
sw $8, 16($a3)
li $8, 2
sw $8, 28($a3)
lw $8, 28($a3)
lw $9, 16($a3)
sw $8, 0($9)
lw $9, 16($a3)
add $8, $9, 4
sw $8, 16($a3)
li $8, 3
sw $8, 32($a3)
lw $8, 32($a3)
lw $9, 16($a3)
sw $8, 0($9)
lw $9, 16($a3)
add $8, $9, 4
sw $8, 16($a3)
li $8, 0
sw $8, 36($a3)
lw $8, 36($a3)
lw $9, 16($a3)
sw $8, 0($9)
lw $9, 16($a3)
add $8, $9, 4
sw $8, 16($a3)
li $8, 1
sw $8, 40($a3)
lw $8, 40($a3)
lw $9, 16($a3)
sw $8, 0($9)
lw $9, 16($a3)
add $8, $9, 4
sw $8, 16($a3)
lw $9, 12($a3)
add $8, $9, 24
sw $8, 12($a3)
lw $9, 12($a3)
move $8, $9
sw $8, 44($a3)
li $8, 3
sw $8, 48($a3)
lw $8, 48($a3)
lw $9, 44($a3)
sw $8, 0($9)
lw $9, 44($a3)
add $8, $9, 4
sw $8, 44($a3)
li $8, 2
sw $8, 52($a3)
lw $8, 52($a3)
lw $9, 44($a3)
sw $8, 0($9)
lw $9, 44($a3)
add $8, $9, 4
sw $8, 44($a3)
li $8, 0
sw $8, 56($a3)
lw $8, 56($a3)
lw $9, 44($a3)
sw $8, 0($9)
lw $9, 44($a3)
add $8, $9, 4
sw $8, 44($a3)
li $8, 1
sw $8, 60($a3)
lw $8, 60($a3)
lw $9, 44($a3)
sw $8, 0($9)
lw $9, 44($a3)
add $8, $9, 4
sw $8, 44($a3)
li $8, 4
sw $8, 64($a3)
lw $8, 64($a3)
lw $9, 44($a3)
sw $8, 0($9)
lw $9, 44($a3)
add $8, $9, 4
sw $8, 44($a3)
li $8, 5
sw $8, 68($a3)
lw $8, 68($a3)
lw $9, 44($a3)
sw $8, 0($9)
lw $9, 44($a3)
add $8, $9, 4
sw $8, 44($a3)
lw $9, 12($a3)
add $8, $9, 24
sw $8, 12($a3)
lw $9, 12($a3)
move $8, $9
sw $8, 72($a3)
li $8, 0
sw $8, 76($a3)
lw $8, 76($a3)
lw $9, 72($a3)
sw $8, 0($9)
lw $9, 72($a3)
add $8, $9, 4
sw $8, 72($a3)
li $8, 1
sw $8, 80($a3)
lw $8, 80($a3)
lw $9, 72($a3)
sw $8, 0($9)
lw $9, 72($a3)
add $8, $9, 4
sw $8, 72($a3)
li $8, 4
sw $8, 84($a3)
lw $8, 84($a3)
lw $9, 72($a3)
sw $8, 0($9)
lw $9, 72($a3)
add $8, $9, 4
sw $8, 72($a3)
li $8, 5
sw $8, 88($a3)
lw $8, 88($a3)
lw $9, 72($a3)
sw $8, 0($9)
lw $9, 72($a3)
add $8, $9, 4
sw $8, 72($a3)
li $8, 3
sw $8, 92($a3)
lw $8, 92($a3)
lw $9, 72($a3)
sw $8, 0($9)
lw $9, 72($a3)
add $8, $9, 4
sw $8, 72($a3)
li $8, 2
sw $8, 96($a3)
lw $8, 96($a3)
lw $9, 72($a3)
sw $8, 0($9)
lw $9, 72($a3)
add $8, $9, 4
sw $8, 72($a3)
lw $9, 12($a3)
add $8, $9, 24
sw $8, 12($a3)
add $8, $29, -588
sw $8, -8($sp)
lw $9, -8($sp)
move $8, $9
sw $8, -4($sp)
add $8, $29, -592
sw $8, -16($sp)
lw $9, -16($sp)
move $8, $9
sw $8, -12($sp)
add $8, $29, -596
sw $8, -24($sp)
lw $9, -24($sp)
move $8, $9
sw $8, -20($sp)
add $8, $29, -600
sw $8, -32($sp)
lw $9, -32($sp)
move $8, $9
sw $8, -28($sp)
add $8, $29, -604
sw $8, -40($sp)
lw $9, -40($sp)
move $8, $9
sw $8, -36($sp)
add $8, $29, -608
sw $8, -48($sp)
lw $9, -48($sp)
move $8, $9
sw $8, -44($sp)
add $8, $29, -632
sw $8, -56($sp)
lw $9, -56($sp)
move $8, $9
sw $8, -52($sp)
add $8, $29, -636
sw $8, -64($sp)
lw $9, -64($sp)
move $8, $9
sw $8, -60($sp)
add $8, $29, -640
sw $8, -72($sp)
lw $9, -72($sp)
move $8, $9
sw $8, -68($sp)
lw $9, 100($a3)
move $8, $9
sw $8, -76($sp)
add $29, $29, -648
jal __getInt
sub $29, $29, -648
add $8, $29, -644
sw $8, -84($sp)
lw $9, -84($sp)
lw $8, 0($9)
sw $8, -80($sp)
lw $8, -80($sp)
lw $9, -76($sp)
sw $8, 0($9)
lw $9, -8($sp)
move $8, $9
sw $8, -88($sp)
li $8, 0
sw $8, -92($sp)
lw $8, -92($sp)
lw $9, -88($sp)
sw $8, 0($9)
label11:
lw $9, -4($sp)
lw $8, 0($9)
sw $8, -96($sp)
lw $9, 100($a3)
lw $8, 0($9)
sw $8, -100($sp)
lw $9, -96($sp)
lw $10, -100($sp)
sub $8, $9, $10
sw $8, -100($sp)
lw $8, -100($sp)
bgez $8, label12
lw $9, -12($sp)
move $8, $9
sw $8, -104($sp)
li $8, 0
sw $8, -108($sp)
lw $8, -108($sp)
lw $9, -104($sp)
sw $8, 0($9)
label14:
lw $9, -12($sp)
lw $8, 0($9)
sw $8, -112($sp)
li $8, 6
sw $8, -116($sp)
lw $9, -112($sp)
lw $10, -116($sp)
sub $8, $9, $10
sw $8, -116($sp)
lw $8, -116($sp)
bgez $8, label15
lw $9, -4($sp)
lw $8, 0($9)
sw $8, -124($sp)
lw $9, -124($sp)
mul $8, $9, 24
sw $8, -128($sp)
lw $9, 104($a3)
lw $10, -128($sp)
add $8, $9, $10
sw $8, -120($sp)
lw $9, -12($sp)
lw $8, 0($9)
sw $8, -132($sp)
lw $9, -132($sp)
mul $8, $9, 4
sw $8, -136($sp)
lw $9, -120($sp)
lw $10, -136($sp)
add $8, $9, $10
sw $8, -120($sp)
add $29, $29, -648
jal __getInt
sub $29, $29, -648
add $8, $29, -644
sw $8, -144($sp)
lw $9, -144($sp)
lw $8, 0($9)
sw $8, -140($sp)
lw $8, -140($sp)
lw $9, -120($sp)
sw $8, 0($9)
label16:
lw $9, -12($sp)
move $8, $9
sw $8, -152($sp)
lw $9, -12($sp)
lw $8, 0($9)
sw $8, -148($sp)
lw $9, -148($sp)
add $8, $9, 1
sw $8, -148($sp)
lw $8, -148($sp)
lw $9, -152($sp)
sw $8, 0($9)
j label14
label15:
label13:
lw $9, -4($sp)
move $8, $9
sw $8, -160($sp)
lw $9, -4($sp)
lw $8, 0($9)
sw $8, -156($sp)
lw $9, -156($sp)
add $8, $9, 1
sw $8, -156($sp)
lw $8, -156($sp)
lw $9, -160($sp)
sw $8, 0($9)
j label11
label12:
lw $9, -20($sp)
move $8, $9
sw $8, -164($sp)
li $8, 0
sw $8, -168($sp)
lw $8, -168($sp)
lw $9, -164($sp)
sw $8, 0($9)
lw $9, -4($sp)
move $8, $9
sw $8, -172($sp)
li $8, 1
sw $8, -176($sp)
lw $8, -176($sp)
lw $9, -172($sp)
sw $8, 0($9)
label17:
lw $9, -4($sp)
lw $8, 0($9)
sw $8, -180($sp)
lw $9, 100($a3)
lw $8, 0($9)
sw $8, -184($sp)
lw $9, -180($sp)
lw $10, -184($sp)
sub $8, $9, $10
sw $8, -184($sp)
lw $8, -184($sp)
bgez $8, label18
lw $9, -68($sp)
move $8, $9
sw $8, -188($sp)
li $8, 0
sw $8, -192($sp)
lw $8, -192($sp)
lw $9, -188($sp)
sw $8, 0($9)
lw $9, -28($sp)
move $8, $9
sw $8, -196($sp)
li $8, 0
sw $8, -200($sp)
lw $8, -200($sp)
lw $9, -196($sp)
sw $8, 0($9)
label20:
lw $9, -28($sp)
lw $8, 0($9)
sw $8, -204($sp)
li $8, 4
sw $8, -208($sp)
lw $9, -204($sp)
lw $10, -208($sp)
sub $8, $9, $10
sw $8, -208($sp)
lw $8, -208($sp)
bgez $8, label21
lw $9, -36($sp)
move $8, $9
sw $8, -212($sp)
li $8, 0
sw $8, -216($sp)
lw $8, -216($sp)
lw $9, -212($sp)
sw $8, 0($9)
label23:
lw $9, -36($sp)
lw $8, 0($9)
sw $8, -220($sp)
li $8, 4
sw $8, -224($sp)
lw $9, -220($sp)
lw $10, -224($sp)
sub $8, $9, $10
sw $8, -224($sp)
lw $8, -224($sp)
bgez $8, label24
lw $9, -44($sp)
move $8, $9
sw $8, -228($sp)
li $8, 0
sw $8, -232($sp)
lw $8, -232($sp)
lw $9, -228($sp)
sw $8, 0($9)
label26:
lw $9, -44($sp)
lw $8, 0($9)
sw $8, -236($sp)
li $8, 4
sw $8, -240($sp)
lw $9, -236($sp)
lw $10, -240($sp)
sub $8, $9, $10
sw $8, -240($sp)
lw $8, -240($sp)
bgez $8, label27
lw $9, -12($sp)
move $8, $9
sw $8, -244($sp)
li $8, 0
sw $8, -248($sp)
lw $8, -248($sp)
lw $9, -244($sp)
sw $8, 0($9)
label29:
lw $9, -12($sp)
lw $8, 0($9)
sw $8, -252($sp)
li $8, 6
sw $8, -256($sp)
lw $9, -252($sp)
lw $10, -256($sp)
sub $8, $9, $10
sw $8, -256($sp)
lw $8, -256($sp)
bgez $8, label30
lw $9, -12($sp)
lw $8, 0($9)
sw $8, -264($sp)
lw $9, -264($sp)
mul $8, $9, 4
sw $8, -268($sp)
lw $9, -52($sp)
lw $10, -268($sp)
add $8, $9, $10
sw $8, -260($sp)
lw $9, -4($sp)
lw $8, 0($9)
sw $8, -276($sp)
lw $9, -276($sp)
mul $8, $9, 24
sw $8, -280($sp)
lw $9, 104($a3)
lw $10, -280($sp)
add $8, $9, $10
sw $8, -272($sp)
lw $9, -12($sp)
lw $8, 0($9)
sw $8, -284($sp)
lw $9, -284($sp)
mul $8, $9, 4
sw $8, -288($sp)
lw $9, -272($sp)
lw $10, -288($sp)
add $8, $9, $10
sw $8, -272($sp)
lw $9, -272($sp)
lw $8, 0($9)
sw $8, -272($sp)
lw $8, -272($sp)
lw $9, -260($sp)
sw $8, 0($9)
label31:
lw $9, -12($sp)
move $8, $9
sw $8, -296($sp)
lw $9, -12($sp)
lw $8, 0($9)
sw $8, -292($sp)
lw $9, -292($sp)
add $8, $9, 1
sw $8, -292($sp)
lw $8, -292($sp)
lw $9, -296($sp)
sw $8, 0($9)
j label29
label30:
lw $9, -12($sp)
move $8, $9
sw $8, -300($sp)
li $8, 0
sw $8, -304($sp)
lw $8, -304($sp)
lw $9, -300($sp)
sw $8, 0($9)
label32:
lw $9, -12($sp)
lw $8, 0($9)
sw $8, -308($sp)
lw $9, -28($sp)
lw $8, 0($9)
sw $8, -312($sp)
lw $9, -308($sp)
lw $10, -312($sp)
sub $8, $9, $10
sw $8, -312($sp)
lw $8, -312($sp)
bgez $8, label33
li $8, 0
sw $8, -320($sp)
add $8, $29, -648
sw $8, -324($sp)
lw $8, -320($sp)
lw $9, -324($sp)
sw $8, 0($9)
lw $9, -52($sp)
move $8, $9
sw $8, -328($sp)
add $8, $29, -652
sw $8, -332($sp)
lw $8, -328($sp)
lw $9, -332($sp)
sw $8, 0($9)
add $29, $29, -652
jal __transform
sub $29, $29, -652
label34:
lw $9, -12($sp)
move $8, $9
sw $8, -340($sp)
lw $9, -12($sp)
lw $8, 0($9)
sw $8, -336($sp)
lw $9, -336($sp)
add $8, $9, 1
sw $8, -336($sp)
lw $8, -336($sp)
lw $9, -340($sp)
sw $8, 0($9)
j label32
label33:
lw $9, -12($sp)
move $8, $9
sw $8, -344($sp)
li $8, 0
sw $8, -348($sp)
lw $8, -348($sp)
lw $9, -344($sp)
sw $8, 0($9)
label35:
lw $9, -12($sp)
lw $8, 0($9)
sw $8, -352($sp)
lw $9, -36($sp)
lw $8, 0($9)
sw $8, -356($sp)
lw $9, -352($sp)
lw $10, -356($sp)
sub $8, $9, $10
sw $8, -356($sp)
lw $8, -356($sp)
bgez $8, label36
li $8, 1
sw $8, -364($sp)
add $8, $29, -648
sw $8, -368($sp)
lw $8, -364($sp)
lw $9, -368($sp)
sw $8, 0($9)
lw $9, -52($sp)
move $8, $9
sw $8, -372($sp)
add $8, $29, -652
sw $8, -376($sp)
lw $8, -372($sp)
lw $9, -376($sp)
sw $8, 0($9)
add $29, $29, -652
jal __transform
sub $29, $29, -652
label37:
lw $9, -12($sp)
move $8, $9
sw $8, -384($sp)
lw $9, -12($sp)
lw $8, 0($9)
sw $8, -380($sp)
lw $9, -380($sp)
add $8, $9, 1
sw $8, -380($sp)
lw $8, -380($sp)
lw $9, -384($sp)
sw $8, 0($9)
j label35
label36:
lw $9, -12($sp)
move $8, $9
sw $8, -388($sp)
li $8, 0
sw $8, -392($sp)
lw $8, -392($sp)
lw $9, -388($sp)
sw $8, 0($9)
label38:
lw $9, -12($sp)
lw $8, 0($9)
sw $8, -396($sp)
lw $9, -44($sp)
lw $8, 0($9)
sw $8, -400($sp)
lw $9, -396($sp)
lw $10, -400($sp)
sub $8, $9, $10
sw $8, -400($sp)
lw $8, -400($sp)
bgez $8, label39
li $8, 2
sw $8, -408($sp)
add $8, $29, -648
sw $8, -412($sp)
lw $8, -408($sp)
lw $9, -412($sp)
sw $8, 0($9)
lw $9, -52($sp)
move $8, $9
sw $8, -416($sp)
add $8, $29, -652
sw $8, -420($sp)
lw $8, -416($sp)
lw $9, -420($sp)
sw $8, 0($9)
add $29, $29, -652
jal __transform
sub $29, $29, -652
label40:
lw $9, -12($sp)
move $8, $9
sw $8, -428($sp)
lw $9, -12($sp)
lw $8, 0($9)
sw $8, -424($sp)
lw $9, -424($sp)
add $8, $9, 1
sw $8, -424($sp)
lw $8, -424($sp)
lw $9, -428($sp)
sw $8, 0($9)
j label38
label39:
lw $9, -60($sp)
move $8, $9
sw $8, -432($sp)
li $8, 1
sw $8, -436($sp)
lw $8, -436($sp)
lw $9, -432($sp)
sw $8, 0($9)
lw $9, -12($sp)
move $8, $9
sw $8, -440($sp)
li $8, 0
sw $8, -444($sp)
lw $8, -444($sp)
lw $9, -440($sp)
sw $8, 0($9)
label41:
lw $9, -12($sp)
lw $8, 0($9)
sw $8, -448($sp)
li $8, 6
sw $8, -452($sp)
lw $9, -448($sp)
lw $10, -452($sp)
sub $8, $9, $10
sw $8, -452($sp)
lw $8, -452($sp)
bgez $8, label42
lw $9, -12($sp)
lw $8, 0($9)
sw $8, -460($sp)
lw $9, -460($sp)
mul $8, $9, 4
sw $8, -464($sp)
lw $9, -52($sp)
lw $10, -464($sp)
add $8, $9, $10
sw $8, -456($sp)
lw $9, -456($sp)
lw $8, 0($9)
sw $8, -456($sp)
li $8, 0
sw $8, -472($sp)
lw $9, -472($sp)
mul $8, $9, 24
sw $8, -476($sp)
lw $9, 104($a3)
lw $10, -476($sp)
add $8, $9, $10
sw $8, -468($sp)
lw $9, -12($sp)
lw $8, 0($9)
sw $8, -480($sp)
lw $9, -480($sp)
mul $8, $9, 4
sw $8, -484($sp)
lw $9, -468($sp)
lw $10, -484($sp)
add $8, $9, $10
sw $8, -468($sp)
lw $9, -468($sp)
lw $8, 0($9)
sw $8, -468($sp)
lw $9, -456($sp)
lw $10, -468($sp)
sub $8, $9, $10
sw $8, -468($sp)
lw $8, -468($sp)
beqz $8, label44
lw $9, -60($sp)
move $8, $9
sw $8, -488($sp)
li $8, 0
sw $8, -492($sp)
lw $8, -492($sp)
lw $9, -488($sp)
sw $8, 0($9)
j label42
label44:
label43:
lw $9, -12($sp)
move $8, $9
sw $8, -500($sp)
lw $9, -12($sp)
lw $8, 0($9)
sw $8, -496($sp)
lw $9, -496($sp)
add $8, $9, 1
sw $8, -496($sp)
lw $8, -496($sp)
lw $9, -500($sp)
sw $8, 0($9)
j label41
label42:
lw $9, -60($sp)
lw $8, 0($9)
sw $8, -504($sp)
lw $8, -504($sp)
beqz $8, label45
lw $9, -68($sp)
move $8, $9
sw $8, -508($sp)
li $8, 1
sw $8, -512($sp)
lw $8, -512($sp)
lw $9, -508($sp)
sw $8, 0($9)
label45:
label28:
lw $9, -44($sp)
move $8, $9
sw $8, -520($sp)
lw $9, -44($sp)
lw $8, 0($9)
sw $8, -516($sp)
lw $9, -516($sp)
add $8, $9, 1
sw $8, -516($sp)
lw $8, -516($sp)
lw $9, -520($sp)
sw $8, 0($9)
j label26
label27:
label25:
lw $9, -36($sp)
move $8, $9
sw $8, -528($sp)
lw $9, -36($sp)
lw $8, 0($9)
sw $8, -524($sp)
lw $9, -524($sp)
add $8, $9, 1
sw $8, -524($sp)
lw $8, -524($sp)
lw $9, -528($sp)
sw $8, 0($9)
j label23
label24:
label22:
lw $9, -28($sp)
move $8, $9
sw $8, -536($sp)
lw $9, -28($sp)
lw $8, 0($9)
sw $8, -532($sp)
lw $9, -532($sp)
add $8, $9, 1
sw $8, -532($sp)
lw $8, -532($sp)
lw $9, -536($sp)
sw $8, 0($9)
j label20
label21:
lw $9, -20($sp)
move $8, $9
sw $8, -540($sp)
lw $9, -20($sp)
lw $8, 0($9)
sw $8, -548($sp)
lw $9, -68($sp)
lw $8, 0($9)
sw $8, -544($sp)
lw $9, -548($sp)
lw $10, -544($sp)
add $8, $9, $10
sw $8, -548($sp)
lw $8, -548($sp)
lw $9, -540($sp)
sw $8, 0($9)
label19:
lw $9, -4($sp)
move $8, $9
sw $8, -556($sp)
lw $9, -4($sp)
lw $8, 0($9)
sw $8, -552($sp)
lw $9, -552($sp)
add $8, $9, 1
sw $8, -552($sp)
lw $8, -552($sp)
lw $9, -556($sp)
sw $8, 0($9)
j label17
label18:
add $8, $29, -648
sw $8, -568($sp)
lw $9, -20($sp)
lw $8, 0($9)
sw $8, -564($sp)
lw $8, -564($sp)
lw $9, -568($sp)
sw $8, 0($9)
lw $9, 936($a3)
move $8, $9
sw $8, -572($sp)
add $8, $29, -652
sw $8, -576($sp)
lw $8, -572($sp)
lw $9, -576($sp)
sw $8, 0($9)
add $29, $29, -652
jal __printf
sub $29, $29, -652
li $8, 0
sw $8, -580($sp)
add $8, $29, 4
sw $8, -584($sp)
lw $8, -580($sp)
lw $9, -584($sp)
sw $8, 0($9)
j __main_end
j __main_end
__main_end:
li $v0, 10
syscall
#global $2 72
#global $25 4
#global $26 26664
#string $234 #%d\n
#move $3 $2
#move $4 $3
#li $5 5
#sw $5 $4 0
#addi $4 $4 4
#li $6 4
#sw $6 $4 0
#addi $4 $4 4
#li $7 2
#sw $7 $4 0
#addi $4 $4 4
#li $8 3
#sw $8 $4 0
#addi $4 $4 4
#li $9 0
#sw $9 $4 0
#addi $4 $4 4
#li $10 1
#sw $10 $4 0
#addi $4 $4 4
#addi $3 $3 24
#move $11 $3
#li $12 3
#sw $12 $11 0
#addi $11 $11 4
#li $13 2
#sw $13 $11 0
#addi $11 $11 4
#li $14 0
#sw $14 $11 0
#addi $11 $11 4
#li $15 1
#sw $15 $11 0
#addi $11 $11 4
#li $16 4
#sw $16 $11 0
#addi $11 $11 4
#li $17 5
#sw $17 $11 0
#addi $11 $11 4
#addi $3 $3 24
#move $18 $3
#li $19 0
#sw $19 $18 0
#addi $18 $18 4
#li $20 1
#sw $20 $18 0
#addi $18 $18 4
#li $21 4
#sw $21 $18 0
#addi $18 $18 4
#li $22 5
#sw $22 $18 0
#addi $18 $18 4
#li $23 3
#sw $23 $18 0
#addi $18 $18 4
#li $24 2
#sw $24 $18 0
#addi $18 $18 4
#addi $3 $3 24
#----------------------------
#func #transform
#addi $27 $0 0
#addi $28 $0 4
#addi $30 $0 -168
#move $29 $30
#addi $32 $0 -172
#move $31 $32
#addi $34 $0 -176
#move $33 $34
#move $35 $32
#li $36 0
#sw $36 $35 0
#label l:0
####move $37 $31
#lw $37 $31 0
#li $38 6
#sub $38 $37 $38
#bgez $38 l:1
####move $39 $29
####move $40 $31
#lw $40 $31 0
#muli $41 $40 4
#add $39 $29 $41
#lw $42 $27 0
####move $43 $31
#lw $43 $31 0
#muli $44 $43 4
#add $42 $42 $44
#lw $42 $42 0
#sw $42 $39 0
#label l:2
####move $45 $31
#move $46 $31
#lw $45 $31 0
#addi $45 $45 1
#sw $45 $46 0
#goto l:0
#label l:1
#move $47 $33
#li $48 0
#sw $48 $47 0
#label l:3
####move $49 $33
#lw $49 $33 0
#li $50 6
#sub $50 $49 $50
#bgez $50 l:4
#lw $51 $27 0
####move $52 $2
####move $54 $28
#lw $54 $28 0
#muli $55 $54 24
#add $52 $2 $55
####move $56 $33
#lw $56 $33 0
#muli $57 $56 4
#add $52 $52 $57
#lw $52 $52 0
#muli $53 $52 4
#add $51 $51 $53
####move $58 $29
####move $59 $33
#lw $59 $33 0
#muli $60 $59 4
#add $58 $29 $60
#lw $58 $58 0
#sw $58 $51 0
#label l:5
####move $61 $33
#move $62 $33
#lw $61 $33 0
#addi $61 $61 1
#sw $61 $62 0
#goto l:3
#label l:4
#return
#----------------------------
#func #getInt
#addi $64 $0 -116
#move $63 $64
#sw $1 $0 -124
#addi $0 $0 -124
#call #getchar
#subi $0 $0 -124
#lw $1 $0 -124
#addi $66 $0 -120
####move $65 $66
#lw $65 $66 0
#sw $65 $63 0
#addi $68 $0 -120
#move $67 $68
#li $69 0
#sw $69 $67 0
#label l:6
####move $70 $63
#lw $70 $63 0
#li $71 48
#sub $71 $70 $71
#bltz $71 l:8
####move $72 $63
#lw $72 $63 0
#li $73 57
#sub $73 $72 $73
#blez $73 l:7
#label l:8
#move $74 $63
#sw $1 $0 -128
#addi $0 $0 -128
#call #getchar
#subi $0 $0 -128
#lw $1 $0 -128
#addi $76 $0 -124
####move $75 $76
#lw $75 $76 0
#sw $75 $74 0
#goto l:6
#label l:7
#label l:9
####move $77 $63
#lw $77 $63 0
#li $78 48
#sub $78 $77 $78
#bltz $78 l:10
####move $79 $63
#lw $79 $63 0
#li $80 57
#sub $80 $79 $80
#bgtz $80 l:10
#move $81 $67
####move $82 $67
#lw $82 $67 0
#li $83 10
#mul $82 $82 $83
####move $84 $63
#lw $84 $63 0
#add $82 $82 $84
#li $85 48
#sub $82 $82 $85
#sw $82 $81 0
#move $86 $63
#sw $1 $0 -128
#addi $0 $0 -128
#call #getchar
#subi $0 $0 -128
#lw $1 $0 -128
#addi $88 $0 -124
####move $87 $88
#lw $87 $88 0
#sw $87 $86 0
#goto l:9
#label l:10
####move $89 $67
#addi $90 $0 4
#lw $89 $67 0
#sw $89 $90 0
#return
#return
#----------------------------
#func #main
#addi $92 $0 -588
#move $91 $92
#addi $94 $0 -592
#move $93 $94
#addi $96 $0 -596
#move $95 $96
#addi $98 $0 -600
#move $97 $98
#addi $100 $0 -604
#move $99 $100
#addi $102 $0 -608
#move $101 $102
#addi $104 $0 -632
#move $103 $104
#addi $106 $0 -636
#move $105 $106
#addi $108 $0 -640
#move $107 $108
#move $109 $25
#addi $0 $0 -648
#call #getInt
#subi $0 $0 -648
#addi $111 $0 -644
####move $110 $111
#lw $110 $111 0
#sw $110 $109 0
#move $112 $92
#li $113 0
#sw $113 $112 0
#label l:11
####move $114 $91
#lw $114 $91 0
####move $115 $25
#lw $115 $25 0
#sub $115 $114 $115
#bgez $115 l:12
#move $116 $93
#li $117 0
#sw $117 $116 0
#label l:14
####move $118 $93
#lw $118 $93 0
#li $119 6
#sub $119 $118 $119
#bgez $119 l:15
####move $120 $26
####move $121 $91
#lw $121 $91 0
#muli $122 $121 24
#add $120 $26 $122
####move $123 $93
#lw $123 $93 0
#muli $124 $123 4
#add $120 $120 $124
#addi $0 $0 -648
#call #getInt
#subi $0 $0 -648
#addi $126 $0 -644
####move $125 $126
#lw $125 $126 0
#sw $125 $120 0
#label l:16
####move $127 $93
#move $128 $93
#lw $127 $93 0
#addi $127 $127 1
#sw $127 $128 0
#goto l:14
#label l:15
#label l:13
####move $129 $91
#move $130 $91
#lw $129 $91 0
#addi $129 $129 1
#sw $129 $130 0
#goto l:11
#label l:12
#move $131 $95
#li $132 0
#sw $132 $131 0
#move $133 $91
#li $134 1
#sw $134 $133 0
#label l:17
####move $135 $91
#lw $135 $91 0
####move $136 $25
#lw $136 $25 0
#sub $136 $135 $136
#bgez $136 l:18
#move $137 $107
#li $138 0
#sw $138 $137 0
#move $139 $97
#li $140 0
#sw $140 $139 0
#label l:20
####move $141 $97
#lw $141 $97 0
#li $142 4
#sub $142 $141 $142
#bgez $142 l:21
#move $143 $99
#li $144 0
#sw $144 $143 0
#label l:23
####move $145 $99
#lw $145 $99 0
#li $146 4
#sub $146 $145 $146
#bgez $146 l:24
#move $147 $101
#li $148 0
#sw $148 $147 0
#label l:26
####move $149 $101
#lw $149 $101 0
#li $150 4
#sub $150 $149 $150
#bgez $150 l:27
#move $151 $93
#li $152 0
#sw $152 $151 0
#label l:29
####move $153 $93
#lw $153 $93 0
#li $154 6
#sub $154 $153 $154
#bgez $154 l:30
####move $155 $103
####move $156 $93
#lw $156 $93 0
#muli $157 $156 4
#add $155 $103 $157
####move $158 $26
####move $159 $91
#lw $159 $91 0
#muli $160 $159 24
#add $158 $26 $160
####move $161 $93
#lw $161 $93 0
#muli $162 $161 4
#add $158 $158 $162
#lw $158 $158 0
#sw $158 $155 0
#label l:31
####move $163 $93
#move $164 $93
#lw $163 $93 0
#addi $163 $163 1
#sw $163 $164 0
#goto l:29
#label l:30
#move $165 $93
#li $166 0
#sw $166 $165 0
#label l:32
####move $167 $93
#lw $167 $93 0
####move $168 $97
#lw $168 $97 0
#sub $168 $167 $168
#bgez $168 l:33
#li $170 0
#addi $171 $0 -648
#sw $170 $171 0
#move $172 $103
#addi $173 $0 -652
#sw $172 $173 0
#addi $0 $0 -652
#call #transform
#subi $0 $0 -652
#label l:34
####move $174 $93
#move $175 $93
#lw $174 $93 0
#addi $174 $174 1
#sw $174 $175 0
#goto l:32
#label l:33
#move $176 $93
#li $177 0
#sw $177 $176 0
#label l:35
####move $178 $93
#lw $178 $93 0
####move $179 $99
#lw $179 $99 0
#sub $179 $178 $179
#bgez $179 l:36
#li $181 1
#addi $182 $0 -648
#sw $181 $182 0
#move $183 $103
#addi $184 $0 -652
#sw $183 $184 0
#addi $0 $0 -652
#call #transform
#subi $0 $0 -652
#label l:37
####move $185 $93
#move $186 $93
#lw $185 $93 0
#addi $185 $185 1
#sw $185 $186 0
#goto l:35
#label l:36
#move $187 $93
#li $188 0
#sw $188 $187 0
#label l:38
####move $189 $93
#lw $189 $93 0
####move $190 $101
#lw $190 $101 0
#sub $190 $189 $190
#bgez $190 l:39
#li $192 2
#addi $193 $0 -648
#sw $192 $193 0
#move $194 $103
#addi $195 $0 -652
#sw $194 $195 0
#addi $0 $0 -652
#call #transform
#subi $0 $0 -652
#label l:40
####move $196 $93
#move $197 $93
#lw $196 $93 0
#addi $196 $196 1
#sw $196 $197 0
#goto l:38
#label l:39
#move $198 $105
#li $199 1
#sw $199 $198 0
#move $200 $93
#li $201 0
#sw $201 $200 0
#label l:41
####move $202 $93
#lw $202 $93 0
#li $203 6
#sub $203 $202 $203
#bgez $203 l:42
####move $204 $103
####move $205 $93
#lw $205 $93 0
#muli $206 $205 4
#add $204 $103 $206
#lw $204 $204 0
####move $207 $26
#li $208 0
#muli $209 $208 24
#add $207 $26 $209
####move $210 $93
#lw $210 $93 0
#muli $211 $210 4
#add $207 $207 $211
#lw $207 $207 0
#sub $207 $204 $207
#beqz $207 l:44
#move $212 $105
#li $213 0
#sw $213 $212 0
#goto l:42
#label l:44
#label l:43
####move $214 $93
#move $215 $93
#lw $214 $93 0
#addi $214 $214 1
#sw $214 $215 0
#goto l:41
#label l:42
####move $216 $105
#lw $216 $105 0
#beqz $216 l:45
#move $217 $107
#li $218 1
#sw $218 $217 0
#label l:45
#label l:28
####move $219 $101
#move $220 $101
#lw $219 $101 0
#addi $219 $219 1
#sw $219 $220 0
#goto l:26
#label l:27
#label l:25
####move $221 $99
#move $222 $99
#lw $221 $99 0
#addi $221 $221 1
#sw $221 $222 0
#goto l:23
#label l:24
#label l:22
####move $223 $97
#move $224 $97
#lw $223 $97 0
#addi $223 $223 1
#sw $223 $224 0
#goto l:20
#label l:21
#move $225 $95
####move $226 $107
#lw $227 $95 0
#lw $226 $107 0
#add $227 $227 $226
#sw $227 $225 0
#label l:19
####move $228 $91
#move $229 $91
#lw $228 $91 0
#addi $228 $228 1
#sw $228 $229 0
#goto l:17
#label l:18
####move $231 $95
#addi $232 $0 -648
#lw $231 $95 0
#sw $231 $232 0
#move $233 $234
#addi $235 $0 -652
#sw $233 $235 0
#addi $0 $0 -652
#call #printf
#subi $0 $0 -652
#li $236 0
#addi $237 $0 4
#sw $236 $237 0
#return
#return
