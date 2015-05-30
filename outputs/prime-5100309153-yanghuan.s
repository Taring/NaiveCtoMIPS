.data
temp: .space 1376
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
var11: .asciiz "%d"
.align 2
var12: .asciiz "%c"
.align 2
var13: .asciiz "Total: %d\n"
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
label0:
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
bgtz $8, label1
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
bnez $8, label3
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
label3:
label4:
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
bgtz $8, label5
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
j label4
label5:
lw $9, -24($sp)
move $8, $9
sw $8, -200($sp)
li $8, 2
sw $8, -204($sp)
lw $8, -204($sp)
lw $9, -200($sp)
sw $8, 0($9)
label2:
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
j label0
label1:
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
bnez $8, label6
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
bgtz $8, label7
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
beqz $8, label8
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
label8:
label7:
label6:
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
bnez $8, label9
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
label9:
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
sw $31, -148($29)
add $8, $29, -152
sw $8, -24($sp)
lw $9, -4($sp)
lw $8, 0($9)
sw $8, -20($sp)
lw $8, -20($sp)
lw $9, -24($sp)
sw $8, 0($9)
lw $9, 608($a3)
move $8, $9
sw $8, -28($sp)
add $8, $29, -156
sw $8, -32($sp)
lw $8, -28($sp)
lw $9, -32($sp)
sw $8, 0($9)
add $29, $29, -156
jal __printf
sub $29, $29, -156
lw $31, -148($29)
label10:
lw $9, -12($sp)
lw $8, 0($9)
sw $8, -36($sp)
li $8, 0
sw $8, -40($sp)
lw $9, -36($sp)
lw $10, -40($sp)
sub $8, $9, $10
sw $8, -40($sp)
lw $8, -40($sp)
blez $8, label11
sw $31, -148($29)
li $8, 32
sw $8, -48($sp)
add $8, $29, -152
sw $8, -52($sp)
lw $8, -48($sp)
lw $9, -52($sp)
sw $8, 0($9)
lw $9, 640($a3)
move $8, $9
sw $8, -56($sp)
add $8, $29, -156
sw $8, -60($sp)
lw $8, -56($sp)
lw $9, -60($sp)
sw $8, 0($9)
add $29, $29, -156
jal __printf
sub $29, $29, -156
lw $31, -148($29)
sw $31, -148($29)
add $8, $29, -152
sw $8, -72($sp)
lw $9, -8($sp)
lw $8, 0($9)
sw $8, -68($sp)
lw $8, -68($sp)
lw $9, -72($sp)
sw $8, 0($9)
lw $9, 608($a3)
move $8, $9
sw $8, -76($sp)
add $8, $29, -156
sw $8, -80($sp)
lw $8, -76($sp)
lw $9, -80($sp)
sw $8, 0($9)
add $29, $29, -156
jal __printf
sub $29, $29, -156
lw $31, -148($29)
lw $9, -8($sp)
move $8, $9
sw $8, -84($sp)
lw $9, -8($sp)
lw $8, 0($9)
sw $8, -88($sp)
li $8, 2
sw $8, -92($sp)
lw $9, -88($sp)
lw $10, -92($sp)
mul $8, $9, $10
sw $8, -88($sp)
lw $9, -4($sp)
lw $8, 0($9)
sw $8, -96($sp)
lw $9, -88($sp)
lw $10, -96($sp)
sub $8, $9, $10
sw $8, -88($sp)
lw $8, -88($sp)
lw $9, -84($sp)
sw $8, 0($9)
lw $9, -4($sp)
move $8, $9
sw $8, -100($sp)
lw $9, -4($sp)
lw $8, 0($9)
sw $8, -104($sp)
lw $9, -8($sp)
lw $8, 0($9)
sw $8, -108($sp)
lw $9, -104($sp)
lw $10, -108($sp)
add $8, $9, $10
sw $8, -104($sp)
li $8, 2
sw $8, -112($sp)
lw $9, -104($sp)
lw $10, -112($sp)
div $8, $9, $10
sw $8, -104($sp)
lw $8, -104($sp)
lw $9, -100($sp)
sw $8, 0($9)
lw $9, -12($sp)
move $8, $9
sw $8, -116($sp)
lw $9, -12($sp)
lw $8, 0($9)
sw $8, -120($sp)
li $8, 1
sw $8, -124($sp)
lw $9, -120($sp)
lw $10, -124($sp)
sub $8, $9, $10
sw $8, -120($sp)
lw $8, -120($sp)
lw $9, -116($sp)
sw $8, 0($9)
j label10
label11:
sw $31, -148($29)
li $8, 10
sw $8, -132($sp)
add $8, $29, -152
sw $8, -136($sp)
lw $8, -132($sp)
lw $9, -136($sp)
sw $8, 0($9)
lw $9, 640($a3)
move $8, $9
sw $8, -140($sp)
add $8, $29, -156
sw $8, -144($sp)
lw $8, -140($sp)
lw $9, -144($sp)
sw $8, 0($9)
add $29, $29, -156
jal __printf
sub $29, $29, -156
lw $31, -148($29)
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
sw $t0, 608($a3)
la $t0, var12
sw $t0, 640($a3)
la $t0, var13
sw $t0, 1360($a3)
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
label12:
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
bgez $8, label13
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
label14:
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
j label12
label13:
lw $9, 16($a3)
move $8, $9
sw $8, -156($sp)
li $8, 0
sw $8, -160($sp)
lw $8, -160($sp)
lw $9, -156($sp)
sw $8, 0($9)
label15:
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
bgez $8, label16
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
label17:
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
j label15
label16:
lw $9, 16($a3)
move $8, $9
sw $8, -204($sp)
li $8, 0
sw $8, -208($sp)
lw $8, -208($sp)
lw $9, -204($sp)
sw $8, 0($9)
label18:
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
bgtz $8, label19
lw $9, 20($a3)
move $8, $9
sw $8, -220($sp)
li $8, 0
sw $8, -224($sp)
lw $8, -224($sp)
lw $9, -220($sp)
sw $8, 0($9)
label21:
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
bgtz $8, label22
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
label23:
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
j label21
label22:
label20:
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
j label18
label19:
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
label24:
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
bgez $8, label25
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
label27:
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
bgtz $8, label28
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
bnez $8, label30
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
blez $8, label31
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
label31:
label30:
label29:
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
j label27
label28:
label26:
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
j label24
label25:
add $8, $29, -648
sw $8, -624($sp)
lw $9, 28($a3)
lw $8, 0($9)
sw $8, -620($sp)
lw $8, -620($sp)
lw $9, -624($sp)
sw $8, 0($9)
lw $9, 1360($a3)
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
#string $152 #%d
#string $160 #%c
#string $340 #Total: %d\n
#----------------------------
#func #getPrime
#addi $13 $0 0
#addi $14 $0 4
#addi $15 $0 8
#addi $16 $0 12
#addi $17 $0 16
#addi $19 $0 -220
#move $18 $19
#addi $21 $0 -224
#move $20 $21
#move $22 $19
#li $23 2
#sw $23 $22 0
#move $24 $21
#li $25 2
#sw $25 $24 0
#label l:0
####move $26 $20
#lw $26 $20 0
####move $27 $13
#lw $27 $13 0
#sub $27 $26 $27
#bgtz $27 l:1
####move $28 $15
#lw $28 $15 0
####move $29 $20
#lw $29 $20 0
#muli $30 $29 4
#add $28 $28 $30
#lw $28 $28 0
#li $31 1
#sub $31 $28 $31
#bnez $31 l:3
####move $32 $14
#lw $32 $14 0
#li $33 0
#muli $34 $33 4
#add $32 $32 $34
####move $35 $14
#lw $35 $14 0
#li $36 0
#muli $37 $36 4
#add $35 $35 $37
#lw $35 $35 0
#li $38 1
#add $35 $35 $38
#sw $35 $32 0
####move $39 $17
#lw $39 $17 0
####move $40 $14
#lw $40 $14 0
#li $42 0
#muli $43 $42 4
#add $40 $40 $43
#lw $40 $40 0
#muli $41 $40 4
#add $39 $39 $41
####move $44 $20
#lw $44 $20 0
#sw $44 $39 0
####move $45 $16
#lw $45 $16 0
####move $46 $20
#lw $46 $20 0
#muli $47 $46 4
#add $45 $45 $47
####move $48 $14
#lw $48 $14 0
#li $49 0
#muli $50 $49 4
#add $48 $48 $50
#lw $48 $48 0
#sw $48 $45 0
#label l:3
#label l:4
####move $51 $20
#lw $51 $20 0
####move $52 $18
#lw $52 $18 0
#mul $51 $51 $52
####move $53 $13
#lw $53 $13 0
#sub $53 $51 $53
#bgtz $53 l:5
####move $54 $15
#lw $54 $15 0
####move $55 $20
#lw $55 $20 0
####move $57 $18
#lw $57 $18 0
#mul $55 $55 $57
#muli $56 $55 4
#add $54 $54 $56
#li $58 0
#sw $58 $54 0
#move $59 $18
####move $60 $18
#lw $60 $18 0
#li $61 1
#add $60 $60 $61
#sw $60 $59 0
#goto l:4
#label l:5
#move $62 $18
#li $63 2
#sw $63 $62 0
#label l:2
#move $64 $20
####move $65 $20
#lw $65 $20 0
#li $66 1
#add $65 $65 $66
#sw $65 $64 0
#goto l:0
#label l:1
#return
#----------------------------
#func #getResult
#addi $67 $0 0
#addi $68 $0 4
#addi $69 $0 8
#addi $70 $0 12
#addi $71 $0 16
#addi $72 $0 20
#addi $73 $0 24
#lw $74 $73 0
####move $75 $68
#lw $75 $68 0
#muli $76 $75 680
#add $74 $74 $76
####move $77 $69
#lw $77 $69 0
#muli $78 $77 4
#add $74 $74 $78
#lw $74 $74 0
#li $79 -1
#sub $79 $74 $79
#bnez $79 l:6
####move $80 $72
#lw $80 $72 0
####move $81 $69
#lw $81 $69 0
#muli $82 $81 4
#add $80 $80 $82
#lw $80 $80 0
#li $83 2
#mul $80 $80 $83
####move $84 $72
#lw $84 $72 0
####move $85 $68
#lw $85 $68 0
#muli $86 $85 4
#add $84 $84 $86
#lw $84 $84 0
#sub $80 $80 $84
####move $87 $67
#lw $87 $67 0
#sub $87 $80 $87
#bgtz $87 l:7
####move $88 $70
#lw $88 $70 0
####move $89 $72
#lw $89 $72 0
####move $91 $69
#lw $91 $69 0
#muli $92 $91 4
#add $89 $89 $92
#lw $89 $89 0
#li $93 2
#mul $89 $89 $93
####move $94 $72
#lw $94 $72 0
####move $95 $68
#lw $95 $68 0
#muli $96 $95 4
#add $94 $94 $96
#lw $94 $94 0
#sub $89 $89 $94
#muli $90 $89 4
#add $88 $88 $90
#lw $88 $88 0
#beqz $88 l:8
#lw $97 $73 0
####move $98 $68
#lw $98 $68 0
#muli $99 $98 680
#add $97 $97 $99
####move $100 $69
#lw $100 $69 0
#muli $101 $100 4
#add $97 $97 $101
#sw $1 $0 -320
#lw $103 $73 0
#addi $104 $0 -324
#sw $103 $104 0
####move $105 $72
#addi $106 $0 -328
#lw $105 $72 0
#sw $105 $106 0
####move $107 $71
#addi $108 $0 -332
#lw $107 $71 0
#sw $107 $108 0
####move $109 $70
#addi $110 $0 -336
#lw $109 $70 0
#sw $109 $110 0
####move $111 $71
#lw $111 $71 0
####move $112 $72
#lw $112 $72 0
####move $114 $69
#lw $114 $69 0
#muli $115 $114 4
#add $112 $112 $115
#lw $112 $112 0
#li $116 2
#mul $112 $112 $116
####move $117 $72
#lw $117 $72 0
####move $118 $68
#lw $118 $68 0
#muli $119 $118 4
#add $117 $117 $119
#lw $117 $117 0
#sub $112 $112 $117
#muli $113 $112 4
#add $111 $111 $113
#addi $120 $0 -340
#lw $111 $111 0
#sw $111 $120 0
####move $121 $69
#addi $122 $0 -344
#lw $121 $69 0
#sw $121 $122 0
####move $123 $67
#addi $124 $0 -348
#lw $123 $67 0
#sw $123 $124 0
#addi $0 $0 -348
#call #getResult
#subi $0 $0 -348
#lw $1 $0 -320
#addi $125 $0 -316
####move $102 $125
#lw $102 $125 0
#li $126 1
#add $102 $102 $126
#sw $102 $97 0
#label l:8
#label l:7
#label l:6
#lw $127 $73 0
####move $128 $68
#lw $128 $68 0
#muli $129 $128 680
#add $127 $127 $129
####move $130 $69
#lw $130 $69 0
#muli $131 $130 4
#add $127 $127 $131
#lw $127 $127 0
#li $132 -1
#sub $132 $127 $132
#bnez $132 l:9
#lw $133 $73 0
####move $134 $68
#lw $134 $68 0
#muli $135 $134 680
#add $133 $133 $135
####move $136 $69
#lw $136 $69 0
#muli $137 $136 4
#add $133 $133 $137
#li $138 1
#sw $138 $133 0
#label l:9
#lw $139 $73 0
####move $140 $68
#lw $140 $68 0
#muli $141 $140 680
#add $139 $139 $141
####move $142 $69
#lw $142 $69 0
#muli $143 $142 4
#add $139 $139 $143
#addi $144 $0 32
#lw $139 $139 0
#sw $139 $144 0
#return
#return
#----------------------------
#func #printF
#addi $145 $0 0
#addi $146 $0 4
#addi $147 $0 8
#sw $1 $0 -148
####move $149 $145
#addi $150 $0 -152
#lw $149 $145 0
#sw $149 $150 0
#move $151 $152
#addi $153 $0 -156
#sw $151 $153 0
#addi $0 $0 -156
#call #printf
#subi $0 $0 -156
#lw $1 $0 -148
#label l:10
####move $154 $147
#lw $154 $147 0
#li $155 0
#sub $155 $154 $155
#blez $155 l:11
#sw $1 $0 -148
#li $157 32
#addi $158 $0 -152
#sw $157 $158 0
#move $159 $160
#addi $161 $0 -156
#sw $159 $161 0
#addi $0 $0 -156
#call #printf
#subi $0 $0 -156
#lw $1 $0 -148
#sw $1 $0 -148
####move $163 $146
#addi $164 $0 -152
#lw $163 $146 0
#sw $163 $164 0
#move $165 $152
#addi $166 $0 -156
#sw $165 $166 0
#addi $0 $0 -156
#call #printf
#subi $0 $0 -156
#lw $1 $0 -148
#move $167 $146
####move $168 $146
#lw $168 $146 0
#li $169 2
#mul $168 $168 $169
####move $170 $145
#lw $170 $145 0
#sub $168 $168 $170
#sw $168 $167 0
#move $171 $145
####move $172 $145
#lw $172 $145 0
####move $173 $146
#lw $173 $146 0
#add $172 $172 $173
#li $174 2
#div $172 $172 $174
#sw $172 $171 0
#move $175 $147
####move $176 $147
#lw $176 $147 0
#li $177 1
#sub $176 $176 $177
#sw $176 $175 0
#goto l:10
#label l:11
#sw $1 $0 -148
#li $179 10
#addi $180 $0 -152
#sw $179 $180 0
#move $181 $160
#addi $182 $0 -156
#sw $181 $182 0
#addi $0 $0 -156
#call #printf
#subi $0 $0 -156
#lw $1 $0 -148
#return
#----------------------------
#func #main
#move $183 $2
#li $184 1000
#sw $184 $183 0
#move $185 $3
#li $186 100
#addi $0 $0 -648
#call #getchar
#subi $0 $0 -648
#addi $188 $0 -644
####move $187 $188
#lw $187 $188 0
#li $189 48
#sub $187 $187 $189
#mul $186 $186 $187
#li $190 10
#addi $0 $0 -648
#call #getchar
#subi $0 $0 -648
#addi $192 $0 -644
####move $191 $192
#lw $191 $192 0
#li $193 48
#sub $191 $191 $193
#mul $190 $190 $191
#add $186 $186 $190
#addi $0 $0 -648
#call #getchar
#subi $0 $0 -648
#addi $195 $0 -644
####move $194 $195
#lw $194 $195 0
#add $186 $186 $194
#li $196 48
#sub $186 $186 $196
#sw $186 $185 0
#move $197 $6
#li $198 0
#sw $198 $197 0
#move $199 $7
#li $200 0
#sw $200 $199 0
####move $201 $11
#li $202 0
#muli $203 $202 4
#add $201 $11 $203
#li $204 0
#sw $204 $201 0
#move $205 $4
#li $206 0
#sw $206 $205 0
#label l:12
####move $207 $4
#lw $207 $4 0
####move $208 $2
#lw $208 $2 0
#li $209 1
#add $208 $208 $209
#sub $208 $207 $208
#bgez $208 l:13
####move $210 $8
####move $211 $4
#lw $211 $4 0
#muli $212 $211 4
#add $210 $8 $212
#li $213 1
#sw $213 $210 0
####move $214 $10
####move $215 $4
#lw $215 $4 0
#muli $216 $215 4
#add $214 $10 $216
#li $217 0
#sw $217 $214 0
#label l:14
#move $218 $4
####move $219 $4
#lw $219 $4 0
#li $220 1
#add $219 $219 $220
#sw $219 $218 0
#goto l:12
#label l:13
#move $221 $4
#li $222 0
#sw $222 $221 0
#label l:15
####move $223 $4
#lw $223 $4 0
####move $224 $3
#lw $224 $3 0
#li $225 1
#add $224 $224 $225
#sub $224 $223 $224
#bgez $224 l:16
####move $226 $9
####move $227 $4
#lw $227 $4 0
#muli $228 $227 4
#add $226 $9 $228
#li $229 0
#sw $229 $226 0
#label l:17
#move $230 $4
####move $231 $4
#lw $231 $4 0
#li $232 1
#add $231 $231 $232
#sw $231 $230 0
#goto l:15
#label l:16
#move $233 $4
#li $234 0
#sw $234 $233 0
#label l:18
####move $235 $4
#lw $235 $4 0
####move $236 $3
#lw $236 $3 0
#sub $236 $235 $236
#bgtz $236 l:19
#move $237 $5
#li $238 0
#sw $238 $237 0
#label l:21
####move $239 $5
#lw $239 $5 0
####move $240 $3
#lw $240 $3 0
#sub $240 $239 $240
#bgtz $240 l:22
####move $241 $12
####move $242 $4
#lw $242 $4 0
#muli $243 $242 680
#add $241 $12 $243
####move $244 $5
#lw $244 $5 0
#muli $245 $244 4
#add $241 $241 $245
#li $246 -1
#sw $246 $241 0
#label l:23
#move $247 $5
####move $248 $5
#lw $248 $5 0
#li $249 1
#add $248 $248 $249
#sw $248 $247 0
#goto l:21
#label l:22
#label l:20
#move $250 $4
####move $251 $4
#lw $251 $4 0
#li $252 1
#add $251 $251 $252
#sw $251 $250 0
#goto l:18
#label l:19
#move $254 $9
#addi $255 $0 -652
#sw $254 $255 0
#move $256 $10
#addi $257 $0 -656
#sw $256 $257 0
#move $258 $8
#addi $259 $0 -660
#sw $258 $259 0
#move $260 $11
#addi $261 $0 -664
#sw $260 $261 0
####move $262 $2
#addi $263 $0 -668
#lw $262 $2 0
#sw $262 $263 0
#addi $0 $0 -668
#call #getPrime
#subi $0 $0 -668
#addi $264 $0 -644
#move $253 $264
#move $265 $6
####move $266 $11
#li $267 0
#muli $268 $267 4
#add $266 $11 $268
#lw $266 $266 0
#sw $266 $265 0
#move $269 $4
#li $270 1
#sw $270 $269 0
#label l:24
####move $271 $4
#lw $271 $4 0
####move $272 $6
#lw $272 $6 0
#sub $272 $271 $272
#bgez $272 l:25
#move $273 $5
####move $274 $4
#lw $274 $4 0
#li $275 1
#add $274 $274 $275
#sw $274 $273 0
#label l:27
####move $276 $5
#lw $276 $5 0
####move $277 $6
#lw $277 $6 0
#sub $277 $276 $277
#bgtz $277 l:28
####move $278 $12
####move $279 $4
#lw $279 $4 0
#muli $280 $279 680
#add $278 $12 $280
####move $281 $5
#lw $281 $5 0
#muli $282 $281 4
#add $278 $278 $282
#lw $278 $278 0
#li $283 -1
#sub $283 $278 $283
#bnez $283 l:30
####move $284 $12
####move $285 $4
#lw $285 $4 0
#muli $286 $285 680
#add $284 $12 $286
####move $287 $5
#lw $287 $5 0
#muli $288 $287 4
#add $284 $284 $288
#move $290 $12
#addi $291 $0 -652
#sw $290 $291 0
#move $292 $9
#addi $293 $0 -656
#sw $292 $293 0
#move $294 $10
#addi $295 $0 -660
#sw $294 $295 0
#move $296 $8
#addi $297 $0 -664
#sw $296 $297 0
####move $298 $5
#addi $299 $0 -668
#lw $298 $5 0
#sw $298 $299 0
####move $300 $4
#addi $301 $0 -672
#lw $300 $4 0
#sw $300 $301 0
####move $302 $2
#addi $303 $0 -676
#lw $302 $2 0
#sw $302 $303 0
#addi $0 $0 -676
#call #getResult
#subi $0 $0 -676
#addi $304 $0 -644
####move $289 $304
#lw $289 $304 0
#sw $289 $284 0
####move $305 $12
####move $306 $4
#lw $306 $4 0
#muli $307 $306 680
#add $305 $12 $307
####move $308 $5
#lw $308 $5 0
#muli $309 $308 4
#add $305 $305 $309
#lw $305 $305 0
#li $310 1
#sub $310 $305 $310
#blez $310 l:31
####move $312 $12
####move $313 $4
#lw $313 $4 0
#muli $314 $313 680
#add $312 $12 $314
####move $315 $5
#lw $315 $5 0
#muli $316 $315 4
#add $312 $312 $316
#addi $317 $0 -652
#lw $312 $312 0
#sw $312 $317 0
####move $318 $9
####move $319 $5
#lw $319 $5 0
#muli $320 $319 4
#add $318 $9 $320
#addi $321 $0 -656
#lw $318 $318 0
#sw $318 $321 0
####move $322 $9
####move $323 $4
#lw $323 $4 0
#muli $324 $323 4
#add $322 $9 $324
#addi $325 $0 -660
#lw $322 $322 0
#sw $322 $325 0
#addi $0 $0 -660
#call #printF
#subi $0 $0 -660
#addi $326 $0 -644
#move $311 $326
#move $327 $7
####move $328 $7
#lw $328 $7 0
#li $329 1
#add $328 $328 $329
#sw $328 $327 0
#label l:31
#label l:30
#label l:29
#move $330 $5
####move $331 $5
#lw $331 $5 0
#li $332 1
#add $331 $331 $332
#sw $331 $330 0
#goto l:27
#label l:28
#label l:26
#move $333 $4
####move $334 $4
#lw $334 $4 0
#li $335 1
#add $334 $334 $335
#sw $334 $333 0
#goto l:24
#label l:25
####move $337 $7
#addi $338 $0 -648
#lw $337 $7 0
#sw $337 $338 0
#move $339 $340
#addi $341 $0 -652
#sw $339 $341 0
#addi $0 $0 -652
#call #printf
#subi $0 $0 -652
#li $342 0
#addi $343 $0 4
#sw $342 $343 0
#return
#return
