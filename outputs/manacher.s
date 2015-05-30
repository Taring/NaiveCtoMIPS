.data
temp: .space 720
var0: .space 1028
var1: .space 4100
var2: .asciiz "%d\n"
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

__getString:
add $8, $29, 0
sw $8, -4($sp)
add $8, $29, -108
sw $8, -12($sp)
lw $9, -12($sp)
move $8, $9
sw $8, -8($sp)
li $8, 0
sw $8, -16($sp)
lw $8, -16($sp)
lw $9, -8($sp)
sw $8, 0($9)
label0:
add $8, $29, -112
sw $8, -24($sp)
lw $9, -24($sp)
move $8, $9
sw $8, -20($sp)
sw $31, -120($29)
add $29, $29, -120
jal __getchar
sub $29, $29, -120
lw $31, -120($29)
add $8, $29, -116
sw $8, -32($sp)
lw $9, -32($sp)
lw $8, 0($9)
sw $8, -28($sp)
lw $8, -28($sp)
lw $9, -20($sp)
sw $8, 0($9)
li $8, 97
sw $8, -36($sp)
lw $9, -20($sp)
lw $8, 0($9)
sw $8, -40($sp)
lw $9, -36($sp)
lw $10, -40($sp)
sub $8, $9, $10
sw $8, -40($sp)
li $8, 1
sw $8, -36($sp)
lw $8, -40($sp)
blez $8, label4
li $8, 0
sw $8, -36($sp)
label4:
lw $8, -36($sp)
beqz $8, label5
lw $9, -20($sp)
lw $8, 0($9)
sw $8, -36($sp)
li $8, 122
sw $8, -44($sp)
lw $9, -36($sp)
lw $10, -44($sp)
sub $8, $9, $10
sw $8, -44($sp)
li $8, 1
sw $8, -36($sp)
lw $8, -44($sp)
blez $8, label6
li $8, 0
sw $8, -36($sp)
label6:
label5:
lw $9, -36($sp)
andi $8, $9, 1
sw $8, -36($sp)
lw $8, -36($sp)
bnez $8, label3
li $8, 65
sw $8, -48($sp)
lw $9, -20($sp)
lw $8, 0($9)
sw $8, -52($sp)
lw $9, -48($sp)
lw $10, -52($sp)
sub $8, $9, $10
sw $8, -52($sp)
li $8, 1
sw $8, -48($sp)
lw $8, -52($sp)
blez $8, label7
li $8, 0
sw $8, -48($sp)
label7:
lw $8, -48($sp)
beqz $8, label8
lw $9, -20($sp)
lw $8, 0($9)
sw $8, -48($sp)
li $8, 90
sw $8, -56($sp)
lw $9, -48($sp)
lw $10, -56($sp)
sub $8, $9, $10
sw $8, -56($sp)
li $8, 1
sw $8, -48($sp)
lw $8, -56($sp)
blez $8, label9
li $8, 0
sw $8, -48($sp)
label9:
label8:
lw $9, -48($sp)
andi $8, $9, 1
sw $8, -48($sp)
lw $8, -48($sp)
beqz $8, label2
label3:
lw $9, -4($sp)
lw $8, 0($9)
sw $8, -60($sp)
lw $9, -8($sp)
move $8, $9
sw $8, -72($sp)
lw $9, -8($sp)
lw $8, 0($9)
sw $8, -64($sp)
lw $9, -64($sp)
add $8, $9, 1
sw $8, -76($sp)
lw $8, -76($sp)
lw $9, -72($sp)
sw $8, 0($9)
lw $9, -64($sp)
mul $8, $9, 1
sw $8, -68($sp)
lw $9, -60($sp)
lw $10, -68($sp)
add $8, $9, $10
sw $8, -60($sp)
lw $9, -20($sp)
lb $8, 0($9)
sw $8, -80($sp)
lw $8, -80($sp)
lw $9, -60($sp)
sb $8, 0($9)
j label0
label2:
j label1
j label0
label1:
lw $9, -4($sp)
lw $8, 0($9)
sw $8, -84($sp)
lw $9, -8($sp)
lw $8, 0($9)
sw $8, -88($sp)
lw $9, -88($sp)
mul $8, $9, 1
sw $8, -92($sp)
lw $9, -84($sp)
lw $10, -92($sp)
add $8, $9, $10
sw $8, -84($sp)
li $8, 0
sw $8, -96($sp)
lw $8, -96($sp)
lw $9, -84($sp)
sb $8, 0($9)
add $8, $29, 8
sw $8, -104($sp)
lw $9, -8($sp)
lw $8, 0($9)
sw $8, -100($sp)
lw $8, -100($sp)
lw $9, -104($sp)
sw $8, 0($9)
jr $ra
jr $ra
__getMax:
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
bgez $8, label10
add $8, $29, 12
sw $8, -24($sp)
lw $9, -8($sp)
lw $8, 0($9)
sw $8, -20($sp)
lw $8, -20($sp)
lw $9, -24($sp)
sw $8, 0($9)
jr $ra
label10:
add $8, $29, 12
sw $8, -32($sp)
lw $9, -4($sp)
lw $8, 0($9)
sw $8, -28($sp)
lw $8, -28($sp)
lw $9, -32($sp)
sw $8, 0($9)
jr $ra
jr $ra
__getMin:
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
bgez $8, label11
add $8, $29, 12
sw $8, -24($sp)
lw $9, -4($sp)
lw $8, 0($9)
sw $8, -20($sp)
lw $8, -20($sp)
lw $9, -24($sp)
sw $8, 0($9)
jr $ra
label11:
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
__Manacher:
add $8, $29, 0
sw $8, -4($sp)
add $8, $29, 4
sw $8, -8($sp)
add $8, $29, 8
sw $8, -12($sp)
add $8, $29, -388
sw $8, -20($sp)
lw $9, -20($sp)
move $8, $9
sw $8, -16($sp)
add $8, $29, -392
sw $8, -28($sp)
lw $9, -28($sp)
move $8, $9
sw $8, -24($sp)
add $8, $29, -396
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
label12:
lw $9, -16($sp)
lw $8, 0($9)
sw $8, -48($sp)
lw $9, -4($sp)
lw $8, 0($9)
sw $8, -52($sp)
lw $9, -4($sp)
lw $8, 0($9)
sw $8, -56($sp)
lw $9, -52($sp)
lw $10, -56($sp)
add $8, $9, $10
sw $8, -52($sp)
lw $9, -48($sp)
lw $10, -52($sp)
sub $8, $9, $10
sw $8, -52($sp)
lw $8, -52($sp)
bgez $8, label13
lw $9, -12($sp)
lw $8, 0($9)
sw $8, -60($sp)
lw $9, -16($sp)
lw $8, 0($9)
sw $8, -64($sp)
lw $9, -64($sp)
mul $8, $9, 4
sw $8, -68($sp)
lw $9, -60($sp)
lw $10, -68($sp)
add $8, $9, $10
sw $8, -60($sp)
li $8, 0
sw $8, -72($sp)
lw $8, -72($sp)
lw $9, -60($sp)
sw $8, 0($9)
label14:
lw $9, -16($sp)
move $8, $9
sw $8, -80($sp)
lw $9, -16($sp)
lw $8, 0($9)
sw $8, -76($sp)
lw $9, -76($sp)
add $8, $9, 1
sw $8, -76($sp)
lw $8, -76($sp)
lw $9, -80($sp)
sw $8, 0($9)
j label12
label13:
lw $9, -16($sp)
move $8, $9
sw $8, -88($sp)
li $8, 0
sw $8, -92($sp)
lw $8, -92($sp)
lw $9, -88($sp)
sw $8, 0($9)
lw $9, -24($sp)
move $8, $9
sw $8, -96($sp)
li $8, 0
sw $8, -100($sp)
lw $8, -100($sp)
lw $9, -96($sp)
sw $8, 0($9)
lw $9, -32($sp)
move $8, $9
sw $8, -84($sp)
label15:
lw $9, -16($sp)
lw $8, 0($9)
sw $8, -104($sp)
lw $9, -4($sp)
lw $8, 0($9)
sw $8, -108($sp)
lw $9, -4($sp)
lw $8, 0($9)
sw $8, -112($sp)
lw $9, -108($sp)
lw $10, -112($sp)
add $8, $9, $10
sw $8, -108($sp)
lw $9, -104($sp)
lw $10, -108($sp)
sub $8, $9, $10
sw $8, -108($sp)
lw $8, -108($sp)
bgez $8, label16
label18:
lw $9, -16($sp)
lw $8, 0($9)
sw $8, -116($sp)
lw $9, -24($sp)
lw $8, 0($9)
sw $8, -120($sp)
lw $9, -116($sp)
lw $10, -120($sp)
sub $8, $9, $10
sw $8, -116($sp)
li $8, 0
sw $8, -124($sp)
lw $9, -116($sp)
lw $10, -124($sp)
sub $8, $9, $10
sw $8, -124($sp)
lw $8, -124($sp)
bltz $8, label19
lw $9, -16($sp)
lw $8, 0($9)
sw $8, -128($sp)
lw $9, -24($sp)
lw $8, 0($9)
sw $8, -132($sp)
lw $9, -128($sp)
lw $10, -132($sp)
add $8, $9, $10
sw $8, -128($sp)
li $8, 1
sw $8, -136($sp)
lw $9, -128($sp)
lw $10, -136($sp)
add $8, $9, $10
sw $8, -128($sp)
lw $9, -4($sp)
lw $8, 0($9)
sw $8, -140($sp)
li $8, 2
sw $8, -144($sp)
lw $9, -140($sp)
lw $10, -144($sp)
mul $8, $9, $10
sw $8, -140($sp)
lw $9, -128($sp)
lw $10, -140($sp)
sub $8, $9, $10
sw $8, -140($sp)
lw $8, -140($sp)
bgez $8, label19
lw $9, -8($sp)
lw $8, 0($9)
sw $8, -148($sp)
lw $9, -16($sp)
lw $8, 0($9)
sw $8, -152($sp)
lw $9, -24($sp)
lw $8, 0($9)
sw $8, -160($sp)
lw $9, -152($sp)
lw $10, -160($sp)
sub $8, $9, $10
sw $8, -152($sp)
li $8, 2
sw $8, -164($sp)
lw $9, -152($sp)
lw $10, -164($sp)
div $8, $9, $10
sw $8, -152($sp)
lw $9, -152($sp)
mul $8, $9, 1
sw $8, -156($sp)
lw $9, -148($sp)
lw $10, -156($sp)
add $8, $9, $10
sw $8, -148($sp)
lw $9, -148($sp)
lb $8, 0($9)
sw $8, -148($sp)
lw $9, -8($sp)
lw $8, 0($9)
sw $8, -168($sp)
lw $9, -16($sp)
lw $8, 0($9)
sw $8, -172($sp)
lw $9, -24($sp)
lw $8, 0($9)
sw $8, -180($sp)
lw $9, -172($sp)
lw $10, -180($sp)
add $8, $9, $10
sw $8, -172($sp)
li $8, 1
sw $8, -184($sp)
lw $9, -172($sp)
lw $10, -184($sp)
add $8, $9, $10
sw $8, -172($sp)
li $8, 2
sw $8, -188($sp)
lw $9, -172($sp)
lw $10, -188($sp)
div $8, $9, $10
sw $8, -172($sp)
lw $9, -172($sp)
mul $8, $9, 1
sw $8, -176($sp)
lw $9, -168($sp)
lw $10, -176($sp)
add $8, $9, $10
sw $8, -168($sp)
lw $9, -168($sp)
lb $8, 0($9)
sw $8, -168($sp)
lw $9, -148($sp)
lw $10, -168($sp)
sub $8, $9, $10
sw $8, -168($sp)
lw $8, -168($sp)
bnez $8, label19
lw $9, -24($sp)
move $8, $9
sw $8, -196($sp)
lw $9, -24($sp)
lw $8, 0($9)
sw $8, -192($sp)
lw $9, -192($sp)
add $8, $9, 1
sw $8, -200($sp)
lw $8, -200($sp)
lw $9, -196($sp)
sw $8, 0($9)
j label18
label19:
lw $9, -12($sp)
lw $8, 0($9)
sw $8, -204($sp)
lw $9, -16($sp)
lw $8, 0($9)
sw $8, -208($sp)
lw $9, -208($sp)
mul $8, $9, 4
sw $8, -212($sp)
lw $9, -204($sp)
lw $10, -212($sp)
add $8, $9, $10
sw $8, -204($sp)
lw $9, -24($sp)
lw $8, 0($9)
sw $8, -216($sp)
lw $8, -216($sp)
lw $9, -204($sp)
sw $8, 0($9)
lw $9, -32($sp)
move $8, $9
sw $8, -220($sp)
li $8, 1
sw $8, -224($sp)
lw $8, -224($sp)
lw $9, -220($sp)
sw $8, 0($9)
label20:
lw $9, -16($sp)
lw $8, 0($9)
sw $8, -228($sp)
lw $9, -32($sp)
lw $8, 0($9)
sw $8, -232($sp)
lw $9, -228($sp)
lw $10, -232($sp)
sub $8, $9, $10
sw $8, -228($sp)
li $8, 0
sw $8, -236($sp)
lw $9, -228($sp)
lw $10, -236($sp)
sub $8, $9, $10
sw $8, -236($sp)
lw $8, -236($sp)
bltz $8, label21
lw $9, -24($sp)
lw $8, 0($9)
sw $8, -240($sp)
lw $9, -32($sp)
lw $8, 0($9)
sw $8, -244($sp)
lw $9, -240($sp)
lw $10, -244($sp)
sub $8, $9, $10
sw $8, -240($sp)
li $8, 0
sw $8, -248($sp)
lw $9, -240($sp)
lw $10, -248($sp)
sub $8, $9, $10
sw $8, -248($sp)
lw $8, -248($sp)
bltz $8, label21
lw $9, -12($sp)
lw $8, 0($9)
sw $8, -252($sp)
lw $9, -16($sp)
lw $8, 0($9)
sw $8, -256($sp)
lw $9, -32($sp)
lw $8, 0($9)
sw $8, -264($sp)
lw $9, -256($sp)
lw $10, -264($sp)
sub $8, $9, $10
sw $8, -256($sp)
lw $9, -256($sp)
mul $8, $9, 4
sw $8, -260($sp)
lw $9, -252($sp)
lw $10, -260($sp)
add $8, $9, $10
sw $8, -252($sp)
lw $9, -252($sp)
lw $8, 0($9)
sw $8, -252($sp)
lw $9, -24($sp)
lw $8, 0($9)
sw $8, -268($sp)
lw $9, -32($sp)
lw $8, 0($9)
sw $8, -272($sp)
lw $9, -268($sp)
lw $10, -272($sp)
sub $8, $9, $10
sw $8, -268($sp)
lw $9, -252($sp)
lw $10, -268($sp)
sub $8, $9, $10
sw $8, -268($sp)
lw $8, -268($sp)
beqz $8, label21
lw $9, -12($sp)
lw $8, 0($9)
sw $8, -276($sp)
lw $9, -16($sp)
lw $8, 0($9)
sw $8, -280($sp)
lw $9, -32($sp)
lw $8, 0($9)
sw $8, -288($sp)
lw $9, -280($sp)
lw $10, -288($sp)
add $8, $9, $10
sw $8, -280($sp)
lw $9, -280($sp)
mul $8, $9, 4
sw $8, -284($sp)
lw $9, -276($sp)
lw $10, -284($sp)
add $8, $9, $10
sw $8, -276($sp)
sw $31, -404($29)
lw $9, -24($sp)
lw $8, 0($9)
sw $8, -296($sp)
lw $9, -32($sp)
lw $8, 0($9)
sw $8, -300($sp)
lw $9, -296($sp)
lw $10, -300($sp)
sub $8, $9, $10
sw $8, -296($sp)
add $8, $29, -408
sw $8, -304($sp)
lw $8, -296($sp)
lw $9, -304($sp)
sw $8, 0($9)
lw $9, -12($sp)
lw $8, 0($9)
sw $8, -308($sp)
lw $9, -16($sp)
lw $8, 0($9)
sw $8, -312($sp)
lw $9, -32($sp)
lw $8, 0($9)
sw $8, -320($sp)
lw $9, -312($sp)
lw $10, -320($sp)
sub $8, $9, $10
sw $8, -312($sp)
lw $9, -312($sp)
mul $8, $9, 4
sw $8, -316($sp)
lw $9, -308($sp)
lw $10, -316($sp)
add $8, $9, $10
sw $8, -308($sp)
add $8, $29, -412
sw $8, -324($sp)
lw $9, -308($sp)
lw $8, 0($9)
sw $8, -308($sp)
lw $8, -308($sp)
lw $9, -324($sp)
sw $8, 0($9)
add $29, $29, -412
jal __getMin
sub $29, $29, -412
lw $31, -404($29)
add $8, $29, -400
sw $8, -328($sp)
lw $9, -328($sp)
lw $8, 0($9)
sw $8, -292($sp)
lw $8, -292($sp)
lw $9, -276($sp)
sw $8, 0($9)
label22:
lw $9, -32($sp)
move $8, $9
sw $8, -336($sp)
lw $9, -32($sp)
lw $8, 0($9)
sw $8, -332($sp)
lw $9, -332($sp)
add $8, $9, 1
sw $8, -340($sp)
lw $8, -340($sp)
lw $9, -336($sp)
sw $8, 0($9)
j label20
label21:
label17:
lw $9, -16($sp)
move $8, $9
sw $8, -348($sp)
lw $9, -16($sp)
lw $8, 0($9)
sw $8, -356($sp)
lw $9, -32($sp)
lw $8, 0($9)
sw $8, -352($sp)
lw $9, -356($sp)
lw $10, -352($sp)
add $8, $9, $10
sw $8, -356($sp)
lw $8, -356($sp)
lw $9, -348($sp)
sw $8, 0($9)
lw $9, -24($sp)
move $8, $9
sw $8, -344($sp)
sw $31, -404($29)
li $8, 0
sw $8, -364($sp)
add $8, $29, -408
sw $8, -368($sp)
lw $8, -364($sp)
lw $9, -368($sp)
sw $8, 0($9)
lw $9, -24($sp)
lw $8, 0($9)
sw $8, -372($sp)
lw $9, -32($sp)
lw $8, 0($9)
sw $8, -376($sp)
lw $9, -372($sp)
lw $10, -376($sp)
sub $8, $9, $10
sw $8, -372($sp)
add $8, $29, -412
sw $8, -380($sp)
lw $8, -372($sp)
lw $9, -380($sp)
sw $8, 0($9)
add $29, $29, -412
jal __getMax
sub $29, $29, -412
lw $31, -404($29)
add $8, $29, -400
sw $8, -384($sp)
lw $9, -384($sp)
lw $8, 0($9)
sw $8, -360($sp)
lw $8, -360($sp)
lw $9, -344($sp)
sw $8, 0($9)
j label15
label16:
jr $ra
main:
la $a3, temp
la $t0, var0
sw $t0, 560($a3)
la $t0, var1
sw $t0, 564($a3)
la $t0, var2
sw $t0, 704($a3)
add $8, $29, -152
sw $8, -8($sp)
lw $9, -8($sp)
move $8, $9
sw $8, -4($sp)
lw $9, 560($a3)
move $8, $9
sw $8, -16($sp)
add $8, $29, -164
sw $8, -20($sp)
lw $8, -16($sp)
lw $9, -20($sp)
sw $8, 0($9)
add $29, $29, -164
jal __getString
sub $29, $29, -164
add $8, $29, -156
sw $8, -24($sp)
lw $9, -24($sp)
lw $8, 0($9)
sw $8, -12($sp)
lw $8, -12($sp)
lw $9, -4($sp)
sw $8, 0($9)
add $8, $29, -156
sw $8, -32($sp)
lw $9, -32($sp)
move $8, $9
sw $8, -28($sp)
add $8, $29, -160
sw $8, -40($sp)
lw $9, -40($sp)
move $8, $9
sw $8, -36($sp)
li $8, 0
sw $8, -44($sp)
lw $8, -44($sp)
lw $9, -36($sp)
sw $8, 0($9)
lw $9, 564($a3)
move $8, $9
sw $8, -52($sp)
add $8, $29, -168
sw $8, -56($sp)
lw $8, -52($sp)
lw $9, -56($sp)
sw $8, 0($9)
lw $9, 560($a3)
move $8, $9
sw $8, -60($sp)
add $8, $29, -172
sw $8, -64($sp)
lw $8, -60($sp)
lw $9, -64($sp)
sw $8, 0($9)
add $8, $29, -176
sw $8, -72($sp)
lw $9, -4($sp)
lw $8, 0($9)
sw $8, -68($sp)
lw $8, -68($sp)
lw $9, -72($sp)
sw $8, 0($9)
add $29, $29, -176
jal __Manacher
sub $29, $29, -176
lw $9, -32($sp)
move $8, $9
sw $8, -76($sp)
li $8, 0
sw $8, -80($sp)
lw $8, -80($sp)
lw $9, -76($sp)
sw $8, 0($9)
label23:
lw $9, -28($sp)
lw $8, 0($9)
sw $8, -84($sp)
lw $9, -4($sp)
lw $8, 0($9)
sw $8, -88($sp)
lw $9, -4($sp)
lw $8, 0($9)
sw $8, -92($sp)
lw $9, -88($sp)
lw $10, -92($sp)
add $8, $9, $10
sw $8, -88($sp)
lw $9, -84($sp)
lw $10, -88($sp)
sub $8, $9, $10
sw $8, -88($sp)
lw $8, -88($sp)
bgez $8, label24
lw $9, -36($sp)
move $8, $9
sw $8, -96($sp)
lw $9, -28($sp)
lw $8, 0($9)
sw $8, -104($sp)
lw $9, -104($sp)
mul $8, $9, 4
sw $8, -108($sp)
lw $9, 564($a3)
lw $10, -108($sp)
add $8, $9, $10
sw $8, -100($sp)
lw $9, -36($sp)
lw $8, 0($9)
sw $8, -112($sp)
lw $9, -100($sp)
lw $8, 0($9)
sw $8, -100($sp)
lw $9, -112($sp)
lw $10, -100($sp)
add $8, $9, $10
sw $8, -112($sp)
lw $8, -112($sp)
lw $9, -96($sp)
sw $8, 0($9)
label25:
lw $9, -28($sp)
move $8, $9
sw $8, -120($sp)
lw $9, -28($sp)
lw $8, 0($9)
sw $8, -116($sp)
lw $9, -116($sp)
add $8, $9, 1
sw $8, -116($sp)
lw $8, -116($sp)
lw $9, -120($sp)
sw $8, 0($9)
j label23
label24:
add $8, $29, -168
sw $8, -132($sp)
lw $9, -36($sp)
lw $8, 0($9)
sw $8, -128($sp)
lw $8, -128($sp)
lw $9, -132($sp)
sw $8, 0($9)
lw $9, 704($a3)
move $8, $9
sw $8, -136($sp)
add $8, $29, -172
sw $8, -140($sp)
lw $8, -136($sp)
lw $9, -140($sp)
sw $8, 0($9)
add $29, $29, -172
jal __printf
sub $29, $29, -172
li $8, 0
sw $8, -144($sp)
add $8, $29, 4
sw $8, -148($sp)
lw $8, -144($sp)
lw $9, -148($sp)
sw $8, 0($9)
j __main_end
j __main_end
__main_end:
li $v0, 10
syscall
#global $140 1028
#global $141 4100
#string $176 #%d\n
#----------------------------
#func #getString
#addi $2 $0 0
#addi $4 $0 -108
#move $3 $4
#li $5 0
#sw $5 $3 0
#label l:0
#addi $7 $0 -112
#move $6 $7
#sw $1 $0 -120
#addi $0 $0 -120
#call #getchar
#subi $0 $0 -120
#lw $1 $0 -120
#addi $9 $0 -116
####move $8 $9
#lw $8 $9 0
#sw $8 $6 0
#li $10 97
####move $11 $6
#lw $11 $6 0
#sub $11 $10 $11
#li $10 1
#blez $11 l:4
#li $10 0
#label l:4
#beqz $10 l:5
####move $10 $6
#lw $10 $6 0
#li $12 122
#sub $12 $10 $12
#li $10 1
#blez $12 l:6
#li $10 0
#label l:6
#label l:5
#andi $10 $10 1
#bnez $10 l:3
#li $13 65
####move $14 $6
#lw $14 $6 0
#sub $14 $13 $14
#li $13 1
#blez $14 l:7
#li $13 0
#label l:7
#beqz $13 l:8
####move $13 $6
#lw $13 $6 0
#li $15 90
#sub $15 $13 $15
#li $13 1
#blez $15 l:9
#li $13 0
#label l:9
#label l:8
#andi $13 $13 1
#beqz $13 l:2
#label l:3
####move $16 $2
#lw $16 $2 0
####move $17 $3
#move $19 $3
#lw $17 $3 0
#addi $20 $17 1
#sw $20 $19 0
#muli $18 $17 1
#add $16 $16 $18
####move $21 $6
#lb $21 $6 0
#sb $21 $16 0
#goto l:0
#label l:2
#goto l:1
#goto l:0
#label l:1
####move $22 $2
#lw $22 $2 0
####move $23 $3
#lw $23 $3 0
#muli $24 $23 1
#add $22 $22 $24
#li $25 0
#sb $25 $22 0
####move $26 $3
#addi $27 $0 8
#lw $26 $3 0
#sw $26 $27 0
#return
#return
#----------------------------
#func #getMax
#addi $28 $0 0
#addi $29 $0 4
####move $30 $28
#lw $30 $28 0
####move $31 $29
#lw $31 $29 0
#sub $31 $30 $31
#bgez $31 l:10
####move $32 $29
#addi $33 $0 12
#lw $32 $29 0
#sw $32 $33 0
#return
#label l:10
####move $34 $28
#addi $35 $0 12
#lw $34 $28 0
#sw $34 $35 0
#return
#return
#----------------------------
#func #getMin
#addi $36 $0 0
#addi $37 $0 4
####move $38 $36
#lw $38 $36 0
####move $39 $37
#lw $39 $37 0
#sub $39 $38 $39
#bgez $39 l:11
####move $40 $36
#addi $41 $0 12
#lw $40 $36 0
#sw $40 $41 0
#return
#label l:11
####move $42 $37
#addi $43 $0 12
#lw $42 $37 0
#sw $42 $43 0
#return
#return
#----------------------------
#func #Manacher
#addi $44 $0 0
#addi $45 $0 4
#addi $46 $0 8
#addi $48 $0 -388
#move $47 $48
#addi $50 $0 -392
#move $49 $50
#addi $52 $0 -396
#move $51 $52
#move $53 $48
#li $54 0
#sw $54 $53 0
#label l:12
####move $55 $47
#lw $55 $47 0
####move $56 $44
#lw $56 $44 0
####move $57 $44
#lw $57 $44 0
#add $56 $56 $57
#sub $56 $55 $56
#bgez $56 l:13
####move $58 $46
#lw $58 $46 0
####move $59 $47
#lw $59 $47 0
#muli $60 $59 4
#add $58 $58 $60
#li $61 0
#sw $61 $58 0
#label l:14
####move $62 $47
#move $63 $47
#lw $62 $47 0
#addi $62 $62 1
#sw $62 $63 0
#goto l:12
#label l:13
#move $65 $47
#li $66 0
#sw $66 $65 0
#move $67 $49
#li $68 0
#sw $68 $67 0
#move $64 $51
#label l:15
####move $69 $47
#lw $69 $47 0
####move $70 $44
#lw $70 $44 0
####move $71 $44
#lw $71 $44 0
#add $70 $70 $71
#sub $70 $69 $70
#bgez $70 l:16
#label l:18
####move $72 $47
#lw $72 $47 0
####move $73 $49
#lw $73 $49 0
#sub $72 $72 $73
#li $74 0
#sub $74 $72 $74
#bltz $74 l:19
####move $75 $47
#lw $75 $47 0
####move $76 $49
#lw $76 $49 0
#add $75 $75 $76
#li $77 1
#add $75 $75 $77
####move $78 $44
#lw $78 $44 0
#li $79 2
#mul $78 $78 $79
#sub $78 $75 $78
#bgez $78 l:19
####move $80 $45
#lw $80 $45 0
####move $81 $47
#lw $81 $47 0
####move $83 $49
#lw $83 $49 0
#sub $81 $81 $83
#li $84 2
#div $81 $81 $84
#muli $82 $81 1
#add $80 $80 $82
#lb $80 $80 0
####move $85 $45
#lw $85 $45 0
####move $86 $47
#lw $86 $47 0
####move $88 $49
#lw $88 $49 0
#add $86 $86 $88
#li $89 1
#add $86 $86 $89
#li $90 2
#div $86 $86 $90
#muli $87 $86 1
#add $85 $85 $87
#lb $85 $85 0
#sub $85 $80 $85
#bnez $85 l:19
####move $91 $49
#move $92 $49
#lw $91 $49 0
#addi $93 $91 1
#sw $93 $92 0
#goto l:18
#label l:19
####move $94 $46
#lw $94 $46 0
####move $95 $47
#lw $95 $47 0
#muli $96 $95 4
#add $94 $94 $96
####move $97 $49
#lw $97 $49 0
#sw $97 $94 0
#move $98 $51
#li $99 1
#sw $99 $98 0
#label l:20
####move $100 $47
#lw $100 $47 0
####move $101 $51
#lw $101 $51 0
#sub $100 $100 $101
#li $102 0
#sub $102 $100 $102
#bltz $102 l:21
####move $103 $49
#lw $103 $49 0
####move $104 $51
#lw $104 $51 0
#sub $103 $103 $104
#li $105 0
#sub $105 $103 $105
#bltz $105 l:21
####move $106 $46
#lw $106 $46 0
####move $107 $47
#lw $107 $47 0
####move $109 $51
#lw $109 $51 0
#sub $107 $107 $109
#muli $108 $107 4
#add $106 $106 $108
#lw $106 $106 0
####move $110 $49
#lw $110 $49 0
####move $111 $51
#lw $111 $51 0
#sub $110 $110 $111
#sub $110 $106 $110
#beqz $110 l:21
####move $112 $46
#lw $112 $46 0
####move $113 $47
#lw $113 $47 0
####move $115 $51
#lw $115 $51 0
#add $113 $113 $115
#muli $114 $113 4
#add $112 $112 $114
#sw $1 $0 -404
####move $117 $49
#lw $117 $49 0
####move $118 $51
#lw $118 $51 0
#sub $117 $117 $118
#addi $119 $0 -408
#sw $117 $119 0
####move $120 $46
#lw $120 $46 0
####move $121 $47
#lw $121 $47 0
####move $123 $51
#lw $123 $51 0
#sub $121 $121 $123
#muli $122 $121 4
#add $120 $120 $122
#addi $124 $0 -412
#lw $120 $120 0
#sw $120 $124 0
#addi $0 $0 -412
#call #getMin
#subi $0 $0 -412
#lw $1 $0 -404
#addi $125 $0 -400
####move $116 $125
#lw $116 $125 0
#sw $116 $112 0
#label l:22
####move $126 $51
#move $127 $51
#lw $126 $51 0
#addi $128 $126 1
#sw $128 $127 0
#goto l:20
#label l:21
#label l:17
#move $130 $47
####move $131 $51
#lw $132 $47 0
#lw $131 $51 0
#add $132 $132 $131
#sw $132 $130 0
#move $129 $49
#sw $1 $0 -404
#li $134 0
#addi $135 $0 -408
#sw $134 $135 0
####move $136 $49
#lw $136 $49 0
####move $137 $51
#lw $137 $51 0
#sub $136 $136 $137
#addi $138 $0 -412
#sw $136 $138 0
#addi $0 $0 -412
#call #getMax
#subi $0 $0 -412
#lw $1 $0 -404
#addi $139 $0 -400
####move $133 $139
#lw $133 $139 0
#sw $133 $129 0
#goto l:15
#label l:16
#return
#----------------------------
#func #main
#addi $143 $0 -152
#move $142 $143
#move $145 $140
#addi $146 $0 -164
#sw $145 $146 0
#addi $0 $0 -164
#call #getString
#subi $0 $0 -164
#addi $147 $0 -156
####move $144 $147
#lw $144 $147 0
#sw $144 $142 0
#addi $149 $0 -156
#move $148 $149
#addi $151 $0 -160
#move $150 $151
#li $152 0
#sw $152 $150 0
#move $154 $141
#addi $155 $0 -168
#sw $154 $155 0
#move $156 $140
#addi $157 $0 -172
#sw $156 $157 0
####move $158 $142
#addi $159 $0 -176
#lw $158 $142 0
#sw $158 $159 0
#addi $0 $0 -176
#call #Manacher
#subi $0 $0 -176
#move $160 $149
#li $161 0
#sw $161 $160 0
#label l:23
####move $162 $148
#lw $162 $148 0
####move $163 $142
#lw $163 $142 0
####move $164 $142
#lw $164 $142 0
#add $163 $163 $164
#sub $163 $162 $163
#bgez $163 l:24
#move $165 $150
####move $166 $141
####move $167 $148
#lw $167 $148 0
#muli $168 $167 4
#add $166 $141 $168
#lw $169 $150 0
#lw $166 $166 0
#add $169 $169 $166
#sw $169 $165 0
#label l:25
####move $170 $148
#move $171 $148
#lw $170 $148 0
#addi $170 $170 1
#sw $170 $171 0
#goto l:23
#label l:24
####move $173 $150
#addi $174 $0 -168
#lw $173 $150 0
#sw $173 $174 0
#move $175 $176
#addi $177 $0 -172
#sw $175 $177 0
#addi $0 $0 -172
#call #printf
#subi $0 $0 -172
#li $178 0
#addi $179 $0 4
#sw $178 $179 0
#return
#return
