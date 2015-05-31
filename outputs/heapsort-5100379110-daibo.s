.data
temp: .space 848
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
lw $9, -32($sp)
sub $8, $9, 1
sw $8, -32($sp)
lw $9, -32($sp)
div $8, $9, 2
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
l0:
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
bltz $8, l1
lw $9, -20($sp)
move $8, $9
sw $8, -64($sp)
lw $9, -4($sp)
lw $8, 0($9)
sw $8, -68($sp)
lw $9, -68($sp)
mul $8, $9, 2
sw $8, -68($sp)
lw $8, -68($sp)
lw $9, -64($sp)
sw $8, 0($9)
lw $9, -4($sp)
lw $8, 0($9)
sw $8, -76($sp)
lw $9, -76($sp)
mul $8, $9, 2
sw $8, -76($sp)
lw $9, -76($sp)
add $8, $9, 1
sw $8, -76($sp)
lw $9, 8($a3)
lw $8, 0($9)
sw $8, -88($sp)
lw $9, -76($sp)
lw $10, -88($sp)
sub $8, $9, $10
sw $8, -88($sp)
lw $8, -88($sp)
bgez $8, l2
lw $9, -4($sp)
lw $8, 0($9)
sw $8, -96($sp)
lw $9, -96($sp)
mul $8, $9, 2
sw $8, -96($sp)
lw $9, -96($sp)
add $8, $9, 1
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
lw $9, -116($sp)
mul $8, $9, 2
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
bgez $8, l2
lw $9, -20($sp)
move $8, $9
sw $8, -128($sp)
lw $9, -4($sp)
lw $8, 0($9)
sw $8, -132($sp)
lw $9, -132($sp)
mul $8, $9, 2
sw $8, -132($sp)
lw $9, -132($sp)
add $8, $9, 1
sw $8, -132($sp)
lw $8, -132($sp)
lw $9, -128($sp)
sw $8, 0($9)
l2:
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
blez $8, l3
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
l3:
lw $9, -4($sp)
move $8, $9
sw $8, -188($sp)
lw $9, -4($sp)
lw $8, 0($9)
sw $8, -192($sp)
lw $9, -192($sp)
sub $8, $9, 1
sw $8, -192($sp)
lw $8, -192($sp)
lw $9, -188($sp)
sw $8, 0($9)
j l0
l1:
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
l4:
lw $9, -8($sp)
lw $8, 0($9)
sw $8, -48($sp)
lw $9, -48($sp)
mul $8, $9, 2
sw $8, -48($sp)
lw $9, -4($sp)
lw $8, 0($9)
sw $8, -56($sp)
lw $9, -48($sp)
lw $10, -56($sp)
sub $8, $9, $10
sw $8, -56($sp)
lw $8, -56($sp)
bgez $8, l5
lw $9, -16($sp)
move $8, $9
sw $8, -60($sp)
lw $9, -8($sp)
lw $8, 0($9)
sw $8, -64($sp)
lw $9, -64($sp)
mul $8, $9, 2
sw $8, -64($sp)
lw $8, -64($sp)
lw $9, -60($sp)
sw $8, 0($9)
lw $9, -8($sp)
lw $8, 0($9)
sw $8, -72($sp)
lw $9, -72($sp)
mul $8, $9, 2
sw $8, -72($sp)
lw $9, -72($sp)
add $8, $9, 1
sw $8, -72($sp)
lw $9, -4($sp)
lw $8, 0($9)
sw $8, -84($sp)
lw $9, -72($sp)
lw $10, -84($sp)
sub $8, $9, $10
sw $8, -84($sp)
lw $8, -84($sp)
bgez $8, l6
lw $9, -8($sp)
lw $8, 0($9)
sw $8, -92($sp)
lw $9, -92($sp)
mul $8, $9, 2
sw $8, -92($sp)
lw $9, -92($sp)
add $8, $9, 1
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
lw $9, -112($sp)
mul $8, $9, 2
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
bgez $8, l6
lw $9, -16($sp)
move $8, $9
sw $8, -124($sp)
lw $9, -8($sp)
lw $8, 0($9)
sw $8, -128($sp)
lw $9, -128($sp)
mul $8, $9, 2
sw $8, -128($sp)
lw $9, -128($sp)
add $8, $9, 1
sw $8, -128($sp)
lw $8, -128($sp)
lw $9, -124($sp)
sw $8, 0($9)
l6:
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
blez $8, l7
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
j l8
l7:
j l5
l8:
j l4
l5:
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
l9:
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
bgez $8, l10
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
lw $9, -76($sp)
sub $8, $9, 1
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
lw $9, -96($sp)
sub $8, $9, 1
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
lw $9, -120($sp)
sub $8, $9, 1
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
l11:
lw $9, -12($sp)
move $8, $9
sw $8, -140($sp)
lw $9, -12($sp)
lw $8, 0($9)
sw $8, -144($sp)
lw $9, -144($sp)
add $8, $9, 1
sw $8, -144($sp)
lw $8, -144($sp)
lw $9, -140($sp)
sw $8, 0($9)
j l9
l10:
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
sw $t0, 804($a3)
la $t0, var3
sw $t0, 832($a3)
add $8, $29, -156
sw $8, -8($sp)
lw $9, -8($sp)
move $8, $9
sw $8, -4($sp)
lw $9, 8($a3)
move $8, $9
sw $8, -12($sp)
li $8, 9987
sw $8, -16($sp)
lw $8, -16($sp)
lw $9, -12($sp)
sw $8, 0($9)
lw $9, -8($sp)
move $8, $9
sw $8, -20($sp)
li $8, 0
sw $8, -24($sp)
lw $8, -24($sp)
lw $9, -20($sp)
sw $8, 0($9)
l12:
lw $9, -4($sp)
lw $8, 0($9)
sw $8, -28($sp)
lw $9, 8($a3)
lw $8, 0($9)
sw $8, -32($sp)
lw $9, -28($sp)
lw $10, -32($sp)
sub $8, $9, $10
sw $8, -32($sp)
lw $8, -32($sp)
bgez $8, l13
lw $9, -4($sp)
lw $8, 0($9)
sw $8, -40($sp)
lw $9, -40($sp)
mul $8, $9, 4
sw $8, -44($sp)
lw $9, 12($a3)
lw $10, -44($sp)
add $8, $9, $10
sw $8, -36($sp)
lw $9, -4($sp)
lw $8, 0($9)
sw $8, -48($sp)
lw $8, -48($sp)
lw $9, -36($sp)
sw $8, 0($9)
l14:
lw $9, -4($sp)
move $8, $9
sw $8, -52($sp)
lw $9, -4($sp)
lw $8, 0($9)
sw $8, -56($sp)
lw $9, -56($sp)
add $8, $9, 1
sw $8, -56($sp)
lw $8, -56($sp)
lw $9, -52($sp)
sw $8, 0($9)
j l12
l13:
add $29, $29, -164
jal __makeHeap
sub $29, $29, -164
add $8, $29, -160
sw $8, -68($sp)
lw $9, -68($sp)
move $8, $9
sw $8, -64($sp)
add $29, $29, -164
jal __heapSort
sub $29, $29, -164
add $8, $29, -160
sw $8, -76($sp)
lw $9, -76($sp)
move $8, $9
sw $8, -72($sp)
lw $9, -4($sp)
move $8, $9
sw $8, -80($sp)
li $8, 0
sw $8, -84($sp)
lw $8, -84($sp)
lw $9, -80($sp)
sw $8, 0($9)
l15:
lw $9, -4($sp)
lw $8, 0($9)
sw $8, -88($sp)
lw $9, 8($a3)
lw $8, 0($9)
sw $8, -92($sp)
lw $9, -88($sp)
lw $10, -92($sp)
sub $8, $9, $10
sw $8, -92($sp)
lw $8, -92($sp)
bgez $8, l16
lw $9, -4($sp)
lw $8, 0($9)
sw $8, -104($sp)
lw $9, -104($sp)
mul $8, $9, 4
sw $8, -108($sp)
lw $9, 12($a3)
lw $10, -108($sp)
add $8, $9, $10
sw $8, -100($sp)
add $8, $29, -164
sw $8, -112($sp)
lw $9, -100($sp)
lw $8, 0($9)
sw $8, -100($sp)
lw $8, -100($sp)
lw $9, -112($sp)
sw $8, 0($9)
lw $9, 804($a3)
move $8, $9
sw $8, -116($sp)
add $8, $29, -168
sw $8, -120($sp)
lw $8, -116($sp)
lw $9, -120($sp)
sw $8, 0($9)
add $29, $29, -168
jal __printf
sub $29, $29, -168
l17:
lw $9, -4($sp)
move $8, $9
sw $8, -124($sp)
lw $9, -4($sp)
lw $8, 0($9)
sw $8, -128($sp)
lw $9, -128($sp)
add $8, $9, 1
sw $8, -128($sp)
lw $8, -128($sp)
lw $9, -124($sp)
sw $8, 0($9)
j l15
l16:
lw $9, 832($a3)
move $8, $9
sw $8, -140($sp)
add $8, $29, -164
sw $8, -144($sp)
lw $8, -140($sp)
lw $9, -144($sp)
sw $8, 0($9)
add $29, $29, -164
jal __printf_single
sub $29, $29, -164
li $8, 0
sw $8, -148($sp)
add $8, $29, 4
sw $8, -152($sp)
lw $8, -148($sp)
lw $9, -152($sp)
sw $8, 0($9)
j __main_end
j __main_end
__main_end:
li $v0, 10
syscall
