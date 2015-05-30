.data
temp: .space 1720
var0: .space 4
var1: .space 4
var2: .space 220
var3: .space 440
var4: .space 200
var5: .space 600
var6: .asciiz "%d\n"
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

__min:
add $8, $29, 0
sw $8, -4($sp)
add $8, $29, 4
sw $8, -8($sp)
lw $9, -4($sp)
lw $8, 0($9)
sw $8, -12($sp)
lw $9, -8($sp)
lw $8, 0($9)
sw $8, -16($sp)
lw $9, -12($sp)
lw $10, -16($sp)
sub $8, $9, $10
sw $8, -16($sp)
lw $8, -16($sp)
bgez $8, label0
add $8, $29, 12
sw $8, -24($sp)
lw $9, -4($sp)
lw $8, 0($9)
sw $8, -20($sp)
lw $8, -20($sp)
lw $9, -24($sp)
sw $8, 0($9)
jr $ra
label0:
add $8, $29, 12
sw $8, -32($sp)
lw $9, -8($sp)
lw $8, 0($9)
sw $8, -28($sp)
lw $8, -28($sp)
lw $9, -32($sp)
sw $8, 0($9)
jr $ra
jr $ra
__newNode:
add $8, $29, -84
sw $8, -8($sp)
lw $9, -8($sp)
move $8, $9
sw $8, -12($sp)
sw $31, -92($29)
li $8, 20
sw $8, -20($sp)
add $8, $29, -96
sw $8, -24($sp)
lw $8, -20($sp)
lw $9, -24($sp)
sw $8, 0($9)
add $29, $29, -96
jal __malloc
sub $29, $29, -96
lw $31, -92($29)
add $8, $29, -88
sw $8, -28($sp)
lw $9, -28($sp)
lw $8, 0($9)
sw $8, -16($sp)
lw $8, -16($sp)
lw $9, -12($sp)
sw $8, 0($9)
lw $9, -8($sp)
lw $8, 0($9)
sw $8, -32($sp)
lw $9, -32($sp)
add $8, $9, 0
sw $8, -32($sp)
li $8, 0
sw $8, -36($sp)
lw $9, -36($sp)
mul $8, $9, 4
sw $8, -40($sp)
lw $9, -32($sp)
lw $10, -40($sp)
add $8, $9, $10
sw $8, -32($sp)
lw $9, -8($sp)
lw $8, 0($9)
sw $8, -44($sp)
lw $9, -44($sp)
add $8, $9, 0
sw $8, -44($sp)
li $8, 1
sw $8, -48($sp)
lw $9, -48($sp)
mul $8, $9, 4
sw $8, -52($sp)
lw $9, -44($sp)
lw $10, -52($sp)
add $8, $9, $10
sw $8, -44($sp)
lw $9, -8($sp)
lw $8, 0($9)
sw $8, -56($sp)
lw $9, -56($sp)
add $8, $9, 8
sw $8, -56($sp)
lw $9, -8($sp)
lw $8, 0($9)
sw $8, -60($sp)
lw $9, -60($sp)
add $8, $9, 12
sw $8, -60($sp)
li $8, 0
sw $8, -64($sp)
lw $8, -64($sp)
lw $9, -60($sp)
sw $8, 0($9)
lw $9, -60($sp)
lw $8, 0($9)
sw $8, -60($sp)
lw $8, -60($sp)
lw $9, -56($sp)
sw $8, 0($9)
lw $9, -56($sp)
lw $8, 0($9)
sw $8, -56($sp)
lw $8, -56($sp)
lw $9, -44($sp)
sw $8, 0($9)
lw $9, -44($sp)
lw $8, 0($9)
sw $8, -44($sp)
lw $8, -44($sp)
lw $9, -32($sp)
sw $8, 0($9)
lw $9, -8($sp)
lw $8, 0($9)
sw $8, -68($sp)
lw $9, -68($sp)
add $8, $9, 16
sw $8, -68($sp)
li $8, 1
sw $8, -72($sp)
lw $8, -72($sp)
lw $9, -68($sp)
sw $8, 0($9)
add $8, $29, 4
sw $8, -80($sp)
lw $9, -8($sp)
lw $8, 0($9)
sw $8, -76($sp)
lw $8, -76($sp)
lw $9, -80($sp)
sw $8, 0($9)
jr $ra
jr $ra
__f:
add $8, $29, 0
sw $8, -4($sp)
lw $9, -4($sp)
lw $8, 0($9)
sw $8, -8($sp)
lw $9, -4($sp)
lw $8, 0($9)
sw $8, -12($sp)
lw $9, -12($sp)
add $8, $9, 8
sw $8, -12($sp)
lw $9, -12($sp)
lw $8, 0($9)
sw $8, -12($sp)
lw $9, -12($sp)
add $8, $9, 0
sw $8, -12($sp)
li $8, 1
sw $8, -16($sp)
lw $9, -16($sp)
mul $8, $9, 4
sw $8, -20($sp)
lw $9, -12($sp)
lw $10, -20($sp)
add $8, $9, $10
sw $8, -12($sp)
lw $9, -12($sp)
lw $8, 0($9)
sw $8, -12($sp)
lw $9, -8($sp)
lw $10, -12($sp)
sub $8, $9, $10
sw $8, -12($sp)
li $8, 1
sw $8, -8($sp)
lw $8, -12($sp)
beqz $8, label1
li $8, 0
sw $8, -8($sp)
label1:
add $8, $29, 8
sw $8, -24($sp)
lw $8, -8($sp)
lw $9, -24($sp)
sw $8, 0($9)
jr $ra
jr $ra
__push_up:
add $8, $29, 0
sw $8, -4($sp)
lw $9, -4($sp)
lw $8, 0($9)
sw $8, -8($sp)
lw $9, -8($sp)
add $8, $9, 16
sw $8, -8($sp)
li $8, 1
sw $8, -12($sp)
lw $8, -12($sp)
lw $9, -8($sp)
sw $8, 0($9)
lw $9, -4($sp)
lw $8, 0($9)
sw $8, -16($sp)
lw $9, -16($sp)
add $8, $9, 0
sw $8, -16($sp)
li $8, 0
sw $8, -20($sp)
lw $9, -20($sp)
mul $8, $9, 4
sw $8, -24($sp)
lw $9, -16($sp)
lw $10, -24($sp)
add $8, $9, $10
sw $8, -16($sp)
lw $9, -16($sp)
lw $8, 0($9)
sw $8, -16($sp)
lw $8, -16($sp)
beqz $8, label2
lw $9, -4($sp)
lw $8, 0($9)
sw $8, -28($sp)
lw $9, -28($sp)
add $8, $9, 16
sw $8, -28($sp)
lw $9, -4($sp)
lw $8, 0($9)
sw $8, -32($sp)
lw $9, -32($sp)
add $8, $9, 0
sw $8, -32($sp)
li $8, 0
sw $8, -36($sp)
lw $9, -36($sp)
mul $8, $9, 4
sw $8, -40($sp)
lw $9, -32($sp)
lw $10, -40($sp)
add $8, $9, $10
sw $8, -32($sp)
lw $9, -32($sp)
lw $8, 0($9)
sw $8, -32($sp)
lw $9, -32($sp)
add $8, $9, 16
sw $8, -32($sp)
lw $9, -28($sp)
lw $8, 0($9)
sw $8, -44($sp)
lw $9, -32($sp)
lw $8, 0($9)
sw $8, -32($sp)
lw $9, -44($sp)
lw $10, -32($sp)
add $8, $9, $10
sw $8, -44($sp)
lw $8, -44($sp)
lw $9, -28($sp)
sw $8, 0($9)
label2:
lw $9, -4($sp)
lw $8, 0($9)
sw $8, -48($sp)
lw $9, -48($sp)
add $8, $9, 0
sw $8, -48($sp)
li $8, 1
sw $8, -52($sp)
lw $9, -52($sp)
mul $8, $9, 4
sw $8, -56($sp)
lw $9, -48($sp)
lw $10, -56($sp)
add $8, $9, $10
sw $8, -48($sp)
lw $9, -48($sp)
lw $8, 0($9)
sw $8, -48($sp)
lw $8, -48($sp)
beqz $8, label3
lw $9, -4($sp)
lw $8, 0($9)
sw $8, -60($sp)
lw $9, -60($sp)
add $8, $9, 16
sw $8, -60($sp)
lw $9, -4($sp)
lw $8, 0($9)
sw $8, -64($sp)
lw $9, -64($sp)
add $8, $9, 0
sw $8, -64($sp)
li $8, 1
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
lw $9, -64($sp)
add $8, $9, 16
sw $8, -64($sp)
lw $9, -60($sp)
lw $8, 0($9)
sw $8, -76($sp)
lw $9, -64($sp)
lw $8, 0($9)
sw $8, -64($sp)
lw $9, -76($sp)
lw $10, -64($sp)
add $8, $9, $10
sw $8, -76($sp)
lw $8, -76($sp)
lw $9, -60($sp)
sw $8, 0($9)
label3:
jr $ra
__rotate:
add $8, $29, 0
sw $8, -4($sp)
add $8, $29, -196
sw $8, -12($sp)
lw $9, -12($sp)
move $8, $9
sw $8, -8($sp)
lw $9, -4($sp)
lw $8, 0($9)
sw $8, -16($sp)
lw $9, -16($sp)
add $8, $9, 8
sw $8, -16($sp)
lw $9, -16($sp)
lw $8, 0($9)
sw $8, -16($sp)
lw $8, -16($sp)
lw $9, -8($sp)
sw $8, 0($9)
add $8, $29, -200
sw $8, -24($sp)
lw $9, -24($sp)
move $8, $9
sw $8, -20($sp)
sw $31, -208($29)
add $8, $29, -212
sw $8, -36($sp)
lw $9, -4($sp)
lw $8, 0($9)
sw $8, -32($sp)
lw $8, -32($sp)
lw $9, -36($sp)
sw $8, 0($9)
add $29, $29, -212
jal __f
sub $29, $29, -212
lw $31, -208($29)
add $8, $29, -204
sw $8, -40($sp)
lw $9, -40($sp)
lw $8, 0($9)
sw $8, -28($sp)
lw $8, -28($sp)
lw $9, -20($sp)
sw $8, 0($9)
lw $9, -4($sp)
lw $8, 0($9)
sw $8, -44($sp)
lw $9, -44($sp)
add $8, $9, 8
sw $8, -44($sp)
lw $9, -8($sp)
lw $8, 0($9)
sw $8, -48($sp)
lw $9, -48($sp)
add $8, $9, 8
sw $8, -48($sp)
lw $9, -48($sp)
lw $8, 0($9)
sw $8, -48($sp)
lw $8, -48($sp)
lw $9, -44($sp)
sw $8, 0($9)
lw $9, -8($sp)
lw $8, 0($9)
sw $8, -52($sp)
lw $9, -52($sp)
add $8, $9, 8
sw $8, -52($sp)
lw $9, -52($sp)
lw $8, 0($9)
sw $8, -52($sp)
lw $8, -52($sp)
beqz $8, label4
lw $9, -8($sp)
lw $8, 0($9)
sw $8, -56($sp)
lw $9, -56($sp)
add $8, $9, 8
sw $8, -56($sp)
lw $9, -56($sp)
lw $8, 0($9)
sw $8, -56($sp)
lw $9, -56($sp)
add $8, $9, 0
sw $8, -56($sp)
sw $31, -208($29)
add $8, $29, -212
sw $8, -72($sp)
lw $9, -8($sp)
lw $8, 0($9)
sw $8, -68($sp)
lw $8, -68($sp)
lw $9, -72($sp)
sw $8, 0($9)
add $29, $29, -212
jal __f
sub $29, $29, -212
lw $31, -208($29)
add $8, $29, -204
sw $8, -76($sp)
lw $9, -76($sp)
lw $8, 0($9)
sw $8, -60($sp)
lw $9, -60($sp)
mul $8, $9, 4
sw $8, -64($sp)
lw $9, -56($sp)
lw $10, -64($sp)
add $8, $9, $10
sw $8, -56($sp)
lw $9, -4($sp)
lw $8, 0($9)
sw $8, -80($sp)
lw $8, -80($sp)
lw $9, -56($sp)
sw $8, 0($9)
label4:
lw $9, -8($sp)
lw $8, 0($9)
sw $8, -84($sp)
lw $9, -84($sp)
add $8, $9, 0
sw $8, -84($sp)
lw $9, -20($sp)
lw $8, 0($9)
sw $8, -88($sp)
lw $9, -88($sp)
mul $8, $9, 4
sw $8, -92($sp)
lw $9, -84($sp)
lw $10, -92($sp)
add $8, $9, $10
sw $8, -84($sp)
lw $9, -4($sp)
lw $8, 0($9)
sw $8, -96($sp)
lw $9, -96($sp)
add $8, $9, 0
sw $8, -96($sp)
li $8, 1
sw $8, -100($sp)
lw $9, -20($sp)
lw $8, 0($9)
sw $8, -108($sp)
lw $9, -100($sp)
lw $10, -108($sp)
xor $8, $9, $10
sw $8, -100($sp)
lw $9, -100($sp)
mul $8, $9, 4
sw $8, -104($sp)
lw $9, -96($sp)
lw $10, -104($sp)
add $8, $9, $10
sw $8, -96($sp)
lw $9, -96($sp)
lw $8, 0($9)
sw $8, -96($sp)
lw $8, -96($sp)
lw $9, -84($sp)
sw $8, 0($9)
lw $9, -4($sp)
lw $8, 0($9)
sw $8, -112($sp)
lw $9, -112($sp)
add $8, $9, 0
sw $8, -112($sp)
li $8, 1
sw $8, -116($sp)
lw $9, -20($sp)
lw $8, 0($9)
sw $8, -124($sp)
lw $9, -116($sp)
lw $10, -124($sp)
xor $8, $9, $10
sw $8, -116($sp)
lw $9, -116($sp)
mul $8, $9, 4
sw $8, -120($sp)
lw $9, -112($sp)
lw $10, -120($sp)
add $8, $9, $10
sw $8, -112($sp)
lw $9, -112($sp)
lw $8, 0($9)
sw $8, -112($sp)
lw $8, -112($sp)
beqz $8, label5
lw $9, -4($sp)
lw $8, 0($9)
sw $8, -128($sp)
lw $9, -128($sp)
add $8, $9, 0
sw $8, -128($sp)
li $8, 1
sw $8, -132($sp)
lw $9, -20($sp)
lw $8, 0($9)
sw $8, -140($sp)
lw $9, -132($sp)
lw $10, -140($sp)
xor $8, $9, $10
sw $8, -132($sp)
lw $9, -132($sp)
mul $8, $9, 4
sw $8, -136($sp)
lw $9, -128($sp)
lw $10, -136($sp)
add $8, $9, $10
sw $8, -128($sp)
lw $9, -128($sp)
lw $8, 0($9)
sw $8, -128($sp)
lw $9, -128($sp)
add $8, $9, 8
sw $8, -128($sp)
lw $9, -8($sp)
lw $8, 0($9)
sw $8, -144($sp)
lw $8, -144($sp)
lw $9, -128($sp)
sw $8, 0($9)
label5:
lw $9, -4($sp)
lw $8, 0($9)
sw $8, -148($sp)
lw $9, -148($sp)
add $8, $9, 0
sw $8, -148($sp)
li $8, 1
sw $8, -152($sp)
lw $9, -20($sp)
lw $8, 0($9)
sw $8, -160($sp)
lw $9, -152($sp)
lw $10, -160($sp)
xor $8, $9, $10
sw $8, -152($sp)
lw $9, -152($sp)
mul $8, $9, 4
sw $8, -156($sp)
lw $9, -148($sp)
lw $10, -156($sp)
add $8, $9, $10
sw $8, -148($sp)
lw $9, -8($sp)
lw $8, 0($9)
sw $8, -164($sp)
lw $8, -164($sp)
lw $9, -148($sp)
sw $8, 0($9)
lw $9, -8($sp)
lw $8, 0($9)
sw $8, -168($sp)
lw $9, -168($sp)
add $8, $9, 8
sw $8, -168($sp)
lw $9, -4($sp)
lw $8, 0($9)
sw $8, -172($sp)
lw $8, -172($sp)
lw $9, -168($sp)
sw $8, 0($9)
sw $31, -204($29)
add $8, $29, -208
sw $8, -184($sp)
lw $9, -8($sp)
lw $8, 0($9)
sw $8, -180($sp)
lw $8, -180($sp)
lw $9, -184($sp)
sw $8, 0($9)
add $29, $29, -208
jal __push_up
sub $29, $29, -208
lw $31, -204($29)
lw $9, -4($sp)
lw $8, 0($9)
sw $8, -188($sp)
lw $9, -188($sp)
add $8, $9, 12
sw $8, -188($sp)
lw $9, -8($sp)
lw $8, 0($9)
sw $8, -192($sp)
lw $9, -192($sp)
add $8, $9, 12
sw $8, -192($sp)
lw $9, -192($sp)
lw $8, 0($9)
sw $8, -192($sp)
lw $8, -192($sp)
lw $9, -188($sp)
sw $8, 0($9)
jr $ra
__splay:
add $8, $29, 0
sw $8, -4($sp)
add $8, $29, 4
sw $8, -8($sp)
add $8, $29, -164
sw $8, -16($sp)
lw $9, -16($sp)
move $8, $9
sw $8, -12($sp)
lw $9, -4($sp)
lw $8, 0($9)
sw $8, -20($sp)
lw $9, -20($sp)
li $8, 1
beqz $9, lnot0
li $8, 0
lnot0:
sw $8, -20($sp)
lw $8, -20($sp)
bnez $8, label7
lw $9, -8($sp)
lw $8, 0($9)
sw $8, -24($sp)
lw $9, -24($sp)
li $8, 1
beqz $9, lnot1
li $8, 0
lnot1:
sw $8, -24($sp)
lw $8, -24($sp)
bnez $8, label7
lw $9, -8($sp)
lw $8, 0($9)
sw $8, -28($sp)
lw $9, -4($sp)
lw $8, 0($9)
sw $8, -32($sp)
lw $9, -28($sp)
lw $10, -32($sp)
sub $8, $9, $10
sw $8, -32($sp)
lw $8, -32($sp)
bnez $8, label6
label7:
jr $ra
label6:
lw $9, -12($sp)
move $8, $9
sw $8, -36($sp)
lw $9, -8($sp)
lw $8, 0($9)
sw $8, -40($sp)
lw $9, -40($sp)
add $8, $9, 8
sw $8, -40($sp)
lw $9, -40($sp)
lw $8, 0($9)
sw $8, -40($sp)
lw $8, -40($sp)
lw $9, -36($sp)
sw $8, 0($9)
label8:
lw $9, -4($sp)
lw $8, 0($9)
sw $8, -44($sp)
lw $9, -44($sp)
add $8, $9, 8
sw $8, -44($sp)
lw $9, -44($sp)
lw $8, 0($9)
sw $8, -44($sp)
lw $9, -12($sp)
lw $8, 0($9)
sw $8, -48($sp)
lw $9, -44($sp)
lw $10, -48($sp)
sub $8, $9, $10
sw $8, -48($sp)
lw $8, -48($sp)
beqz $8, label9
lw $9, -4($sp)
lw $8, 0($9)
sw $8, -52($sp)
lw $9, -52($sp)
add $8, $9, 8
sw $8, -52($sp)
lw $9, -52($sp)
lw $8, 0($9)
sw $8, -52($sp)
lw $9, -52($sp)
add $8, $9, 8
sw $8, -52($sp)
lw $9, -52($sp)
lw $8, 0($9)
sw $8, -52($sp)
lw $9, -12($sp)
lw $8, 0($9)
sw $8, -56($sp)
lw $9, -52($sp)
lw $10, -56($sp)
sub $8, $9, $10
sw $8, -56($sp)
lw $8, -56($sp)
bnez $8, label10
sw $31, -168($29)
add $8, $29, -172
sw $8, -68($sp)
lw $9, -4($sp)
lw $8, 0($9)
sw $8, -64($sp)
lw $8, -64($sp)
lw $9, -68($sp)
sw $8, 0($9)
add $29, $29, -172
jal __rotate
sub $29, $29, -172
lw $31, -168($29)
j label11
label10:
sw $31, -172($29)
add $8, $29, -176
sw $8, -80($sp)
lw $9, -4($sp)
lw $8, 0($9)
sw $8, -76($sp)
lw $8, -76($sp)
lw $9, -80($sp)
sw $8, 0($9)
add $29, $29, -176
jal __f
sub $29, $29, -176
lw $31, -172($29)
add $8, $29, -168
sw $8, -84($sp)
lw $9, -84($sp)
lw $8, 0($9)
sw $8, -72($sp)
sw $31, -172($29)
lw $9, -4($sp)
lw $8, 0($9)
sw $8, -92($sp)
lw $9, -92($sp)
add $8, $9, 8
sw $8, -92($sp)
add $8, $29, -176
sw $8, -96($sp)
lw $9, -92($sp)
lw $8, 0($9)
sw $8, -92($sp)
lw $8, -92($sp)
lw $9, -96($sp)
sw $8, 0($9)
add $29, $29, -176
jal __f
sub $29, $29, -176
lw $31, -172($29)
add $8, $29, -168
sw $8, -100($sp)
lw $9, -100($sp)
lw $8, 0($9)
sw $8, -88($sp)
lw $9, -72($sp)
lw $10, -88($sp)
sub $8, $9, $10
sw $8, -88($sp)
lw $8, -88($sp)
bnez $8, label12
sw $31, -168($29)
lw $9, -4($sp)
lw $8, 0($9)
sw $8, -108($sp)
lw $9, -108($sp)
add $8, $9, 8
sw $8, -108($sp)
add $8, $29, -172
sw $8, -112($sp)
lw $9, -108($sp)
lw $8, 0($9)
sw $8, -108($sp)
lw $8, -108($sp)
lw $9, -112($sp)
sw $8, 0($9)
add $29, $29, -172
jal __rotate
sub $29, $29, -172
lw $31, -168($29)
sw $31, -168($29)
add $8, $29, -172
sw $8, -124($sp)
lw $9, -4($sp)
lw $8, 0($9)
sw $8, -120($sp)
lw $8, -120($sp)
lw $9, -124($sp)
sw $8, 0($9)
add $29, $29, -172
jal __rotate
sub $29, $29, -172
lw $31, -168($29)
j label13
label12:
sw $31, -168($29)
add $8, $29, -172
sw $8, -136($sp)
lw $9, -4($sp)
lw $8, 0($9)
sw $8, -132($sp)
lw $8, -132($sp)
lw $9, -136($sp)
sw $8, 0($9)
add $29, $29, -172
jal __rotate
sub $29, $29, -172
lw $31, -168($29)
sw $31, -168($29)
add $8, $29, -172
sw $8, -148($sp)
lw $9, -4($sp)
lw $8, 0($9)
sw $8, -144($sp)
lw $8, -144($sp)
lw $9, -148($sp)
sw $8, 0($9)
add $29, $29, -172
jal __rotate
sub $29, $29, -172
lw $31, -168($29)
label13:
label11:
j label8
label9:
sw $31, -168($29)
add $8, $29, -172
sw $8, -160($sp)
lw $9, -4($sp)
lw $8, 0($9)
sw $8, -156($sp)
lw $8, -156($sp)
lw $9, -160($sp)
sw $8, 0($9)
add $29, $29, -172
jal __push_up
sub $29, $29, -172
lw $31, -168($29)
jr $ra
__find_rt:
add $8, $29, 0
sw $8, -4($sp)
label14:
lw $9, -4($sp)
lw $8, 0($9)
sw $8, -8($sp)
lw $9, -8($sp)
add $8, $9, 8
sw $8, -8($sp)
lw $9, -8($sp)
lw $8, 0($9)
sw $8, -8($sp)
lw $8, -8($sp)
beqz $8, label15
lw $9, -4($sp)
move $8, $9
sw $8, -12($sp)
lw $9, -4($sp)
lw $8, 0($9)
sw $8, -16($sp)
lw $9, -16($sp)
add $8, $9, 8
sw $8, -16($sp)
lw $9, -16($sp)
lw $8, 0($9)
sw $8, -16($sp)
lw $8, -16($sp)
lw $9, -12($sp)
sw $8, 0($9)
j label14
label15:
add $8, $29, 8
sw $8, -24($sp)
lw $9, -4($sp)
lw $8, 0($9)
sw $8, -20($sp)
lw $8, -20($sp)
lw $9, -24($sp)
sw $8, 0($9)
jr $ra
jr $ra
__access:
add $8, $29, 0
sw $8, -4($sp)
add $8, $29, -172
sw $8, -12($sp)
lw $9, -12($sp)
move $8, $9
sw $8, -8($sp)
lw $9, -4($sp)
lw $8, 0($9)
sw $8, -16($sp)
lw $8, -16($sp)
lw $9, -8($sp)
sw $8, 0($9)
lw $9, -4($sp)
move $8, $9
sw $8, -20($sp)
li $8, 0
sw $8, -24($sp)
lw $8, -24($sp)
lw $9, -20($sp)
sw $8, 0($9)
label16:
lw $9, -8($sp)
lw $8, 0($9)
sw $8, -28($sp)
lw $8, -28($sp)
beqz $8, label17
sw $31, -176($29)
sw $31, -188($29)
add $8, $29, -192
sw $8, -44($sp)
lw $9, -8($sp)
lw $8, 0($9)
sw $8, -40($sp)
lw $8, -40($sp)
lw $9, -44($sp)
sw $8, 0($9)
add $29, $29, -192
jal __find_rt
sub $29, $29, -192
lw $31, -188($29)
add $8, $29, -184
sw $8, -48($sp)
add $8, $29, -180
sw $8, -52($sp)
lw $9, -48($sp)
lw $8, 0($9)
sw $8, -36($sp)
lw $8, -36($sp)
lw $9, -52($sp)
sw $8, 0($9)
add $8, $29, -184
sw $8, -60($sp)
lw $9, -8($sp)
lw $8, 0($9)
sw $8, -56($sp)
lw $8, -56($sp)
lw $9, -60($sp)
sw $8, 0($9)
add $29, $29, -184
jal __splay
sub $29, $29, -184
lw $31, -176($29)
lw $9, -8($sp)
lw $8, 0($9)
sw $8, -64($sp)
lw $9, -64($sp)
add $8, $9, 0
sw $8, -64($sp)
li $8, 1
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
beqz $8, label18
lw $9, -8($sp)
lw $8, 0($9)
sw $8, -76($sp)
lw $9, -76($sp)
add $8, $9, 0
sw $8, -76($sp)
li $8, 1
sw $8, -80($sp)
lw $9, -80($sp)
mul $8, $9, 4
sw $8, -84($sp)
lw $9, -76($sp)
lw $10, -84($sp)
add $8, $9, $10
sw $8, -76($sp)
lw $9, -76($sp)
lw $8, 0($9)
sw $8, -76($sp)
lw $9, -76($sp)
add $8, $9, 8
sw $8, -76($sp)
li $8, 0
sw $8, -88($sp)
lw $8, -88($sp)
lw $9, -76($sp)
sw $8, 0($9)
lw $9, -8($sp)
lw $8, 0($9)
sw $8, -92($sp)
lw $9, -92($sp)
add $8, $9, 0
sw $8, -92($sp)
li $8, 1
sw $8, -96($sp)
lw $9, -96($sp)
mul $8, $9, 4
sw $8, -100($sp)
lw $9, -92($sp)
lw $10, -100($sp)
add $8, $9, $10
sw $8, -92($sp)
lw $9, -92($sp)
lw $8, 0($9)
sw $8, -92($sp)
lw $9, -92($sp)
add $8, $9, 12
sw $8, -92($sp)
lw $9, -8($sp)
lw $8, 0($9)
sw $8, -104($sp)
lw $8, -104($sp)
lw $9, -92($sp)
sw $8, 0($9)
label18:
lw $9, -8($sp)
lw $8, 0($9)
sw $8, -108($sp)
lw $9, -108($sp)
add $8, $9, 0
sw $8, -108($sp)
li $8, 1
sw $8, -112($sp)
lw $9, -112($sp)
mul $8, $9, 4
sw $8, -116($sp)
lw $9, -108($sp)
lw $10, -116($sp)
add $8, $9, $10
sw $8, -108($sp)
lw $9, -4($sp)
lw $8, 0($9)
sw $8, -120($sp)
lw $8, -120($sp)
lw $9, -108($sp)
sw $8, 0($9)
lw $9, -4($sp)
lw $8, 0($9)
sw $8, -124($sp)
lw $8, -124($sp)
beqz $8, label19
lw $9, -4($sp)
lw $8, 0($9)
sw $8, -128($sp)
lw $9, -128($sp)
add $8, $9, 8
sw $8, -128($sp)
lw $9, -8($sp)
lw $8, 0($9)
sw $8, -132($sp)
lw $8, -132($sp)
lw $9, -128($sp)
sw $8, 0($9)
lw $9, -4($sp)
lw $8, 0($9)
sw $8, -136($sp)
lw $9, -136($sp)
add $8, $9, 12
sw $8, -136($sp)
li $8, 0
sw $8, -140($sp)
lw $8, -140($sp)
lw $9, -136($sp)
sw $8, 0($9)
label19:
sw $31, -176($29)
add $8, $29, -180
sw $8, -152($sp)
lw $9, -8($sp)
lw $8, 0($9)
sw $8, -148($sp)
lw $8, -148($sp)
lw $9, -152($sp)
sw $8, 0($9)
add $29, $29, -180
jal __push_up
sub $29, $29, -180
lw $31, -176($29)
lw $9, -4($sp)
move $8, $9
sw $8, -156($sp)
lw $9, -8($sp)
lw $8, 0($9)
sw $8, -160($sp)
lw $8, -160($sp)
lw $9, -156($sp)
sw $8, 0($9)
lw $9, -8($sp)
move $8, $9
sw $8, -164($sp)
lw $9, -8($sp)
lw $8, 0($9)
sw $8, -168($sp)
lw $9, -168($sp)
add $8, $9, 12
sw $8, -168($sp)
lw $9, -168($sp)
lw $8, 0($9)
sw $8, -168($sp)
lw $8, -168($sp)
lw $9, -164($sp)
sw $8, 0($9)
j label16
label17:
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
sw $t0, 52($a3)
la $t0, var4
sw $t0, 780($a3)
la $t0, var5
sw $t0, 828($a3)
la $t0, var6
sw $t0, 1444($a3)
lw $9, 780($a3)
move $8, $9
sw $8, 784($a3)
li $8, 1
sw $8, 788($a3)
lw $8, 788($a3)
lw $9, 784($a3)
sw $8, 0($9)
lw $9, 784($a3)
add $8, $9, 4
sw $8, 784($a3)
li $8, 2
sw $8, 792($a3)
lw $8, 792($a3)
lw $9, 784($a3)
sw $8, 0($9)
lw $9, 784($a3)
add $8, $9, 4
sw $8, 784($a3)
li $8, 1
sw $8, 796($a3)
lw $8, 796($a3)
lw $9, 784($a3)
sw $8, 0($9)
lw $9, 784($a3)
add $8, $9, 4
sw $8, 784($a3)
li $8, 2
sw $8, 800($a3)
lw $8, 800($a3)
lw $9, 784($a3)
sw $8, 0($9)
lw $9, 784($a3)
add $8, $9, 4
sw $8, 784($a3)
li $8, 1
sw $8, 804($a3)
lw $8, 804($a3)
lw $9, 784($a3)
sw $8, 0($9)
lw $9, 784($a3)
add $8, $9, 4
sw $8, 784($a3)
li $8, 2
sw $8, 808($a3)
lw $8, 808($a3)
lw $9, 784($a3)
sw $8, 0($9)
lw $9, 784($a3)
add $8, $9, 4
sw $8, 784($a3)
li $8, 1
sw $8, 812($a3)
lw $8, 812($a3)
lw $9, 784($a3)
sw $8, 0($9)
lw $9, 784($a3)
add $8, $9, 4
sw $8, 784($a3)
li $8, 2
sw $8, 816($a3)
lw $8, 816($a3)
lw $9, 784($a3)
sw $8, 0($9)
lw $9, 784($a3)
add $8, $9, 4
sw $8, 784($a3)
li $8, 1
sw $8, 820($a3)
lw $8, 820($a3)
lw $9, 784($a3)
sw $8, 0($9)
lw $9, 784($a3)
add $8, $9, 4
sw $8, 784($a3)
li $8, 2
sw $8, 824($a3)
lw $8, 824($a3)
lw $9, 784($a3)
sw $8, 0($9)
lw $9, 784($a3)
add $8, $9, 4
sw $8, 784($a3)
lw $9, 828($a3)
move $8, $9
sw $8, 832($a3)
lw $9, 832($a3)
move $8, $9
sw $8, 836($a3)
li $8, 1
sw $8, 840($a3)
lw $8, 840($a3)
lw $9, 836($a3)
sw $8, 0($9)
lw $9, 836($a3)
add $8, $9, 4
sw $8, 836($a3)
li $8, 1
sw $8, 844($a3)
lw $8, 844($a3)
lw $9, 836($a3)
sw $8, 0($9)
lw $9, 836($a3)
add $8, $9, 4
sw $8, 836($a3)
lw $9, 832($a3)
add $8, $9, 12
sw $8, 832($a3)
lw $9, 832($a3)
move $8, $9
sw $8, 848($a3)
li $8, 2
sw $8, 852($a3)
lw $8, 852($a3)
lw $9, 848($a3)
sw $8, 0($9)
lw $9, 848($a3)
add $8, $9, 4
sw $8, 848($a3)
li $8, 1
sw $8, 856($a3)
lw $8, 856($a3)
lw $9, 848($a3)
sw $8, 0($9)
lw $9, 848($a3)
add $8, $9, 4
sw $8, 848($a3)
li $8, 1
sw $8, 860($a3)
lw $8, 860($a3)
lw $9, 848($a3)
sw $8, 0($9)
lw $9, 848($a3)
add $8, $9, 4
sw $8, 848($a3)
lw $9, 832($a3)
add $8, $9, 12
sw $8, 832($a3)
lw $9, 832($a3)
move $8, $9
sw $8, 864($a3)
li $8, 1
sw $8, 868($a3)
lw $8, 868($a3)
lw $9, 864($a3)
sw $8, 0($9)
lw $9, 864($a3)
add $8, $9, 4
sw $8, 864($a3)
li $8, 1
sw $8, 872($a3)
lw $8, 872($a3)
lw $9, 864($a3)
sw $8, 0($9)
lw $9, 864($a3)
add $8, $9, 4
sw $8, 864($a3)
lw $9, 832($a3)
add $8, $9, 12
sw $8, 832($a3)
lw $9, 832($a3)
move $8, $9
sw $8, 876($a3)
li $8, 1
sw $8, 880($a3)
lw $8, 880($a3)
lw $9, 876($a3)
sw $8, 0($9)
lw $9, 876($a3)
add $8, $9, 4
sw $8, 876($a3)
li $8, 2
sw $8, 884($a3)
lw $8, 884($a3)
lw $9, 876($a3)
sw $8, 0($9)
lw $9, 876($a3)
add $8, $9, 4
sw $8, 876($a3)
lw $9, 832($a3)
add $8, $9, 12
sw $8, 832($a3)
lw $9, 832($a3)
move $8, $9
sw $8, 888($a3)
li $8, 2
sw $8, 892($a3)
lw $8, 892($a3)
lw $9, 888($a3)
sw $8, 0($9)
lw $9, 888($a3)
add $8, $9, 4
sw $8, 888($a3)
li $8, 5
sw $8, 896($a3)
lw $8, 896($a3)
lw $9, 888($a3)
sw $8, 0($9)
lw $9, 888($a3)
add $8, $9, 4
sw $8, 888($a3)
li $8, 1
sw $8, 900($a3)
lw $8, 900($a3)
lw $9, 888($a3)
sw $8, 0($9)
lw $9, 888($a3)
add $8, $9, 4
sw $8, 888($a3)
lw $9, 832($a3)
add $8, $9, 12
sw $8, 832($a3)
lw $9, 832($a3)
move $8, $9
sw $8, 904($a3)
li $8, 2
sw $8, 908($a3)
lw $8, 908($a3)
lw $9, 904($a3)
sw $8, 0($9)
lw $9, 904($a3)
add $8, $9, 4
sw $8, 904($a3)
li $8, 7
sw $8, 912($a3)
lw $8, 912($a3)
lw $9, 904($a3)
sw $8, 0($9)
lw $9, 904($a3)
add $8, $9, 4
sw $8, 904($a3)
li $8, 1
sw $8, 916($a3)
lw $8, 916($a3)
lw $9, 904($a3)
sw $8, 0($9)
lw $9, 904($a3)
add $8, $9, 4
sw $8, 904($a3)
lw $9, 832($a3)
add $8, $9, 12
sw $8, 832($a3)
lw $9, 832($a3)
move $8, $9
sw $8, 920($a3)
li $8, 2
sw $8, 924($a3)
lw $8, 924($a3)
lw $9, 920($a3)
sw $8, 0($9)
lw $9, 920($a3)
add $8, $9, 4
sw $8, 920($a3)
li $8, 8
sw $8, 928($a3)
lw $8, 928($a3)
lw $9, 920($a3)
sw $8, 0($9)
lw $9, 920($a3)
add $8, $9, 4
sw $8, 920($a3)
li $8, 1
sw $8, 932($a3)
lw $8, 932($a3)
lw $9, 920($a3)
sw $8, 0($9)
lw $9, 920($a3)
add $8, $9, 4
sw $8, 920($a3)
lw $9, 832($a3)
add $8, $9, 12
sw $8, 832($a3)
lw $9, 832($a3)
move $8, $9
sw $8, 936($a3)
li $8, 1
sw $8, 940($a3)
lw $8, 940($a3)
lw $9, 936($a3)
sw $8, 0($9)
lw $9, 936($a3)
add $8, $9, 4
sw $8, 936($a3)
li $8, 3
sw $8, 944($a3)
lw $8, 944($a3)
lw $9, 936($a3)
sw $8, 0($9)
lw $9, 936($a3)
add $8, $9, 4
sw $8, 936($a3)
lw $9, 832($a3)
add $8, $9, 12
sw $8, 832($a3)
lw $9, 832($a3)
move $8, $9
sw $8, 948($a3)
li $8, 1
sw $8, 952($a3)
lw $8, 952($a3)
lw $9, 948($a3)
sw $8, 0($9)
lw $9, 948($a3)
add $8, $9, 4
sw $8, 948($a3)
li $8, 4
sw $8, 956($a3)
lw $8, 956($a3)
lw $9, 948($a3)
sw $8, 0($9)
lw $9, 948($a3)
add $8, $9, 4
sw $8, 948($a3)
lw $9, 832($a3)
add $8, $9, 12
sw $8, 832($a3)
lw $9, 832($a3)
move $8, $9
sw $8, 960($a3)
li $8, 1
sw $8, 964($a3)
lw $8, 964($a3)
lw $9, 960($a3)
sw $8, 0($9)
lw $9, 960($a3)
add $8, $9, 4
sw $8, 960($a3)
li $8, 5
sw $8, 968($a3)
lw $8, 968($a3)
lw $9, 960($a3)
sw $8, 0($9)
lw $9, 960($a3)
add $8, $9, 4
sw $8, 960($a3)
lw $9, 832($a3)
add $8, $9, 12
sw $8, 832($a3)
lw $9, 832($a3)
move $8, $9
sw $8, 972($a3)
li $8, 1
sw $8, 976($a3)
lw $8, 976($a3)
lw $9, 972($a3)
sw $8, 0($9)
lw $9, 972($a3)
add $8, $9, 4
sw $8, 972($a3)
li $8, 6
sw $8, 980($a3)
lw $8, 980($a3)
lw $9, 972($a3)
sw $8, 0($9)
lw $9, 972($a3)
add $8, $9, 4
sw $8, 972($a3)
lw $9, 832($a3)
add $8, $9, 12
sw $8, 832($a3)
lw $9, 832($a3)
move $8, $9
sw $8, 984($a3)
li $8, 1
sw $8, 988($a3)
lw $8, 988($a3)
lw $9, 984($a3)
sw $8, 0($9)
lw $9, 984($a3)
add $8, $9, 4
sw $8, 984($a3)
li $8, 7
sw $8, 992($a3)
lw $8, 992($a3)
lw $9, 984($a3)
sw $8, 0($9)
lw $9, 984($a3)
add $8, $9, 4
sw $8, 984($a3)
lw $9, 832($a3)
add $8, $9, 12
sw $8, 832($a3)
lw $9, 832($a3)
move $8, $9
sw $8, 996($a3)
li $8, 1
sw $8, 1000($a3)
lw $8, 1000($a3)
lw $9, 996($a3)
sw $8, 0($9)
lw $9, 996($a3)
add $8, $9, 4
sw $8, 996($a3)
li $8, 8
sw $8, 1004($a3)
lw $8, 1004($a3)
lw $9, 996($a3)
sw $8, 0($9)
lw $9, 996($a3)
add $8, $9, 4
sw $8, 996($a3)
lw $9, 832($a3)
add $8, $9, 12
sw $8, 832($a3)
lw $9, 832($a3)
move $8, $9
sw $8, 1008($a3)
li $8, 1
sw $8, 1012($a3)
lw $8, 1012($a3)
lw $9, 1008($a3)
sw $8, 0($9)
lw $9, 1008($a3)
add $8, $9, 4
sw $8, 1008($a3)
li $8, 9
sw $8, 1016($a3)
lw $8, 1016($a3)
lw $9, 1008($a3)
sw $8, 0($9)
lw $9, 1008($a3)
add $8, $9, 4
sw $8, 1008($a3)
lw $9, 832($a3)
add $8, $9, 12
sw $8, 832($a3)
lw $9, 832($a3)
move $8, $9
sw $8, 1020($a3)
li $8, 1
sw $8, 1024($a3)
lw $8, 1024($a3)
lw $9, 1020($a3)
sw $8, 0($9)
lw $9, 1020($a3)
add $8, $9, 4
sw $8, 1020($a3)
li $8, 10
sw $8, 1028($a3)
lw $8, 1028($a3)
lw $9, 1020($a3)
sw $8, 0($9)
lw $9, 1020($a3)
add $8, $9, 4
sw $8, 1020($a3)
lw $9, 832($a3)
add $8, $9, 12
sw $8, 832($a3)
add $8, $29, -688
sw $8, -8($sp)
lw $9, -8($sp)
move $8, $9
sw $8, -4($sp)
add $8, $29, -692
sw $8, -16($sp)
lw $9, -16($sp)
move $8, $9
sw $8, -12($sp)
add $8, $29, -696
sw $8, -24($sp)
lw $9, -24($sp)
move $8, $9
sw $8, -20($sp)
add $8, $29, -700
sw $8, -32($sp)
lw $9, -32($sp)
move $8, $9
sw $8, -28($sp)
lw $9, 8($a3)
move $8, $9
sw $8, -36($sp)
li $8, 10
sw $8, -40($sp)
lw $8, -40($sp)
lw $9, -36($sp)
sw $8, 0($9)
lw $9, -8($sp)
move $8, $9
sw $8, -44($sp)
li $8, 1
sw $8, -48($sp)
lw $8, -48($sp)
lw $9, -44($sp)
sw $8, 0($9)
label20:
lw $9, -4($sp)
lw $8, 0($9)
sw $8, -52($sp)
lw $9, 8($a3)
lw $8, 0($9)
sw $8, -56($sp)
li $8, 1
sw $8, -60($sp)
lw $9, -56($sp)
lw $10, -60($sp)
add $8, $9, $10
sw $8, -56($sp)
lw $9, -52($sp)
lw $10, -56($sp)
sub $8, $9, $10
sw $8, -56($sp)
lw $8, -56($sp)
bgtz $8, label21
lw $9, -4($sp)
lw $8, 0($9)
sw $8, -68($sp)
lw $9, -68($sp)
mul $8, $9, 4
sw $8, -72($sp)
lw $9, 52($a3)
lw $10, -72($sp)
add $8, $9, $10
sw $8, -64($sp)
add $29, $29, -708
jal __newNode
sub $29, $29, -708
add $8, $29, -704
sw $8, -80($sp)
lw $9, -80($sp)
lw $8, 0($9)
sw $8, -76($sp)
lw $8, -76($sp)
lw $9, -64($sp)
sw $8, 0($9)
label22:
lw $9, -4($sp)
move $8, $9
sw $8, -88($sp)
lw $9, -4($sp)
lw $8, 0($9)
sw $8, -84($sp)
lw $9, -84($sp)
add $8, $9, 1
sw $8, -92($sp)
lw $8, -92($sp)
lw $9, -88($sp)
sw $8, 0($9)
j label20
label21:
lw $9, -4($sp)
move $8, $9
sw $8, -96($sp)
li $8, 1
sw $8, -100($sp)
lw $8, -100($sp)
lw $9, -96($sp)
sw $8, 0($9)
label23:
lw $9, -4($sp)
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
bgtz $8, label24
lw $9, -12($sp)
move $8, $9
sw $8, -112($sp)
lw $9, -4($sp)
lw $8, 0($9)
sw $8, -120($sp)
li $8, 1
sw $8, -128($sp)
lw $9, -120($sp)
lw $10, -128($sp)
sub $8, $9, $10
sw $8, -120($sp)
lw $9, -120($sp)
mul $8, $9, 4
sw $8, -124($sp)
lw $9, 780($a3)
lw $10, -124($sp)
add $8, $9, $10
sw $8, -116($sp)
lw $9, -116($sp)
lw $8, 0($9)
sw $8, -116($sp)
lw $8, -116($sp)
lw $9, -112($sp)
sw $8, 0($9)
lw $9, -4($sp)
lw $8, 0($9)
sw $8, -136($sp)
lw $9, -136($sp)
mul $8, $9, 4
sw $8, -140($sp)
lw $9, 52($a3)
lw $10, -140($sp)
add $8, $9, $10
sw $8, -132($sp)
lw $9, -132($sp)
lw $8, 0($9)
sw $8, -132($sp)
lw $9, -132($sp)
add $8, $9, 12
sw $8, -132($sp)
lw $9, 8($a3)
lw $8, 0($9)
sw $8, -156($sp)
li $8, 1
sw $8, -160($sp)
lw $9, -156($sp)
lw $10, -160($sp)
add $8, $9, $10
sw $8, -156($sp)
add $8, $29, -712
sw $8, -164($sp)
lw $8, -156($sp)
lw $9, -164($sp)
sw $8, 0($9)
lw $9, -4($sp)
lw $8, 0($9)
sw $8, -168($sp)
lw $9, -12($sp)
lw $8, 0($9)
sw $8, -172($sp)
lw $9, -168($sp)
lw $10, -172($sp)
add $8, $9, $10
sw $8, -168($sp)
add $8, $29, -716
sw $8, -176($sp)
lw $8, -168($sp)
lw $9, -176($sp)
sw $8, 0($9)
add $29, $29, -716
jal __min
sub $29, $29, -716
add $8, $29, -704
sw $8, -180($sp)
lw $9, -180($sp)
lw $8, 0($9)
sw $8, -148($sp)
lw $9, -148($sp)
mul $8, $9, 4
sw $8, -152($sp)
lw $9, 52($a3)
lw $10, -152($sp)
add $8, $9, $10
sw $8, -144($sp)
lw $9, -144($sp)
lw $8, 0($9)
sw $8, -144($sp)
lw $8, -144($sp)
lw $9, -132($sp)
sw $8, 0($9)
lw $9, -4($sp)
lw $8, 0($9)
sw $8, -192($sp)
lw $9, -192($sp)
mul $8, $9, 4
sw $8, -196($sp)
lw $9, 52($a3)
lw $10, -196($sp)
add $8, $9, $10
sw $8, -188($sp)
add $8, $29, -708
sw $8, -200($sp)
lw $9, -188($sp)
lw $8, 0($9)
sw $8, -188($sp)
lw $8, -188($sp)
lw $9, -200($sp)
sw $8, 0($9)
add $29, $29, -708
jal __access
sub $29, $29, -708
label25:
lw $9, -4($sp)
move $8, $9
sw $8, -208($sp)
lw $9, -4($sp)
lw $8, 0($9)
sw $8, -204($sp)
lw $9, -204($sp)
add $8, $9, 1
sw $8, -212($sp)
lw $8, -212($sp)
lw $9, -208($sp)
sw $8, 0($9)
j label23
label24:
lw $9, 12($a3)
move $8, $9
sw $8, -216($sp)
li $8, 14
sw $8, -220($sp)
lw $8, -220($sp)
lw $9, -216($sp)
sw $8, 0($9)
lw $9, -4($sp)
move $8, $9
sw $8, -224($sp)
li $8, 1
sw $8, -228($sp)
lw $8, -228($sp)
lw $9, -224($sp)
sw $8, 0($9)
label26:
lw $9, -4($sp)
lw $8, 0($9)
sw $8, -232($sp)
lw $9, 12($a3)
lw $8, 0($9)
sw $8, -236($sp)
lw $9, -232($sp)
lw $10, -236($sp)
sub $8, $9, $10
sw $8, -236($sp)
lw $8, -236($sp)
bgtz $8, label27
lw $9, -20($sp)
move $8, $9
sw $8, -240($sp)
lw $9, -4($sp)
lw $8, 0($9)
sw $8, -248($sp)
li $8, 1
sw $8, -256($sp)
lw $9, -248($sp)
lw $10, -256($sp)
sub $8, $9, $10
sw $8, -248($sp)
lw $9, -248($sp)
mul $8, $9, 12
sw $8, -252($sp)
lw $9, 828($a3)
lw $10, -252($sp)
add $8, $9, $10
sw $8, -244($sp)
li $8, 0
sw $8, -260($sp)
lw $9, -260($sp)
mul $8, $9, 4
sw $8, -264($sp)
lw $9, -244($sp)
lw $10, -264($sp)
add $8, $9, $10
sw $8, -244($sp)
lw $9, -244($sp)
lw $8, 0($9)
sw $8, -244($sp)
lw $8, -244($sp)
lw $9, -240($sp)
sw $8, 0($9)
lw $9, -12($sp)
move $8, $9
sw $8, -268($sp)
lw $9, -4($sp)
lw $8, 0($9)
sw $8, -276($sp)
li $8, 1
sw $8, -284($sp)
lw $9, -276($sp)
lw $10, -284($sp)
sub $8, $9, $10
sw $8, -276($sp)
lw $9, -276($sp)
mul $8, $9, 12
sw $8, -280($sp)
lw $9, 828($a3)
lw $10, -280($sp)
add $8, $9, $10
sw $8, -272($sp)
li $8, 1
sw $8, -288($sp)
lw $9, -288($sp)
mul $8, $9, 4
sw $8, -292($sp)
lw $9, -272($sp)
lw $10, -292($sp)
add $8, $9, $10
sw $8, -272($sp)
lw $9, -272($sp)
lw $8, 0($9)
sw $8, -272($sp)
lw $8, -272($sp)
lw $9, -268($sp)
sw $8, 0($9)
lw $9, -12($sp)
move $8, $9
sw $8, -300($sp)
lw $9, -12($sp)
lw $8, 0($9)
sw $8, -296($sp)
lw $9, -296($sp)
add $8, $9, 1
sw $8, -304($sp)
lw $8, -304($sp)
lw $9, -300($sp)
sw $8, 0($9)
lw $9, -20($sp)
lw $8, 0($9)
sw $8, -308($sp)
li $8, 1
sw $8, -312($sp)
lw $9, -308($sp)
lw $10, -312($sp)
sub $8, $9, $10
sw $8, -312($sp)
lw $8, -312($sp)
bnez $8, label29
lw $9, -12($sp)
lw $8, 0($9)
sw $8, -324($sp)
lw $9, -324($sp)
mul $8, $9, 4
sw $8, -328($sp)
lw $9, 52($a3)
lw $10, -328($sp)
add $8, $9, $10
sw $8, -320($sp)
add $8, $29, -708
sw $8, -332($sp)
lw $9, -320($sp)
lw $8, 0($9)
sw $8, -320($sp)
lw $8, -320($sp)
lw $9, -332($sp)
sw $8, 0($9)
add $29, $29, -708
jal __access
sub $29, $29, -708
lw $9, -12($sp)
lw $8, 0($9)
sw $8, -348($sp)
lw $9, -348($sp)
mul $8, $9, 4
sw $8, -352($sp)
lw $9, 52($a3)
lw $10, -352($sp)
add $8, $9, $10
sw $8, -344($sp)
add $8, $29, -720
sw $8, -356($sp)
lw $9, -344($sp)
lw $8, 0($9)
sw $8, -344($sp)
lw $8, -344($sp)
lw $9, -356($sp)
sw $8, 0($9)
add $29, $29, -720
jal __find_rt
sub $29, $29, -720
add $8, $29, -712
sw $8, -360($sp)
add $8, $29, -708
sw $8, -364($sp)
lw $9, -360($sp)
lw $8, 0($9)
sw $8, -340($sp)
lw $8, -340($sp)
lw $9, -364($sp)
sw $8, 0($9)
lw $9, -12($sp)
lw $8, 0($9)
sw $8, -372($sp)
lw $9, -372($sp)
mul $8, $9, 4
sw $8, -376($sp)
lw $9, 52($a3)
lw $10, -376($sp)
add $8, $9, $10
sw $8, -368($sp)
add $8, $29, -712
sw $8, -380($sp)
lw $9, -368($sp)
lw $8, 0($9)
sw $8, -368($sp)
lw $8, -368($sp)
lw $9, -380($sp)
sw $8, 0($9)
add $29, $29, -712
jal __splay
sub $29, $29, -712
lw $9, -12($sp)
lw $8, 0($9)
sw $8, -392($sp)
lw $9, -392($sp)
mul $8, $9, 4
sw $8, -396($sp)
lw $9, 52($a3)
lw $10, -396($sp)
add $8, $9, $10
sw $8, -388($sp)
lw $9, -388($sp)
lw $8, 0($9)
sw $8, -388($sp)
lw $9, -388($sp)
add $8, $9, 0
sw $8, -388($sp)
li $8, 0
sw $8, -400($sp)
lw $9, -400($sp)
mul $8, $9, 4
sw $8, -404($sp)
lw $9, -388($sp)
lw $10, -404($sp)
add $8, $9, $10
sw $8, -388($sp)
lw $9, -388($sp)
lw $8, 0($9)
sw $8, -388($sp)
lw $9, -388($sp)
add $8, $9, 16
sw $8, -388($sp)
add $8, $29, -708
sw $8, -408($sp)
lw $9, -388($sp)
lw $8, 0($9)
sw $8, -388($sp)
lw $8, -388($sp)
lw $9, -408($sp)
sw $8, 0($9)
lw $9, 1444($a3)
move $8, $9
sw $8, -412($sp)
add $8, $29, -712
sw $8, -416($sp)
lw $8, -412($sp)
lw $9, -416($sp)
sw $8, 0($9)
add $29, $29, -712
jal __printf
sub $29, $29, -712
j label30
label29:
lw $9, -28($sp)
move $8, $9
sw $8, -420($sp)
lw $9, -4($sp)
lw $8, 0($9)
sw $8, -428($sp)
li $8, 1
sw $8, -436($sp)
lw $9, -428($sp)
lw $10, -436($sp)
sub $8, $9, $10
sw $8, -428($sp)
lw $9, -428($sp)
mul $8, $9, 12
sw $8, -432($sp)
lw $9, 828($a3)
lw $10, -432($sp)
add $8, $9, $10
sw $8, -424($sp)
li $8, 2
sw $8, -440($sp)
lw $9, -440($sp)
mul $8, $9, 4
sw $8, -444($sp)
lw $9, -424($sp)
lw $10, -444($sp)
add $8, $9, $10
sw $8, -424($sp)
lw $9, -424($sp)
lw $8, 0($9)
sw $8, -424($sp)
lw $8, -424($sp)
lw $9, -420($sp)
sw $8, 0($9)
lw $9, -12($sp)
lw $8, 0($9)
sw $8, -456($sp)
lw $9, -456($sp)
mul $8, $9, 4
sw $8, -460($sp)
lw $9, 52($a3)
lw $10, -460($sp)
add $8, $9, $10
sw $8, -452($sp)
add $8, $29, -708
sw $8, -464($sp)
lw $9, -452($sp)
lw $8, 0($9)
sw $8, -452($sp)
lw $8, -452($sp)
lw $9, -464($sp)
sw $8, 0($9)
add $29, $29, -708
jal __access
sub $29, $29, -708
lw $9, -12($sp)
lw $8, 0($9)
sw $8, -480($sp)
lw $9, -480($sp)
mul $8, $9, 4
sw $8, -484($sp)
lw $9, 52($a3)
lw $10, -484($sp)
add $8, $9, $10
sw $8, -476($sp)
add $8, $29, -720
sw $8, -488($sp)
lw $9, -476($sp)
lw $8, 0($9)
sw $8, -476($sp)
lw $8, -476($sp)
lw $9, -488($sp)
sw $8, 0($9)
add $29, $29, -720
jal __find_rt
sub $29, $29, -720
add $8, $29, -712
sw $8, -492($sp)
add $8, $29, -708
sw $8, -496($sp)
lw $9, -492($sp)
lw $8, 0($9)
sw $8, -472($sp)
lw $8, -472($sp)
lw $9, -496($sp)
sw $8, 0($9)
lw $9, -12($sp)
lw $8, 0($9)
sw $8, -504($sp)
lw $9, -504($sp)
mul $8, $9, 4
sw $8, -508($sp)
lw $9, 52($a3)
lw $10, -508($sp)
add $8, $9, $10
sw $8, -500($sp)
add $8, $29, -712
sw $8, -512($sp)
lw $9, -500($sp)
lw $8, 0($9)
sw $8, -500($sp)
lw $8, -500($sp)
lw $9, -512($sp)
sw $8, 0($9)
add $29, $29, -712
jal __splay
sub $29, $29, -712
lw $9, -12($sp)
lw $8, 0($9)
sw $8, -520($sp)
lw $9, -520($sp)
mul $8, $9, 4
sw $8, -524($sp)
lw $9, 52($a3)
lw $10, -524($sp)
add $8, $9, $10
sw $8, -516($sp)
lw $9, -516($sp)
lw $8, 0($9)
sw $8, -516($sp)
lw $9, -516($sp)
add $8, $9, 0
sw $8, -516($sp)
li $8, 0
sw $8, -528($sp)
lw $9, -528($sp)
mul $8, $9, 4
sw $8, -532($sp)
lw $9, -516($sp)
lw $10, -532($sp)
add $8, $9, $10
sw $8, -516($sp)
lw $9, -516($sp)
lw $8, 0($9)
sw $8, -516($sp)
lw $9, -516($sp)
add $8, $9, 8
sw $8, -516($sp)
li $8, 0
sw $8, -536($sp)
lw $8, -536($sp)
lw $9, -516($sp)
sw $8, 0($9)
lw $9, -12($sp)
lw $8, 0($9)
sw $8, -544($sp)
lw $9, -544($sp)
mul $8, $9, 4
sw $8, -548($sp)
lw $9, 52($a3)
lw $10, -548($sp)
add $8, $9, $10
sw $8, -540($sp)
lw $9, -540($sp)
lw $8, 0($9)
sw $8, -540($sp)
lw $9, -540($sp)
add $8, $9, 0
sw $8, -540($sp)
li $8, 0
sw $8, -552($sp)
lw $9, -552($sp)
mul $8, $9, 4
sw $8, -556($sp)
lw $9, -540($sp)
lw $10, -556($sp)
add $8, $9, $10
sw $8, -540($sp)
lw $9, -540($sp)
lw $8, 0($9)
sw $8, -540($sp)
lw $9, -540($sp)
add $8, $9, 12
sw $8, -540($sp)
lw $9, -12($sp)
lw $8, 0($9)
sw $8, -564($sp)
lw $9, -564($sp)
mul $8, $9, 4
sw $8, -568($sp)
lw $9, 52($a3)
lw $10, -568($sp)
add $8, $9, $10
sw $8, -560($sp)
lw $9, -560($sp)
lw $8, 0($9)
sw $8, -560($sp)
lw $9, -560($sp)
add $8, $9, 12
sw $8, -560($sp)
lw $9, -560($sp)
lw $8, 0($9)
sw $8, -560($sp)
lw $8, -560($sp)
lw $9, -540($sp)
sw $8, 0($9)
lw $9, -12($sp)
lw $8, 0($9)
sw $8, -576($sp)
lw $9, -576($sp)
mul $8, $9, 4
sw $8, -580($sp)
lw $9, 52($a3)
lw $10, -580($sp)
add $8, $9, $10
sw $8, -572($sp)
lw $9, -572($sp)
lw $8, 0($9)
sw $8, -572($sp)
lw $9, -572($sp)
add $8, $9, 0
sw $8, -572($sp)
li $8, 0
sw $8, -584($sp)
lw $9, -584($sp)
mul $8, $9, 4
sw $8, -588($sp)
lw $9, -572($sp)
lw $10, -588($sp)
add $8, $9, $10
sw $8, -572($sp)
li $8, 0
sw $8, -592($sp)
lw $8, -592($sp)
lw $9, -572($sp)
sw $8, 0($9)
lw $9, -12($sp)
lw $8, 0($9)
sw $8, -600($sp)
lw $9, -600($sp)
mul $8, $9, 4
sw $8, -604($sp)
lw $9, 52($a3)
lw $10, -604($sp)
add $8, $9, $10
sw $8, -596($sp)
lw $9, -596($sp)
lw $8, 0($9)
sw $8, -596($sp)
lw $9, -596($sp)
add $8, $9, 12
sw $8, -596($sp)
lw $9, 8($a3)
lw $8, 0($9)
sw $8, -620($sp)
li $8, 1
sw $8, -624($sp)
lw $9, -620($sp)
lw $10, -624($sp)
add $8, $9, $10
sw $8, -620($sp)
add $8, $29, -712
sw $8, -628($sp)
lw $8, -620($sp)
lw $9, -628($sp)
sw $8, 0($9)
lw $9, -12($sp)
lw $8, 0($9)
sw $8, -632($sp)
lw $9, -28($sp)
lw $8, 0($9)
sw $8, -636($sp)
lw $9, -632($sp)
lw $10, -636($sp)
add $8, $9, $10
sw $8, -632($sp)
add $8, $29, -716
sw $8, -640($sp)
lw $8, -632($sp)
lw $9, -640($sp)
sw $8, 0($9)
add $29, $29, -716
jal __min
sub $29, $29, -716
add $8, $29, -704
sw $8, -644($sp)
lw $9, -644($sp)
lw $8, 0($9)
sw $8, -612($sp)
lw $9, -612($sp)
mul $8, $9, 4
sw $8, -616($sp)
lw $9, 52($a3)
lw $10, -616($sp)
add $8, $9, $10
sw $8, -608($sp)
lw $9, -608($sp)
lw $8, 0($9)
sw $8, -608($sp)
lw $8, -608($sp)
lw $9, -596($sp)
sw $8, 0($9)
lw $9, -12($sp)
lw $8, 0($9)
sw $8, -656($sp)
lw $9, -656($sp)
mul $8, $9, 4
sw $8, -660($sp)
lw $9, 52($a3)
lw $10, -660($sp)
add $8, $9, $10
sw $8, -652($sp)
add $8, $29, -708
sw $8, -664($sp)
lw $9, -652($sp)
lw $8, 0($9)
sw $8, -652($sp)
lw $8, -652($sp)
lw $9, -664($sp)
sw $8, 0($9)
add $29, $29, -708
jal __access
sub $29, $29, -708
label30:
label28:
lw $9, -4($sp)
move $8, $9
sw $8, -672($sp)
lw $9, -4($sp)
lw $8, 0($9)
sw $8, -668($sp)
lw $9, -668($sp)
add $8, $9, 1
sw $8, -676($sp)
lw $8, -676($sp)
lw $9, -672($sp)
sw $8, 0($9)
j label26
label27:
li $8, 0
sw $8, -680($sp)
add $8, $29, 4
sw $8, -684($sp)
lw $8, -680($sp)
lw $9, -684($sp)
sw $8, 0($9)
j __main_end
j __main_end
__main_end:
li $v0, 10
syscall
#global $2 4
#global $3 4
#global $4 220
#global $13 440
#global $195 200
#global $207 600
#string $361 #%d\n
#move $196 $195
#li $197 1
#sw $197 $196 0
#addi $196 $196 4
#li $198 2
#sw $198 $196 0
#addi $196 $196 4
#li $199 1
#sw $199 $196 0
#addi $196 $196 4
#li $200 2
#sw $200 $196 0
#addi $196 $196 4
#li $201 1
#sw $201 $196 0
#addi $196 $196 4
#li $202 2
#sw $202 $196 0
#addi $196 $196 4
#li $203 1
#sw $203 $196 0
#addi $196 $196 4
#li $204 2
#sw $204 $196 0
#addi $196 $196 4
#li $205 1
#sw $205 $196 0
#addi $196 $196 4
#li $206 2
#sw $206 $196 0
#addi $196 $196 4
#move $208 $207
#move $209 $208
#li $210 1
#sw $210 $209 0
#addi $209 $209 4
#li $211 1
#sw $211 $209 0
#addi $209 $209 4
#addi $208 $208 12
#move $212 $208
#li $213 2
#sw $213 $212 0
#addi $212 $212 4
#li $214 1
#sw $214 $212 0
#addi $212 $212 4
#li $215 1
#sw $215 $212 0
#addi $212 $212 4
#addi $208 $208 12
#move $216 $208
#li $217 1
#sw $217 $216 0
#addi $216 $216 4
#li $218 1
#sw $218 $216 0
#addi $216 $216 4
#addi $208 $208 12
#move $219 $208
#li $220 1
#sw $220 $219 0
#addi $219 $219 4
#li $221 2
#sw $221 $219 0
#addi $219 $219 4
#addi $208 $208 12
#move $222 $208
#li $223 2
#sw $223 $222 0
#addi $222 $222 4
#li $224 5
#sw $224 $222 0
#addi $222 $222 4
#li $225 1
#sw $225 $222 0
#addi $222 $222 4
#addi $208 $208 12
#move $226 $208
#li $227 2
#sw $227 $226 0
#addi $226 $226 4
#li $228 7
#sw $228 $226 0
#addi $226 $226 4
#li $229 1
#sw $229 $226 0
#addi $226 $226 4
#addi $208 $208 12
#move $230 $208
#li $231 2
#sw $231 $230 0
#addi $230 $230 4
#li $232 8
#sw $232 $230 0
#addi $230 $230 4
#li $233 1
#sw $233 $230 0
#addi $230 $230 4
#addi $208 $208 12
#move $234 $208
#li $235 1
#sw $235 $234 0
#addi $234 $234 4
#li $236 3
#sw $236 $234 0
#addi $234 $234 4
#addi $208 $208 12
#move $237 $208
#li $238 1
#sw $238 $237 0
#addi $237 $237 4
#li $239 4
#sw $239 $237 0
#addi $237 $237 4
#addi $208 $208 12
#move $240 $208
#li $241 1
#sw $241 $240 0
#addi $240 $240 4
#li $242 5
#sw $242 $240 0
#addi $240 $240 4
#addi $208 $208 12
#move $243 $208
#li $244 1
#sw $244 $243 0
#addi $243 $243 4
#li $245 6
#sw $245 $243 0
#addi $243 $243 4
#addi $208 $208 12
#move $246 $208
#li $247 1
#sw $247 $246 0
#addi $246 $246 4
#li $248 7
#sw $248 $246 0
#addi $246 $246 4
#addi $208 $208 12
#move $249 $208
#li $250 1
#sw $250 $249 0
#addi $249 $249 4
#li $251 8
#sw $251 $249 0
#addi $249 $249 4
#addi $208 $208 12
#move $252 $208
#li $253 1
#sw $253 $252 0
#addi $252 $252 4
#li $254 9
#sw $254 $252 0
#addi $252 $252 4
#addi $208 $208 12
#move $255 $208
#li $256 1
#sw $256 $255 0
#addi $255 $255 4
#li $257 10
#sw $257 $255 0
#addi $255 $255 4
#addi $208 $208 12
#----------------------------
#func #min
#addi $5 $0 0
#addi $6 $0 4
####move $7 $5
#lw $7 $5 0
####move $8 $6
#lw $8 $6 0
#sub $8 $7 $8
#bgez $8 l:0
####move $9 $5
#addi $10 $0 12
#lw $9 $5 0
#sw $9 $10 0
#return
#label l:0
####move $11 $6
#addi $12 $0 12
#lw $11 $6 0
#sw $11 $12 0
#return
#return
#----------------------------
#func #newNode
#addi $15 $0 -84
####move $14 $15
#move $16 $15
#sw $1 $0 -92
#li $18 20
#addi $19 $0 -96
#sw $18 $19 0
#addi $0 $0 -96
#call #malloc
#subi $0 $0 -96
#lw $1 $0 -92
#addi $20 $0 -88
####move $17 $20
#lw $17 $20 0
#sw $17 $16 0
####move $21 $15
#lw $21 $15 0
#addi $21 $21 0
#li $22 0
#muli $23 $22 4
#add $21 $21 $23
####move $24 $15
#lw $24 $15 0
#addi $24 $24 0
#li $25 1
#muli $26 $25 4
#add $24 $24 $26
####move $27 $15
#lw $27 $15 0
#addi $27 $27 8
####move $28 $15
#lw $28 $15 0
#addi $28 $28 12
#li $29 0
#sw $29 $28 0
#lw $28 $28 0
#sw $28 $27 0
#lw $27 $27 0
#sw $27 $24 0
#lw $24 $24 0
#sw $24 $21 0
####move $30 $15
#lw $30 $15 0
#addi $30 $30 16
#li $31 1
#sw $31 $30 0
####move $32 $15
#addi $33 $0 4
#lw $32 $15 0
#sw $32 $33 0
#return
#return
#----------------------------
#func #f
#addi $34 $0 0
####move $35 $34
#lw $35 $34 0
####move $36 $34
#lw $36 $34 0
#addi $36 $36 8
#lw $36 $36 0
#addi $36 $36 0
#li $37 1
#muli $38 $37 4
#add $36 $36 $38
#lw $36 $36 0
#sub $36 $35 $36
#li $35 1
#beqz $36 l:1
#li $35 0
#label l:1
#addi $39 $0 8
#sw $35 $39 0
#return
#return
#----------------------------
#func #push_up
#addi $40 $0 0
####move $41 $40
#lw $41 $40 0
#addi $41 $41 16
#li $42 1
#sw $42 $41 0
####move $43 $40
#lw $43 $40 0
#addi $43 $43 0
#li $44 0
#muli $45 $44 4
#add $43 $43 $45
#lw $43 $43 0
#beqz $43 l:2
####move $46 $40
#lw $46 $40 0
#addi $46 $46 16
####move $47 $40
#lw $47 $40 0
#addi $47 $47 0
#li $48 0
#muli $49 $48 4
#add $47 $47 $49
#lw $47 $47 0
#addi $47 $47 16
#lw $50 $46 0
#lw $47 $47 0
#add $50 $50 $47
#sw $50 $46 0
#label l:2
####move $51 $40
#lw $51 $40 0
#addi $51 $51 0
#li $52 1
#muli $53 $52 4
#add $51 $51 $53
#lw $51 $51 0
#beqz $51 l:3
####move $54 $40
#lw $54 $40 0
#addi $54 $54 16
####move $55 $40
#lw $55 $40 0
#addi $55 $55 0
#li $56 1
#muli $57 $56 4
#add $55 $55 $57
#lw $55 $55 0
#addi $55 $55 16
#lw $58 $54 0
#lw $55 $55 0
#add $58 $58 $55
#sw $58 $54 0
#label l:3
#return
#----------------------------
#func #rotate
#addi $59 $0 0
#addi $61 $0 -196
#move $60 $61
####move $62 $59
#lw $62 $59 0
#addi $62 $62 8
#lw $62 $62 0
#sw $62 $60 0
#addi $64 $0 -200
#move $63 $64
#sw $1 $0 -208
####move $66 $59
#addi $67 $0 -212
#lw $66 $59 0
#sw $66 $67 0
#addi $0 $0 -212
#call #f
#subi $0 $0 -212
#lw $1 $0 -208
#addi $68 $0 -204
####move $65 $68
#lw $65 $68 0
#sw $65 $63 0
####move $69 $59
#lw $69 $59 0
#addi $69 $69 8
####move $70 $60
#lw $70 $60 0
#addi $70 $70 8
#lw $70 $70 0
#sw $70 $69 0
####move $71 $60
#lw $71 $60 0
#addi $71 $71 8
#lw $71 $71 0
#beqz $71 l:4
####move $72 $60
#lw $72 $60 0
#addi $72 $72 8
#lw $72 $72 0
#addi $72 $72 0
#sw $1 $0 -208
####move $75 $60
#addi $76 $0 -212
#lw $75 $60 0
#sw $75 $76 0
#addi $0 $0 -212
#call #f
#subi $0 $0 -212
#lw $1 $0 -208
#addi $77 $0 -204
####move $73 $77
#lw $73 $77 0
#muli $74 $73 4
#add $72 $72 $74
####move $78 $59
#lw $78 $59 0
#sw $78 $72 0
#label l:4
####move $79 $60
#lw $79 $60 0
#addi $79 $79 0
####move $80 $63
#lw $80 $63 0
#muli $81 $80 4
#add $79 $79 $81
####move $82 $59
#lw $82 $59 0
#addi $82 $82 0
#li $83 1
####move $85 $63
#lw $85 $63 0
#xor $83 $83 $85
#muli $84 $83 4
#add $82 $82 $84
#lw $82 $82 0
#sw $82 $79 0
####move $86 $59
#lw $86 $59 0
#addi $86 $86 0
#li $87 1
####move $89 $63
#lw $89 $63 0
#xor $87 $87 $89
#muli $88 $87 4
#add $86 $86 $88
#lw $86 $86 0
#beqz $86 l:5
####move $90 $59
#lw $90 $59 0
#addi $90 $90 0
#li $91 1
####move $93 $63
#lw $93 $63 0
#xor $91 $91 $93
#muli $92 $91 4
#add $90 $90 $92
#lw $90 $90 0
#addi $90 $90 8
####move $94 $60
#lw $94 $60 0
#sw $94 $90 0
#label l:5
####move $95 $59
#lw $95 $59 0
#addi $95 $95 0
#li $96 1
####move $98 $63
#lw $98 $63 0
#xor $96 $96 $98
#muli $97 $96 4
#add $95 $95 $97
####move $99 $60
#lw $99 $60 0
#sw $99 $95 0
####move $100 $60
#lw $100 $60 0
#addi $100 $100 8
####move $101 $59
#lw $101 $59 0
#sw $101 $100 0
#sw $1 $0 -204
####move $103 $60
#addi $104 $0 -208
#lw $103 $60 0
#sw $103 $104 0
#addi $0 $0 -208
#call #push_up
#subi $0 $0 -208
#lw $1 $0 -204
####move $105 $59
#lw $105 $59 0
#addi $105 $105 12
####move $106 $60
#lw $106 $60 0
#addi $106 $106 12
#lw $106 $106 0
#sw $106 $105 0
#return
#----------------------------
#func #splay
#addi $107 $0 0
#addi $108 $0 4
#addi $110 $0 -164
#move $109 $110
####move $111 $107
#lw $111 $107 0
#lnot $111 $111
#bnez $111 l:7
####move $112 $108
#lw $112 $108 0
#lnot $112 $112
#bnez $112 l:7
####move $113 $108
#lw $113 $108 0
####move $114 $107
#lw $114 $107 0
#sub $114 $113 $114
#bnez $114 l:6
#label l:7
#return
#label l:6
#move $115 $109
####move $116 $108
#lw $116 $108 0
#addi $116 $116 8
#lw $116 $116 0
#sw $116 $115 0
#label l:8
####move $117 $107
#lw $117 $107 0
#addi $117 $117 8
#lw $117 $117 0
####move $118 $109
#lw $118 $109 0
#sub $118 $117 $118
#beqz $118 l:9
####move $119 $107
#lw $119 $107 0
#addi $119 $119 8
#lw $119 $119 0
#addi $119 $119 8
#lw $119 $119 0
####move $120 $109
#lw $120 $109 0
#sub $120 $119 $120
#bnez $120 l:10
#sw $1 $0 -168
####move $122 $107
#addi $123 $0 -172
#lw $122 $107 0
#sw $122 $123 0
#addi $0 $0 -172
#call #rotate
#subi $0 $0 -172
#lw $1 $0 -168
#goto l:11
#label l:10
#sw $1 $0 -172
####move $125 $107
#addi $126 $0 -176
#lw $125 $107 0
#sw $125 $126 0
#addi $0 $0 -176
#call #f
#subi $0 $0 -176
#lw $1 $0 -172
#addi $127 $0 -168
####move $124 $127
#lw $124 $127 0
#sw $1 $0 -172
####move $129 $107
#lw $129 $107 0
#addi $129 $129 8
#addi $130 $0 -176
#lw $129 $129 0
#sw $129 $130 0
#addi $0 $0 -176
#call #f
#subi $0 $0 -176
#lw $1 $0 -172
#addi $131 $0 -168
####move $128 $131
#lw $128 $131 0
#sub $128 $124 $128
#bnez $128 l:12
#sw $1 $0 -168
####move $133 $107
#lw $133 $107 0
#addi $133 $133 8
#addi $134 $0 -172
#lw $133 $133 0
#sw $133 $134 0
#addi $0 $0 -172
#call #rotate
#subi $0 $0 -172
#lw $1 $0 -168
#sw $1 $0 -168
####move $136 $107
#addi $137 $0 -172
#lw $136 $107 0
#sw $136 $137 0
#addi $0 $0 -172
#call #rotate
#subi $0 $0 -172
#lw $1 $0 -168
#goto l:13
#label l:12
#sw $1 $0 -168
####move $139 $107
#addi $140 $0 -172
#lw $139 $107 0
#sw $139 $140 0
#addi $0 $0 -172
#call #rotate
#subi $0 $0 -172
#lw $1 $0 -168
#sw $1 $0 -168
####move $142 $107
#addi $143 $0 -172
#lw $142 $107 0
#sw $142 $143 0
#addi $0 $0 -172
#call #rotate
#subi $0 $0 -172
#lw $1 $0 -168
#label l:13
#label l:11
#goto l:8
#label l:9
#sw $1 $0 -168
####move $145 $107
#addi $146 $0 -172
#lw $145 $107 0
#sw $145 $146 0
#addi $0 $0 -172
#call #push_up
#subi $0 $0 -172
#lw $1 $0 -168
#return
#----------------------------
#func #find_rt
#addi $147 $0 0
#label l:14
####move $148 $147
#lw $148 $147 0
#addi $148 $148 8
#lw $148 $148 0
#beqz $148 l:15
#move $149 $147
####move $150 $147
#lw $150 $147 0
#addi $150 $150 8
#lw $150 $150 0
#sw $150 $149 0
#goto l:14
#label l:15
####move $151 $147
#addi $152 $0 8
#lw $151 $147 0
#sw $151 $152 0
#return
#return
#----------------------------
#func #access
#addi $153 $0 0
#addi $155 $0 -172
#move $154 $155
####move $156 $153
#lw $156 $153 0
#sw $156 $154 0
#move $157 $153
#li $158 0
#sw $158 $157 0
#label l:16
####move $159 $154
#lw $159 $154 0
#beqz $159 l:17
#sw $1 $0 -176
#sw $1 $0 -188
####move $162 $154
#addi $163 $0 -192
#lw $162 $154 0
#sw $162 $163 0
#addi $0 $0 -192
#call #find_rt
#subi $0 $0 -192
#lw $1 $0 -188
#addi $164 $0 -184
####move $161 $164
#addi $165 $0 -180
#lw $161 $164 0
#sw $161 $165 0
####move $166 $154
#addi $167 $0 -184
#lw $166 $154 0
#sw $166 $167 0
#addi $0 $0 -184
#call #splay
#subi $0 $0 -184
#lw $1 $0 -176
####move $168 $154
#lw $168 $154 0
#addi $168 $168 0
#li $169 1
#muli $170 $169 4
#add $168 $168 $170
#lw $168 $168 0
#beqz $168 l:18
####move $171 $154
#lw $171 $154 0
#addi $171 $171 0
#li $172 1
#muli $173 $172 4
#add $171 $171 $173
#lw $171 $171 0
#addi $171 $171 8
#li $174 0
#sw $174 $171 0
####move $175 $154
#lw $175 $154 0
#addi $175 $175 0
#li $176 1
#muli $177 $176 4
#add $175 $175 $177
#lw $175 $175 0
#addi $175 $175 12
####move $178 $154
#lw $178 $154 0
#sw $178 $175 0
#label l:18
####move $179 $154
#lw $179 $154 0
#addi $179 $179 0
#li $180 1
#muli $181 $180 4
#add $179 $179 $181
####move $182 $153
#lw $182 $153 0
#sw $182 $179 0
####move $183 $153
#lw $183 $153 0
#beqz $183 l:19
####move $184 $153
#lw $184 $153 0
#addi $184 $184 8
####move $185 $154
#lw $185 $154 0
#sw $185 $184 0
####move $186 $153
#lw $186 $153 0
#addi $186 $186 12
#li $187 0
#sw $187 $186 0
#label l:19
#sw $1 $0 -176
####move $189 $154
#addi $190 $0 -180
#lw $189 $154 0
#sw $189 $190 0
#addi $0 $0 -180
#call #push_up
#subi $0 $0 -180
#lw $1 $0 -176
#move $191 $153
####move $192 $154
#lw $192 $154 0
#sw $192 $191 0
#move $193 $154
####move $194 $154
#lw $194 $154 0
#addi $194 $194 12
#lw $194 $194 0
#sw $194 $193 0
#goto l:16
#label l:17
#return
#----------------------------
#func #main
#addi $259 $0 -688
#move $258 $259
#addi $261 $0 -692
#move $260 $261
#addi $263 $0 -696
#move $262 $263
#addi $265 $0 -700
#move $264 $265
#move $266 $2
#li $267 10
#sw $267 $266 0
#move $268 $259
#li $269 1
#sw $269 $268 0
#label l:20
####move $270 $258
#lw $270 $258 0
####move $271 $2
#lw $271 $2 0
#li $272 1
#add $271 $271 $272
#sub $271 $270 $271
#bgtz $271 l:21
####move $273 $13
####move $274 $258
#lw $274 $258 0
#muli $275 $274 4
#add $273 $13 $275
#addi $0 $0 -708
#call #newNode
#subi $0 $0 -708
#addi $277 $0 -704
####move $276 $277
#lw $276 $277 0
#sw $276 $273 0
#label l:22
####move $278 $258
#move $279 $258
#lw $278 $258 0
#addi $280 $278 1
#sw $280 $279 0
#goto l:20
#label l:21
#move $281 $258
#li $282 1
#sw $282 $281 0
#label l:23
####move $283 $258
#lw $283 $258 0
####move $284 $2
#lw $284 $2 0
#sub $284 $283 $284
#bgtz $284 l:24
#move $285 $260
####move $286 $195
####move $287 $258
#lw $287 $258 0
#li $289 1
#sub $287 $287 $289
#muli $288 $287 4
#add $286 $195 $288
#lw $286 $286 0
#sw $286 $285 0
####move $290 $13
####move $291 $258
#lw $291 $258 0
#muli $292 $291 4
#add $290 $13 $292
#lw $290 $290 0
#addi $290 $290 12
####move $293 $13
####move $296 $2
#lw $296 $2 0
#li $297 1
#add $296 $296 $297
#addi $298 $0 -712
#sw $296 $298 0
####move $299 $258
#lw $299 $258 0
####move $300 $260
#lw $300 $260 0
#add $299 $299 $300
#addi $301 $0 -716
#sw $299 $301 0
#addi $0 $0 -716
#call #min
#subi $0 $0 -716
#addi $302 $0 -704
####move $294 $302
#lw $294 $302 0
#muli $295 $294 4
#add $293 $13 $295
#lw $293 $293 0
#sw $293 $290 0
####move $304 $13
####move $305 $258
#lw $305 $258 0
#muli $306 $305 4
#add $304 $13 $306
#addi $307 $0 -708
#lw $304 $304 0
#sw $304 $307 0
#addi $0 $0 -708
#call #access
#subi $0 $0 -708
#label l:25
####move $308 $258
#move $309 $258
#lw $308 $258 0
#addi $310 $308 1
#sw $310 $309 0
#goto l:23
#label l:24
#move $311 $3
#li $312 14
#sw $312 $311 0
#move $313 $258
#li $314 1
#sw $314 $313 0
#label l:26
####move $315 $258
#lw $315 $258 0
####move $316 $3
#lw $316 $3 0
#sub $316 $315 $316
#bgtz $316 l:27
#move $317 $262
####move $318 $207
####move $319 $258
#lw $319 $258 0
#li $321 1
#sub $319 $319 $321
#muli $320 $319 12
#add $318 $207 $320
#li $322 0
#muli $323 $322 4
#add $318 $318 $323
#lw $318 $318 0
#sw $318 $317 0
#move $324 $260
####move $325 $207
####move $326 $258
#lw $326 $258 0
#li $328 1
#sub $326 $326 $328
#muli $327 $326 12
#add $325 $207 $327
#li $329 1
#muli $330 $329 4
#add $325 $325 $330
#lw $325 $325 0
#sw $325 $324 0
####move $331 $260
#move $332 $260
#lw $331 $260 0
#addi $333 $331 1
#sw $333 $332 0
####move $334 $262
#lw $334 $262 0
#li $335 1
#sub $335 $334 $335
#bnez $335 l:29
####move $337 $13
####move $338 $260
#lw $338 $260 0
#muli $339 $338 4
#add $337 $13 $339
#addi $340 $0 -708
#lw $337 $337 0
#sw $337 $340 0
#addi $0 $0 -708
#call #access
#subi $0 $0 -708
####move $343 $13
####move $344 $260
#lw $344 $260 0
#muli $345 $344 4
#add $343 $13 $345
#addi $346 $0 -720
#lw $343 $343 0
#sw $343 $346 0
#addi $0 $0 -720
#call #find_rt
#subi $0 $0 -720
#addi $347 $0 -712
####move $342 $347
#addi $348 $0 -708
#lw $342 $347 0
#sw $342 $348 0
####move $349 $13
####move $350 $260
#lw $350 $260 0
#muli $351 $350 4
#add $349 $13 $351
#addi $352 $0 -712
#lw $349 $349 0
#sw $349 $352 0
#addi $0 $0 -712
#call #splay
#subi $0 $0 -712
####move $354 $13
####move $355 $260
#lw $355 $260 0
#muli $356 $355 4
#add $354 $13 $356
#lw $354 $354 0
#addi $354 $354 0
#li $357 0
#muli $358 $357 4
#add $354 $354 $358
#lw $354 $354 0
#addi $354 $354 16
#addi $359 $0 -708
#lw $354 $354 0
#sw $354 $359 0
#move $360 $361
#addi $362 $0 -712
#sw $360 $362 0
#addi $0 $0 -712
#call #printf
#subi $0 $0 -712
#goto l:30
#label l:29
#move $363 $264
####move $364 $207
####move $365 $258
#lw $365 $258 0
#li $367 1
#sub $365 $365 $367
#muli $366 $365 12
#add $364 $207 $366
#li $368 2
#muli $369 $368 4
#add $364 $364 $369
#lw $364 $364 0
#sw $364 $363 0
####move $371 $13
####move $372 $260
#lw $372 $260 0
#muli $373 $372 4
#add $371 $13 $373
#addi $374 $0 -708
#lw $371 $371 0
#sw $371 $374 0
#addi $0 $0 -708
#call #access
#subi $0 $0 -708
####move $377 $13
####move $378 $260
#lw $378 $260 0
#muli $379 $378 4
#add $377 $13 $379
#addi $380 $0 -720
#lw $377 $377 0
#sw $377 $380 0
#addi $0 $0 -720
#call #find_rt
#subi $0 $0 -720
#addi $381 $0 -712
####move $376 $381
#addi $382 $0 -708
#lw $376 $381 0
#sw $376 $382 0
####move $383 $13
####move $384 $260
#lw $384 $260 0
#muli $385 $384 4
#add $383 $13 $385
#addi $386 $0 -712
#lw $383 $383 0
#sw $383 $386 0
#addi $0 $0 -712
#call #splay
#subi $0 $0 -712
####move $387 $13
####move $388 $260
#lw $388 $260 0
#muli $389 $388 4
#add $387 $13 $389
#lw $387 $387 0
#addi $387 $387 0
#li $390 0
#muli $391 $390 4
#add $387 $387 $391
#lw $387 $387 0
#addi $387 $387 8
#li $392 0
#sw $392 $387 0
####move $393 $13
####move $394 $260
#lw $394 $260 0
#muli $395 $394 4
#add $393 $13 $395
#lw $393 $393 0
#addi $393 $393 0
#li $396 0
#muli $397 $396 4
#add $393 $393 $397
#lw $393 $393 0
#addi $393 $393 12
####move $398 $13
####move $399 $260
#lw $399 $260 0
#muli $400 $399 4
#add $398 $13 $400
#lw $398 $398 0
#addi $398 $398 12
#lw $398 $398 0
#sw $398 $393 0
####move $401 $13
####move $402 $260
#lw $402 $260 0
#muli $403 $402 4
#add $401 $13 $403
#lw $401 $401 0
#addi $401 $401 0
#li $404 0
#muli $405 $404 4
#add $401 $401 $405
#li $406 0
#sw $406 $401 0
####move $407 $13
####move $408 $260
#lw $408 $260 0
#muli $409 $408 4
#add $407 $13 $409
#lw $407 $407 0
#addi $407 $407 12
####move $410 $13
####move $413 $2
#lw $413 $2 0
#li $414 1
#add $413 $413 $414
#addi $415 $0 -712
#sw $413 $415 0
####move $416 $260
#lw $416 $260 0
####move $417 $264
#lw $417 $264 0
#add $416 $416 $417
#addi $418 $0 -716
#sw $416 $418 0
#addi $0 $0 -716
#call #min
#subi $0 $0 -716
#addi $419 $0 -704
####move $411 $419
#lw $411 $419 0
#muli $412 $411 4
#add $410 $13 $412
#lw $410 $410 0
#sw $410 $407 0
####move $421 $13
####move $422 $260
#lw $422 $260 0
#muli $423 $422 4
#add $421 $13 $423
#addi $424 $0 -708
#lw $421 $421 0
#sw $421 $424 0
#addi $0 $0 -708
#call #access
#subi $0 $0 -708
#label l:30
#label l:28
####move $425 $258
#move $426 $258
#lw $425 $258 0
#addi $427 $425 1
#sw $427 $426 0
#goto l:26
#label l:27
#li $428 0
#addi $429 $0 4
#sw $428 $429 0
#return
#return
