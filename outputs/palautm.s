.data
temp: .space 1020
var0: .space 500
var1: .space 500
var2: .space 4
var3: .space 4
var4: .space 4
var5: .space 4
var6: .space 4000
var7: .space 2000
var8: .space 2000
var9: .asciiz "%c"
.align 2
var10: .asciiz "\n"
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

__origin:
add $8, $29, -236
sw $8, -8($sp)
lw $9, -8($sp)
move $8, $9
sw $8, -4($sp)
add $8, $29, -240
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
label0:
lw $9, -4($sp)
lw $8, 0($9)
sw $8, -28($sp)
lw $9, 16($a3)
lw $8, 0($9)
sw $8, -32($sp)
lw $9, -28($sp)
lw $10, -32($sp)
sub $8, $9, $10
sw $8, -32($sp)
lw $8, -32($sp)
bgtz $8, label1
lw $9, -12($sp)
move $8, $9
sw $8, -36($sp)
li $8, 0
sw $8, -40($sp)
lw $8, -40($sp)
lw $9, -36($sp)
sw $8, 0($9)
label3:
lw $9, -12($sp)
lw $8, 0($9)
sw $8, -44($sp)
li $8, 1
sw $8, -48($sp)
lw $9, -44($sp)
lw $10, -48($sp)
sub $8, $9, $10
sw $8, -48($sp)
lw $8, -48($sp)
bgtz $8, label4
lw $9, -4($sp)
lw $8, 0($9)
sw $8, -56($sp)
lw $9, -56($sp)
mul $8, $9, 8
sw $8, -60($sp)
lw $9, 32($a3)
lw $10, -60($sp)
add $8, $9, $10
sw $8, -52($sp)
lw $9, -12($sp)
lw $8, 0($9)
sw $8, -64($sp)
lw $9, -64($sp)
mul $8, $9, 4
sw $8, -68($sp)
lw $9, -52($sp)
lw $10, -68($sp)
add $8, $9, $10
sw $8, -52($sp)
li $8, 0
sw $8, -72($sp)
lw $8, -72($sp)
lw $9, -52($sp)
sw $8, 0($9)
label5:
lw $9, -12($sp)
move $8, $9
sw $8, -80($sp)
lw $9, -12($sp)
lw $8, 0($9)
sw $8, -76($sp)
lw $9, -76($sp)
add $8, $9, 1
sw $8, -84($sp)
lw $8, -84($sp)
lw $9, -80($sp)
sw $8, 0($9)
j label3
label4:
lw $9, 16($a3)
lw $8, 0($9)
sw $8, -96($sp)
lw $9, -96($sp)
mul $8, $9, 4
sw $8, -100($sp)
lw $9, 40($a3)
lw $10, -100($sp)
add $8, $9, $10
sw $8, -92($sp)
li $8, -2
sw $8, -104($sp)
lw $8, -104($sp)
lw $9, -92($sp)
sw $8, 0($9)
lw $9, 16($a3)
lw $8, 0($9)
sw $8, -108($sp)
lw $9, -108($sp)
mul $8, $9, 4
sw $8, -112($sp)
lw $9, 36($a3)
lw $10, -112($sp)
add $8, $9, $10
sw $8, -88($sp)
li $8, 0
sw $8, -116($sp)
lw $8, -116($sp)
lw $9, -88($sp)
sw $8, 0($9)
label2:
lw $9, -4($sp)
move $8, $9
sw $8, -124($sp)
lw $9, -4($sp)
lw $8, 0($9)
sw $8, -120($sp)
lw $9, -120($sp)
add $8, $9, 1
sw $8, -128($sp)
lw $8, -128($sp)
lw $9, -124($sp)
sw $8, 0($9)
j label0
label1:
lw $9, 16($a3)
move $8, $9
sw $8, -132($sp)
li $8, 0
sw $8, -136($sp)
lw $8, -136($sp)
lw $9, -132($sp)
sw $8, 0($9)
lw $9, 20($a3)
move $8, $9
sw $8, -144($sp)
lw $9, 16($a3)
move $8, $9
sw $8, -152($sp)
lw $9, 16($a3)
lw $8, 0($9)
sw $8, -148($sp)
lw $9, -148($sp)
add $8, $9, 1
sw $8, -148($sp)
lw $8, -148($sp)
lw $9, -152($sp)
sw $8, 0($9)
lw $8, -148($sp)
lw $9, -144($sp)
sw $8, 0($9)
lw $9, 20($a3)
lw $8, 0($9)
sw $8, -160($sp)
lw $9, -160($sp)
mul $8, $9, 4
sw $8, -164($sp)
lw $9, 40($a3)
lw $10, -164($sp)
add $8, $9, $10
sw $8, -156($sp)
li $8, -1
sw $8, -168($sp)
lw $8, -168($sp)
lw $9, -156($sp)
sw $8, 0($9)
lw $9, 20($a3)
lw $8, 0($9)
sw $8, -172($sp)
lw $9, -172($sp)
mul $8, $9, 4
sw $8, -176($sp)
lw $9, 36($a3)
lw $10, -176($sp)
add $8, $9, $10
sw $8, -140($sp)
lw $9, 20($a3)
lw $8, 0($9)
sw $8, -180($sp)
lw $8, -180($sp)
lw $9, -140($sp)
sw $8, 0($9)
lw $9, 24($a3)
move $8, $9
sw $8, -188($sp)
lw $9, 16($a3)
move $8, $9
sw $8, -196($sp)
lw $9, 16($a3)
lw $8, 0($9)
sw $8, -192($sp)
lw $9, -192($sp)
add $8, $9, 1
sw $8, -192($sp)
lw $8, -192($sp)
lw $9, -196($sp)
sw $8, 0($9)
lw $8, -192($sp)
lw $9, -188($sp)
sw $8, 0($9)
lw $9, 24($a3)
lw $8, 0($9)
sw $8, -204($sp)
lw $9, -204($sp)
mul $8, $9, 4
sw $8, -208($sp)
lw $9, 40($a3)
lw $10, -208($sp)
add $8, $9, $10
sw $8, -200($sp)
li $8, 0
sw $8, -212($sp)
lw $8, -212($sp)
lw $9, -200($sp)
sw $8, 0($9)
lw $9, 24($a3)
lw $8, 0($9)
sw $8, -216($sp)
lw $9, -216($sp)
mul $8, $9, 4
sw $8, -220($sp)
lw $9, 36($a3)
lw $10, -220($sp)
add $8, $9, $10
sw $8, -184($sp)
lw $9, 20($a3)
lw $8, 0($9)
sw $8, -224($sp)
lw $8, -224($sp)
lw $9, -184($sp)
sw $8, 0($9)
lw $9, 28($a3)
move $8, $9
sw $8, -228($sp)
lw $9, 20($a3)
lw $8, 0($9)
sw $8, -232($sp)
lw $8, -232($sp)
lw $9, -228($sp)
sw $8, 0($9)
jr $ra
__palin:
add $8, $29, 0
sw $8, -4($sp)
add $8, $29, 4
sw $8, -8($sp)
add $8, $29, 8
sw $8, -12($sp)
lw $9, -8($sp)
lw $8, 0($9)
sw $8, -20($sp)
li $8, 1
sw $8, -28($sp)
lw $9, -20($sp)
lw $10, -28($sp)
sub $8, $9, $10
sw $8, -20($sp)
lw $9, -4($sp)
lw $8, 0($9)
sw $8, -36($sp)
lw $9, -36($sp)
mul $8, $9, 4
sw $8, -40($sp)
lw $9, 40($a3)
lw $10, -40($sp)
add $8, $9, $10
sw $8, -32($sp)
lw $9, -32($sp)
lw $8, 0($9)
sw $8, -32($sp)
lw $9, -20($sp)
lw $10, -32($sp)
sub $8, $9, $10
sw $8, -20($sp)
lw $9, -20($sp)
mul $8, $9, 1
sw $8, -24($sp)
lw $9, 8($a3)
lw $10, -24($sp)
add $8, $9, $10
sw $8, -16($sp)
lw $9, -16($sp)
lb $8, 0($9)
sw $8, -16($sp)
li $8, 97
sw $8, -44($sp)
lw $9, -16($sp)
lw $10, -44($sp)
sub $8, $9, $10
sw $8, -16($sp)
lw $9, -12($sp)
lw $8, 0($9)
sw $8, -48($sp)
lw $9, -16($sp)
lw $10, -48($sp)
sub $8, $9, $10
sw $8, -48($sp)
li $8, 1
sw $8, -16($sp)
lw $8, -48($sp)
beqz $8, label6
li $8, 0
sw $8, -16($sp)
label6:
add $8, $29, 16
sw $8, -52($sp)
lw $8, -16($sp)
lw $9, -52($sp)
sw $8, 0($9)
jr $ra
jr $ra
__add:
add $8, $29, 0
sw $8, -4($sp)
add $8, $29, 4
sw $8, -8($sp)
label7:
sw $31, -400($29)
add $8, $29, -404
sw $8, -20($sp)
lw $9, -4($sp)
lw $8, 0($9)
sw $8, -16($sp)
lw $8, -16($sp)
lw $9, -20($sp)
sw $8, 0($9)
add $8, $29, -408
sw $8, -28($sp)
lw $9, -8($sp)
lw $8, 0($9)
sw $8, -24($sp)
lw $8, -24($sp)
lw $9, -28($sp)
sw $8, 0($9)
add $8, $29, -412
sw $8, -36($sp)
lw $9, 28($a3)
lw $8, 0($9)
sw $8, -32($sp)
lw $8, -32($sp)
lw $9, -36($sp)
sw $8, 0($9)
add $29, $29, -412
jal __palin
sub $29, $29, -412
lw $31, -400($29)
add $8, $29, -396
sw $8, -40($sp)
lw $9, -40($sp)
lw $8, 0($9)
sw $8, -12($sp)
lw $9, -12($sp)
li $8, 1
beqz $9, lnot0
li $8, 0
lnot0:
sw $8, -12($sp)
lw $8, -12($sp)
beqz $8, label8
label9:
lw $9, 28($a3)
move $8, $9
sw $8, -44($sp)
lw $9, 28($a3)
lw $8, 0($9)
sw $8, -52($sp)
lw $9, -52($sp)
mul $8, $9, 4
sw $8, -56($sp)
lw $9, 36($a3)
lw $10, -56($sp)
add $8, $9, $10
sw $8, -48($sp)
lw $9, -48($sp)
lw $8, 0($9)
sw $8, -48($sp)
lw $8, -48($sp)
lw $9, -44($sp)
sw $8, 0($9)
j label7
label8:
lw $9, 28($a3)
lw $8, 0($9)
sw $8, -64($sp)
lw $9, -64($sp)
mul $8, $9, 8
sw $8, -68($sp)
lw $9, 32($a3)
lw $10, -68($sp)
add $8, $9, $10
sw $8, -60($sp)
lw $9, -4($sp)
lw $8, 0($9)
sw $8, -72($sp)
lw $9, -72($sp)
mul $8, $9, 4
sw $8, -76($sp)
lw $9, -60($sp)
lw $10, -76($sp)
add $8, $9, $10
sw $8, -60($sp)
lw $9, -60($sp)
lw $8, 0($9)
sw $8, -60($sp)
lw $8, -60($sp)
beqz $8, label10
lw $9, 28($a3)
move $8, $9
sw $8, -80($sp)
lw $9, 28($a3)
lw $8, 0($9)
sw $8, -88($sp)
lw $9, -88($sp)
mul $8, $9, 8
sw $8, -92($sp)
lw $9, 32($a3)
lw $10, -92($sp)
add $8, $9, $10
sw $8, -84($sp)
lw $9, -4($sp)
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
lw $8, -84($sp)
lw $9, -80($sp)
sw $8, 0($9)
j label11
label10:
add $8, $29, -396
sw $8, -108($sp)
lw $9, -108($sp)
move $8, $9
sw $8, -104($sp)
lw $9, 28($a3)
lw $8, 0($9)
sw $8, -112($sp)
lw $8, -112($sp)
lw $9, -104($sp)
sw $8, 0($9)
lw $9, 16($a3)
move $8, $9
sw $8, -120($sp)
lw $9, 16($a3)
lw $8, 0($9)
sw $8, -116($sp)
lw $9, -116($sp)
add $8, $9, 1
sw $8, -116($sp)
lw $8, -116($sp)
lw $9, -120($sp)
sw $8, 0($9)
lw $9, -104($sp)
lw $8, 0($9)
sw $8, -132($sp)
lw $9, -132($sp)
mul $8, $9, 8
sw $8, -136($sp)
lw $9, 32($a3)
lw $10, -136($sp)
add $8, $9, $10
sw $8, -128($sp)
lw $9, -4($sp)
lw $8, 0($9)
sw $8, -140($sp)
lw $9, -140($sp)
mul $8, $9, 4
sw $8, -144($sp)
lw $9, -128($sp)
lw $10, -144($sp)
add $8, $9, $10
sw $8, -128($sp)
lw $9, 16($a3)
lw $8, 0($9)
sw $8, -148($sp)
lw $8, -148($sp)
lw $9, -128($sp)
sw $8, 0($9)
lw $9, 16($a3)
lw $8, 0($9)
sw $8, -152($sp)
lw $9, -152($sp)
mul $8, $9, 4
sw $8, -156($sp)
lw $9, 40($a3)
lw $10, -156($sp)
add $8, $9, $10
sw $8, -124($sp)
lw $9, -104($sp)
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
li $8, 2
sw $8, -172($sp)
lw $9, -160($sp)
lw $10, -172($sp)
add $8, $9, $10
sw $8, -160($sp)
lw $8, -160($sp)
lw $9, -124($sp)
sw $8, 0($9)
lw $9, -104($sp)
lw $8, 0($9)
sw $8, -176($sp)
lw $9, 20($a3)
lw $8, 0($9)
sw $8, -180($sp)
lw $9, -176($sp)
lw $10, -180($sp)
sub $8, $9, $10
sw $8, -180($sp)
lw $8, -180($sp)
bnez $8, label12
lw $9, 16($a3)
lw $8, 0($9)
sw $8, -188($sp)
lw $9, -188($sp)
mul $8, $9, 4
sw $8, -192($sp)
lw $9, 36($a3)
lw $10, -192($sp)
add $8, $9, $10
sw $8, -184($sp)
lw $9, 24($a3)
lw $8, 0($9)
sw $8, -196($sp)
lw $8, -196($sp)
lw $9, -184($sp)
sw $8, 0($9)
j label13
label12:
lw $9, -104($sp)
move $8, $9
sw $8, -200($sp)
lw $9, -104($sp)
lw $8, 0($9)
sw $8, -208($sp)
lw $9, -208($sp)
mul $8, $9, 4
sw $8, -212($sp)
lw $9, 36($a3)
lw $10, -212($sp)
add $8, $9, $10
sw $8, -204($sp)
lw $9, -204($sp)
lw $8, 0($9)
sw $8, -204($sp)
lw $8, -204($sp)
lw $9, -200($sp)
sw $8, 0($9)
label14:
lw $9, -104($sp)
lw $8, 0($9)
sw $8, -216($sp)
lw $9, 20($a3)
lw $8, 0($9)
sw $8, -220($sp)
lw $9, -216($sp)
lw $10, -220($sp)
sub $8, $9, $10
sw $8, -220($sp)
lw $8, -220($sp)
beqz $8, label15
lw $9, -104($sp)
lw $8, 0($9)
sw $8, -228($sp)
lw $9, -228($sp)
mul $8, $9, 8
sw $8, -232($sp)
lw $9, 32($a3)
lw $10, -232($sp)
add $8, $9, $10
sw $8, -224($sp)
lw $9, -4($sp)
lw $8, 0($9)
sw $8, -236($sp)
lw $9, -236($sp)
mul $8, $9, 4
sw $8, -240($sp)
lw $9, -224($sp)
lw $10, -240($sp)
add $8, $9, $10
sw $8, -224($sp)
lw $9, -224($sp)
lw $8, 0($9)
sw $8, -224($sp)
lw $9, -224($sp)
li $8, 1
beqz $9, lnot1
li $8, 0
lnot1:
sw $8, -224($sp)
lw $8, -224($sp)
bnez $8, label17
sw $31, -404($29)
add $8, $29, -408
sw $8, -248($sp)
lw $9, -4($sp)
lw $8, 0($9)
sw $8, -244($sp)
lw $8, -244($sp)
lw $9, -248($sp)
sw $8, 0($9)
add $8, $29, -412
sw $8, -256($sp)
lw $9, -8($sp)
lw $8, 0($9)
sw $8, -252($sp)
lw $8, -252($sp)
lw $9, -256($sp)
sw $8, 0($9)
add $8, $29, -416
sw $8, -264($sp)
lw $9, -104($sp)
lw $8, 0($9)
sw $8, -260($sp)
lw $8, -260($sp)
lw $9, -264($sp)
sw $8, 0($9)
add $29, $29, -416
jal __palin
sub $29, $29, -416
lw $31, -404($29)
add $8, $29, -400
sw $8, -268($sp)
lw $9, -268($sp)
lw $8, 0($9)
sw $8, -224($sp)
lw $9, -224($sp)
li $8, 1
beqz $9, lnot2
li $8, 0
lnot2:
sw $8, -224($sp)
label17:
lw $9, -224($sp)
andi $8, $9, 1
sw $8, -224($sp)
lw $8, -224($sp)
beqz $8, label15
label16:
lw $9, -104($sp)
move $8, $9
sw $8, -272($sp)
lw $9, -104($sp)
lw $8, 0($9)
sw $8, -280($sp)
lw $9, -280($sp)
mul $8, $9, 4
sw $8, -284($sp)
lw $9, 36($a3)
lw $10, -284($sp)
add $8, $9, $10
sw $8, -276($sp)
lw $9, -276($sp)
lw $8, 0($9)
sw $8, -276($sp)
lw $8, -276($sp)
lw $9, -272($sp)
sw $8, 0($9)
j label14
label15:
lw $9, -104($sp)
lw $8, 0($9)
sw $8, -292($sp)
lw $9, -292($sp)
mul $8, $9, 8
sw $8, -296($sp)
lw $9, 32($a3)
lw $10, -296($sp)
add $8, $9, $10
sw $8, -288($sp)
lw $9, -4($sp)
lw $8, 0($9)
sw $8, -300($sp)
lw $9, -300($sp)
mul $8, $9, 4
sw $8, -304($sp)
lw $9, -288($sp)
lw $10, -304($sp)
add $8, $9, $10
sw $8, -288($sp)
lw $9, -288($sp)
lw $8, 0($9)
sw $8, -288($sp)
lw $8, -288($sp)
beqz $8, label18
sw $31, -404($29)
add $8, $29, -408
sw $8, -316($sp)
lw $9, -4($sp)
lw $8, 0($9)
sw $8, -312($sp)
lw $8, -312($sp)
lw $9, -316($sp)
sw $8, 0($9)
add $8, $29, -412
sw $8, -324($sp)
lw $9, -8($sp)
lw $8, 0($9)
sw $8, -320($sp)
lw $8, -320($sp)
lw $9, -324($sp)
sw $8, 0($9)
add $8, $29, -416
sw $8, -332($sp)
lw $9, -104($sp)
lw $8, 0($9)
sw $8, -328($sp)
lw $8, -328($sp)
lw $9, -332($sp)
sw $8, 0($9)
add $29, $29, -416
jal __palin
sub $29, $29, -416
lw $31, -404($29)
add $8, $29, -400
sw $8, -336($sp)
lw $9, -336($sp)
lw $8, 0($9)
sw $8, -308($sp)
lw $8, -308($sp)
beqz $8, label18
lw $9, 16($a3)
lw $8, 0($9)
sw $8, -344($sp)
lw $9, -344($sp)
mul $8, $9, 4
sw $8, -348($sp)
lw $9, 36($a3)
lw $10, -348($sp)
add $8, $9, $10
sw $8, -340($sp)
lw $9, -104($sp)
lw $8, 0($9)
sw $8, -356($sp)
lw $9, -356($sp)
mul $8, $9, 8
sw $8, -360($sp)
lw $9, 32($a3)
lw $10, -360($sp)
add $8, $9, $10
sw $8, -352($sp)
lw $9, -4($sp)
lw $8, 0($9)
sw $8, -364($sp)
lw $9, -364($sp)
mul $8, $9, 4
sw $8, -368($sp)
lw $9, -352($sp)
lw $10, -368($sp)
add $8, $9, $10
sw $8, -352($sp)
lw $9, -352($sp)
lw $8, 0($9)
sw $8, -352($sp)
lw $8, -352($sp)
lw $9, -340($sp)
sw $8, 0($9)
j label19
label18:
lw $9, 16($a3)
lw $8, 0($9)
sw $8, -376($sp)
lw $9, -376($sp)
mul $8, $9, 4
sw $8, -380($sp)
lw $9, 36($a3)
lw $10, -380($sp)
add $8, $9, $10
sw $8, -372($sp)
lw $9, 20($a3)
lw $8, 0($9)
sw $8, -384($sp)
lw $8, -384($sp)
lw $9, -372($sp)
sw $8, 0($9)
label19:
label13:
lw $9, 28($a3)
move $8, $9
sw $8, -388($sp)
lw $9, 16($a3)
lw $8, 0($9)
sw $8, -392($sp)
lw $8, -392($sp)
lw $9, -388($sp)
sw $8, 0($9)
label11:
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
sw $t0, 936($a3)
la $t0, var10
sw $t0, 1004($a3)
add $8, $29, -296
sw $8, -8($sp)
lw $9, -8($sp)
move $8, $9
sw $8, -4($sp)
add $8, $29, -300
sw $8, -16($sp)
lw $9, -16($sp)
move $8, $9
sw $8, -12($sp)
li $8, 1
sw $8, -20($sp)
lw $8, -20($sp)
lw $9, -12($sp)
sw $8, 0($9)
lw $9, -12($sp)
lw $8, 0($9)
sw $8, -28($sp)
lw $9, -28($sp)
mul $8, $9, 1
sw $8, -32($sp)
lw $9, 8($a3)
lw $10, -32($sp)
add $8, $9, $10
sw $8, -24($sp)
add $29, $29, -308
jal __getchar
sub $29, $29, -308
add $8, $29, -304
sw $8, -40($sp)
lw $9, -40($sp)
lb $8, 0($9)
sw $8, -36($sp)
lw $8, -36($sp)
lw $9, -24($sp)
sb $8, 0($9)
label20:
lw $9, -12($sp)
lw $8, 0($9)
sw $8, -48($sp)
lw $9, -48($sp)
mul $8, $9, 1
sw $8, -52($sp)
lw $9, 8($a3)
lw $10, -52($sp)
add $8, $9, $10
sw $8, -44($sp)
lw $9, -44($sp)
lb $8, 0($9)
sw $8, -44($sp)
li $8, 97
sw $8, -56($sp)
lw $9, -44($sp)
lw $10, -56($sp)
sub $8, $9, $10
sw $8, -56($sp)
lw $8, -56($sp)
beqz $8, label22
lw $9, -12($sp)
lw $8, 0($9)
sw $8, -64($sp)
lw $9, -64($sp)
mul $8, $9, 1
sw $8, -68($sp)
lw $9, 8($a3)
lw $10, -68($sp)
add $8, $9, $10
sw $8, -60($sp)
lw $9, -60($sp)
lb $8, 0($9)
sw $8, -60($sp)
li $8, 98
sw $8, -72($sp)
lw $9, -60($sp)
lw $10, -72($sp)
sub $8, $9, $10
sw $8, -72($sp)
lw $8, -72($sp)
bnez $8, label21
label22:
lw $9, -12($sp)
move $8, $9
sw $8, -80($sp)
lw $9, -12($sp)
lw $8, 0($9)
sw $8, -76($sp)
lw $9, -76($sp)
add $8, $9, 1
sw $8, -76($sp)
lw $8, -76($sp)
lw $9, -80($sp)
sw $8, 0($9)
lw $9, -12($sp)
lw $8, 0($9)
sw $8, -88($sp)
lw $9, -88($sp)
mul $8, $9, 1
sw $8, -92($sp)
lw $9, 8($a3)
lw $10, -92($sp)
add $8, $9, $10
sw $8, -84($sp)
add $29, $29, -308
jal __getchar
sub $29, $29, -308
add $8, $29, -304
sw $8, -100($sp)
lw $9, -100($sp)
lb $8, 0($9)
sw $8, -96($sp)
lw $8, -96($sp)
lw $9, -84($sp)
sb $8, 0($9)
j label20
label21:
lw $9, -12($sp)
lw $8, 0($9)
sw $8, -108($sp)
lw $9, -108($sp)
mul $8, $9, 1
sw $8, -112($sp)
lw $9, 8($a3)
lw $10, -112($sp)
add $8, $9, $10
sw $8, -104($sp)
li $8, 0
sw $8, -116($sp)
lw $8, -116($sp)
lw $9, -104($sp)
sb $8, 0($9)
add $29, $29, -304
jal __origin
sub $29, $29, -304
lw $9, -12($sp)
move $8, $9
sw $8, -128($sp)
lw $9, -12($sp)
lw $8, 0($9)
sw $8, -124($sp)
lw $9, -124($sp)
sub $8, $9, 1
sw $8, -132($sp)
lw $8, -132($sp)
lw $9, -128($sp)
sw $8, 0($9)
lw $9, -4($sp)
move $8, $9
sw $8, -136($sp)
li $8, 1
sw $8, -140($sp)
lw $8, -140($sp)
lw $9, -136($sp)
sw $8, 0($9)
label23:
lw $9, -4($sp)
lw $8, 0($9)
sw $8, -144($sp)
lw $9, -12($sp)
lw $8, 0($9)
sw $8, -148($sp)
lw $9, -144($sp)
lw $10, -148($sp)
sub $8, $9, $10
sw $8, -148($sp)
lw $8, -148($sp)
bgtz $8, label24
add $8, $29, -304
sw $8, -156($sp)
lw $9, -156($sp)
move $8, $9
sw $8, -152($sp)
lw $9, 16($a3)
lw $8, 0($9)
sw $8, -160($sp)
lw $8, -160($sp)
lw $9, -152($sp)
sw $8, 0($9)
add $8, $29, -312
sw $8, -172($sp)
lw $9, -4($sp)
lw $8, 0($9)
sw $8, -168($sp)
lw $8, -168($sp)
lw $9, -172($sp)
sw $8, 0($9)
lw $9, -4($sp)
lw $8, 0($9)
sw $8, -180($sp)
lw $9, -180($sp)
mul $8, $9, 1
sw $8, -184($sp)
lw $9, 8($a3)
lw $10, -184($sp)
add $8, $9, $10
sw $8, -176($sp)
lw $9, -176($sp)
lb $8, 0($9)
sw $8, -176($sp)
li $8, 97
sw $8, -188($sp)
lw $9, -176($sp)
lw $10, -188($sp)
sub $8, $9, $10
sw $8, -176($sp)
add $8, $29, -316
sw $8, -192($sp)
lw $8, -176($sp)
lw $9, -192($sp)
sw $8, 0($9)
add $29, $29, -316
jal __add
sub $29, $29, -316
lw $9, -152($sp)
lw $8, 0($9)
sw $8, -196($sp)
lw $9, 16($a3)
lw $8, 0($9)
sw $8, -200($sp)
lw $9, -196($sp)
lw $10, -200($sp)
sub $8, $9, $10
sw $8, -200($sp)
lw $8, -200($sp)
beqz $8, label26
li $8, 49
sw $8, -208($sp)
add $8, $29, -312
sw $8, -212($sp)
lw $8, -208($sp)
lw $9, -212($sp)
sw $8, 0($9)
lw $9, 936($a3)
move $8, $9
sw $8, -216($sp)
add $8, $29, -316
sw $8, -220($sp)
lw $8, -216($sp)
lw $9, -220($sp)
sw $8, 0($9)
add $29, $29, -316
jal __printf
sub $29, $29, -316
j label27
label26:
li $8, 48
sw $8, -228($sp)
add $8, $29, -312
sw $8, -232($sp)
lw $8, -228($sp)
lw $9, -232($sp)
sw $8, 0($9)
lw $9, 936($a3)
move $8, $9
sw $8, -236($sp)
add $8, $29, -316
sw $8, -240($sp)
lw $8, -236($sp)
lw $9, -240($sp)
sw $8, 0($9)
add $29, $29, -316
jal __printf
sub $29, $29, -316
label27:
label25:
lw $9, -4($sp)
move $8, $9
sw $8, -248($sp)
lw $9, -4($sp)
lw $8, 0($9)
sw $8, -244($sp)
lw $9, -244($sp)
add $8, $9, 1
sw $8, -252($sp)
lw $8, -252($sp)
lw $9, -248($sp)
sw $8, 0($9)
j label23
label24:
lw $9, -12($sp)
lw $8, 0($9)
sw $8, -260($sp)
li $8, 1
sw $8, -268($sp)
lw $9, -260($sp)
lw $10, -268($sp)
add $8, $9, $10
sw $8, -260($sp)
lw $9, -260($sp)
mul $8, $9, 1
sw $8, -264($sp)
lw $9, 12($a3)
lw $10, -264($sp)
add $8, $9, $10
sw $8, -256($sp)
li $8, 0
sw $8, -272($sp)
lw $8, -272($sp)
lw $9, -256($sp)
sb $8, 0($9)
lw $9, 1004($a3)
move $8, $9
sw $8, -280($sp)
add $8, $29, -308
sw $8, -284($sp)
lw $8, -280($sp)
lw $9, -284($sp)
sw $8, 0($9)
add $29, $29, -308
jal __printf_single
sub $29, $29, -308
li $8, 0
sw $8, -288($sp)
add $8, $29, 4
sw $8, -292($sp)
lw $8, -288($sp)
lw $9, -292($sp)
sw $8, 0($9)
j __main_end
j __main_end
__main_end:
li $v0, 10
syscall
#global $2 500
#global $3 500
#global $4 4
#global $5 4
#global $6 4
#global $7 4
#global $8 4000
#global $9 2000
#global $10 2000
#string $234 #%c
#string $251 #\n
#----------------------------
#func #origin
#addi $12 $0 -236
#move $11 $12
#addi $14 $0 -240
#move $13 $14
#move $15 $12
#li $16 0
#sw $16 $15 0
#label l:0
####move $17 $11
#lw $17 $11 0
####move $18 $4
#lw $18 $4 0
#sub $18 $17 $18
#bgtz $18 l:1
#move $19 $13
#li $20 0
#sw $20 $19 0
#label l:3
####move $21 $13
#lw $21 $13 0
#li $22 1
#sub $22 $21 $22
#bgtz $22 l:4
####move $23 $8
####move $24 $11
#lw $24 $11 0
#muli $25 $24 8
#add $23 $8 $25
####move $26 $13
#lw $26 $13 0
#muli $27 $26 4
#add $23 $23 $27
#li $28 0
#sw $28 $23 0
#label l:5
####move $29 $13
#move $30 $13
#lw $29 $13 0
#addi $31 $29 1
#sw $31 $30 0
#goto l:3
#label l:4
####move $33 $10
####move $34 $4
#lw $34 $4 0
#muli $35 $34 4
#add $33 $10 $35
#li $36 -2
#sw $36 $33 0
####move $32 $9
####move $37 $4
#lw $37 $4 0
#muli $38 $37 4
#add $32 $9 $38
#li $39 0
#sw $39 $32 0
#label l:2
####move $40 $11
#move $41 $11
#lw $40 $11 0
#addi $42 $40 1
#sw $42 $41 0
#goto l:0
#label l:1
#move $43 $4
#li $44 0
#sw $44 $43 0
#move $46 $5
####move $47 $4
#move $48 $4
#lw $47 $4 0
#addi $47 $47 1
#sw $47 $48 0
#sw $47 $46 0
####move $49 $10
####move $50 $5
#lw $50 $5 0
#muli $51 $50 4
#add $49 $10 $51
#li $52 -1
#sw $52 $49 0
####move $45 $9
####move $53 $5
#lw $53 $5 0
#muli $54 $53 4
#add $45 $9 $54
####move $55 $5
#lw $55 $5 0
#sw $55 $45 0
#move $57 $6
####move $58 $4
#move $59 $4
#lw $58 $4 0
#addi $58 $58 1
#sw $58 $59 0
#sw $58 $57 0
####move $60 $10
####move $61 $6
#lw $61 $6 0
#muli $62 $61 4
#add $60 $10 $62
#li $63 0
#sw $63 $60 0
####move $56 $9
####move $64 $6
#lw $64 $6 0
#muli $65 $64 4
#add $56 $9 $65
####move $66 $5
#lw $66 $5 0
#sw $66 $56 0
#move $67 $7
####move $68 $5
#lw $68 $5 0
#sw $68 $67 0
#return
#----------------------------
#func #palin
#addi $69 $0 0
#addi $70 $0 4
#addi $71 $0 8
####move $72 $2
####move $73 $70
#lw $73 $70 0
#li $75 1
#sub $73 $73 $75
####move $76 $10
####move $77 $69
#lw $77 $69 0
#muli $78 $77 4
#add $76 $10 $78
#lw $76 $76 0
#sub $73 $73 $76
#muli $74 $73 1
#add $72 $2 $74
#lb $72 $72 0
#li $79 97
#sub $72 $72 $79
####move $80 $71
#lw $80 $71 0
#sub $80 $72 $80
#li $72 1
#beqz $80 l:6
#li $72 0
#label l:6
#addi $81 $0 16
#sw $72 $81 0
#return
#return
#----------------------------
#func #add
#addi $82 $0 0
#addi $83 $0 4
#label l:7
#sw $1 $0 -400
####move $85 $82
#addi $86 $0 -404
#lw $85 $82 0
#sw $85 $86 0
####move $87 $83
#addi $88 $0 -408
#lw $87 $83 0
#sw $87 $88 0
####move $89 $7
#addi $90 $0 -412
#lw $89 $7 0
#sw $89 $90 0
#addi $0 $0 -412
#call #palin
#subi $0 $0 -412
#lw $1 $0 -400
#addi $91 $0 -396
####move $84 $91
#lw $84 $91 0
#lnot $84 $84
#beqz $84 l:8
#label l:9
#move $92 $7
####move $93 $9
####move $94 $7
#lw $94 $7 0
#muli $95 $94 4
#add $93 $9 $95
#lw $93 $93 0
#sw $93 $92 0
#goto l:7
#label l:8
####move $96 $8
####move $97 $7
#lw $97 $7 0
#muli $98 $97 8
#add $96 $8 $98
####move $99 $82
#lw $99 $82 0
#muli $100 $99 4
#add $96 $96 $100
#lw $96 $96 0
#beqz $96 l:10
#move $101 $7
####move $102 $8
####move $103 $7
#lw $103 $7 0
#muli $104 $103 8
#add $102 $8 $104
####move $105 $82
#lw $105 $82 0
#muli $106 $105 4
#add $102 $102 $106
#lw $102 $102 0
#sw $102 $101 0
#goto l:11
#label l:10
#addi $108 $0 -396
#move $107 $108
####move $109 $7
#lw $109 $7 0
#sw $109 $107 0
####move $110 $4
#move $111 $4
#lw $110 $4 0
#addi $110 $110 1
#sw $110 $111 0
####move $113 $8
####move $114 $107
#lw $114 $107 0
#muli $115 $114 8
#add $113 $8 $115
####move $116 $82
#lw $116 $82 0
#muli $117 $116 4
#add $113 $113 $117
####move $118 $4
#lw $118 $4 0
#sw $118 $113 0
####move $112 $10
####move $119 $4
#lw $119 $4 0
#muli $120 $119 4
#add $112 $10 $120
####move $121 $10
####move $122 $107
#lw $122 $107 0
#muli $123 $122 4
#add $121 $10 $123
#lw $121 $121 0
#li $124 2
#add $121 $121 $124
#sw $121 $112 0
####move $125 $107
#lw $125 $107 0
####move $126 $5
#lw $126 $5 0
#sub $126 $125 $126
#bnez $126 l:12
####move $127 $9
####move $128 $4
#lw $128 $4 0
#muli $129 $128 4
#add $127 $9 $129
####move $130 $6
#lw $130 $6 0
#sw $130 $127 0
#goto l:13
#label l:12
#move $131 $107
####move $132 $9
####move $133 $107
#lw $133 $107 0
#muli $134 $133 4
#add $132 $9 $134
#lw $132 $132 0
#sw $132 $131 0
#label l:14
####move $135 $107
#lw $135 $107 0
####move $136 $5
#lw $136 $5 0
#sub $136 $135 $136
#beqz $136 l:15
####move $137 $8
####move $138 $107
#lw $138 $107 0
#muli $139 $138 8
#add $137 $8 $139
####move $140 $82
#lw $140 $82 0
#muli $141 $140 4
#add $137 $137 $141
#lw $137 $137 0
#lnot $137 $137
#bnez $137 l:17
#sw $1 $0 -404
####move $142 $82
#addi $143 $0 -408
#lw $142 $82 0
#sw $142 $143 0
####move $144 $83
#addi $145 $0 -412
#lw $144 $83 0
#sw $144 $145 0
####move $146 $107
#addi $147 $0 -416
#lw $146 $107 0
#sw $146 $147 0
#addi $0 $0 -416
#call #palin
#subi $0 $0 -416
#lw $1 $0 -404
#addi $148 $0 -400
####move $137 $148
#lw $137 $148 0
#lnot $137 $137
#label l:17
#andi $137 $137 1
#beqz $137 l:15
#label l:16
#move $149 $107
####move $150 $9
####move $151 $107
#lw $151 $107 0
#muli $152 $151 4
#add $150 $9 $152
#lw $150 $150 0
#sw $150 $149 0
#goto l:14
#label l:15
####move $153 $8
####move $154 $107
#lw $154 $107 0
#muli $155 $154 8
#add $153 $8 $155
####move $156 $82
#lw $156 $82 0
#muli $157 $156 4
#add $153 $153 $157
#lw $153 $153 0
#beqz $153 l:18
#sw $1 $0 -404
####move $159 $82
#addi $160 $0 -408
#lw $159 $82 0
#sw $159 $160 0
####move $161 $83
#addi $162 $0 -412
#lw $161 $83 0
#sw $161 $162 0
####move $163 $107
#addi $164 $0 -416
#lw $163 $107 0
#sw $163 $164 0
#addi $0 $0 -416
#call #palin
#subi $0 $0 -416
#lw $1 $0 -404
#addi $165 $0 -400
####move $158 $165
#lw $158 $165 0
#beqz $158 l:18
####move $166 $9
####move $167 $4
#lw $167 $4 0
#muli $168 $167 4
#add $166 $9 $168
####move $169 $8
####move $170 $107
#lw $170 $107 0
#muli $171 $170 8
#add $169 $8 $171
####move $172 $82
#lw $172 $82 0
#muli $173 $172 4
#add $169 $169 $173
#lw $169 $169 0
#sw $169 $166 0
#goto l:19
#label l:18
####move $174 $9
####move $175 $4
#lw $175 $4 0
#muli $176 $175 4
#add $174 $9 $176
####move $177 $5
#lw $177 $5 0
#sw $177 $174 0
#label l:19
#label l:13
#move $178 $7
####move $179 $4
#lw $179 $4 0
#sw $179 $178 0
#label l:11
#return
#----------------------------
#func #main
#addi $181 $0 -296
#move $180 $181
#addi $183 $0 -300
#move $182 $183
#li $184 1
#sw $184 $182 0
####move $185 $2
####move $186 $182
#lw $186 $182 0
#muli $187 $186 1
#add $185 $2 $187
#addi $0 $0 -308
#call #getchar
#subi $0 $0 -308
#addi $189 $0 -304
####move $188 $189
#lb $188 $189 0
#sb $188 $185 0
#label l:20
####move $190 $2
####move $191 $182
#lw $191 $182 0
#muli $192 $191 1
#add $190 $2 $192
#lb $190 $190 0
#li $193 97
#sub $193 $190 $193
#beqz $193 l:22
####move $194 $2
####move $195 $182
#lw $195 $182 0
#muli $196 $195 1
#add $194 $2 $196
#lb $194 $194 0
#li $197 98
#sub $197 $194 $197
#bnez $197 l:21
#label l:22
####move $198 $182
#move $199 $182
#lw $198 $182 0
#addi $198 $198 1
#sw $198 $199 0
####move $200 $2
####move $201 $182
#lw $201 $182 0
#muli $202 $201 1
#add $200 $2 $202
#addi $0 $0 -308
#call #getchar
#subi $0 $0 -308
#addi $204 $0 -304
####move $203 $204
#lb $203 $204 0
#sb $203 $200 0
#goto l:20
#label l:21
####move $205 $2
####move $206 $182
#lw $206 $182 0
#muli $207 $206 1
#add $205 $2 $207
#li $208 0
#sb $208 $205 0
#addi $0 $0 -304
#call #origin
#subi $0 $0 -304
####move $210 $182
#move $211 $182
#lw $210 $182 0
#subi $212 $210 1
#sw $212 $211 0
#move $213 $180
#li $214 1
#sw $214 $213 0
#label l:23
####move $215 $180
#lw $215 $180 0
####move $216 $182
#lw $216 $182 0
#sub $216 $215 $216
#bgtz $216 l:24
#addi $218 $0 -304
#move $217 $218
####move $219 $4
#lw $219 $4 0
#sw $219 $217 0
####move $221 $180
#addi $222 $0 -312
#lw $221 $180 0
#sw $221 $222 0
####move $223 $2
####move $224 $180
#lw $224 $180 0
#muli $225 $224 1
#add $223 $2 $225
#lb $223 $223 0
#li $226 97
#sub $223 $223 $226
#addi $227 $0 -316
#sw $223 $227 0
#addi $0 $0 -316
#call #add
#subi $0 $0 -316
####move $228 $217
#lw $228 $217 0
####move $229 $4
#lw $229 $4 0
#sub $229 $228 $229
#beqz $229 l:26
#li $231 49
#addi $232 $0 -312
#sw $231 $232 0
#move $233 $234
#addi $235 $0 -316
#sw $233 $235 0
#addi $0 $0 -316
#call #printf
#subi $0 $0 -316
#goto l:27
#label l:26
#li $237 48
#addi $238 $0 -312
#sw $237 $238 0
#move $239 $234
#addi $240 $0 -316
#sw $239 $240 0
#addi $0 $0 -316
#call #printf
#subi $0 $0 -316
#label l:27
#label l:25
####move $241 $180
#move $242 $180
#lw $241 $180 0
#addi $243 $241 1
#sw $243 $242 0
#goto l:23
#label l:24
####move $244 $3
####move $245 $182
#lw $245 $182 0
#li $247 1
#add $245 $245 $247
#muli $246 $245 1
#add $244 $3 $246
#li $248 0
#sb $248 $244 0
#move $250 $251
#addi $252 $0 -308
#sw $250 $252 0
#addi $0 $0 -308
#call #printf_single
#subi $0 $0 -308
#li $253 0
#addi $254 $0 4
#sw $253 $254 0
#return
#return
