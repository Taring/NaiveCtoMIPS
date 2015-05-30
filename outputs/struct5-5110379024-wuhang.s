.data
temp: .space 1620
var0: .space 4
var1: .space 4
var2: .space 560
var3: .asciiz "%d\t"
.align 2
var4: .asciiz "\n"
.align 2
var5: .asciiz "%c %c %d, %d\n"
.align 2
var6: .asciiz "%d "
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

__comp1:
add $8, $29, 0
sw $8, -4($sp)
add $8, $29, 4
sw $8, -8($sp)
lw $9, -4($sp)
add $8, $9, 0
sw $8, -12($sp)
lw $9, -12($sp)
lw $8, 0($9)
sw $8, -12($sp)
lw $9, -8($sp)
add $8, $9, 0
sw $8, -16($sp)
lw $9, -16($sp)
lw $8, 0($9)
sw $8, -16($sp)
lw $9, -12($sp)
lw $10, -16($sp)
sub $8, $9, $10
sw $8, -16($sp)
lw $8, -16($sp)
beqz $8, label0
li $8, 0
sw $8, -20($sp)
add $8, $29, 12
sw $8, -24($sp)
lw $8, -20($sp)
lw $9, -24($sp)
sw $8, 0($9)
jr $ra
j label1
label0:
li $8, 1
sw $8, -28($sp)
add $8, $29, 12
sw $8, -32($sp)
lw $8, -28($sp)
lw $9, -32($sp)
sw $8, 0($9)
jr $ra
label1:
jr $ra
__compare:
add $8, $29, 0
sw $8, -4($sp)
add $8, $29, 112
sw $8, -8($sp)
add $8, $29, -228
sw $8, -16($sp)
lw $9, -16($sp)
move $8, $9
sw $8, -12($sp)
add $8, $29, -232
sw $8, -24($sp)
lw $9, -24($sp)
move $8, $9
sw $8, -20($sp)
li $8, 0
sw $8, -28($sp)
lw $8, -28($sp)
lw $9, -20($sp)
sw $8, 0($9)
lw $9, -16($sp)
move $8, $9
sw $8, -32($sp)
li $8, 0
sw $8, -36($sp)
lw $8, -36($sp)
lw $9, -32($sp)
sw $8, 0($9)
label2:
lw $9, -12($sp)
lw $8, 0($9)
sw $8, -40($sp)
lw $9, 8($a3)
lw $8, 0($9)
sw $8, -44($sp)
lw $9, -40($sp)
lw $10, -44($sp)
sub $8, $9, $10
sw $8, -44($sp)
lw $8, -44($sp)
bgez $8, label3
lw $9, -20($sp)
move $8, $9
sw $8, -48($sp)
li $8, 0
sw $8, -52($sp)
lw $8, -52($sp)
lw $9, -48($sp)
sw $8, 0($9)
label5:
lw $9, -20($sp)
lw $8, 0($9)
sw $8, -56($sp)
lw $9, 8($a3)
lw $8, 0($9)
sw $8, -60($sp)
lw $9, -56($sp)
lw $10, -60($sp)
sub $8, $9, $10
sw $8, -60($sp)
lw $8, -60($sp)
bgez $8, label6
lw $9, -4($sp)
add $8, $9, 0
sw $8, -64($sp)
lw $9, -12($sp)
lw $8, 0($9)
sw $8, -68($sp)
lw $9, -68($sp)
mul $8, $9, 20
sw $8, -72($sp)
lw $9, -64($sp)
lw $10, -72($sp)
add $8, $9, $10
sw $8, -64($sp)
lw $9, -20($sp)
lw $8, 0($9)
sw $8, -76($sp)
lw $9, -76($sp)
mul $8, $9, 4
sw $8, -80($sp)
lw $9, -64($sp)
lw $10, -80($sp)
add $8, $9, $10
sw $8, -64($sp)
lw $9, -64($sp)
lw $8, 0($9)
sw $8, -64($sp)
lw $9, -8($sp)
add $8, $9, 0
sw $8, -84($sp)
lw $9, -12($sp)
lw $8, 0($9)
sw $8, -88($sp)
lw $9, -88($sp)
mul $8, $9, 20
sw $8, -92($sp)
lw $9, -84($sp)
lw $10, -92($sp)
add $8, $9, $10
sw $8, -84($sp)
lw $9, -20($sp)
lw $8, 0($9)
sw $8, -96($sp)
lw $9, -96($sp)
mul $8, $9, 4
sw $8, -100($sp)
lw $9, -84($sp)
lw $10, -100($sp)
add $8, $9, $10
sw $8, -84($sp)
lw $9, -84($sp)
lw $8, 0($9)
sw $8, -84($sp)
lw $9, -64($sp)
lw $10, -84($sp)
sub $8, $9, $10
sw $8, -84($sp)
lw $8, -84($sp)
beqz $8, label8
li $8, 0
sw $8, -104($sp)
add $8, $29, 228
sw $8, -108($sp)
lw $8, -104($sp)
lw $9, -108($sp)
sw $8, 0($9)
jr $ra
label8:
label7:
lw $9, -20($sp)
move $8, $9
sw $8, -116($sp)
lw $9, -20($sp)
lw $8, 0($9)
sw $8, -112($sp)
lw $9, -112($sp)
add $8, $9, 1
sw $8, -112($sp)
lw $8, -112($sp)
lw $9, -116($sp)
sw $8, 0($9)
j label5
label6:
label4:
lw $9, -12($sp)
move $8, $9
sw $8, -124($sp)
lw $9, -12($sp)
lw $8, 0($9)
sw $8, -120($sp)
lw $9, -120($sp)
add $8, $9, 1
sw $8, -120($sp)
lw $8, -120($sp)
lw $9, -124($sp)
sw $8, 0($9)
j label2
label3:
lw $9, -4($sp)
add $8, $9, 100
sw $8, -128($sp)
li $8, 0
sw $8, -132($sp)
lw $9, -132($sp)
mul $8, $9, 1
sw $8, -136($sp)
lw $9, -128($sp)
lw $10, -136($sp)
add $8, $9, $10
sw $8, -128($sp)
lw $9, -128($sp)
lb $8, 0($9)
sw $8, -128($sp)
lw $9, -8($sp)
add $8, $9, 100
sw $8, -140($sp)
li $8, 0
sw $8, -144($sp)
lw $9, -144($sp)
mul $8, $9, 1
sw $8, -148($sp)
lw $9, -140($sp)
lw $10, -148($sp)
add $8, $9, $10
sw $8, -140($sp)
lw $9, -140($sp)
lb $8, 0($9)
sw $8, -140($sp)
lw $9, -128($sp)
lw $10, -140($sp)
sub $8, $9, $10
sw $8, -140($sp)
lw $8, -140($sp)
beqz $8, label9
li $8, 0
sw $8, -152($sp)
add $8, $29, 228
sw $8, -156($sp)
lw $8, -152($sp)
lw $9, -156($sp)
sw $8, 0($9)
jr $ra
j label10
label9:
lw $9, -4($sp)
add $8, $9, 100
sw $8, -160($sp)
li $8, 1
sw $8, -164($sp)
lw $9, -164($sp)
mul $8, $9, 1
sw $8, -168($sp)
lw $9, -160($sp)
lw $10, -168($sp)
add $8, $9, $10
sw $8, -160($sp)
lw $9, -160($sp)
lb $8, 0($9)
sw $8, -160($sp)
lw $9, -8($sp)
add $8, $9, 100
sw $8, -172($sp)
li $8, 1
sw $8, -176($sp)
lw $9, -176($sp)
mul $8, $9, 1
sw $8, -180($sp)
lw $9, -172($sp)
lw $10, -180($sp)
add $8, $9, $10
sw $8, -172($sp)
lw $9, -172($sp)
lb $8, 0($9)
sw $8, -172($sp)
lw $9, -160($sp)
lw $10, -172($sp)
sub $8, $9, $10
sw $8, -172($sp)
lw $8, -172($sp)
beqz $8, label11
li $8, 0
sw $8, -184($sp)
add $8, $29, 228
sw $8, -188($sp)
lw $8, -184($sp)
lw $9, -188($sp)
sw $8, 0($9)
jr $ra
j label12
label11:
sw $31, -240($29)
lw $9, -8($sp)
add $8, $9, 108
sw $8, -196($sp)
add $8, $29, -244
sw $8, -200($sp)
lw $9, -196($sp)
lw $8, 0($9)
sw $8, -196($sp)
lw $8, -196($sp)
lw $9, -200($sp)
sw $8, 0($9)
lw $9, -4($sp)
add $8, $9, 108
sw $8, -204($sp)
add $8, $29, -248
sw $8, -208($sp)
lw $9, -204($sp)
lw $8, 0($9)
sw $8, -204($sp)
lw $8, -204($sp)
lw $9, -208($sp)
sw $8, 0($9)
add $29, $29, -248
jal __comp1
sub $29, $29, -248
lw $31, -240($29)
add $8, $29, -236
sw $8, -212($sp)
add $8, $29, 228
sw $8, -216($sp)
lw $9, -212($sp)
lw $8, 0($9)
sw $8, -192($sp)
lw $8, -192($sp)
lw $9, -216($sp)
sw $8, 0($9)
jr $ra
label12:
label10:
li $8, -1
sw $8, -220($sp)
add $8, $29, 228
sw $8, -224($sp)
lw $8, -220($sp)
lw $9, -224($sp)
sw $8, 0($9)
jr $ra
jr $ra
__getNode:
add $8, $29, 0
sw $8, -4($sp)
lw $9, -4($sp)
lw $8, 0($9)
sw $8, -12($sp)
lw $9, -12($sp)
mul $8, $9, 112
sw $8, -16($sp)
lw $9, 24($a3)
lw $10, -16($sp)
add $8, $9, $10
sw $8, -8($sp)
lw $9, -8($sp)
add $8, $9, 104
sw $8, -8($sp)
lw $9, -8($sp)
move $8, $9
sw $8, -20($sp)
lw $9, -8($sp)
lw $8, 0($9)
sw $8, -8($sp)
lw $9, -8($sp)
add $8, $9, 1
sw $8, -24($sp)
lw $8, -24($sp)
lw $9, -20($sp)
sw $8, 0($9)
lw $9, -4($sp)
lw $8, 0($9)
sw $8, -32($sp)
lw $9, -32($sp)
mul $8, $9, 112
sw $8, -36($sp)
lw $9, 24($a3)
lw $10, -36($sp)
add $8, $9, $10
sw $8, -28($sp)
add $8, $29, 8
sw $8, -40($sp)
lw $9, -40($sp)
move $8, $9
sw $8, -44($sp)
lw $9, -28($sp)
lw $8, 0($9)
sw $8, -52($sp)
lw $8, -52($sp)
lw $9, -44($sp)
sw $8, 0($9)
lw $9, -44($sp)
add $8, $9, 4
sw $8, -44($sp)
lw $9, -28($sp)
add $8, $9, 4
sw $8, -48($sp)
lw $9, -48($sp)
lw $8, 0($9)
sw $8, -52($sp)
lw $8, -52($sp)
lw $9, -44($sp)
sw $8, 0($9)
lw $9, -44($sp)
add $8, $9, 4
sw $8, -44($sp)
lw $9, -48($sp)
add $8, $9, 4
sw $8, -48($sp)
lw $9, -48($sp)
lw $8, 0($9)
sw $8, -52($sp)
lw $8, -52($sp)
lw $9, -44($sp)
sw $8, 0($9)
lw $9, -44($sp)
add $8, $9, 4
sw $8, -44($sp)
lw $9, -48($sp)
add $8, $9, 4
sw $8, -48($sp)
lw $9, -48($sp)
lw $8, 0($9)
sw $8, -52($sp)
lw $8, -52($sp)
lw $9, -44($sp)
sw $8, 0($9)
lw $9, -44($sp)
add $8, $9, 4
sw $8, -44($sp)
lw $9, -48($sp)
add $8, $9, 4
sw $8, -48($sp)
lw $9, -48($sp)
lw $8, 0($9)
sw $8, -52($sp)
lw $8, -52($sp)
lw $9, -44($sp)
sw $8, 0($9)
lw $9, -44($sp)
add $8, $9, 4
sw $8, -44($sp)
lw $9, -48($sp)
add $8, $9, 4
sw $8, -48($sp)
lw $9, -48($sp)
lw $8, 0($9)
sw $8, -52($sp)
lw $8, -52($sp)
lw $9, -44($sp)
sw $8, 0($9)
lw $9, -44($sp)
add $8, $9, 4
sw $8, -44($sp)
lw $9, -48($sp)
add $8, $9, 4
sw $8, -48($sp)
lw $9, -48($sp)
lw $8, 0($9)
sw $8, -52($sp)
lw $8, -52($sp)
lw $9, -44($sp)
sw $8, 0($9)
lw $9, -44($sp)
add $8, $9, 4
sw $8, -44($sp)
lw $9, -48($sp)
add $8, $9, 4
sw $8, -48($sp)
lw $9, -48($sp)
lw $8, 0($9)
sw $8, -52($sp)
lw $8, -52($sp)
lw $9, -44($sp)
sw $8, 0($9)
lw $9, -44($sp)
add $8, $9, 4
sw $8, -44($sp)
lw $9, -48($sp)
add $8, $9, 4
sw $8, -48($sp)
lw $9, -48($sp)
lw $8, 0($9)
sw $8, -52($sp)
lw $8, -52($sp)
lw $9, -44($sp)
sw $8, 0($9)
lw $9, -44($sp)
add $8, $9, 4
sw $8, -44($sp)
lw $9, -48($sp)
add $8, $9, 4
sw $8, -48($sp)
lw $9, -48($sp)
lw $8, 0($9)
sw $8, -52($sp)
lw $8, -52($sp)
lw $9, -44($sp)
sw $8, 0($9)
lw $9, -44($sp)
add $8, $9, 4
sw $8, -44($sp)
lw $9, -48($sp)
add $8, $9, 4
sw $8, -48($sp)
lw $9, -48($sp)
lw $8, 0($9)
sw $8, -52($sp)
lw $8, -52($sp)
lw $9, -44($sp)
sw $8, 0($9)
lw $9, -44($sp)
add $8, $9, 4
sw $8, -44($sp)
lw $9, -48($sp)
add $8, $9, 4
sw $8, -48($sp)
lw $9, -48($sp)
lw $8, 0($9)
sw $8, -52($sp)
lw $8, -52($sp)
lw $9, -44($sp)
sw $8, 0($9)
lw $9, -44($sp)
add $8, $9, 4
sw $8, -44($sp)
lw $9, -48($sp)
add $8, $9, 4
sw $8, -48($sp)
lw $9, -48($sp)
lw $8, 0($9)
sw $8, -52($sp)
lw $8, -52($sp)
lw $9, -44($sp)
sw $8, 0($9)
lw $9, -44($sp)
add $8, $9, 4
sw $8, -44($sp)
lw $9, -48($sp)
add $8, $9, 4
sw $8, -48($sp)
lw $9, -48($sp)
lw $8, 0($9)
sw $8, -52($sp)
lw $8, -52($sp)
lw $9, -44($sp)
sw $8, 0($9)
lw $9, -44($sp)
add $8, $9, 4
sw $8, -44($sp)
lw $9, -48($sp)
add $8, $9, 4
sw $8, -48($sp)
lw $9, -48($sp)
lw $8, 0($9)
sw $8, -52($sp)
lw $8, -52($sp)
lw $9, -44($sp)
sw $8, 0($9)
lw $9, -44($sp)
add $8, $9, 4
sw $8, -44($sp)
lw $9, -48($sp)
add $8, $9, 4
sw $8, -48($sp)
lw $9, -48($sp)
lw $8, 0($9)
sw $8, -52($sp)
lw $8, -52($sp)
lw $9, -44($sp)
sw $8, 0($9)
lw $9, -44($sp)
add $8, $9, 4
sw $8, -44($sp)
lw $9, -48($sp)
add $8, $9, 4
sw $8, -48($sp)
lw $9, -48($sp)
lw $8, 0($9)
sw $8, -52($sp)
lw $8, -52($sp)
lw $9, -44($sp)
sw $8, 0($9)
lw $9, -44($sp)
add $8, $9, 4
sw $8, -44($sp)
lw $9, -48($sp)
add $8, $9, 4
sw $8, -48($sp)
lw $9, -48($sp)
lw $8, 0($9)
sw $8, -52($sp)
lw $8, -52($sp)
lw $9, -44($sp)
sw $8, 0($9)
lw $9, -44($sp)
add $8, $9, 4
sw $8, -44($sp)
lw $9, -48($sp)
add $8, $9, 4
sw $8, -48($sp)
lw $9, -48($sp)
lw $8, 0($9)
sw $8, -52($sp)
lw $8, -52($sp)
lw $9, -44($sp)
sw $8, 0($9)
lw $9, -44($sp)
add $8, $9, 4
sw $8, -44($sp)
lw $9, -48($sp)
add $8, $9, 4
sw $8, -48($sp)
lw $9, -48($sp)
lw $8, 0($9)
sw $8, -52($sp)
lw $8, -52($sp)
lw $9, -44($sp)
sw $8, 0($9)
lw $9, -44($sp)
add $8, $9, 4
sw $8, -44($sp)
lw $9, -48($sp)
add $8, $9, 4
sw $8, -48($sp)
lw $9, -48($sp)
lw $8, 0($9)
sw $8, -52($sp)
lw $8, -52($sp)
lw $9, -44($sp)
sw $8, 0($9)
lw $9, -44($sp)
add $8, $9, 4
sw $8, -44($sp)
lw $9, -48($sp)
add $8, $9, 4
sw $8, -48($sp)
lw $9, -48($sp)
lw $8, 0($9)
sw $8, -52($sp)
lw $8, -52($sp)
lw $9, -44($sp)
sw $8, 0($9)
lw $9, -44($sp)
add $8, $9, 4
sw $8, -44($sp)
lw $9, -48($sp)
add $8, $9, 4
sw $8, -48($sp)
lw $9, -48($sp)
lw $8, 0($9)
sw $8, -52($sp)
lw $8, -52($sp)
lw $9, -44($sp)
sw $8, 0($9)
lw $9, -44($sp)
add $8, $9, 4
sw $8, -44($sp)
lw $9, -48($sp)
add $8, $9, 4
sw $8, -48($sp)
lw $9, -48($sp)
lw $8, 0($9)
sw $8, -52($sp)
lw $8, -52($sp)
lw $9, -44($sp)
sw $8, 0($9)
lw $9, -44($sp)
add $8, $9, 4
sw $8, -44($sp)
lw $9, -48($sp)
add $8, $9, 4
sw $8, -48($sp)
lw $9, -48($sp)
lw $8, 0($9)
sw $8, -52($sp)
lw $8, -52($sp)
lw $9, -44($sp)
sw $8, 0($9)
lw $9, -44($sp)
add $8, $9, 4
sw $8, -44($sp)
lw $9, -48($sp)
add $8, $9, 4
sw $8, -48($sp)
lw $9, -48($sp)
lw $8, 0($9)
sw $8, -52($sp)
lw $8, -52($sp)
lw $9, -44($sp)
sw $8, 0($9)
lw $9, -44($sp)
add $8, $9, 4
sw $8, -44($sp)
lw $9, -48($sp)
add $8, $9, 4
sw $8, -48($sp)
lw $9, -48($sp)
lw $8, 0($9)
sw $8, -52($sp)
lw $8, -52($sp)
lw $9, -44($sp)
sw $8, 0($9)
lw $9, -44($sp)
add $8, $9, 4
sw $8, -44($sp)
lw $9, -48($sp)
add $8, $9, 4
sw $8, -48($sp)
lw $9, -48($sp)
lw $8, 0($9)
sw $8, -52($sp)
lw $8, -52($sp)
lw $9, -44($sp)
sw $8, 0($9)
lw $9, -44($sp)
add $8, $9, 4
sw $8, -44($sp)
lw $9, -48($sp)
add $8, $9, 4
sw $8, -48($sp)
jr $ra
jr $ra
__exchange:
add $8, $29, 0
sw $8, -4($sp)
add $8, $29, 4
sw $8, -8($sp)
add $8, $29, -184
sw $8, -16($sp)
lw $9, -4($sp)
lw $8, 0($9)
sw $8, -20($sp)
lw $9, -16($sp)
move $8, $9
sw $8, -24($sp)
lw $9, -20($sp)
lw $8, 0($9)
sw $8, -32($sp)
lw $8, -32($sp)
lw $9, -24($sp)
sw $8, 0($9)
lw $9, -24($sp)
add $8, $9, 4
sw $8, -24($sp)
lw $9, -20($sp)
add $8, $9, 4
sw $8, -28($sp)
lw $9, -28($sp)
lw $8, 0($9)
sw $8, -32($sp)
lw $8, -32($sp)
lw $9, -24($sp)
sw $8, 0($9)
lw $9, -24($sp)
add $8, $9, 4
sw $8, -24($sp)
lw $9, -28($sp)
add $8, $9, 4
sw $8, -28($sp)
lw $9, -28($sp)
lw $8, 0($9)
sw $8, -32($sp)
lw $8, -32($sp)
lw $9, -24($sp)
sw $8, 0($9)
lw $9, -24($sp)
add $8, $9, 4
sw $8, -24($sp)
lw $9, -28($sp)
add $8, $9, 4
sw $8, -28($sp)
lw $9, -28($sp)
lw $8, 0($9)
sw $8, -32($sp)
lw $8, -32($sp)
lw $9, -24($sp)
sw $8, 0($9)
lw $9, -24($sp)
add $8, $9, 4
sw $8, -24($sp)
lw $9, -28($sp)
add $8, $9, 4
sw $8, -28($sp)
lw $9, -28($sp)
lw $8, 0($9)
sw $8, -32($sp)
lw $8, -32($sp)
lw $9, -24($sp)
sw $8, 0($9)
lw $9, -24($sp)
add $8, $9, 4
sw $8, -24($sp)
lw $9, -28($sp)
add $8, $9, 4
sw $8, -28($sp)
lw $9, -28($sp)
lw $8, 0($9)
sw $8, -32($sp)
lw $8, -32($sp)
lw $9, -24($sp)
sw $8, 0($9)
lw $9, -24($sp)
add $8, $9, 4
sw $8, -24($sp)
lw $9, -28($sp)
add $8, $9, 4
sw $8, -28($sp)
lw $9, -28($sp)
lw $8, 0($9)
sw $8, -32($sp)
lw $8, -32($sp)
lw $9, -24($sp)
sw $8, 0($9)
lw $9, -24($sp)
add $8, $9, 4
sw $8, -24($sp)
lw $9, -28($sp)
add $8, $9, 4
sw $8, -28($sp)
lw $9, -28($sp)
lw $8, 0($9)
sw $8, -32($sp)
lw $8, -32($sp)
lw $9, -24($sp)
sw $8, 0($9)
lw $9, -24($sp)
add $8, $9, 4
sw $8, -24($sp)
lw $9, -28($sp)
add $8, $9, 4
sw $8, -28($sp)
lw $9, -28($sp)
lw $8, 0($9)
sw $8, -32($sp)
lw $8, -32($sp)
lw $9, -24($sp)
sw $8, 0($9)
lw $9, -24($sp)
add $8, $9, 4
sw $8, -24($sp)
lw $9, -28($sp)
add $8, $9, 4
sw $8, -28($sp)
lw $9, -28($sp)
lw $8, 0($9)
sw $8, -32($sp)
lw $8, -32($sp)
lw $9, -24($sp)
sw $8, 0($9)
lw $9, -24($sp)
add $8, $9, 4
sw $8, -24($sp)
lw $9, -28($sp)
add $8, $9, 4
sw $8, -28($sp)
lw $9, -28($sp)
lw $8, 0($9)
sw $8, -32($sp)
lw $8, -32($sp)
lw $9, -24($sp)
sw $8, 0($9)
lw $9, -24($sp)
add $8, $9, 4
sw $8, -24($sp)
lw $9, -28($sp)
add $8, $9, 4
sw $8, -28($sp)
lw $9, -28($sp)
lw $8, 0($9)
sw $8, -32($sp)
lw $8, -32($sp)
lw $9, -24($sp)
sw $8, 0($9)
lw $9, -24($sp)
add $8, $9, 4
sw $8, -24($sp)
lw $9, -28($sp)
add $8, $9, 4
sw $8, -28($sp)
lw $9, -28($sp)
lw $8, 0($9)
sw $8, -32($sp)
lw $8, -32($sp)
lw $9, -24($sp)
sw $8, 0($9)
lw $9, -24($sp)
add $8, $9, 4
sw $8, -24($sp)
lw $9, -28($sp)
add $8, $9, 4
sw $8, -28($sp)
lw $9, -28($sp)
lw $8, 0($9)
sw $8, -32($sp)
lw $8, -32($sp)
lw $9, -24($sp)
sw $8, 0($9)
lw $9, -24($sp)
add $8, $9, 4
sw $8, -24($sp)
lw $9, -28($sp)
add $8, $9, 4
sw $8, -28($sp)
lw $9, -28($sp)
lw $8, 0($9)
sw $8, -32($sp)
lw $8, -32($sp)
lw $9, -24($sp)
sw $8, 0($9)
lw $9, -24($sp)
add $8, $9, 4
sw $8, -24($sp)
lw $9, -28($sp)
add $8, $9, 4
sw $8, -28($sp)
lw $9, -28($sp)
lw $8, 0($9)
sw $8, -32($sp)
lw $8, -32($sp)
lw $9, -24($sp)
sw $8, 0($9)
lw $9, -24($sp)
add $8, $9, 4
sw $8, -24($sp)
lw $9, -28($sp)
add $8, $9, 4
sw $8, -28($sp)
lw $9, -28($sp)
lw $8, 0($9)
sw $8, -32($sp)
lw $8, -32($sp)
lw $9, -24($sp)
sw $8, 0($9)
lw $9, -24($sp)
add $8, $9, 4
sw $8, -24($sp)
lw $9, -28($sp)
add $8, $9, 4
sw $8, -28($sp)
lw $9, -28($sp)
lw $8, 0($9)
sw $8, -32($sp)
lw $8, -32($sp)
lw $9, -24($sp)
sw $8, 0($9)
lw $9, -24($sp)
add $8, $9, 4
sw $8, -24($sp)
lw $9, -28($sp)
add $8, $9, 4
sw $8, -28($sp)
lw $9, -28($sp)
lw $8, 0($9)
sw $8, -32($sp)
lw $8, -32($sp)
lw $9, -24($sp)
sw $8, 0($9)
lw $9, -24($sp)
add $8, $9, 4
sw $8, -24($sp)
lw $9, -28($sp)
add $8, $9, 4
sw $8, -28($sp)
lw $9, -28($sp)
lw $8, 0($9)
sw $8, -32($sp)
lw $8, -32($sp)
lw $9, -24($sp)
sw $8, 0($9)
lw $9, -24($sp)
add $8, $9, 4
sw $8, -24($sp)
lw $9, -28($sp)
add $8, $9, 4
sw $8, -28($sp)
lw $9, -28($sp)
lw $8, 0($9)
sw $8, -32($sp)
lw $8, -32($sp)
lw $9, -24($sp)
sw $8, 0($9)
lw $9, -24($sp)
add $8, $9, 4
sw $8, -24($sp)
lw $9, -28($sp)
add $8, $9, 4
sw $8, -28($sp)
lw $9, -28($sp)
lw $8, 0($9)
sw $8, -32($sp)
lw $8, -32($sp)
lw $9, -24($sp)
sw $8, 0($9)
lw $9, -24($sp)
add $8, $9, 4
sw $8, -24($sp)
lw $9, -28($sp)
add $8, $9, 4
sw $8, -28($sp)
lw $9, -28($sp)
lw $8, 0($9)
sw $8, -32($sp)
lw $8, -32($sp)
lw $9, -24($sp)
sw $8, 0($9)
lw $9, -24($sp)
add $8, $9, 4
sw $8, -24($sp)
lw $9, -28($sp)
add $8, $9, 4
sw $8, -28($sp)
lw $9, -28($sp)
lw $8, 0($9)
sw $8, -32($sp)
lw $8, -32($sp)
lw $9, -24($sp)
sw $8, 0($9)
lw $9, -24($sp)
add $8, $9, 4
sw $8, -24($sp)
lw $9, -28($sp)
add $8, $9, 4
sw $8, -28($sp)
lw $9, -28($sp)
lw $8, 0($9)
sw $8, -32($sp)
lw $8, -32($sp)
lw $9, -24($sp)
sw $8, 0($9)
lw $9, -24($sp)
add $8, $9, 4
sw $8, -24($sp)
lw $9, -28($sp)
add $8, $9, 4
sw $8, -28($sp)
lw $9, -28($sp)
lw $8, 0($9)
sw $8, -32($sp)
lw $8, -32($sp)
lw $9, -24($sp)
sw $8, 0($9)
lw $9, -24($sp)
add $8, $9, 4
sw $8, -24($sp)
lw $9, -28($sp)
add $8, $9, 4
sw $8, -28($sp)
lw $9, -28($sp)
lw $8, 0($9)
sw $8, -32($sp)
lw $8, -32($sp)
lw $9, -24($sp)
sw $8, 0($9)
lw $9, -24($sp)
add $8, $9, 4
sw $8, -24($sp)
lw $9, -28($sp)
add $8, $9, 4
sw $8, -28($sp)
lw $9, -28($sp)
lw $8, 0($9)
sw $8, -32($sp)
lw $8, -32($sp)
lw $9, -24($sp)
sw $8, 0($9)
lw $9, -24($sp)
add $8, $9, 4
sw $8, -24($sp)
lw $9, -28($sp)
add $8, $9, 4
sw $8, -28($sp)
lw $9, -4($sp)
lw $8, 0($9)
sw $8, -36($sp)
lw $9, -8($sp)
lw $8, 0($9)
sw $8, -40($sp)
lw $9, -36($sp)
move $8, $9
sw $8, -44($sp)
lw $9, -40($sp)
lw $8, 0($9)
sw $8, -52($sp)
lw $8, -52($sp)
lw $9, -44($sp)
sw $8, 0($9)
lw $9, -44($sp)
add $8, $9, 4
sw $8, -44($sp)
lw $9, -40($sp)
add $8, $9, 4
sw $8, -48($sp)
lw $9, -48($sp)
lw $8, 0($9)
sw $8, -52($sp)
lw $8, -52($sp)
lw $9, -44($sp)
sw $8, 0($9)
lw $9, -44($sp)
add $8, $9, 4
sw $8, -44($sp)
lw $9, -48($sp)
add $8, $9, 4
sw $8, -48($sp)
lw $9, -48($sp)
lw $8, 0($9)
sw $8, -52($sp)
lw $8, -52($sp)
lw $9, -44($sp)
sw $8, 0($9)
lw $9, -44($sp)
add $8, $9, 4
sw $8, -44($sp)
lw $9, -48($sp)
add $8, $9, 4
sw $8, -48($sp)
lw $9, -48($sp)
lw $8, 0($9)
sw $8, -52($sp)
lw $8, -52($sp)
lw $9, -44($sp)
sw $8, 0($9)
lw $9, -44($sp)
add $8, $9, 4
sw $8, -44($sp)
lw $9, -48($sp)
add $8, $9, 4
sw $8, -48($sp)
lw $9, -48($sp)
lw $8, 0($9)
sw $8, -52($sp)
lw $8, -52($sp)
lw $9, -44($sp)
sw $8, 0($9)
lw $9, -44($sp)
add $8, $9, 4
sw $8, -44($sp)
lw $9, -48($sp)
add $8, $9, 4
sw $8, -48($sp)
lw $9, -48($sp)
lw $8, 0($9)
sw $8, -52($sp)
lw $8, -52($sp)
lw $9, -44($sp)
sw $8, 0($9)
lw $9, -44($sp)
add $8, $9, 4
sw $8, -44($sp)
lw $9, -48($sp)
add $8, $9, 4
sw $8, -48($sp)
lw $9, -48($sp)
lw $8, 0($9)
sw $8, -52($sp)
lw $8, -52($sp)
lw $9, -44($sp)
sw $8, 0($9)
lw $9, -44($sp)
add $8, $9, 4
sw $8, -44($sp)
lw $9, -48($sp)
add $8, $9, 4
sw $8, -48($sp)
lw $9, -48($sp)
lw $8, 0($9)
sw $8, -52($sp)
lw $8, -52($sp)
lw $9, -44($sp)
sw $8, 0($9)
lw $9, -44($sp)
add $8, $9, 4
sw $8, -44($sp)
lw $9, -48($sp)
add $8, $9, 4
sw $8, -48($sp)
lw $9, -48($sp)
lw $8, 0($9)
sw $8, -52($sp)
lw $8, -52($sp)
lw $9, -44($sp)
sw $8, 0($9)
lw $9, -44($sp)
add $8, $9, 4
sw $8, -44($sp)
lw $9, -48($sp)
add $8, $9, 4
sw $8, -48($sp)
lw $9, -48($sp)
lw $8, 0($9)
sw $8, -52($sp)
lw $8, -52($sp)
lw $9, -44($sp)
sw $8, 0($9)
lw $9, -44($sp)
add $8, $9, 4
sw $8, -44($sp)
lw $9, -48($sp)
add $8, $9, 4
sw $8, -48($sp)
lw $9, -48($sp)
lw $8, 0($9)
sw $8, -52($sp)
lw $8, -52($sp)
lw $9, -44($sp)
sw $8, 0($9)
lw $9, -44($sp)
add $8, $9, 4
sw $8, -44($sp)
lw $9, -48($sp)
add $8, $9, 4
sw $8, -48($sp)
lw $9, -48($sp)
lw $8, 0($9)
sw $8, -52($sp)
lw $8, -52($sp)
lw $9, -44($sp)
sw $8, 0($9)
lw $9, -44($sp)
add $8, $9, 4
sw $8, -44($sp)
lw $9, -48($sp)
add $8, $9, 4
sw $8, -48($sp)
lw $9, -48($sp)
lw $8, 0($9)
sw $8, -52($sp)
lw $8, -52($sp)
lw $9, -44($sp)
sw $8, 0($9)
lw $9, -44($sp)
add $8, $9, 4
sw $8, -44($sp)
lw $9, -48($sp)
add $8, $9, 4
sw $8, -48($sp)
lw $9, -48($sp)
lw $8, 0($9)
sw $8, -52($sp)
lw $8, -52($sp)
lw $9, -44($sp)
sw $8, 0($9)
lw $9, -44($sp)
add $8, $9, 4
sw $8, -44($sp)
lw $9, -48($sp)
add $8, $9, 4
sw $8, -48($sp)
lw $9, -48($sp)
lw $8, 0($9)
sw $8, -52($sp)
lw $8, -52($sp)
lw $9, -44($sp)
sw $8, 0($9)
lw $9, -44($sp)
add $8, $9, 4
sw $8, -44($sp)
lw $9, -48($sp)
add $8, $9, 4
sw $8, -48($sp)
lw $9, -48($sp)
lw $8, 0($9)
sw $8, -52($sp)
lw $8, -52($sp)
lw $9, -44($sp)
sw $8, 0($9)
lw $9, -44($sp)
add $8, $9, 4
sw $8, -44($sp)
lw $9, -48($sp)
add $8, $9, 4
sw $8, -48($sp)
lw $9, -48($sp)
lw $8, 0($9)
sw $8, -52($sp)
lw $8, -52($sp)
lw $9, -44($sp)
sw $8, 0($9)
lw $9, -44($sp)
add $8, $9, 4
sw $8, -44($sp)
lw $9, -48($sp)
add $8, $9, 4
sw $8, -48($sp)
lw $9, -48($sp)
lw $8, 0($9)
sw $8, -52($sp)
lw $8, -52($sp)
lw $9, -44($sp)
sw $8, 0($9)
lw $9, -44($sp)
add $8, $9, 4
sw $8, -44($sp)
lw $9, -48($sp)
add $8, $9, 4
sw $8, -48($sp)
lw $9, -48($sp)
lw $8, 0($9)
sw $8, -52($sp)
lw $8, -52($sp)
lw $9, -44($sp)
sw $8, 0($9)
lw $9, -44($sp)
add $8, $9, 4
sw $8, -44($sp)
lw $9, -48($sp)
add $8, $9, 4
sw $8, -48($sp)
lw $9, -48($sp)
lw $8, 0($9)
sw $8, -52($sp)
lw $8, -52($sp)
lw $9, -44($sp)
sw $8, 0($9)
lw $9, -44($sp)
add $8, $9, 4
sw $8, -44($sp)
lw $9, -48($sp)
add $8, $9, 4
sw $8, -48($sp)
lw $9, -48($sp)
lw $8, 0($9)
sw $8, -52($sp)
lw $8, -52($sp)
lw $9, -44($sp)
sw $8, 0($9)
lw $9, -44($sp)
add $8, $9, 4
sw $8, -44($sp)
lw $9, -48($sp)
add $8, $9, 4
sw $8, -48($sp)
lw $9, -48($sp)
lw $8, 0($9)
sw $8, -52($sp)
lw $8, -52($sp)
lw $9, -44($sp)
sw $8, 0($9)
lw $9, -44($sp)
add $8, $9, 4
sw $8, -44($sp)
lw $9, -48($sp)
add $8, $9, 4
sw $8, -48($sp)
lw $9, -48($sp)
lw $8, 0($9)
sw $8, -52($sp)
lw $8, -52($sp)
lw $9, -44($sp)
sw $8, 0($9)
lw $9, -44($sp)
add $8, $9, 4
sw $8, -44($sp)
lw $9, -48($sp)
add $8, $9, 4
sw $8, -48($sp)
lw $9, -48($sp)
lw $8, 0($9)
sw $8, -52($sp)
lw $8, -52($sp)
lw $9, -44($sp)
sw $8, 0($9)
lw $9, -44($sp)
add $8, $9, 4
sw $8, -44($sp)
lw $9, -48($sp)
add $8, $9, 4
sw $8, -48($sp)
lw $9, -48($sp)
lw $8, 0($9)
sw $8, -52($sp)
lw $8, -52($sp)
lw $9, -44($sp)
sw $8, 0($9)
lw $9, -44($sp)
add $8, $9, 4
sw $8, -44($sp)
lw $9, -48($sp)
add $8, $9, 4
sw $8, -48($sp)
lw $9, -48($sp)
lw $8, 0($9)
sw $8, -52($sp)
lw $8, -52($sp)
lw $9, -44($sp)
sw $8, 0($9)
lw $9, -44($sp)
add $8, $9, 4
sw $8, -44($sp)
lw $9, -48($sp)
add $8, $9, 4
sw $8, -48($sp)
lw $9, -48($sp)
lw $8, 0($9)
sw $8, -52($sp)
lw $8, -52($sp)
lw $9, -44($sp)
sw $8, 0($9)
lw $9, -44($sp)
add $8, $9, 4
sw $8, -44($sp)
lw $9, -48($sp)
add $8, $9, 4
sw $8, -48($sp)
lw $9, -48($sp)
lw $8, 0($9)
sw $8, -52($sp)
lw $8, -52($sp)
lw $9, -44($sp)
sw $8, 0($9)
lw $9, -44($sp)
add $8, $9, 4
sw $8, -44($sp)
lw $9, -48($sp)
add $8, $9, 4
sw $8, -48($sp)
lw $9, -8($sp)
lw $8, 0($9)
sw $8, -56($sp)
lw $9, -56($sp)
move $8, $9
sw $8, -64($sp)
lw $9, -16($sp)
lw $8, 0($9)
sw $8, -72($sp)
lw $8, -72($sp)
lw $9, -64($sp)
sw $8, 0($9)
lw $9, -64($sp)
add $8, $9, 4
sw $8, -64($sp)
lw $9, -16($sp)
add $8, $9, 4
sw $8, -68($sp)
lw $9, -68($sp)
lw $8, 0($9)
sw $8, -72($sp)
lw $8, -72($sp)
lw $9, -64($sp)
sw $8, 0($9)
lw $9, -64($sp)
add $8, $9, 4
sw $8, -64($sp)
lw $9, -68($sp)
add $8, $9, 4
sw $8, -68($sp)
lw $9, -68($sp)
lw $8, 0($9)
sw $8, -72($sp)
lw $8, -72($sp)
lw $9, -64($sp)
sw $8, 0($9)
lw $9, -64($sp)
add $8, $9, 4
sw $8, -64($sp)
lw $9, -68($sp)
add $8, $9, 4
sw $8, -68($sp)
lw $9, -68($sp)
lw $8, 0($9)
sw $8, -72($sp)
lw $8, -72($sp)
lw $9, -64($sp)
sw $8, 0($9)
lw $9, -64($sp)
add $8, $9, 4
sw $8, -64($sp)
lw $9, -68($sp)
add $8, $9, 4
sw $8, -68($sp)
lw $9, -68($sp)
lw $8, 0($9)
sw $8, -72($sp)
lw $8, -72($sp)
lw $9, -64($sp)
sw $8, 0($9)
lw $9, -64($sp)
add $8, $9, 4
sw $8, -64($sp)
lw $9, -68($sp)
add $8, $9, 4
sw $8, -68($sp)
lw $9, -68($sp)
lw $8, 0($9)
sw $8, -72($sp)
lw $8, -72($sp)
lw $9, -64($sp)
sw $8, 0($9)
lw $9, -64($sp)
add $8, $9, 4
sw $8, -64($sp)
lw $9, -68($sp)
add $8, $9, 4
sw $8, -68($sp)
lw $9, -68($sp)
lw $8, 0($9)
sw $8, -72($sp)
lw $8, -72($sp)
lw $9, -64($sp)
sw $8, 0($9)
lw $9, -64($sp)
add $8, $9, 4
sw $8, -64($sp)
lw $9, -68($sp)
add $8, $9, 4
sw $8, -68($sp)
lw $9, -68($sp)
lw $8, 0($9)
sw $8, -72($sp)
lw $8, -72($sp)
lw $9, -64($sp)
sw $8, 0($9)
lw $9, -64($sp)
add $8, $9, 4
sw $8, -64($sp)
lw $9, -68($sp)
add $8, $9, 4
sw $8, -68($sp)
lw $9, -68($sp)
lw $8, 0($9)
sw $8, -72($sp)
lw $8, -72($sp)
lw $9, -64($sp)
sw $8, 0($9)
lw $9, -64($sp)
add $8, $9, 4
sw $8, -64($sp)
lw $9, -68($sp)
add $8, $9, 4
sw $8, -68($sp)
lw $9, -68($sp)
lw $8, 0($9)
sw $8, -72($sp)
lw $8, -72($sp)
lw $9, -64($sp)
sw $8, 0($9)
lw $9, -64($sp)
add $8, $9, 4
sw $8, -64($sp)
lw $9, -68($sp)
add $8, $9, 4
sw $8, -68($sp)
lw $9, -68($sp)
lw $8, 0($9)
sw $8, -72($sp)
lw $8, -72($sp)
lw $9, -64($sp)
sw $8, 0($9)
lw $9, -64($sp)
add $8, $9, 4
sw $8, -64($sp)
lw $9, -68($sp)
add $8, $9, 4
sw $8, -68($sp)
lw $9, -68($sp)
lw $8, 0($9)
sw $8, -72($sp)
lw $8, -72($sp)
lw $9, -64($sp)
sw $8, 0($9)
lw $9, -64($sp)
add $8, $9, 4
sw $8, -64($sp)
lw $9, -68($sp)
add $8, $9, 4
sw $8, -68($sp)
lw $9, -68($sp)
lw $8, 0($9)
sw $8, -72($sp)
lw $8, -72($sp)
lw $9, -64($sp)
sw $8, 0($9)
lw $9, -64($sp)
add $8, $9, 4
sw $8, -64($sp)
lw $9, -68($sp)
add $8, $9, 4
sw $8, -68($sp)
lw $9, -68($sp)
lw $8, 0($9)
sw $8, -72($sp)
lw $8, -72($sp)
lw $9, -64($sp)
sw $8, 0($9)
lw $9, -64($sp)
add $8, $9, 4
sw $8, -64($sp)
lw $9, -68($sp)
add $8, $9, 4
sw $8, -68($sp)
lw $9, -68($sp)
lw $8, 0($9)
sw $8, -72($sp)
lw $8, -72($sp)
lw $9, -64($sp)
sw $8, 0($9)
lw $9, -64($sp)
add $8, $9, 4
sw $8, -64($sp)
lw $9, -68($sp)
add $8, $9, 4
sw $8, -68($sp)
lw $9, -68($sp)
lw $8, 0($9)
sw $8, -72($sp)
lw $8, -72($sp)
lw $9, -64($sp)
sw $8, 0($9)
lw $9, -64($sp)
add $8, $9, 4
sw $8, -64($sp)
lw $9, -68($sp)
add $8, $9, 4
sw $8, -68($sp)
lw $9, -68($sp)
lw $8, 0($9)
sw $8, -72($sp)
lw $8, -72($sp)
lw $9, -64($sp)
sw $8, 0($9)
lw $9, -64($sp)
add $8, $9, 4
sw $8, -64($sp)
lw $9, -68($sp)
add $8, $9, 4
sw $8, -68($sp)
lw $9, -68($sp)
lw $8, 0($9)
sw $8, -72($sp)
lw $8, -72($sp)
lw $9, -64($sp)
sw $8, 0($9)
lw $9, -64($sp)
add $8, $9, 4
sw $8, -64($sp)
lw $9, -68($sp)
add $8, $9, 4
sw $8, -68($sp)
lw $9, -68($sp)
lw $8, 0($9)
sw $8, -72($sp)
lw $8, -72($sp)
lw $9, -64($sp)
sw $8, 0($9)
lw $9, -64($sp)
add $8, $9, 4
sw $8, -64($sp)
lw $9, -68($sp)
add $8, $9, 4
sw $8, -68($sp)
lw $9, -68($sp)
lw $8, 0($9)
sw $8, -72($sp)
lw $8, -72($sp)
lw $9, -64($sp)
sw $8, 0($9)
lw $9, -64($sp)
add $8, $9, 4
sw $8, -64($sp)
lw $9, -68($sp)
add $8, $9, 4
sw $8, -68($sp)
lw $9, -68($sp)
lw $8, 0($9)
sw $8, -72($sp)
lw $8, -72($sp)
lw $9, -64($sp)
sw $8, 0($9)
lw $9, -64($sp)
add $8, $9, 4
sw $8, -64($sp)
lw $9, -68($sp)
add $8, $9, 4
sw $8, -68($sp)
lw $9, -68($sp)
lw $8, 0($9)
sw $8, -72($sp)
lw $8, -72($sp)
lw $9, -64($sp)
sw $8, 0($9)
lw $9, -64($sp)
add $8, $9, 4
sw $8, -64($sp)
lw $9, -68($sp)
add $8, $9, 4
sw $8, -68($sp)
lw $9, -68($sp)
lw $8, 0($9)
sw $8, -72($sp)
lw $8, -72($sp)
lw $9, -64($sp)
sw $8, 0($9)
lw $9, -64($sp)
add $8, $9, 4
sw $8, -64($sp)
lw $9, -68($sp)
add $8, $9, 4
sw $8, -68($sp)
lw $9, -68($sp)
lw $8, 0($9)
sw $8, -72($sp)
lw $8, -72($sp)
lw $9, -64($sp)
sw $8, 0($9)
lw $9, -64($sp)
add $8, $9, 4
sw $8, -64($sp)
lw $9, -68($sp)
add $8, $9, 4
sw $8, -68($sp)
lw $9, -68($sp)
lw $8, 0($9)
sw $8, -72($sp)
lw $8, -72($sp)
lw $9, -64($sp)
sw $8, 0($9)
lw $9, -64($sp)
add $8, $9, 4
sw $8, -64($sp)
lw $9, -68($sp)
add $8, $9, 4
sw $8, -68($sp)
lw $9, -68($sp)
lw $8, 0($9)
sw $8, -72($sp)
lw $8, -72($sp)
lw $9, -64($sp)
sw $8, 0($9)
lw $9, -64($sp)
add $8, $9, 4
sw $8, -64($sp)
lw $9, -68($sp)
add $8, $9, 4
sw $8, -68($sp)
lw $9, -68($sp)
lw $8, 0($9)
sw $8, -72($sp)
lw $8, -72($sp)
lw $9, -64($sp)
sw $8, 0($9)
lw $9, -64($sp)
add $8, $9, 4
sw $8, -64($sp)
lw $9, -68($sp)
add $8, $9, 4
sw $8, -68($sp)
lw $9, -68($sp)
lw $8, 0($9)
sw $8, -72($sp)
lw $8, -72($sp)
lw $9, -64($sp)
sw $8, 0($9)
lw $9, -64($sp)
add $8, $9, 4
sw $8, -64($sp)
lw $9, -68($sp)
add $8, $9, 4
sw $8, -68($sp)
jr $ra
__comp:
add $8, $29, 0
sw $8, -4($sp)
add $8, $29, 4
sw $8, -8($sp)
add $8, $29, -332
sw $8, -16($sp)
lw $9, -16($sp)
move $8, $9
sw $8, -12($sp)
sw $31, -448($29)
add $8, $29, -452
sw $8, -28($sp)
lw $9, -4($sp)
lw $8, 0($9)
sw $8, -24($sp)
lw $8, -24($sp)
lw $9, -28($sp)
sw $8, 0($9)
add $29, $29, -452
jal __getNode
sub $29, $29, -452
lw $31, -448($29)
add $8, $29, -444
sw $8, -32($sp)
lw $9, -32($sp)
move $8, $9
sw $8, -20($sp)
lw $9, -16($sp)
move $8, $9
sw $8, -36($sp)
lw $9, -32($sp)
lw $8, 0($9)
sw $8, -44($sp)
lw $8, -44($sp)
lw $9, -36($sp)
sw $8, 0($9)
lw $9, -36($sp)
add $8, $9, 4
sw $8, -36($sp)
lw $9, -32($sp)
add $8, $9, 4
sw $8, -40($sp)
lw $9, -40($sp)
lw $8, 0($9)
sw $8, -44($sp)
lw $8, -44($sp)
lw $9, -36($sp)
sw $8, 0($9)
lw $9, -36($sp)
add $8, $9, 4
sw $8, -36($sp)
lw $9, -40($sp)
add $8, $9, 4
sw $8, -40($sp)
lw $9, -40($sp)
lw $8, 0($9)
sw $8, -44($sp)
lw $8, -44($sp)
lw $9, -36($sp)
sw $8, 0($9)
lw $9, -36($sp)
add $8, $9, 4
sw $8, -36($sp)
lw $9, -40($sp)
add $8, $9, 4
sw $8, -40($sp)
lw $9, -40($sp)
lw $8, 0($9)
sw $8, -44($sp)
lw $8, -44($sp)
lw $9, -36($sp)
sw $8, 0($9)
lw $9, -36($sp)
add $8, $9, 4
sw $8, -36($sp)
lw $9, -40($sp)
add $8, $9, 4
sw $8, -40($sp)
lw $9, -40($sp)
lw $8, 0($9)
sw $8, -44($sp)
lw $8, -44($sp)
lw $9, -36($sp)
sw $8, 0($9)
lw $9, -36($sp)
add $8, $9, 4
sw $8, -36($sp)
lw $9, -40($sp)
add $8, $9, 4
sw $8, -40($sp)
lw $9, -40($sp)
lw $8, 0($9)
sw $8, -44($sp)
lw $8, -44($sp)
lw $9, -36($sp)
sw $8, 0($9)
lw $9, -36($sp)
add $8, $9, 4
sw $8, -36($sp)
lw $9, -40($sp)
add $8, $9, 4
sw $8, -40($sp)
lw $9, -40($sp)
lw $8, 0($9)
sw $8, -44($sp)
lw $8, -44($sp)
lw $9, -36($sp)
sw $8, 0($9)
lw $9, -36($sp)
add $8, $9, 4
sw $8, -36($sp)
lw $9, -40($sp)
add $8, $9, 4
sw $8, -40($sp)
lw $9, -40($sp)
lw $8, 0($9)
sw $8, -44($sp)
lw $8, -44($sp)
lw $9, -36($sp)
sw $8, 0($9)
lw $9, -36($sp)
add $8, $9, 4
sw $8, -36($sp)
lw $9, -40($sp)
add $8, $9, 4
sw $8, -40($sp)
lw $9, -40($sp)
lw $8, 0($9)
sw $8, -44($sp)
lw $8, -44($sp)
lw $9, -36($sp)
sw $8, 0($9)
lw $9, -36($sp)
add $8, $9, 4
sw $8, -36($sp)
lw $9, -40($sp)
add $8, $9, 4
sw $8, -40($sp)
lw $9, -40($sp)
lw $8, 0($9)
sw $8, -44($sp)
lw $8, -44($sp)
lw $9, -36($sp)
sw $8, 0($9)
lw $9, -36($sp)
add $8, $9, 4
sw $8, -36($sp)
lw $9, -40($sp)
add $8, $9, 4
sw $8, -40($sp)
lw $9, -40($sp)
lw $8, 0($9)
sw $8, -44($sp)
lw $8, -44($sp)
lw $9, -36($sp)
sw $8, 0($9)
lw $9, -36($sp)
add $8, $9, 4
sw $8, -36($sp)
lw $9, -40($sp)
add $8, $9, 4
sw $8, -40($sp)
lw $9, -40($sp)
lw $8, 0($9)
sw $8, -44($sp)
lw $8, -44($sp)
lw $9, -36($sp)
sw $8, 0($9)
lw $9, -36($sp)
add $8, $9, 4
sw $8, -36($sp)
lw $9, -40($sp)
add $8, $9, 4
sw $8, -40($sp)
lw $9, -40($sp)
lw $8, 0($9)
sw $8, -44($sp)
lw $8, -44($sp)
lw $9, -36($sp)
sw $8, 0($9)
lw $9, -36($sp)
add $8, $9, 4
sw $8, -36($sp)
lw $9, -40($sp)
add $8, $9, 4
sw $8, -40($sp)
lw $9, -40($sp)
lw $8, 0($9)
sw $8, -44($sp)
lw $8, -44($sp)
lw $9, -36($sp)
sw $8, 0($9)
lw $9, -36($sp)
add $8, $9, 4
sw $8, -36($sp)
lw $9, -40($sp)
add $8, $9, 4
sw $8, -40($sp)
lw $9, -40($sp)
lw $8, 0($9)
sw $8, -44($sp)
lw $8, -44($sp)
lw $9, -36($sp)
sw $8, 0($9)
lw $9, -36($sp)
add $8, $9, 4
sw $8, -36($sp)
lw $9, -40($sp)
add $8, $9, 4
sw $8, -40($sp)
lw $9, -40($sp)
lw $8, 0($9)
sw $8, -44($sp)
lw $8, -44($sp)
lw $9, -36($sp)
sw $8, 0($9)
lw $9, -36($sp)
add $8, $9, 4
sw $8, -36($sp)
lw $9, -40($sp)
add $8, $9, 4
sw $8, -40($sp)
lw $9, -40($sp)
lw $8, 0($9)
sw $8, -44($sp)
lw $8, -44($sp)
lw $9, -36($sp)
sw $8, 0($9)
lw $9, -36($sp)
add $8, $9, 4
sw $8, -36($sp)
lw $9, -40($sp)
add $8, $9, 4
sw $8, -40($sp)
lw $9, -40($sp)
lw $8, 0($9)
sw $8, -44($sp)
lw $8, -44($sp)
lw $9, -36($sp)
sw $8, 0($9)
lw $9, -36($sp)
add $8, $9, 4
sw $8, -36($sp)
lw $9, -40($sp)
add $8, $9, 4
sw $8, -40($sp)
lw $9, -40($sp)
lw $8, 0($9)
sw $8, -44($sp)
lw $8, -44($sp)
lw $9, -36($sp)
sw $8, 0($9)
lw $9, -36($sp)
add $8, $9, 4
sw $8, -36($sp)
lw $9, -40($sp)
add $8, $9, 4
sw $8, -40($sp)
lw $9, -40($sp)
lw $8, 0($9)
sw $8, -44($sp)
lw $8, -44($sp)
lw $9, -36($sp)
sw $8, 0($9)
lw $9, -36($sp)
add $8, $9, 4
sw $8, -36($sp)
lw $9, -40($sp)
add $8, $9, 4
sw $8, -40($sp)
lw $9, -40($sp)
lw $8, 0($9)
sw $8, -44($sp)
lw $8, -44($sp)
lw $9, -36($sp)
sw $8, 0($9)
lw $9, -36($sp)
add $8, $9, 4
sw $8, -36($sp)
lw $9, -40($sp)
add $8, $9, 4
sw $8, -40($sp)
lw $9, -40($sp)
lw $8, 0($9)
sw $8, -44($sp)
lw $8, -44($sp)
lw $9, -36($sp)
sw $8, 0($9)
lw $9, -36($sp)
add $8, $9, 4
sw $8, -36($sp)
lw $9, -40($sp)
add $8, $9, 4
sw $8, -40($sp)
lw $9, -40($sp)
lw $8, 0($9)
sw $8, -44($sp)
lw $8, -44($sp)
lw $9, -36($sp)
sw $8, 0($9)
lw $9, -36($sp)
add $8, $9, 4
sw $8, -36($sp)
lw $9, -40($sp)
add $8, $9, 4
sw $8, -40($sp)
lw $9, -40($sp)
lw $8, 0($9)
sw $8, -44($sp)
lw $8, -44($sp)
lw $9, -36($sp)
sw $8, 0($9)
lw $9, -36($sp)
add $8, $9, 4
sw $8, -36($sp)
lw $9, -40($sp)
add $8, $9, 4
sw $8, -40($sp)
lw $9, -40($sp)
lw $8, 0($9)
sw $8, -44($sp)
lw $8, -44($sp)
lw $9, -36($sp)
sw $8, 0($9)
lw $9, -36($sp)
add $8, $9, 4
sw $8, -36($sp)
lw $9, -40($sp)
add $8, $9, 4
sw $8, -40($sp)
lw $9, -40($sp)
lw $8, 0($9)
sw $8, -44($sp)
lw $8, -44($sp)
lw $9, -36($sp)
sw $8, 0($9)
lw $9, -36($sp)
add $8, $9, 4
sw $8, -36($sp)
lw $9, -40($sp)
add $8, $9, 4
sw $8, -40($sp)
lw $9, -40($sp)
lw $8, 0($9)
sw $8, -44($sp)
lw $8, -44($sp)
lw $9, -36($sp)
sw $8, 0($9)
lw $9, -36($sp)
add $8, $9, 4
sw $8, -36($sp)
lw $9, -40($sp)
add $8, $9, 4
sw $8, -40($sp)
lw $9, -40($sp)
lw $8, 0($9)
sw $8, -44($sp)
lw $8, -44($sp)
lw $9, -36($sp)
sw $8, 0($9)
lw $9, -36($sp)
add $8, $9, 4
sw $8, -36($sp)
lw $9, -40($sp)
add $8, $9, 4
sw $8, -40($sp)
add $8, $29, -444
sw $8, -52($sp)
lw $9, -52($sp)
move $8, $9
sw $8, -48($sp)
sw $31, -560($29)
add $8, $29, -564
sw $8, -64($sp)
lw $9, -8($sp)
lw $8, 0($9)
sw $8, -60($sp)
lw $8, -60($sp)
lw $9, -64($sp)
sw $8, 0($9)
add $29, $29, -564
jal __getNode
sub $29, $29, -564
lw $31, -560($29)
add $8, $29, -556
sw $8, -68($sp)
lw $9, -68($sp)
move $8, $9
sw $8, -56($sp)
lw $9, -52($sp)
move $8, $9
sw $8, -72($sp)
lw $9, -68($sp)
lw $8, 0($9)
sw $8, -80($sp)
lw $8, -80($sp)
lw $9, -72($sp)
sw $8, 0($9)
lw $9, -72($sp)
add $8, $9, 4
sw $8, -72($sp)
lw $9, -68($sp)
add $8, $9, 4
sw $8, -76($sp)
lw $9, -76($sp)
lw $8, 0($9)
sw $8, -80($sp)
lw $8, -80($sp)
lw $9, -72($sp)
sw $8, 0($9)
lw $9, -72($sp)
add $8, $9, 4
sw $8, -72($sp)
lw $9, -76($sp)
add $8, $9, 4
sw $8, -76($sp)
lw $9, -76($sp)
lw $8, 0($9)
sw $8, -80($sp)
lw $8, -80($sp)
lw $9, -72($sp)
sw $8, 0($9)
lw $9, -72($sp)
add $8, $9, 4
sw $8, -72($sp)
lw $9, -76($sp)
add $8, $9, 4
sw $8, -76($sp)
lw $9, -76($sp)
lw $8, 0($9)
sw $8, -80($sp)
lw $8, -80($sp)
lw $9, -72($sp)
sw $8, 0($9)
lw $9, -72($sp)
add $8, $9, 4
sw $8, -72($sp)
lw $9, -76($sp)
add $8, $9, 4
sw $8, -76($sp)
lw $9, -76($sp)
lw $8, 0($9)
sw $8, -80($sp)
lw $8, -80($sp)
lw $9, -72($sp)
sw $8, 0($9)
lw $9, -72($sp)
add $8, $9, 4
sw $8, -72($sp)
lw $9, -76($sp)
add $8, $9, 4
sw $8, -76($sp)
lw $9, -76($sp)
lw $8, 0($9)
sw $8, -80($sp)
lw $8, -80($sp)
lw $9, -72($sp)
sw $8, 0($9)
lw $9, -72($sp)
add $8, $9, 4
sw $8, -72($sp)
lw $9, -76($sp)
add $8, $9, 4
sw $8, -76($sp)
lw $9, -76($sp)
lw $8, 0($9)
sw $8, -80($sp)
lw $8, -80($sp)
lw $9, -72($sp)
sw $8, 0($9)
lw $9, -72($sp)
add $8, $9, 4
sw $8, -72($sp)
lw $9, -76($sp)
add $8, $9, 4
sw $8, -76($sp)
lw $9, -76($sp)
lw $8, 0($9)
sw $8, -80($sp)
lw $8, -80($sp)
lw $9, -72($sp)
sw $8, 0($9)
lw $9, -72($sp)
add $8, $9, 4
sw $8, -72($sp)
lw $9, -76($sp)
add $8, $9, 4
sw $8, -76($sp)
lw $9, -76($sp)
lw $8, 0($9)
sw $8, -80($sp)
lw $8, -80($sp)
lw $9, -72($sp)
sw $8, 0($9)
lw $9, -72($sp)
add $8, $9, 4
sw $8, -72($sp)
lw $9, -76($sp)
add $8, $9, 4
sw $8, -76($sp)
lw $9, -76($sp)
lw $8, 0($9)
sw $8, -80($sp)
lw $8, -80($sp)
lw $9, -72($sp)
sw $8, 0($9)
lw $9, -72($sp)
add $8, $9, 4
sw $8, -72($sp)
lw $9, -76($sp)
add $8, $9, 4
sw $8, -76($sp)
lw $9, -76($sp)
lw $8, 0($9)
sw $8, -80($sp)
lw $8, -80($sp)
lw $9, -72($sp)
sw $8, 0($9)
lw $9, -72($sp)
add $8, $9, 4
sw $8, -72($sp)
lw $9, -76($sp)
add $8, $9, 4
sw $8, -76($sp)
lw $9, -76($sp)
lw $8, 0($9)
sw $8, -80($sp)
lw $8, -80($sp)
lw $9, -72($sp)
sw $8, 0($9)
lw $9, -72($sp)
add $8, $9, 4
sw $8, -72($sp)
lw $9, -76($sp)
add $8, $9, 4
sw $8, -76($sp)
lw $9, -76($sp)
lw $8, 0($9)
sw $8, -80($sp)
lw $8, -80($sp)
lw $9, -72($sp)
sw $8, 0($9)
lw $9, -72($sp)
add $8, $9, 4
sw $8, -72($sp)
lw $9, -76($sp)
add $8, $9, 4
sw $8, -76($sp)
lw $9, -76($sp)
lw $8, 0($9)
sw $8, -80($sp)
lw $8, -80($sp)
lw $9, -72($sp)
sw $8, 0($9)
lw $9, -72($sp)
add $8, $9, 4
sw $8, -72($sp)
lw $9, -76($sp)
add $8, $9, 4
sw $8, -76($sp)
lw $9, -76($sp)
lw $8, 0($9)
sw $8, -80($sp)
lw $8, -80($sp)
lw $9, -72($sp)
sw $8, 0($9)
lw $9, -72($sp)
add $8, $9, 4
sw $8, -72($sp)
lw $9, -76($sp)
add $8, $9, 4
sw $8, -76($sp)
lw $9, -76($sp)
lw $8, 0($9)
sw $8, -80($sp)
lw $8, -80($sp)
lw $9, -72($sp)
sw $8, 0($9)
lw $9, -72($sp)
add $8, $9, 4
sw $8, -72($sp)
lw $9, -76($sp)
add $8, $9, 4
sw $8, -76($sp)
lw $9, -76($sp)
lw $8, 0($9)
sw $8, -80($sp)
lw $8, -80($sp)
lw $9, -72($sp)
sw $8, 0($9)
lw $9, -72($sp)
add $8, $9, 4
sw $8, -72($sp)
lw $9, -76($sp)
add $8, $9, 4
sw $8, -76($sp)
lw $9, -76($sp)
lw $8, 0($9)
sw $8, -80($sp)
lw $8, -80($sp)
lw $9, -72($sp)
sw $8, 0($9)
lw $9, -72($sp)
add $8, $9, 4
sw $8, -72($sp)
lw $9, -76($sp)
add $8, $9, 4
sw $8, -76($sp)
lw $9, -76($sp)
lw $8, 0($9)
sw $8, -80($sp)
lw $8, -80($sp)
lw $9, -72($sp)
sw $8, 0($9)
lw $9, -72($sp)
add $8, $9, 4
sw $8, -72($sp)
lw $9, -76($sp)
add $8, $9, 4
sw $8, -76($sp)
lw $9, -76($sp)
lw $8, 0($9)
sw $8, -80($sp)
lw $8, -80($sp)
lw $9, -72($sp)
sw $8, 0($9)
lw $9, -72($sp)
add $8, $9, 4
sw $8, -72($sp)
lw $9, -76($sp)
add $8, $9, 4
sw $8, -76($sp)
lw $9, -76($sp)
lw $8, 0($9)
sw $8, -80($sp)
lw $8, -80($sp)
lw $9, -72($sp)
sw $8, 0($9)
lw $9, -72($sp)
add $8, $9, 4
sw $8, -72($sp)
lw $9, -76($sp)
add $8, $9, 4
sw $8, -76($sp)
lw $9, -76($sp)
lw $8, 0($9)
sw $8, -80($sp)
lw $8, -80($sp)
lw $9, -72($sp)
sw $8, 0($9)
lw $9, -72($sp)
add $8, $9, 4
sw $8, -72($sp)
lw $9, -76($sp)
add $8, $9, 4
sw $8, -76($sp)
lw $9, -76($sp)
lw $8, 0($9)
sw $8, -80($sp)
lw $8, -80($sp)
lw $9, -72($sp)
sw $8, 0($9)
lw $9, -72($sp)
add $8, $9, 4
sw $8, -72($sp)
lw $9, -76($sp)
add $8, $9, 4
sw $8, -76($sp)
lw $9, -76($sp)
lw $8, 0($9)
sw $8, -80($sp)
lw $8, -80($sp)
lw $9, -72($sp)
sw $8, 0($9)
lw $9, -72($sp)
add $8, $9, 4
sw $8, -72($sp)
lw $9, -76($sp)
add $8, $9, 4
sw $8, -76($sp)
lw $9, -76($sp)
lw $8, 0($9)
sw $8, -80($sp)
lw $8, -80($sp)
lw $9, -72($sp)
sw $8, 0($9)
lw $9, -72($sp)
add $8, $9, 4
sw $8, -72($sp)
lw $9, -76($sp)
add $8, $9, 4
sw $8, -76($sp)
lw $9, -76($sp)
lw $8, 0($9)
sw $8, -80($sp)
lw $8, -80($sp)
lw $9, -72($sp)
sw $8, 0($9)
lw $9, -72($sp)
add $8, $9, 4
sw $8, -72($sp)
lw $9, -76($sp)
add $8, $9, 4
sw $8, -76($sp)
lw $9, -76($sp)
lw $8, 0($9)
sw $8, -80($sp)
lw $8, -80($sp)
lw $9, -72($sp)
sw $8, 0($9)
lw $9, -72($sp)
add $8, $9, 4
sw $8, -72($sp)
lw $9, -76($sp)
add $8, $9, 4
sw $8, -76($sp)
lw $9, -76($sp)
lw $8, 0($9)
sw $8, -80($sp)
lw $8, -80($sp)
lw $9, -72($sp)
sw $8, 0($9)
lw $9, -72($sp)
add $8, $9, 4
sw $8, -72($sp)
lw $9, -76($sp)
add $8, $9, 4
sw $8, -76($sp)
add $8, $29, -448
sw $8, -88($sp)
lw $9, -88($sp)
move $8, $9
sw $8, -84($sp)
li $8, 0
sw $8, -92($sp)
lw $8, -92($sp)
lw $9, -84($sp)
sw $8, 0($9)
add $8, $29, -452
sw $8, -100($sp)
lw $9, -100($sp)
move $8, $9
sw $8, -96($sp)
li $8, 0
sw $8, -104($sp)
lw $8, -104($sp)
lw $9, -96($sp)
sw $8, 0($9)
label13:
lw $9, -84($sp)
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
bgez $8, label14
label16:
lw $9, -96($sp)
lw $8, 0($9)
sw $8, -116($sp)
lw $9, 8($a3)
lw $8, 0($9)
sw $8, -120($sp)
lw $9, -116($sp)
lw $10, -120($sp)
sub $8, $9, $10
sw $8, -120($sp)
lw $8, -120($sp)
bgez $8, label17
lw $9, -12($sp)
add $8, $9, 0
sw $8, -124($sp)
lw $9, -84($sp)
lw $8, 0($9)
sw $8, -128($sp)
lw $9, -128($sp)
mul $8, $9, 20
sw $8, -132($sp)
lw $9, -124($sp)
lw $10, -132($sp)
add $8, $9, $10
sw $8, -124($sp)
lw $9, -96($sp)
lw $8, 0($9)
sw $8, -136($sp)
lw $9, -136($sp)
mul $8, $9, 4
sw $8, -140($sp)
lw $9, -124($sp)
lw $10, -140($sp)
add $8, $9, $10
sw $8, -124($sp)
lw $9, -124($sp)
lw $8, 0($9)
sw $8, -124($sp)
lw $9, -48($sp)
add $8, $9, 0
sw $8, -144($sp)
lw $9, -84($sp)
lw $8, 0($9)
sw $8, -148($sp)
lw $9, -148($sp)
mul $8, $9, 20
sw $8, -152($sp)
lw $9, -144($sp)
lw $10, -152($sp)
add $8, $9, $10
sw $8, -144($sp)
lw $9, -96($sp)
lw $8, 0($9)
sw $8, -156($sp)
lw $9, -156($sp)
mul $8, $9, 4
sw $8, -160($sp)
lw $9, -144($sp)
lw $10, -160($sp)
add $8, $9, $10
sw $8, -144($sp)
lw $9, -144($sp)
lw $8, 0($9)
sw $8, -144($sp)
lw $9, -124($sp)
lw $10, -144($sp)
sub $8, $9, $10
sw $8, -144($sp)
lw $8, -144($sp)
blez $8, label19
sw $31, -456($29)
lw $9, -48($sp)
move $8, $9
sw $8, -168($sp)
add $8, $29, -460
sw $8, -172($sp)
lw $8, -168($sp)
lw $9, -172($sp)
sw $8, 0($9)
lw $9, -12($sp)
move $8, $9
sw $8, -176($sp)
add $8, $29, -464
sw $8, -180($sp)
lw $8, -176($sp)
lw $9, -180($sp)
sw $8, 0($9)
add $29, $29, -464
jal __exchange
sub $29, $29, -464
lw $31, -456($29)
lw $9, -12($sp)
add $8, $9, 108
sw $8, -184($sp)
lw $9, -184($sp)
add $8, $9, 0
sw $8, -184($sp)
lw $9, -184($sp)
move $8, $9
sw $8, -188($sp)
lw $9, -184($sp)
lw $8, 0($9)
sw $8, -184($sp)
lw $9, -184($sp)
add $8, $9, 1
sw $8, -192($sp)
lw $8, -192($sp)
lw $9, -188($sp)
sw $8, 0($9)
lw $9, -48($sp)
add $8, $9, 108
sw $8, -196($sp)
lw $9, -196($sp)
add $8, $9, 0
sw $8, -196($sp)
lw $9, -196($sp)
move $8, $9
sw $8, -200($sp)
lw $9, -196($sp)
lw $8, 0($9)
sw $8, -196($sp)
lw $9, -196($sp)
sub $8, $9, 1
sw $8, -204($sp)
lw $8, -204($sp)
lw $9, -200($sp)
sw $8, 0($9)
label19:
label18:
lw $9, -96($sp)
move $8, $9
sw $8, -212($sp)
lw $9, -96($sp)
lw $8, 0($9)
sw $8, -208($sp)
lw $9, -208($sp)
add $8, $9, 1
sw $8, -208($sp)
lw $8, -208($sp)
lw $9, -212($sp)
sw $8, 0($9)
j label16
label17:
label15:
lw $9, -84($sp)
move $8, $9
sw $8, -220($sp)
lw $9, -84($sp)
lw $8, 0($9)
sw $8, -216($sp)
lw $9, -216($sp)
add $8, $9, 1
sw $8, -216($sp)
lw $8, -216($sp)
lw $9, -220($sp)
sw $8, 0($9)
j label13
label14:
jr $ra
__show:
add $8, $29, 0
sw $8, -4($sp)
add $8, $29, -220
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
label20:
lw $9, -8($sp)
lw $8, 0($9)
sw $8, -24($sp)
lw $9, 8($a3)
lw $8, 0($9)
sw $8, -28($sp)
lw $9, -24($sp)
lw $10, -28($sp)
sub $8, $9, $10
sw $8, -28($sp)
lw $8, -28($sp)
bgez $8, label21
add $8, $29, -224
sw $8, -36($sp)
lw $9, -36($sp)
move $8, $9
sw $8, -32($sp)
lw $9, -36($sp)
move $8, $9
sw $8, -40($sp)
li $8, 0
sw $8, -44($sp)
lw $8, -44($sp)
lw $9, -40($sp)
sw $8, 0($9)
label23:
lw $9, -32($sp)
lw $8, 0($9)
sw $8, -48($sp)
lw $9, 8($a3)
lw $8, 0($9)
sw $8, -52($sp)
lw $9, -48($sp)
lw $10, -52($sp)
sub $8, $9, $10
sw $8, -52($sp)
lw $8, -52($sp)
bgez $8, label24
sw $31, -228($29)
lw $9, -4($sp)
lw $8, 0($9)
sw $8, -64($sp)
lw $9, -64($sp)
mul $8, $9, 112
sw $8, -68($sp)
lw $9, 24($a3)
lw $10, -68($sp)
add $8, $9, $10
sw $8, -60($sp)
lw $9, -60($sp)
add $8, $9, 0
sw $8, -60($sp)
lw $9, -8($sp)
lw $8, 0($9)
sw $8, -72($sp)
lw $9, -72($sp)
mul $8, $9, 20
sw $8, -76($sp)
lw $9, -60($sp)
lw $10, -76($sp)
add $8, $9, $10
sw $8, -60($sp)
lw $9, -32($sp)
lw $8, 0($9)
sw $8, -80($sp)
lw $9, -80($sp)
mul $8, $9, 4
sw $8, -84($sp)
lw $9, -60($sp)
lw $10, -84($sp)
add $8, $9, $10
sw $8, -60($sp)
add $8, $29, -232
sw $8, -88($sp)
lw $9, -60($sp)
lw $8, 0($9)
sw $8, -60($sp)
lw $8, -60($sp)
lw $9, -88($sp)
sw $8, 0($9)
lw $9, 720($a3)
move $8, $9
sw $8, -92($sp)
add $8, $29, -236
sw $8, -96($sp)
lw $8, -92($sp)
lw $9, -96($sp)
sw $8, 0($9)
add $29, $29, -236
jal __printf
sub $29, $29, -236
lw $31, -228($29)
label25:
lw $9, -32($sp)
move $8, $9
sw $8, -104($sp)
lw $9, -32($sp)
lw $8, 0($9)
sw $8, -100($sp)
lw $9, -100($sp)
add $8, $9, 1
sw $8, -100($sp)
lw $8, -100($sp)
lw $9, -104($sp)
sw $8, 0($9)
j label23
label24:
sw $31, -228($29)
lw $9, 744($a3)
move $8, $9
sw $8, -112($sp)
add $8, $29, -232
sw $8, -116($sp)
lw $8, -112($sp)
lw $9, -116($sp)
sw $8, 0($9)
add $29, $29, -232
jal __printf_single
sub $29, $29, -232
lw $31, -228($29)
label22:
lw $9, -8($sp)
move $8, $9
sw $8, -124($sp)
lw $9, -8($sp)
lw $8, 0($9)
sw $8, -120($sp)
lw $9, -120($sp)
add $8, $9, 1
sw $8, -120($sp)
lw $8, -120($sp)
lw $9, -124($sp)
sw $8, 0($9)
j label20
label21:
sw $31, -224($29)
lw $9, -4($sp)
lw $8, 0($9)
sw $8, -136($sp)
lw $9, -136($sp)
mul $8, $9, 112
sw $8, -140($sp)
lw $9, 24($a3)
lw $10, -140($sp)
add $8, $9, $10
sw $8, -132($sp)
lw $9, -132($sp)
add $8, $9, 108
sw $8, -132($sp)
lw $9, -132($sp)
add $8, $9, 0
sw $8, -132($sp)
add $8, $29, -228
sw $8, -144($sp)
lw $9, -132($sp)
lw $8, 0($9)
sw $8, -132($sp)
lw $8, -132($sp)
lw $9, -144($sp)
sw $8, 0($9)
lw $9, -4($sp)
lw $8, 0($9)
sw $8, -152($sp)
lw $9, -152($sp)
mul $8, $9, 112
sw $8, -156($sp)
lw $9, 24($a3)
lw $10, -156($sp)
add $8, $9, $10
sw $8, -148($sp)
lw $9, -148($sp)
add $8, $9, 104
sw $8, -148($sp)
add $8, $29, -232
sw $8, -160($sp)
lw $9, -148($sp)
lw $8, 0($9)
sw $8, -148($sp)
lw $8, -148($sp)
lw $9, -160($sp)
sw $8, 0($9)
lw $9, -4($sp)
lw $8, 0($9)
sw $8, -168($sp)
lw $9, -168($sp)
mul $8, $9, 112
sw $8, -172($sp)
lw $9, 24($a3)
lw $10, -172($sp)
add $8, $9, $10
sw $8, -164($sp)
lw $9, -164($sp)
add $8, $9, 100
sw $8, -164($sp)
li $8, 1
sw $8, -176($sp)
lw $9, -176($sp)
mul $8, $9, 1
sw $8, -180($sp)
lw $9, -164($sp)
lw $10, -180($sp)
add $8, $9, $10
sw $8, -164($sp)
add $8, $29, -236
sw $8, -184($sp)
lw $9, -164($sp)
lb $8, 0($9)
sw $8, -164($sp)
lw $8, -164($sp)
lw $9, -184($sp)
sb $8, 0($9)
lw $9, -4($sp)
lw $8, 0($9)
sw $8, -192($sp)
lw $9, -192($sp)
mul $8, $9, 112
sw $8, -196($sp)
lw $9, 24($a3)
lw $10, -196($sp)
add $8, $9, $10
sw $8, -188($sp)
lw $9, -188($sp)
add $8, $9, 100
sw $8, -188($sp)
li $8, 0
sw $8, -200($sp)
lw $9, -200($sp)
mul $8, $9, 1
sw $8, -204($sp)
lw $9, -188($sp)
lw $10, -204($sp)
add $8, $9, $10
sw $8, -188($sp)
add $8, $29, -240
sw $8, -208($sp)
lw $9, -188($sp)
lb $8, 0($9)
sw $8, -188($sp)
lw $8, -188($sp)
lw $9, -208($sp)
sb $8, 0($9)
lw $9, 848($a3)
move $8, $9
sw $8, -212($sp)
add $8, $29, -244
sw $8, -216($sp)
lw $8, -212($sp)
lw $9, -216($sp)
sw $8, 0($9)
add $29, $29, -244
jal __printf
sub $29, $29, -244
lw $31, -224($29)
jr $ra
main:
la $a3, temp
la $t0, var0
sw $t0, 8($a3)
la $t0, var1
sw $t0, 16($a3)
la $t0, var2
sw $t0, 24($a3)
la $t0, var3
sw $t0, 720($a3)
la $t0, var4
sw $t0, 744($a3)
la $t0, var5
sw $t0, 848($a3)
la $t0, var6
sw $t0, 1576($a3)
li $8, 5
sw $8, 12($a3)
lw $8, 12($a3)
lw $9, 8($a3)
sw $8, 0($9)
li $8, 5
sw $8, 20($a3)
lw $8, 20($a3)
lw $9, 16($a3)
sw $8, 0($9)
add $8, $29, -764
sw $8, -8($sp)
lw $9, -8($sp)
move $8, $9
sw $8, -4($sp)
li $8, 7
sw $8, -12($sp)
lw $8, -12($sp)
lw $9, -4($sp)
sw $8, 0($9)
add $8, $29, -768
sw $8, -20($sp)
lw $9, -20($sp)
move $8, $9
sw $8, -16($sp)
add $8, $29, -772
sw $8, -28($sp)
lw $9, -28($sp)
move $8, $9
sw $8, -24($sp)
add $8, $29, -776
sw $8, -36($sp)
lw $9, -36($sp)
move $8, $9
sw $8, -32($sp)
lw $9, -20($sp)
move $8, $9
sw $8, -40($sp)
li $8, 0
sw $8, -44($sp)
lw $8, -44($sp)
lw $9, -40($sp)
sw $8, 0($9)
label26:
lw $9, -16($sp)
lw $8, 0($9)
sw $8, -48($sp)
lw $9, 16($a3)
lw $8, 0($9)
sw $8, -52($sp)
lw $9, -48($sp)
lw $10, -52($sp)
sub $8, $9, $10
sw $8, -52($sp)
lw $8, -52($sp)
bgez $8, label27
lw $9, -24($sp)
move $8, $9
sw $8, -56($sp)
li $8, 0
sw $8, -60($sp)
lw $8, -60($sp)
lw $9, -56($sp)
sw $8, 0($9)
label29:
lw $9, -24($sp)
lw $8, 0($9)
sw $8, -64($sp)
lw $9, 8($a3)
lw $8, 0($9)
sw $8, -68($sp)
lw $9, -64($sp)
lw $10, -68($sp)
sub $8, $9, $10
sw $8, -68($sp)
lw $8, -68($sp)
bgez $8, label30
lw $9, -32($sp)
move $8, $9
sw $8, -72($sp)
li $8, 0
sw $8, -76($sp)
lw $8, -76($sp)
lw $9, -72($sp)
sw $8, 0($9)
label32:
lw $9, -32($sp)
lw $8, 0($9)
sw $8, -80($sp)
lw $9, 8($a3)
lw $8, 0($9)
sw $8, -84($sp)
lw $9, -80($sp)
lw $10, -84($sp)
sub $8, $9, $10
sw $8, -84($sp)
lw $8, -84($sp)
bgez $8, label33
lw $9, -16($sp)
lw $8, 0($9)
sw $8, -96($sp)
lw $9, -96($sp)
mul $8, $9, 112
sw $8, -100($sp)
lw $9, 24($a3)
lw $10, -100($sp)
add $8, $9, $10
sw $8, -92($sp)
lw $9, -92($sp)
add $8, $9, 0
sw $8, -92($sp)
lw $9, -24($sp)
lw $8, 0($9)
sw $8, -104($sp)
lw $9, -104($sp)
mul $8, $9, 20
sw $8, -108($sp)
lw $9, -92($sp)
lw $10, -108($sp)
add $8, $9, $10
sw $8, -92($sp)
lw $9, -32($sp)
lw $8, 0($9)
sw $8, -112($sp)
lw $9, -112($sp)
mul $8, $9, 4
sw $8, -116($sp)
lw $9, -92($sp)
lw $10, -116($sp)
add $8, $9, $10
sw $8, -92($sp)
lw $9, -24($sp)
lw $8, 0($9)
sw $8, -120($sp)
li $8, 5110
sw $8, -124($sp)
lw $9, -120($sp)
lw $10, -124($sp)
mul $8, $9, $10
sw $8, -120($sp)
lw $9, -32($sp)
lw $8, 0($9)
sw $8, -128($sp)
lw $9, -120($sp)
lw $10, -128($sp)
add $8, $9, $10
sw $8, -120($sp)
li $8, 34
sw $8, -132($sp)
lw $9, -16($sp)
lw $8, 0($9)
sw $8, -136($sp)
lw $9, -132($sp)
lw $10, -136($sp)
sub $8, $9, $10
sw $8, -132($sp)
lw $9, -120($sp)
lw $10, -132($sp)
rem $8, $9, $10
sw $8, -120($sp)
li $8, 1
sw $8, -140($sp)
lw $9, -120($sp)
lw $10, -140($sp)
add $8, $9, $10
sw $8, -120($sp)
lw $8, -120($sp)
lw $9, -92($sp)
sw $8, 0($9)
lw $9, -16($sp)
lw $8, 0($9)
sw $8, -148($sp)
lw $9, -148($sp)
mul $8, $9, 112
sw $8, -152($sp)
lw $9, 24($a3)
lw $10, -152($sp)
add $8, $9, $10
sw $8, -144($sp)
lw $9, -144($sp)
add $8, $9, 100
sw $8, -144($sp)
li $8, 0
sw $8, -156($sp)
lw $9, -156($sp)
mul $8, $9, 1
sw $8, -160($sp)
lw $9, -144($sp)
lw $10, -160($sp)
add $8, $9, $10
sw $8, -144($sp)
lw $9, -16($sp)
lw $8, 0($9)
sw $8, -164($sp)
lw $9, -24($sp)
lw $8, 0($9)
sw $8, -168($sp)
lw $9, -24($sp)
lw $8, 0($9)
sw $8, -172($sp)
lw $9, -168($sp)
lw $10, -172($sp)
mul $8, $9, $10
sw $8, -168($sp)
lw $9, -24($sp)
lw $8, 0($9)
sw $8, -176($sp)
lw $9, -168($sp)
lw $10, -176($sp)
mul $8, $9, $10
sw $8, -168($sp)
lw $9, -164($sp)
lw $10, -168($sp)
add $8, $9, $10
sw $8, -164($sp)
lw $8, -164($sp)
lw $9, -144($sp)
sb $8, 0($9)
lw $9, -16($sp)
lw $8, 0($9)
sw $8, -184($sp)
lw $9, -184($sp)
mul $8, $9, 112
sw $8, -188($sp)
lw $9, 24($a3)
lw $10, -188($sp)
add $8, $9, $10
sw $8, -180($sp)
lw $9, -180($sp)
add $8, $9, 100
sw $8, -180($sp)
li $8, 1
sw $8, -192($sp)
lw $9, -192($sp)
mul $8, $9, 1
sw $8, -196($sp)
lw $9, -180($sp)
lw $10, -196($sp)
add $8, $9, $10
sw $8, -180($sp)
lw $9, -32($sp)
lw $8, 0($9)
sw $8, -200($sp)
lw $9, -24($sp)
lw $8, 0($9)
sw $8, -204($sp)
lw $9, -200($sp)
lw $10, -204($sp)
add $8, $9, $10
sw $8, -200($sp)
lw $9, -16($sp)
lw $8, 0($9)
sw $8, -208($sp)
lw $9, -200($sp)
lw $10, -208($sp)
add $8, $9, $10
sw $8, -200($sp)
li $8, 1
sw $8, -212($sp)
lw $9, -200($sp)
lw $10, -212($sp)
sll $8, $9, $10
sw $8, -200($sp)
lw $8, -200($sp)
lw $9, -180($sp)
sb $8, 0($9)
lw $9, -16($sp)
lw $8, 0($9)
sw $8, -216($sp)
lw $9, -216($sp)
mul $8, $9, 112
sw $8, -220($sp)
lw $9, 24($a3)
lw $10, -220($sp)
add $8, $9, $10
sw $8, -88($sp)
lw $9, -88($sp)
add $8, $9, 108
sw $8, -88($sp)
lw $9, -88($sp)
add $8, $9, 0
sw $8, -88($sp)
lw $9, -16($sp)
lw $8, 0($9)
sw $8, -224($sp)
lw $9, -24($sp)
lw $8, 0($9)
sw $8, -228($sp)
lw $9, -228($sp)
not $8, $9
sw $8, -228($sp)
lw $9, -224($sp)
lw $10, -228($sp)
add $8, $9, $10
sw $8, -224($sp)
lw $9, -32($sp)
lw $8, 0($9)
sw $8, -232($sp)
lw $9, -224($sp)
lw $10, -232($sp)
or $8, $9, $10
sw $8, -224($sp)
lw $8, -224($sp)
lw $9, -88($sp)
sw $8, 0($9)
lw $9, -16($sp)
lw $8, 0($9)
sw $8, -240($sp)
lw $9, -240($sp)
mul $8, $9, 112
sw $8, -244($sp)
lw $9, 24($a3)
lw $10, -244($sp)
add $8, $9, $10
sw $8, -236($sp)
lw $9, -236($sp)
add $8, $9, 100
sw $8, -236($sp)
li $8, 0
sw $8, -248($sp)
lw $9, -248($sp)
mul $8, $9, 1
sw $8, -252($sp)
lw $9, -236($sp)
lw $10, -252($sp)
add $8, $9, $10
sw $8, -236($sp)
lw $9, -16($sp)
lw $8, 0($9)
sw $8, -260($sp)
lw $9, -260($sp)
mul $8, $9, 112
sw $8, -264($sp)
lw $9, 24($a3)
lw $10, -264($sp)
add $8, $9, $10
sw $8, -256($sp)
lw $9, -256($sp)
add $8, $9, 100
sw $8, -256($sp)
li $8, 0
sw $8, -268($sp)
lw $9, -268($sp)
mul $8, $9, 1
sw $8, -272($sp)
lw $9, -256($sp)
lw $10, -272($sp)
add $8, $9, $10
sw $8, -256($sp)
lw $9, -256($sp)
lb $8, 0($9)
sw $8, -256($sp)
li $8, 26
sw $8, -276($sp)
lw $9, -256($sp)
lw $10, -276($sp)
rem $8, $9, $10
sw $8, -256($sp)
li $8, 97
sw $8, -280($sp)
lw $9, -256($sp)
lw $10, -280($sp)
add $8, $9, $10
sw $8, -256($sp)
lw $8, -256($sp)
lw $9, -236($sp)
sb $8, 0($9)
lw $9, -16($sp)
lw $8, 0($9)
sw $8, -288($sp)
lw $9, -288($sp)
mul $8, $9, 112
sw $8, -292($sp)
lw $9, 24($a3)
lw $10, -292($sp)
add $8, $9, $10
sw $8, -284($sp)
lw $9, -284($sp)
add $8, $9, 100
sw $8, -284($sp)
li $8, 1
sw $8, -296($sp)
lw $9, -296($sp)
mul $8, $9, 1
sw $8, -300($sp)
lw $9, -284($sp)
lw $10, -300($sp)
add $8, $9, $10
sw $8, -284($sp)
lw $9, -16($sp)
lw $8, 0($9)
sw $8, -308($sp)
lw $9, -308($sp)
mul $8, $9, 112
sw $8, -312($sp)
lw $9, 24($a3)
lw $10, -312($sp)
add $8, $9, $10
sw $8, -304($sp)
lw $9, -304($sp)
add $8, $9, 100
sw $8, -304($sp)
li $8, 1
sw $8, -316($sp)
lw $9, -316($sp)
mul $8, $9, 1
sw $8, -320($sp)
lw $9, -304($sp)
lw $10, -320($sp)
add $8, $9, $10
sw $8, -304($sp)
lw $9, -304($sp)
lb $8, 0($9)
sw $8, -304($sp)
li $8, 26
sw $8, -324($sp)
lw $9, -304($sp)
lw $10, -324($sp)
rem $8, $9, $10
sw $8, -304($sp)
li $8, 65
sw $8, -328($sp)
lw $9, -304($sp)
lw $10, -328($sp)
add $8, $9, $10
sw $8, -304($sp)
lw $8, -304($sp)
lw $9, -284($sp)
sb $8, 0($9)
label34:
lw $9, -32($sp)
move $8, $9
sw $8, -336($sp)
lw $9, -32($sp)
lw $8, 0($9)
sw $8, -332($sp)
lw $9, -332($sp)
add $8, $9, 1
sw $8, -332($sp)
lw $8, -332($sp)
lw $9, -336($sp)
sw $8, 0($9)
j label32
label33:
label31:
lw $9, -24($sp)
move $8, $9
sw $8, -344($sp)
lw $9, -24($sp)
lw $8, 0($9)
sw $8, -340($sp)
lw $9, -340($sp)
add $8, $9, 1
sw $8, -340($sp)
lw $8, -340($sp)
lw $9, -344($sp)
sw $8, 0($9)
j label29
label30:
label28:
lw $9, -16($sp)
move $8, $9
sw $8, -352($sp)
lw $9, -16($sp)
lw $8, 0($9)
sw $8, -348($sp)
lw $9, -348($sp)
add $8, $9, 1
sw $8, -348($sp)
lw $8, -348($sp)
lw $9, -352($sp)
sw $8, 0($9)
j label26
label27:
lw $9, -24($sp)
move $8, $9
sw $8, -356($sp)
li $8, 0
sw $8, -360($sp)
lw $8, -360($sp)
lw $9, -356($sp)
sw $8, 0($9)
label35:
lw $9, -24($sp)
lw $8, 0($9)
sw $8, -364($sp)
lw $9, 16($a3)
lw $8, 0($9)
sw $8, -368($sp)
lw $9, -364($sp)
lw $10, -368($sp)
sub $8, $9, $10
sw $8, -368($sp)
lw $8, -368($sp)
bgez $8, label36
lw $9, -32($sp)
move $8, $9
sw $8, -372($sp)
li $8, 0
sw $8, -376($sp)
lw $8, -376($sp)
lw $9, -372($sp)
sw $8, 0($9)
label38:
lw $9, -32($sp)
lw $8, 0($9)
sw $8, -380($sp)
lw $9, 16($a3)
lw $8, 0($9)
sw $8, -384($sp)
lw $9, -380($sp)
lw $10, -384($sp)
sub $8, $9, $10
sw $8, -384($sp)
lw $8, -384($sp)
bgez $8, label39
add $8, $29, -788
sw $8, -396($sp)
lw $9, -32($sp)
lw $8, 0($9)
sw $8, -392($sp)
lw $8, -392($sp)
lw $9, -396($sp)
sw $8, 0($9)
add $8, $29, -792
sw $8, -404($sp)
lw $9, -24($sp)
lw $8, 0($9)
sw $8, -400($sp)
lw $8, -400($sp)
lw $9, -404($sp)
sw $8, 0($9)
add $29, $29, -792
jal __comp
sub $29, $29, -792
add $8, $29, -780
sw $8, -408($sp)
lw $9, -408($sp)
move $8, $9
sw $8, -388($sp)
label40:
lw $9, -32($sp)
move $8, $9
sw $8, -416($sp)
lw $9, -32($sp)
lw $8, 0($9)
sw $8, -412($sp)
lw $9, -412($sp)
add $8, $9, 1
sw $8, -412($sp)
lw $8, -412($sp)
lw $9, -416($sp)
sw $8, 0($9)
j label38
label39:
label37:
lw $9, -24($sp)
move $8, $9
sw $8, -424($sp)
lw $9, -24($sp)
lw $8, 0($9)
sw $8, -420($sp)
lw $9, -420($sp)
add $8, $9, 1
sw $8, -420($sp)
lw $8, -420($sp)
lw $9, -424($sp)
sw $8, 0($9)
j label35
label36:
lw $9, -16($sp)
move $8, $9
sw $8, -428($sp)
li $8, 0
sw $8, -432($sp)
lw $8, -432($sp)
lw $9, -428($sp)
sw $8, 0($9)
label41:
lw $9, -16($sp)
lw $8, 0($9)
sw $8, -436($sp)
lw $9, 16($a3)
lw $8, 0($9)
sw $8, -440($sp)
lw $9, -436($sp)
lw $10, -440($sp)
sub $8, $9, $10
sw $8, -440($sp)
lw $8, -440($sp)
bgez $8, label42
add $8, $29, -784
sw $8, -452($sp)
lw $9, -16($sp)
lw $8, 0($9)
sw $8, -448($sp)
lw $8, -448($sp)
lw $9, -452($sp)
sw $8, 0($9)
add $29, $29, -784
jal __show
sub $29, $29, -784
label43:
lw $9, -16($sp)
move $8, $9
sw $8, -460($sp)
lw $9, -16($sp)
lw $8, 0($9)
sw $8, -456($sp)
lw $9, -456($sp)
add $8, $9, 1
sw $8, -456($sp)
lw $8, -456($sp)
lw $9, -460($sp)
sw $8, 0($9)
j label41
label42:
lw $9, -24($sp)
move $8, $9
sw $8, -464($sp)
lw $9, 16($a3)
lw $8, 0($9)
sw $8, -468($sp)
li $8, 1
sw $8, -472($sp)
lw $9, -468($sp)
lw $10, -472($sp)
sub $8, $9, $10
sw $8, -468($sp)
lw $8, -468($sp)
lw $9, -464($sp)
sw $8, 0($9)
label44:
lw $9, -24($sp)
lw $8, 0($9)
sw $8, -476($sp)
li $8, -1
sw $8, -480($sp)
lw $9, -476($sp)
lw $10, -480($sp)
sub $8, $9, $10
sw $8, -480($sp)
lw $8, -480($sp)
blez $8, label45
lw $9, -24($sp)
lw $8, 0($9)
sw $8, -484($sp)
li $8, 3
sw $8, -488($sp)
lw $9, -484($sp)
lw $10, -488($sp)
rem $8, $9, $10
sw $8, -484($sp)
li $8, 0
sw $8, -492($sp)
lw $9, -484($sp)
lw $10, -492($sp)
sub $8, $9, $10
sw $8, -492($sp)
lw $8, -492($sp)
bnez $8, label47
lw $9, -24($sp)
lw $8, 0($9)
sw $8, -500($sp)
lw $9, -500($sp)
mul $8, $9, 112
sw $8, -504($sp)
lw $9, 24($a3)
lw $10, -504($sp)
add $8, $9, $10
sw $8, -496($sp)
lw $9, -24($sp)
lw $8, 0($9)
sw $8, -512($sp)
li $8, 3
sw $8, -516($sp)
lw $9, -512($sp)
lw $10, -516($sp)
add $8, $9, $10
sw $8, -512($sp)
lw $9, 16($a3)
lw $8, 0($9)
sw $8, -520($sp)
lw $9, -512($sp)
lw $10, -520($sp)
rem $8, $9, $10
sw $8, -512($sp)
add $8, $29, -896
sw $8, -524($sp)
lw $8, -512($sp)
lw $9, -524($sp)
sw $8, 0($9)
add $29, $29, -896
jal __getNode
sub $29, $29, -896
add $8, $29, -888
sw $8, -528($sp)
lw $9, -528($sp)
move $8, $9
sw $8, -508($sp)
lw $9, -496($sp)
move $8, $9
sw $8, -532($sp)
lw $9, -528($sp)
lw $8, 0($9)
sw $8, -540($sp)
lw $8, -540($sp)
lw $9, -532($sp)
sw $8, 0($9)
lw $9, -532($sp)
add $8, $9, 4
sw $8, -532($sp)
lw $9, -528($sp)
add $8, $9, 4
sw $8, -536($sp)
lw $9, -536($sp)
lw $8, 0($9)
sw $8, -540($sp)
lw $8, -540($sp)
lw $9, -532($sp)
sw $8, 0($9)
lw $9, -532($sp)
add $8, $9, 4
sw $8, -532($sp)
lw $9, -536($sp)
add $8, $9, 4
sw $8, -536($sp)
lw $9, -536($sp)
lw $8, 0($9)
sw $8, -540($sp)
lw $8, -540($sp)
lw $9, -532($sp)
sw $8, 0($9)
lw $9, -532($sp)
add $8, $9, 4
sw $8, -532($sp)
lw $9, -536($sp)
add $8, $9, 4
sw $8, -536($sp)
lw $9, -536($sp)
lw $8, 0($9)
sw $8, -540($sp)
lw $8, -540($sp)
lw $9, -532($sp)
sw $8, 0($9)
lw $9, -532($sp)
add $8, $9, 4
sw $8, -532($sp)
lw $9, -536($sp)
add $8, $9, 4
sw $8, -536($sp)
lw $9, -536($sp)
lw $8, 0($9)
sw $8, -540($sp)
lw $8, -540($sp)
lw $9, -532($sp)
sw $8, 0($9)
lw $9, -532($sp)
add $8, $9, 4
sw $8, -532($sp)
lw $9, -536($sp)
add $8, $9, 4
sw $8, -536($sp)
lw $9, -536($sp)
lw $8, 0($9)
sw $8, -540($sp)
lw $8, -540($sp)
lw $9, -532($sp)
sw $8, 0($9)
lw $9, -532($sp)
add $8, $9, 4
sw $8, -532($sp)
lw $9, -536($sp)
add $8, $9, 4
sw $8, -536($sp)
lw $9, -536($sp)
lw $8, 0($9)
sw $8, -540($sp)
lw $8, -540($sp)
lw $9, -532($sp)
sw $8, 0($9)
lw $9, -532($sp)
add $8, $9, 4
sw $8, -532($sp)
lw $9, -536($sp)
add $8, $9, 4
sw $8, -536($sp)
lw $9, -536($sp)
lw $8, 0($9)
sw $8, -540($sp)
lw $8, -540($sp)
lw $9, -532($sp)
sw $8, 0($9)
lw $9, -532($sp)
add $8, $9, 4
sw $8, -532($sp)
lw $9, -536($sp)
add $8, $9, 4
sw $8, -536($sp)
lw $9, -536($sp)
lw $8, 0($9)
sw $8, -540($sp)
lw $8, -540($sp)
lw $9, -532($sp)
sw $8, 0($9)
lw $9, -532($sp)
add $8, $9, 4
sw $8, -532($sp)
lw $9, -536($sp)
add $8, $9, 4
sw $8, -536($sp)
lw $9, -536($sp)
lw $8, 0($9)
sw $8, -540($sp)
lw $8, -540($sp)
lw $9, -532($sp)
sw $8, 0($9)
lw $9, -532($sp)
add $8, $9, 4
sw $8, -532($sp)
lw $9, -536($sp)
add $8, $9, 4
sw $8, -536($sp)
lw $9, -536($sp)
lw $8, 0($9)
sw $8, -540($sp)
lw $8, -540($sp)
lw $9, -532($sp)
sw $8, 0($9)
lw $9, -532($sp)
add $8, $9, 4
sw $8, -532($sp)
lw $9, -536($sp)
add $8, $9, 4
sw $8, -536($sp)
lw $9, -536($sp)
lw $8, 0($9)
sw $8, -540($sp)
lw $8, -540($sp)
lw $9, -532($sp)
sw $8, 0($9)
lw $9, -532($sp)
add $8, $9, 4
sw $8, -532($sp)
lw $9, -536($sp)
add $8, $9, 4
sw $8, -536($sp)
lw $9, -536($sp)
lw $8, 0($9)
sw $8, -540($sp)
lw $8, -540($sp)
lw $9, -532($sp)
sw $8, 0($9)
lw $9, -532($sp)
add $8, $9, 4
sw $8, -532($sp)
lw $9, -536($sp)
add $8, $9, 4
sw $8, -536($sp)
lw $9, -536($sp)
lw $8, 0($9)
sw $8, -540($sp)
lw $8, -540($sp)
lw $9, -532($sp)
sw $8, 0($9)
lw $9, -532($sp)
add $8, $9, 4
sw $8, -532($sp)
lw $9, -536($sp)
add $8, $9, 4
sw $8, -536($sp)
lw $9, -536($sp)
lw $8, 0($9)
sw $8, -540($sp)
lw $8, -540($sp)
lw $9, -532($sp)
sw $8, 0($9)
lw $9, -532($sp)
add $8, $9, 4
sw $8, -532($sp)
lw $9, -536($sp)
add $8, $9, 4
sw $8, -536($sp)
lw $9, -536($sp)
lw $8, 0($9)
sw $8, -540($sp)
lw $8, -540($sp)
lw $9, -532($sp)
sw $8, 0($9)
lw $9, -532($sp)
add $8, $9, 4
sw $8, -532($sp)
lw $9, -536($sp)
add $8, $9, 4
sw $8, -536($sp)
lw $9, -536($sp)
lw $8, 0($9)
sw $8, -540($sp)
lw $8, -540($sp)
lw $9, -532($sp)
sw $8, 0($9)
lw $9, -532($sp)
add $8, $9, 4
sw $8, -532($sp)
lw $9, -536($sp)
add $8, $9, 4
sw $8, -536($sp)
lw $9, -536($sp)
lw $8, 0($9)
sw $8, -540($sp)
lw $8, -540($sp)
lw $9, -532($sp)
sw $8, 0($9)
lw $9, -532($sp)
add $8, $9, 4
sw $8, -532($sp)
lw $9, -536($sp)
add $8, $9, 4
sw $8, -536($sp)
lw $9, -536($sp)
lw $8, 0($9)
sw $8, -540($sp)
lw $8, -540($sp)
lw $9, -532($sp)
sw $8, 0($9)
lw $9, -532($sp)
add $8, $9, 4
sw $8, -532($sp)
lw $9, -536($sp)
add $8, $9, 4
sw $8, -536($sp)
lw $9, -536($sp)
lw $8, 0($9)
sw $8, -540($sp)
lw $8, -540($sp)
lw $9, -532($sp)
sw $8, 0($9)
lw $9, -532($sp)
add $8, $9, 4
sw $8, -532($sp)
lw $9, -536($sp)
add $8, $9, 4
sw $8, -536($sp)
lw $9, -536($sp)
lw $8, 0($9)
sw $8, -540($sp)
lw $8, -540($sp)
lw $9, -532($sp)
sw $8, 0($9)
lw $9, -532($sp)
add $8, $9, 4
sw $8, -532($sp)
lw $9, -536($sp)
add $8, $9, 4
sw $8, -536($sp)
lw $9, -536($sp)
lw $8, 0($9)
sw $8, -540($sp)
lw $8, -540($sp)
lw $9, -532($sp)
sw $8, 0($9)
lw $9, -532($sp)
add $8, $9, 4
sw $8, -532($sp)
lw $9, -536($sp)
add $8, $9, 4
sw $8, -536($sp)
lw $9, -536($sp)
lw $8, 0($9)
sw $8, -540($sp)
lw $8, -540($sp)
lw $9, -532($sp)
sw $8, 0($9)
lw $9, -532($sp)
add $8, $9, 4
sw $8, -532($sp)
lw $9, -536($sp)
add $8, $9, 4
sw $8, -536($sp)
lw $9, -536($sp)
lw $8, 0($9)
sw $8, -540($sp)
lw $8, -540($sp)
lw $9, -532($sp)
sw $8, 0($9)
lw $9, -532($sp)
add $8, $9, 4
sw $8, -532($sp)
lw $9, -536($sp)
add $8, $9, 4
sw $8, -536($sp)
lw $9, -536($sp)
lw $8, 0($9)
sw $8, -540($sp)
lw $8, -540($sp)
lw $9, -532($sp)
sw $8, 0($9)
lw $9, -532($sp)
add $8, $9, 4
sw $8, -532($sp)
lw $9, -536($sp)
add $8, $9, 4
sw $8, -536($sp)
lw $9, -536($sp)
lw $8, 0($9)
sw $8, -540($sp)
lw $8, -540($sp)
lw $9, -532($sp)
sw $8, 0($9)
lw $9, -532($sp)
add $8, $9, 4
sw $8, -532($sp)
lw $9, -536($sp)
add $8, $9, 4
sw $8, -536($sp)
lw $9, -536($sp)
lw $8, 0($9)
sw $8, -540($sp)
lw $8, -540($sp)
lw $9, -532($sp)
sw $8, 0($9)
lw $9, -532($sp)
add $8, $9, 4
sw $8, -532($sp)
lw $9, -536($sp)
add $8, $9, 4
sw $8, -536($sp)
lw $9, -536($sp)
lw $8, 0($9)
sw $8, -540($sp)
lw $8, -540($sp)
lw $9, -532($sp)
sw $8, 0($9)
lw $9, -532($sp)
add $8, $9, 4
sw $8, -532($sp)
lw $9, -536($sp)
add $8, $9, 4
sw $8, -536($sp)
j label48
label47:
lw $9, -24($sp)
lw $8, 0($9)
sw $8, -548($sp)
lw $9, -548($sp)
mul $8, $9, 112
sw $8, -552($sp)
lw $9, 24($a3)
lw $10, -552($sp)
add $8, $9, $10
sw $8, -544($sp)
add $8, $29, -896
sw $8, -564($sp)
lw $9, -24($sp)
lw $8, 0($9)
sw $8, -560($sp)
lw $8, -560($sp)
lw $9, -564($sp)
sw $8, 0($9)
add $29, $29, -896
jal __getNode
sub $29, $29, -896
add $8, $29, -888
sw $8, -568($sp)
lw $9, -568($sp)
move $8, $9
sw $8, -556($sp)
lw $9, -544($sp)
move $8, $9
sw $8, -572($sp)
lw $9, -568($sp)
lw $8, 0($9)
sw $8, -580($sp)
lw $8, -580($sp)
lw $9, -572($sp)
sw $8, 0($9)
lw $9, -572($sp)
add $8, $9, 4
sw $8, -572($sp)
lw $9, -568($sp)
add $8, $9, 4
sw $8, -576($sp)
lw $9, -576($sp)
lw $8, 0($9)
sw $8, -580($sp)
lw $8, -580($sp)
lw $9, -572($sp)
sw $8, 0($9)
lw $9, -572($sp)
add $8, $9, 4
sw $8, -572($sp)
lw $9, -576($sp)
add $8, $9, 4
sw $8, -576($sp)
lw $9, -576($sp)
lw $8, 0($9)
sw $8, -580($sp)
lw $8, -580($sp)
lw $9, -572($sp)
sw $8, 0($9)
lw $9, -572($sp)
add $8, $9, 4
sw $8, -572($sp)
lw $9, -576($sp)
add $8, $9, 4
sw $8, -576($sp)
lw $9, -576($sp)
lw $8, 0($9)
sw $8, -580($sp)
lw $8, -580($sp)
lw $9, -572($sp)
sw $8, 0($9)
lw $9, -572($sp)
add $8, $9, 4
sw $8, -572($sp)
lw $9, -576($sp)
add $8, $9, 4
sw $8, -576($sp)
lw $9, -576($sp)
lw $8, 0($9)
sw $8, -580($sp)
lw $8, -580($sp)
lw $9, -572($sp)
sw $8, 0($9)
lw $9, -572($sp)
add $8, $9, 4
sw $8, -572($sp)
lw $9, -576($sp)
add $8, $9, 4
sw $8, -576($sp)
lw $9, -576($sp)
lw $8, 0($9)
sw $8, -580($sp)
lw $8, -580($sp)
lw $9, -572($sp)
sw $8, 0($9)
lw $9, -572($sp)
add $8, $9, 4
sw $8, -572($sp)
lw $9, -576($sp)
add $8, $9, 4
sw $8, -576($sp)
lw $9, -576($sp)
lw $8, 0($9)
sw $8, -580($sp)
lw $8, -580($sp)
lw $9, -572($sp)
sw $8, 0($9)
lw $9, -572($sp)
add $8, $9, 4
sw $8, -572($sp)
lw $9, -576($sp)
add $8, $9, 4
sw $8, -576($sp)
lw $9, -576($sp)
lw $8, 0($9)
sw $8, -580($sp)
lw $8, -580($sp)
lw $9, -572($sp)
sw $8, 0($9)
lw $9, -572($sp)
add $8, $9, 4
sw $8, -572($sp)
lw $9, -576($sp)
add $8, $9, 4
sw $8, -576($sp)
lw $9, -576($sp)
lw $8, 0($9)
sw $8, -580($sp)
lw $8, -580($sp)
lw $9, -572($sp)
sw $8, 0($9)
lw $9, -572($sp)
add $8, $9, 4
sw $8, -572($sp)
lw $9, -576($sp)
add $8, $9, 4
sw $8, -576($sp)
lw $9, -576($sp)
lw $8, 0($9)
sw $8, -580($sp)
lw $8, -580($sp)
lw $9, -572($sp)
sw $8, 0($9)
lw $9, -572($sp)
add $8, $9, 4
sw $8, -572($sp)
lw $9, -576($sp)
add $8, $9, 4
sw $8, -576($sp)
lw $9, -576($sp)
lw $8, 0($9)
sw $8, -580($sp)
lw $8, -580($sp)
lw $9, -572($sp)
sw $8, 0($9)
lw $9, -572($sp)
add $8, $9, 4
sw $8, -572($sp)
lw $9, -576($sp)
add $8, $9, 4
sw $8, -576($sp)
lw $9, -576($sp)
lw $8, 0($9)
sw $8, -580($sp)
lw $8, -580($sp)
lw $9, -572($sp)
sw $8, 0($9)
lw $9, -572($sp)
add $8, $9, 4
sw $8, -572($sp)
lw $9, -576($sp)
add $8, $9, 4
sw $8, -576($sp)
lw $9, -576($sp)
lw $8, 0($9)
sw $8, -580($sp)
lw $8, -580($sp)
lw $9, -572($sp)
sw $8, 0($9)
lw $9, -572($sp)
add $8, $9, 4
sw $8, -572($sp)
lw $9, -576($sp)
add $8, $9, 4
sw $8, -576($sp)
lw $9, -576($sp)
lw $8, 0($9)
sw $8, -580($sp)
lw $8, -580($sp)
lw $9, -572($sp)
sw $8, 0($9)
lw $9, -572($sp)
add $8, $9, 4
sw $8, -572($sp)
lw $9, -576($sp)
add $8, $9, 4
sw $8, -576($sp)
lw $9, -576($sp)
lw $8, 0($9)
sw $8, -580($sp)
lw $8, -580($sp)
lw $9, -572($sp)
sw $8, 0($9)
lw $9, -572($sp)
add $8, $9, 4
sw $8, -572($sp)
lw $9, -576($sp)
add $8, $9, 4
sw $8, -576($sp)
lw $9, -576($sp)
lw $8, 0($9)
sw $8, -580($sp)
lw $8, -580($sp)
lw $9, -572($sp)
sw $8, 0($9)
lw $9, -572($sp)
add $8, $9, 4
sw $8, -572($sp)
lw $9, -576($sp)
add $8, $9, 4
sw $8, -576($sp)
lw $9, -576($sp)
lw $8, 0($9)
sw $8, -580($sp)
lw $8, -580($sp)
lw $9, -572($sp)
sw $8, 0($9)
lw $9, -572($sp)
add $8, $9, 4
sw $8, -572($sp)
lw $9, -576($sp)
add $8, $9, 4
sw $8, -576($sp)
lw $9, -576($sp)
lw $8, 0($9)
sw $8, -580($sp)
lw $8, -580($sp)
lw $9, -572($sp)
sw $8, 0($9)
lw $9, -572($sp)
add $8, $9, 4
sw $8, -572($sp)
lw $9, -576($sp)
add $8, $9, 4
sw $8, -576($sp)
lw $9, -576($sp)
lw $8, 0($9)
sw $8, -580($sp)
lw $8, -580($sp)
lw $9, -572($sp)
sw $8, 0($9)
lw $9, -572($sp)
add $8, $9, 4
sw $8, -572($sp)
lw $9, -576($sp)
add $8, $9, 4
sw $8, -576($sp)
lw $9, -576($sp)
lw $8, 0($9)
sw $8, -580($sp)
lw $8, -580($sp)
lw $9, -572($sp)
sw $8, 0($9)
lw $9, -572($sp)
add $8, $9, 4
sw $8, -572($sp)
lw $9, -576($sp)
add $8, $9, 4
sw $8, -576($sp)
lw $9, -576($sp)
lw $8, 0($9)
sw $8, -580($sp)
lw $8, -580($sp)
lw $9, -572($sp)
sw $8, 0($9)
lw $9, -572($sp)
add $8, $9, 4
sw $8, -572($sp)
lw $9, -576($sp)
add $8, $9, 4
sw $8, -576($sp)
lw $9, -576($sp)
lw $8, 0($9)
sw $8, -580($sp)
lw $8, -580($sp)
lw $9, -572($sp)
sw $8, 0($9)
lw $9, -572($sp)
add $8, $9, 4
sw $8, -572($sp)
lw $9, -576($sp)
add $8, $9, 4
sw $8, -576($sp)
lw $9, -576($sp)
lw $8, 0($9)
sw $8, -580($sp)
lw $8, -580($sp)
lw $9, -572($sp)
sw $8, 0($9)
lw $9, -572($sp)
add $8, $9, 4
sw $8, -572($sp)
lw $9, -576($sp)
add $8, $9, 4
sw $8, -576($sp)
lw $9, -576($sp)
lw $8, 0($9)
sw $8, -580($sp)
lw $8, -580($sp)
lw $9, -572($sp)
sw $8, 0($9)
lw $9, -572($sp)
add $8, $9, 4
sw $8, -572($sp)
lw $9, -576($sp)
add $8, $9, 4
sw $8, -576($sp)
lw $9, -576($sp)
lw $8, 0($9)
sw $8, -580($sp)
lw $8, -580($sp)
lw $9, -572($sp)
sw $8, 0($9)
lw $9, -572($sp)
add $8, $9, 4
sw $8, -572($sp)
lw $9, -576($sp)
add $8, $9, 4
sw $8, -576($sp)
lw $9, -576($sp)
lw $8, 0($9)
sw $8, -580($sp)
lw $8, -580($sp)
lw $9, -572($sp)
sw $8, 0($9)
lw $9, -572($sp)
add $8, $9, 4
sw $8, -572($sp)
lw $9, -576($sp)
add $8, $9, 4
sw $8, -576($sp)
lw $9, -576($sp)
lw $8, 0($9)
sw $8, -580($sp)
lw $8, -580($sp)
lw $9, -572($sp)
sw $8, 0($9)
lw $9, -572($sp)
add $8, $9, 4
sw $8, -572($sp)
lw $9, -576($sp)
add $8, $9, 4
sw $8, -576($sp)
lw $9, -576($sp)
lw $8, 0($9)
sw $8, -580($sp)
lw $8, -580($sp)
lw $9, -572($sp)
sw $8, 0($9)
lw $9, -572($sp)
add $8, $9, 4
sw $8, -572($sp)
lw $9, -576($sp)
add $8, $9, 4
sw $8, -576($sp)
label48:
label46:
lw $9, -24($sp)
move $8, $9
sw $8, -588($sp)
lw $9, -24($sp)
lw $8, 0($9)
sw $8, -584($sp)
lw $9, -584($sp)
sub $8, $9, 1
sw $8, -592($sp)
lw $8, -592($sp)
lw $9, -588($sp)
sw $8, 0($9)
j label44
label45:
lw $9, 744($a3)
move $8, $9
sw $8, -600($sp)
add $8, $29, -784
sw $8, -604($sp)
lw $8, -600($sp)
lw $9, -604($sp)
sw $8, 0($9)
add $29, $29, -784
jal __printf_single
sub $29, $29, -784
lw $9, -24($sp)
move $8, $9
sw $8, -608($sp)
li $8, 0
sw $8, -612($sp)
lw $8, -612($sp)
lw $9, -608($sp)
sw $8, 0($9)
label49:
lw $9, -24($sp)
lw $8, 0($9)
sw $8, -616($sp)
lw $9, 16($a3)
lw $8, 0($9)
sw $8, -620($sp)
lw $9, -616($sp)
lw $10, -620($sp)
sub $8, $9, $10
sw $8, -620($sp)
lw $8, -620($sp)
bgez $8, label50
lw $9, -32($sp)
move $8, $9
sw $8, -624($sp)
li $8, 0
sw $8, -628($sp)
lw $8, -628($sp)
lw $9, -624($sp)
sw $8, 0($9)
label52:
lw $9, -32($sp)
lw $8, 0($9)
sw $8, -632($sp)
lw $9, 16($a3)
lw $8, 0($9)
sw $8, -636($sp)
lw $9, -632($sp)
lw $10, -636($sp)
sub $8, $9, $10
sw $8, -636($sp)
lw $8, -636($sp)
bgez $8, label53
add $8, $29, -1024
sw $8, -656($sp)
lw $9, -32($sp)
lw $8, 0($9)
sw $8, -652($sp)
lw $8, -652($sp)
lw $9, -656($sp)
sw $8, 0($9)
add $29, $29, -1024
jal __getNode
sub $29, $29, -1024
add $8, $29, -1016
sw $8, -660($sp)
lw $9, -660($sp)
move $8, $9
sw $8, -648($sp)
add $8, $29, -904
sw $8, -664($sp)
lw $9, -664($sp)
move $8, $9
sw $8, -668($sp)
lw $9, -660($sp)
lw $8, 0($9)
sw $8, -676($sp)
lw $8, -676($sp)
lw $9, -668($sp)
sw $8, 0($9)
lw $9, -668($sp)
add $8, $9, 4
sw $8, -668($sp)
lw $9, -660($sp)
add $8, $9, 4
sw $8, -672($sp)
lw $9, -672($sp)
lw $8, 0($9)
sw $8, -676($sp)
lw $8, -676($sp)
lw $9, -668($sp)
sw $8, 0($9)
lw $9, -668($sp)
add $8, $9, 4
sw $8, -668($sp)
lw $9, -672($sp)
add $8, $9, 4
sw $8, -672($sp)
lw $9, -672($sp)
lw $8, 0($9)
sw $8, -676($sp)
lw $8, -676($sp)
lw $9, -668($sp)
sw $8, 0($9)
lw $9, -668($sp)
add $8, $9, 4
sw $8, -668($sp)
lw $9, -672($sp)
add $8, $9, 4
sw $8, -672($sp)
lw $9, -672($sp)
lw $8, 0($9)
sw $8, -676($sp)
lw $8, -676($sp)
lw $9, -668($sp)
sw $8, 0($9)
lw $9, -668($sp)
add $8, $9, 4
sw $8, -668($sp)
lw $9, -672($sp)
add $8, $9, 4
sw $8, -672($sp)
lw $9, -672($sp)
lw $8, 0($9)
sw $8, -676($sp)
lw $8, -676($sp)
lw $9, -668($sp)
sw $8, 0($9)
lw $9, -668($sp)
add $8, $9, 4
sw $8, -668($sp)
lw $9, -672($sp)
add $8, $9, 4
sw $8, -672($sp)
lw $9, -672($sp)
lw $8, 0($9)
sw $8, -676($sp)
lw $8, -676($sp)
lw $9, -668($sp)
sw $8, 0($9)
lw $9, -668($sp)
add $8, $9, 4
sw $8, -668($sp)
lw $9, -672($sp)
add $8, $9, 4
sw $8, -672($sp)
lw $9, -672($sp)
lw $8, 0($9)
sw $8, -676($sp)
lw $8, -676($sp)
lw $9, -668($sp)
sw $8, 0($9)
lw $9, -668($sp)
add $8, $9, 4
sw $8, -668($sp)
lw $9, -672($sp)
add $8, $9, 4
sw $8, -672($sp)
lw $9, -672($sp)
lw $8, 0($9)
sw $8, -676($sp)
lw $8, -676($sp)
lw $9, -668($sp)
sw $8, 0($9)
lw $9, -668($sp)
add $8, $9, 4
sw $8, -668($sp)
lw $9, -672($sp)
add $8, $9, 4
sw $8, -672($sp)
lw $9, -672($sp)
lw $8, 0($9)
sw $8, -676($sp)
lw $8, -676($sp)
lw $9, -668($sp)
sw $8, 0($9)
lw $9, -668($sp)
add $8, $9, 4
sw $8, -668($sp)
lw $9, -672($sp)
add $8, $9, 4
sw $8, -672($sp)
lw $9, -672($sp)
lw $8, 0($9)
sw $8, -676($sp)
lw $8, -676($sp)
lw $9, -668($sp)
sw $8, 0($9)
lw $9, -668($sp)
add $8, $9, 4
sw $8, -668($sp)
lw $9, -672($sp)
add $8, $9, 4
sw $8, -672($sp)
lw $9, -672($sp)
lw $8, 0($9)
sw $8, -676($sp)
lw $8, -676($sp)
lw $9, -668($sp)
sw $8, 0($9)
lw $9, -668($sp)
add $8, $9, 4
sw $8, -668($sp)
lw $9, -672($sp)
add $8, $9, 4
sw $8, -672($sp)
lw $9, -672($sp)
lw $8, 0($9)
sw $8, -676($sp)
lw $8, -676($sp)
lw $9, -668($sp)
sw $8, 0($9)
lw $9, -668($sp)
add $8, $9, 4
sw $8, -668($sp)
lw $9, -672($sp)
add $8, $9, 4
sw $8, -672($sp)
lw $9, -672($sp)
lw $8, 0($9)
sw $8, -676($sp)
lw $8, -676($sp)
lw $9, -668($sp)
sw $8, 0($9)
lw $9, -668($sp)
add $8, $9, 4
sw $8, -668($sp)
lw $9, -672($sp)
add $8, $9, 4
sw $8, -672($sp)
lw $9, -672($sp)
lw $8, 0($9)
sw $8, -676($sp)
lw $8, -676($sp)
lw $9, -668($sp)
sw $8, 0($9)
lw $9, -668($sp)
add $8, $9, 4
sw $8, -668($sp)
lw $9, -672($sp)
add $8, $9, 4
sw $8, -672($sp)
lw $9, -672($sp)
lw $8, 0($9)
sw $8, -676($sp)
lw $8, -676($sp)
lw $9, -668($sp)
sw $8, 0($9)
lw $9, -668($sp)
add $8, $9, 4
sw $8, -668($sp)
lw $9, -672($sp)
add $8, $9, 4
sw $8, -672($sp)
lw $9, -672($sp)
lw $8, 0($9)
sw $8, -676($sp)
lw $8, -676($sp)
lw $9, -668($sp)
sw $8, 0($9)
lw $9, -668($sp)
add $8, $9, 4
sw $8, -668($sp)
lw $9, -672($sp)
add $8, $9, 4
sw $8, -672($sp)
lw $9, -672($sp)
lw $8, 0($9)
sw $8, -676($sp)
lw $8, -676($sp)
lw $9, -668($sp)
sw $8, 0($9)
lw $9, -668($sp)
add $8, $9, 4
sw $8, -668($sp)
lw $9, -672($sp)
add $8, $9, 4
sw $8, -672($sp)
lw $9, -672($sp)
lw $8, 0($9)
sw $8, -676($sp)
lw $8, -676($sp)
lw $9, -668($sp)
sw $8, 0($9)
lw $9, -668($sp)
add $8, $9, 4
sw $8, -668($sp)
lw $9, -672($sp)
add $8, $9, 4
sw $8, -672($sp)
lw $9, -672($sp)
lw $8, 0($9)
sw $8, -676($sp)
lw $8, -676($sp)
lw $9, -668($sp)
sw $8, 0($9)
lw $9, -668($sp)
add $8, $9, 4
sw $8, -668($sp)
lw $9, -672($sp)
add $8, $9, 4
sw $8, -672($sp)
lw $9, -672($sp)
lw $8, 0($9)
sw $8, -676($sp)
lw $8, -676($sp)
lw $9, -668($sp)
sw $8, 0($9)
lw $9, -668($sp)
add $8, $9, 4
sw $8, -668($sp)
lw $9, -672($sp)
add $8, $9, 4
sw $8, -672($sp)
lw $9, -672($sp)
lw $8, 0($9)
sw $8, -676($sp)
lw $8, -676($sp)
lw $9, -668($sp)
sw $8, 0($9)
lw $9, -668($sp)
add $8, $9, 4
sw $8, -668($sp)
lw $9, -672($sp)
add $8, $9, 4
sw $8, -672($sp)
lw $9, -672($sp)
lw $8, 0($9)
sw $8, -676($sp)
lw $8, -676($sp)
lw $9, -668($sp)
sw $8, 0($9)
lw $9, -668($sp)
add $8, $9, 4
sw $8, -668($sp)
lw $9, -672($sp)
add $8, $9, 4
sw $8, -672($sp)
lw $9, -672($sp)
lw $8, 0($9)
sw $8, -676($sp)
lw $8, -676($sp)
lw $9, -668($sp)
sw $8, 0($9)
lw $9, -668($sp)
add $8, $9, 4
sw $8, -668($sp)
lw $9, -672($sp)
add $8, $9, 4
sw $8, -672($sp)
lw $9, -672($sp)
lw $8, 0($9)
sw $8, -676($sp)
lw $8, -676($sp)
lw $9, -668($sp)
sw $8, 0($9)
lw $9, -668($sp)
add $8, $9, 4
sw $8, -668($sp)
lw $9, -672($sp)
add $8, $9, 4
sw $8, -672($sp)
lw $9, -672($sp)
lw $8, 0($9)
sw $8, -676($sp)
lw $8, -676($sp)
lw $9, -668($sp)
sw $8, 0($9)
lw $9, -668($sp)
add $8, $9, 4
sw $8, -668($sp)
lw $9, -672($sp)
add $8, $9, 4
sw $8, -672($sp)
lw $9, -672($sp)
lw $8, 0($9)
sw $8, -676($sp)
lw $8, -676($sp)
lw $9, -668($sp)
sw $8, 0($9)
lw $9, -668($sp)
add $8, $9, 4
sw $8, -668($sp)
lw $9, -672($sp)
add $8, $9, 4
sw $8, -672($sp)
lw $9, -672($sp)
lw $8, 0($9)
sw $8, -676($sp)
lw $8, -676($sp)
lw $9, -668($sp)
sw $8, 0($9)
lw $9, -668($sp)
add $8, $9, 4
sw $8, -668($sp)
lw $9, -672($sp)
add $8, $9, 4
sw $8, -672($sp)
lw $9, -672($sp)
lw $8, 0($9)
sw $8, -676($sp)
lw $8, -676($sp)
lw $9, -668($sp)
sw $8, 0($9)
lw $9, -668($sp)
add $8, $9, 4
sw $8, -668($sp)
lw $9, -672($sp)
add $8, $9, 4
sw $8, -672($sp)
add $8, $29, -1136
sw $8, -688($sp)
lw $9, -24($sp)
lw $8, 0($9)
sw $8, -684($sp)
lw $8, -684($sp)
lw $9, -688($sp)
sw $8, 0($9)
add $29, $29, -1136
jal __getNode
sub $29, $29, -1136
add $8, $29, -1128
sw $8, -692($sp)
lw $9, -692($sp)
move $8, $9
sw $8, -680($sp)
add $8, $29, -1016
sw $8, -696($sp)
lw $9, -696($sp)
move $8, $9
sw $8, -700($sp)
lw $9, -692($sp)
lw $8, 0($9)
sw $8, -708($sp)
lw $8, -708($sp)
lw $9, -700($sp)
sw $8, 0($9)
lw $9, -700($sp)
add $8, $9, 4
sw $8, -700($sp)
lw $9, -692($sp)
add $8, $9, 4
sw $8, -704($sp)
lw $9, -704($sp)
lw $8, 0($9)
sw $8, -708($sp)
lw $8, -708($sp)
lw $9, -700($sp)
sw $8, 0($9)
lw $9, -700($sp)
add $8, $9, 4
sw $8, -700($sp)
lw $9, -704($sp)
add $8, $9, 4
sw $8, -704($sp)
lw $9, -704($sp)
lw $8, 0($9)
sw $8, -708($sp)
lw $8, -708($sp)
lw $9, -700($sp)
sw $8, 0($9)
lw $9, -700($sp)
add $8, $9, 4
sw $8, -700($sp)
lw $9, -704($sp)
add $8, $9, 4
sw $8, -704($sp)
lw $9, -704($sp)
lw $8, 0($9)
sw $8, -708($sp)
lw $8, -708($sp)
lw $9, -700($sp)
sw $8, 0($9)
lw $9, -700($sp)
add $8, $9, 4
sw $8, -700($sp)
lw $9, -704($sp)
add $8, $9, 4
sw $8, -704($sp)
lw $9, -704($sp)
lw $8, 0($9)
sw $8, -708($sp)
lw $8, -708($sp)
lw $9, -700($sp)
sw $8, 0($9)
lw $9, -700($sp)
add $8, $9, 4
sw $8, -700($sp)
lw $9, -704($sp)
add $8, $9, 4
sw $8, -704($sp)
lw $9, -704($sp)
lw $8, 0($9)
sw $8, -708($sp)
lw $8, -708($sp)
lw $9, -700($sp)
sw $8, 0($9)
lw $9, -700($sp)
add $8, $9, 4
sw $8, -700($sp)
lw $9, -704($sp)
add $8, $9, 4
sw $8, -704($sp)
lw $9, -704($sp)
lw $8, 0($9)
sw $8, -708($sp)
lw $8, -708($sp)
lw $9, -700($sp)
sw $8, 0($9)
lw $9, -700($sp)
add $8, $9, 4
sw $8, -700($sp)
lw $9, -704($sp)
add $8, $9, 4
sw $8, -704($sp)
lw $9, -704($sp)
lw $8, 0($9)
sw $8, -708($sp)
lw $8, -708($sp)
lw $9, -700($sp)
sw $8, 0($9)
lw $9, -700($sp)
add $8, $9, 4
sw $8, -700($sp)
lw $9, -704($sp)
add $8, $9, 4
sw $8, -704($sp)
lw $9, -704($sp)
lw $8, 0($9)
sw $8, -708($sp)
lw $8, -708($sp)
lw $9, -700($sp)
sw $8, 0($9)
lw $9, -700($sp)
add $8, $9, 4
sw $8, -700($sp)
lw $9, -704($sp)
add $8, $9, 4
sw $8, -704($sp)
lw $9, -704($sp)
lw $8, 0($9)
sw $8, -708($sp)
lw $8, -708($sp)
lw $9, -700($sp)
sw $8, 0($9)
lw $9, -700($sp)
add $8, $9, 4
sw $8, -700($sp)
lw $9, -704($sp)
add $8, $9, 4
sw $8, -704($sp)
lw $9, -704($sp)
lw $8, 0($9)
sw $8, -708($sp)
lw $8, -708($sp)
lw $9, -700($sp)
sw $8, 0($9)
lw $9, -700($sp)
add $8, $9, 4
sw $8, -700($sp)
lw $9, -704($sp)
add $8, $9, 4
sw $8, -704($sp)
lw $9, -704($sp)
lw $8, 0($9)
sw $8, -708($sp)
lw $8, -708($sp)
lw $9, -700($sp)
sw $8, 0($9)
lw $9, -700($sp)
add $8, $9, 4
sw $8, -700($sp)
lw $9, -704($sp)
add $8, $9, 4
sw $8, -704($sp)
lw $9, -704($sp)
lw $8, 0($9)
sw $8, -708($sp)
lw $8, -708($sp)
lw $9, -700($sp)
sw $8, 0($9)
lw $9, -700($sp)
add $8, $9, 4
sw $8, -700($sp)
lw $9, -704($sp)
add $8, $9, 4
sw $8, -704($sp)
lw $9, -704($sp)
lw $8, 0($9)
sw $8, -708($sp)
lw $8, -708($sp)
lw $9, -700($sp)
sw $8, 0($9)
lw $9, -700($sp)
add $8, $9, 4
sw $8, -700($sp)
lw $9, -704($sp)
add $8, $9, 4
sw $8, -704($sp)
lw $9, -704($sp)
lw $8, 0($9)
sw $8, -708($sp)
lw $8, -708($sp)
lw $9, -700($sp)
sw $8, 0($9)
lw $9, -700($sp)
add $8, $9, 4
sw $8, -700($sp)
lw $9, -704($sp)
add $8, $9, 4
sw $8, -704($sp)
lw $9, -704($sp)
lw $8, 0($9)
sw $8, -708($sp)
lw $8, -708($sp)
lw $9, -700($sp)
sw $8, 0($9)
lw $9, -700($sp)
add $8, $9, 4
sw $8, -700($sp)
lw $9, -704($sp)
add $8, $9, 4
sw $8, -704($sp)
lw $9, -704($sp)
lw $8, 0($9)
sw $8, -708($sp)
lw $8, -708($sp)
lw $9, -700($sp)
sw $8, 0($9)
lw $9, -700($sp)
add $8, $9, 4
sw $8, -700($sp)
lw $9, -704($sp)
add $8, $9, 4
sw $8, -704($sp)
lw $9, -704($sp)
lw $8, 0($9)
sw $8, -708($sp)
lw $8, -708($sp)
lw $9, -700($sp)
sw $8, 0($9)
lw $9, -700($sp)
add $8, $9, 4
sw $8, -700($sp)
lw $9, -704($sp)
add $8, $9, 4
sw $8, -704($sp)
lw $9, -704($sp)
lw $8, 0($9)
sw $8, -708($sp)
lw $8, -708($sp)
lw $9, -700($sp)
sw $8, 0($9)
lw $9, -700($sp)
add $8, $9, 4
sw $8, -700($sp)
lw $9, -704($sp)
add $8, $9, 4
sw $8, -704($sp)
lw $9, -704($sp)
lw $8, 0($9)
sw $8, -708($sp)
lw $8, -708($sp)
lw $9, -700($sp)
sw $8, 0($9)
lw $9, -700($sp)
add $8, $9, 4
sw $8, -700($sp)
lw $9, -704($sp)
add $8, $9, 4
sw $8, -704($sp)
lw $9, -704($sp)
lw $8, 0($9)
sw $8, -708($sp)
lw $8, -708($sp)
lw $9, -700($sp)
sw $8, 0($9)
lw $9, -700($sp)
add $8, $9, 4
sw $8, -700($sp)
lw $9, -704($sp)
add $8, $9, 4
sw $8, -704($sp)
lw $9, -704($sp)
lw $8, 0($9)
sw $8, -708($sp)
lw $8, -708($sp)
lw $9, -700($sp)
sw $8, 0($9)
lw $9, -700($sp)
add $8, $9, 4
sw $8, -700($sp)
lw $9, -704($sp)
add $8, $9, 4
sw $8, -704($sp)
lw $9, -704($sp)
lw $8, 0($9)
sw $8, -708($sp)
lw $8, -708($sp)
lw $9, -700($sp)
sw $8, 0($9)
lw $9, -700($sp)
add $8, $9, 4
sw $8, -700($sp)
lw $9, -704($sp)
add $8, $9, 4
sw $8, -704($sp)
lw $9, -704($sp)
lw $8, 0($9)
sw $8, -708($sp)
lw $8, -708($sp)
lw $9, -700($sp)
sw $8, 0($9)
lw $9, -700($sp)
add $8, $9, 4
sw $8, -700($sp)
lw $9, -704($sp)
add $8, $9, 4
sw $8, -704($sp)
lw $9, -704($sp)
lw $8, 0($9)
sw $8, -708($sp)
lw $8, -708($sp)
lw $9, -700($sp)
sw $8, 0($9)
lw $9, -700($sp)
add $8, $9, 4
sw $8, -700($sp)
lw $9, -704($sp)
add $8, $9, 4
sw $8, -704($sp)
lw $9, -704($sp)
lw $8, 0($9)
sw $8, -708($sp)
lw $8, -708($sp)
lw $9, -700($sp)
sw $8, 0($9)
lw $9, -700($sp)
add $8, $9, 4
sw $8, -700($sp)
lw $9, -704($sp)
add $8, $9, 4
sw $8, -704($sp)
lw $9, -704($sp)
lw $8, 0($9)
sw $8, -708($sp)
lw $8, -708($sp)
lw $9, -700($sp)
sw $8, 0($9)
lw $9, -700($sp)
add $8, $9, 4
sw $8, -700($sp)
lw $9, -704($sp)
add $8, $9, 4
sw $8, -704($sp)
lw $9, -704($sp)
lw $8, 0($9)
sw $8, -708($sp)
lw $8, -708($sp)
lw $9, -700($sp)
sw $8, 0($9)
lw $9, -700($sp)
add $8, $9, 4
sw $8, -700($sp)
lw $9, -704($sp)
add $8, $9, 4
sw $8, -704($sp)
add $29, $29, -1016
jal __compare
sub $29, $29, -1016
add $8, $29, -788
sw $8, -712($sp)
add $8, $29, -784
sw $8, -716($sp)
lw $9, -712($sp)
lw $8, 0($9)
sw $8, -644($sp)
lw $8, -644($sp)
lw $9, -716($sp)
sw $8, 0($9)
lw $9, 1576($a3)
move $8, $9
sw $8, -720($sp)
add $8, $29, -788
sw $8, -724($sp)
lw $8, -720($sp)
lw $9, -724($sp)
sw $8, 0($9)
add $29, $29, -788
jal __printf
sub $29, $29, -788
label54:
lw $9, -32($sp)
move $8, $9
sw $8, -732($sp)
lw $9, -32($sp)
lw $8, 0($9)
sw $8, -728($sp)
lw $9, -728($sp)
add $8, $9, 1
sw $8, -728($sp)
lw $8, -728($sp)
lw $9, -732($sp)
sw $8, 0($9)
j label52
label53:
lw $9, 744($a3)
move $8, $9
sw $8, -740($sp)
add $8, $29, -784
sw $8, -744($sp)
lw $8, -740($sp)
lw $9, -744($sp)
sw $8, 0($9)
add $29, $29, -784
jal __printf_single
sub $29, $29, -784
label51:
lw $9, -24($sp)
move $8, $9
sw $8, -752($sp)
lw $9, -24($sp)
lw $8, 0($9)
sw $8, -748($sp)
lw $9, -748($sp)
add $8, $9, 1
sw $8, -748($sp)
lw $8, -748($sp)
lw $9, -752($sp)
sw $8, 0($9)
j label49
label50:
li $8, 0
sw $8, -756($sp)
add $8, $29, 4
sw $8, -760($sp)
lw $8, -756($sp)
lw $9, -760($sp)
sw $8, 0($9)
j __main_end
j __main_end
__main_end:
li $v0, 10
syscall
#global $2 4
#global $4 4
#global $6 560
#string $180 #%d\t
#string $186 #\n
#string $212 #%c %c %d, %d\n
#string $394 #%d 
#li $3 5
#sw $3 $2 0
#li $5 5
#sw $5 $4 0
#----------------------------
#func #comp1
#addi $7 $0 0
#addi $8 $0 4
####move $9 $7
#addi $9 $7 0
#lw $9 $9 0
####move $10 $8
#addi $10 $8 0
#lw $10 $10 0
#sub $10 $9 $10
#beqz $10 l:0
#li $11 0
#addi $12 $0 12
#sw $11 $12 0
#return
#goto l:1
#label l:0
#li $13 1
#addi $14 $0 12
#sw $13 $14 0
#return
#label l:1
#return
#----------------------------
#func #compare
#addi $15 $0 0
#addi $16 $0 112
#addi $18 $0 -228
#move $17 $18
#addi $20 $0 -232
#move $19 $20
#li $21 0
#sw $21 $19 0
#move $22 $18
#li $23 0
#sw $23 $22 0
#label l:2
####move $24 $17
#lw $24 $17 0
####move $25 $2
#lw $25 $2 0
#sub $25 $24 $25
#bgez $25 l:3
#move $26 $19
#li $27 0
#sw $27 $26 0
#label l:5
####move $28 $19
#lw $28 $19 0
####move $29 $2
#lw $29 $2 0
#sub $29 $28 $29
#bgez $29 l:6
####move $30 $15
#addi $30 $15 0
####move $31 $17
#lw $31 $17 0
#muli $32 $31 20
#add $30 $30 $32
####move $33 $19
#lw $33 $19 0
#muli $34 $33 4
#add $30 $30 $34
#lw $30 $30 0
####move $35 $16
#addi $35 $16 0
####move $36 $17
#lw $36 $17 0
#muli $37 $36 20
#add $35 $35 $37
####move $38 $19
#lw $38 $19 0
#muli $39 $38 4
#add $35 $35 $39
#lw $35 $35 0
#sub $35 $30 $35
#beqz $35 l:8
#li $40 0
#addi $41 $0 228
#sw $40 $41 0
#return
#label l:8
#label l:7
####move $42 $19
#move $43 $19
#lw $42 $19 0
#addi $42 $42 1
#sw $42 $43 0
#goto l:5
#label l:6
#label l:4
####move $44 $17
#move $45 $17
#lw $44 $17 0
#addi $44 $44 1
#sw $44 $45 0
#goto l:2
#label l:3
####move $46 $15
#addi $46 $15 100
#li $47 0
#muli $48 $47 1
#add $46 $46 $48
#lb $46 $46 0
####move $49 $16
#addi $49 $16 100
#li $50 0
#muli $51 $50 1
#add $49 $49 $51
#lb $49 $49 0
#sub $49 $46 $49
#beqz $49 l:9
#li $52 0
#addi $53 $0 228
#sw $52 $53 0
#return
#goto l:10
#label l:9
####move $54 $15
#addi $54 $15 100
#li $55 1
#muli $56 $55 1
#add $54 $54 $56
#lb $54 $54 0
####move $57 $16
#addi $57 $16 100
#li $58 1
#muli $59 $58 1
#add $57 $57 $59
#lb $57 $57 0
#sub $57 $54 $57
#beqz $57 l:11
#li $60 0
#addi $61 $0 228
#sw $60 $61 0
#return
#goto l:12
#label l:11
#sw $1 $0 -240
####move $63 $16
#addi $63 $16 108
#addi $64 $0 -244
#lw $63 $63 0
#sw $63 $64 0
####move $65 $15
#addi $65 $15 108
#addi $66 $0 -248
#lw $65 $65 0
#sw $65 $66 0
#addi $0 $0 -248
#call #comp1
#subi $0 $0 -248
#lw $1 $0 -240
#addi $67 $0 -236
####move $62 $67
#addi $68 $0 228
#lw $62 $67 0
#sw $62 $68 0
#return
#label l:12
#label l:10
#li $69 -1
#addi $70 $0 228
#sw $69 $70 0
#return
#return
#----------------------------
#func #getNode
#addi $71 $0 0
####move $72 $6
####move $73 $71
#lw $73 $71 0
#muli $74 $73 112
#add $72 $6 $74
#addi $72 $72 104
#move $75 $72
#lw $72 $72 0
#addi $76 $72 1
#sw $76 $75 0
####move $77 $6
####move $78 $71
#lw $78 $71 0
#muli $79 $78 112
#add $77 $6 $79
#addi $80 $0 8
#move $81 $80
####move $82 $77
#lw $83 $77 0
#sw $83 $81 0
#addi $81 $81 4
#addi $82 $77 4
#lw $83 $82 0
#sw $83 $81 0
#addi $81 $81 4
#addi $82 $82 4
#lw $83 $82 0
#sw $83 $81 0
#addi $81 $81 4
#addi $82 $82 4
#lw $83 $82 0
#sw $83 $81 0
#addi $81 $81 4
#addi $82 $82 4
#lw $83 $82 0
#sw $83 $81 0
#addi $81 $81 4
#addi $82 $82 4
#lw $83 $82 0
#sw $83 $81 0
#addi $81 $81 4
#addi $82 $82 4
#lw $83 $82 0
#sw $83 $81 0
#addi $81 $81 4
#addi $82 $82 4
#lw $83 $82 0
#sw $83 $81 0
#addi $81 $81 4
#addi $82 $82 4
#lw $83 $82 0
#sw $83 $81 0
#addi $81 $81 4
#addi $82 $82 4
#lw $83 $82 0
#sw $83 $81 0
#addi $81 $81 4
#addi $82 $82 4
#lw $83 $82 0
#sw $83 $81 0
#addi $81 $81 4
#addi $82 $82 4
#lw $83 $82 0
#sw $83 $81 0
#addi $81 $81 4
#addi $82 $82 4
#lw $83 $82 0
#sw $83 $81 0
#addi $81 $81 4
#addi $82 $82 4
#lw $83 $82 0
#sw $83 $81 0
#addi $81 $81 4
#addi $82 $82 4
#lw $83 $82 0
#sw $83 $81 0
#addi $81 $81 4
#addi $82 $82 4
#lw $83 $82 0
#sw $83 $81 0
#addi $81 $81 4
#addi $82 $82 4
#lw $83 $82 0
#sw $83 $81 0
#addi $81 $81 4
#addi $82 $82 4
#lw $83 $82 0
#sw $83 $81 0
#addi $81 $81 4
#addi $82 $82 4
#lw $83 $82 0
#sw $83 $81 0
#addi $81 $81 4
#addi $82 $82 4
#lw $83 $82 0
#sw $83 $81 0
#addi $81 $81 4
#addi $82 $82 4
#lw $83 $82 0
#sw $83 $81 0
#addi $81 $81 4
#addi $82 $82 4
#lw $83 $82 0
#sw $83 $81 0
#addi $81 $81 4
#addi $82 $82 4
#lw $83 $82 0
#sw $83 $81 0
#addi $81 $81 4
#addi $82 $82 4
#lw $83 $82 0
#sw $83 $81 0
#addi $81 $81 4
#addi $82 $82 4
#lw $83 $82 0
#sw $83 $81 0
#addi $81 $81 4
#addi $82 $82 4
#lw $83 $82 0
#sw $83 $81 0
#addi $81 $81 4
#addi $82 $82 4
#lw $83 $82 0
#sw $83 $81 0
#addi $81 $81 4
#addi $82 $82 4
#lw $83 $82 0
#sw $83 $81 0
#addi $81 $81 4
#addi $82 $82 4
#return
#return
#----------------------------
#func #exchange
#addi $84 $0 0
#addi $85 $0 4
#addi $87 $0 -184
####move $86 $87
####move $88 $84
#lw $88 $84 0
#move $89 $87
####move $90 $88
#lw $91 $88 0
#sw $91 $89 0
#addi $89 $89 4
#addi $90 $88 4
#lw $91 $90 0
#sw $91 $89 0
#addi $89 $89 4
#addi $90 $90 4
#lw $91 $90 0
#sw $91 $89 0
#addi $89 $89 4
#addi $90 $90 4
#lw $91 $90 0
#sw $91 $89 0
#addi $89 $89 4
#addi $90 $90 4
#lw $91 $90 0
#sw $91 $89 0
#addi $89 $89 4
#addi $90 $90 4
#lw $91 $90 0
#sw $91 $89 0
#addi $89 $89 4
#addi $90 $90 4
#lw $91 $90 0
#sw $91 $89 0
#addi $89 $89 4
#addi $90 $90 4
#lw $91 $90 0
#sw $91 $89 0
#addi $89 $89 4
#addi $90 $90 4
#lw $91 $90 0
#sw $91 $89 0
#addi $89 $89 4
#addi $90 $90 4
#lw $91 $90 0
#sw $91 $89 0
#addi $89 $89 4
#addi $90 $90 4
#lw $91 $90 0
#sw $91 $89 0
#addi $89 $89 4
#addi $90 $90 4
#lw $91 $90 0
#sw $91 $89 0
#addi $89 $89 4
#addi $90 $90 4
#lw $91 $90 0
#sw $91 $89 0
#addi $89 $89 4
#addi $90 $90 4
#lw $91 $90 0
#sw $91 $89 0
#addi $89 $89 4
#addi $90 $90 4
#lw $91 $90 0
#sw $91 $89 0
#addi $89 $89 4
#addi $90 $90 4
#lw $91 $90 0
#sw $91 $89 0
#addi $89 $89 4
#addi $90 $90 4
#lw $91 $90 0
#sw $91 $89 0
#addi $89 $89 4
#addi $90 $90 4
#lw $91 $90 0
#sw $91 $89 0
#addi $89 $89 4
#addi $90 $90 4
#lw $91 $90 0
#sw $91 $89 0
#addi $89 $89 4
#addi $90 $90 4
#lw $91 $90 0
#sw $91 $89 0
#addi $89 $89 4
#addi $90 $90 4
#lw $91 $90 0
#sw $91 $89 0
#addi $89 $89 4
#addi $90 $90 4
#lw $91 $90 0
#sw $91 $89 0
#addi $89 $89 4
#addi $90 $90 4
#lw $91 $90 0
#sw $91 $89 0
#addi $89 $89 4
#addi $90 $90 4
#lw $91 $90 0
#sw $91 $89 0
#addi $89 $89 4
#addi $90 $90 4
#lw $91 $90 0
#sw $91 $89 0
#addi $89 $89 4
#addi $90 $90 4
#lw $91 $90 0
#sw $91 $89 0
#addi $89 $89 4
#addi $90 $90 4
#lw $91 $90 0
#sw $91 $89 0
#addi $89 $89 4
#addi $90 $90 4
#lw $91 $90 0
#sw $91 $89 0
#addi $89 $89 4
#addi $90 $90 4
####move $92 $84
#lw $92 $84 0
####move $93 $85
#lw $93 $85 0
#move $94 $92
####move $95 $93
#lw $96 $93 0
#sw $96 $94 0
#addi $94 $94 4
#addi $95 $93 4
#lw $96 $95 0
#sw $96 $94 0
#addi $94 $94 4
#addi $95 $95 4
#lw $96 $95 0
#sw $96 $94 0
#addi $94 $94 4
#addi $95 $95 4
#lw $96 $95 0
#sw $96 $94 0
#addi $94 $94 4
#addi $95 $95 4
#lw $96 $95 0
#sw $96 $94 0
#addi $94 $94 4
#addi $95 $95 4
#lw $96 $95 0
#sw $96 $94 0
#addi $94 $94 4
#addi $95 $95 4
#lw $96 $95 0
#sw $96 $94 0
#addi $94 $94 4
#addi $95 $95 4
#lw $96 $95 0
#sw $96 $94 0
#addi $94 $94 4
#addi $95 $95 4
#lw $96 $95 0
#sw $96 $94 0
#addi $94 $94 4
#addi $95 $95 4
#lw $96 $95 0
#sw $96 $94 0
#addi $94 $94 4
#addi $95 $95 4
#lw $96 $95 0
#sw $96 $94 0
#addi $94 $94 4
#addi $95 $95 4
#lw $96 $95 0
#sw $96 $94 0
#addi $94 $94 4
#addi $95 $95 4
#lw $96 $95 0
#sw $96 $94 0
#addi $94 $94 4
#addi $95 $95 4
#lw $96 $95 0
#sw $96 $94 0
#addi $94 $94 4
#addi $95 $95 4
#lw $96 $95 0
#sw $96 $94 0
#addi $94 $94 4
#addi $95 $95 4
#lw $96 $95 0
#sw $96 $94 0
#addi $94 $94 4
#addi $95 $95 4
#lw $96 $95 0
#sw $96 $94 0
#addi $94 $94 4
#addi $95 $95 4
#lw $96 $95 0
#sw $96 $94 0
#addi $94 $94 4
#addi $95 $95 4
#lw $96 $95 0
#sw $96 $94 0
#addi $94 $94 4
#addi $95 $95 4
#lw $96 $95 0
#sw $96 $94 0
#addi $94 $94 4
#addi $95 $95 4
#lw $96 $95 0
#sw $96 $94 0
#addi $94 $94 4
#addi $95 $95 4
#lw $96 $95 0
#sw $96 $94 0
#addi $94 $94 4
#addi $95 $95 4
#lw $96 $95 0
#sw $96 $94 0
#addi $94 $94 4
#addi $95 $95 4
#lw $96 $95 0
#sw $96 $94 0
#addi $94 $94 4
#addi $95 $95 4
#lw $96 $95 0
#sw $96 $94 0
#addi $94 $94 4
#addi $95 $95 4
#lw $96 $95 0
#sw $96 $94 0
#addi $94 $94 4
#addi $95 $95 4
#lw $96 $95 0
#sw $96 $94 0
#addi $94 $94 4
#addi $95 $95 4
#lw $96 $95 0
#sw $96 $94 0
#addi $94 $94 4
#addi $95 $95 4
####move $97 $85
#lw $97 $85 0
####move $98 $87
#move $99 $97
####move $100 $87
#lw $101 $87 0
#sw $101 $99 0
#addi $99 $99 4
#addi $100 $87 4
#lw $101 $100 0
#sw $101 $99 0
#addi $99 $99 4
#addi $100 $100 4
#lw $101 $100 0
#sw $101 $99 0
#addi $99 $99 4
#addi $100 $100 4
#lw $101 $100 0
#sw $101 $99 0
#addi $99 $99 4
#addi $100 $100 4
#lw $101 $100 0
#sw $101 $99 0
#addi $99 $99 4
#addi $100 $100 4
#lw $101 $100 0
#sw $101 $99 0
#addi $99 $99 4
#addi $100 $100 4
#lw $101 $100 0
#sw $101 $99 0
#addi $99 $99 4
#addi $100 $100 4
#lw $101 $100 0
#sw $101 $99 0
#addi $99 $99 4
#addi $100 $100 4
#lw $101 $100 0
#sw $101 $99 0
#addi $99 $99 4
#addi $100 $100 4
#lw $101 $100 0
#sw $101 $99 0
#addi $99 $99 4
#addi $100 $100 4
#lw $101 $100 0
#sw $101 $99 0
#addi $99 $99 4
#addi $100 $100 4
#lw $101 $100 0
#sw $101 $99 0
#addi $99 $99 4
#addi $100 $100 4
#lw $101 $100 0
#sw $101 $99 0
#addi $99 $99 4
#addi $100 $100 4
#lw $101 $100 0
#sw $101 $99 0
#addi $99 $99 4
#addi $100 $100 4
#lw $101 $100 0
#sw $101 $99 0
#addi $99 $99 4
#addi $100 $100 4
#lw $101 $100 0
#sw $101 $99 0
#addi $99 $99 4
#addi $100 $100 4
#lw $101 $100 0
#sw $101 $99 0
#addi $99 $99 4
#addi $100 $100 4
#lw $101 $100 0
#sw $101 $99 0
#addi $99 $99 4
#addi $100 $100 4
#lw $101 $100 0
#sw $101 $99 0
#addi $99 $99 4
#addi $100 $100 4
#lw $101 $100 0
#sw $101 $99 0
#addi $99 $99 4
#addi $100 $100 4
#lw $101 $100 0
#sw $101 $99 0
#addi $99 $99 4
#addi $100 $100 4
#lw $101 $100 0
#sw $101 $99 0
#addi $99 $99 4
#addi $100 $100 4
#lw $101 $100 0
#sw $101 $99 0
#addi $99 $99 4
#addi $100 $100 4
#lw $101 $100 0
#sw $101 $99 0
#addi $99 $99 4
#addi $100 $100 4
#lw $101 $100 0
#sw $101 $99 0
#addi $99 $99 4
#addi $100 $100 4
#lw $101 $100 0
#sw $101 $99 0
#addi $99 $99 4
#addi $100 $100 4
#lw $101 $100 0
#sw $101 $99 0
#addi $99 $99 4
#addi $100 $100 4
#lw $101 $100 0
#sw $101 $99 0
#addi $99 $99 4
#addi $100 $100 4
#return
#----------------------------
#func #comp
#addi $102 $0 0
#addi $103 $0 4
#addi $105 $0 -332
#move $104 $105
#sw $1 $0 -448
####move $107 $102
#addi $108 $0 -452
#lw $107 $102 0
#sw $107 $108 0
#addi $0 $0 -452
#call #getNode
#subi $0 $0 -452
#lw $1 $0 -448
#addi $109 $0 -444
#move $106 $109
#move $110 $105
####move $111 $109
#lw $112 $109 0
#sw $112 $110 0
#addi $110 $110 4
#addi $111 $109 4
#lw $112 $111 0
#sw $112 $110 0
#addi $110 $110 4
#addi $111 $111 4
#lw $112 $111 0
#sw $112 $110 0
#addi $110 $110 4
#addi $111 $111 4
#lw $112 $111 0
#sw $112 $110 0
#addi $110 $110 4
#addi $111 $111 4
#lw $112 $111 0
#sw $112 $110 0
#addi $110 $110 4
#addi $111 $111 4
#lw $112 $111 0
#sw $112 $110 0
#addi $110 $110 4
#addi $111 $111 4
#lw $112 $111 0
#sw $112 $110 0
#addi $110 $110 4
#addi $111 $111 4
#lw $112 $111 0
#sw $112 $110 0
#addi $110 $110 4
#addi $111 $111 4
#lw $112 $111 0
#sw $112 $110 0
#addi $110 $110 4
#addi $111 $111 4
#lw $112 $111 0
#sw $112 $110 0
#addi $110 $110 4
#addi $111 $111 4
#lw $112 $111 0
#sw $112 $110 0
#addi $110 $110 4
#addi $111 $111 4
#lw $112 $111 0
#sw $112 $110 0
#addi $110 $110 4
#addi $111 $111 4
#lw $112 $111 0
#sw $112 $110 0
#addi $110 $110 4
#addi $111 $111 4
#lw $112 $111 0
#sw $112 $110 0
#addi $110 $110 4
#addi $111 $111 4
#lw $112 $111 0
#sw $112 $110 0
#addi $110 $110 4
#addi $111 $111 4
#lw $112 $111 0
#sw $112 $110 0
#addi $110 $110 4
#addi $111 $111 4
#lw $112 $111 0
#sw $112 $110 0
#addi $110 $110 4
#addi $111 $111 4
#lw $112 $111 0
#sw $112 $110 0
#addi $110 $110 4
#addi $111 $111 4
#lw $112 $111 0
#sw $112 $110 0
#addi $110 $110 4
#addi $111 $111 4
#lw $112 $111 0
#sw $112 $110 0
#addi $110 $110 4
#addi $111 $111 4
#lw $112 $111 0
#sw $112 $110 0
#addi $110 $110 4
#addi $111 $111 4
#lw $112 $111 0
#sw $112 $110 0
#addi $110 $110 4
#addi $111 $111 4
#lw $112 $111 0
#sw $112 $110 0
#addi $110 $110 4
#addi $111 $111 4
#lw $112 $111 0
#sw $112 $110 0
#addi $110 $110 4
#addi $111 $111 4
#lw $112 $111 0
#sw $112 $110 0
#addi $110 $110 4
#addi $111 $111 4
#lw $112 $111 0
#sw $112 $110 0
#addi $110 $110 4
#addi $111 $111 4
#lw $112 $111 0
#sw $112 $110 0
#addi $110 $110 4
#addi $111 $111 4
#lw $112 $111 0
#sw $112 $110 0
#addi $110 $110 4
#addi $111 $111 4
#addi $114 $0 -444
#move $113 $114
#sw $1 $0 -560
####move $116 $103
#addi $117 $0 -564
#lw $116 $103 0
#sw $116 $117 0
#addi $0 $0 -564
#call #getNode
#subi $0 $0 -564
#lw $1 $0 -560
#addi $118 $0 -556
#move $115 $118
#move $119 $114
####move $120 $118
#lw $121 $118 0
#sw $121 $119 0
#addi $119 $119 4
#addi $120 $118 4
#lw $121 $120 0
#sw $121 $119 0
#addi $119 $119 4
#addi $120 $120 4
#lw $121 $120 0
#sw $121 $119 0
#addi $119 $119 4
#addi $120 $120 4
#lw $121 $120 0
#sw $121 $119 0
#addi $119 $119 4
#addi $120 $120 4
#lw $121 $120 0
#sw $121 $119 0
#addi $119 $119 4
#addi $120 $120 4
#lw $121 $120 0
#sw $121 $119 0
#addi $119 $119 4
#addi $120 $120 4
#lw $121 $120 0
#sw $121 $119 0
#addi $119 $119 4
#addi $120 $120 4
#lw $121 $120 0
#sw $121 $119 0
#addi $119 $119 4
#addi $120 $120 4
#lw $121 $120 0
#sw $121 $119 0
#addi $119 $119 4
#addi $120 $120 4
#lw $121 $120 0
#sw $121 $119 0
#addi $119 $119 4
#addi $120 $120 4
#lw $121 $120 0
#sw $121 $119 0
#addi $119 $119 4
#addi $120 $120 4
#lw $121 $120 0
#sw $121 $119 0
#addi $119 $119 4
#addi $120 $120 4
#lw $121 $120 0
#sw $121 $119 0
#addi $119 $119 4
#addi $120 $120 4
#lw $121 $120 0
#sw $121 $119 0
#addi $119 $119 4
#addi $120 $120 4
#lw $121 $120 0
#sw $121 $119 0
#addi $119 $119 4
#addi $120 $120 4
#lw $121 $120 0
#sw $121 $119 0
#addi $119 $119 4
#addi $120 $120 4
#lw $121 $120 0
#sw $121 $119 0
#addi $119 $119 4
#addi $120 $120 4
#lw $121 $120 0
#sw $121 $119 0
#addi $119 $119 4
#addi $120 $120 4
#lw $121 $120 0
#sw $121 $119 0
#addi $119 $119 4
#addi $120 $120 4
#lw $121 $120 0
#sw $121 $119 0
#addi $119 $119 4
#addi $120 $120 4
#lw $121 $120 0
#sw $121 $119 0
#addi $119 $119 4
#addi $120 $120 4
#lw $121 $120 0
#sw $121 $119 0
#addi $119 $119 4
#addi $120 $120 4
#lw $121 $120 0
#sw $121 $119 0
#addi $119 $119 4
#addi $120 $120 4
#lw $121 $120 0
#sw $121 $119 0
#addi $119 $119 4
#addi $120 $120 4
#lw $121 $120 0
#sw $121 $119 0
#addi $119 $119 4
#addi $120 $120 4
#lw $121 $120 0
#sw $121 $119 0
#addi $119 $119 4
#addi $120 $120 4
#lw $121 $120 0
#sw $121 $119 0
#addi $119 $119 4
#addi $120 $120 4
#lw $121 $120 0
#sw $121 $119 0
#addi $119 $119 4
#addi $120 $120 4
#addi $123 $0 -448
#move $122 $123
#li $124 0
#sw $124 $122 0
#addi $126 $0 -452
#move $125 $126
#li $127 0
#sw $127 $125 0
#label l:13
####move $128 $122
#lw $128 $122 0
####move $129 $2
#lw $129 $2 0
#sub $129 $128 $129
#bgez $129 l:14
#label l:16
####move $130 $125
#lw $130 $125 0
####move $131 $2
#lw $131 $2 0
#sub $131 $130 $131
#bgez $131 l:17
####move $132 $104
#addi $132 $104 0
####move $133 $122
#lw $133 $122 0
#muli $134 $133 20
#add $132 $132 $134
####move $135 $125
#lw $135 $125 0
#muli $136 $135 4
#add $132 $132 $136
#lw $132 $132 0
####move $137 $113
#addi $137 $113 0
####move $138 $122
#lw $138 $122 0
#muli $139 $138 20
#add $137 $137 $139
####move $140 $125
#lw $140 $125 0
#muli $141 $140 4
#add $137 $137 $141
#lw $137 $137 0
#sub $137 $132 $137
#blez $137 l:19
#sw $1 $0 -456
#move $143 $113
#addi $144 $0 -460
#sw $143 $144 0
#move $145 $104
#addi $146 $0 -464
#sw $145 $146 0
#addi $0 $0 -464
#call #exchange
#subi $0 $0 -464
#lw $1 $0 -456
####move $147 $104
#addi $147 $104 108
#addi $147 $147 0
#move $148 $147
#lw $147 $147 0
#addi $149 $147 1
#sw $149 $148 0
####move $150 $113
#addi $150 $113 108
#addi $150 $150 0
#move $151 $150
#lw $150 $150 0
#subi $152 $150 1
#sw $152 $151 0
#label l:19
#label l:18
####move $153 $125
#move $154 $125
#lw $153 $125 0
#addi $153 $153 1
#sw $153 $154 0
#goto l:16
#label l:17
#label l:15
####move $155 $122
#move $156 $122
#lw $155 $122 0
#addi $155 $155 1
#sw $155 $156 0
#goto l:13
#label l:14
#return
#----------------------------
#func #show
#addi $157 $0 0
#addi $159 $0 -220
#move $158 $159
#move $160 $159
#li $161 0
#sw $161 $160 0
#label l:20
####move $162 $158
#lw $162 $158 0
####move $163 $2
#lw $163 $2 0
#sub $163 $162 $163
#bgez $163 l:21
#addi $165 $0 -224
#move $164 $165
#move $166 $165
#li $167 0
#sw $167 $166 0
#label l:23
####move $168 $164
#lw $168 $164 0
####move $169 $2
#lw $169 $2 0
#sub $169 $168 $169
#bgez $169 l:24
#sw $1 $0 -228
####move $171 $6
####move $172 $157
#lw $172 $157 0
#muli $173 $172 112
#add $171 $6 $173
#addi $171 $171 0
####move $174 $158
#lw $174 $158 0
#muli $175 $174 20
#add $171 $171 $175
####move $176 $164
#lw $176 $164 0
#muli $177 $176 4
#add $171 $171 $177
#addi $178 $0 -232
#lw $171 $171 0
#sw $171 $178 0
#move $179 $180
#addi $181 $0 -236
#sw $179 $181 0
#addi $0 $0 -236
#call #printf
#subi $0 $0 -236
#lw $1 $0 -228
#label l:25
####move $182 $164
#move $183 $164
#lw $182 $164 0
#addi $182 $182 1
#sw $182 $183 0
#goto l:23
#label l:24
#sw $1 $0 -228
#move $185 $186
#addi $187 $0 -232
#sw $185 $187 0
#addi $0 $0 -232
#call #printf_single
#subi $0 $0 -232
#lw $1 $0 -228
#label l:22
####move $188 $158
#move $189 $158
#lw $188 $158 0
#addi $188 $188 1
#sw $188 $189 0
#goto l:20
#label l:21
#sw $1 $0 -224
####move $191 $6
####move $192 $157
#lw $192 $157 0
#muli $193 $192 112
#add $191 $6 $193
#addi $191 $191 108
#addi $191 $191 0
#addi $194 $0 -228
#lw $191 $191 0
#sw $191 $194 0
####move $195 $6
####move $196 $157
#lw $196 $157 0
#muli $197 $196 112
#add $195 $6 $197
#addi $195 $195 104
#addi $198 $0 -232
#lw $195 $195 0
#sw $195 $198 0
####move $199 $6
####move $200 $157
#lw $200 $157 0
#muli $201 $200 112
#add $199 $6 $201
#addi $199 $199 100
#li $202 1
#muli $203 $202 1
#add $199 $199 $203
#addi $204 $0 -236
#lb $199 $199 0
#sb $199 $204 0
####move $205 $6
####move $206 $157
#lw $206 $157 0
#muli $207 $206 112
#add $205 $6 $207
#addi $205 $205 100
#li $208 0
#muli $209 $208 1
#add $205 $205 $209
#addi $210 $0 -240
#lb $205 $205 0
#sb $205 $210 0
#move $211 $212
#addi $213 $0 -244
#sw $211 $213 0
#addi $0 $0 -244
#call #printf
#subi $0 $0 -244
#lw $1 $0 -224
#return
#----------------------------
#func #main
#addi $215 $0 -764
#move $214 $215
#li $216 7
#sw $216 $214 0
#addi $218 $0 -768
#move $217 $218
#addi $220 $0 -772
#move $219 $220
#addi $222 $0 -776
#move $221 $222
#move $223 $218
#li $224 0
#sw $224 $223 0
#label l:26
####move $225 $217
#lw $225 $217 0
####move $226 $4
#lw $226 $4 0
#sub $226 $225 $226
#bgez $226 l:27
#move $227 $219
#li $228 0
#sw $228 $227 0
#label l:29
####move $229 $219
#lw $229 $219 0
####move $230 $2
#lw $230 $2 0
#sub $230 $229 $230
#bgez $230 l:30
#move $231 $221
#li $232 0
#sw $232 $231 0
#label l:32
####move $233 $221
#lw $233 $221 0
####move $234 $2
#lw $234 $2 0
#sub $234 $233 $234
#bgez $234 l:33
####move $236 $6
####move $237 $217
#lw $237 $217 0
#muli $238 $237 112
#add $236 $6 $238
#addi $236 $236 0
####move $239 $219
#lw $239 $219 0
#muli $240 $239 20
#add $236 $236 $240
####move $241 $221
#lw $241 $221 0
#muli $242 $241 4
#add $236 $236 $242
####move $243 $219
#lw $243 $219 0
#li $244 5110
#mul $243 $243 $244
####move $245 $221
#lw $245 $221 0
#add $243 $243 $245
#li $246 34
####move $247 $217
#lw $247 $217 0
#sub $246 $246 $247
#mod $243 $243 $246
#li $248 1
#add $243 $243 $248
#sw $243 $236 0
####move $249 $6
####move $250 $217
#lw $250 $217 0
#muli $251 $250 112
#add $249 $6 $251
#addi $249 $249 100
#li $252 0
#muli $253 $252 1
#add $249 $249 $253
####move $254 $217
#lw $254 $217 0
####move $255 $219
#lw $255 $219 0
####move $256 $219
#lw $256 $219 0
#mul $255 $255 $256
####move $257 $219
#lw $257 $219 0
#mul $255 $255 $257
#add $254 $254 $255
#sb $254 $249 0
####move $258 $6
####move $259 $217
#lw $259 $217 0
#muli $260 $259 112
#add $258 $6 $260
#addi $258 $258 100
#li $261 1
#muli $262 $261 1
#add $258 $258 $262
####move $263 $221
#lw $263 $221 0
####move $264 $219
#lw $264 $219 0
#add $263 $263 $264
####move $265 $217
#lw $265 $217 0
#add $263 $263 $265
#li $266 1
#shl $263 $263 $266
#sb $263 $258 0
####move $235 $6
####move $267 $217
#lw $267 $217 0
#muli $268 $267 112
#add $235 $6 $268
#addi $235 $235 108
#addi $235 $235 0
####move $269 $217
#lw $269 $217 0
####move $270 $219
#lw $270 $219 0
#not $270 $270
#add $269 $269 $270
####move $271 $221
#lw $271 $221 0
#or $269 $269 $271
#sw $269 $235 0
####move $272 $6
####move $273 $217
#lw $273 $217 0
#muli $274 $273 112
#add $272 $6 $274
#addi $272 $272 100
#li $275 0
#muli $276 $275 1
#add $272 $272 $276
####move $277 $6
####move $278 $217
#lw $278 $217 0
#muli $279 $278 112
#add $277 $6 $279
#addi $277 $277 100
#li $280 0
#muli $281 $280 1
#add $277 $277 $281
#lb $277 $277 0
#li $282 26
#mod $277 $277 $282
#li $283 97
#add $277 $277 $283
#sb $277 $272 0
####move $284 $6
####move $285 $217
#lw $285 $217 0
#muli $286 $285 112
#add $284 $6 $286
#addi $284 $284 100
#li $287 1
#muli $288 $287 1
#add $284 $284 $288
####move $289 $6
####move $290 $217
#lw $290 $217 0
#muli $291 $290 112
#add $289 $6 $291
#addi $289 $289 100
#li $292 1
#muli $293 $292 1
#add $289 $289 $293
#lb $289 $289 0
#li $294 26
#mod $289 $289 $294
#li $295 65
#add $289 $289 $295
#sb $289 $284 0
#label l:34
####move $296 $221
#move $297 $221
#lw $296 $221 0
#addi $296 $296 1
#sw $296 $297 0
#goto l:32
#label l:33
#label l:31
####move $298 $219
#move $299 $219
#lw $298 $219 0
#addi $298 $298 1
#sw $298 $299 0
#goto l:29
#label l:30
#label l:28
####move $300 $217
#move $301 $217
#lw $300 $217 0
#addi $300 $300 1
#sw $300 $301 0
#goto l:26
#label l:27
#move $302 $219
#li $303 0
#sw $303 $302 0
#label l:35
####move $304 $219
#lw $304 $219 0
####move $305 $4
#lw $305 $4 0
#sub $305 $304 $305
#bgez $305 l:36
#move $306 $221
#li $307 0
#sw $307 $306 0
#label l:38
####move $308 $221
#lw $308 $221 0
####move $309 $4
#lw $309 $4 0
#sub $309 $308 $309
#bgez $309 l:39
####move $311 $221
#addi $312 $0 -788
#lw $311 $221 0
#sw $311 $312 0
####move $313 $219
#addi $314 $0 -792
#lw $313 $219 0
#sw $313 $314 0
#addi $0 $0 -792
#call #comp
#subi $0 $0 -792
#addi $315 $0 -780
#move $310 $315
#label l:40
####move $316 $221
#move $317 $221
#lw $316 $221 0
#addi $316 $316 1
#sw $316 $317 0
#goto l:38
#label l:39
#label l:37
####move $318 $219
#move $319 $219
#lw $318 $219 0
#addi $318 $318 1
#sw $318 $319 0
#goto l:35
#label l:36
#move $320 $217
#li $321 0
#sw $321 $320 0
#label l:41
####move $322 $217
#lw $322 $217 0
####move $323 $4
#lw $323 $4 0
#sub $323 $322 $323
#bgez $323 l:42
####move $325 $217
#addi $326 $0 -784
#lw $325 $217 0
#sw $325 $326 0
#addi $0 $0 -784
#call #show
#subi $0 $0 -784
#label l:43
####move $327 $217
#move $328 $217
#lw $327 $217 0
#addi $327 $327 1
#sw $327 $328 0
#goto l:41
#label l:42
#move $329 $219
####move $330 $4
#lw $330 $4 0
#li $331 1
#sub $330 $330 $331
#sw $330 $329 0
#label l:44
####move $332 $219
#lw $332 $219 0
#li $333 -1
#sub $333 $332 $333
#blez $333 l:45
####move $334 $219
#lw $334 $219 0
#li $335 3
#mod $334 $334 $335
#li $336 0
#sub $336 $334 $336
#bnez $336 l:47
####move $337 $6
####move $338 $219
#lw $338 $219 0
#muli $339 $338 112
#add $337 $6 $339
####move $341 $219
#lw $341 $219 0
#li $342 3
#add $341 $341 $342
####move $343 $4
#lw $343 $4 0
#mod $341 $341 $343
#addi $344 $0 -896
#sw $341 $344 0
#addi $0 $0 -896
#call #getNode
#subi $0 $0 -896
#addi $345 $0 -888
#move $340 $345
#move $346 $337
####move $347 $345
#lw $348 $345 0
#sw $348 $346 0
#addi $346 $346 4
#addi $347 $345 4
#lw $348 $347 0
#sw $348 $346 0
#addi $346 $346 4
#addi $347 $347 4
#lw $348 $347 0
#sw $348 $346 0
#addi $346 $346 4
#addi $347 $347 4
#lw $348 $347 0
#sw $348 $346 0
#addi $346 $346 4
#addi $347 $347 4
#lw $348 $347 0
#sw $348 $346 0
#addi $346 $346 4
#addi $347 $347 4
#lw $348 $347 0
#sw $348 $346 0
#addi $346 $346 4
#addi $347 $347 4
#lw $348 $347 0
#sw $348 $346 0
#addi $346 $346 4
#addi $347 $347 4
#lw $348 $347 0
#sw $348 $346 0
#addi $346 $346 4
#addi $347 $347 4
#lw $348 $347 0
#sw $348 $346 0
#addi $346 $346 4
#addi $347 $347 4
#lw $348 $347 0
#sw $348 $346 0
#addi $346 $346 4
#addi $347 $347 4
#lw $348 $347 0
#sw $348 $346 0
#addi $346 $346 4
#addi $347 $347 4
#lw $348 $347 0
#sw $348 $346 0
#addi $346 $346 4
#addi $347 $347 4
#lw $348 $347 0
#sw $348 $346 0
#addi $346 $346 4
#addi $347 $347 4
#lw $348 $347 0
#sw $348 $346 0
#addi $346 $346 4
#addi $347 $347 4
#lw $348 $347 0
#sw $348 $346 0
#addi $346 $346 4
#addi $347 $347 4
#lw $348 $347 0
#sw $348 $346 0
#addi $346 $346 4
#addi $347 $347 4
#lw $348 $347 0
#sw $348 $346 0
#addi $346 $346 4
#addi $347 $347 4
#lw $348 $347 0
#sw $348 $346 0
#addi $346 $346 4
#addi $347 $347 4
#lw $348 $347 0
#sw $348 $346 0
#addi $346 $346 4
#addi $347 $347 4
#lw $348 $347 0
#sw $348 $346 0
#addi $346 $346 4
#addi $347 $347 4
#lw $348 $347 0
#sw $348 $346 0
#addi $346 $346 4
#addi $347 $347 4
#lw $348 $347 0
#sw $348 $346 0
#addi $346 $346 4
#addi $347 $347 4
#lw $348 $347 0
#sw $348 $346 0
#addi $346 $346 4
#addi $347 $347 4
#lw $348 $347 0
#sw $348 $346 0
#addi $346 $346 4
#addi $347 $347 4
#lw $348 $347 0
#sw $348 $346 0
#addi $346 $346 4
#addi $347 $347 4
#lw $348 $347 0
#sw $348 $346 0
#addi $346 $346 4
#addi $347 $347 4
#lw $348 $347 0
#sw $348 $346 0
#addi $346 $346 4
#addi $347 $347 4
#lw $348 $347 0
#sw $348 $346 0
#addi $346 $346 4
#addi $347 $347 4
#goto l:48
#label l:47
####move $349 $6
####move $350 $219
#lw $350 $219 0
#muli $351 $350 112
#add $349 $6 $351
####move $353 $219
#addi $354 $0 -896
#lw $353 $219 0
#sw $353 $354 0
#addi $0 $0 -896
#call #getNode
#subi $0 $0 -896
#addi $355 $0 -888
#move $352 $355
#move $356 $349
####move $357 $355
#lw $358 $355 0
#sw $358 $356 0
#addi $356 $356 4
#addi $357 $355 4
#lw $358 $357 0
#sw $358 $356 0
#addi $356 $356 4
#addi $357 $357 4
#lw $358 $357 0
#sw $358 $356 0
#addi $356 $356 4
#addi $357 $357 4
#lw $358 $357 0
#sw $358 $356 0
#addi $356 $356 4
#addi $357 $357 4
#lw $358 $357 0
#sw $358 $356 0
#addi $356 $356 4
#addi $357 $357 4
#lw $358 $357 0
#sw $358 $356 0
#addi $356 $356 4
#addi $357 $357 4
#lw $358 $357 0
#sw $358 $356 0
#addi $356 $356 4
#addi $357 $357 4
#lw $358 $357 0
#sw $358 $356 0
#addi $356 $356 4
#addi $357 $357 4
#lw $358 $357 0
#sw $358 $356 0
#addi $356 $356 4
#addi $357 $357 4
#lw $358 $357 0
#sw $358 $356 0
#addi $356 $356 4
#addi $357 $357 4
#lw $358 $357 0
#sw $358 $356 0
#addi $356 $356 4
#addi $357 $357 4
#lw $358 $357 0
#sw $358 $356 0
#addi $356 $356 4
#addi $357 $357 4
#lw $358 $357 0
#sw $358 $356 0
#addi $356 $356 4
#addi $357 $357 4
#lw $358 $357 0
#sw $358 $356 0
#addi $356 $356 4
#addi $357 $357 4
#lw $358 $357 0
#sw $358 $356 0
#addi $356 $356 4
#addi $357 $357 4
#lw $358 $357 0
#sw $358 $356 0
#addi $356 $356 4
#addi $357 $357 4
#lw $358 $357 0
#sw $358 $356 0
#addi $356 $356 4
#addi $357 $357 4
#lw $358 $357 0
#sw $358 $356 0
#addi $356 $356 4
#addi $357 $357 4
#lw $358 $357 0
#sw $358 $356 0
#addi $356 $356 4
#addi $357 $357 4
#lw $358 $357 0
#sw $358 $356 0
#addi $356 $356 4
#addi $357 $357 4
#lw $358 $357 0
#sw $358 $356 0
#addi $356 $356 4
#addi $357 $357 4
#lw $358 $357 0
#sw $358 $356 0
#addi $356 $356 4
#addi $357 $357 4
#lw $358 $357 0
#sw $358 $356 0
#addi $356 $356 4
#addi $357 $357 4
#lw $358 $357 0
#sw $358 $356 0
#addi $356 $356 4
#addi $357 $357 4
#lw $358 $357 0
#sw $358 $356 0
#addi $356 $356 4
#addi $357 $357 4
#lw $358 $357 0
#sw $358 $356 0
#addi $356 $356 4
#addi $357 $357 4
#lw $358 $357 0
#sw $358 $356 0
#addi $356 $356 4
#addi $357 $357 4
#lw $358 $357 0
#sw $358 $356 0
#addi $356 $356 4
#addi $357 $357 4
#label l:48
#label l:46
####move $359 $219
#move $360 $219
#lw $359 $219 0
#subi $361 $359 1
#sw $361 $360 0
#goto l:44
#label l:45
#move $363 $186
#addi $364 $0 -784
#sw $363 $364 0
#addi $0 $0 -784
#call #printf_single
#subi $0 $0 -784
#move $365 $219
#li $366 0
#sw $366 $365 0
#label l:49
####move $367 $219
#lw $367 $219 0
####move $368 $4
#lw $368 $4 0
#sub $368 $367 $368
#bgez $368 l:50
#move $369 $221
#li $370 0
#sw $370 $369 0
#label l:52
####move $371 $221
#lw $371 $221 0
####move $372 $4
#lw $372 $4 0
#sub $372 $371 $372
#bgez $372 l:53
####move $376 $221
#addi $377 $0 -1024
#lw $376 $221 0
#sw $376 $377 0
#addi $0 $0 -1024
#call #getNode
#subi $0 $0 -1024
#addi $378 $0 -1016
#move $375 $378
#addi $379 $0 -904
#move $380 $379
####move $381 $378
#lw $382 $378 0
#sw $382 $380 0
#addi $380 $380 4
#addi $381 $378 4
#lw $382 $381 0
#sw $382 $380 0
#addi $380 $380 4
#addi $381 $381 4
#lw $382 $381 0
#sw $382 $380 0
#addi $380 $380 4
#addi $381 $381 4
#lw $382 $381 0
#sw $382 $380 0
#addi $380 $380 4
#addi $381 $381 4
#lw $382 $381 0
#sw $382 $380 0
#addi $380 $380 4
#addi $381 $381 4
#lw $382 $381 0
#sw $382 $380 0
#addi $380 $380 4
#addi $381 $381 4
#lw $382 $381 0
#sw $382 $380 0
#addi $380 $380 4
#addi $381 $381 4
#lw $382 $381 0
#sw $382 $380 0
#addi $380 $380 4
#addi $381 $381 4
#lw $382 $381 0
#sw $382 $380 0
#addi $380 $380 4
#addi $381 $381 4
#lw $382 $381 0
#sw $382 $380 0
#addi $380 $380 4
#addi $381 $381 4
#lw $382 $381 0
#sw $382 $380 0
#addi $380 $380 4
#addi $381 $381 4
#lw $382 $381 0
#sw $382 $380 0
#addi $380 $380 4
#addi $381 $381 4
#lw $382 $381 0
#sw $382 $380 0
#addi $380 $380 4
#addi $381 $381 4
#lw $382 $381 0
#sw $382 $380 0
#addi $380 $380 4
#addi $381 $381 4
#lw $382 $381 0
#sw $382 $380 0
#addi $380 $380 4
#addi $381 $381 4
#lw $382 $381 0
#sw $382 $380 0
#addi $380 $380 4
#addi $381 $381 4
#lw $382 $381 0
#sw $382 $380 0
#addi $380 $380 4
#addi $381 $381 4
#lw $382 $381 0
#sw $382 $380 0
#addi $380 $380 4
#addi $381 $381 4
#lw $382 $381 0
#sw $382 $380 0
#addi $380 $380 4
#addi $381 $381 4
#lw $382 $381 0
#sw $382 $380 0
#addi $380 $380 4
#addi $381 $381 4
#lw $382 $381 0
#sw $382 $380 0
#addi $380 $380 4
#addi $381 $381 4
#lw $382 $381 0
#sw $382 $380 0
#addi $380 $380 4
#addi $381 $381 4
#lw $382 $381 0
#sw $382 $380 0
#addi $380 $380 4
#addi $381 $381 4
#lw $382 $381 0
#sw $382 $380 0
#addi $380 $380 4
#addi $381 $381 4
#lw $382 $381 0
#sw $382 $380 0
#addi $380 $380 4
#addi $381 $381 4
#lw $382 $381 0
#sw $382 $380 0
#addi $380 $380 4
#addi $381 $381 4
#lw $382 $381 0
#sw $382 $380 0
#addi $380 $380 4
#addi $381 $381 4
#lw $382 $381 0
#sw $382 $380 0
#addi $380 $380 4
#addi $381 $381 4
####move $384 $219
#addi $385 $0 -1136
#lw $384 $219 0
#sw $384 $385 0
#addi $0 $0 -1136
#call #getNode
#subi $0 $0 -1136
#addi $386 $0 -1128
#move $383 $386
#addi $387 $0 -1016
#move $388 $387
####move $389 $386
#lw $390 $386 0
#sw $390 $388 0
#addi $388 $388 4
#addi $389 $386 4
#lw $390 $389 0
#sw $390 $388 0
#addi $388 $388 4
#addi $389 $389 4
#lw $390 $389 0
#sw $390 $388 0
#addi $388 $388 4
#addi $389 $389 4
#lw $390 $389 0
#sw $390 $388 0
#addi $388 $388 4
#addi $389 $389 4
#lw $390 $389 0
#sw $390 $388 0
#addi $388 $388 4
#addi $389 $389 4
#lw $390 $389 0
#sw $390 $388 0
#addi $388 $388 4
#addi $389 $389 4
#lw $390 $389 0
#sw $390 $388 0
#addi $388 $388 4
#addi $389 $389 4
#lw $390 $389 0
#sw $390 $388 0
#addi $388 $388 4
#addi $389 $389 4
#lw $390 $389 0
#sw $390 $388 0
#addi $388 $388 4
#addi $389 $389 4
#lw $390 $389 0
#sw $390 $388 0
#addi $388 $388 4
#addi $389 $389 4
#lw $390 $389 0
#sw $390 $388 0
#addi $388 $388 4
#addi $389 $389 4
#lw $390 $389 0
#sw $390 $388 0
#addi $388 $388 4
#addi $389 $389 4
#lw $390 $389 0
#sw $390 $388 0
#addi $388 $388 4
#addi $389 $389 4
#lw $390 $389 0
#sw $390 $388 0
#addi $388 $388 4
#addi $389 $389 4
#lw $390 $389 0
#sw $390 $388 0
#addi $388 $388 4
#addi $389 $389 4
#lw $390 $389 0
#sw $390 $388 0
#addi $388 $388 4
#addi $389 $389 4
#lw $390 $389 0
#sw $390 $388 0
#addi $388 $388 4
#addi $389 $389 4
#lw $390 $389 0
#sw $390 $388 0
#addi $388 $388 4
#addi $389 $389 4
#lw $390 $389 0
#sw $390 $388 0
#addi $388 $388 4
#addi $389 $389 4
#lw $390 $389 0
#sw $390 $388 0
#addi $388 $388 4
#addi $389 $389 4
#lw $390 $389 0
#sw $390 $388 0
#addi $388 $388 4
#addi $389 $389 4
#lw $390 $389 0
#sw $390 $388 0
#addi $388 $388 4
#addi $389 $389 4
#lw $390 $389 0
#sw $390 $388 0
#addi $388 $388 4
#addi $389 $389 4
#lw $390 $389 0
#sw $390 $388 0
#addi $388 $388 4
#addi $389 $389 4
#lw $390 $389 0
#sw $390 $388 0
#addi $388 $388 4
#addi $389 $389 4
#lw $390 $389 0
#sw $390 $388 0
#addi $388 $388 4
#addi $389 $389 4
#lw $390 $389 0
#sw $390 $388 0
#addi $388 $388 4
#addi $389 $389 4
#lw $390 $389 0
#sw $390 $388 0
#addi $388 $388 4
#addi $389 $389 4
#addi $0 $0 -1016
#call #compare
#subi $0 $0 -1016
#addi $391 $0 -788
####move $374 $391
#addi $392 $0 -784
#lw $374 $391 0
#sw $374 $392 0
#move $393 $394
#addi $395 $0 -788
#sw $393 $395 0
#addi $0 $0 -788
#call #printf
#subi $0 $0 -788
#label l:54
####move $396 $221
#move $397 $221
#lw $396 $221 0
#addi $396 $396 1
#sw $396 $397 0
#goto l:52
#label l:53
#move $399 $186
#addi $400 $0 -784
#sw $399 $400 0
#addi $0 $0 -784
#call #printf_single
#subi $0 $0 -784
#label l:51
####move $401 $219
#move $402 $219
#lw $401 $219 0
#addi $401 $401 1
#sw $401 $402 0
#goto l:49
#label l:50
#li $403 0
#addi $404 $0 4
#sw $403 $404 0
#return
#return
