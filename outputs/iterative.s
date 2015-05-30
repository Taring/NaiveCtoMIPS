.data
temp: .space 1536
var0: .space 4
var1: .space 4
var2: .space 4
var3: .space 4
var4: .space 4
var5: .space 4
var6: .space 4
var7: .space 4
var8: .space 4
var9: .space 4
var10: .space 4
var11: .asciiz "%d %d\n"
.align 2
var12: .asciiz "%d:"
.align 2
var13: .asciiz " %d"
.align 2
var14: .asciiz "\n"
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

__dfs:
add $8, $29, 0
sw $8, -4($sp)
add $8, $29, -188
sw $8, -12($sp)
lw $9, -12($sp)
move $8, $9
sw $8, -8($sp)
lw $9, 40($a3)
lw $8, 0($9)
sw $8, -16($sp)
lw $9, -4($sp)
lw $8, 0($9)
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
lw $9, -8($sp)
sw $8, 0($9)
label0:
lw $9, -8($sp)
lw $8, 0($9)
sw $8, -28($sp)
lw $8, -28($sp)
beqz $8, label1
add $8, $29, -192
sw $8, -36($sp)
lw $9, -36($sp)
move $8, $9
sw $8, -32($sp)
sw $31, -200($29)
li $8, 8
sw $8, -44($sp)
add $8, $29, -204
sw $8, -48($sp)
lw $8, -44($sp)
lw $9, -48($sp)
sw $8, 0($9)
add $29, $29, -204
jal __malloc
sub $29, $29, -204
lw $31, -200($29)
add $8, $29, -196
sw $8, -52($sp)
lw $9, -52($sp)
lw $8, 0($9)
sw $8, -40($sp)
lw $8, -40($sp)
lw $9, -32($sp)
sw $8, 0($9)
lw $9, 28($a3)
lw $8, 0($9)
sw $8, -56($sp)
lw $9, -8($sp)
lw $8, 0($9)
sw $8, -60($sp)
lw $9, -60($sp)
add $8, $9, 0
sw $8, -60($sp)
lw $9, -60($sp)
lw $8, 0($9)
sw $8, -60($sp)
lw $9, -60($sp)
mul $8, $9, 4
sw $8, -64($sp)
lw $9, -56($sp)
lw $10, -64($sp)
add $8, $9, $10
sw $8, -56($sp)
lw $9, -56($sp)
lw $8, 0($9)
sw $8, -56($sp)
li $8, -1
sw $8, -68($sp)
lw $9, -56($sp)
lw $10, -68($sp)
sub $8, $9, $10
sw $8, -68($sp)
lw $8, -68($sp)
bnez $8, label2
lw $9, 28($a3)
lw $8, 0($9)
sw $8, -72($sp)
lw $9, -8($sp)
lw $8, 0($9)
sw $8, -76($sp)
lw $9, -76($sp)
add $8, $9, 0
sw $8, -76($sp)
lw $9, -76($sp)
lw $8, 0($9)
sw $8, -76($sp)
lw $9, -76($sp)
mul $8, $9, 4
sw $8, -80($sp)
lw $9, -72($sp)
lw $10, -80($sp)
add $8, $9, $10
sw $8, -72($sp)
lw $9, -4($sp)
lw $8, 0($9)
sw $8, -84($sp)
lw $8, -84($sp)
lw $9, -72($sp)
sw $8, 0($9)
sw $31, -196($29)
lw $9, -8($sp)
lw $8, 0($9)
sw $8, -92($sp)
lw $9, -92($sp)
add $8, $9, 0
sw $8, -92($sp)
add $8, $29, -200
sw $8, -96($sp)
lw $9, -92($sp)
lw $8, 0($9)
sw $8, -92($sp)
lw $8, -92($sp)
lw $9, -96($sp)
sw $8, 0($9)
add $29, $29, -200
jal __dfs
sub $29, $29, -200
lw $31, -196($29)
label2:
lw $9, -32($sp)
lw $8, 0($9)
sw $8, -100($sp)
lw $9, -100($sp)
add $8, $9, 0
sw $8, -100($sp)
lw $9, -4($sp)
lw $8, 0($9)
sw $8, -104($sp)
lw $8, -104($sp)
lw $9, -100($sp)
sw $8, 0($9)
lw $9, -32($sp)
lw $8, 0($9)
sw $8, -108($sp)
lw $9, -108($sp)
add $8, $9, 4
sw $8, -108($sp)
lw $9, 44($a3)
lw $8, 0($9)
sw $8, -112($sp)
lw $9, -8($sp)
lw $8, 0($9)
sw $8, -116($sp)
lw $9, -116($sp)
add $8, $9, 0
sw $8, -116($sp)
lw $9, -116($sp)
lw $8, 0($9)
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
lw $9, -108($sp)
sw $8, 0($9)
lw $9, 44($a3)
lw $8, 0($9)
sw $8, -124($sp)
lw $9, -8($sp)
lw $8, 0($9)
sw $8, -128($sp)
lw $9, -128($sp)
add $8, $9, 0
sw $8, -128($sp)
lw $9, -128($sp)
lw $8, 0($9)
sw $8, -128($sp)
lw $9, -128($sp)
mul $8, $9, 4
sw $8, -132($sp)
lw $9, -124($sp)
lw $10, -132($sp)
add $8, $9, $10
sw $8, -124($sp)
lw $9, -32($sp)
lw $8, 0($9)
sw $8, -136($sp)
lw $8, -136($sp)
lw $9, -124($sp)
sw $8, 0($9)
lw $9, -8($sp)
move $8, $9
sw $8, -140($sp)
lw $9, -8($sp)
lw $8, 0($9)
sw $8, -144($sp)
lw $9, -144($sp)
add $8, $9, 4
sw $8, -144($sp)
lw $9, -144($sp)
lw $8, 0($9)
sw $8, -144($sp)
lw $8, -144($sp)
lw $9, -140($sp)
sw $8, 0($9)
j label0
label1:
lw $9, 32($a3)
lw $8, 0($9)
sw $8, -148($sp)
lw $9, 8($a3)
lw $8, 0($9)
sw $8, -152($sp)
lw $9, 16($a3)
move $8, $9
sw $8, -164($sp)
lw $9, 16($a3)
lw $8, 0($9)
sw $8, -160($sp)
lw $9, -160($sp)
add $8, $9, 1
sw $8, -160($sp)
lw $8, -160($sp)
lw $9, -164($sp)
sw $8, 0($9)
lw $9, -152($sp)
lw $10, -160($sp)
sub $8, $9, $10
sw $8, -152($sp)
lw $9, -152($sp)
mul $8, $9, 4
sw $8, -156($sp)
lw $9, -148($sp)
lw $10, -156($sp)
add $8, $9, $10
sw $8, -148($sp)
lw $9, -4($sp)
lw $8, 0($9)
sw $8, -168($sp)
lw $8, -168($sp)
lw $9, -148($sp)
sw $8, 0($9)
lw $9, 36($a3)
lw $8, 0($9)
sw $8, -172($sp)
lw $9, -4($sp)
lw $8, 0($9)
sw $8, -176($sp)
lw $9, -176($sp)
mul $8, $9, 4
sw $8, -180($sp)
lw $9, -172($sp)
lw $10, -180($sp)
add $8, $9, $10
sw $8, -172($sp)
lw $9, 16($a3)
lw $8, 0($9)
sw $8, -184($sp)
lw $8, -184($sp)
lw $9, -172($sp)
sw $8, 0($9)
jr $ra
__get_dom:
add $8, $29, 0
sw $8, -4($sp)
add $8, $29, 4
sw $8, -8($sp)
label3:
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
beqz $8, label4
lw $9, 36($a3)
lw $8, 0($9)
sw $8, -20($sp)
lw $9, -4($sp)
lw $8, 0($9)
sw $8, -24($sp)
lw $9, -24($sp)
mul $8, $9, 4
sw $8, -28($sp)
lw $9, -20($sp)
lw $10, -28($sp)
add $8, $9, $10
sw $8, -20($sp)
lw $9, -20($sp)
lw $8, 0($9)
sw $8, -20($sp)
lw $9, 36($a3)
lw $8, 0($9)
sw $8, -32($sp)
lw $9, -8($sp)
lw $8, 0($9)
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
lw $9, -20($sp)
lw $10, -32($sp)
sub $8, $9, $10
sw $8, -32($sp)
lw $8, -32($sp)
bgez $8, label5
lw $9, -4($sp)
move $8, $9
sw $8, -44($sp)
lw $9, 20($a3)
lw $8, 0($9)
sw $8, -48($sp)
lw $9, -4($sp)
lw $8, 0($9)
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
lw $9, -44($sp)
sw $8, 0($9)
j label6
label5:
lw $9, -8($sp)
move $8, $9
sw $8, -60($sp)
lw $9, 20($a3)
lw $8, 0($9)
sw $8, -64($sp)
lw $9, -8($sp)
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
lw $9, -60($sp)
sw $8, 0($9)
label6:
j label3
label4:
add $8, $29, 12
sw $8, -80($sp)
lw $9, -4($sp)
lw $8, 0($9)
sw $8, -76($sp)
lw $8, -76($sp)
lw $9, -80($sp)
sw $8, 0($9)
jr $ra
jr $ra
__get_int:
add $8, $29, -140
sw $8, -8($sp)
lw $9, -8($sp)
move $8, $9
sw $8, -4($sp)
sw $31, -148($29)
add $29, $29, -148
jal __getchar
sub $29, $29, -148
lw $31, -148($29)
add $8, $29, -144
sw $8, -16($sp)
lw $9, -16($sp)
lw $8, 0($9)
sw $8, -12($sp)
lw $8, -12($sp)
lw $9, -4($sp)
sw $8, 0($9)
add $8, $29, -144
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
lw $9, -4($sp)
lw $8, 0($9)
sw $8, -32($sp)
li $8, 48
sw $8, -36($sp)
lw $9, -32($sp)
lw $10, -36($sp)
sub $8, $9, $10
sw $8, -36($sp)
li $8, 1
sw $8, -32($sp)
lw $8, -36($sp)
bltz $8, label9
li $8, 0
sw $8, -32($sp)
label9:
lw $8, -32($sp)
bnez $8, label10
lw $9, -4($sp)
lw $8, 0($9)
sw $8, -32($sp)
li $8, 57
sw $8, -40($sp)
lw $9, -32($sp)
lw $10, -40($sp)
sub $8, $9, $10
sw $8, -40($sp)
li $8, 1
sw $8, -32($sp)
lw $8, -40($sp)
bgtz $8, label11
li $8, 0
sw $8, -32($sp)
label11:
label10:
lw $9, -32($sp)
andi $8, $9, 1
sw $8, -32($sp)
lw $8, -32($sp)
beqz $8, label8
lw $9, -4($sp)
lw $8, 0($9)
sw $8, -44($sp)
li $8, 45
sw $8, -48($sp)
lw $9, -44($sp)
lw $10, -48($sp)
sub $8, $9, $10
sw $8, -48($sp)
lw $8, -48($sp)
beqz $8, label8
lw $9, -4($sp)
move $8, $9
sw $8, -52($sp)
sw $31, -152($29)
add $29, $29, -152
jal __getchar
sub $29, $29, -152
lw $31, -152($29)
add $8, $29, -148
sw $8, -60($sp)
lw $9, -60($sp)
lw $8, 0($9)
sw $8, -56($sp)
lw $8, -56($sp)
lw $9, -52($sp)
sw $8, 0($9)
j label7
label8:
lw $9, -4($sp)
lw $8, 0($9)
sw $8, -64($sp)
li $8, 45
sw $8, -68($sp)
lw $9, -64($sp)
lw $10, -68($sp)
sub $8, $9, $10
sw $8, -68($sp)
lw $8, -68($sp)
bnez $8, label12
sw $31, -152($29)
add $29, $29, -152
jal __get_int
sub $29, $29, -152
lw $31, -152($29)
add $8, $29, -148
sw $8, -76($sp)
lw $9, -76($sp)
lw $8, 0($9)
sw $8, -72($sp)
lw $9, -72($sp)
neg $8, $9
sw $8, -72($sp)
add $8, $29, 4
sw $8, -80($sp)
lw $8, -72($sp)
lw $9, -80($sp)
sw $8, 0($9)
jr $ra
label12:
label13:
lw $9, -4($sp)
lw $8, 0($9)
sw $8, -84($sp)
li $8, 48
sw $8, -88($sp)
lw $9, -84($sp)
lw $10, -88($sp)
sub $8, $9, $10
sw $8, -88($sp)
lw $8, -88($sp)
bltz $8, label14
lw $9, -4($sp)
lw $8, 0($9)
sw $8, -92($sp)
li $8, 57
sw $8, -96($sp)
lw $9, -92($sp)
lw $10, -96($sp)
sub $8, $9, $10
sw $8, -96($sp)
lw $8, -96($sp)
bgtz $8, label14
lw $9, -20($sp)
move $8, $9
sw $8, -100($sp)
lw $9, -20($sp)
lw $8, 0($9)
sw $8, -104($sp)
li $8, 10
sw $8, -108($sp)
lw $9, -104($sp)
lw $10, -108($sp)
mul $8, $9, $10
sw $8, -104($sp)
lw $9, -4($sp)
lw $8, 0($9)
sw $8, -112($sp)
lw $9, -104($sp)
lw $10, -112($sp)
add $8, $9, $10
sw $8, -104($sp)
li $8, 48
sw $8, -116($sp)
lw $9, -104($sp)
lw $10, -116($sp)
sub $8, $9, $10
sw $8, -104($sp)
lw $8, -104($sp)
lw $9, -100($sp)
sw $8, 0($9)
lw $9, -4($sp)
move $8, $9
sw $8, -120($sp)
sw $31, -152($29)
add $29, $29, -152
jal __getchar
sub $29, $29, -152
lw $31, -152($29)
add $8, $29, -148
sw $8, -128($sp)
lw $9, -128($sp)
lw $8, 0($9)
sw $8, -124($sp)
lw $8, -124($sp)
lw $9, -120($sp)
sw $8, 0($9)
j label13
label14:
add $8, $29, 4
sw $8, -136($sp)
lw $9, -20($sp)
lw $8, 0($9)
sw $8, -132($sp)
lw $8, -132($sp)
lw $9, -136($sp)
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
sw $t0, 36($a3)
la $t0, var8
sw $t0, 40($a3)
la $t0, var9
sw $t0, 44($a3)
la $t0, var10
sw $t0, 48($a3)
la $t0, var11
sw $t0, 1392($a3)
la $t0, var12
sw $t0, 1460($a3)
la $t0, var13
sw $t0, 1488($a3)
la $t0, var14
sw $t0, 1512($a3)
add $8, $29, -1072
sw $8, -8($sp)
lw $9, -8($sp)
move $8, $9
sw $8, -4($sp)
li $8, 1
sw $8, -12($sp)
lw $8, -12($sp)
lw $9, -4($sp)
sw $8, 0($9)
add $8, $29, -1076
sw $8, -20($sp)
lw $9, -20($sp)
move $8, $9
sw $8, -16($sp)
lw $9, 8($a3)
move $8, $9
sw $8, -24($sp)
add $29, $29, -1084
jal __get_int
sub $29, $29, -1084
add $8, $29, -1080
sw $8, -32($sp)
lw $9, -32($sp)
lw $8, 0($9)
sw $8, -28($sp)
lw $8, -28($sp)
lw $9, -24($sp)
sw $8, 0($9)
lw $9, 12($a3)
move $8, $9
sw $8, -36($sp)
add $29, $29, -1084
jal __get_int
sub $29, $29, -1084
add $8, $29, -1080
sw $8, -44($sp)
lw $9, -44($sp)
lw $8, 0($9)
sw $8, -40($sp)
lw $8, -40($sp)
lw $9, -36($sp)
sw $8, 0($9)
lw $9, 20($a3)
move $8, $9
sw $8, -48($sp)
lw $9, 8($a3)
lw $8, 0($9)
sw $8, -56($sp)
li $8, 4
sw $8, -60($sp)
lw $9, -56($sp)
lw $10, -60($sp)
mul $8, $9, $10
sw $8, -56($sp)
add $8, $29, -1088
sw $8, -64($sp)
lw $8, -56($sp)
lw $9, -64($sp)
sw $8, 0($9)
add $29, $29, -1088
jal __malloc
sub $29, $29, -1088
add $8, $29, -1080
sw $8, -68($sp)
lw $9, -68($sp)
lw $8, 0($9)
sw $8, -52($sp)
lw $8, -52($sp)
lw $9, -48($sp)
sw $8, 0($9)
lw $9, 28($a3)
move $8, $9
sw $8, -72($sp)
lw $9, 8($a3)
lw $8, 0($9)
sw $8, -80($sp)
li $8, 4
sw $8, -84($sp)
lw $9, -80($sp)
lw $10, -84($sp)
mul $8, $9, $10
sw $8, -80($sp)
add $8, $29, -1088
sw $8, -88($sp)
lw $8, -80($sp)
lw $9, -88($sp)
sw $8, 0($9)
add $29, $29, -1088
jal __malloc
sub $29, $29, -1088
add $8, $29, -1080
sw $8, -92($sp)
lw $9, -92($sp)
lw $8, 0($9)
sw $8, -76($sp)
lw $8, -76($sp)
lw $9, -72($sp)
sw $8, 0($9)
lw $9, 32($a3)
move $8, $9
sw $8, -96($sp)
lw $9, 8($a3)
lw $8, 0($9)
sw $8, -104($sp)
li $8, 4
sw $8, -108($sp)
lw $9, -104($sp)
lw $10, -108($sp)
mul $8, $9, $10
sw $8, -104($sp)
add $8, $29, -1088
sw $8, -112($sp)
lw $8, -104($sp)
lw $9, -112($sp)
sw $8, 0($9)
add $29, $29, -1088
jal __malloc
sub $29, $29, -1088
add $8, $29, -1080
sw $8, -116($sp)
lw $9, -116($sp)
lw $8, 0($9)
sw $8, -100($sp)
lw $8, -100($sp)
lw $9, -96($sp)
sw $8, 0($9)
lw $9, 36($a3)
move $8, $9
sw $8, -120($sp)
lw $9, 8($a3)
lw $8, 0($9)
sw $8, -128($sp)
li $8, 4
sw $8, -132($sp)
lw $9, -128($sp)
lw $10, -132($sp)
mul $8, $9, $10
sw $8, -128($sp)
add $8, $29, -1088
sw $8, -136($sp)
lw $8, -128($sp)
lw $9, -136($sp)
sw $8, 0($9)
add $29, $29, -1088
jal __malloc
sub $29, $29, -1088
add $8, $29, -1080
sw $8, -140($sp)
lw $9, -140($sp)
lw $8, 0($9)
sw $8, -124($sp)
lw $8, -124($sp)
lw $9, -120($sp)
sw $8, 0($9)
lw $9, 40($a3)
move $8, $9
sw $8, -144($sp)
lw $9, 8($a3)
lw $8, 0($9)
sw $8, -152($sp)
li $8, 4
sw $8, -156($sp)
lw $9, -152($sp)
lw $10, -156($sp)
mul $8, $9, $10
sw $8, -152($sp)
add $8, $29, -1088
sw $8, -160($sp)
lw $8, -152($sp)
lw $9, -160($sp)
sw $8, 0($9)
add $29, $29, -1088
jal __malloc
sub $29, $29, -1088
add $8, $29, -1080
sw $8, -164($sp)
lw $9, -164($sp)
lw $8, 0($9)
sw $8, -148($sp)
lw $8, -148($sp)
lw $9, -144($sp)
sw $8, 0($9)
lw $9, 44($a3)
move $8, $9
sw $8, -168($sp)
lw $9, 8($a3)
lw $8, 0($9)
sw $8, -176($sp)
li $8, 4
sw $8, -180($sp)
lw $9, -176($sp)
lw $10, -180($sp)
mul $8, $9, $10
sw $8, -176($sp)
add $8, $29, -1088
sw $8, -184($sp)
lw $8, -176($sp)
lw $9, -184($sp)
sw $8, 0($9)
add $29, $29, -1088
jal __malloc
sub $29, $29, -1088
add $8, $29, -1080
sw $8, -188($sp)
lw $9, -188($sp)
lw $8, 0($9)
sw $8, -172($sp)
lw $8, -172($sp)
lw $9, -168($sp)
sw $8, 0($9)
lw $9, 48($a3)
move $8, $9
sw $8, -192($sp)
lw $9, 8($a3)
lw $8, 0($9)
sw $8, -200($sp)
li $8, 4
sw $8, -204($sp)
lw $9, -200($sp)
lw $10, -204($sp)
mul $8, $9, $10
sw $8, -200($sp)
add $8, $29, -1088
sw $8, -208($sp)
lw $8, -200($sp)
lw $9, -208($sp)
sw $8, 0($9)
add $29, $29, -1088
jal __malloc
sub $29, $29, -1088
add $8, $29, -1080
sw $8, -212($sp)
lw $9, -212($sp)
lw $8, 0($9)
sw $8, -196($sp)
lw $8, -196($sp)
lw $9, -192($sp)
sw $8, 0($9)
lw $9, -20($sp)
move $8, $9
sw $8, -216($sp)
li $8, 0
sw $8, -220($sp)
lw $8, -220($sp)
lw $9, -216($sp)
sw $8, 0($9)
label15:
lw $9, -16($sp)
lw $8, 0($9)
sw $8, -224($sp)
lw $9, 8($a3)
lw $8, 0($9)
sw $8, -228($sp)
lw $9, -224($sp)
lw $10, -228($sp)
sub $8, $9, $10
sw $8, -228($sp)
lw $8, -228($sp)
bgez $8, label16
lw $9, 28($a3)
lw $8, 0($9)
sw $8, -232($sp)
lw $9, -16($sp)
lw $8, 0($9)
sw $8, -236($sp)
lw $9, -236($sp)
mul $8, $9, 4
sw $8, -240($sp)
lw $9, -232($sp)
lw $10, -240($sp)
add $8, $9, $10
sw $8, -232($sp)
lw $9, 20($a3)
lw $8, 0($9)
sw $8, -244($sp)
lw $9, -16($sp)
lw $8, 0($9)
sw $8, -248($sp)
lw $9, -248($sp)
mul $8, $9, 4
sw $8, -252($sp)
lw $9, -244($sp)
lw $10, -252($sp)
add $8, $9, $10
sw $8, -244($sp)
li $8, -1
sw $8, -256($sp)
lw $8, -256($sp)
lw $9, -244($sp)
sw $8, 0($9)
lw $9, -244($sp)
lw $8, 0($9)
sw $8, -244($sp)
lw $8, -244($sp)
lw $9, -232($sp)
sw $8, 0($9)
lw $9, 44($a3)
lw $8, 0($9)
sw $8, -260($sp)
lw $9, -16($sp)
lw $8, 0($9)
sw $8, -264($sp)
lw $9, -264($sp)
mul $8, $9, 4
sw $8, -268($sp)
lw $9, -260($sp)
lw $10, -268($sp)
add $8, $9, $10
sw $8, -260($sp)
lw $9, 40($a3)
lw $8, 0($9)
sw $8, -272($sp)
lw $9, -16($sp)
lw $8, 0($9)
sw $8, -276($sp)
lw $9, -276($sp)
mul $8, $9, 4
sw $8, -280($sp)
lw $9, -272($sp)
lw $10, -280($sp)
add $8, $9, $10
sw $8, -272($sp)
li $8, 0
sw $8, -284($sp)
lw $8, -284($sp)
lw $9, -272($sp)
sw $8, 0($9)
lw $9, -272($sp)
lw $8, 0($9)
sw $8, -272($sp)
lw $8, -272($sp)
lw $9, -260($sp)
sw $8, 0($9)
label17:
lw $9, -16($sp)
move $8, $9
sw $8, -292($sp)
lw $9, -16($sp)
lw $8, 0($9)
sw $8, -288($sp)
lw $9, -288($sp)
add $8, $9, 1
sw $8, -288($sp)
lw $8, -288($sp)
lw $9, -292($sp)
sw $8, 0($9)
j label15
label16:
lw $9, -16($sp)
move $8, $9
sw $8, -296($sp)
li $8, 0
sw $8, -300($sp)
lw $8, -300($sp)
lw $9, -296($sp)
sw $8, 0($9)
label18:
lw $9, -16($sp)
lw $8, 0($9)
sw $8, -304($sp)
lw $9, 12($a3)
lw $8, 0($9)
sw $8, -308($sp)
lw $9, -304($sp)
lw $10, -308($sp)
sub $8, $9, $10
sw $8, -308($sp)
lw $8, -308($sp)
bgez $8, label19
add $8, $29, -1080
sw $8, -316($sp)
lw $9, -316($sp)
move $8, $9
sw $8, -312($sp)
add $29, $29, -1088
jal __get_int
sub $29, $29, -1088
add $8, $29, -1084
sw $8, -324($sp)
lw $9, -324($sp)
lw $8, 0($9)
sw $8, -320($sp)
lw $8, -320($sp)
lw $9, -312($sp)
sw $8, 0($9)
add $8, $29, -1084
sw $8, -332($sp)
lw $9, -332($sp)
move $8, $9
sw $8, -328($sp)
add $29, $29, -1092
jal __get_int
sub $29, $29, -1092
add $8, $29, -1088
sw $8, -340($sp)
lw $9, -340($sp)
lw $8, 0($9)
sw $8, -336($sp)
lw $8, -336($sp)
lw $9, -328($sp)
sw $8, 0($9)
add $8, $29, -1088
sw $8, -348($sp)
lw $9, -348($sp)
move $8, $9
sw $8, -344($sp)
li $8, 8
sw $8, -356($sp)
add $8, $29, -1100
sw $8, -360($sp)
lw $8, -356($sp)
lw $9, -360($sp)
sw $8, 0($9)
add $29, $29, -1100
jal __malloc
sub $29, $29, -1100
add $8, $29, -1092
sw $8, -364($sp)
lw $9, -364($sp)
lw $8, 0($9)
sw $8, -352($sp)
lw $8, -352($sp)
lw $9, -344($sp)
sw $8, 0($9)
lw $9, -344($sp)
lw $8, 0($9)
sw $8, -368($sp)
lw $9, -368($sp)
add $8, $9, 0
sw $8, -368($sp)
lw $9, -328($sp)
lw $8, 0($9)
sw $8, -372($sp)
lw $8, -372($sp)
lw $9, -368($sp)
sw $8, 0($9)
lw $9, -344($sp)
lw $8, 0($9)
sw $8, -376($sp)
lw $9, -376($sp)
add $8, $9, 4
sw $8, -376($sp)
lw $9, 40($a3)
lw $8, 0($9)
sw $8, -380($sp)
lw $9, -312($sp)
lw $8, 0($9)
sw $8, -384($sp)
lw $9, -384($sp)
mul $8, $9, 4
sw $8, -388($sp)
lw $9, -380($sp)
lw $10, -388($sp)
add $8, $9, $10
sw $8, -380($sp)
lw $9, -380($sp)
lw $8, 0($9)
sw $8, -380($sp)
lw $8, -380($sp)
lw $9, -376($sp)
sw $8, 0($9)
lw $9, 40($a3)
lw $8, 0($9)
sw $8, -392($sp)
lw $9, -312($sp)
lw $8, 0($9)
sw $8, -396($sp)
lw $9, -396($sp)
mul $8, $9, 4
sw $8, -400($sp)
lw $9, -392($sp)
lw $10, -400($sp)
add $8, $9, $10
sw $8, -392($sp)
lw $9, -344($sp)
lw $8, 0($9)
sw $8, -404($sp)
lw $8, -404($sp)
lw $9, -392($sp)
sw $8, 0($9)
label20:
lw $9, -16($sp)
move $8, $9
sw $8, -412($sp)
lw $9, -16($sp)
lw $8, 0($9)
sw $8, -408($sp)
lw $9, -408($sp)
add $8, $9, 1
sw $8, -408($sp)
lw $8, -408($sp)
lw $9, -412($sp)
sw $8, 0($9)
j label18
label19:
lw $9, 24($a3)
move $8, $9
sw $8, -416($sp)
add $29, $29, -1084
jal __get_int
sub $29, $29, -1084
add $8, $29, -1080
sw $8, -424($sp)
lw $9, -424($sp)
lw $8, 0($9)
sw $8, -420($sp)
lw $8, -420($sp)
lw $9, -416($sp)
sw $8, 0($9)
lw $9, 20($a3)
lw $8, 0($9)
sw $8, -428($sp)
lw $9, 24($a3)
lw $8, 0($9)
sw $8, -432($sp)
lw $9, -432($sp)
mul $8, $9, 4
sw $8, -436($sp)
lw $9, -428($sp)
lw $10, -436($sp)
add $8, $9, $10
sw $8, -428($sp)
lw $9, 28($a3)
lw $8, 0($9)
sw $8, -440($sp)
lw $9, 24($a3)
lw $8, 0($9)
sw $8, -444($sp)
lw $9, -444($sp)
mul $8, $9, 4
sw $8, -448($sp)
lw $9, -440($sp)
lw $10, -448($sp)
add $8, $9, $10
sw $8, -440($sp)
lw $9, 24($a3)
lw $8, 0($9)
sw $8, -452($sp)
lw $8, -452($sp)
lw $9, -440($sp)
sw $8, 0($9)
lw $9, -440($sp)
lw $8, 0($9)
sw $8, -440($sp)
lw $8, -440($sp)
lw $9, -428($sp)
sw $8, 0($9)
add $8, $29, -1084
sw $8, -464($sp)
lw $9, 24($a3)
lw $8, 0($9)
sw $8, -460($sp)
lw $8, -460($sp)
lw $9, -464($sp)
sw $8, 0($9)
add $29, $29, -1084
jal __dfs
sub $29, $29, -1084
label21:
lw $9, -4($sp)
lw $8, 0($9)
sw $8, -468($sp)
lw $8, -468($sp)
beqz $8, label22
add $8, $29, -1080
sw $8, -476($sp)
lw $9, -476($sp)
move $8, $9
sw $8, -472($sp)
lw $9, -4($sp)
move $8, $9
sw $8, -480($sp)
li $8, 0
sw $8, -484($sp)
lw $8, -484($sp)
lw $9, -480($sp)
sw $8, 0($9)
lw $9, -16($sp)
move $8, $9
sw $8, -488($sp)
li $8, 1
sw $8, -492($sp)
lw $8, -492($sp)
lw $9, -488($sp)
sw $8, 0($9)
label23:
lw $9, -16($sp)
lw $8, 0($9)
sw $8, -496($sp)
lw $9, 8($a3)
lw $8, 0($9)
sw $8, -500($sp)
lw $9, -496($sp)
lw $10, -500($sp)
sub $8, $9, $10
sw $8, -500($sp)
lw $8, -500($sp)
bgez $8, label24
add $8, $29, -1084
sw $8, -508($sp)
lw $9, -508($sp)
move $8, $9
sw $8, -504($sp)
lw $9, 44($a3)
lw $8, 0($9)
sw $8, -512($sp)
lw $9, 32($a3)
lw $8, 0($9)
sw $8, -516($sp)
lw $9, -16($sp)
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
mul $8, $9, 4
sw $8, -520($sp)
lw $9, -512($sp)
lw $10, -520($sp)
add $8, $9, $10
sw $8, -512($sp)
lw $9, -512($sp)
lw $8, 0($9)
sw $8, -512($sp)
lw $8, -512($sp)
lw $9, -504($sp)
sw $8, 0($9)
lw $9, -472($sp)
move $8, $9
sw $8, -532($sp)
lw $9, 28($a3)
lw $8, 0($9)
sw $8, -536($sp)
lw $9, 32($a3)
lw $8, 0($9)
sw $8, -540($sp)
lw $9, -16($sp)
lw $8, 0($9)
sw $8, -548($sp)
lw $9, -548($sp)
mul $8, $9, 4
sw $8, -552($sp)
lw $9, -540($sp)
lw $10, -552($sp)
add $8, $9, $10
sw $8, -540($sp)
lw $9, -540($sp)
lw $8, 0($9)
sw $8, -540($sp)
lw $9, -540($sp)
mul $8, $9, 4
sw $8, -544($sp)
lw $9, -536($sp)
lw $10, -544($sp)
add $8, $9, $10
sw $8, -536($sp)
lw $9, -536($sp)
lw $8, 0($9)
sw $8, -536($sp)
lw $8, -536($sp)
lw $9, -532($sp)
sw $8, 0($9)
label26:
lw $9, -504($sp)
lw $8, 0($9)
sw $8, -556($sp)
lw $8, -556($sp)
beqz $8, label27
lw $9, 20($a3)
lw $8, 0($9)
sw $8, -560($sp)
lw $9, -504($sp)
lw $8, 0($9)
sw $8, -564($sp)
lw $9, -564($sp)
add $8, $9, 0
sw $8, -564($sp)
lw $9, -564($sp)
lw $8, 0($9)
sw $8, -564($sp)
lw $9, -564($sp)
mul $8, $9, 4
sw $8, -568($sp)
lw $9, -560($sp)
lw $10, -568($sp)
add $8, $9, $10
sw $8, -560($sp)
lw $9, -560($sp)
lw $8, 0($9)
sw $8, -560($sp)
li $8, -1
sw $8, -572($sp)
lw $9, -560($sp)
lw $10, -572($sp)
sub $8, $9, $10
sw $8, -572($sp)
lw $8, -572($sp)
beqz $8, label28
lw $9, -472($sp)
move $8, $9
sw $8, -576($sp)
lw $9, -504($sp)
lw $8, 0($9)
sw $8, -584($sp)
lw $9, -584($sp)
add $8, $9, 0
sw $8, -584($sp)
add $8, $29, -1096
sw $8, -588($sp)
lw $9, -584($sp)
lw $8, 0($9)
sw $8, -584($sp)
lw $8, -584($sp)
lw $9, -588($sp)
sw $8, 0($9)
add $8, $29, -1100
sw $8, -596($sp)
lw $9, -472($sp)
lw $8, 0($9)
sw $8, -592($sp)
lw $8, -592($sp)
lw $9, -596($sp)
sw $8, 0($9)
add $29, $29, -1100
jal __get_dom
sub $29, $29, -1100
add $8, $29, -1088
sw $8, -600($sp)
lw $9, -600($sp)
lw $8, 0($9)
sw $8, -580($sp)
lw $8, -580($sp)
lw $9, -576($sp)
sw $8, 0($9)
label28:
lw $9, -504($sp)
move $8, $9
sw $8, -604($sp)
lw $9, -504($sp)
lw $8, 0($9)
sw $8, -608($sp)
lw $9, -608($sp)
add $8, $9, 4
sw $8, -608($sp)
lw $9, -608($sp)
lw $8, 0($9)
sw $8, -608($sp)
lw $8, -608($sp)
lw $9, -604($sp)
sw $8, 0($9)
j label26
label27:
lw $9, -472($sp)
lw $8, 0($9)
sw $8, -612($sp)
lw $9, 20($a3)
lw $8, 0($9)
sw $8, -616($sp)
lw $9, 32($a3)
lw $8, 0($9)
sw $8, -620($sp)
lw $9, -16($sp)
lw $8, 0($9)
sw $8, -628($sp)
lw $9, -628($sp)
mul $8, $9, 4
sw $8, -632($sp)
lw $9, -620($sp)
lw $10, -632($sp)
add $8, $9, $10
sw $8, -620($sp)
lw $9, -620($sp)
lw $8, 0($9)
sw $8, -620($sp)
lw $9, -620($sp)
mul $8, $9, 4
sw $8, -624($sp)
lw $9, -616($sp)
lw $10, -624($sp)
add $8, $9, $10
sw $8, -616($sp)
lw $9, -616($sp)
lw $8, 0($9)
sw $8, -616($sp)
lw $9, -612($sp)
lw $10, -616($sp)
sub $8, $9, $10
sw $8, -616($sp)
lw $8, -616($sp)
beqz $8, label29
lw $9, 20($a3)
lw $8, 0($9)
sw $8, -636($sp)
lw $9, 32($a3)
lw $8, 0($9)
sw $8, -640($sp)
lw $9, -16($sp)
lw $8, 0($9)
sw $8, -648($sp)
lw $9, -648($sp)
mul $8, $9, 4
sw $8, -652($sp)
lw $9, -640($sp)
lw $10, -652($sp)
add $8, $9, $10
sw $8, -640($sp)
lw $9, -640($sp)
lw $8, 0($9)
sw $8, -640($sp)
lw $9, -640($sp)
mul $8, $9, 4
sw $8, -644($sp)
lw $9, -636($sp)
lw $10, -644($sp)
add $8, $9, $10
sw $8, -636($sp)
lw $9, -472($sp)
lw $8, 0($9)
sw $8, -656($sp)
lw $8, -656($sp)
lw $9, -636($sp)
sw $8, 0($9)
lw $9, -4($sp)
move $8, $9
sw $8, -660($sp)
li $8, 1
sw $8, -664($sp)
lw $8, -664($sp)
lw $9, -660($sp)
sw $8, 0($9)
label29:
label25:
lw $9, -16($sp)
move $8, $9
sw $8, -672($sp)
lw $9, -16($sp)
lw $8, 0($9)
sw $8, -668($sp)
lw $9, -668($sp)
add $8, $9, 1
sw $8, -668($sp)
lw $8, -668($sp)
lw $9, -672($sp)
sw $8, 0($9)
j label23
label24:
j label21
label22:
lw $9, -16($sp)
move $8, $9
sw $8, -676($sp)
li $8, 0
sw $8, -680($sp)
lw $8, -680($sp)
lw $9, -676($sp)
sw $8, 0($9)
label30:
lw $9, -16($sp)
lw $8, 0($9)
sw $8, -684($sp)
lw $9, 8($a3)
lw $8, 0($9)
sw $8, -688($sp)
lw $9, -684($sp)
lw $10, -688($sp)
sub $8, $9, $10
sw $8, -688($sp)
lw $8, -688($sp)
bgez $8, label31
add $8, $29, -1080
sw $8, -696($sp)
lw $9, -696($sp)
move $8, $9
sw $8, -692($sp)
li $8, 0
sw $8, -700($sp)
lw $8, -700($sp)
lw $9, -692($sp)
sw $8, 0($9)
add $8, $29, -1084
sw $8, -708($sp)
lw $9, -708($sp)
move $8, $9
sw $8, -704($sp)
lw $9, 44($a3)
lw $8, 0($9)
sw $8, -712($sp)
lw $9, -16($sp)
lw $8, 0($9)
sw $8, -716($sp)
lw $9, -716($sp)
mul $8, $9, 4
sw $8, -720($sp)
lw $9, -712($sp)
lw $10, -720($sp)
add $8, $9, $10
sw $8, -712($sp)
lw $9, -712($sp)
lw $8, 0($9)
sw $8, -712($sp)
lw $8, -712($sp)
lw $9, -704($sp)
sw $8, 0($9)
label33:
lw $9, -704($sp)
lw $8, 0($9)
sw $8, -724($sp)
lw $8, -724($sp)
beqz $8, label34
lw $9, -692($sp)
move $8, $9
sw $8, -732($sp)
lw $9, -692($sp)
lw $8, 0($9)
sw $8, -728($sp)
lw $9, -728($sp)
add $8, $9, 1
sw $8, -728($sp)
lw $8, -728($sp)
lw $9, -732($sp)
sw $8, 0($9)
lw $9, -704($sp)
move $8, $9
sw $8, -736($sp)
lw $9, -704($sp)
lw $8, 0($9)
sw $8, -740($sp)
lw $9, -740($sp)
add $8, $9, 4
sw $8, -740($sp)
lw $9, -740($sp)
lw $8, 0($9)
sw $8, -740($sp)
lw $8, -740($sp)
lw $9, -736($sp)
sw $8, 0($9)
j label33
label34:
lw $9, -692($sp)
lw $8, 0($9)
sw $8, -744($sp)
li $8, 2
sw $8, -748($sp)
lw $9, -744($sp)
lw $10, -748($sp)
sub $8, $9, $10
sw $8, -748($sp)
lw $8, -748($sp)
bltz $8, label35
lw $9, -704($sp)
move $8, $9
sw $8, -752($sp)
lw $9, 44($a3)
lw $8, 0($9)
sw $8, -756($sp)
lw $9, -16($sp)
lw $8, 0($9)
sw $8, -760($sp)
lw $9, -760($sp)
mul $8, $9, 4
sw $8, -764($sp)
lw $9, -756($sp)
lw $10, -764($sp)
add $8, $9, $10
sw $8, -756($sp)
lw $9, -756($sp)
lw $8, 0($9)
sw $8, -756($sp)
lw $8, -756($sp)
lw $9, -752($sp)
sw $8, 0($9)
label36:
lw $9, -704($sp)
lw $8, 0($9)
sw $8, -768($sp)
lw $8, -768($sp)
beqz $8, label37
add $8, $29, -1088
sw $8, -776($sp)
lw $9, -776($sp)
move $8, $9
sw $8, -772($sp)
lw $9, -704($sp)
lw $8, 0($9)
sw $8, -780($sp)
lw $9, -780($sp)
add $8, $9, 0
sw $8, -780($sp)
lw $9, -780($sp)
lw $8, 0($9)
sw $8, -780($sp)
lw $8, -780($sp)
lw $9, -772($sp)
sw $8, 0($9)
label38:
lw $9, -772($sp)
lw $8, 0($9)
sw $8, -784($sp)
lw $9, 20($a3)
lw $8, 0($9)
sw $8, -788($sp)
lw $9, -16($sp)
lw $8, 0($9)
sw $8, -792($sp)
lw $9, -792($sp)
mul $8, $9, 4
sw $8, -796($sp)
lw $9, -788($sp)
lw $10, -796($sp)
add $8, $9, $10
sw $8, -788($sp)
lw $9, -788($sp)
lw $8, 0($9)
sw $8, -788($sp)
lw $9, -784($sp)
lw $10, -788($sp)
sub $8, $9, $10
sw $8, -788($sp)
lw $8, -788($sp)
beqz $8, label39
add $8, $29, -1092
sw $8, -804($sp)
lw $9, -804($sp)
move $8, $9
sw $8, -800($sp)
li $8, 8
sw $8, -812($sp)
add $8, $29, -1104
sw $8, -816($sp)
lw $8, -812($sp)
lw $9, -816($sp)
sw $8, 0($9)
add $29, $29, -1104
jal __malloc
sub $29, $29, -1104
add $8, $29, -1096
sw $8, -820($sp)
lw $9, -820($sp)
lw $8, 0($9)
sw $8, -808($sp)
lw $8, -808($sp)
lw $9, -800($sp)
sw $8, 0($9)
lw $9, -800($sp)
lw $8, 0($9)
sw $8, -824($sp)
lw $9, -824($sp)
add $8, $9, 0
sw $8, -824($sp)
lw $9, -16($sp)
lw $8, 0($9)
sw $8, -828($sp)
lw $8, -828($sp)
lw $9, -824($sp)
sw $8, 0($9)
lw $9, -800($sp)
lw $8, 0($9)
sw $8, -832($sp)
lw $9, -832($sp)
add $8, $9, 4
sw $8, -832($sp)
lw $9, 48($a3)
lw $8, 0($9)
sw $8, -836($sp)
lw $9, -772($sp)
lw $8, 0($9)
sw $8, -840($sp)
lw $9, -840($sp)
mul $8, $9, 4
sw $8, -844($sp)
lw $9, -836($sp)
lw $10, -844($sp)
add $8, $9, $10
sw $8, -836($sp)
lw $9, -836($sp)
lw $8, 0($9)
sw $8, -836($sp)
lw $8, -836($sp)
lw $9, -832($sp)
sw $8, 0($9)
lw $9, 48($a3)
lw $8, 0($9)
sw $8, -848($sp)
lw $9, -772($sp)
lw $8, 0($9)
sw $8, -852($sp)
lw $9, -852($sp)
mul $8, $9, 4
sw $8, -856($sp)
lw $9, -848($sp)
lw $10, -856($sp)
add $8, $9, $10
sw $8, -848($sp)
lw $9, -800($sp)
lw $8, 0($9)
sw $8, -860($sp)
lw $8, -860($sp)
lw $9, -848($sp)
sw $8, 0($9)
lw $9, -772($sp)
move $8, $9
sw $8, -864($sp)
lw $9, 20($a3)
lw $8, 0($9)
sw $8, -868($sp)
lw $9, -772($sp)
lw $8, 0($9)
sw $8, -872($sp)
lw $9, -872($sp)
mul $8, $9, 4
sw $8, -876($sp)
lw $9, -868($sp)
lw $10, -876($sp)
add $8, $9, $10
sw $8, -868($sp)
lw $9, -868($sp)
lw $8, 0($9)
sw $8, -868($sp)
lw $8, -868($sp)
lw $9, -864($sp)
sw $8, 0($9)
j label38
label39:
lw $9, -704($sp)
move $8, $9
sw $8, -880($sp)
lw $9, -704($sp)
lw $8, 0($9)
sw $8, -884($sp)
lw $9, -884($sp)
add $8, $9, 4
sw $8, -884($sp)
lw $9, -884($sp)
lw $8, 0($9)
sw $8, -884($sp)
lw $8, -884($sp)
lw $9, -880($sp)
sw $8, 0($9)
j label36
label37:
label35:
label32:
lw $9, -16($sp)
move $8, $9
sw $8, -892($sp)
lw $9, -16($sp)
lw $8, 0($9)
sw $8, -888($sp)
lw $9, -888($sp)
add $8, $9, 1
sw $8, -888($sp)
lw $8, -888($sp)
lw $9, -892($sp)
sw $8, 0($9)
j label30
label31:
lw $9, -16($sp)
move $8, $9
sw $8, -896($sp)
li $8, 0
sw $8, -900($sp)
lw $8, -900($sp)
lw $9, -896($sp)
sw $8, 0($9)
label40:
lw $9, -16($sp)
lw $8, 0($9)
sw $8, -904($sp)
lw $9, 8($a3)
lw $8, 0($9)
sw $8, -908($sp)
lw $9, -904($sp)
lw $10, -908($sp)
sub $8, $9, $10
sw $8, -908($sp)
lw $8, -908($sp)
bgez $8, label41
lw $9, 20($a3)
lw $8, 0($9)
sw $8, -916($sp)
lw $9, -16($sp)
lw $8, 0($9)
sw $8, -920($sp)
lw $9, -920($sp)
mul $8, $9, 4
sw $8, -924($sp)
lw $9, -916($sp)
lw $10, -924($sp)
add $8, $9, $10
sw $8, -916($sp)
add $8, $29, -1084
sw $8, -928($sp)
lw $9, -916($sp)
lw $8, 0($9)
sw $8, -916($sp)
lw $8, -916($sp)
lw $9, -928($sp)
sw $8, 0($9)
add $8, $29, -1088
sw $8, -936($sp)
lw $9, -16($sp)
lw $8, 0($9)
sw $8, -932($sp)
lw $8, -932($sp)
lw $9, -936($sp)
sw $8, 0($9)
lw $9, 1392($a3)
move $8, $9
sw $8, -940($sp)
add $8, $29, -1092
sw $8, -944($sp)
lw $8, -940($sp)
lw $9, -944($sp)
sw $8, 0($9)
add $29, $29, -1092
jal __printf
sub $29, $29, -1092
label42:
lw $9, -16($sp)
move $8, $9
sw $8, -952($sp)
lw $9, -16($sp)
lw $8, 0($9)
sw $8, -948($sp)
lw $9, -948($sp)
add $8, $9, 1
sw $8, -948($sp)
lw $8, -948($sp)
lw $9, -952($sp)
sw $8, 0($9)
j label40
label41:
lw $9, -16($sp)
move $8, $9
sw $8, -956($sp)
li $8, 0
sw $8, -960($sp)
lw $8, -960($sp)
lw $9, -956($sp)
sw $8, 0($9)
label43:
lw $9, -16($sp)
lw $8, 0($9)
sw $8, -964($sp)
lw $9, 8($a3)
lw $8, 0($9)
sw $8, -968($sp)
lw $9, -964($sp)
lw $10, -968($sp)
sub $8, $9, $10
sw $8, -968($sp)
lw $8, -968($sp)
bgez $8, label44
add $8, $29, -1080
sw $8, -976($sp)
lw $9, -976($sp)
move $8, $9
sw $8, -972($sp)
lw $9, 48($a3)
lw $8, 0($9)
sw $8, -980($sp)
lw $9, -16($sp)
lw $8, 0($9)
sw $8, -984($sp)
lw $9, -984($sp)
mul $8, $9, 4
sw $8, -988($sp)
lw $9, -980($sp)
lw $10, -988($sp)
add $8, $9, $10
sw $8, -980($sp)
lw $9, -980($sp)
lw $8, 0($9)
sw $8, -980($sp)
lw $8, -980($sp)
lw $9, -972($sp)
sw $8, 0($9)
add $8, $29, -1088
sw $8, -1000($sp)
lw $9, -16($sp)
lw $8, 0($9)
sw $8, -996($sp)
lw $8, -996($sp)
lw $9, -1000($sp)
sw $8, 0($9)
lw $9, 1460($a3)
move $8, $9
sw $8, -1004($sp)
add $8, $29, -1092
sw $8, -1008($sp)
lw $8, -1004($sp)
lw $9, -1008($sp)
sw $8, 0($9)
add $29, $29, -1092
jal __printf
sub $29, $29, -1092
label46:
lw $9, -972($sp)
lw $8, 0($9)
sw $8, -1012($sp)
lw $8, -1012($sp)
beqz $8, label47
lw $9, -972($sp)
lw $8, 0($9)
sw $8, -1020($sp)
lw $9, -1020($sp)
add $8, $9, 0
sw $8, -1020($sp)
add $8, $29, -1088
sw $8, -1024($sp)
lw $9, -1020($sp)
lw $8, 0($9)
sw $8, -1020($sp)
lw $8, -1020($sp)
lw $9, -1024($sp)
sw $8, 0($9)
lw $9, 1488($a3)
move $8, $9
sw $8, -1028($sp)
add $8, $29, -1092
sw $8, -1032($sp)
lw $8, -1028($sp)
lw $9, -1032($sp)
sw $8, 0($9)
add $29, $29, -1092
jal __printf
sub $29, $29, -1092
lw $9, -972($sp)
move $8, $9
sw $8, -1036($sp)
lw $9, -972($sp)
lw $8, 0($9)
sw $8, -1040($sp)
lw $9, -1040($sp)
add $8, $9, 4
sw $8, -1040($sp)
lw $9, -1040($sp)
lw $8, 0($9)
sw $8, -1040($sp)
lw $8, -1040($sp)
lw $9, -1036($sp)
sw $8, 0($9)
j label46
label47:
lw $9, 1512($a3)
move $8, $9
sw $8, -1048($sp)
add $8, $29, -1088
sw $8, -1052($sp)
lw $8, -1048($sp)
lw $9, -1052($sp)
sw $8, 0($9)
add $29, $29, -1088
jal __printf_single
sub $29, $29, -1088
label45:
lw $9, -16($sp)
move $8, $9
sw $8, -1060($sp)
lw $9, -16($sp)
lw $8, 0($9)
sw $8, -1056($sp)
lw $9, -1056($sp)
add $8, $9, 1
sw $8, -1056($sp)
lw $8, -1056($sp)
lw $9, -1060($sp)
sw $8, 0($9)
j label43
label44:
li $8, 0
sw $8, -1064($sp)
add $8, $29, 4
sw $8, -1068($sp)
lw $8, -1064($sp)
lw $9, -1068($sp)
sw $8, 0($9)
j __main_end
j __main_end
__main_end:
li $v0, 10
syscall
#global $2 4
#global $3 4
#global $4 4
#global $5 4
#global $6 4
#global $7 4
#global $8 4
#global $9 4
#global $10 4
#global $11 4
#global $12 4
#string $348 #%d %d\n
#string $365 #%d:
#string $372 # %d
#string $378 #\n
#----------------------------
#func #dfs
#addi $13 $0 0
#addi $15 $0 -188
#move $14 $15
####move $16 $10
#lw $16 $10 0
####move $17 $13
#lw $17 $13 0
#muli $18 $17 4
#add $16 $16 $18
#lw $16 $16 0
#sw $16 $14 0
#label l:0
####move $19 $14
#lw $19 $14 0
#beqz $19 l:1
#addi $21 $0 -192
#move $20 $21
#sw $1 $0 -200
#li $23 8
#addi $24 $0 -204
#sw $23 $24 0
#addi $0 $0 -204
#call #malloc
#subi $0 $0 -204
#lw $1 $0 -200
#addi $25 $0 -196
####move $22 $25
#lw $22 $25 0
#sw $22 $20 0
####move $26 $7
#lw $26 $7 0
####move $27 $14
#lw $27 $14 0
#addi $27 $27 0
#lw $27 $27 0
#muli $28 $27 4
#add $26 $26 $28
#lw $26 $26 0
#li $29 -1
#sub $29 $26 $29
#bnez $29 l:2
####move $30 $7
#lw $30 $7 0
####move $31 $14
#lw $31 $14 0
#addi $31 $31 0
#lw $31 $31 0
#muli $32 $31 4
#add $30 $30 $32
####move $33 $13
#lw $33 $13 0
#sw $33 $30 0
#sw $1 $0 -196
####move $35 $14
#lw $35 $14 0
#addi $35 $35 0
#addi $36 $0 -200
#lw $35 $35 0
#sw $35 $36 0
#addi $0 $0 -200
#call #dfs
#subi $0 $0 -200
#lw $1 $0 -196
#label l:2
####move $37 $20
#lw $37 $20 0
#addi $37 $37 0
####move $38 $13
#lw $38 $13 0
#sw $38 $37 0
####move $39 $20
#lw $39 $20 0
#addi $39 $39 4
####move $40 $11
#lw $40 $11 0
####move $41 $14
#lw $41 $14 0
#addi $41 $41 0
#lw $41 $41 0
#muli $42 $41 4
#add $40 $40 $42
#lw $40 $40 0
#sw $40 $39 0
####move $43 $11
#lw $43 $11 0
####move $44 $14
#lw $44 $14 0
#addi $44 $44 0
#lw $44 $44 0
#muli $45 $44 4
#add $43 $43 $45
####move $46 $20
#lw $46 $20 0
#sw $46 $43 0
#move $47 $14
####move $48 $14
#lw $48 $14 0
#addi $48 $48 4
#lw $48 $48 0
#sw $48 $47 0
#goto l:0
#label l:1
####move $49 $8
#lw $49 $8 0
####move $50 $2
#lw $50 $2 0
####move $52 $4
#move $53 $4
#lw $52 $4 0
#addi $52 $52 1
#sw $52 $53 0
#sub $50 $50 $52
#muli $51 $50 4
#add $49 $49 $51
####move $54 $13
#lw $54 $13 0
#sw $54 $49 0
####move $55 $9
#lw $55 $9 0
####move $56 $13
#lw $56 $13 0
#muli $57 $56 4
#add $55 $55 $57
####move $58 $4
#lw $58 $4 0
#sw $58 $55 0
#return
#----------------------------
#func #get_dom
#addi $59 $0 0
#addi $60 $0 4
#label l:3
####move $61 $59
#lw $61 $59 0
####move $62 $60
#lw $62 $60 0
#sub $62 $61 $62
#beqz $62 l:4
####move $63 $9
#lw $63 $9 0
####move $64 $59
#lw $64 $59 0
#muli $65 $64 4
#add $63 $63 $65
#lw $63 $63 0
####move $66 $9
#lw $66 $9 0
####move $67 $60
#lw $67 $60 0
#muli $68 $67 4
#add $66 $66 $68
#lw $66 $66 0
#sub $66 $63 $66
#bgez $66 l:5
#move $69 $59
####move $70 $5
#lw $70 $5 0
####move $71 $59
#lw $71 $59 0
#muli $72 $71 4
#add $70 $70 $72
#lw $70 $70 0
#sw $70 $69 0
#goto l:6
#label l:5
#move $73 $60
####move $74 $5
#lw $74 $5 0
####move $75 $60
#lw $75 $60 0
#muli $76 $75 4
#add $74 $74 $76
#lw $74 $74 0
#sw $74 $73 0
#label l:6
#goto l:3
#label l:4
####move $77 $59
#addi $78 $0 12
#lw $77 $59 0
#sw $77 $78 0
#return
#return
#----------------------------
#func #get_int
#addi $80 $0 -140
#move $79 $80
#sw $1 $0 -148
#addi $0 $0 -148
#call #getchar
#subi $0 $0 -148
#lw $1 $0 -148
#addi $82 $0 -144
####move $81 $82
#lw $81 $82 0
#sw $81 $79 0
#addi $84 $0 -144
#move $83 $84
#li $85 0
#sw $85 $83 0
#label l:7
####move $86 $79
#lw $86 $79 0
#li $87 48
#sub $87 $86 $87
#li $86 1
#bltz $87 l:9
#li $86 0
#label l:9
#bnez $86 l:10
####move $86 $79
#lw $86 $79 0
#li $88 57
#sub $88 $86 $88
#li $86 1
#bgtz $88 l:11
#li $86 0
#label l:11
#label l:10
#andi $86 $86 1
#beqz $86 l:8
####move $89 $79
#lw $89 $79 0
#li $90 45
#sub $90 $89 $90
#beqz $90 l:8
#move $91 $79
#sw $1 $0 -152
#addi $0 $0 -152
#call #getchar
#subi $0 $0 -152
#lw $1 $0 -152
#addi $93 $0 -148
####move $92 $93
#lw $92 $93 0
#sw $92 $91 0
#goto l:7
#label l:8
####move $94 $79
#lw $94 $79 0
#li $95 45
#sub $95 $94 $95
#bnez $95 l:12
#sw $1 $0 -152
#addi $0 $0 -152
#call #get_int
#subi $0 $0 -152
#lw $1 $0 -152
#addi $97 $0 -148
####move $96 $97
#lw $96 $97 0
#neg $96 $96
#addi $98 $0 4
#sw $96 $98 0
#return
#label l:12
#label l:13
####move $99 $79
#lw $99 $79 0
#li $100 48
#sub $100 $99 $100
#bltz $100 l:14
####move $101 $79
#lw $101 $79 0
#li $102 57
#sub $102 $101 $102
#bgtz $102 l:14
#move $103 $83
####move $104 $83
#lw $104 $83 0
#li $105 10
#mul $104 $104 $105
####move $106 $79
#lw $106 $79 0
#add $104 $104 $106
#li $107 48
#sub $104 $104 $107
#sw $104 $103 0
#move $108 $79
#sw $1 $0 -152
#addi $0 $0 -152
#call #getchar
#subi $0 $0 -152
#lw $1 $0 -152
#addi $110 $0 -148
####move $109 $110
#lw $109 $110 0
#sw $109 $108 0
#goto l:13
#label l:14
####move $111 $83
#addi $112 $0 4
#lw $111 $83 0
#sw $111 $112 0
#return
#return
#----------------------------
#func #main
#addi $114 $0 -1072
#move $113 $114
#li $115 1
#sw $115 $113 0
#addi $117 $0 -1076
#move $116 $117
#move $118 $2
#addi $0 $0 -1084
#call #get_int
#subi $0 $0 -1084
#addi $120 $0 -1080
####move $119 $120
#lw $119 $120 0
#sw $119 $118 0
#move $121 $3
#addi $0 $0 -1084
#call #get_int
#subi $0 $0 -1084
#addi $123 $0 -1080
####move $122 $123
#lw $122 $123 0
#sw $122 $121 0
#move $124 $5
####move $126 $2
#lw $126 $2 0
#li $127 4
#mul $126 $126 $127
#addi $128 $0 -1088
#sw $126 $128 0
#addi $0 $0 -1088
#call #malloc
#subi $0 $0 -1088
#addi $129 $0 -1080
####move $125 $129
#lw $125 $129 0
#sw $125 $124 0
#move $130 $7
####move $132 $2
#lw $132 $2 0
#li $133 4
#mul $132 $132 $133
#addi $134 $0 -1088
#sw $132 $134 0
#addi $0 $0 -1088
#call #malloc
#subi $0 $0 -1088
#addi $135 $0 -1080
####move $131 $135
#lw $131 $135 0
#sw $131 $130 0
#move $136 $8
####move $138 $2
#lw $138 $2 0
#li $139 4
#mul $138 $138 $139
#addi $140 $0 -1088
#sw $138 $140 0
#addi $0 $0 -1088
#call #malloc
#subi $0 $0 -1088
#addi $141 $0 -1080
####move $137 $141
#lw $137 $141 0
#sw $137 $136 0
#move $142 $9
####move $144 $2
#lw $144 $2 0
#li $145 4
#mul $144 $144 $145
#addi $146 $0 -1088
#sw $144 $146 0
#addi $0 $0 -1088
#call #malloc
#subi $0 $0 -1088
#addi $147 $0 -1080
####move $143 $147
#lw $143 $147 0
#sw $143 $142 0
#move $148 $10
####move $150 $2
#lw $150 $2 0
#li $151 4
#mul $150 $150 $151
#addi $152 $0 -1088
#sw $150 $152 0
#addi $0 $0 -1088
#call #malloc
#subi $0 $0 -1088
#addi $153 $0 -1080
####move $149 $153
#lw $149 $153 0
#sw $149 $148 0
#move $154 $11
####move $156 $2
#lw $156 $2 0
#li $157 4
#mul $156 $156 $157
#addi $158 $0 -1088
#sw $156 $158 0
#addi $0 $0 -1088
#call #malloc
#subi $0 $0 -1088
#addi $159 $0 -1080
####move $155 $159
#lw $155 $159 0
#sw $155 $154 0
#move $160 $12
####move $162 $2
#lw $162 $2 0
#li $163 4
#mul $162 $162 $163
#addi $164 $0 -1088
#sw $162 $164 0
#addi $0 $0 -1088
#call #malloc
#subi $0 $0 -1088
#addi $165 $0 -1080
####move $161 $165
#lw $161 $165 0
#sw $161 $160 0
#move $166 $117
#li $167 0
#sw $167 $166 0
#label l:15
####move $168 $116
#lw $168 $116 0
####move $169 $2
#lw $169 $2 0
#sub $169 $168 $169
#bgez $169 l:16
####move $170 $7
#lw $170 $7 0
####move $171 $116
#lw $171 $116 0
#muli $172 $171 4
#add $170 $170 $172
####move $173 $5
#lw $173 $5 0
####move $174 $116
#lw $174 $116 0
#muli $175 $174 4
#add $173 $173 $175
#li $176 -1
#sw $176 $173 0
#lw $173 $173 0
#sw $173 $170 0
####move $177 $11
#lw $177 $11 0
####move $178 $116
#lw $178 $116 0
#muli $179 $178 4
#add $177 $177 $179
####move $180 $10
#lw $180 $10 0
####move $181 $116
#lw $181 $116 0
#muli $182 $181 4
#add $180 $180 $182
#li $183 0
#sw $183 $180 0
#lw $180 $180 0
#sw $180 $177 0
#label l:17
####move $184 $116
#move $185 $116
#lw $184 $116 0
#addi $184 $184 1
#sw $184 $185 0
#goto l:15
#label l:16
#move $186 $116
#li $187 0
#sw $187 $186 0
#label l:18
####move $188 $116
#lw $188 $116 0
####move $189 $3
#lw $189 $3 0
#sub $189 $188 $189
#bgez $189 l:19
#addi $191 $0 -1080
#move $190 $191
#addi $0 $0 -1088
#call #get_int
#subi $0 $0 -1088
#addi $193 $0 -1084
####move $192 $193
#lw $192 $193 0
#sw $192 $190 0
#addi $195 $0 -1084
#move $194 $195
#addi $0 $0 -1092
#call #get_int
#subi $0 $0 -1092
#addi $197 $0 -1088
####move $196 $197
#lw $196 $197 0
#sw $196 $194 0
#addi $199 $0 -1088
#move $198 $199
#li $201 8
#addi $202 $0 -1100
#sw $201 $202 0
#addi $0 $0 -1100
#call #malloc
#subi $0 $0 -1100
#addi $203 $0 -1092
####move $200 $203
#lw $200 $203 0
#sw $200 $198 0
####move $204 $198
#lw $204 $198 0
#addi $204 $204 0
####move $205 $194
#lw $205 $194 0
#sw $205 $204 0
####move $206 $198
#lw $206 $198 0
#addi $206 $206 4
####move $207 $10
#lw $207 $10 0
####move $208 $190
#lw $208 $190 0
#muli $209 $208 4
#add $207 $207 $209
#lw $207 $207 0
#sw $207 $206 0
####move $210 $10
#lw $210 $10 0
####move $211 $190
#lw $211 $190 0
#muli $212 $211 4
#add $210 $210 $212
####move $213 $198
#lw $213 $198 0
#sw $213 $210 0
#label l:20
####move $214 $116
#move $215 $116
#lw $214 $116 0
#addi $214 $214 1
#sw $214 $215 0
#goto l:18
#label l:19
#move $216 $6
#addi $0 $0 -1084
#call #get_int
#subi $0 $0 -1084
#addi $218 $0 -1080
####move $217 $218
#lw $217 $218 0
#sw $217 $216 0
####move $219 $5
#lw $219 $5 0
####move $220 $6
#lw $220 $6 0
#muli $221 $220 4
#add $219 $219 $221
####move $222 $7
#lw $222 $7 0
####move $223 $6
#lw $223 $6 0
#muli $224 $223 4
#add $222 $222 $224
####move $225 $6
#lw $225 $6 0
#sw $225 $222 0
#lw $222 $222 0
#sw $222 $219 0
####move $227 $6
#addi $228 $0 -1084
#lw $227 $6 0
#sw $227 $228 0
#addi $0 $0 -1084
#call #dfs
#subi $0 $0 -1084
#label l:21
####move $229 $113
#lw $229 $113 0
#beqz $229 l:22
#addi $231 $0 -1080
#move $230 $231
#move $232 $113
#li $233 0
#sw $233 $232 0
#move $234 $116
#li $235 1
#sw $235 $234 0
#label l:23
####move $236 $116
#lw $236 $116 0
####move $237 $2
#lw $237 $2 0
#sub $237 $236 $237
#bgez $237 l:24
#addi $239 $0 -1084
#move $238 $239
####move $240 $11
#lw $240 $11 0
####move $241 $8
#lw $241 $8 0
####move $243 $116
#lw $243 $116 0
#muli $244 $243 4
#add $241 $241 $244
#lw $241 $241 0
#muli $242 $241 4
#add $240 $240 $242
#lw $240 $240 0
#sw $240 $238 0
#move $245 $230
####move $246 $7
#lw $246 $7 0
####move $247 $8
#lw $247 $8 0
####move $249 $116
#lw $249 $116 0
#muli $250 $249 4
#add $247 $247 $250
#lw $247 $247 0
#muli $248 $247 4
#add $246 $246 $248
#lw $246 $246 0
#sw $246 $245 0
#label l:26
####move $251 $238
#lw $251 $238 0
#beqz $251 l:27
####move $252 $5
#lw $252 $5 0
####move $253 $238
#lw $253 $238 0
#addi $253 $253 0
#lw $253 $253 0
#muli $254 $253 4
#add $252 $252 $254
#lw $252 $252 0
#li $255 -1
#sub $255 $252 $255
#beqz $255 l:28
#move $256 $230
####move $258 $238
#lw $258 $238 0
#addi $258 $258 0
#addi $259 $0 -1096
#lw $258 $258 0
#sw $258 $259 0
####move $260 $230
#addi $261 $0 -1100
#lw $260 $230 0
#sw $260 $261 0
#addi $0 $0 -1100
#call #get_dom
#subi $0 $0 -1100
#addi $262 $0 -1088
####move $257 $262
#lw $257 $262 0
#sw $257 $256 0
#label l:28
#move $263 $238
####move $264 $238
#lw $264 $238 0
#addi $264 $264 4
#lw $264 $264 0
#sw $264 $263 0
#goto l:26
#label l:27
####move $265 $230
#lw $265 $230 0
####move $266 $5
#lw $266 $5 0
####move $267 $8
#lw $267 $8 0
####move $269 $116
#lw $269 $116 0
#muli $270 $269 4
#add $267 $267 $270
#lw $267 $267 0
#muli $268 $267 4
#add $266 $266 $268
#lw $266 $266 0
#sub $266 $265 $266
#beqz $266 l:29
####move $271 $5
#lw $271 $5 0
####move $272 $8
#lw $272 $8 0
####move $274 $116
#lw $274 $116 0
#muli $275 $274 4
#add $272 $272 $275
#lw $272 $272 0
#muli $273 $272 4
#add $271 $271 $273
####move $276 $230
#lw $276 $230 0
#sw $276 $271 0
#move $277 $113
#li $278 1
#sw $278 $277 0
#label l:29
#label l:25
####move $279 $116
#move $280 $116
#lw $279 $116 0
#addi $279 $279 1
#sw $279 $280 0
#goto l:23
#label l:24
#goto l:21
#label l:22
#move $281 $116
#li $282 0
#sw $282 $281 0
#label l:30
####move $283 $116
#lw $283 $116 0
####move $284 $2
#lw $284 $2 0
#sub $284 $283 $284
#bgez $284 l:31
#addi $286 $0 -1080
#move $285 $286
#li $287 0
#sw $287 $285 0
#addi $289 $0 -1084
#move $288 $289
####move $290 $11
#lw $290 $11 0
####move $291 $116
#lw $291 $116 0
#muli $292 $291 4
#add $290 $290 $292
#lw $290 $290 0
#sw $290 $288 0
#label l:33
####move $293 $288
#lw $293 $288 0
#beqz $293 l:34
####move $294 $285
#move $295 $285
#lw $294 $285 0
#addi $294 $294 1
#sw $294 $295 0
#move $296 $288
####move $297 $288
#lw $297 $288 0
#addi $297 $297 4
#lw $297 $297 0
#sw $297 $296 0
#goto l:33
#label l:34
####move $298 $285
#lw $298 $285 0
#li $299 2
#sub $299 $298 $299
#bltz $299 l:35
#move $300 $288
####move $301 $11
#lw $301 $11 0
####move $302 $116
#lw $302 $116 0
#muli $303 $302 4
#add $301 $301 $303
#lw $301 $301 0
#sw $301 $300 0
#label l:36
####move $304 $288
#lw $304 $288 0
#beqz $304 l:37
#addi $306 $0 -1088
#move $305 $306
####move $307 $288
#lw $307 $288 0
#addi $307 $307 0
#lw $307 $307 0
#sw $307 $305 0
#label l:38
####move $308 $305
#lw $308 $305 0
####move $309 $5
#lw $309 $5 0
####move $310 $116
#lw $310 $116 0
#muli $311 $310 4
#add $309 $309 $311
#lw $309 $309 0
#sub $309 $308 $309
#beqz $309 l:39
#addi $313 $0 -1092
#move $312 $313
#li $315 8
#addi $316 $0 -1104
#sw $315 $316 0
#addi $0 $0 -1104
#call #malloc
#subi $0 $0 -1104
#addi $317 $0 -1096
####move $314 $317
#lw $314 $317 0
#sw $314 $312 0
####move $318 $312
#lw $318 $312 0
#addi $318 $318 0
####move $319 $116
#lw $319 $116 0
#sw $319 $318 0
####move $320 $312
#lw $320 $312 0
#addi $320 $320 4
####move $321 $12
#lw $321 $12 0
####move $322 $305
#lw $322 $305 0
#muli $323 $322 4
#add $321 $321 $323
#lw $321 $321 0
#sw $321 $320 0
####move $324 $12
#lw $324 $12 0
####move $325 $305
#lw $325 $305 0
#muli $326 $325 4
#add $324 $324 $326
####move $327 $312
#lw $327 $312 0
#sw $327 $324 0
#move $328 $305
####move $329 $5
#lw $329 $5 0
####move $330 $305
#lw $330 $305 0
#muli $331 $330 4
#add $329 $329 $331
#lw $329 $329 0
#sw $329 $328 0
#goto l:38
#label l:39
#move $332 $288
####move $333 $288
#lw $333 $288 0
#addi $333 $333 4
#lw $333 $333 0
#sw $333 $332 0
#goto l:36
#label l:37
#label l:35
#label l:32
####move $334 $116
#move $335 $116
#lw $334 $116 0
#addi $334 $334 1
#sw $334 $335 0
#goto l:30
#label l:31
#move $336 $116
#li $337 0
#sw $337 $336 0
#label l:40
####move $338 $116
#lw $338 $116 0
####move $339 $2
#lw $339 $2 0
#sub $339 $338 $339
#bgez $339 l:41
####move $341 $5
#lw $341 $5 0
####move $342 $116
#lw $342 $116 0
#muli $343 $342 4
#add $341 $341 $343
#addi $344 $0 -1084
#lw $341 $341 0
#sw $341 $344 0
####move $345 $116
#addi $346 $0 -1088
#lw $345 $116 0
#sw $345 $346 0
#move $347 $348
#addi $349 $0 -1092
#sw $347 $349 0
#addi $0 $0 -1092
#call #printf
#subi $0 $0 -1092
#label l:42
####move $350 $116
#move $351 $116
#lw $350 $116 0
#addi $350 $350 1
#sw $350 $351 0
#goto l:40
#label l:41
#move $352 $116
#li $353 0
#sw $353 $352 0
#label l:43
####move $354 $116
#lw $354 $116 0
####move $355 $2
#lw $355 $2 0
#sub $355 $354 $355
#bgez $355 l:44
#addi $357 $0 -1080
#move $356 $357
####move $358 $12
#lw $358 $12 0
####move $359 $116
#lw $359 $116 0
#muli $360 $359 4
#add $358 $358 $360
#lw $358 $358 0
#sw $358 $356 0
####move $362 $116
#addi $363 $0 -1088
#lw $362 $116 0
#sw $362 $363 0
#move $364 $365
#addi $366 $0 -1092
#sw $364 $366 0
#addi $0 $0 -1092
#call #printf
#subi $0 $0 -1092
#label l:46
####move $367 $356
#lw $367 $356 0
#beqz $367 l:47
####move $369 $356
#lw $369 $356 0
#addi $369 $369 0
#addi $370 $0 -1088
#lw $369 $369 0
#sw $369 $370 0
#move $371 $372
#addi $373 $0 -1092
#sw $371 $373 0
#addi $0 $0 -1092
#call #printf
#subi $0 $0 -1092
#move $374 $356
####move $375 $356
#lw $375 $356 0
#addi $375 $375 4
#lw $375 $375 0
#sw $375 $374 0
#goto l:46
#label l:47
#move $377 $378
#addi $379 $0 -1088
#sw $377 $379 0
#addi $0 $0 -1088
#call #printf_single
#subi $0 $0 -1088
#label l:45
####move $380 $116
#move $381 $116
#lw $380 $116 0
#addi $380 $380 1
#sw $380 $381 0
#goto l:43
#label l:44
#li $382 0
#addi $383 $0 4
#sw $382 $383 0
#return
#return
