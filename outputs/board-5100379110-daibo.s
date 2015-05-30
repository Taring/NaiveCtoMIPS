.data
temp: .space 1172
var0: .space 4
var1: .space 4
var2: .space 4
var3: .asciiz "%d "
.align 2
var4: .asciiz "\n"
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

__printBoard:
add $8, $29, 0
sw $8, -4($sp)
add $8, $29, 4
sw $8, -8($sp)
add $8, $29, -140
sw $8, -16($sp)
lw $9, -16($sp)
move $8, $9
sw $8, -12($sp)
add $8, $29, -144
sw $8, -24($sp)
lw $9, -24($sp)
move $8, $9
sw $8, -20($sp)
lw $9, -16($sp)
move $8, $9
sw $8, -28($sp)
li $8, 0
sw $8, -32($sp)
lw $8, -32($sp)
lw $9, -28($sp)
sw $8, 0($9)
label0:
lw $9, -12($sp)
lw $8, 0($9)
sw $8, -36($sp)
lw $9, -4($sp)
lw $8, 0($9)
sw $8, -40($sp)
lw $9, -36($sp)
lw $10, -40($sp)
sub $8, $9, $10
sw $8, -40($sp)
lw $8, -40($sp)
bgez $8, label1
lw $9, -20($sp)
move $8, $9
sw $8, -44($sp)
li $8, 0
sw $8, -48($sp)
lw $8, -48($sp)
lw $9, -44($sp)
sw $8, 0($9)
label3:
lw $9, -20($sp)
lw $8, 0($9)
sw $8, -52($sp)
lw $9, -4($sp)
lw $8, 0($9)
sw $8, -56($sp)
lw $9, -52($sp)
lw $10, -56($sp)
sub $8, $9, $10
sw $8, -56($sp)
lw $8, -56($sp)
bgez $8, label4
sw $31, -148($29)
lw $9, -8($sp)
lw $8, 0($9)
sw $8, -64($sp)
lw $9, -12($sp)
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
add $8, $29, -152
sw $8, -84($sp)
lw $9, -64($sp)
lw $8, 0($9)
sw $8, -64($sp)
lw $8, -64($sp)
lw $9, -84($sp)
sw $8, 0($9)
lw $9, 108($a3)
move $8, $9
sw $8, -88($sp)
add $8, $29, -156
sw $8, -92($sp)
lw $8, -88($sp)
lw $9, -92($sp)
sw $8, 0($9)
add $29, $29, -156
jal __printf
sub $29, $29, -156
lw $31, -148($29)
label5:
lw $9, -20($sp)
move $8, $9
sw $8, -100($sp)
lw $9, -20($sp)
lw $8, 0($9)
sw $8, -96($sp)
lw $9, -96($sp)
add $8, $9, 1
sw $8, -104($sp)
lw $8, -104($sp)
lw $9, -100($sp)
sw $8, 0($9)
j label3
label4:
sw $31, -148($29)
lw $9, 136($a3)
move $8, $9
sw $8, -112($sp)
add $8, $29, -152
sw $8, -116($sp)
lw $8, -112($sp)
lw $9, -116($sp)
sw $8, 0($9)
add $29, $29, -152
jal __printf_single
sub $29, $29, -152
lw $31, -148($29)
label2:
lw $9, -12($sp)
move $8, $9
sw $8, -124($sp)
lw $9, -12($sp)
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
li $8, 0
sw $8, -132($sp)
add $8, $29, 12
sw $8, -136($sp)
lw $8, -132($sp)
lw $9, -136($sp)
sw $8, 0($9)
jr $ra
jr $ra
__inRect:
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
lw $9, -4($sp)
lw $8, 0($9)
sw $8, -28($sp)
lw $9, -12($sp)
lw $8, 0($9)
sw $8, -32($sp)
lw $9, -28($sp)
lw $10, -32($sp)
sub $8, $9, $10
sw $8, -32($sp)
li $8, 1
sw $8, -28($sp)
lw $8, -32($sp)
bgez $8, label6
li $8, 0
sw $8, -28($sp)
label6:
lw $8, -28($sp)
beqz $8, label7
lw $9, -4($sp)
lw $8, 0($9)
sw $8, -28($sp)
lw $9, -20($sp)
lw $8, 0($9)
sw $8, -36($sp)
lw $9, -28($sp)
lw $10, -36($sp)
sub $8, $9, $10
sw $8, -36($sp)
li $8, 1
sw $8, -28($sp)
lw $8, -36($sp)
bltz $8, label8
li $8, 0
sw $8, -28($sp)
label8:
label7:
lw $9, -28($sp)
andi $8, $9, 1
sw $8, -28($sp)
lw $8, -28($sp)
beqz $8, label9
lw $9, -8($sp)
lw $8, 0($9)
sw $8, -28($sp)
lw $9, -16($sp)
lw $8, 0($9)
sw $8, -40($sp)
lw $9, -28($sp)
lw $10, -40($sp)
sub $8, $9, $10
sw $8, -40($sp)
li $8, 1
sw $8, -28($sp)
lw $8, -40($sp)
bgez $8, label10
li $8, 0
sw $8, -28($sp)
label10:
label9:
lw $9, -28($sp)
andi $8, $9, 1
sw $8, -28($sp)
lw $8, -28($sp)
beqz $8, label11
lw $9, -8($sp)
lw $8, 0($9)
sw $8, -28($sp)
lw $9, -24($sp)
lw $8, 0($9)
sw $8, -44($sp)
lw $9, -28($sp)
lw $10, -44($sp)
sub $8, $9, $10
sw $8, -44($sp)
li $8, 1
sw $8, -28($sp)
lw $8, -44($sp)
bltz $8, label12
li $8, 0
sw $8, -28($sp)
label12:
label11:
lw $9, -28($sp)
andi $8, $9, 1
sw $8, -28($sp)
add $8, $29, 28
sw $8, -48($sp)
lw $8, -28($sp)
lw $9, -48($sp)
sw $8, 0($9)
jr $ra
jr $ra
__fill:
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
add $8, $29, 28
sw $8, -32($sp)
add $8, $29, 32
sw $8, -36($sp)
lw $9, -8($sp)
lw $8, 0($9)
sw $8, -40($sp)
li $8, 0
sw $8, -44($sp)
lw $9, -40($sp)
lw $10, -44($sp)
sub $8, $9, $10
sw $8, -44($sp)
lw $8, -44($sp)
bnez $8, label13
lw $9, -4($sp)
lw $8, 0($9)
sw $8, -48($sp)
lw $9, -20($sp)
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
lw $9, -24($sp)
lw $8, 0($9)
sw $8, -60($sp)
lw $9, -60($sp)
mul $8, $9, 4
sw $8, -64($sp)
lw $9, -48($sp)
lw $10, -64($sp)
add $8, $9, $10
sw $8, -48($sp)
lw $9, -28($sp)
lw $8, 0($9)
sw $8, -68($sp)
lw $8, -68($sp)
lw $9, -48($sp)
sw $8, 0($9)
j label14
label13:
add $8, $29, -584
sw $8, -76($sp)
lw $9, -76($sp)
move $8, $9
sw $8, -72($sp)
add $8, $29, -588
sw $8, -84($sp)
lw $9, -84($sp)
move $8, $9
sw $8, -80($sp)
add $8, $29, -592
sw $8, -92($sp)
lw $9, -92($sp)
move $8, $9
sw $8, -88($sp)
add $8, $29, -596
sw $8, -100($sp)
lw $9, -100($sp)
move $8, $9
sw $8, -96($sp)
add $8, $29, -600
sw $8, -108($sp)
lw $9, -108($sp)
move $8, $9
sw $8, -104($sp)
add $8, $29, -604
sw $8, -116($sp)
lw $9, -116($sp)
move $8, $9
sw $8, -112($sp)
add $8, $29, -608
sw $8, -124($sp)
lw $9, -124($sp)
move $8, $9
sw $8, -120($sp)
add $8, $29, -612
sw $8, -132($sp)
lw $9, -132($sp)
move $8, $9
sw $8, -128($sp)
lw $9, -76($sp)
move $8, $9
sw $8, -136($sp)
lw $9, -32($sp)
lw $8, 0($9)
sw $8, -140($sp)
lw $9, -8($sp)
lw $8, 0($9)
sw $8, -144($sp)
li $8, 1
sw $8, -152($sp)
lw $9, -144($sp)
lw $10, -152($sp)
sub $8, $9, $10
sw $8, -144($sp)
lw $9, -144($sp)
mul $8, $9, 4
sw $8, -148($sp)
lw $9, -140($sp)
lw $10, -148($sp)
add $8, $9, $10
sw $8, -140($sp)
lw $9, -140($sp)
lw $8, 0($9)
sw $8, -140($sp)
lw $8, -140($sp)
lw $9, -136($sp)
sw $8, 0($9)
lw $9, -84($sp)
move $8, $9
sw $8, -156($sp)
lw $9, -36($sp)
lw $8, 0($9)
sw $8, -160($sp)
lw $8, -160($sp)
lw $9, -156($sp)
sw $8, 0($9)
lw $9, -92($sp)
move $8, $9
sw $8, -164($sp)
lw $9, -100($sp)
move $8, $9
sw $8, -168($sp)
lw $9, -108($sp)
move $8, $9
sw $8, -172($sp)
lw $9, -116($sp)
move $8, $9
sw $8, -176($sp)
li $8, 0
sw $8, -180($sp)
lw $8, -180($sp)
lw $9, -176($sp)
sw $8, 0($9)
lw $9, -176($sp)
lw $8, 0($9)
sw $8, -176($sp)
lw $8, -176($sp)
lw $9, -172($sp)
sw $8, 0($9)
lw $9, -172($sp)
lw $8, 0($9)
sw $8, -172($sp)
lw $8, -172($sp)
lw $9, -168($sp)
sw $8, 0($9)
lw $9, -168($sp)
lw $8, 0($9)
sw $8, -168($sp)
lw $8, -168($sp)
lw $9, -164($sp)
sw $8, 0($9)
lw $9, -36($sp)
move $8, $9
sw $8, -188($sp)
lw $9, -36($sp)
lw $8, 0($9)
sw $8, -184($sp)
lw $9, -184($sp)
add $8, $9, 1
sw $8, -192($sp)
lw $8, -192($sp)
lw $9, -188($sp)
sw $8, 0($9)
lw $9, -124($sp)
move $8, $9
sw $8, -196($sp)
li $8, 0
sw $8, -200($sp)
lw $8, -200($sp)
lw $9, -196($sp)
sw $8, 0($9)
label15:
lw $9, -120($sp)
lw $8, 0($9)
sw $8, -204($sp)
li $8, 1
sw $8, -208($sp)
lw $9, -204($sp)
lw $10, -208($sp)
sub $8, $9, $10
sw $8, -208($sp)
lw $8, -208($sp)
bgtz $8, label16
lw $9, -128($sp)
move $8, $9
sw $8, -212($sp)
li $8, 0
sw $8, -216($sp)
lw $8, -216($sp)
lw $9, -212($sp)
sw $8, 0($9)
label18:
lw $9, -128($sp)
lw $8, 0($9)
sw $8, -220($sp)
li $8, 1
sw $8, -224($sp)
lw $9, -220($sp)
lw $10, -224($sp)
sub $8, $9, $10
sw $8, -224($sp)
lw $8, -224($sp)
bgtz $8, label19
lw $9, -88($sp)
move $8, $9
sw $8, -228($sp)
lw $9, -12($sp)
lw $8, 0($9)
sw $8, -232($sp)
lw $9, -120($sp)
lw $8, 0($9)
sw $8, -236($sp)
lw $9, -72($sp)
lw $8, 0($9)
sw $8, -240($sp)
lw $9, -236($sp)
lw $10, -240($sp)
mul $8, $9, $10
sw $8, -236($sp)
lw $9, -232($sp)
lw $10, -236($sp)
add $8, $9, $10
sw $8, -232($sp)
lw $8, -232($sp)
lw $9, -228($sp)
sw $8, 0($9)
lw $9, -96($sp)
move $8, $9
sw $8, -244($sp)
lw $9, -16($sp)
lw $8, 0($9)
sw $8, -248($sp)
lw $9, -128($sp)
lw $8, 0($9)
sw $8, -252($sp)
lw $9, -72($sp)
lw $8, 0($9)
sw $8, -256($sp)
lw $9, -252($sp)
lw $10, -256($sp)
mul $8, $9, $10
sw $8, -252($sp)
lw $9, -248($sp)
lw $10, -252($sp)
add $8, $9, $10
sw $8, -248($sp)
lw $8, -248($sp)
lw $9, -244($sp)
sw $8, 0($9)
lw $9, -104($sp)
move $8, $9
sw $8, -260($sp)
lw $9, -12($sp)
lw $8, 0($9)
sw $8, -264($sp)
lw $9, -120($sp)
lw $8, 0($9)
sw $8, -268($sp)
li $8, 1
sw $8, -272($sp)
lw $9, -268($sp)
lw $10, -272($sp)
add $8, $9, $10
sw $8, -268($sp)
lw $9, -72($sp)
lw $8, 0($9)
sw $8, -276($sp)
lw $9, -268($sp)
lw $10, -276($sp)
mul $8, $9, $10
sw $8, -268($sp)
lw $9, -264($sp)
lw $10, -268($sp)
add $8, $9, $10
sw $8, -264($sp)
lw $8, -264($sp)
lw $9, -260($sp)
sw $8, 0($9)
lw $9, -112($sp)
move $8, $9
sw $8, -280($sp)
lw $9, -16($sp)
lw $8, 0($9)
sw $8, -284($sp)
lw $9, -128($sp)
lw $8, 0($9)
sw $8, -288($sp)
li $8, 1
sw $8, -292($sp)
lw $9, -288($sp)
lw $10, -292($sp)
add $8, $9, $10
sw $8, -288($sp)
lw $9, -72($sp)
lw $8, 0($9)
sw $8, -296($sp)
lw $9, -288($sp)
lw $10, -296($sp)
mul $8, $9, $10
sw $8, -288($sp)
lw $9, -284($sp)
lw $10, -288($sp)
add $8, $9, $10
sw $8, -284($sp)
lw $8, -284($sp)
lw $9, -280($sp)
sw $8, 0($9)
sw $31, -620($29)
add $8, $29, -624
sw $8, -308($sp)
lw $9, -112($sp)
lw $8, 0($9)
sw $8, -304($sp)
lw $8, -304($sp)
lw $9, -308($sp)
sw $8, 0($9)
add $8, $29, -628
sw $8, -316($sp)
lw $9, -104($sp)
lw $8, 0($9)
sw $8, -312($sp)
lw $8, -312($sp)
lw $9, -316($sp)
sw $8, 0($9)
add $8, $29, -632
sw $8, -324($sp)
lw $9, -96($sp)
lw $8, 0($9)
sw $8, -320($sp)
lw $8, -320($sp)
lw $9, -324($sp)
sw $8, 0($9)
add $8, $29, -636
sw $8, -332($sp)
lw $9, -88($sp)
lw $8, 0($9)
sw $8, -328($sp)
lw $8, -328($sp)
lw $9, -332($sp)
sw $8, 0($9)
add $8, $29, -640
sw $8, -340($sp)
lw $9, -24($sp)
lw $8, 0($9)
sw $8, -336($sp)
lw $8, -336($sp)
lw $9, -340($sp)
sw $8, 0($9)
add $8, $29, -644
sw $8, -348($sp)
lw $9, -20($sp)
lw $8, 0($9)
sw $8, -344($sp)
lw $8, -344($sp)
lw $9, -348($sp)
sw $8, 0($9)
add $29, $29, -644
jal __inRect
sub $29, $29, -644
lw $31, -620($29)
add $8, $29, -616
sw $8, -352($sp)
lw $9, -352($sp)
lw $8, 0($9)
sw $8, -300($sp)
lw $8, -300($sp)
beqz $8, label21
lw $9, -36($sp)
move $8, $9
sw $8, -356($sp)
sw $31, -620($29)
add $8, $29, -624
sw $8, -368($sp)
lw $9, -36($sp)
lw $8, 0($9)
sw $8, -364($sp)
lw $8, -364($sp)
lw $9, -368($sp)
sw $8, 0($9)
add $8, $29, -628
sw $8, -376($sp)
lw $9, -32($sp)
lw $8, 0($9)
sw $8, -372($sp)
lw $8, -372($sp)
lw $9, -376($sp)
sw $8, 0($9)
add $8, $29, -632
sw $8, -384($sp)
lw $9, -28($sp)
lw $8, 0($9)
sw $8, -380($sp)
lw $8, -380($sp)
lw $9, -384($sp)
sw $8, 0($9)
add $8, $29, -636
sw $8, -392($sp)
lw $9, -24($sp)
lw $8, 0($9)
sw $8, -388($sp)
lw $8, -388($sp)
lw $9, -392($sp)
sw $8, 0($9)
add $8, $29, -640
sw $8, -400($sp)
lw $9, -20($sp)
lw $8, 0($9)
sw $8, -396($sp)
lw $8, -396($sp)
lw $9, -400($sp)
sw $8, 0($9)
add $8, $29, -644
sw $8, -408($sp)
lw $9, -96($sp)
lw $8, 0($9)
sw $8, -404($sp)
lw $8, -404($sp)
lw $9, -408($sp)
sw $8, 0($9)
add $8, $29, -648
sw $8, -416($sp)
lw $9, -88($sp)
lw $8, 0($9)
sw $8, -412($sp)
lw $8, -412($sp)
lw $9, -416($sp)
sw $8, 0($9)
lw $9, -8($sp)
lw $8, 0($9)
sw $8, -420($sp)
li $8, 1
sw $8, -424($sp)
lw $9, -420($sp)
lw $10, -424($sp)
sub $8, $9, $10
sw $8, -420($sp)
add $8, $29, -652
sw $8, -428($sp)
lw $8, -420($sp)
lw $9, -428($sp)
sw $8, 0($9)
add $8, $29, -656
sw $8, -436($sp)
lw $9, -4($sp)
lw $8, 0($9)
sw $8, -432($sp)
lw $8, -432($sp)
lw $9, -436($sp)
sw $8, 0($9)
add $29, $29, -656
jal __fill
sub $29, $29, -656
lw $31, -620($29)
add $8, $29, -616
sw $8, -440($sp)
lw $9, -440($sp)
lw $8, 0($9)
sw $8, -360($sp)
lw $8, -360($sp)
lw $9, -356($sp)
sw $8, 0($9)
j label22
label21:
lw $9, -36($sp)
move $8, $9
sw $8, -444($sp)
sw $31, -620($29)
add $8, $29, -624
sw $8, -456($sp)
lw $9, -36($sp)
lw $8, 0($9)
sw $8, -452($sp)
lw $8, -452($sp)
lw $9, -456($sp)
sw $8, 0($9)
add $8, $29, -628
sw $8, -464($sp)
lw $9, -32($sp)
lw $8, 0($9)
sw $8, -460($sp)
lw $8, -460($sp)
lw $9, -464($sp)
sw $8, 0($9)
add $8, $29, -632
sw $8, -472($sp)
lw $9, -80($sp)
lw $8, 0($9)
sw $8, -468($sp)
lw $8, -468($sp)
lw $9, -472($sp)
sw $8, 0($9)
lw $9, -16($sp)
lw $8, 0($9)
sw $8, -476($sp)
lw $9, -72($sp)
lw $8, 0($9)
sw $8, -480($sp)
lw $9, -476($sp)
lw $10, -480($sp)
add $8, $9, $10
sw $8, -476($sp)
li $8, 1
sw $8, -484($sp)
lw $9, -476($sp)
lw $10, -484($sp)
sub $8, $9, $10
sw $8, -476($sp)
lw $9, -128($sp)
lw $8, 0($9)
sw $8, -488($sp)
lw $9, -476($sp)
lw $10, -488($sp)
add $8, $9, $10
sw $8, -476($sp)
add $8, $29, -636
sw $8, -492($sp)
lw $8, -476($sp)
lw $9, -492($sp)
sw $8, 0($9)
lw $9, -12($sp)
lw $8, 0($9)
sw $8, -496($sp)
lw $9, -72($sp)
lw $8, 0($9)
sw $8, -500($sp)
lw $9, -496($sp)
lw $10, -500($sp)
add $8, $9, $10
sw $8, -496($sp)
li $8, 1
sw $8, -504($sp)
lw $9, -496($sp)
lw $10, -504($sp)
sub $8, $9, $10
sw $8, -496($sp)
lw $9, -120($sp)
lw $8, 0($9)
sw $8, -508($sp)
lw $9, -496($sp)
lw $10, -508($sp)
add $8, $9, $10
sw $8, -496($sp)
add $8, $29, -640
sw $8, -512($sp)
lw $8, -496($sp)
lw $9, -512($sp)
sw $8, 0($9)
add $8, $29, -644
sw $8, -520($sp)
lw $9, -96($sp)
lw $8, 0($9)
sw $8, -516($sp)
lw $8, -516($sp)
lw $9, -520($sp)
sw $8, 0($9)
add $8, $29, -648
sw $8, -528($sp)
lw $9, -88($sp)
lw $8, 0($9)
sw $8, -524($sp)
lw $8, -524($sp)
lw $9, -528($sp)
sw $8, 0($9)
lw $9, -8($sp)
lw $8, 0($9)
sw $8, -532($sp)
li $8, 1
sw $8, -536($sp)
lw $9, -532($sp)
lw $10, -536($sp)
sub $8, $9, $10
sw $8, -532($sp)
add $8, $29, -652
sw $8, -540($sp)
lw $8, -532($sp)
lw $9, -540($sp)
sw $8, 0($9)
add $8, $29, -656
sw $8, -548($sp)
lw $9, -4($sp)
lw $8, 0($9)
sw $8, -544($sp)
lw $8, -544($sp)
lw $9, -548($sp)
sw $8, 0($9)
add $29, $29, -656
jal __fill
sub $29, $29, -656
lw $31, -620($29)
add $8, $29, -616
sw $8, -552($sp)
lw $9, -552($sp)
lw $8, 0($9)
sw $8, -448($sp)
lw $8, -448($sp)
lw $9, -444($sp)
sw $8, 0($9)
label22:
label20:
lw $9, -128($sp)
move $8, $9
sw $8, -560($sp)
lw $9, -128($sp)
lw $8, 0($9)
sw $8, -556($sp)
lw $9, -556($sp)
add $8, $9, 1
sw $8, -564($sp)
lw $8, -564($sp)
lw $9, -560($sp)
sw $8, 0($9)
j label18
label19:
label17:
lw $9, -120($sp)
move $8, $9
sw $8, -572($sp)
lw $9, -120($sp)
lw $8, 0($9)
sw $8, -568($sp)
lw $9, -568($sp)
add $8, $9, 1
sw $8, -568($sp)
lw $8, -568($sp)
lw $9, -572($sp)
sw $8, 0($9)
j label15
label16:
label14:
add $8, $29, 40
sw $8, -580($sp)
lw $9, -36($sp)
lw $8, 0($9)
sw $8, -576($sp)
lw $8, -576($sp)
lw $9, -580($sp)
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
sw $t0, 108($a3)
la $t0, var4
sw $t0, 136($a3)
add $8, $29, -384
sw $8, -8($sp)
lw $9, -8($sp)
move $8, $9
sw $8, -4($sp)
lw $9, 8($a3)
move $8, $9
sw $8, -12($sp)
add $29, $29, -392
jal __getchar
sub $29, $29, -392
add $8, $29, -388
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
lw $9, -8($sp)
move $8, $9
sw $8, -28($sp)
lw $9, 8($a3)
lw $8, 0($9)
sw $8, -36($sp)
li $8, 1
sw $8, -40($sp)
lw $9, -36($sp)
lw $10, -40($sp)
add $8, $9, $10
sw $8, -36($sp)
li $8, 4
sw $8, -44($sp)
lw $9, -36($sp)
lw $10, -44($sp)
mul $8, $9, $10
sw $8, -36($sp)
add $8, $29, -396
sw $8, -48($sp)
lw $8, -36($sp)
lw $9, -48($sp)
sw $8, 0($9)
add $29, $29, -396
jal __malloc
sub $29, $29, -396
add $8, $29, -388
sw $8, -52($sp)
lw $9, -52($sp)
lw $8, 0($9)
sw $8, -32($sp)
lw $8, -32($sp)
lw $9, -28($sp)
sw $8, 0($9)
lw $9, -8($sp)
lw $8, 0($9)
sw $8, -56($sp)
li $8, 0
sw $8, -60($sp)
lw $9, -60($sp)
mul $8, $9, 4
sw $8, -64($sp)
lw $9, -56($sp)
lw $10, -64($sp)
add $8, $9, $10
sw $8, -56($sp)
li $8, 1
sw $8, -68($sp)
lw $8, -68($sp)
lw $9, -56($sp)
sw $8, 0($9)
lw $9, 12($a3)
move $8, $9
sw $8, -72($sp)
li $8, 1
sw $8, -76($sp)
lw $8, -76($sp)
lw $9, -72($sp)
sw $8, 0($9)
label23:
lw $9, 12($a3)
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
bgtz $8, label24
lw $9, -4($sp)
lw $8, 0($9)
sw $8, -88($sp)
lw $9, 12($a3)
lw $8, 0($9)
sw $8, -92($sp)
lw $9, -92($sp)
mul $8, $9, 4
sw $8, -96($sp)
lw $9, -88($sp)
lw $10, -96($sp)
add $8, $9, $10
sw $8, -88($sp)
lw $9, -4($sp)
lw $8, 0($9)
sw $8, -100($sp)
lw $9, 12($a3)
lw $8, 0($9)
sw $8, -104($sp)
li $8, 1
sw $8, -112($sp)
lw $9, -104($sp)
lw $10, -112($sp)
sub $8, $9, $10
sw $8, -104($sp)
lw $9, -104($sp)
mul $8, $9, 4
sw $8, -108($sp)
lw $9, -100($sp)
lw $10, -108($sp)
add $8, $9, $10
sw $8, -100($sp)
lw $9, -100($sp)
lw $8, 0($9)
sw $8, -100($sp)
li $8, 2
sw $8, -116($sp)
lw $9, -100($sp)
lw $10, -116($sp)
mul $8, $9, $10
sw $8, -100($sp)
lw $8, -100($sp)
lw $9, -88($sp)
sw $8, 0($9)
label25:
lw $9, 12($a3)
move $8, $9
sw $8, -124($sp)
lw $9, 12($a3)
lw $8, 0($9)
sw $8, -120($sp)
lw $9, -120($sp)
add $8, $9, 1
sw $8, -128($sp)
lw $8, -128($sp)
lw $9, -124($sp)
sw $8, 0($9)
j label23
label24:
lw $9, 16($a3)
move $8, $9
sw $8, -132($sp)
lw $9, -4($sp)
lw $8, 0($9)
sw $8, -140($sp)
lw $9, 8($a3)
lw $8, 0($9)
sw $8, -144($sp)
lw $9, -144($sp)
mul $8, $9, 4
sw $8, -148($sp)
lw $9, -140($sp)
lw $10, -148($sp)
add $8, $9, $10
sw $8, -140($sp)
lw $9, -140($sp)
lw $8, 0($9)
sw $8, -140($sp)
li $8, 4
sw $8, -152($sp)
lw $9, -140($sp)
lw $10, -152($sp)
mul $8, $9, $10
sw $8, -140($sp)
add $8, $29, -396
sw $8, -156($sp)
lw $8, -140($sp)
lw $9, -156($sp)
sw $8, 0($9)
add $29, $29, -396
jal __malloc
sub $29, $29, -396
add $8, $29, -388
sw $8, -160($sp)
lw $9, -160($sp)
lw $8, 0($9)
sw $8, -136($sp)
lw $8, -136($sp)
lw $9, -132($sp)
sw $8, 0($9)
lw $9, 12($a3)
move $8, $9
sw $8, -164($sp)
li $8, 0
sw $8, -168($sp)
lw $8, -168($sp)
lw $9, -164($sp)
sw $8, 0($9)
label26:
lw $9, 12($a3)
lw $8, 0($9)
sw $8, -172($sp)
lw $9, -4($sp)
lw $8, 0($9)
sw $8, -176($sp)
lw $9, 8($a3)
lw $8, 0($9)
sw $8, -180($sp)
lw $9, -180($sp)
mul $8, $9, 4
sw $8, -184($sp)
lw $9, -176($sp)
lw $10, -184($sp)
add $8, $9, $10
sw $8, -176($sp)
lw $9, -176($sp)
lw $8, 0($9)
sw $8, -176($sp)
lw $9, -172($sp)
lw $10, -176($sp)
sub $8, $9, $10
sw $8, -176($sp)
lw $8, -176($sp)
bgez $8, label27
lw $9, 16($a3)
lw $8, 0($9)
sw $8, -188($sp)
lw $9, 12($a3)
lw $8, 0($9)
sw $8, -192($sp)
lw $9, -192($sp)
mul $8, $9, 4
sw $8, -196($sp)
lw $9, -188($sp)
lw $10, -196($sp)
add $8, $9, $10
sw $8, -188($sp)
lw $9, -4($sp)
lw $8, 0($9)
sw $8, -204($sp)
lw $9, 8($a3)
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
li $8, 4
sw $8, -216($sp)
lw $9, -204($sp)
lw $10, -216($sp)
mul $8, $9, $10
sw $8, -204($sp)
add $8, $29, -396
sw $8, -220($sp)
lw $8, -204($sp)
lw $9, -220($sp)
sw $8, 0($9)
add $29, $29, -396
jal __malloc
sub $29, $29, -396
add $8, $29, -388
sw $8, -224($sp)
lw $9, -224($sp)
lw $8, 0($9)
sw $8, -200($sp)
lw $8, -200($sp)
lw $9, -188($sp)
sw $8, 0($9)
label28:
lw $9, 12($a3)
move $8, $9
sw $8, -232($sp)
lw $9, 12($a3)
lw $8, 0($9)
sw $8, -228($sp)
lw $9, -228($sp)
add $8, $9, 1
sw $8, -236($sp)
lw $8, -236($sp)
lw $9, -232($sp)
sw $8, 0($9)
j label26
label27:
li $8, 1
sw $8, -244($sp)
add $8, $29, -396
sw $8, -248($sp)
lw $8, -244($sp)
lw $9, -248($sp)
sw $8, 0($9)
add $8, $29, -400
sw $8, -256($sp)
lw $9, -4($sp)
lw $8, 0($9)
sw $8, -252($sp)
lw $8, -252($sp)
lw $9, -256($sp)
sw $8, 0($9)
li $8, 0
sw $8, -260($sp)
add $8, $29, -404
sw $8, -264($sp)
lw $8, -260($sp)
lw $9, -264($sp)
sw $8, 0($9)
lw $9, -4($sp)
lw $8, 0($9)
sw $8, -268($sp)
lw $9, 8($a3)
lw $8, 0($9)
sw $8, -272($sp)
lw $9, -272($sp)
mul $8, $9, 4
sw $8, -276($sp)
lw $9, -268($sp)
lw $10, -276($sp)
add $8, $9, $10
sw $8, -268($sp)
lw $9, -268($sp)
lw $8, 0($9)
sw $8, -268($sp)
li $8, 1
sw $8, -280($sp)
lw $9, -268($sp)
lw $10, -280($sp)
sub $8, $9, $10
sw $8, -268($sp)
add $8, $29, -408
sw $8, -284($sp)
lw $8, -268($sp)
lw $9, -284($sp)
sw $8, 0($9)
lw $9, -4($sp)
lw $8, 0($9)
sw $8, -288($sp)
lw $9, 8($a3)
lw $8, 0($9)
sw $8, -292($sp)
lw $9, -292($sp)
mul $8, $9, 4
sw $8, -296($sp)
lw $9, -288($sp)
lw $10, -296($sp)
add $8, $9, $10
sw $8, -288($sp)
lw $9, -288($sp)
lw $8, 0($9)
sw $8, -288($sp)
li $8, 1
sw $8, -300($sp)
lw $9, -288($sp)
lw $10, -300($sp)
sub $8, $9, $10
sw $8, -288($sp)
add $8, $29, -412
sw $8, -304($sp)
lw $8, -288($sp)
lw $9, -304($sp)
sw $8, 0($9)
li $8, 0
sw $8, -308($sp)
add $8, $29, -416
sw $8, -312($sp)
lw $8, -308($sp)
lw $9, -312($sp)
sw $8, 0($9)
li $8, 0
sw $8, -316($sp)
add $8, $29, -420
sw $8, -320($sp)
lw $8, -316($sp)
lw $9, -320($sp)
sw $8, 0($9)
add $8, $29, -424
sw $8, -328($sp)
lw $9, 8($a3)
lw $8, 0($9)
sw $8, -324($sp)
lw $8, -324($sp)
lw $9, -328($sp)
sw $8, 0($9)
add $8, $29, -428
sw $8, -336($sp)
lw $9, 16($a3)
lw $8, 0($9)
sw $8, -332($sp)
lw $8, -332($sp)
lw $9, -336($sp)
sw $8, 0($9)
add $29, $29, -428
jal __fill
sub $29, $29, -428
add $8, $29, -388
sw $8, -340($sp)
add $8, $29, -396
sw $8, -352($sp)
lw $9, 16($a3)
lw $8, 0($9)
sw $8, -348($sp)
lw $8, -348($sp)
lw $9, -352($sp)
sw $8, 0($9)
lw $9, -4($sp)
lw $8, 0($9)
sw $8, -356($sp)
lw $9, 8($a3)
lw $8, 0($9)
sw $8, -360($sp)
lw $9, -360($sp)
mul $8, $9, 4
sw $8, -364($sp)
lw $9, -356($sp)
lw $10, -364($sp)
add $8, $9, $10
sw $8, -356($sp)
add $8, $29, -400
sw $8, -368($sp)
lw $9, -356($sp)
lw $8, 0($9)
sw $8, -356($sp)
lw $8, -356($sp)
lw $9, -368($sp)
sw $8, 0($9)
add $29, $29, -400
jal __printBoard
sub $29, $29, -400
add $8, $29, -388
sw $8, -372($sp)
li $8, 0
sw $8, -376($sp)
add $8, $29, 4
sw $8, -380($sp)
lw $8, -376($sp)
lw $9, -380($sp)
sw $8, 0($9)
j __main_end
j __main_end
__main_end:
li $v0, 10
syscall
#global $2 4
#global $3 4
#global $4 4
#string $27 #%d 
#string $34 #\n
#----------------------------
#func #printBoard
#addi $5 $0 0
#addi $6 $0 4
#addi $8 $0 -140
#move $7 $8
#addi $10 $0 -144
#move $9 $10
#move $11 $8
#li $12 0
#sw $12 $11 0
#label l:0
####move $13 $7
#lw $13 $7 0
####move $14 $5
#lw $14 $5 0
#sub $14 $13 $14
#bgez $14 l:1
#move $15 $9
#li $16 0
#sw $16 $15 0
#label l:3
####move $17 $9
#lw $17 $9 0
####move $18 $5
#lw $18 $5 0
#sub $18 $17 $18
#bgez $18 l:4
#sw $1 $0 -148
####move $20 $6
#lw $20 $6 0
####move $21 $7
#lw $21 $7 0
#muli $22 $21 4
#add $20 $20 $22
#lw $20 $20 0
####move $23 $9
#lw $23 $9 0
#muli $24 $23 4
#add $20 $20 $24
#addi $25 $0 -152
#lw $20 $20 0
#sw $20 $25 0
#move $26 $27
#addi $28 $0 -156
#sw $26 $28 0
#addi $0 $0 -156
#call #printf
#subi $0 $0 -156
#lw $1 $0 -148
#label l:5
####move $29 $9
#move $30 $9
#lw $29 $9 0
#addi $31 $29 1
#sw $31 $30 0
#goto l:3
#label l:4
#sw $1 $0 -148
#move $33 $34
#addi $35 $0 -152
#sw $33 $35 0
#addi $0 $0 -152
#call #printf_single
#subi $0 $0 -152
#lw $1 $0 -148
#label l:2
####move $36 $7
#move $37 $7
#lw $36 $7 0
#addi $38 $36 1
#sw $38 $37 0
#goto l:0
#label l:1
#li $39 0
#addi $40 $0 12
#sw $39 $40 0
#return
#return
#----------------------------
#func #inRect
#addi $41 $0 0
#addi $42 $0 4
#addi $43 $0 8
#addi $44 $0 12
#addi $45 $0 16
#addi $46 $0 20
####move $47 $41
#lw $47 $41 0
####move $48 $43
#lw $48 $43 0
#sub $48 $47 $48
#li $47 1
#bgez $48 l:6
#li $47 0
#label l:6
#beqz $47 l:7
####move $47 $41
#lw $47 $41 0
####move $49 $45
#lw $49 $45 0
#sub $49 $47 $49
#li $47 1
#bltz $49 l:8
#li $47 0
#label l:8
#label l:7
#andi $47 $47 1
#beqz $47 l:9
####move $47 $42
#lw $47 $42 0
####move $50 $44
#lw $50 $44 0
#sub $50 $47 $50
#li $47 1
#bgez $50 l:10
#li $47 0
#label l:10
#label l:9
#andi $47 $47 1
#beqz $47 l:11
####move $47 $42
#lw $47 $42 0
####move $51 $46
#lw $51 $46 0
#sub $51 $47 $51
#li $47 1
#bltz $51 l:12
#li $47 0
#label l:12
#label l:11
#andi $47 $47 1
#addi $52 $0 28
#sw $47 $52 0
#return
#return
#----------------------------
#func #fill
#addi $53 $0 0
#addi $54 $0 4
#addi $55 $0 8
#addi $56 $0 12
#addi $57 $0 16
#addi $58 $0 20
#addi $59 $0 24
#addi $60 $0 28
#addi $61 $0 32
####move $62 $54
#lw $62 $54 0
#li $63 0
#sub $63 $62 $63
#bnez $63 l:13
####move $64 $53
#lw $64 $53 0
####move $65 $57
#lw $65 $57 0
#muli $66 $65 4
#add $64 $64 $66
#lw $64 $64 0
####move $67 $58
#lw $67 $58 0
#muli $68 $67 4
#add $64 $64 $68
####move $69 $59
#lw $69 $59 0
#sw $69 $64 0
#goto l:14
#label l:13
#addi $71 $0 -584
#move $70 $71
#addi $73 $0 -588
#move $72 $73
#addi $75 $0 -592
#move $74 $75
#addi $77 $0 -596
#move $76 $77
#addi $79 $0 -600
#move $78 $79
#addi $81 $0 -604
#move $80 $81
#addi $83 $0 -608
#move $82 $83
#addi $85 $0 -612
#move $84 $85
#move $86 $71
####move $87 $60
#lw $87 $60 0
####move $88 $54
#lw $88 $54 0
#li $90 1
#sub $88 $88 $90
#muli $89 $88 4
#add $87 $87 $89
#lw $87 $87 0
#sw $87 $86 0
#move $91 $73
####move $92 $61
#lw $92 $61 0
#sw $92 $91 0
#move $93 $75
#move $94 $77
#move $95 $79
#move $96 $81
#li $97 0
#sw $97 $96 0
#lw $96 $96 0
#sw $96 $95 0
#lw $95 $95 0
#sw $95 $94 0
#lw $94 $94 0
#sw $94 $93 0
####move $98 $61
#move $99 $61
#lw $98 $61 0
#addi $100 $98 1
#sw $100 $99 0
#move $101 $83
#li $102 0
#sw $102 $101 0
#label l:15
####move $103 $82
#lw $103 $82 0
#li $104 1
#sub $104 $103 $104
#bgtz $104 l:16
#move $105 $84
#li $106 0
#sw $106 $105 0
#label l:18
####move $107 $84
#lw $107 $84 0
#li $108 1
#sub $108 $107 $108
#bgtz $108 l:19
#move $109 $74
####move $110 $55
#lw $110 $55 0
####move $111 $82
#lw $111 $82 0
####move $112 $70
#lw $112 $70 0
#mul $111 $111 $112
#add $110 $110 $111
#sw $110 $109 0
#move $113 $76
####move $114 $56
#lw $114 $56 0
####move $115 $84
#lw $115 $84 0
####move $116 $70
#lw $116 $70 0
#mul $115 $115 $116
#add $114 $114 $115
#sw $114 $113 0
#move $117 $78
####move $118 $55
#lw $118 $55 0
####move $119 $82
#lw $119 $82 0
#li $120 1
#add $119 $119 $120
####move $121 $70
#lw $121 $70 0
#mul $119 $119 $121
#add $118 $118 $119
#sw $118 $117 0
#move $122 $80
####move $123 $56
#lw $123 $56 0
####move $124 $84
#lw $124 $84 0
#li $125 1
#add $124 $124 $125
####move $126 $70
#lw $126 $70 0
#mul $124 $124 $126
#add $123 $123 $124
#sw $123 $122 0
#sw $1 $0 -620
####move $128 $80
#addi $129 $0 -624
#lw $128 $80 0
#sw $128 $129 0
####move $130 $78
#addi $131 $0 -628
#lw $130 $78 0
#sw $130 $131 0
####move $132 $76
#addi $133 $0 -632
#lw $132 $76 0
#sw $132 $133 0
####move $134 $74
#addi $135 $0 -636
#lw $134 $74 0
#sw $134 $135 0
####move $136 $58
#addi $137 $0 -640
#lw $136 $58 0
#sw $136 $137 0
####move $138 $57
#addi $139 $0 -644
#lw $138 $57 0
#sw $138 $139 0
#addi $0 $0 -644
#call #inRect
#subi $0 $0 -644
#lw $1 $0 -620
#addi $140 $0 -616
####move $127 $140
#lw $127 $140 0
#beqz $127 l:21
#move $141 $61
#sw $1 $0 -620
####move $143 $61
#addi $144 $0 -624
#lw $143 $61 0
#sw $143 $144 0
####move $145 $60
#addi $146 $0 -628
#lw $145 $60 0
#sw $145 $146 0
####move $147 $59
#addi $148 $0 -632
#lw $147 $59 0
#sw $147 $148 0
####move $149 $58
#addi $150 $0 -636
#lw $149 $58 0
#sw $149 $150 0
####move $151 $57
#addi $152 $0 -640
#lw $151 $57 0
#sw $151 $152 0
####move $153 $76
#addi $154 $0 -644
#lw $153 $76 0
#sw $153 $154 0
####move $155 $74
#addi $156 $0 -648
#lw $155 $74 0
#sw $155 $156 0
####move $157 $54
#lw $157 $54 0
#li $158 1
#sub $157 $157 $158
#addi $159 $0 -652
#sw $157 $159 0
####move $160 $53
#addi $161 $0 -656
#lw $160 $53 0
#sw $160 $161 0
#addi $0 $0 -656
#call #fill
#subi $0 $0 -656
#lw $1 $0 -620
#addi $162 $0 -616
####move $142 $162
#lw $142 $162 0
#sw $142 $141 0
#goto l:22
#label l:21
#move $163 $61
#sw $1 $0 -620
####move $165 $61
#addi $166 $0 -624
#lw $165 $61 0
#sw $165 $166 0
####move $167 $60
#addi $168 $0 -628
#lw $167 $60 0
#sw $167 $168 0
####move $169 $72
#addi $170 $0 -632
#lw $169 $72 0
#sw $169 $170 0
####move $171 $56
#lw $171 $56 0
####move $172 $70
#lw $172 $70 0
#add $171 $171 $172
#li $173 1
#sub $171 $171 $173
####move $174 $84
#lw $174 $84 0
#add $171 $171 $174
#addi $175 $0 -636
#sw $171 $175 0
####move $176 $55
#lw $176 $55 0
####move $177 $70
#lw $177 $70 0
#add $176 $176 $177
#li $178 1
#sub $176 $176 $178
####move $179 $82
#lw $179 $82 0
#add $176 $176 $179
#addi $180 $0 -640
#sw $176 $180 0
####move $181 $76
#addi $182 $0 -644
#lw $181 $76 0
#sw $181 $182 0
####move $183 $74
#addi $184 $0 -648
#lw $183 $74 0
#sw $183 $184 0
####move $185 $54
#lw $185 $54 0
#li $186 1
#sub $185 $185 $186
#addi $187 $0 -652
#sw $185 $187 0
####move $188 $53
#addi $189 $0 -656
#lw $188 $53 0
#sw $188 $189 0
#addi $0 $0 -656
#call #fill
#subi $0 $0 -656
#lw $1 $0 -620
#addi $190 $0 -616
####move $164 $190
#lw $164 $190 0
#sw $164 $163 0
#label l:22
#label l:20
####move $191 $84
#move $192 $84
#lw $191 $84 0
#addi $193 $191 1
#sw $193 $192 0
#goto l:18
#label l:19
#label l:17
####move $194 $82
#move $195 $82
#lw $194 $82 0
#addi $194 $194 1
#sw $194 $195 0
#goto l:15
#label l:16
#label l:14
####move $196 $61
#addi $197 $0 40
#lw $196 $61 0
#sw $196 $197 0
#return
#return
#----------------------------
#func #main
#addi $199 $0 -384
#move $198 $199
#move $200 $2
#addi $0 $0 -392
#call #getchar
#subi $0 $0 -392
#addi $202 $0 -388
####move $201 $202
#lw $201 $202 0
#li $203 48
#sub $201 $201 $203
#sw $201 $200 0
#move $204 $199
####move $206 $2
#lw $206 $2 0
#li $207 1
#add $206 $206 $207
#li $208 4
#mul $206 $206 $208
#addi $209 $0 -396
#sw $206 $209 0
#addi $0 $0 -396
#call #malloc
#subi $0 $0 -396
#addi $210 $0 -388
####move $205 $210
#lw $205 $210 0
#sw $205 $204 0
####move $211 $199
#lw $211 $199 0
#li $212 0
#muli $213 $212 4
#add $211 $211 $213
#li $214 1
#sw $214 $211 0
#move $215 $3
#li $216 1
#sw $216 $215 0
#label l:23
####move $217 $3
#lw $217 $3 0
####move $218 $2
#lw $218 $2 0
#sub $218 $217 $218
#bgtz $218 l:24
####move $219 $198
#lw $219 $198 0
####move $220 $3
#lw $220 $3 0
#muli $221 $220 4
#add $219 $219 $221
####move $222 $198
#lw $222 $198 0
####move $223 $3
#lw $223 $3 0
#li $225 1
#sub $223 $223 $225
#muli $224 $223 4
#add $222 $222 $224
#lw $222 $222 0
#li $226 2
#mul $222 $222 $226
#sw $222 $219 0
#label l:25
####move $227 $3
#move $228 $3
#lw $227 $3 0
#addi $229 $227 1
#sw $229 $228 0
#goto l:23
#label l:24
#move $230 $4
####move $232 $198
#lw $232 $198 0
####move $233 $2
#lw $233 $2 0
#muli $234 $233 4
#add $232 $232 $234
#lw $232 $232 0
#li $235 4
#mul $232 $232 $235
#addi $236 $0 -396
#sw $232 $236 0
#addi $0 $0 -396
#call #malloc
#subi $0 $0 -396
#addi $237 $0 -388
####move $231 $237
#lw $231 $237 0
#sw $231 $230 0
#move $238 $3
#li $239 0
#sw $239 $238 0
#label l:26
####move $240 $3
#lw $240 $3 0
####move $241 $198
#lw $241 $198 0
####move $242 $2
#lw $242 $2 0
#muli $243 $242 4
#add $241 $241 $243
#lw $241 $241 0
#sub $241 $240 $241
#bgez $241 l:27
####move $244 $4
#lw $244 $4 0
####move $245 $3
#lw $245 $3 0
#muli $246 $245 4
#add $244 $244 $246
####move $248 $198
#lw $248 $198 0
####move $249 $2
#lw $249 $2 0
#muli $250 $249 4
#add $248 $248 $250
#lw $248 $248 0
#li $251 4
#mul $248 $248 $251
#addi $252 $0 -396
#sw $248 $252 0
#addi $0 $0 -396
#call #malloc
#subi $0 $0 -396
#addi $253 $0 -388
####move $247 $253
#lw $247 $253 0
#sw $247 $244 0
#label l:28
####move $254 $3
#move $255 $3
#lw $254 $3 0
#addi $256 $254 1
#sw $256 $255 0
#goto l:26
#label l:27
#li $258 1
#addi $259 $0 -396
#sw $258 $259 0
####move $260 $198
#addi $261 $0 -400
#lw $260 $198 0
#sw $260 $261 0
#li $262 0
#addi $263 $0 -404
#sw $262 $263 0
####move $264 $198
#lw $264 $198 0
####move $265 $2
#lw $265 $2 0
#muli $266 $265 4
#add $264 $264 $266
#lw $264 $264 0
#li $267 1
#sub $264 $264 $267
#addi $268 $0 -408
#sw $264 $268 0
####move $269 $198
#lw $269 $198 0
####move $270 $2
#lw $270 $2 0
#muli $271 $270 4
#add $269 $269 $271
#lw $269 $269 0
#li $272 1
#sub $269 $269 $272
#addi $273 $0 -412
#sw $269 $273 0
#li $274 0
#addi $275 $0 -416
#sw $274 $275 0
#li $276 0
#addi $277 $0 -420
#sw $276 $277 0
####move $278 $2
#addi $279 $0 -424
#lw $278 $2 0
#sw $278 $279 0
####move $280 $4
#addi $281 $0 -428
#lw $280 $4 0
#sw $280 $281 0
#addi $0 $0 -428
#call #fill
#subi $0 $0 -428
#addi $282 $0 -388
####move $257 $282
####move $284 $4
#addi $285 $0 -396
#lw $284 $4 0
#sw $284 $285 0
####move $286 $198
#lw $286 $198 0
####move $287 $2
#lw $287 $2 0
#muli $288 $287 4
#add $286 $286 $288
#addi $289 $0 -400
#lw $286 $286 0
#sw $286 $289 0
#addi $0 $0 -400
#call #printBoard
#subi $0 $0 -400
#addi $290 $0 -388
####move $283 $290
#li $291 0
#addi $292 $0 4
#sw $291 $292 0
#return
#return
