.data
temp: .space 928
var0: .space 4
var1: .space 40000
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

__exchange:
add $8, $29, 0
sw $8, -4($sp)
add $8, $29, 4
sw $8, -8($sp)
add $8, $29, -56
sw $8, -16($sp)
lw $9, -16($sp)
move $8, $9
sw $8, -12($sp)
lw $9, -4($sp)
lw $8, 0($9)
sw $8, -24($sp)
lw $9, -24($sp)
mul $8, $9, 4
sw $8, -24($sp)
lw $9, 12($a3)
lw $10, -24($sp)
add $8, $9, $10
sw $8, -20($sp)
lw $9, -20($sp)
lw $8, 0($9)
sw $8, -20($sp)
lw $8, -20($sp)
lw $9, -12($sp)
sw $8, 0($9)
lw $9, -4($sp)
lw $8, 0($9)
sw $8, -32($sp)
lw $9, -32($sp)
mul $8, $9, 4
sw $8, -32($sp)
lw $9, 12($a3)
lw $10, -32($sp)
add $8, $9, $10
sw $8, -28($sp)
lw $9, -8($sp)
lw $8, 0($9)
sw $8, -40($sp)
lw $9, -40($sp)
mul $8, $9, 4
sw $8, -40($sp)
lw $9, 12($a3)
lw $10, -40($sp)
add $8, $9, $10
sw $8, -36($sp)
lw $9, -36($sp)
lw $8, 0($9)
sw $8, -36($sp)
lw $8, -36($sp)
lw $9, -28($sp)
sw $8, 0($9)
lw $9, -8($sp)
lw $8, 0($9)
sw $8, -48($sp)
lw $9, -48($sp)
mul $8, $9, 4
sw $8, -48($sp)
lw $9, 12($a3)
lw $10, -48($sp)
add $8, $9, $10
sw $8, -44($sp)
lw $9, -12($sp)
lw $8, 0($9)
sw $8, -52($sp)
lw $8, -52($sp)
lw $9, -44($sp)
sw $8, 0($9)
jr $ra
__makeHeap:
add $8, $29, -208
sw $8, -8($sp)
lw $9, -8($sp)
move $8, $9
sw $8, -4($sp)
add $8, $29, -212
sw $8, -16($sp)
lw $9, -16($sp)
move $8, $9
sw $8, -12($sp)
add $8, $29, -216
sw $8, -24($sp)
lw $9, -24($sp)
move $8, $9
sw $8, -20($sp)
lw $9, -8($sp)
move $8, $9
sw $8, -28($sp)
lw $9, 8($a3)
lw $8, 0($9)
sw $8, -32($sp)
li $8, 1
sw $8, -36($sp)
lw $9, -32($sp)
lw $10, -36($sp)
sub $8, $9, $10
sw $8, -32($sp)
li $8, 2
sw $8, -40($sp)
lw $9, -32($sp)
lw $10, -40($sp)
div $8, $9, $10
sw $8, -32($sp)
lw $8, -32($sp)
lw $9, -28($sp)
sw $8, 0($9)
lw $9, -16($sp)
move $8, $9
sw $8, -44($sp)
lw $9, -24($sp)
move $8, $9
sw $8, -48($sp)
li $8, 0
sw $8, -52($sp)
lw $8, -52($sp)
lw $9, -48($sp)
sw $8, 0($9)
lw $9, -48($sp)
lw $8, 0($9)
sw $8, -48($sp)
lw $8, -48($sp)
lw $9, -44($sp)
sw $8, 0($9)
label0:
lw $9, -4($sp)
lw $8, 0($9)
sw $8, -56($sp)
li $8, 0
sw $8, -60($sp)
lw $9, -56($sp)
lw $10, -60($sp)
sub $8, $9, $10
sw $8, -60($sp)
lw $8, -60($sp)
bltz $8, label1
lw $9, -20($sp)
move $8, $9
sw $8, -64($sp)
lw $9, -4($sp)
lw $8, 0($9)
sw $8, -68($sp)
li $8, 2
sw $8, -72($sp)
lw $9, -68($sp)
lw $10, -72($sp)
mul $8, $9, $10
sw $8, -68($sp)
lw $8, -68($sp)
lw $9, -64($sp)
sw $8, 0($9)
lw $9, -4($sp)
lw $8, 0($9)
sw $8, -76($sp)
li $8, 2
sw $8, -80($sp)
lw $9, -76($sp)
lw $10, -80($sp)
mul $8, $9, $10
sw $8, -76($sp)
li $8, 1
sw $8, -84($sp)
lw $9, -76($sp)
lw $10, -84($sp)
add $8, $9, $10
sw $8, -76($sp)
lw $9, 8($a3)
lw $8, 0($9)
sw $8, -88($sp)
lw $9, -76($sp)
lw $10, -88($sp)
sub $8, $9, $10
sw $8, -88($sp)
lw $8, -88($sp)
bgez $8, label2
lw $9, -4($sp)
lw $8, 0($9)
sw $8, -96($sp)
li $8, 2
sw $8, -104($sp)
lw $9, -96($sp)
lw $10, -104($sp)
mul $8, $9, $10
sw $8, -96($sp)
li $8, 1
sw $8, -108($sp)
lw $9, -96($sp)
lw $10, -108($sp)
add $8, $9, $10
sw $8, -96($sp)
lw $9, -96($sp)
mul $8, $9, 4
sw $8, -100($sp)
lw $9, 12($a3)
lw $10, -100($sp)
add $8, $9, $10
sw $8, -92($sp)
lw $9, -92($sp)
lw $8, 0($9)
sw $8, -92($sp)
lw $9, -4($sp)
lw $8, 0($9)
sw $8, -116($sp)
li $8, 2
sw $8, -124($sp)
lw $9, -116($sp)
lw $10, -124($sp)
mul $8, $9, $10
sw $8, -116($sp)
lw $9, -116($sp)
mul $8, $9, 4
sw $8, -120($sp)
lw $9, 12($a3)
lw $10, -120($sp)
add $8, $9, $10
sw $8, -112($sp)
lw $9, -112($sp)
lw $8, 0($9)
sw $8, -112($sp)
lw $9, -92($sp)
lw $10, -112($sp)
sub $8, $9, $10
sw $8, -112($sp)
lw $8, -112($sp)
bgez $8, label2
lw $9, -20($sp)
move $8, $9
sw $8, -128($sp)
lw $9, -4($sp)
lw $8, 0($9)
sw $8, -132($sp)
li $8, 2
sw $8, -136($sp)
lw $9, -132($sp)
lw $10, -136($sp)
mul $8, $9, $10
sw $8, -132($sp)
li $8, 1
sw $8, -140($sp)
lw $9, -132($sp)
lw $10, -140($sp)
add $8, $9, $10
sw $8, -132($sp)
lw $8, -132($sp)
lw $9, -128($sp)
sw $8, 0($9)
label2:
lw $9, -4($sp)
lw $8, 0($9)
sw $8, -148($sp)
lw $9, -148($sp)
mul $8, $9, 4
sw $8, -152($sp)
lw $9, 12($a3)
lw $10, -152($sp)
add $8, $9, $10
sw $8, -144($sp)
lw $9, -144($sp)
lw $8, 0($9)
sw $8, -144($sp)
lw $9, -20($sp)
lw $8, 0($9)
sw $8, -160($sp)
lw $9, -160($sp)
mul $8, $9, 4
sw $8, -164($sp)
lw $9, 12($a3)
lw $10, -164($sp)
add $8, $9, $10
sw $8, -156($sp)
lw $9, -156($sp)
lw $8, 0($9)
sw $8, -156($sp)
lw $9, -144($sp)
lw $10, -156($sp)
sub $8, $9, $10
sw $8, -156($sp)
lw $8, -156($sp)
blez $8, label3
sw $31, -220($29)
add $8, $29, -224
sw $8, -176($sp)
lw $9, -20($sp)
lw $8, 0($9)
sw $8, -172($sp)
lw $8, -172($sp)
lw $9, -176($sp)
sw $8, 0($9)
add $8, $29, -228
sw $8, -184($sp)
lw $9, -4($sp)
lw $8, 0($9)
sw $8, -180($sp)
lw $8, -180($sp)
lw $9, -184($sp)
sw $8, 0($9)
add $29, $29, -228
jal __exchange
sub $29, $29, -228
lw $31, -220($29)
label3:
lw $9, -4($sp)
move $8, $9
sw $8, -188($sp)
lw $9, -4($sp)
lw $8, 0($9)
sw $8, -192($sp)
li $8, 1
sw $8, -196($sp)
lw $9, -192($sp)
lw $10, -196($sp)
sub $8, $9, $10
sw $8, -192($sp)
lw $8, -192($sp)
lw $9, -188($sp)
sw $8, 0($9)
j label0
label1:
li $8, 0
sw $8, -200($sp)
add $8, $29, 4
sw $8, -204($sp)
lw $8, -200($sp)
lw $9, -204($sp)
sw $8, 0($9)
jr $ra
jr $ra
__adjustHeap:
add $8, $29, 0
sw $8, -4($sp)
add $8, $29, -264
sw $8, -12($sp)
lw $9, -12($sp)
move $8, $9
sw $8, -8($sp)
add $8, $29, -268
sw $8, -20($sp)
lw $9, -20($sp)
move $8, $9
sw $8, -16($sp)
add $8, $29, -272
sw $8, -28($sp)
lw $9, -28($sp)
move $8, $9
sw $8, -24($sp)
lw $9, -12($sp)
move $8, $9
sw $8, -32($sp)
lw $9, -20($sp)
move $8, $9
sw $8, -36($sp)
lw $9, -28($sp)
move $8, $9
sw $8, -40($sp)
li $8, 0
sw $8, -44($sp)
lw $8, -44($sp)
lw $9, -40($sp)
sw $8, 0($9)
lw $9, -40($sp)
lw $8, 0($9)
sw $8, -40($sp)
lw $8, -40($sp)
lw $9, -36($sp)
sw $8, 0($9)
lw $9, -36($sp)
lw $8, 0($9)
sw $8, -36($sp)
lw $8, -36($sp)
lw $9, -32($sp)
sw $8, 0($9)
label4:
lw $9, -8($sp)
lw $8, 0($9)
sw $8, -48($sp)
li $8, 2
sw $8, -52($sp)
lw $9, -48($sp)
lw $10, -52($sp)
mul $8, $9, $10
sw $8, -48($sp)
lw $9, -4($sp)
lw $8, 0($9)
sw $8, -56($sp)
lw $9, -48($sp)
lw $10, -56($sp)
sub $8, $9, $10
sw $8, -56($sp)
lw $8, -56($sp)
bgez $8, label5
lw $9, -16($sp)
move $8, $9
sw $8, -60($sp)
lw $9, -8($sp)
lw $8, 0($9)
sw $8, -64($sp)
li $8, 2
sw $8, -68($sp)
lw $9, -64($sp)
lw $10, -68($sp)
mul $8, $9, $10
sw $8, -64($sp)
lw $8, -64($sp)
lw $9, -60($sp)
sw $8, 0($9)
lw $9, -8($sp)
lw $8, 0($9)
sw $8, -72($sp)
li $8, 2
sw $8, -76($sp)
lw $9, -72($sp)
lw $10, -76($sp)
mul $8, $9, $10
sw $8, -72($sp)
li $8, 1
sw $8, -80($sp)
lw $9, -72($sp)
lw $10, -80($sp)
add $8, $9, $10
sw $8, -72($sp)
lw $9, -4($sp)
lw $8, 0($9)
sw $8, -84($sp)
lw $9, -72($sp)
lw $10, -84($sp)
sub $8, $9, $10
sw $8, -84($sp)
lw $8, -84($sp)
bgez $8, label6
lw $9, -8($sp)
lw $8, 0($9)
sw $8, -92($sp)
li $8, 2
sw $8, -100($sp)
lw $9, -92($sp)
lw $10, -100($sp)
mul $8, $9, $10
sw $8, -92($sp)
li $8, 1
sw $8, -104($sp)
lw $9, -92($sp)
lw $10, -104($sp)
add $8, $9, $10
sw $8, -92($sp)
lw $9, -92($sp)
mul $8, $9, 4
sw $8, -96($sp)
lw $9, 12($a3)
lw $10, -96($sp)
add $8, $9, $10
sw $8, -88($sp)
lw $9, -88($sp)
lw $8, 0($9)
sw $8, -88($sp)
lw $9, -8($sp)
lw $8, 0($9)
sw $8, -112($sp)
li $8, 2
sw $8, -120($sp)
lw $9, -112($sp)
lw $10, -120($sp)
mul $8, $9, $10
sw $8, -112($sp)
lw $9, -112($sp)
mul $8, $9, 4
sw $8, -116($sp)
lw $9, 12($a3)
lw $10, -116($sp)
add $8, $9, $10
sw $8, -108($sp)
lw $9, -108($sp)
lw $8, 0($9)
sw $8, -108($sp)
lw $9, -88($sp)
lw $10, -108($sp)
sub $8, $9, $10
sw $8, -108($sp)
lw $8, -108($sp)
bgez $8, label6
lw $9, -16($sp)
move $8, $9
sw $8, -124($sp)
lw $9, -8($sp)
lw $8, 0($9)
sw $8, -128($sp)
li $8, 2
sw $8, -132($sp)
lw $9, -128($sp)
lw $10, -132($sp)
mul $8, $9, $10
sw $8, -128($sp)
li $8, 1
sw $8, -136($sp)
lw $9, -128($sp)
lw $10, -136($sp)
add $8, $9, $10
sw $8, -128($sp)
lw $8, -128($sp)
lw $9, -124($sp)
sw $8, 0($9)
label6:
lw $9, -8($sp)
lw $8, 0($9)
sw $8, -144($sp)
lw $9, -144($sp)
mul $8, $9, 4
sw $8, -148($sp)
lw $9, 12($a3)
lw $10, -148($sp)
add $8, $9, $10
sw $8, -140($sp)
lw $9, -140($sp)
lw $8, 0($9)
sw $8, -140($sp)
lw $9, -16($sp)
lw $8, 0($9)
sw $8, -156($sp)
lw $9, -156($sp)
mul $8, $9, 4
sw $8, -160($sp)
lw $9, 12($a3)
lw $10, -160($sp)
add $8, $9, $10
sw $8, -152($sp)
lw $9, -152($sp)
lw $8, 0($9)
sw $8, -152($sp)
lw $9, -140($sp)
lw $10, -152($sp)
sub $8, $9, $10
sw $8, -152($sp)
lw $8, -152($sp)
blez $8, label7
lw $9, -8($sp)
lw $8, 0($9)
sw $8, -168($sp)
lw $9, -168($sp)
mul $8, $9, 4
sw $8, -172($sp)
lw $9, 12($a3)
lw $10, -172($sp)
add $8, $9, $10
sw $8, -164($sp)
lw $9, -16($sp)
lw $8, 0($9)
sw $8, -180($sp)
lw $9, -180($sp)
mul $8, $9, 4
sw $8, -184($sp)
lw $9, 12($a3)
lw $10, -184($sp)
add $8, $9, $10
sw $8, -176($sp)
lw $9, -164($sp)
lw $8, 0($9)
sw $8, -188($sp)
lw $9, -176($sp)
lw $8, 0($9)
sw $8, -176($sp)
lw $9, -188($sp)
lw $10, -176($sp)
xor $8, $9, $10
sw $8, -188($sp)
lw $8, -188($sp)
lw $9, -164($sp)
sw $8, 0($9)
lw $9, -16($sp)
lw $8, 0($9)
sw $8, -196($sp)
lw $9, -196($sp)
mul $8, $9, 4
sw $8, -200($sp)
lw $9, 12($a3)
lw $10, -200($sp)
add $8, $9, $10
sw $8, -192($sp)
lw $9, -8($sp)
lw $8, 0($9)
sw $8, -208($sp)
lw $9, -208($sp)
mul $8, $9, 4
sw $8, -212($sp)
lw $9, 12($a3)
lw $10, -212($sp)
add $8, $9, $10
sw $8, -204($sp)
lw $9, -192($sp)
lw $8, 0($9)
sw $8, -216($sp)
lw $9, -204($sp)
lw $8, 0($9)
sw $8, -204($sp)
lw $9, -216($sp)
lw $10, -204($sp)
xor $8, $9, $10
sw $8, -216($sp)
lw $8, -216($sp)
lw $9, -192($sp)
sw $8, 0($9)
lw $9, -8($sp)
lw $8, 0($9)
sw $8, -224($sp)
lw $9, -224($sp)
mul $8, $9, 4
sw $8, -228($sp)
lw $9, 12($a3)
lw $10, -228($sp)
add $8, $9, $10
sw $8, -220($sp)
lw $9, -16($sp)
lw $8, 0($9)
sw $8, -236($sp)
lw $9, -236($sp)
mul $8, $9, 4
sw $8, -240($sp)
lw $9, 12($a3)
lw $10, -240($sp)
add $8, $9, $10
sw $8, -232($sp)
lw $9, -220($sp)
lw $8, 0($9)
sw $8, -244($sp)
lw $9, -232($sp)
lw $8, 0($9)
sw $8, -232($sp)
lw $9, -244($sp)
lw $10, -232($sp)
xor $8, $9, $10
sw $8, -244($sp)
lw $8, -244($sp)
lw $9, -220($sp)
sw $8, 0($9)
lw $9, -8($sp)
move $8, $9
sw $8, -248($sp)
lw $9, -16($sp)
lw $8, 0($9)
sw $8, -252($sp)
lw $8, -252($sp)
lw $9, -248($sp)
sw $8, 0($9)
j label8
label7:
j label5
label8:
j label4
label5:
li $8, 0
sw $8, -256($sp)
add $8, $29, 8
sw $8, -260($sp)
lw $8, -256($sp)
lw $9, -260($sp)
sw $8, 0($9)
jr $ra
jr $ra
__heapSort:
add $8, $29, -160
sw $8, -8($sp)
lw $9, -8($sp)
move $8, $9
sw $8, -4($sp)
add $8, $29, -164
sw $8, -16($sp)
lw $9, -16($sp)
move $8, $9
sw $8, -12($sp)
lw $9, -8($sp)
move $8, $9
sw $8, -20($sp)
li $8, 0
sw $8, -24($sp)
lw $8, -24($sp)
lw $9, -20($sp)
sw $8, 0($9)
lw $9, -16($sp)
move $8, $9
sw $8, -28($sp)
li $8, 0
sw $8, -32($sp)
lw $8, -32($sp)
lw $9, -28($sp)
sw $8, 0($9)
label9:
lw $9, -12($sp)
lw $8, 0($9)
sw $8, -36($sp)
lw $9, 8($a3)
lw $8, 0($9)
sw $8, -40($sp)
lw $9, -36($sp)
lw $10, -40($sp)
sub $8, $9, $10
sw $8, -40($sp)
lw $8, -40($sp)
bgez $8, label10
lw $9, -4($sp)
move $8, $9
sw $8, -44($sp)
li $8, 0
sw $8, -52($sp)
lw $9, -52($sp)
mul $8, $9, 4
sw $8, -56($sp)
lw $9, 12($a3)
lw $10, -56($sp)
add $8, $9, $10
sw $8, -48($sp)
lw $9, -48($sp)
lw $8, 0($9)
sw $8, -48($sp)
lw $8, -48($sp)
lw $9, -44($sp)
sw $8, 0($9)
li $8, 0
sw $8, -64($sp)
lw $9, -64($sp)
mul $8, $9, 4
sw $8, -68($sp)
lw $9, 12($a3)
lw $10, -68($sp)
add $8, $9, $10
sw $8, -60($sp)
lw $9, 8($a3)
lw $8, 0($9)
sw $8, -76($sp)
lw $9, -12($sp)
lw $8, 0($9)
sw $8, -84($sp)
lw $9, -76($sp)
lw $10, -84($sp)
sub $8, $9, $10
sw $8, -76($sp)
li $8, 1
sw $8, -88($sp)
lw $9, -76($sp)
lw $10, -88($sp)
sub $8, $9, $10
sw $8, -76($sp)
lw $9, -76($sp)
mul $8, $9, 4
sw $8, -80($sp)
lw $9, 12($a3)
lw $10, -80($sp)
add $8, $9, $10
sw $8, -72($sp)
lw $9, -72($sp)
lw $8, 0($9)
sw $8, -72($sp)
lw $8, -72($sp)
lw $9, -60($sp)
sw $8, 0($9)
lw $9, 8($a3)
lw $8, 0($9)
sw $8, -96($sp)
lw $9, -12($sp)
lw $8, 0($9)
sw $8, -104($sp)
lw $9, -96($sp)
lw $10, -104($sp)
sub $8, $9, $10
sw $8, -96($sp)
li $8, 1
sw $8, -108($sp)
lw $9, -96($sp)
lw $10, -108($sp)
sub $8, $9, $10
sw $8, -96($sp)
lw $9, -96($sp)
mul $8, $9, 4
sw $8, -100($sp)
lw $9, 12($a3)
lw $10, -100($sp)
add $8, $9, $10
sw $8, -92($sp)
lw $9, -4($sp)
lw $8, 0($9)
sw $8, -112($sp)
lw $8, -112($sp)
lw $9, -92($sp)
sw $8, 0($9)
sw $31, -172($29)
lw $9, 8($a3)
lw $8, 0($9)
sw $8, -120($sp)
lw $9, -12($sp)
lw $8, 0($9)
sw $8, -124($sp)
lw $9, -120($sp)
lw $10, -124($sp)
sub $8, $9, $10
sw $8, -120($sp)
li $8, 1
sw $8, -128($sp)
lw $9, -120($sp)
lw $10, -128($sp)
sub $8, $9, $10
sw $8, -120($sp)
add $8, $29, -176
sw $8, -132($sp)
lw $8, -120($sp)
lw $9, -132($sp)
sw $8, 0($9)
add $29, $29, -176
jal __adjustHeap
sub $29, $29, -176
lw $31, -172($29)
add $8, $29, -168
sw $8, -136($sp)
lw $9, -136($sp)
move $8, $9
sw $8, -116($sp)
label11:
lw $9, -12($sp)
move $8, $9
sw $8, -140($sp)
lw $9, -12($sp)
lw $8, 0($9)
sw $8, -144($sp)
li $8, 1
sw $8, -148($sp)
lw $9, -144($sp)
lw $10, -148($sp)
add $8, $9, $10
sw $8, -144($sp)
lw $8, -144($sp)
lw $9, -140($sp)
sw $8, 0($9)
j label9
label10:
li $8, 0
sw $8, -152($sp)
add $8, $29, 4
sw $8, -156($sp)
lw $8, -152($sp)
lw $9, -156($sp)
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
sw $t0, 884($a3)
la $t0, var3
sw $t0, 912($a3)
add $8, $29, -236
sw $8, -8($sp)
lw $9, -8($sp)
move $8, $9
sw $8, -4($sp)
lw $9, 8($a3)
move $8, $9
sw $8, -12($sp)
add $29, $29, -244
jal __getchar
sub $29, $29, -244
add $8, $29, -240
sw $8, -20($sp)
lw $9, -20($sp)
lw $8, 0($9)
sw $8, -16($sp)
li $8, 48
sw $8, -24($sp)
lw $9, -16($sp)
lw $10, -24($sp)
sub $8, $9, $10
sw $8, -16($sp)
lw $8, -16($sp)
lw $9, -12($sp)
sw $8, 0($9)
lw $9, 8($a3)
move $8, $9
sw $8, -28($sp)
li $8, 10
sw $8, -32($sp)
lw $9, 8($a3)
lw $8, 0($9)
sw $8, -36($sp)
lw $9, -32($sp)
lw $10, -36($sp)
mul $8, $9, $10
sw $8, -32($sp)
add $29, $29, -244
jal __getchar
sub $29, $29, -244
add $8, $29, -240
sw $8, -44($sp)
lw $9, -44($sp)
lw $8, 0($9)
sw $8, -40($sp)
lw $9, -32($sp)
lw $10, -40($sp)
add $8, $9, $10
sw $8, -32($sp)
li $8, 48
sw $8, -48($sp)
lw $9, -32($sp)
lw $10, -48($sp)
sub $8, $9, $10
sw $8, -32($sp)
lw $8, -32($sp)
lw $9, -28($sp)
sw $8, 0($9)
lw $9, 8($a3)
move $8, $9
sw $8, -52($sp)
li $8, 10
sw $8, -56($sp)
lw $9, 8($a3)
lw $8, 0($9)
sw $8, -60($sp)
lw $9, -56($sp)
lw $10, -60($sp)
mul $8, $9, $10
sw $8, -56($sp)
add $29, $29, -244
jal __getchar
sub $29, $29, -244
add $8, $29, -240
sw $8, -68($sp)
lw $9, -68($sp)
lw $8, 0($9)
sw $8, -64($sp)
lw $9, -56($sp)
lw $10, -64($sp)
add $8, $9, $10
sw $8, -56($sp)
li $8, 48
sw $8, -72($sp)
lw $9, -56($sp)
lw $10, -72($sp)
sub $8, $9, $10
sw $8, -56($sp)
lw $8, -56($sp)
lw $9, -52($sp)
sw $8, 0($9)
lw $9, 8($a3)
move $8, $9
sw $8, -76($sp)
li $8, 10
sw $8, -80($sp)
lw $9, 8($a3)
lw $8, 0($9)
sw $8, -84($sp)
lw $9, -80($sp)
lw $10, -84($sp)
mul $8, $9, $10
sw $8, -80($sp)
add $29, $29, -244
jal __getchar
sub $29, $29, -244
add $8, $29, -240
sw $8, -92($sp)
lw $9, -92($sp)
lw $8, 0($9)
sw $8, -88($sp)
lw $9, -80($sp)
lw $10, -88($sp)
add $8, $9, $10
sw $8, -80($sp)
li $8, 48
sw $8, -96($sp)
lw $9, -80($sp)
lw $10, -96($sp)
sub $8, $9, $10
sw $8, -80($sp)
lw $8, -80($sp)
lw $9, -76($sp)
sw $8, 0($9)
lw $9, -8($sp)
move $8, $9
sw $8, -100($sp)
li $8, 0
sw $8, -104($sp)
lw $8, -104($sp)
lw $9, -100($sp)
sw $8, 0($9)
label12:
lw $9, -4($sp)
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
bgez $8, label13
lw $9, -4($sp)
lw $8, 0($9)
sw $8, -120($sp)
lw $9, -120($sp)
mul $8, $9, 4
sw $8, -124($sp)
lw $9, 12($a3)
lw $10, -124($sp)
add $8, $9, $10
sw $8, -116($sp)
lw $9, -4($sp)
lw $8, 0($9)
sw $8, -128($sp)
lw $8, -128($sp)
lw $9, -116($sp)
sw $8, 0($9)
label14:
lw $9, -4($sp)
move $8, $9
sw $8, -132($sp)
lw $9, -4($sp)
lw $8, 0($9)
sw $8, -136($sp)
li $8, 1
sw $8, -140($sp)
lw $9, -136($sp)
lw $10, -140($sp)
add $8, $9, $10
sw $8, -136($sp)
lw $8, -136($sp)
lw $9, -132($sp)
sw $8, 0($9)
j label12
label13:
add $29, $29, -244
jal __makeHeap
sub $29, $29, -244
add $8, $29, -240
sw $8, -148($sp)
lw $9, -148($sp)
move $8, $9
sw $8, -144($sp)
add $29, $29, -244
jal __heapSort
sub $29, $29, -244
add $8, $29, -240
sw $8, -156($sp)
lw $9, -156($sp)
move $8, $9
sw $8, -152($sp)
lw $9, -4($sp)
move $8, $9
sw $8, -160($sp)
li $8, 0
sw $8, -164($sp)
lw $8, -164($sp)
lw $9, -160($sp)
sw $8, 0($9)
label15:
lw $9, -4($sp)
lw $8, 0($9)
sw $8, -168($sp)
lw $9, 8($a3)
lw $8, 0($9)
sw $8, -172($sp)
lw $9, -168($sp)
lw $10, -172($sp)
sub $8, $9, $10
sw $8, -172($sp)
lw $8, -172($sp)
bgez $8, label16
lw $9, -4($sp)
lw $8, 0($9)
sw $8, -184($sp)
lw $9, -184($sp)
mul $8, $9, 4
sw $8, -188($sp)
lw $9, 12($a3)
lw $10, -188($sp)
add $8, $9, $10
sw $8, -180($sp)
add $8, $29, -244
sw $8, -192($sp)
lw $9, -180($sp)
lw $8, 0($9)
sw $8, -180($sp)
lw $8, -180($sp)
lw $9, -192($sp)
sw $8, 0($9)
lw $9, 884($a3)
move $8, $9
sw $8, -196($sp)
add $8, $29, -248
sw $8, -200($sp)
lw $8, -196($sp)
lw $9, -200($sp)
sw $8, 0($9)
add $29, $29, -248
jal __printf
sub $29, $29, -248
label17:
lw $9, -4($sp)
move $8, $9
sw $8, -204($sp)
lw $9, -4($sp)
lw $8, 0($9)
sw $8, -208($sp)
li $8, 1
sw $8, -212($sp)
lw $9, -208($sp)
lw $10, -212($sp)
add $8, $9, $10
sw $8, -208($sp)
lw $8, -208($sp)
lw $9, -204($sp)
sw $8, 0($9)
j label15
label16:
lw $9, 912($a3)
move $8, $9
sw $8, -220($sp)
add $8, $29, -244
sw $8, -224($sp)
lw $8, -220($sp)
lw $9, -224($sp)
sw $8, 0($9)
add $29, $29, -244
jal __printf_single
sub $29, $29, -244
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
#global $3 40000
#string $221 #%d 
#string $228 #\n
#----------------------------
#func #exchange
#addi $4 $0 0
#addi $5 $0 4
#addi $7 $0 -56
#move $6 $7
####move $8 $3
####move $9 $4
#lw $9 $4 0
#muli $9 $9 4
#add $8 $3 $9
#lw $8 $8 0
#sw $8 $6 0
####move $10 $3
####move $11 $4
#lw $11 $4 0
#muli $11 $11 4
#add $10 $3 $11
####move $12 $3
####move $13 $5
#lw $13 $5 0
#muli $13 $13 4
#add $12 $3 $13
#lw $12 $12 0
#sw $12 $10 0
####move $14 $3
####move $15 $5
#lw $15 $5 0
#muli $15 $15 4
#add $14 $3 $15
####move $16 $6
#lw $16 $6 0
#sw $16 $14 0
#return
#----------------------------
#func #makeHeap
#addi $18 $0 -208
#move $17 $18
#addi $20 $0 -212
#move $19 $20
#addi $22 $0 -216
#move $21 $22
#move $23 $18
####move $24 $2
#lw $24 $2 0
#li $25 1
#sub $24 $24 $25
#li $26 2
#div $24 $24 $26
#sw $24 $23 0
#move $27 $20
#move $28 $22
#li $29 0
#sw $29 $28 0
#lw $28 $28 0
#sw $28 $27 0
#label l:0
####move $30 $17
#lw $30 $17 0
#li $31 0
#sub $31 $30 $31
#bltz $31 l:1
#move $32 $21
####move $33 $17
#lw $33 $17 0
#li $34 2
#mul $33 $33 $34
#sw $33 $32 0
####move $35 $17
#lw $35 $17 0
#li $36 2
#mul $35 $35 $36
#li $37 1
#add $35 $35 $37
####move $38 $2
#lw $38 $2 0
#sub $38 $35 $38
#bgez $38 l:2
####move $39 $3
####move $40 $17
#lw $40 $17 0
#li $42 2
#mul $40 $40 $42
#li $43 1
#add $40 $40 $43
#muli $41 $40 4
#add $39 $3 $41
#lw $39 $39 0
####move $44 $3
####move $45 $17
#lw $45 $17 0
#li $47 2
#mul $45 $45 $47
#muli $46 $45 4
#add $44 $3 $46
#lw $44 $44 0
#sub $44 $39 $44
#bgez $44 l:2
#move $48 $21
####move $49 $17
#lw $49 $17 0
#li $50 2
#mul $49 $49 $50
#li $51 1
#add $49 $49 $51
#sw $49 $48 0
#label l:2
####move $52 $3
####move $53 $17
#lw $53 $17 0
#muli $54 $53 4
#add $52 $3 $54
#lw $52 $52 0
####move $55 $3
####move $56 $21
#lw $56 $21 0
#muli $57 $56 4
#add $55 $3 $57
#lw $55 $55 0
#sub $55 $52 $55
#blez $55 l:3
#sw $1 $0 -220
####move $59 $21
#addi $60 $0 -224
#lw $59 $21 0
#sw $59 $60 0
####move $61 $17
#addi $62 $0 -228
#lw $61 $17 0
#sw $61 $62 0
#addi $0 $0 -228
#call #exchange
#subi $0 $0 -228
#lw $1 $0 -220
#label l:3
#move $63 $17
####move $64 $17
#lw $64 $17 0
#li $65 1
#sub $64 $64 $65
#sw $64 $63 0
#goto l:0
#label l:1
#li $66 0
#addi $67 $0 4
#sw $66 $67 0
#return
#return
#----------------------------
#func #adjustHeap
#addi $68 $0 0
#addi $70 $0 -264
#move $69 $70
#addi $72 $0 -268
#move $71 $72
#addi $74 $0 -272
#move $73 $74
#move $75 $70
#move $76 $72
#move $77 $74
#li $78 0
#sw $78 $77 0
#lw $77 $77 0
#sw $77 $76 0
#lw $76 $76 0
#sw $76 $75 0
#label l:4
####move $79 $69
#lw $79 $69 0
#li $80 2
#mul $79 $79 $80
####move $81 $68
#lw $81 $68 0
#sub $81 $79 $81
#bgez $81 l:5
#move $82 $71
####move $83 $69
#lw $83 $69 0
#li $84 2
#mul $83 $83 $84
#sw $83 $82 0
####move $85 $69
#lw $85 $69 0
#li $86 2
#mul $85 $85 $86
#li $87 1
#add $85 $85 $87
####move $88 $68
#lw $88 $68 0
#sub $88 $85 $88
#bgez $88 l:6
####move $89 $3
####move $90 $69
#lw $90 $69 0
#li $92 2
#mul $90 $90 $92
#li $93 1
#add $90 $90 $93
#muli $91 $90 4
#add $89 $3 $91
#lw $89 $89 0
####move $94 $3
####move $95 $69
#lw $95 $69 0
#li $97 2
#mul $95 $95 $97
#muli $96 $95 4
#add $94 $3 $96
#lw $94 $94 0
#sub $94 $89 $94
#bgez $94 l:6
#move $98 $71
####move $99 $69
#lw $99 $69 0
#li $100 2
#mul $99 $99 $100
#li $101 1
#add $99 $99 $101
#sw $99 $98 0
#label l:6
####move $102 $3
####move $103 $69
#lw $103 $69 0
#muli $104 $103 4
#add $102 $3 $104
#lw $102 $102 0
####move $105 $3
####move $106 $71
#lw $106 $71 0
#muli $107 $106 4
#add $105 $3 $107
#lw $105 $105 0
#sub $105 $102 $105
#blez $105 l:7
####move $108 $3
####move $109 $69
#lw $109 $69 0
#muli $110 $109 4
#add $108 $3 $110
####move $111 $3
####move $112 $71
#lw $112 $71 0
#muli $113 $112 4
#add $111 $3 $113
#lw $114 $108 0
#lw $111 $111 0
#xor $114 $114 $111
#sw $114 $108 0
####move $115 $3
####move $116 $71
#lw $116 $71 0
#muli $117 $116 4
#add $115 $3 $117
####move $118 $3
####move $119 $69
#lw $119 $69 0
#muli $120 $119 4
#add $118 $3 $120
#lw $121 $115 0
#lw $118 $118 0
#xor $121 $121 $118
#sw $121 $115 0
####move $122 $3
####move $123 $69
#lw $123 $69 0
#muli $124 $123 4
#add $122 $3 $124
####move $125 $3
####move $126 $71
#lw $126 $71 0
#muli $127 $126 4
#add $125 $3 $127
#lw $128 $122 0
#lw $125 $125 0
#xor $128 $128 $125
#sw $128 $122 0
#move $129 $69
####move $130 $71
#lw $130 $71 0
#sw $130 $129 0
#goto l:8
#label l:7
#goto l:5
#label l:8
#goto l:4
#label l:5
#li $131 0
#addi $132 $0 8
#sw $131 $132 0
#return
#return
#----------------------------
#func #heapSort
#addi $134 $0 -160
#move $133 $134
#addi $136 $0 -164
#move $135 $136
#move $137 $134
#li $138 0
#sw $138 $137 0
#move $139 $136
#li $140 0
#sw $140 $139 0
#label l:9
####move $141 $135
#lw $141 $135 0
####move $142 $2
#lw $142 $2 0
#sub $142 $141 $142
#bgez $142 l:10
#move $143 $133
####move $144 $3
#li $145 0
#muli $146 $145 4
#add $144 $3 $146
#lw $144 $144 0
#sw $144 $143 0
####move $147 $3
#li $148 0
#muli $149 $148 4
#add $147 $3 $149
####move $150 $3
####move $151 $2
#lw $151 $2 0
####move $153 $135
#lw $153 $135 0
#sub $151 $151 $153
#li $154 1
#sub $151 $151 $154
#muli $152 $151 4
#add $150 $3 $152
#lw $150 $150 0
#sw $150 $147 0
####move $155 $3
####move $156 $2
#lw $156 $2 0
####move $158 $135
#lw $158 $135 0
#sub $156 $156 $158
#li $159 1
#sub $156 $156 $159
#muli $157 $156 4
#add $155 $3 $157
####move $160 $133
#lw $160 $133 0
#sw $160 $155 0
#sw $1 $0 -172
####move $162 $2
#lw $162 $2 0
####move $163 $135
#lw $163 $135 0
#sub $162 $162 $163
#li $164 1
#sub $162 $162 $164
#addi $165 $0 -176
#sw $162 $165 0
#addi $0 $0 -176
#call #adjustHeap
#subi $0 $0 -176
#lw $1 $0 -172
#addi $166 $0 -168
#move $161 $166
#label l:11
#move $167 $135
####move $168 $135
#lw $168 $135 0
#li $169 1
#add $168 $168 $169
#sw $168 $167 0
#goto l:9
#label l:10
#li $170 0
#addi $171 $0 4
#sw $170 $171 0
#return
#return
#----------------------------
#func #main
#addi $173 $0 -236
#move $172 $173
#move $174 $2
#addi $0 $0 -244
#call #getchar
#subi $0 $0 -244
#addi $176 $0 -240
####move $175 $176
#lw $175 $176 0
#li $177 48
#sub $175 $175 $177
#sw $175 $174 0
#move $178 $2
#li $179 10
####move $180 $2
#lw $180 $2 0
#mul $179 $179 $180
#addi $0 $0 -244
#call #getchar
#subi $0 $0 -244
#addi $182 $0 -240
####move $181 $182
#lw $181 $182 0
#add $179 $179 $181
#li $183 48
#sub $179 $179 $183
#sw $179 $178 0
#move $184 $2
#li $185 10
####move $186 $2
#lw $186 $2 0
#mul $185 $185 $186
#addi $0 $0 -244
#call #getchar
#subi $0 $0 -244
#addi $188 $0 -240
####move $187 $188
#lw $187 $188 0
#add $185 $185 $187
#li $189 48
#sub $185 $185 $189
#sw $185 $184 0
#move $190 $2
#li $191 10
####move $192 $2
#lw $192 $2 0
#mul $191 $191 $192
#addi $0 $0 -244
#call #getchar
#subi $0 $0 -244
#addi $194 $0 -240
####move $193 $194
#lw $193 $194 0
#add $191 $191 $193
#li $195 48
#sub $191 $191 $195
#sw $191 $190 0
#move $196 $173
#li $197 0
#sw $197 $196 0
#label l:12
####move $198 $172
#lw $198 $172 0
####move $199 $2
#lw $199 $2 0
#sub $199 $198 $199
#bgez $199 l:13
####move $200 $3
####move $201 $172
#lw $201 $172 0
#muli $202 $201 4
#add $200 $3 $202
####move $203 $172
#lw $203 $172 0
#sw $203 $200 0
#label l:14
#move $204 $172
####move $205 $172
#lw $205 $172 0
#li $206 1
#add $205 $205 $206
#sw $205 $204 0
#goto l:12
#label l:13
#addi $0 $0 -244
#call #makeHeap
#subi $0 $0 -244
#addi $208 $0 -240
#move $207 $208
#addi $0 $0 -244
#call #heapSort
#subi $0 $0 -244
#addi $210 $0 -240
#move $209 $210
#move $211 $172
#li $212 0
#sw $212 $211 0
#label l:15
####move $213 $172
#lw $213 $172 0
####move $214 $2
#lw $214 $2 0
#sub $214 $213 $214
#bgez $214 l:16
####move $216 $3
####move $217 $172
#lw $217 $172 0
#muli $218 $217 4
#add $216 $3 $218
#addi $219 $0 -244
#lw $216 $216 0
#sw $216 $219 0
#move $220 $221
#addi $222 $0 -248
#sw $220 $222 0
#addi $0 $0 -248
#call #printf
#subi $0 $0 -248
#label l:17
#move $223 $172
####move $224 $172
#lw $224 $172 0
#li $225 1
#add $224 $224 $225
#sw $224 $223 0
#goto l:15
#label l:16
#move $227 $228
#addi $229 $0 -244
#sw $227 $229 0
#addi $0 $0 -244
#call #printf_single
#subi $0 $0 -244
#li $230 0
#addi $231 $0 4
#sw $230 $231 0
#return
#return
