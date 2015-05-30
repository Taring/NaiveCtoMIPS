.data
temp: .space 836
var0: .space 4
var1: .space 4
var2: .space 4
var3: .space 4
var4: .space 4
var5: .space 4
var6: .space 4
var7: .space 4
var8: .space 48000
var9: .space 48000
var10: .space 4
var11: .space 4
var12: .space 4
var13: .space 44944
var14: .space 4
var15: .space 4
var16: .asciiz "%d\n"
.align 2
var17: .asciiz "no solution!\n"
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

__check:
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
li $8, 1
sw $8, -12($sp)
lw $8, -16($sp)
bltz $8, label0
li $8, 0
sw $8, -12($sp)
label0:
lw $8, -12($sp)
beqz $8, label1
lw $9, -4($sp)
lw $8, 0($9)
sw $8, -12($sp)
li $8, 0
sw $8, -20($sp)
lw $9, -12($sp)
lw $10, -20($sp)
sub $8, $9, $10
sw $8, -20($sp)
li $8, 1
sw $8, -12($sp)
lw $8, -20($sp)
bgez $8, label2
li $8, 0
sw $8, -12($sp)
label2:
label1:
lw $9, -12($sp)
andi $8, $9, 1
sw $8, -12($sp)
add $8, $29, 12
sw $8, -24($sp)
lw $8, -12($sp)
lw $9, -24($sp)
sw $8, 0($9)
jr $ra
jr $ra
__addList:
add $8, $29, 0
sw $8, -4($sp)
add $8, $29, 4
sw $8, -8($sp)
sw $31, -192($29)
add $8, $29, -196
sw $8, -20($sp)
lw $9, 8($a3)
lw $8, 0($9)
sw $8, -16($sp)
lw $8, -16($sp)
lw $9, -20($sp)
sw $8, 0($9)
add $8, $29, -200
sw $8, -28($sp)
lw $9, -4($sp)
lw $8, 0($9)
sw $8, -24($sp)
lw $8, -24($sp)
lw $9, -28($sp)
sw $8, 0($9)
add $29, $29, -200
jal __check
sub $29, $29, -200
lw $31, -192($29)
add $8, $29, -188
sw $8, -32($sp)
lw $9, -32($sp)
lw $8, 0($9)
sw $8, -12($sp)
li $8, 1
sw $8, -36($sp)
lw $9, -12($sp)
lw $10, -36($sp)
sub $8, $9, $10
sw $8, -36($sp)
lw $8, -36($sp)
bnez $8, label3
sw $31, -192($29)
add $8, $29, -196
sw $8, -48($sp)
lw $9, 8($a3)
lw $8, 0($9)
sw $8, -44($sp)
lw $8, -44($sp)
lw $9, -48($sp)
sw $8, 0($9)
add $8, $29, -200
sw $8, -56($sp)
lw $9, -8($sp)
lw $8, 0($9)
sw $8, -52($sp)
lw $8, -52($sp)
lw $9, -56($sp)
sw $8, 0($9)
add $29, $29, -200
jal __check
sub $29, $29, -200
lw $31, -192($29)
add $8, $29, -188
sw $8, -60($sp)
lw $9, -60($sp)
lw $8, 0($9)
sw $8, -40($sp)
li $8, 1
sw $8, -64($sp)
lw $9, -40($sp)
lw $10, -64($sp)
sub $8, $9, $10
sw $8, -64($sp)
lw $8, -64($sp)
bnez $8, label3
lw $9, -4($sp)
lw $8, 0($9)
sw $8, -72($sp)
lw $9, -72($sp)
mul $8, $9, 424
sw $8, -76($sp)
lw $9, 60($a3)
lw $10, -76($sp)
add $8, $9, $10
sw $8, -68($sp)
lw $9, -8($sp)
lw $8, 0($9)
sw $8, -80($sp)
lw $9, -80($sp)
mul $8, $9, 4
sw $8, -84($sp)
lw $9, -68($sp)
lw $10, -84($sp)
add $8, $9, $10
sw $8, -68($sp)
lw $9, -68($sp)
lw $8, 0($9)
sw $8, -68($sp)
li $8, -1
sw $8, -88($sp)
lw $9, -68($sp)
lw $10, -88($sp)
sub $8, $9, $10
sw $8, -88($sp)
lw $8, -88($sp)
bnez $8, label3
lw $9, 48($a3)
move $8, $9
sw $8, -92($sp)
lw $9, 48($a3)
lw $8, 0($9)
sw $8, -96($sp)
li $8, 1
sw $8, -100($sp)
lw $9, -96($sp)
lw $10, -100($sp)
add $8, $9, $10
sw $8, -96($sp)
lw $8, -96($sp)
lw $9, -92($sp)
sw $8, 0($9)
lw $9, 48($a3)
lw $8, 0($9)
sw $8, -108($sp)
lw $9, -108($sp)
mul $8, $9, 4
sw $8, -112($sp)
lw $9, 40($a3)
lw $10, -112($sp)
add $8, $9, $10
sw $8, -104($sp)
lw $9, -4($sp)
lw $8, 0($9)
sw $8, -116($sp)
lw $8, -116($sp)
lw $9, -104($sp)
sw $8, 0($9)
lw $9, 48($a3)
lw $8, 0($9)
sw $8, -124($sp)
lw $9, -124($sp)
mul $8, $9, 4
sw $8, -128($sp)
lw $9, 44($a3)
lw $10, -128($sp)
add $8, $9, $10
sw $8, -120($sp)
lw $9, -8($sp)
lw $8, 0($9)
sw $8, -132($sp)
lw $8, -132($sp)
lw $9, -120($sp)
sw $8, 0($9)
lw $9, -4($sp)
lw $8, 0($9)
sw $8, -140($sp)
lw $9, -140($sp)
mul $8, $9, 424
sw $8, -144($sp)
lw $9, 60($a3)
lw $10, -144($sp)
add $8, $9, $10
sw $8, -136($sp)
lw $9, -8($sp)
lw $8, 0($9)
sw $8, -148($sp)
lw $9, -148($sp)
mul $8, $9, 4
sw $8, -152($sp)
lw $9, -136($sp)
lw $10, -152($sp)
add $8, $9, $10
sw $8, -136($sp)
lw $9, 56($a3)
lw $8, 0($9)
sw $8, -156($sp)
li $8, 1
sw $8, -160($sp)
lw $9, -156($sp)
lw $10, -160($sp)
add $8, $9, $10
sw $8, -156($sp)
lw $8, -156($sp)
lw $9, -136($sp)
sw $8, 0($9)
lw $9, -4($sp)
lw $8, 0($9)
sw $8, -164($sp)
lw $9, 24($a3)
lw $8, 0($9)
sw $8, -168($sp)
lw $9, -164($sp)
lw $10, -168($sp)
sub $8, $9, $10
sw $8, -168($sp)
li $8, 1
sw $8, -164($sp)
lw $8, -168($sp)
beqz $8, label5
li $8, 0
sw $8, -164($sp)
label5:
lw $8, -164($sp)
beqz $8, label4
lw $9, -8($sp)
lw $8, 0($9)
sw $8, -172($sp)
lw $9, 28($a3)
lw $8, 0($9)
sw $8, -176($sp)
lw $9, -172($sp)
lw $10, -176($sp)
sub $8, $9, $10
sw $8, -176($sp)
li $8, 1
sw $8, -172($sp)
lw $8, -176($sp)
beqz $8, label6
li $8, 0
sw $8, -172($sp)
label6:
lw $8, -172($sp)
beqz $8, label4
lw $9, 52($a3)
move $8, $9
sw $8, -180($sp)
li $8, 1
sw $8, -184($sp)
lw $8, -184($sp)
lw $9, -180($sp)
sw $8, 0($9)
label4:
label3:
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
sw $t0, 52($a3)
la $t0, var12
sw $t0, 56($a3)
la $t0, var13
sw $t0, 60($a3)
la $t0, var14
sw $t0, 64($a3)
la $t0, var15
sw $t0, 68($a3)
la $t0, var16
sw $t0, 804($a3)
la $t0, var17
sw $t0, 820($a3)
lw $9, 8($a3)
move $8, $9
sw $8, -4($sp)
li $8, 100
sw $8, -8($sp)
add $29, $29, -556
jal __getchar
sub $29, $29, -556
add $8, $29, -552
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
li $8, 10
sw $8, -24($sp)
add $29, $29, -556
jal __getchar
sub $29, $29, -556
add $8, $29, -552
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
add $29, $29, -556
jal __getchar
sub $29, $29, -556
add $8, $29, -552
sw $8, -44($sp)
lw $9, -44($sp)
lw $8, 0($9)
sw $8, -40($sp)
lw $9, -8($sp)
lw $10, -40($sp)
add $8, $9, $10
sw $8, -8($sp)
li $8, 48
sw $8, -48($sp)
lw $9, -8($sp)
lw $10, -48($sp)
sub $8, $9, $10
sw $8, -8($sp)
lw $8, -8($sp)
lw $9, -4($sp)
sw $8, 0($9)
lw $9, 24($a3)
move $8, $9
sw $8, -52($sp)
lw $9, 28($a3)
move $8, $9
sw $8, -56($sp)
lw $9, 8($a3)
lw $8, 0($9)
sw $8, -60($sp)
li $8, 1
sw $8, -64($sp)
lw $9, -60($sp)
lw $10, -64($sp)
sub $8, $9, $10
sw $8, -60($sp)
lw $8, -60($sp)
lw $9, -56($sp)
sw $8, 0($9)
lw $9, -56($sp)
lw $8, 0($9)
sw $8, -56($sp)
lw $8, -56($sp)
lw $9, -52($sp)
sw $8, 0($9)
lw $9, 64($a3)
move $8, $9
sw $8, -68($sp)
li $8, 0
sw $8, -72($sp)
lw $8, -72($sp)
lw $9, -68($sp)
sw $8, 0($9)
label7:
lw $9, 64($a3)
lw $8, 0($9)
sw $8, -76($sp)
lw $9, 8($a3)
lw $8, 0($9)
sw $8, -80($sp)
lw $9, -76($sp)
lw $10, -80($sp)
sub $8, $9, $10
sw $8, -80($sp)
lw $8, -80($sp)
bgez $8, label8
lw $9, 68($a3)
move $8, $9
sw $8, -84($sp)
li $8, 0
sw $8, -88($sp)
lw $8, -88($sp)
lw $9, -84($sp)
sw $8, 0($9)
label10:
lw $9, 68($a3)
lw $8, 0($9)
sw $8, -92($sp)
lw $9, 8($a3)
lw $8, 0($9)
sw $8, -96($sp)
lw $9, -92($sp)
lw $10, -96($sp)
sub $8, $9, $10
sw $8, -96($sp)
lw $8, -96($sp)
bgez $8, label11
lw $9, 64($a3)
lw $8, 0($9)
sw $8, -104($sp)
lw $9, -104($sp)
mul $8, $9, 424
sw $8, -108($sp)
lw $9, 60($a3)
lw $10, -108($sp)
add $8, $9, $10
sw $8, -100($sp)
lw $9, 68($a3)
lw $8, 0($9)
sw $8, -112($sp)
lw $9, -112($sp)
mul $8, $9, 4
sw $8, -116($sp)
lw $9, -100($sp)
lw $10, -116($sp)
add $8, $9, $10
sw $8, -100($sp)
li $8, -1
sw $8, -120($sp)
lw $8, -120($sp)
lw $9, -100($sp)
sw $8, 0($9)
label12:
lw $9, 68($a3)
move $8, $9
sw $8, -128($sp)
lw $9, 68($a3)
lw $8, 0($9)
sw $8, -124($sp)
lw $9, -124($sp)
add $8, $9, 1
sw $8, -132($sp)
lw $8, -132($sp)
lw $9, -128($sp)
sw $8, 0($9)
j label10
label11:
label9:
lw $9, 64($a3)
move $8, $9
sw $8, -140($sp)
lw $9, 64($a3)
lw $8, 0($9)
sw $8, -136($sp)
lw $9, -136($sp)
add $8, $9, 1
sw $8, -144($sp)
lw $8, -144($sp)
lw $9, -140($sp)
sw $8, 0($9)
j label7
label8:
label13:
lw $9, 12($a3)
lw $8, 0($9)
sw $8, -148($sp)
lw $9, 48($a3)
lw $8, 0($9)
sw $8, -152($sp)
lw $9, -148($sp)
lw $10, -152($sp)
sub $8, $9, $10
sw $8, -152($sp)
lw $8, -152($sp)
bgtz $8, label14
lw $9, 32($a3)
move $8, $9
sw $8, -156($sp)
lw $9, 12($a3)
lw $8, 0($9)
sw $8, -164($sp)
lw $9, -164($sp)
mul $8, $9, 4
sw $8, -168($sp)
lw $9, 40($a3)
lw $10, -168($sp)
add $8, $9, $10
sw $8, -160($sp)
lw $9, -160($sp)
lw $8, 0($9)
sw $8, -160($sp)
lw $8, -160($sp)
lw $9, -156($sp)
sw $8, 0($9)
lw $9, 36($a3)
move $8, $9
sw $8, -172($sp)
lw $9, 12($a3)
lw $8, 0($9)
sw $8, -180($sp)
lw $9, -180($sp)
mul $8, $9, 4
sw $8, -184($sp)
lw $9, 44($a3)
lw $10, -184($sp)
add $8, $9, $10
sw $8, -176($sp)
lw $9, -176($sp)
lw $8, 0($9)
sw $8, -176($sp)
lw $8, -176($sp)
lw $9, -172($sp)
sw $8, 0($9)
lw $9, 56($a3)
move $8, $9
sw $8, -188($sp)
lw $9, 32($a3)
lw $8, 0($9)
sw $8, -196($sp)
lw $9, -196($sp)
mul $8, $9, 424
sw $8, -200($sp)
lw $9, 60($a3)
lw $10, -200($sp)
add $8, $9, $10
sw $8, -192($sp)
lw $9, 36($a3)
lw $8, 0($9)
sw $8, -204($sp)
lw $9, -204($sp)
mul $8, $9, 4
sw $8, -208($sp)
lw $9, -192($sp)
lw $10, -208($sp)
add $8, $9, $10
sw $8, -192($sp)
lw $9, -192($sp)
lw $8, 0($9)
sw $8, -192($sp)
lw $8, -192($sp)
lw $9, -188($sp)
sw $8, 0($9)
lw $9, 36($a3)
lw $8, 0($9)
sw $8, -216($sp)
li $8, 2
sw $8, -220($sp)
lw $9, -216($sp)
lw $10, -220($sp)
sub $8, $9, $10
sw $8, -216($sp)
add $8, $29, -560
sw $8, -224($sp)
lw $8, -216($sp)
lw $9, -224($sp)
sw $8, 0($9)
lw $9, 32($a3)
lw $8, 0($9)
sw $8, -228($sp)
li $8, 1
sw $8, -232($sp)
lw $9, -228($sp)
lw $10, -232($sp)
sub $8, $9, $10
sw $8, -228($sp)
add $8, $29, -564
sw $8, -236($sp)
lw $8, -228($sp)
lw $9, -236($sp)
sw $8, 0($9)
add $29, $29, -564
jal __addList
sub $29, $29, -564
add $8, $29, -552
sw $8, -240($sp)
lw $9, -240($sp)
move $8, $9
sw $8, -212($sp)
lw $9, 36($a3)
lw $8, 0($9)
sw $8, -248($sp)
li $8, 2
sw $8, -252($sp)
lw $9, -248($sp)
lw $10, -252($sp)
add $8, $9, $10
sw $8, -248($sp)
add $8, $29, -560
sw $8, -256($sp)
lw $8, -248($sp)
lw $9, -256($sp)
sw $8, 0($9)
lw $9, 32($a3)
lw $8, 0($9)
sw $8, -260($sp)
li $8, 1
sw $8, -264($sp)
lw $9, -260($sp)
lw $10, -264($sp)
sub $8, $9, $10
sw $8, -260($sp)
add $8, $29, -564
sw $8, -268($sp)
lw $8, -260($sp)
lw $9, -268($sp)
sw $8, 0($9)
add $29, $29, -564
jal __addList
sub $29, $29, -564
add $8, $29, -552
sw $8, -272($sp)
lw $9, -272($sp)
move $8, $9
sw $8, -244($sp)
lw $9, 36($a3)
lw $8, 0($9)
sw $8, -280($sp)
li $8, 2
sw $8, -284($sp)
lw $9, -280($sp)
lw $10, -284($sp)
sub $8, $9, $10
sw $8, -280($sp)
add $8, $29, -560
sw $8, -288($sp)
lw $8, -280($sp)
lw $9, -288($sp)
sw $8, 0($9)
lw $9, 32($a3)
lw $8, 0($9)
sw $8, -292($sp)
li $8, 1
sw $8, -296($sp)
lw $9, -292($sp)
lw $10, -296($sp)
add $8, $9, $10
sw $8, -292($sp)
add $8, $29, -564
sw $8, -300($sp)
lw $8, -292($sp)
lw $9, -300($sp)
sw $8, 0($9)
add $29, $29, -564
jal __addList
sub $29, $29, -564
add $8, $29, -552
sw $8, -304($sp)
lw $9, -304($sp)
move $8, $9
sw $8, -276($sp)
lw $9, 36($a3)
lw $8, 0($9)
sw $8, -312($sp)
li $8, 2
sw $8, -316($sp)
lw $9, -312($sp)
lw $10, -316($sp)
add $8, $9, $10
sw $8, -312($sp)
add $8, $29, -560
sw $8, -320($sp)
lw $8, -312($sp)
lw $9, -320($sp)
sw $8, 0($9)
lw $9, 32($a3)
lw $8, 0($9)
sw $8, -324($sp)
li $8, 1
sw $8, -328($sp)
lw $9, -324($sp)
lw $10, -328($sp)
add $8, $9, $10
sw $8, -324($sp)
add $8, $29, -564
sw $8, -332($sp)
lw $8, -324($sp)
lw $9, -332($sp)
sw $8, 0($9)
add $29, $29, -564
jal __addList
sub $29, $29, -564
add $8, $29, -552
sw $8, -336($sp)
lw $9, -336($sp)
move $8, $9
sw $8, -308($sp)
lw $9, 36($a3)
lw $8, 0($9)
sw $8, -344($sp)
li $8, 1
sw $8, -348($sp)
lw $9, -344($sp)
lw $10, -348($sp)
sub $8, $9, $10
sw $8, -344($sp)
add $8, $29, -560
sw $8, -352($sp)
lw $8, -344($sp)
lw $9, -352($sp)
sw $8, 0($9)
lw $9, 32($a3)
lw $8, 0($9)
sw $8, -356($sp)
li $8, 2
sw $8, -360($sp)
lw $9, -356($sp)
lw $10, -360($sp)
sub $8, $9, $10
sw $8, -356($sp)
add $8, $29, -564
sw $8, -364($sp)
lw $8, -356($sp)
lw $9, -364($sp)
sw $8, 0($9)
add $29, $29, -564
jal __addList
sub $29, $29, -564
add $8, $29, -552
sw $8, -368($sp)
lw $9, -368($sp)
move $8, $9
sw $8, -340($sp)
lw $9, 36($a3)
lw $8, 0($9)
sw $8, -376($sp)
li $8, 1
sw $8, -380($sp)
lw $9, -376($sp)
lw $10, -380($sp)
add $8, $9, $10
sw $8, -376($sp)
add $8, $29, -560
sw $8, -384($sp)
lw $8, -376($sp)
lw $9, -384($sp)
sw $8, 0($9)
lw $9, 32($a3)
lw $8, 0($9)
sw $8, -388($sp)
li $8, 2
sw $8, -392($sp)
lw $9, -388($sp)
lw $10, -392($sp)
sub $8, $9, $10
sw $8, -388($sp)
add $8, $29, -564
sw $8, -396($sp)
lw $8, -388($sp)
lw $9, -396($sp)
sw $8, 0($9)
add $29, $29, -564
jal __addList
sub $29, $29, -564
add $8, $29, -552
sw $8, -400($sp)
lw $9, -400($sp)
move $8, $9
sw $8, -372($sp)
lw $9, 36($a3)
lw $8, 0($9)
sw $8, -408($sp)
li $8, 1
sw $8, -412($sp)
lw $9, -408($sp)
lw $10, -412($sp)
sub $8, $9, $10
sw $8, -408($sp)
add $8, $29, -560
sw $8, -416($sp)
lw $8, -408($sp)
lw $9, -416($sp)
sw $8, 0($9)
lw $9, 32($a3)
lw $8, 0($9)
sw $8, -420($sp)
li $8, 2
sw $8, -424($sp)
lw $9, -420($sp)
lw $10, -424($sp)
add $8, $9, $10
sw $8, -420($sp)
add $8, $29, -564
sw $8, -428($sp)
lw $8, -420($sp)
lw $9, -428($sp)
sw $8, 0($9)
add $29, $29, -564
jal __addList
sub $29, $29, -564
add $8, $29, -552
sw $8, -432($sp)
lw $9, -432($sp)
move $8, $9
sw $8, -404($sp)
lw $9, 36($a3)
lw $8, 0($9)
sw $8, -440($sp)
li $8, 1
sw $8, -444($sp)
lw $9, -440($sp)
lw $10, -444($sp)
add $8, $9, $10
sw $8, -440($sp)
add $8, $29, -560
sw $8, -448($sp)
lw $8, -440($sp)
lw $9, -448($sp)
sw $8, 0($9)
lw $9, 32($a3)
lw $8, 0($9)
sw $8, -452($sp)
li $8, 2
sw $8, -456($sp)
lw $9, -452($sp)
lw $10, -456($sp)
add $8, $9, $10
sw $8, -452($sp)
add $8, $29, -564
sw $8, -460($sp)
lw $8, -452($sp)
lw $9, -460($sp)
sw $8, 0($9)
add $29, $29, -564
jal __addList
sub $29, $29, -564
add $8, $29, -552
sw $8, -464($sp)
lw $9, -464($sp)
move $8, $9
sw $8, -436($sp)
lw $9, 52($a3)
lw $8, 0($9)
sw $8, -468($sp)
li $8, 1
sw $8, -472($sp)
lw $9, -468($sp)
lw $10, -472($sp)
sub $8, $9, $10
sw $8, -472($sp)
lw $8, -472($sp)
bnez $8, label15
j label14
label15:
lw $9, 12($a3)
move $8, $9
sw $8, -476($sp)
lw $9, 12($a3)
lw $8, 0($9)
sw $8, -480($sp)
li $8, 1
sw $8, -484($sp)
lw $9, -480($sp)
lw $10, -484($sp)
add $8, $9, $10
sw $8, -480($sp)
lw $8, -480($sp)
lw $9, -476($sp)
sw $8, 0($9)
j label13
label14:
lw $9, 52($a3)
lw $8, 0($9)
sw $8, -488($sp)
li $8, 1
sw $8, -492($sp)
lw $9, -488($sp)
lw $10, -492($sp)
sub $8, $9, $10
sw $8, -492($sp)
lw $8, -492($sp)
bnez $8, label16
lw $9, 24($a3)
lw $8, 0($9)
sw $8, -504($sp)
lw $9, -504($sp)
mul $8, $9, 424
sw $8, -508($sp)
lw $9, 60($a3)
lw $10, -508($sp)
add $8, $9, $10
sw $8, -500($sp)
lw $9, 28($a3)
lw $8, 0($9)
sw $8, -512($sp)
lw $9, -512($sp)
mul $8, $9, 4
sw $8, -516($sp)
lw $9, -500($sp)
lw $10, -516($sp)
add $8, $9, $10
sw $8, -500($sp)
add $8, $29, -556
sw $8, -520($sp)
lw $9, -500($sp)
lw $8, 0($9)
sw $8, -500($sp)
lw $8, -500($sp)
lw $9, -520($sp)
sw $8, 0($9)
lw $9, 804($a3)
move $8, $9
sw $8, -524($sp)
add $8, $29, -560
sw $8, -528($sp)
lw $8, -524($sp)
lw $9, -528($sp)
sw $8, 0($9)
add $29, $29, -560
jal __printf
sub $29, $29, -560
j label17
label16:
lw $9, 820($a3)
move $8, $9
sw $8, -536($sp)
add $8, $29, -556
sw $8, -540($sp)
lw $8, -536($sp)
lw $9, -540($sp)
sw $8, 0($9)
add $29, $29, -556
jal __printf_single
sub $29, $29, -556
label17:
li $8, 0
sw $8, -544($sp)
add $8, $29, 4
sw $8, -548($sp)
lw $8, -544($sp)
lw $9, -548($sp)
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
#global $10 48000
#global $11 48000
#global $12 4
#global $13 4
#global $14 4
#global $15 44944
#global $16 4
#global $17 4
#string $201 #%d\n
#string $205 #no solution!\n
#----------------------------
#func #check
#addi $18 $0 0
#addi $19 $0 4
####move $20 $18
#lw $20 $18 0
####move $21 $19
#lw $21 $19 0
#sub $21 $20 $21
#li $20 1
#bltz $21 l:0
#li $20 0
#label l:0
#beqz $20 l:1
####move $20 $18
#lw $20 $18 0
#li $22 0
#sub $22 $20 $22
#li $20 1
#bgez $22 l:2
#li $20 0
#label l:2
#label l:1
#andi $20 $20 1
#addi $23 $0 12
#sw $20 $23 0
#return
#return
#----------------------------
#func #addList
#addi $24 $0 0
#addi $25 $0 4
#sw $1 $0 -192
####move $27 $2
#addi $28 $0 -196
#lw $27 $2 0
#sw $27 $28 0
####move $29 $24
#addi $30 $0 -200
#lw $29 $24 0
#sw $29 $30 0
#addi $0 $0 -200
#call #check
#subi $0 $0 -200
#lw $1 $0 -192
#addi $31 $0 -188
####move $26 $31
#lw $26 $31 0
#li $32 1
#sub $32 $26 $32
#bnez $32 l:3
#sw $1 $0 -192
####move $34 $2
#addi $35 $0 -196
#lw $34 $2 0
#sw $34 $35 0
####move $36 $25
#addi $37 $0 -200
#lw $36 $25 0
#sw $36 $37 0
#addi $0 $0 -200
#call #check
#subi $0 $0 -200
#lw $1 $0 -192
#addi $38 $0 -188
####move $33 $38
#lw $33 $38 0
#li $39 1
#sub $39 $33 $39
#bnez $39 l:3
####move $40 $15
####move $41 $24
#lw $41 $24 0
#muli $42 $41 424
#add $40 $15 $42
####move $43 $25
#lw $43 $25 0
#muli $44 $43 4
#add $40 $40 $44
#lw $40 $40 0
#li $45 -1
#sub $45 $40 $45
#bnez $45 l:3
#move $46 $12
####move $47 $12
#lw $47 $12 0
#li $48 1
#add $47 $47 $48
#sw $47 $46 0
####move $49 $10
####move $50 $12
#lw $50 $12 0
#muli $51 $50 4
#add $49 $10 $51
####move $52 $24
#lw $52 $24 0
#sw $52 $49 0
####move $53 $11
####move $54 $12
#lw $54 $12 0
#muli $55 $54 4
#add $53 $11 $55
####move $56 $25
#lw $56 $25 0
#sw $56 $53 0
####move $57 $15
####move $58 $24
#lw $58 $24 0
#muli $59 $58 424
#add $57 $15 $59
####move $60 $25
#lw $60 $25 0
#muli $61 $60 4
#add $57 $57 $61
####move $62 $14
#lw $62 $14 0
#li $63 1
#add $62 $62 $63
#sw $62 $57 0
####move $64 $24
#lw $64 $24 0
####move $65 $6
#lw $65 $6 0
#sub $65 $64 $65
#li $64 1
#beqz $65 l:5
#li $64 0
#label l:5
#beqz $64 l:4
####move $66 $25
#lw $66 $25 0
####move $67 $7
#lw $67 $7 0
#sub $67 $66 $67
#li $66 1
#beqz $67 l:6
#li $66 0
#label l:6
#beqz $66 l:4
#move $68 $13
#li $69 1
#sw $69 $68 0
#label l:4
#label l:3
#return
#----------------------------
#func #main
#move $70 $2
#li $71 100
#addi $0 $0 -556
#call #getchar
#subi $0 $0 -556
#addi $73 $0 -552
####move $72 $73
#lw $72 $73 0
#li $74 48
#sub $72 $72 $74
#mul $71 $71 $72
#li $75 10
#addi $0 $0 -556
#call #getchar
#subi $0 $0 -556
#addi $77 $0 -552
####move $76 $77
#lw $76 $77 0
#li $78 48
#sub $76 $76 $78
#mul $75 $75 $76
#add $71 $71 $75
#addi $0 $0 -556
#call #getchar
#subi $0 $0 -556
#addi $80 $0 -552
####move $79 $80
#lw $79 $80 0
#add $71 $71 $79
#li $81 48
#sub $71 $71 $81
#sw $71 $70 0
#move $82 $6
#move $83 $7
####move $84 $2
#lw $84 $2 0
#li $85 1
#sub $84 $84 $85
#sw $84 $83 0
#lw $83 $83 0
#sw $83 $82 0
#move $86 $16
#li $87 0
#sw $87 $86 0
#label l:7
####move $88 $16
#lw $88 $16 0
####move $89 $2
#lw $89 $2 0
#sub $89 $88 $89
#bgez $89 l:8
#move $90 $17
#li $91 0
#sw $91 $90 0
#label l:10
####move $92 $17
#lw $92 $17 0
####move $93 $2
#lw $93 $2 0
#sub $93 $92 $93
#bgez $93 l:11
####move $94 $15
####move $95 $16
#lw $95 $16 0
#muli $96 $95 424
#add $94 $15 $96
####move $97 $17
#lw $97 $17 0
#muli $98 $97 4
#add $94 $94 $98
#li $99 -1
#sw $99 $94 0
#label l:12
####move $100 $17
#move $101 $17
#lw $100 $17 0
#addi $102 $100 1
#sw $102 $101 0
#goto l:10
#label l:11
#label l:9
####move $103 $16
#move $104 $16
#lw $103 $16 0
#addi $105 $103 1
#sw $105 $104 0
#goto l:7
#label l:8
#label l:13
####move $106 $3
#lw $106 $3 0
####move $107 $12
#lw $107 $12 0
#sub $107 $106 $107
#bgtz $107 l:14
#move $108 $8
####move $109 $10
####move $110 $3
#lw $110 $3 0
#muli $111 $110 4
#add $109 $10 $111
#lw $109 $109 0
#sw $109 $108 0
#move $112 $9
####move $113 $11
####move $114 $3
#lw $114 $3 0
#muli $115 $114 4
#add $113 $11 $115
#lw $113 $113 0
#sw $113 $112 0
#move $116 $14
####move $117 $15
####move $118 $8
#lw $118 $8 0
#muli $119 $118 424
#add $117 $15 $119
####move $120 $9
#lw $120 $9 0
#muli $121 $120 4
#add $117 $117 $121
#lw $117 $117 0
#sw $117 $116 0
####move $123 $9
#lw $123 $9 0
#li $124 2
#sub $123 $123 $124
#addi $125 $0 -560
#sw $123 $125 0
####move $126 $8
#lw $126 $8 0
#li $127 1
#sub $126 $126 $127
#addi $128 $0 -564
#sw $126 $128 0
#addi $0 $0 -564
#call #addList
#subi $0 $0 -564
#addi $129 $0 -552
#move $122 $129
####move $131 $9
#lw $131 $9 0
#li $132 2
#add $131 $131 $132
#addi $133 $0 -560
#sw $131 $133 0
####move $134 $8
#lw $134 $8 0
#li $135 1
#sub $134 $134 $135
#addi $136 $0 -564
#sw $134 $136 0
#addi $0 $0 -564
#call #addList
#subi $0 $0 -564
#addi $137 $0 -552
#move $130 $137
####move $139 $9
#lw $139 $9 0
#li $140 2
#sub $139 $139 $140
#addi $141 $0 -560
#sw $139 $141 0
####move $142 $8
#lw $142 $8 0
#li $143 1
#add $142 $142 $143
#addi $144 $0 -564
#sw $142 $144 0
#addi $0 $0 -564
#call #addList
#subi $0 $0 -564
#addi $145 $0 -552
#move $138 $145
####move $147 $9
#lw $147 $9 0
#li $148 2
#add $147 $147 $148
#addi $149 $0 -560
#sw $147 $149 0
####move $150 $8
#lw $150 $8 0
#li $151 1
#add $150 $150 $151
#addi $152 $0 -564
#sw $150 $152 0
#addi $0 $0 -564
#call #addList
#subi $0 $0 -564
#addi $153 $0 -552
#move $146 $153
####move $155 $9
#lw $155 $9 0
#li $156 1
#sub $155 $155 $156
#addi $157 $0 -560
#sw $155 $157 0
####move $158 $8
#lw $158 $8 0
#li $159 2
#sub $158 $158 $159
#addi $160 $0 -564
#sw $158 $160 0
#addi $0 $0 -564
#call #addList
#subi $0 $0 -564
#addi $161 $0 -552
#move $154 $161
####move $163 $9
#lw $163 $9 0
#li $164 1
#add $163 $163 $164
#addi $165 $0 -560
#sw $163 $165 0
####move $166 $8
#lw $166 $8 0
#li $167 2
#sub $166 $166 $167
#addi $168 $0 -564
#sw $166 $168 0
#addi $0 $0 -564
#call #addList
#subi $0 $0 -564
#addi $169 $0 -552
#move $162 $169
####move $171 $9
#lw $171 $9 0
#li $172 1
#sub $171 $171 $172
#addi $173 $0 -560
#sw $171 $173 0
####move $174 $8
#lw $174 $8 0
#li $175 2
#add $174 $174 $175
#addi $176 $0 -564
#sw $174 $176 0
#addi $0 $0 -564
#call #addList
#subi $0 $0 -564
#addi $177 $0 -552
#move $170 $177
####move $179 $9
#lw $179 $9 0
#li $180 1
#add $179 $179 $180
#addi $181 $0 -560
#sw $179 $181 0
####move $182 $8
#lw $182 $8 0
#li $183 2
#add $182 $182 $183
#addi $184 $0 -564
#sw $182 $184 0
#addi $0 $0 -564
#call #addList
#subi $0 $0 -564
#addi $185 $0 -552
#move $178 $185
####move $186 $13
#lw $186 $13 0
#li $187 1
#sub $187 $186 $187
#bnez $187 l:15
#goto l:14
#label l:15
#move $188 $3
####move $189 $3
#lw $189 $3 0
#li $190 1
#add $189 $189 $190
#sw $189 $188 0
#goto l:13
#label l:14
####move $191 $13
#lw $191 $13 0
#li $192 1
#sub $192 $191 $192
#bnez $192 l:16
####move $194 $15
####move $195 $6
#lw $195 $6 0
#muli $196 $195 424
#add $194 $15 $196
####move $197 $7
#lw $197 $7 0
#muli $198 $197 4
#add $194 $194 $198
#addi $199 $0 -556
#lw $194 $194 0
#sw $194 $199 0
#move $200 $201
#addi $202 $0 -560
#sw $200 $202 0
#addi $0 $0 -560
#call #printf
#subi $0 $0 -560
#goto l:17
#label l:16
#move $204 $205
#addi $206 $0 -556
#sw $204 $206 0
#addi $0 $0 -556
#call #printf_single
#subi $0 $0 -556
#label l:17
#li $207 0
#addi $208 $0 4
#sw $207 $208 0
#return
#return
