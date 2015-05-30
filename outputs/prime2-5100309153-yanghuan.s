.data
temp: .space 1416
var0: .space 4
var1: .space 4
var2: .space 4
var3: .space 4
var4: .space 4
var5: .space 4
var6: .space 4004
var7: .space 680
var8: .space 4004
var9: .space 4
var10: .space 115600
var11: .asciiz "%s"
.align 2
var12: .asciiz "%d"
.align 2
var13: .asciiz " "
.align 2
var14: .asciiz "\n"
.align 2
var15: .asciiz "Total: %d\n"
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

__xprint:
add $8, $29, 0
sw $8, -4($sp)
j label0
sw $31, -28($29)
add $8, $29, -32
sw $8, -16($sp)
lw $9, -4($sp)
lw $8, 0($9)
sw $8, -12($sp)
lw $8, -12($sp)
lw $9, -16($sp)
sw $8, 0($9)
lw $9, 72($a3)
move $8, $9
sw $8, -20($sp)
add $8, $29, -36
sw $8, -24($sp)
lw $8, -20($sp)
lw $9, -24($sp)
sw $8, 0($9)
add $29, $29, -36
jal __printf
sub $29, $29, -36
lw $31, -28($29)
label0:
jr $ra
__xprinti:
add $8, $29, 0
sw $8, -4($sp)
j label1
sw $31, -28($29)
add $8, $29, -32
sw $8, -16($sp)
lw $9, -4($sp)
lw $8, 0($9)
sw $8, -12($sp)
lw $8, -12($sp)
lw $9, -16($sp)
sw $8, 0($9)
lw $9, 100($a3)
move $8, $9
sw $8, -20($sp)
add $8, $29, -36
sw $8, -24($sp)
lw $8, -20($sp)
lw $9, -24($sp)
sw $8, 0($9)
add $29, $29, -36
jal __printf
sub $29, $29, -36
lw $31, -28($29)
label1:
jr $ra
__getPrime:
add $8, $29, 0
sw $8, -4($sp)
add $8, $29, 4
sw $8, -8($sp)
add $8, $29, 8
sw $8, -12($sp)
add $8, $29, 12
sw $8, -16($sp)
add $8, $29, 16
sw $8, -20($sp)
add $8, $29, -220
sw $8, -28($sp)
lw $9, -28($sp)
move $8, $9
sw $8, -24($sp)
add $8, $29, -224
sw $8, -36($sp)
lw $9, -36($sp)
move $8, $9
sw $8, -32($sp)
lw $9, -28($sp)
move $8, $9
sw $8, -40($sp)
li $8, 2
sw $8, -44($sp)
lw $8, -44($sp)
lw $9, -40($sp)
sw $8, 0($9)
lw $9, -36($sp)
move $8, $9
sw $8, -48($sp)
li $8, 2
sw $8, -52($sp)
lw $8, -52($sp)
lw $9, -48($sp)
sw $8, 0($9)
label2:
lw $9, -32($sp)
lw $8, 0($9)
sw $8, -56($sp)
lw $9, -4($sp)
lw $8, 0($9)
sw $8, -60($sp)
lw $9, -56($sp)
lw $10, -60($sp)
sub $8, $9, $10
sw $8, -60($sp)
lw $8, -60($sp)
bgtz $8, label3
lw $9, -12($sp)
lw $8, 0($9)
sw $8, -64($sp)
lw $9, -32($sp)
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
li $8, 1
sw $8, -76($sp)
lw $9, -64($sp)
lw $10, -76($sp)
sub $8, $9, $10
sw $8, -76($sp)
lw $8, -76($sp)
bnez $8, label5
lw $9, -8($sp)
lw $8, 0($9)
sw $8, -80($sp)
li $8, 0
sw $8, -84($sp)
lw $9, -84($sp)
mul $8, $9, 4
sw $8, -88($sp)
lw $9, -80($sp)
lw $10, -88($sp)
add $8, $9, $10
sw $8, -80($sp)
lw $9, -8($sp)
lw $8, 0($9)
sw $8, -92($sp)
li $8, 0
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
li $8, 1
sw $8, -104($sp)
lw $9, -92($sp)
lw $10, -104($sp)
add $8, $9, $10
sw $8, -92($sp)
lw $8, -92($sp)
lw $9, -80($sp)
sw $8, 0($9)
lw $9, -20($sp)
lw $8, 0($9)
sw $8, -108($sp)
lw $9, -8($sp)
lw $8, 0($9)
sw $8, -112($sp)
li $8, 0
sw $8, -120($sp)
lw $9, -120($sp)
mul $8, $9, 4
sw $8, -124($sp)
lw $9, -112($sp)
lw $10, -124($sp)
add $8, $9, $10
sw $8, -112($sp)
lw $9, -112($sp)
lw $8, 0($9)
sw $8, -112($sp)
lw $9, -112($sp)
mul $8, $9, 4
sw $8, -116($sp)
lw $9, -108($sp)
lw $10, -116($sp)
add $8, $9, $10
sw $8, -108($sp)
lw $9, -32($sp)
lw $8, 0($9)
sw $8, -128($sp)
lw $8, -128($sp)
lw $9, -108($sp)
sw $8, 0($9)
lw $9, -16($sp)
lw $8, 0($9)
sw $8, -132($sp)
lw $9, -32($sp)
lw $8, 0($9)
sw $8, -136($sp)
lw $9, -136($sp)
mul $8, $9, 4
sw $8, -140($sp)
lw $9, -132($sp)
lw $10, -140($sp)
add $8, $9, $10
sw $8, -132($sp)
lw $9, -8($sp)
lw $8, 0($9)
sw $8, -144($sp)
li $8, 0
sw $8, -148($sp)
lw $9, -148($sp)
mul $8, $9, 4
sw $8, -152($sp)
lw $9, -144($sp)
lw $10, -152($sp)
add $8, $9, $10
sw $8, -144($sp)
lw $9, -144($sp)
lw $8, 0($9)
sw $8, -144($sp)
lw $8, -144($sp)
lw $9, -132($sp)
sw $8, 0($9)
label5:
label6:
lw $9, -32($sp)
lw $8, 0($9)
sw $8, -156($sp)
lw $9, -24($sp)
lw $8, 0($9)
sw $8, -160($sp)
lw $9, -156($sp)
lw $10, -160($sp)
mul $8, $9, $10
sw $8, -156($sp)
lw $9, -4($sp)
lw $8, 0($9)
sw $8, -164($sp)
lw $9, -156($sp)
lw $10, -164($sp)
sub $8, $9, $10
sw $8, -164($sp)
lw $8, -164($sp)
bgtz $8, label7
lw $9, -12($sp)
lw $8, 0($9)
sw $8, -168($sp)
lw $9, -32($sp)
lw $8, 0($9)
sw $8, -172($sp)
lw $9, -24($sp)
lw $8, 0($9)
sw $8, -180($sp)
lw $9, -172($sp)
lw $10, -180($sp)
mul $8, $9, $10
sw $8, -172($sp)
lw $9, -172($sp)
mul $8, $9, 4
sw $8, -176($sp)
lw $9, -168($sp)
lw $10, -176($sp)
add $8, $9, $10
sw $8, -168($sp)
li $8, 0
sw $8, -184($sp)
lw $8, -184($sp)
lw $9, -168($sp)
sw $8, 0($9)
lw $9, -24($sp)
move $8, $9
sw $8, -188($sp)
lw $9, -24($sp)
lw $8, 0($9)
sw $8, -192($sp)
li $8, 1
sw $8, -196($sp)
lw $9, -192($sp)
lw $10, -196($sp)
add $8, $9, $10
sw $8, -192($sp)
lw $8, -192($sp)
lw $9, -188($sp)
sw $8, 0($9)
j label6
label7:
lw $9, -24($sp)
move $8, $9
sw $8, -200($sp)
li $8, 2
sw $8, -204($sp)
lw $8, -204($sp)
lw $9, -200($sp)
sw $8, 0($9)
label4:
lw $9, -32($sp)
move $8, $9
sw $8, -208($sp)
lw $9, -32($sp)
lw $8, 0($9)
sw $8, -212($sp)
li $8, 1
sw $8, -216($sp)
lw $9, -212($sp)
lw $10, -216($sp)
add $8, $9, $10
sw $8, -212($sp)
lw $8, -212($sp)
lw $9, -208($sp)
sw $8, 0($9)
j label2
label3:
jr $ra
__getResult:
add $8, $29, 0
sw $8, -4($sp)
add $8, $29, 4
sw $8, -8($sp)
add $8, $29, 8
sw $8, -12($sp)
add $8, $29, 12
sw $8, -16($sp)
add $8, $29, 16
sw $8, -20($sp)
add $8, $29, 20
sw $8, -24($sp)
add $8, $29, 24
sw $8, -28($sp)
lw $9, -28($sp)
lw $8, 0($9)
sw $8, -32($sp)
lw $9, -8($sp)
lw $8, 0($9)
sw $8, -36($sp)
lw $9, -36($sp)
mul $8, $9, 680
sw $8, -40($sp)
lw $9, -32($sp)
lw $10, -40($sp)
add $8, $9, $10
sw $8, -32($sp)
lw $9, -12($sp)
lw $8, 0($9)
sw $8, -44($sp)
lw $9, -44($sp)
mul $8, $9, 4
sw $8, -48($sp)
lw $9, -32($sp)
lw $10, -48($sp)
add $8, $9, $10
sw $8, -32($sp)
lw $9, -32($sp)
lw $8, 0($9)
sw $8, -32($sp)
li $8, -1
sw $8, -52($sp)
lw $9, -32($sp)
lw $10, -52($sp)
sub $8, $9, $10
sw $8, -52($sp)
lw $8, -52($sp)
bnez $8, label8
lw $9, -24($sp)
lw $8, 0($9)
sw $8, -56($sp)
lw $9, -12($sp)
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
li $8, 2
sw $8, -68($sp)
lw $9, -56($sp)
lw $10, -68($sp)
mul $8, $9, $10
sw $8, -56($sp)
lw $9, -24($sp)
lw $8, 0($9)
sw $8, -72($sp)
lw $9, -8($sp)
lw $8, 0($9)
sw $8, -76($sp)
lw $9, -76($sp)
mul $8, $9, 4
sw $8, -80($sp)
lw $9, -72($sp)
lw $10, -80($sp)
add $8, $9, $10
sw $8, -72($sp)
lw $9, -72($sp)
lw $8, 0($9)
sw $8, -72($sp)
lw $9, -56($sp)
lw $10, -72($sp)
sub $8, $9, $10
sw $8, -56($sp)
lw $9, -4($sp)
lw $8, 0($9)
sw $8, -84($sp)
lw $9, -56($sp)
lw $10, -84($sp)
sub $8, $9, $10
sw $8, -84($sp)
lw $8, -84($sp)
bgtz $8, label9
lw $9, -16($sp)
lw $8, 0($9)
sw $8, -88($sp)
lw $9, -24($sp)
lw $8, 0($9)
sw $8, -92($sp)
lw $9, -12($sp)
lw $8, 0($9)
sw $8, -100($sp)
lw $9, -100($sp)
mul $8, $9, 4
sw $8, -104($sp)
lw $9, -92($sp)
lw $10, -104($sp)
add $8, $9, $10
sw $8, -92($sp)
lw $9, -92($sp)
lw $8, 0($9)
sw $8, -92($sp)
li $8, 2
sw $8, -108($sp)
lw $9, -92($sp)
lw $10, -108($sp)
mul $8, $9, $10
sw $8, -92($sp)
lw $9, -24($sp)
lw $8, 0($9)
sw $8, -112($sp)
lw $9, -8($sp)
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
lw $9, -92($sp)
lw $10, -112($sp)
sub $8, $9, $10
sw $8, -92($sp)
lw $9, -92($sp)
mul $8, $9, 4
sw $8, -96($sp)
lw $9, -88($sp)
lw $10, -96($sp)
add $8, $9, $10
sw $8, -88($sp)
lw $9, -88($sp)
lw $8, 0($9)
sw $8, -88($sp)
lw $8, -88($sp)
beqz $8, label10
lw $9, -28($sp)
lw $8, 0($9)
sw $8, -124($sp)
lw $9, -8($sp)
lw $8, 0($9)
sw $8, -128($sp)
lw $9, -128($sp)
mul $8, $9, 680
sw $8, -132($sp)
lw $9, -124($sp)
lw $10, -132($sp)
add $8, $9, $10
sw $8, -124($sp)
lw $9, -12($sp)
lw $8, 0($9)
sw $8, -136($sp)
lw $9, -136($sp)
mul $8, $9, 4
sw $8, -140($sp)
lw $9, -124($sp)
lw $10, -140($sp)
add $8, $9, $10
sw $8, -124($sp)
sw $31, -320($29)
lw $9, -28($sp)
lw $8, 0($9)
sw $8, -148($sp)
add $8, $29, -324
sw $8, -152($sp)
lw $8, -148($sp)
lw $9, -152($sp)
sw $8, 0($9)
add $8, $29, -328
sw $8, -160($sp)
lw $9, -24($sp)
lw $8, 0($9)
sw $8, -156($sp)
lw $8, -156($sp)
lw $9, -160($sp)
sw $8, 0($9)
add $8, $29, -332
sw $8, -168($sp)
lw $9, -20($sp)
lw $8, 0($9)
sw $8, -164($sp)
lw $8, -164($sp)
lw $9, -168($sp)
sw $8, 0($9)
add $8, $29, -336
sw $8, -176($sp)
lw $9, -16($sp)
lw $8, 0($9)
sw $8, -172($sp)
lw $8, -172($sp)
lw $9, -176($sp)
sw $8, 0($9)
lw $9, -20($sp)
lw $8, 0($9)
sw $8, -180($sp)
lw $9, -24($sp)
lw $8, 0($9)
sw $8, -184($sp)
lw $9, -12($sp)
lw $8, 0($9)
sw $8, -192($sp)
lw $9, -192($sp)
mul $8, $9, 4
sw $8, -196($sp)
lw $9, -184($sp)
lw $10, -196($sp)
add $8, $9, $10
sw $8, -184($sp)
lw $9, -184($sp)
lw $8, 0($9)
sw $8, -184($sp)
li $8, 2
sw $8, -200($sp)
lw $9, -184($sp)
lw $10, -200($sp)
mul $8, $9, $10
sw $8, -184($sp)
lw $9, -24($sp)
lw $8, 0($9)
sw $8, -204($sp)
lw $9, -8($sp)
lw $8, 0($9)
sw $8, -208($sp)
lw $9, -208($sp)
mul $8, $9, 4
sw $8, -212($sp)
lw $9, -204($sp)
lw $10, -212($sp)
add $8, $9, $10
sw $8, -204($sp)
lw $9, -204($sp)
lw $8, 0($9)
sw $8, -204($sp)
lw $9, -184($sp)
lw $10, -204($sp)
sub $8, $9, $10
sw $8, -184($sp)
lw $9, -184($sp)
mul $8, $9, 4
sw $8, -188($sp)
lw $9, -180($sp)
lw $10, -188($sp)
add $8, $9, $10
sw $8, -180($sp)
add $8, $29, -340
sw $8, -216($sp)
lw $9, -180($sp)
lw $8, 0($9)
sw $8, -180($sp)
lw $8, -180($sp)
lw $9, -216($sp)
sw $8, 0($9)
add $8, $29, -344
sw $8, -224($sp)
lw $9, -12($sp)
lw $8, 0($9)
sw $8, -220($sp)
lw $8, -220($sp)
lw $9, -224($sp)
sw $8, 0($9)
add $8, $29, -348
sw $8, -232($sp)
lw $9, -4($sp)
lw $8, 0($9)
sw $8, -228($sp)
lw $8, -228($sp)
lw $9, -232($sp)
sw $8, 0($9)
add $29, $29, -348
jal __getResult
sub $29, $29, -348
lw $31, -320($29)
add $8, $29, -316
sw $8, -236($sp)
lw $9, -236($sp)
lw $8, 0($9)
sw $8, -144($sp)
li $8, 1
sw $8, -240($sp)
lw $9, -144($sp)
lw $10, -240($sp)
add $8, $9, $10
sw $8, -144($sp)
lw $8, -144($sp)
lw $9, -124($sp)
sw $8, 0($9)
label10:
label9:
label8:
lw $9, -28($sp)
lw $8, 0($9)
sw $8, -244($sp)
lw $9, -8($sp)
lw $8, 0($9)
sw $8, -248($sp)
lw $9, -248($sp)
mul $8, $9, 680
sw $8, -252($sp)
lw $9, -244($sp)
lw $10, -252($sp)
add $8, $9, $10
sw $8, -244($sp)
lw $9, -12($sp)
lw $8, 0($9)
sw $8, -256($sp)
lw $9, -256($sp)
mul $8, $9, 4
sw $8, -260($sp)
lw $9, -244($sp)
lw $10, -260($sp)
add $8, $9, $10
sw $8, -244($sp)
lw $9, -244($sp)
lw $8, 0($9)
sw $8, -244($sp)
li $8, -1
sw $8, -264($sp)
lw $9, -244($sp)
lw $10, -264($sp)
sub $8, $9, $10
sw $8, -264($sp)
lw $8, -264($sp)
bnez $8, label11
lw $9, -28($sp)
lw $8, 0($9)
sw $8, -268($sp)
lw $9, -8($sp)
lw $8, 0($9)
sw $8, -272($sp)
lw $9, -272($sp)
mul $8, $9, 680
sw $8, -276($sp)
lw $9, -268($sp)
lw $10, -276($sp)
add $8, $9, $10
sw $8, -268($sp)
lw $9, -12($sp)
lw $8, 0($9)
sw $8, -280($sp)
lw $9, -280($sp)
mul $8, $9, 4
sw $8, -284($sp)
lw $9, -268($sp)
lw $10, -284($sp)
add $8, $9, $10
sw $8, -268($sp)
li $8, 1
sw $8, -288($sp)
lw $8, -288($sp)
lw $9, -268($sp)
sw $8, 0($9)
label11:
lw $9, -28($sp)
lw $8, 0($9)
sw $8, -292($sp)
lw $9, -8($sp)
lw $8, 0($9)
sw $8, -296($sp)
lw $9, -296($sp)
mul $8, $9, 680
sw $8, -300($sp)
lw $9, -292($sp)
lw $10, -300($sp)
add $8, $9, $10
sw $8, -292($sp)
lw $9, -12($sp)
lw $8, 0($9)
sw $8, -304($sp)
lw $9, -304($sp)
mul $8, $9, 4
sw $8, -308($sp)
lw $9, -292($sp)
lw $10, -308($sp)
add $8, $9, $10
sw $8, -292($sp)
add $8, $29, 32
sw $8, -312($sp)
lw $9, -292($sp)
lw $8, 0($9)
sw $8, -292($sp)
lw $8, -292($sp)
lw $9, -312($sp)
sw $8, 0($9)
jr $ra
jr $ra
__printF:
add $8, $29, 0
sw $8, -4($sp)
add $8, $29, 4
sw $8, -8($sp)
add $8, $29, 8
sw $8, -12($sp)
sw $31, -136($29)
add $8, $29, -140
sw $8, -24($sp)
lw $9, -4($sp)
lw $8, 0($9)
sw $8, -20($sp)
lw $8, -20($sp)
lw $9, -24($sp)
sw $8, 0($9)
add $29, $29, -140
jal __xprinti
sub $29, $29, -140
lw $31, -136($29)
add $8, $29, -132
sw $8, -28($sp)
lw $9, -28($sp)
move $8, $9
sw $8, -16($sp)
label12:
lw $9, -12($sp)
lw $8, 0($9)
sw $8, -32($sp)
li $8, 0
sw $8, -36($sp)
lw $9, -32($sp)
lw $10, -36($sp)
sub $8, $9, $10
sw $8, -36($sp)
lw $8, -36($sp)
blez $8, label13
sw $31, -136($29)
lw $9, 680($a3)
move $8, $9
sw $8, -44($sp)
add $8, $29, -140
sw $8, -48($sp)
lw $8, -44($sp)
lw $9, -48($sp)
sw $8, 0($9)
add $29, $29, -140
jal __xprint
sub $29, $29, -140
lw $31, -136($29)
add $8, $29, -132
sw $8, -52($sp)
lw $9, -52($sp)
move $8, $9
sw $8, -40($sp)
sw $31, -136($29)
add $8, $29, -140
sw $8, -64($sp)
lw $9, -8($sp)
lw $8, 0($9)
sw $8, -60($sp)
lw $8, -60($sp)
lw $9, -64($sp)
sw $8, 0($9)
add $29, $29, -140
jal __xprinti
sub $29, $29, -140
lw $31, -136($29)
add $8, $29, -132
sw $8, -68($sp)
lw $9, -68($sp)
move $8, $9
sw $8, -56($sp)
lw $9, -8($sp)
move $8, $9
sw $8, -72($sp)
lw $9, -8($sp)
lw $8, 0($9)
sw $8, -76($sp)
li $8, 2
sw $8, -80($sp)
lw $9, -76($sp)
lw $10, -80($sp)
mul $8, $9, $10
sw $8, -76($sp)
lw $9, -4($sp)
lw $8, 0($9)
sw $8, -84($sp)
lw $9, -76($sp)
lw $10, -84($sp)
sub $8, $9, $10
sw $8, -76($sp)
lw $8, -76($sp)
lw $9, -72($sp)
sw $8, 0($9)
lw $9, -4($sp)
move $8, $9
sw $8, -88($sp)
lw $9, -4($sp)
lw $8, 0($9)
sw $8, -92($sp)
lw $9, -8($sp)
lw $8, 0($9)
sw $8, -96($sp)
lw $9, -92($sp)
lw $10, -96($sp)
add $8, $9, $10
sw $8, -92($sp)
li $8, 2
sw $8, -100($sp)
lw $9, -92($sp)
lw $10, -100($sp)
div $8, $9, $10
sw $8, -92($sp)
lw $8, -92($sp)
lw $9, -88($sp)
sw $8, 0($9)
lw $9, -12($sp)
move $8, $9
sw $8, -104($sp)
lw $9, -12($sp)
lw $8, 0($9)
sw $8, -108($sp)
li $8, 1
sw $8, -112($sp)
lw $9, -108($sp)
lw $10, -112($sp)
sub $8, $9, $10
sw $8, -108($sp)
lw $8, -108($sp)
lw $9, -104($sp)
sw $8, 0($9)
j label12
label13:
sw $31, -136($29)
lw $9, 760($a3)
move $8, $9
sw $8, -120($sp)
add $8, $29, -140
sw $8, -124($sp)
lw $8, -120($sp)
lw $9, -124($sp)
sw $8, 0($9)
add $29, $29, -140
jal __xprint
sub $29, $29, -140
lw $31, -136($29)
add $8, $29, -132
sw $8, -128($sp)
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
sw $t0, 72($a3)
la $t0, var12
sw $t0, 100($a3)
la $t0, var13
sw $t0, 680($a3)
la $t0, var14
sw $t0, 760($a3)
la $t0, var15
sw $t0, 1400($a3)
lw $9, 8($a3)
move $8, $9
sw $8, -4($sp)
li $8, 1000
sw $8, -8($sp)
lw $8, -8($sp)
lw $9, -4($sp)
sw $8, 0($9)
lw $9, 12($a3)
move $8, $9
sw $8, -12($sp)
li $8, 100
sw $8, -16($sp)
add $29, $29, -648
jal __getchar
sub $29, $29, -648
add $8, $29, -644
sw $8, -24($sp)
lw $9, -24($sp)
lw $8, 0($9)
sw $8, -20($sp)
li $8, 48
sw $8, -28($sp)
lw $9, -20($sp)
lw $10, -28($sp)
sub $8, $9, $10
sw $8, -20($sp)
lw $9, -16($sp)
lw $10, -20($sp)
mul $8, $9, $10
sw $8, -16($sp)
li $8, 10
sw $8, -32($sp)
add $29, $29, -648
jal __getchar
sub $29, $29, -648
add $8, $29, -644
sw $8, -40($sp)
lw $9, -40($sp)
lw $8, 0($9)
sw $8, -36($sp)
li $8, 48
sw $8, -44($sp)
lw $9, -36($sp)
lw $10, -44($sp)
sub $8, $9, $10
sw $8, -36($sp)
lw $9, -32($sp)
lw $10, -36($sp)
mul $8, $9, $10
sw $8, -32($sp)
lw $9, -16($sp)
lw $10, -32($sp)
add $8, $9, $10
sw $8, -16($sp)
add $29, $29, -648
jal __getchar
sub $29, $29, -648
add $8, $29, -644
sw $8, -52($sp)
lw $9, -52($sp)
lw $8, 0($9)
sw $8, -48($sp)
lw $9, -16($sp)
lw $10, -48($sp)
add $8, $9, $10
sw $8, -16($sp)
li $8, 48
sw $8, -56($sp)
lw $9, -16($sp)
lw $10, -56($sp)
sub $8, $9, $10
sw $8, -16($sp)
lw $8, -16($sp)
lw $9, -12($sp)
sw $8, 0($9)
lw $9, 24($a3)
move $8, $9
sw $8, -60($sp)
li $8, 0
sw $8, -64($sp)
lw $8, -64($sp)
lw $9, -60($sp)
sw $8, 0($9)
lw $9, 28($a3)
move $8, $9
sw $8, -68($sp)
li $8, 0
sw $8, -72($sp)
lw $8, -72($sp)
lw $9, -68($sp)
sw $8, 0($9)
li $8, 0
sw $8, -80($sp)
lw $9, -80($sp)
mul $8, $9, 4
sw $8, -84($sp)
lw $9, 44($a3)
lw $10, -84($sp)
add $8, $9, $10
sw $8, -76($sp)
li $8, 0
sw $8, -88($sp)
lw $8, -88($sp)
lw $9, -76($sp)
sw $8, 0($9)
lw $9, 16($a3)
move $8, $9
sw $8, -92($sp)
li $8, 0
sw $8, -96($sp)
lw $8, -96($sp)
lw $9, -92($sp)
sw $8, 0($9)
label14:
lw $9, 16($a3)
lw $8, 0($9)
sw $8, -100($sp)
lw $9, 8($a3)
lw $8, 0($9)
sw $8, -104($sp)
li $8, 1
sw $8, -108($sp)
lw $9, -104($sp)
lw $10, -108($sp)
add $8, $9, $10
sw $8, -104($sp)
lw $9, -100($sp)
lw $10, -104($sp)
sub $8, $9, $10
sw $8, -104($sp)
lw $8, -104($sp)
bgez $8, label15
lw $9, 16($a3)
lw $8, 0($9)
sw $8, -116($sp)
lw $9, -116($sp)
mul $8, $9, 4
sw $8, -120($sp)
lw $9, 32($a3)
lw $10, -120($sp)
add $8, $9, $10
sw $8, -112($sp)
li $8, 1
sw $8, -124($sp)
lw $8, -124($sp)
lw $9, -112($sp)
sw $8, 0($9)
lw $9, 16($a3)
lw $8, 0($9)
sw $8, -132($sp)
lw $9, -132($sp)
mul $8, $9, 4
sw $8, -136($sp)
lw $9, 40($a3)
lw $10, -136($sp)
add $8, $9, $10
sw $8, -128($sp)
li $8, 0
sw $8, -140($sp)
lw $8, -140($sp)
lw $9, -128($sp)
sw $8, 0($9)
label16:
lw $9, 16($a3)
move $8, $9
sw $8, -144($sp)
lw $9, 16($a3)
lw $8, 0($9)
sw $8, -148($sp)
li $8, 1
sw $8, -152($sp)
lw $9, -148($sp)
lw $10, -152($sp)
add $8, $9, $10
sw $8, -148($sp)
lw $8, -148($sp)
lw $9, -144($sp)
sw $8, 0($9)
j label14
label15:
lw $9, 16($a3)
move $8, $9
sw $8, -156($sp)
li $8, 0
sw $8, -160($sp)
lw $8, -160($sp)
lw $9, -156($sp)
sw $8, 0($9)
label17:
lw $9, 16($a3)
lw $8, 0($9)
sw $8, -164($sp)
lw $9, 12($a3)
lw $8, 0($9)
sw $8, -168($sp)
li $8, 1
sw $8, -172($sp)
lw $9, -168($sp)
lw $10, -172($sp)
add $8, $9, $10
sw $8, -168($sp)
lw $9, -164($sp)
lw $10, -168($sp)
sub $8, $9, $10
sw $8, -168($sp)
lw $8, -168($sp)
bgez $8, label18
lw $9, 16($a3)
lw $8, 0($9)
sw $8, -180($sp)
lw $9, -180($sp)
mul $8, $9, 4
sw $8, -184($sp)
lw $9, 36($a3)
lw $10, -184($sp)
add $8, $9, $10
sw $8, -176($sp)
li $8, 0
sw $8, -188($sp)
lw $8, -188($sp)
lw $9, -176($sp)
sw $8, 0($9)
label19:
lw $9, 16($a3)
move $8, $9
sw $8, -192($sp)
lw $9, 16($a3)
lw $8, 0($9)
sw $8, -196($sp)
li $8, 1
sw $8, -200($sp)
lw $9, -196($sp)
lw $10, -200($sp)
add $8, $9, $10
sw $8, -196($sp)
lw $8, -196($sp)
lw $9, -192($sp)
sw $8, 0($9)
j label17
label18:
lw $9, 16($a3)
move $8, $9
sw $8, -204($sp)
li $8, 0
sw $8, -208($sp)
lw $8, -208($sp)
lw $9, -204($sp)
sw $8, 0($9)
label20:
lw $9, 16($a3)
lw $8, 0($9)
sw $8, -212($sp)
lw $9, 12($a3)
lw $8, 0($9)
sw $8, -216($sp)
lw $9, -212($sp)
lw $10, -216($sp)
sub $8, $9, $10
sw $8, -216($sp)
lw $8, -216($sp)
bgtz $8, label21
lw $9, 20($a3)
move $8, $9
sw $8, -220($sp)
li $8, 0
sw $8, -224($sp)
lw $8, -224($sp)
lw $9, -220($sp)
sw $8, 0($9)
label23:
lw $9, 20($a3)
lw $8, 0($9)
sw $8, -228($sp)
lw $9, 12($a3)
lw $8, 0($9)
sw $8, -232($sp)
lw $9, -228($sp)
lw $10, -232($sp)
sub $8, $9, $10
sw $8, -232($sp)
lw $8, -232($sp)
bgtz $8, label24
lw $9, 16($a3)
lw $8, 0($9)
sw $8, -240($sp)
lw $9, -240($sp)
mul $8, $9, 680
sw $8, -244($sp)
lw $9, 48($a3)
lw $10, -244($sp)
add $8, $9, $10
sw $8, -236($sp)
lw $9, 20($a3)
lw $8, 0($9)
sw $8, -248($sp)
lw $9, -248($sp)
mul $8, $9, 4
sw $8, -252($sp)
lw $9, -236($sp)
lw $10, -252($sp)
add $8, $9, $10
sw $8, -236($sp)
li $8, -1
sw $8, -256($sp)
lw $8, -256($sp)
lw $9, -236($sp)
sw $8, 0($9)
label25:
lw $9, 20($a3)
move $8, $9
sw $8, -260($sp)
lw $9, 20($a3)
lw $8, 0($9)
sw $8, -264($sp)
li $8, 1
sw $8, -268($sp)
lw $9, -264($sp)
lw $10, -268($sp)
add $8, $9, $10
sw $8, -264($sp)
lw $8, -264($sp)
lw $9, -260($sp)
sw $8, 0($9)
j label23
label24:
label22:
lw $9, 16($a3)
move $8, $9
sw $8, -272($sp)
lw $9, 16($a3)
lw $8, 0($9)
sw $8, -276($sp)
li $8, 1
sw $8, -280($sp)
lw $9, -276($sp)
lw $10, -280($sp)
add $8, $9, $10
sw $8, -276($sp)
lw $8, -276($sp)
lw $9, -272($sp)
sw $8, 0($9)
j label20
label21:
lw $9, 36($a3)
move $8, $9
sw $8, -288($sp)
add $8, $29, -652
sw $8, -292($sp)
lw $8, -288($sp)
lw $9, -292($sp)
sw $8, 0($9)
lw $9, 40($a3)
move $8, $9
sw $8, -296($sp)
add $8, $29, -656
sw $8, -300($sp)
lw $8, -296($sp)
lw $9, -300($sp)
sw $8, 0($9)
lw $9, 32($a3)
move $8, $9
sw $8, -304($sp)
add $8, $29, -660
sw $8, -308($sp)
lw $8, -304($sp)
lw $9, -308($sp)
sw $8, 0($9)
lw $9, 44($a3)
move $8, $9
sw $8, -312($sp)
add $8, $29, -664
sw $8, -316($sp)
lw $8, -312($sp)
lw $9, -316($sp)
sw $8, 0($9)
add $8, $29, -668
sw $8, -324($sp)
lw $9, 8($a3)
lw $8, 0($9)
sw $8, -320($sp)
lw $8, -320($sp)
lw $9, -324($sp)
sw $8, 0($9)
add $29, $29, -668
jal __getPrime
sub $29, $29, -668
add $8, $29, -644
sw $8, -328($sp)
lw $9, -328($sp)
move $8, $9
sw $8, -284($sp)
lw $9, 24($a3)
move $8, $9
sw $8, -332($sp)
li $8, 0
sw $8, -340($sp)
lw $9, -340($sp)
mul $8, $9, 4
sw $8, -344($sp)
lw $9, 44($a3)
lw $10, -344($sp)
add $8, $9, $10
sw $8, -336($sp)
lw $9, -336($sp)
lw $8, 0($9)
sw $8, -336($sp)
lw $8, -336($sp)
lw $9, -332($sp)
sw $8, 0($9)
lw $9, 16($a3)
move $8, $9
sw $8, -348($sp)
li $8, 1
sw $8, -352($sp)
lw $8, -352($sp)
lw $9, -348($sp)
sw $8, 0($9)
label26:
lw $9, 16($a3)
lw $8, 0($9)
sw $8, -356($sp)
lw $9, 24($a3)
lw $8, 0($9)
sw $8, -360($sp)
lw $9, -356($sp)
lw $10, -360($sp)
sub $8, $9, $10
sw $8, -360($sp)
lw $8, -360($sp)
bgez $8, label27
lw $9, 20($a3)
move $8, $9
sw $8, -364($sp)
lw $9, 16($a3)
lw $8, 0($9)
sw $8, -368($sp)
li $8, 1
sw $8, -372($sp)
lw $9, -368($sp)
lw $10, -372($sp)
add $8, $9, $10
sw $8, -368($sp)
lw $8, -368($sp)
lw $9, -364($sp)
sw $8, 0($9)
label29:
lw $9, 20($a3)
lw $8, 0($9)
sw $8, -376($sp)
lw $9, 24($a3)
lw $8, 0($9)
sw $8, -380($sp)
lw $9, -376($sp)
lw $10, -380($sp)
sub $8, $9, $10
sw $8, -380($sp)
lw $8, -380($sp)
bgtz $8, label30
lw $9, 16($a3)
lw $8, 0($9)
sw $8, -388($sp)
lw $9, -388($sp)
mul $8, $9, 680
sw $8, -392($sp)
lw $9, 48($a3)
lw $10, -392($sp)
add $8, $9, $10
sw $8, -384($sp)
lw $9, 20($a3)
lw $8, 0($9)
sw $8, -396($sp)
lw $9, -396($sp)
mul $8, $9, 4
sw $8, -400($sp)
lw $9, -384($sp)
lw $10, -400($sp)
add $8, $9, $10
sw $8, -384($sp)
lw $9, -384($sp)
lw $8, 0($9)
sw $8, -384($sp)
li $8, -1
sw $8, -404($sp)
lw $9, -384($sp)
lw $10, -404($sp)
sub $8, $9, $10
sw $8, -404($sp)
lw $8, -404($sp)
bnez $8, label32
lw $9, 16($a3)
lw $8, 0($9)
sw $8, -412($sp)
lw $9, -412($sp)
mul $8, $9, 680
sw $8, -416($sp)
lw $9, 48($a3)
lw $10, -416($sp)
add $8, $9, $10
sw $8, -408($sp)
lw $9, 20($a3)
lw $8, 0($9)
sw $8, -420($sp)
lw $9, -420($sp)
mul $8, $9, 4
sw $8, -424($sp)
lw $9, -408($sp)
lw $10, -424($sp)
add $8, $9, $10
sw $8, -408($sp)
lw $9, 48($a3)
move $8, $9
sw $8, -432($sp)
add $8, $29, -652
sw $8, -436($sp)
lw $8, -432($sp)
lw $9, -436($sp)
sw $8, 0($9)
lw $9, 36($a3)
move $8, $9
sw $8, -440($sp)
add $8, $29, -656
sw $8, -444($sp)
lw $8, -440($sp)
lw $9, -444($sp)
sw $8, 0($9)
lw $9, 40($a3)
move $8, $9
sw $8, -448($sp)
add $8, $29, -660
sw $8, -452($sp)
lw $8, -448($sp)
lw $9, -452($sp)
sw $8, 0($9)
lw $9, 32($a3)
move $8, $9
sw $8, -456($sp)
add $8, $29, -664
sw $8, -460($sp)
lw $8, -456($sp)
lw $9, -460($sp)
sw $8, 0($9)
add $8, $29, -668
sw $8, -468($sp)
lw $9, 20($a3)
lw $8, 0($9)
sw $8, -464($sp)
lw $8, -464($sp)
lw $9, -468($sp)
sw $8, 0($9)
add $8, $29, -672
sw $8, -476($sp)
lw $9, 16($a3)
lw $8, 0($9)
sw $8, -472($sp)
lw $8, -472($sp)
lw $9, -476($sp)
sw $8, 0($9)
add $8, $29, -676
sw $8, -484($sp)
lw $9, 8($a3)
lw $8, 0($9)
sw $8, -480($sp)
lw $8, -480($sp)
lw $9, -484($sp)
sw $8, 0($9)
add $29, $29, -676
jal __getResult
sub $29, $29, -676
add $8, $29, -644
sw $8, -488($sp)
lw $9, -488($sp)
lw $8, 0($9)
sw $8, -428($sp)
lw $8, -428($sp)
lw $9, -408($sp)
sw $8, 0($9)
lw $9, 16($a3)
lw $8, 0($9)
sw $8, -496($sp)
lw $9, -496($sp)
mul $8, $9, 680
sw $8, -500($sp)
lw $9, 48($a3)
lw $10, -500($sp)
add $8, $9, $10
sw $8, -492($sp)
lw $9, 20($a3)
lw $8, 0($9)
sw $8, -504($sp)
lw $9, -504($sp)
mul $8, $9, 4
sw $8, -508($sp)
lw $9, -492($sp)
lw $10, -508($sp)
add $8, $9, $10
sw $8, -492($sp)
lw $9, -492($sp)
lw $8, 0($9)
sw $8, -492($sp)
li $8, 1
sw $8, -512($sp)
lw $9, -492($sp)
lw $10, -512($sp)
sub $8, $9, $10
sw $8, -512($sp)
lw $8, -512($sp)
blez $8, label33
lw $9, 16($a3)
lw $8, 0($9)
sw $8, -524($sp)
lw $9, -524($sp)
mul $8, $9, 680
sw $8, -528($sp)
lw $9, 48($a3)
lw $10, -528($sp)
add $8, $9, $10
sw $8, -520($sp)
lw $9, 20($a3)
lw $8, 0($9)
sw $8, -532($sp)
lw $9, -532($sp)
mul $8, $9, 4
sw $8, -536($sp)
lw $9, -520($sp)
lw $10, -536($sp)
add $8, $9, $10
sw $8, -520($sp)
add $8, $29, -652
sw $8, -540($sp)
lw $9, -520($sp)
lw $8, 0($9)
sw $8, -520($sp)
lw $8, -520($sp)
lw $9, -540($sp)
sw $8, 0($9)
lw $9, 20($a3)
lw $8, 0($9)
sw $8, -548($sp)
lw $9, -548($sp)
mul $8, $9, 4
sw $8, -552($sp)
lw $9, 36($a3)
lw $10, -552($sp)
add $8, $9, $10
sw $8, -544($sp)
add $8, $29, -656
sw $8, -556($sp)
lw $9, -544($sp)
lw $8, 0($9)
sw $8, -544($sp)
lw $8, -544($sp)
lw $9, -556($sp)
sw $8, 0($9)
lw $9, 16($a3)
lw $8, 0($9)
sw $8, -564($sp)
lw $9, -564($sp)
mul $8, $9, 4
sw $8, -568($sp)
lw $9, 36($a3)
lw $10, -568($sp)
add $8, $9, $10
sw $8, -560($sp)
add $8, $29, -660
sw $8, -572($sp)
lw $9, -560($sp)
lw $8, 0($9)
sw $8, -560($sp)
lw $8, -560($sp)
lw $9, -572($sp)
sw $8, 0($9)
add $29, $29, -660
jal __printF
sub $29, $29, -660
add $8, $29, -644
sw $8, -576($sp)
lw $9, -576($sp)
move $8, $9
sw $8, -516($sp)
lw $9, 28($a3)
move $8, $9
sw $8, -580($sp)
lw $9, 28($a3)
lw $8, 0($9)
sw $8, -584($sp)
li $8, 1
sw $8, -588($sp)
lw $9, -584($sp)
lw $10, -588($sp)
add $8, $9, $10
sw $8, -584($sp)
lw $8, -584($sp)
lw $9, -580($sp)
sw $8, 0($9)
label33:
label32:
label31:
lw $9, 20($a3)
move $8, $9
sw $8, -592($sp)
lw $9, 20($a3)
lw $8, 0($9)
sw $8, -596($sp)
li $8, 1
sw $8, -600($sp)
lw $9, -596($sp)
lw $10, -600($sp)
add $8, $9, $10
sw $8, -596($sp)
lw $8, -596($sp)
lw $9, -592($sp)
sw $8, 0($9)
j label29
label30:
label28:
lw $9, 16($a3)
move $8, $9
sw $8, -604($sp)
lw $9, 16($a3)
lw $8, 0($9)
sw $8, -608($sp)
li $8, 1
sw $8, -612($sp)
lw $9, -608($sp)
lw $10, -612($sp)
add $8, $9, $10
sw $8, -608($sp)
lw $8, -608($sp)
lw $9, -604($sp)
sw $8, 0($9)
j label26
label27:
add $8, $29, -648
sw $8, -624($sp)
lw $9, 28($a3)
lw $8, 0($9)
sw $8, -620($sp)
lw $8, -620($sp)
lw $9, -624($sp)
sw $8, 0($9)
lw $9, 1400($a3)
move $8, $9
sw $8, -628($sp)
add $8, $29, -652
sw $8, -632($sp)
lw $8, -628($sp)
lw $9, -632($sp)
sw $8, 0($9)
add $29, $29, -652
jal __printf
sub $29, $29, -652
li $8, 0
sw $8, -636($sp)
add $8, $29, 4
sw $8, -640($sp)
lw $8, -636($sp)
lw $9, -640($sp)
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
#global $8 4004
#global $9 680
#global $10 4004
#global $11 4
#global $12 115600
#string $18 #%s
#string $25 #%d
#string $170 # 
#string $190 #\n
#string $350 #Total: %d\n
#----------------------------
#func #xprint
#addi $13 $0 0
#goto l:0
#sw $1 $0 -28
####move $15 $13
#addi $16 $0 -32
#lw $15 $13 0
#sw $15 $16 0
#move $17 $18
#addi $19 $0 -36
#sw $17 $19 0
#addi $0 $0 -36
#call #printf
#subi $0 $0 -36
#lw $1 $0 -28
#label l:0
#return
#----------------------------
#func #xprinti
#addi $20 $0 0
#goto l:1
#sw $1 $0 -28
####move $22 $20
#addi $23 $0 -32
#lw $22 $20 0
#sw $22 $23 0
#move $24 $25
#addi $26 $0 -36
#sw $24 $26 0
#addi $0 $0 -36
#call #printf
#subi $0 $0 -36
#lw $1 $0 -28
#label l:1
#return
#----------------------------
#func #getPrime
#addi $27 $0 0
#addi $28 $0 4
#addi $29 $0 8
#addi $30 $0 12
#addi $31 $0 16
#addi $33 $0 -220
#move $32 $33
#addi $35 $0 -224
#move $34 $35
#move $36 $33
#li $37 2
#sw $37 $36 0
#move $38 $35
#li $39 2
#sw $39 $38 0
#label l:2
####move $40 $34
#lw $40 $34 0
####move $41 $27
#lw $41 $27 0
#sub $41 $40 $41
#bgtz $41 l:3
####move $42 $29
#lw $42 $29 0
####move $43 $34
#lw $43 $34 0
#muli $44 $43 4
#add $42 $42 $44
#lw $42 $42 0
#li $45 1
#sub $45 $42 $45
#bnez $45 l:5
####move $46 $28
#lw $46 $28 0
#li $47 0
#muli $48 $47 4
#add $46 $46 $48
####move $49 $28
#lw $49 $28 0
#li $50 0
#muli $51 $50 4
#add $49 $49 $51
#lw $49 $49 0
#li $52 1
#add $49 $49 $52
#sw $49 $46 0
####move $53 $31
#lw $53 $31 0
####move $54 $28
#lw $54 $28 0
#li $56 0
#muli $57 $56 4
#add $54 $54 $57
#lw $54 $54 0
#muli $55 $54 4
#add $53 $53 $55
####move $58 $34
#lw $58 $34 0
#sw $58 $53 0
####move $59 $30
#lw $59 $30 0
####move $60 $34
#lw $60 $34 0
#muli $61 $60 4
#add $59 $59 $61
####move $62 $28
#lw $62 $28 0
#li $63 0
#muli $64 $63 4
#add $62 $62 $64
#lw $62 $62 0
#sw $62 $59 0
#label l:5
#label l:6
####move $65 $34
#lw $65 $34 0
####move $66 $32
#lw $66 $32 0
#mul $65 $65 $66
####move $67 $27
#lw $67 $27 0
#sub $67 $65 $67
#bgtz $67 l:7
####move $68 $29
#lw $68 $29 0
####move $69 $34
#lw $69 $34 0
####move $71 $32
#lw $71 $32 0
#mul $69 $69 $71
#muli $70 $69 4
#add $68 $68 $70
#li $72 0
#sw $72 $68 0
#move $73 $32
####move $74 $32
#lw $74 $32 0
#li $75 1
#add $74 $74 $75
#sw $74 $73 0
#goto l:6
#label l:7
#move $76 $32
#li $77 2
#sw $77 $76 0
#label l:4
#move $78 $34
####move $79 $34
#lw $79 $34 0
#li $80 1
#add $79 $79 $80
#sw $79 $78 0
#goto l:2
#label l:3
#return
#----------------------------
#func #getResult
#addi $81 $0 0
#addi $82 $0 4
#addi $83 $0 8
#addi $84 $0 12
#addi $85 $0 16
#addi $86 $0 20
#addi $87 $0 24
#lw $88 $87 0
####move $89 $82
#lw $89 $82 0
#muli $90 $89 680
#add $88 $88 $90
####move $91 $83
#lw $91 $83 0
#muli $92 $91 4
#add $88 $88 $92
#lw $88 $88 0
#li $93 -1
#sub $93 $88 $93
#bnez $93 l:8
####move $94 $86
#lw $94 $86 0
####move $95 $83
#lw $95 $83 0
#muli $96 $95 4
#add $94 $94 $96
#lw $94 $94 0
#li $97 2
#mul $94 $94 $97
####move $98 $86
#lw $98 $86 0
####move $99 $82
#lw $99 $82 0
#muli $100 $99 4
#add $98 $98 $100
#lw $98 $98 0
#sub $94 $94 $98
####move $101 $81
#lw $101 $81 0
#sub $101 $94 $101
#bgtz $101 l:9
####move $102 $84
#lw $102 $84 0
####move $103 $86
#lw $103 $86 0
####move $105 $83
#lw $105 $83 0
#muli $106 $105 4
#add $103 $103 $106
#lw $103 $103 0
#li $107 2
#mul $103 $103 $107
####move $108 $86
#lw $108 $86 0
####move $109 $82
#lw $109 $82 0
#muli $110 $109 4
#add $108 $108 $110
#lw $108 $108 0
#sub $103 $103 $108
#muli $104 $103 4
#add $102 $102 $104
#lw $102 $102 0
#beqz $102 l:10
#lw $111 $87 0
####move $112 $82
#lw $112 $82 0
#muli $113 $112 680
#add $111 $111 $113
####move $114 $83
#lw $114 $83 0
#muli $115 $114 4
#add $111 $111 $115
#sw $1 $0 -320
#lw $117 $87 0
#addi $118 $0 -324
#sw $117 $118 0
####move $119 $86
#addi $120 $0 -328
#lw $119 $86 0
#sw $119 $120 0
####move $121 $85
#addi $122 $0 -332
#lw $121 $85 0
#sw $121 $122 0
####move $123 $84
#addi $124 $0 -336
#lw $123 $84 0
#sw $123 $124 0
####move $125 $85
#lw $125 $85 0
####move $126 $86
#lw $126 $86 0
####move $128 $83
#lw $128 $83 0
#muli $129 $128 4
#add $126 $126 $129
#lw $126 $126 0
#li $130 2
#mul $126 $126 $130
####move $131 $86
#lw $131 $86 0
####move $132 $82
#lw $132 $82 0
#muli $133 $132 4
#add $131 $131 $133
#lw $131 $131 0
#sub $126 $126 $131
#muli $127 $126 4
#add $125 $125 $127
#addi $134 $0 -340
#lw $125 $125 0
#sw $125 $134 0
####move $135 $83
#addi $136 $0 -344
#lw $135 $83 0
#sw $135 $136 0
####move $137 $81
#addi $138 $0 -348
#lw $137 $81 0
#sw $137 $138 0
#addi $0 $0 -348
#call #getResult
#subi $0 $0 -348
#lw $1 $0 -320
#addi $139 $0 -316
####move $116 $139
#lw $116 $139 0
#li $140 1
#add $116 $116 $140
#sw $116 $111 0
#label l:10
#label l:9
#label l:8
#lw $141 $87 0
####move $142 $82
#lw $142 $82 0
#muli $143 $142 680
#add $141 $141 $143
####move $144 $83
#lw $144 $83 0
#muli $145 $144 4
#add $141 $141 $145
#lw $141 $141 0
#li $146 -1
#sub $146 $141 $146
#bnez $146 l:11
#lw $147 $87 0
####move $148 $82
#lw $148 $82 0
#muli $149 $148 680
#add $147 $147 $149
####move $150 $83
#lw $150 $83 0
#muli $151 $150 4
#add $147 $147 $151
#li $152 1
#sw $152 $147 0
#label l:11
#lw $153 $87 0
####move $154 $82
#lw $154 $82 0
#muli $155 $154 680
#add $153 $153 $155
####move $156 $83
#lw $156 $83 0
#muli $157 $156 4
#add $153 $153 $157
#addi $158 $0 32
#lw $153 $153 0
#sw $153 $158 0
#return
#return
#----------------------------
#func #printF
#addi $159 $0 0
#addi $160 $0 4
#addi $161 $0 8
#sw $1 $0 -136
####move $163 $159
#addi $164 $0 -140
#lw $163 $159 0
#sw $163 $164 0
#addi $0 $0 -140
#call #xprinti
#subi $0 $0 -140
#lw $1 $0 -136
#addi $165 $0 -132
#move $162 $165
#label l:12
####move $166 $161
#lw $166 $161 0
#li $167 0
#sub $167 $166 $167
#blez $167 l:13
#sw $1 $0 -136
#move $169 $170
#addi $171 $0 -140
#sw $169 $171 0
#addi $0 $0 -140
#call #xprint
#subi $0 $0 -140
#lw $1 $0 -136
#addi $172 $0 -132
#move $168 $172
#sw $1 $0 -136
####move $174 $160
#addi $175 $0 -140
#lw $174 $160 0
#sw $174 $175 0
#addi $0 $0 -140
#call #xprinti
#subi $0 $0 -140
#lw $1 $0 -136
#addi $176 $0 -132
#move $173 $176
#move $177 $160
####move $178 $160
#lw $178 $160 0
#li $179 2
#mul $178 $178 $179
####move $180 $159
#lw $180 $159 0
#sub $178 $178 $180
#sw $178 $177 0
#move $181 $159
####move $182 $159
#lw $182 $159 0
####move $183 $160
#lw $183 $160 0
#add $182 $182 $183
#li $184 2
#div $182 $182 $184
#sw $182 $181 0
#move $185 $161
####move $186 $161
#lw $186 $161 0
#li $187 1
#sub $186 $186 $187
#sw $186 $185 0
#goto l:12
#label l:13
#sw $1 $0 -136
#move $189 $190
#addi $191 $0 -140
#sw $189 $191 0
#addi $0 $0 -140
#call #xprint
#subi $0 $0 -140
#lw $1 $0 -136
#addi $192 $0 -132
####move $188 $192
#return
#----------------------------
#func #main
#move $193 $2
#li $194 1000
#sw $194 $193 0
#move $195 $3
#li $196 100
#addi $0 $0 -648
#call #getchar
#subi $0 $0 -648
#addi $198 $0 -644
####move $197 $198
#lw $197 $198 0
#li $199 48
#sub $197 $197 $199
#mul $196 $196 $197
#li $200 10
#addi $0 $0 -648
#call #getchar
#subi $0 $0 -648
#addi $202 $0 -644
####move $201 $202
#lw $201 $202 0
#li $203 48
#sub $201 $201 $203
#mul $200 $200 $201
#add $196 $196 $200
#addi $0 $0 -648
#call #getchar
#subi $0 $0 -648
#addi $205 $0 -644
####move $204 $205
#lw $204 $205 0
#add $196 $196 $204
#li $206 48
#sub $196 $196 $206
#sw $196 $195 0
#move $207 $6
#li $208 0
#sw $208 $207 0
#move $209 $7
#li $210 0
#sw $210 $209 0
####move $211 $11
#li $212 0
#muli $213 $212 4
#add $211 $11 $213
#li $214 0
#sw $214 $211 0
#move $215 $4
#li $216 0
#sw $216 $215 0
#label l:14
####move $217 $4
#lw $217 $4 0
####move $218 $2
#lw $218 $2 0
#li $219 1
#add $218 $218 $219
#sub $218 $217 $218
#bgez $218 l:15
####move $220 $8
####move $221 $4
#lw $221 $4 0
#muli $222 $221 4
#add $220 $8 $222
#li $223 1
#sw $223 $220 0
####move $224 $10
####move $225 $4
#lw $225 $4 0
#muli $226 $225 4
#add $224 $10 $226
#li $227 0
#sw $227 $224 0
#label l:16
#move $228 $4
####move $229 $4
#lw $229 $4 0
#li $230 1
#add $229 $229 $230
#sw $229 $228 0
#goto l:14
#label l:15
#move $231 $4
#li $232 0
#sw $232 $231 0
#label l:17
####move $233 $4
#lw $233 $4 0
####move $234 $3
#lw $234 $3 0
#li $235 1
#add $234 $234 $235
#sub $234 $233 $234
#bgez $234 l:18
####move $236 $9
####move $237 $4
#lw $237 $4 0
#muli $238 $237 4
#add $236 $9 $238
#li $239 0
#sw $239 $236 0
#label l:19
#move $240 $4
####move $241 $4
#lw $241 $4 0
#li $242 1
#add $241 $241 $242
#sw $241 $240 0
#goto l:17
#label l:18
#move $243 $4
#li $244 0
#sw $244 $243 0
#label l:20
####move $245 $4
#lw $245 $4 0
####move $246 $3
#lw $246 $3 0
#sub $246 $245 $246
#bgtz $246 l:21
#move $247 $5
#li $248 0
#sw $248 $247 0
#label l:23
####move $249 $5
#lw $249 $5 0
####move $250 $3
#lw $250 $3 0
#sub $250 $249 $250
#bgtz $250 l:24
####move $251 $12
####move $252 $4
#lw $252 $4 0
#muli $253 $252 680
#add $251 $12 $253
####move $254 $5
#lw $254 $5 0
#muli $255 $254 4
#add $251 $251 $255
#li $256 -1
#sw $256 $251 0
#label l:25
#move $257 $5
####move $258 $5
#lw $258 $5 0
#li $259 1
#add $258 $258 $259
#sw $258 $257 0
#goto l:23
#label l:24
#label l:22
#move $260 $4
####move $261 $4
#lw $261 $4 0
#li $262 1
#add $261 $261 $262
#sw $261 $260 0
#goto l:20
#label l:21
#move $264 $9
#addi $265 $0 -652
#sw $264 $265 0
#move $266 $10
#addi $267 $0 -656
#sw $266 $267 0
#move $268 $8
#addi $269 $0 -660
#sw $268 $269 0
#move $270 $11
#addi $271 $0 -664
#sw $270 $271 0
####move $272 $2
#addi $273 $0 -668
#lw $272 $2 0
#sw $272 $273 0
#addi $0 $0 -668
#call #getPrime
#subi $0 $0 -668
#addi $274 $0 -644
#move $263 $274
#move $275 $6
####move $276 $11
#li $277 0
#muli $278 $277 4
#add $276 $11 $278
#lw $276 $276 0
#sw $276 $275 0
#move $279 $4
#li $280 1
#sw $280 $279 0
#label l:26
####move $281 $4
#lw $281 $4 0
####move $282 $6
#lw $282 $6 0
#sub $282 $281 $282
#bgez $282 l:27
#move $283 $5
####move $284 $4
#lw $284 $4 0
#li $285 1
#add $284 $284 $285
#sw $284 $283 0
#label l:29
####move $286 $5
#lw $286 $5 0
####move $287 $6
#lw $287 $6 0
#sub $287 $286 $287
#bgtz $287 l:30
####move $288 $12
####move $289 $4
#lw $289 $4 0
#muli $290 $289 680
#add $288 $12 $290
####move $291 $5
#lw $291 $5 0
#muli $292 $291 4
#add $288 $288 $292
#lw $288 $288 0
#li $293 -1
#sub $293 $288 $293
#bnez $293 l:32
####move $294 $12
####move $295 $4
#lw $295 $4 0
#muli $296 $295 680
#add $294 $12 $296
####move $297 $5
#lw $297 $5 0
#muli $298 $297 4
#add $294 $294 $298
#move $300 $12
#addi $301 $0 -652
#sw $300 $301 0
#move $302 $9
#addi $303 $0 -656
#sw $302 $303 0
#move $304 $10
#addi $305 $0 -660
#sw $304 $305 0
#move $306 $8
#addi $307 $0 -664
#sw $306 $307 0
####move $308 $5
#addi $309 $0 -668
#lw $308 $5 0
#sw $308 $309 0
####move $310 $4
#addi $311 $0 -672
#lw $310 $4 0
#sw $310 $311 0
####move $312 $2
#addi $313 $0 -676
#lw $312 $2 0
#sw $312 $313 0
#addi $0 $0 -676
#call #getResult
#subi $0 $0 -676
#addi $314 $0 -644
####move $299 $314
#lw $299 $314 0
#sw $299 $294 0
####move $315 $12
####move $316 $4
#lw $316 $4 0
#muli $317 $316 680
#add $315 $12 $317
####move $318 $5
#lw $318 $5 0
#muli $319 $318 4
#add $315 $315 $319
#lw $315 $315 0
#li $320 1
#sub $320 $315 $320
#blez $320 l:33
####move $322 $12
####move $323 $4
#lw $323 $4 0
#muli $324 $323 680
#add $322 $12 $324
####move $325 $5
#lw $325 $5 0
#muli $326 $325 4
#add $322 $322 $326
#addi $327 $0 -652
#lw $322 $322 0
#sw $322 $327 0
####move $328 $9
####move $329 $5
#lw $329 $5 0
#muli $330 $329 4
#add $328 $9 $330
#addi $331 $0 -656
#lw $328 $328 0
#sw $328 $331 0
####move $332 $9
####move $333 $4
#lw $333 $4 0
#muli $334 $333 4
#add $332 $9 $334
#addi $335 $0 -660
#lw $332 $332 0
#sw $332 $335 0
#addi $0 $0 -660
#call #printF
#subi $0 $0 -660
#addi $336 $0 -644
#move $321 $336
#move $337 $7
####move $338 $7
#lw $338 $7 0
#li $339 1
#add $338 $338 $339
#sw $338 $337 0
#label l:33
#label l:32
#label l:31
#move $340 $5
####move $341 $5
#lw $341 $5 0
#li $342 1
#add $341 $341 $342
#sw $341 $340 0
#goto l:29
#label l:30
#label l:28
#move $343 $4
####move $344 $4
#lw $344 $4 0
#li $345 1
#add $344 $344 $345
#sw $344 $343 0
#goto l:26
#label l:27
####move $347 $7
#addi $348 $0 -648
#lw $347 $7 0
#sw $347 $348 0
#move $349 $350
#addi $351 $0 -652
#sw $349 $351 0
#addi $0 $0 -652
#call #printf
#subi $0 $0 -652
#li $352 0
#addi $353 $0 4
#sw $352 $353 0
#return
#return
