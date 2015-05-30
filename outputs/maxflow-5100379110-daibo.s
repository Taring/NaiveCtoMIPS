.data
temp: .space 884
var0: .space 48400
var1: .space 4
var2: .space 440
var3: .space 440
var4: .space 440
var5: .space 4
var6: .space 4
var7: .space 4
var8: .space 4
var9: .asciiz "%d \n"
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

__build:
add $8, $29, 0
sw $8, -4($sp)
add $8, $29, 4
sw $8, -8($sp)
lw $9, 28($a3)
move $8, $9
sw $8, -12($sp)
li $8, 1
sw $8, -16($sp)
lw $8, -16($sp)
lw $9, -12($sp)
sw $8, 0($9)
label0:
lw $9, 28($a3)
lw $8, 0($9)
sw $8, -20($sp)
li $8, 49
sw $8, -24($sp)
lw $9, -20($sp)
lw $10, -24($sp)
sub $8, $9, $10
sw $8, -24($sp)
lw $8, -24($sp)
bgtz $8, label1
lw $9, 32($a3)
move $8, $9
sw $8, -28($sp)
li $8, 50
sw $8, -32($sp)
lw $8, -32($sp)
lw $9, -28($sp)
sw $8, 0($9)
label3:
lw $9, 32($a3)
lw $8, 0($9)
sw $8, -36($sp)
li $8, 98
sw $8, -40($sp)
lw $9, 28($a3)
lw $8, 0($9)
sw $8, -44($sp)
lw $9, -40($sp)
lw $10, -44($sp)
sub $8, $9, $10
sw $8, -40($sp)
li $8, 1
sw $8, -48($sp)
lw $9, -40($sp)
lw $10, -48($sp)
add $8, $9, $10
sw $8, -40($sp)
lw $9, -36($sp)
lw $10, -40($sp)
sub $8, $9, $10
sw $8, -40($sp)
lw $8, -40($sp)
bgtz $8, label4
lw $9, 28($a3)
lw $8, 0($9)
sw $8, -56($sp)
lw $9, -56($sp)
mul $8, $9, 440
sw $8, -60($sp)
lw $9, 8($a3)
lw $10, -60($sp)
add $8, $9, $10
sw $8, -52($sp)
lw $9, 32($a3)
lw $8, 0($9)
sw $8, -64($sp)
lw $9, -64($sp)
mul $8, $9, 4
sw $8, -68($sp)
lw $9, -52($sp)
lw $10, -68($sp)
add $8, $9, $10
sw $8, -52($sp)
li $8, 1
sw $8, -72($sp)
lw $8, -72($sp)
lw $9, -52($sp)
sw $8, 0($9)
label5:
lw $9, 32($a3)
move $8, $9
sw $8, -80($sp)
lw $9, 32($a3)
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
label2:
lw $9, 28($a3)
move $8, $9
sw $8, -92($sp)
lw $9, 28($a3)
lw $8, 0($9)
sw $8, -88($sp)
lw $9, -88($sp)
add $8, $9, 1
sw $8, -96($sp)
lw $8, -96($sp)
lw $9, -92($sp)
sw $8, 0($9)
j label0
label1:
lw $9, 28($a3)
move $8, $9
sw $8, -100($sp)
li $8, 1
sw $8, -104($sp)
lw $8, -104($sp)
lw $9, -100($sp)
sw $8, 0($9)
label6:
lw $9, 28($a3)
lw $8, 0($9)
sw $8, -108($sp)
li $8, 49
sw $8, -112($sp)
lw $9, -108($sp)
lw $10, -112($sp)
sub $8, $9, $10
sw $8, -112($sp)
lw $8, -112($sp)
bgtz $8, label7
lw $9, -4($sp)
lw $8, 0($9)
sw $8, -120($sp)
lw $9, -120($sp)
mul $8, $9, 440
sw $8, -124($sp)
lw $9, 8($a3)
lw $10, -124($sp)
add $8, $9, $10
sw $8, -116($sp)
lw $9, 28($a3)
lw $8, 0($9)
sw $8, -128($sp)
lw $9, -128($sp)
mul $8, $9, 4
sw $8, -132($sp)
lw $9, -116($sp)
lw $10, -132($sp)
add $8, $9, $10
sw $8, -116($sp)
li $8, 1
sw $8, -136($sp)
lw $8, -136($sp)
lw $9, -116($sp)
sw $8, 0($9)
label8:
lw $9, 28($a3)
move $8, $9
sw $8, -144($sp)
lw $9, 28($a3)
lw $8, 0($9)
sw $8, -140($sp)
lw $9, -140($sp)
add $8, $9, 1
sw $8, -148($sp)
lw $8, -148($sp)
lw $9, -144($sp)
sw $8, 0($9)
j label6
label7:
lw $9, 28($a3)
move $8, $9
sw $8, -152($sp)
li $8, 50
sw $8, -156($sp)
lw $8, -156($sp)
lw $9, -152($sp)
sw $8, 0($9)
label9:
lw $9, 28($a3)
lw $8, 0($9)
sw $8, -160($sp)
li $8, 98
sw $8, -164($sp)
lw $9, -160($sp)
lw $10, -164($sp)
sub $8, $9, $10
sw $8, -164($sp)
lw $8, -164($sp)
bgtz $8, label10
lw $9, 28($a3)
lw $8, 0($9)
sw $8, -172($sp)
lw $9, -172($sp)
mul $8, $9, 440
sw $8, -176($sp)
lw $9, 8($a3)
lw $10, -176($sp)
add $8, $9, $10
sw $8, -168($sp)
lw $9, -8($sp)
lw $8, 0($9)
sw $8, -180($sp)
lw $9, -180($sp)
mul $8, $9, 4
sw $8, -184($sp)
lw $9, -168($sp)
lw $10, -184($sp)
add $8, $9, $10
sw $8, -168($sp)
li $8, 1
sw $8, -188($sp)
lw $8, -188($sp)
lw $9, -168($sp)
sw $8, 0($9)
label11:
lw $9, 28($a3)
move $8, $9
sw $8, -196($sp)
lw $9, 28($a3)
lw $8, 0($9)
sw $8, -192($sp)
lw $9, -192($sp)
add $8, $9, 1
sw $8, -200($sp)
lw $8, -200($sp)
lw $9, -196($sp)
sw $8, 0($9)
j label9
label10:
li $8, 0
sw $8, -204($sp)
add $8, $29, 12
sw $8, -208($sp)
lw $8, -204($sp)
lw $9, -208($sp)
sw $8, 0($9)
jr $ra
jr $ra
__find:
add $8, $29, 0
sw $8, -4($sp)
add $8, $29, 4
sw $8, -8($sp)
add $8, $29, 8
sw $8, -12($sp)
lw $9, 36($a3)
move $8, $9
sw $8, -16($sp)
li $8, 0
sw $8, -20($sp)
lw $8, -20($sp)
lw $9, -16($sp)
sw $8, 0($9)
lw $9, 40($a3)
move $8, $9
sw $8, -24($sp)
li $8, 1
sw $8, -28($sp)
lw $8, -28($sp)
lw $9, -24($sp)
sw $8, 0($9)
lw $9, 28($a3)
move $8, $9
sw $8, -32($sp)
li $8, 1
sw $8, -36($sp)
lw $8, -36($sp)
lw $9, -32($sp)
sw $8, 0($9)
label12:
lw $9, 28($a3)
lw $8, 0($9)
sw $8, -40($sp)
lw $9, -4($sp)
lw $8, 0($9)
sw $8, -44($sp)
lw $9, -40($sp)
lw $10, -44($sp)
sub $8, $9, $10
sw $8, -44($sp)
lw $8, -44($sp)
bgtz $8, label13
lw $9, 28($a3)
lw $8, 0($9)
sw $8, -52($sp)
lw $9, -52($sp)
mul $8, $9, 4
sw $8, -56($sp)
lw $9, 16($a3)
lw $10, -56($sp)
add $8, $9, $10
sw $8, -48($sp)
li $8, 0
sw $8, -60($sp)
lw $8, -60($sp)
lw $9, -48($sp)
sw $8, 0($9)
label14:
lw $9, 28($a3)
move $8, $9
sw $8, -68($sp)
lw $9, 28($a3)
lw $8, 0($9)
sw $8, -64($sp)
lw $9, -64($sp)
add $8, $9, 1
sw $8, -72($sp)
lw $8, -72($sp)
lw $9, -68($sp)
sw $8, 0($9)
j label12
label13:
li $8, 1
sw $8, -80($sp)
lw $9, -80($sp)
mul $8, $9, 4
sw $8, -84($sp)
lw $9, 24($a3)
lw $10, -84($sp)
add $8, $9, $10
sw $8, -76($sp)
lw $9, -8($sp)
lw $8, 0($9)
sw $8, -88($sp)
lw $8, -88($sp)
lw $9, -76($sp)
sw $8, 0($9)
lw $9, -8($sp)
lw $8, 0($9)
sw $8, -96($sp)
lw $9, -96($sp)
mul $8, $9, 4
sw $8, -100($sp)
lw $9, 16($a3)
lw $10, -100($sp)
add $8, $9, $10
sw $8, -92($sp)
li $8, 1
sw $8, -104($sp)
lw $8, -104($sp)
lw $9, -92($sp)
sw $8, 0($9)
lw $9, -8($sp)
lw $8, 0($9)
sw $8, -112($sp)
lw $9, -112($sp)
mul $8, $9, 4
sw $8, -116($sp)
lw $9, 20($a3)
lw $10, -116($sp)
add $8, $9, $10
sw $8, -108($sp)
li $8, 0
sw $8, -120($sp)
lw $8, -120($sp)
lw $9, -108($sp)
sw $8, 0($9)
lw $9, -12($sp)
move $8, $9
sw $8, -124($sp)
li $8, 0
sw $8, -128($sp)
lw $8, -128($sp)
lw $9, -124($sp)
sw $8, 0($9)
label15:
lw $9, 36($a3)
lw $8, 0($9)
sw $8, -132($sp)
lw $9, 40($a3)
lw $8, 0($9)
sw $8, -136($sp)
lw $9, -132($sp)
lw $10, -136($sp)
sub $8, $9, $10
sw $8, -136($sp)
lw $8, -136($sp)
bgez $8, label16
lw $9, -12($sp)
lw $8, 0($9)
sw $8, -140($sp)
li $8, 0
sw $8, -144($sp)
lw $9, -140($sp)
lw $10, -144($sp)
sub $8, $9, $10
sw $8, -144($sp)
lw $8, -144($sp)
bnez $8, label16
lw $9, 36($a3)
move $8, $9
sw $8, -152($sp)
lw $9, 36($a3)
lw $8, 0($9)
sw $8, -148($sp)
lw $9, -148($sp)
add $8, $9, 1
sw $8, -156($sp)
lw $8, -156($sp)
lw $9, -152($sp)
sw $8, 0($9)
lw $9, 28($a3)
move $8, $9
sw $8, -160($sp)
lw $9, 36($a3)
lw $8, 0($9)
sw $8, -168($sp)
lw $9, -168($sp)
mul $8, $9, 4
sw $8, -172($sp)
lw $9, 24($a3)
lw $10, -172($sp)
add $8, $9, $10
sw $8, -164($sp)
lw $9, -164($sp)
lw $8, 0($9)
sw $8, -164($sp)
lw $8, -164($sp)
lw $9, -160($sp)
sw $8, 0($9)
lw $9, 32($a3)
move $8, $9
sw $8, -176($sp)
li $8, 1
sw $8, -180($sp)
lw $8, -180($sp)
lw $9, -176($sp)
sw $8, 0($9)
label17:
lw $9, 32($a3)
lw $8, 0($9)
sw $8, -184($sp)
lw $9, -4($sp)
lw $8, 0($9)
sw $8, -188($sp)
lw $9, -184($sp)
lw $10, -188($sp)
sub $8, $9, $10
sw $8, -188($sp)
lw $8, -188($sp)
bgtz $8, label18
lw $9, 28($a3)
lw $8, 0($9)
sw $8, -196($sp)
lw $9, -196($sp)
mul $8, $9, 440
sw $8, -200($sp)
lw $9, 8($a3)
lw $10, -200($sp)
add $8, $9, $10
sw $8, -192($sp)
lw $9, 32($a3)
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
li $8, 0
sw $8, -212($sp)
lw $9, -192($sp)
lw $10, -212($sp)
sub $8, $9, $10
sw $8, -212($sp)
lw $8, -212($sp)
blez $8, label20
lw $9, 32($a3)
lw $8, 0($9)
sw $8, -220($sp)
lw $9, -220($sp)
mul $8, $9, 4
sw $8, -224($sp)
lw $9, 16($a3)
lw $10, -224($sp)
add $8, $9, $10
sw $8, -216($sp)
lw $9, -216($sp)
lw $8, 0($9)
sw $8, -216($sp)
li $8, 0
sw $8, -228($sp)
lw $9, -216($sp)
lw $10, -228($sp)
sub $8, $9, $10
sw $8, -228($sp)
lw $8, -228($sp)
bnez $8, label20
lw $9, 32($a3)
lw $8, 0($9)
sw $8, -236($sp)
lw $9, -236($sp)
mul $8, $9, 4
sw $8, -240($sp)
lw $9, 16($a3)
lw $10, -240($sp)
add $8, $9, $10
sw $8, -232($sp)
li $8, 1
sw $8, -244($sp)
lw $8, -244($sp)
lw $9, -232($sp)
sw $8, 0($9)
lw $9, 40($a3)
move $8, $9
sw $8, -252($sp)
lw $9, 40($a3)
lw $8, 0($9)
sw $8, -248($sp)
lw $9, -248($sp)
add $8, $9, 1
sw $8, -256($sp)
lw $8, -256($sp)
lw $9, -252($sp)
sw $8, 0($9)
lw $9, 40($a3)
lw $8, 0($9)
sw $8, -264($sp)
lw $9, -264($sp)
mul $8, $9, 4
sw $8, -268($sp)
lw $9, 24($a3)
lw $10, -268($sp)
add $8, $9, $10
sw $8, -260($sp)
lw $9, 32($a3)
lw $8, 0($9)
sw $8, -272($sp)
lw $8, -272($sp)
lw $9, -260($sp)
sw $8, 0($9)
lw $9, 32($a3)
lw $8, 0($9)
sw $8, -280($sp)
lw $9, -280($sp)
mul $8, $9, 4
sw $8, -284($sp)
lw $9, 20($a3)
lw $10, -284($sp)
add $8, $9, $10
sw $8, -276($sp)
lw $9, 28($a3)
lw $8, 0($9)
sw $8, -288($sp)
lw $8, -288($sp)
lw $9, -276($sp)
sw $8, 0($9)
lw $9, 40($a3)
lw $8, 0($9)
sw $8, -292($sp)
lw $9, -4($sp)
lw $8, 0($9)
sw $8, -296($sp)
lw $9, -292($sp)
lw $10, -296($sp)
sub $8, $9, $10
sw $8, -296($sp)
lw $8, -296($sp)
bnez $8, label21
lw $9, -12($sp)
move $8, $9
sw $8, -300($sp)
li $8, 1
sw $8, -304($sp)
lw $8, -304($sp)
lw $9, -300($sp)
sw $8, 0($9)
label21:
label20:
label19:
lw $9, 32($a3)
move $8, $9
sw $8, -312($sp)
lw $9, 32($a3)
lw $8, 0($9)
sw $8, -308($sp)
lw $9, -308($sp)
add $8, $9, 1
sw $8, -316($sp)
lw $8, -316($sp)
lw $9, -312($sp)
sw $8, 0($9)
j label17
label18:
j label15
label16:
add $8, $29, 16
sw $8, -324($sp)
lw $9, -12($sp)
lw $8, 0($9)
sw $8, -320($sp)
lw $8, -320($sp)
lw $9, -324($sp)
sw $8, 0($9)
jr $ra
jr $ra
__improve:
add $8, $29, 0
sw $8, -4($sp)
lw $9, 28($a3)
move $8, $9
sw $8, -8($sp)
lw $9, -4($sp)
lw $8, 0($9)
sw $8, -12($sp)
lw $8, -12($sp)
lw $9, -8($sp)
sw $8, 0($9)
lw $9, 12($a3)
move $8, $9
sw $8, -20($sp)
lw $9, 12($a3)
lw $8, 0($9)
sw $8, -16($sp)
lw $9, -16($sp)
add $8, $9, 1
sw $8, -24($sp)
lw $8, -24($sp)
lw $9, -20($sp)
sw $8, 0($9)
label22:
lw $9, 28($a3)
lw $8, 0($9)
sw $8, -32($sp)
lw $9, -32($sp)
mul $8, $9, 4
sw $8, -36($sp)
lw $9, 20($a3)
lw $10, -36($sp)
add $8, $9, $10
sw $8, -28($sp)
lw $9, -28($sp)
lw $8, 0($9)
sw $8, -28($sp)
li $8, 0
sw $8, -40($sp)
lw $9, -28($sp)
lw $10, -40($sp)
sub $8, $9, $10
sw $8, -40($sp)
lw $8, -40($sp)
blez $8, label23
lw $9, 32($a3)
move $8, $9
sw $8, -44($sp)
lw $9, 28($a3)
lw $8, 0($9)
sw $8, -52($sp)
lw $9, -52($sp)
mul $8, $9, 4
sw $8, -56($sp)
lw $9, 20($a3)
lw $10, -56($sp)
add $8, $9, $10
sw $8, -48($sp)
lw $9, -48($sp)
lw $8, 0($9)
sw $8, -48($sp)
lw $8, -48($sp)
lw $9, -44($sp)
sw $8, 0($9)
lw $9, 32($a3)
lw $8, 0($9)
sw $8, -64($sp)
lw $9, -64($sp)
mul $8, $9, 440
sw $8, -68($sp)
lw $9, 8($a3)
lw $10, -68($sp)
add $8, $9, $10
sw $8, -60($sp)
lw $9, 28($a3)
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
move $8, $9
sw $8, -80($sp)
lw $9, -60($sp)
lw $8, 0($9)
sw $8, -60($sp)
lw $9, -60($sp)
sub $8, $9, 1
sw $8, -84($sp)
lw $8, -84($sp)
lw $9, -80($sp)
sw $8, 0($9)
lw $9, 28($a3)
lw $8, 0($9)
sw $8, -92($sp)
lw $9, -92($sp)
mul $8, $9, 440
sw $8, -96($sp)
lw $9, 8($a3)
lw $10, -96($sp)
add $8, $9, $10
sw $8, -88($sp)
lw $9, 32($a3)
lw $8, 0($9)
sw $8, -100($sp)
lw $9, -100($sp)
mul $8, $9, 4
sw $8, -104($sp)
lw $9, -88($sp)
lw $10, -104($sp)
add $8, $9, $10
sw $8, -88($sp)
lw $9, -88($sp)
move $8, $9
sw $8, -108($sp)
lw $9, -88($sp)
lw $8, 0($9)
sw $8, -88($sp)
lw $9, -88($sp)
add $8, $9, 1
sw $8, -112($sp)
lw $8, -112($sp)
lw $9, -108($sp)
sw $8, 0($9)
lw $9, 28($a3)
move $8, $9
sw $8, -116($sp)
lw $9, 32($a3)
lw $8, 0($9)
sw $8, -120($sp)
lw $8, -120($sp)
lw $9, -116($sp)
sw $8, 0($9)
j label22
label23:
li $8, 0
sw $8, -124($sp)
add $8, $29, 8
sw $8, -128($sp)
lw $8, -124($sp)
lw $9, -128($sp)
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
sw $t0, 868($a3)
add $8, $29, -180
sw $8, -8($sp)
lw $9, -8($sp)
move $8, $9
sw $8, -4($sp)
add $8, $29, -184
sw $8, -16($sp)
lw $9, -16($sp)
move $8, $9
sw $8, -12($sp)
add $8, $29, -188
sw $8, -24($sp)
lw $9, -24($sp)
move $8, $9
sw $8, -20($sp)
add $8, $29, -192
sw $8, -32($sp)
lw $9, -32($sp)
move $8, $9
sw $8, -28($sp)
add $8, $29, -196
sw $8, -40($sp)
lw $9, -40($sp)
move $8, $9
sw $8, -36($sp)
lw $9, -8($sp)
move $8, $9
sw $8, -44($sp)
li $8, 0
sw $8, -48($sp)
lw $8, -48($sp)
lw $9, -44($sp)
sw $8, 0($9)
lw $9, -16($sp)
move $8, $9
sw $8, -52($sp)
li $8, 99
sw $8, -56($sp)
lw $8, -56($sp)
lw $9, -52($sp)
sw $8, 0($9)
lw $9, -24($sp)
move $8, $9
sw $8, -60($sp)
li $8, 100
sw $8, -64($sp)
lw $8, -64($sp)
lw $9, -60($sp)
sw $8, 0($9)
lw $9, -32($sp)
move $8, $9
sw $8, -68($sp)
li $8, 0
sw $8, -72($sp)
lw $8, -72($sp)
lw $9, -68($sp)
sw $8, 0($9)
add $8, $29, -208
sw $8, -84($sp)
lw $9, -24($sp)
lw $8, 0($9)
sw $8, -80($sp)
lw $8, -80($sp)
lw $9, -84($sp)
sw $8, 0($9)
add $8, $29, -212
sw $8, -92($sp)
lw $9, -16($sp)
lw $8, 0($9)
sw $8, -88($sp)
lw $8, -88($sp)
lw $9, -92($sp)
sw $8, 0($9)
add $29, $29, -212
jal __build
sub $29, $29, -212
add $8, $29, -200
sw $8, -96($sp)
lw $9, -96($sp)
move $8, $9
sw $8, -76($sp)
label24:
add $8, $29, -208
sw $8, -108($sp)
lw $9, -28($sp)
lw $8, 0($9)
sw $8, -104($sp)
lw $8, -104($sp)
lw $9, -108($sp)
sw $8, 0($9)
add $8, $29, -212
sw $8, -116($sp)
lw $9, -12($sp)
lw $8, 0($9)
sw $8, -112($sp)
lw $8, -112($sp)
lw $9, -116($sp)
sw $8, 0($9)
add $8, $29, -216
sw $8, -124($sp)
lw $9, -20($sp)
lw $8, 0($9)
sw $8, -120($sp)
lw $8, -120($sp)
lw $9, -124($sp)
sw $8, 0($9)
add $29, $29, -216
jal __find
sub $29, $29, -216
add $8, $29, -200
sw $8, -128($sp)
lw $9, -128($sp)
lw $8, 0($9)
sw $8, -100($sp)
li $8, 0
sw $8, -132($sp)
lw $9, -100($sp)
lw $10, -132($sp)
sub $8, $9, $10
sw $8, -132($sp)
lw $8, -132($sp)
blez $8, label25
add $8, $29, -208
sw $8, -144($sp)
lw $9, -20($sp)
lw $8, 0($9)
sw $8, -140($sp)
lw $8, -140($sp)
lw $9, -144($sp)
sw $8, 0($9)
add $29, $29, -208
jal __improve
sub $29, $29, -208
add $8, $29, -200
sw $8, -148($sp)
lw $9, -148($sp)
move $8, $9
sw $8, -136($sp)
j label24
label25:
add $8, $29, -204
sw $8, -160($sp)
lw $9, 12($a3)
lw $8, 0($9)
sw $8, -156($sp)
lw $8, -156($sp)
lw $9, -160($sp)
sw $8, 0($9)
lw $9, 868($a3)
move $8, $9
sw $8, -164($sp)
add $8, $29, -208
sw $8, -168($sp)
lw $8, -164($sp)
lw $9, -168($sp)
sw $8, 0($9)
add $29, $29, -208
jal __printf
sub $29, $29, -208
li $8, 0
sw $8, -172($sp)
add $8, $29, 4
sw $8, -176($sp)
lw $8, -172($sp)
lw $9, -176($sp)
sw $8, 0($9)
j __main_end
j __main_end
__main_end:
li $v0, 10
syscall
#global $2 48400
#global $3 4
#global $4 440
#global $5 440
#global $6 440
#global $7 4
#global $8 4
#global $9 4
#global $10 4
#string $217 #%d \n
#----------------------------
#func #build
#addi $11 $0 0
#addi $12 $0 4
#move $13 $7
#li $14 1
#sw $14 $13 0
#label l:0
####move $15 $7
#lw $15 $7 0
#li $16 49
#sub $16 $15 $16
#bgtz $16 l:1
#move $17 $8
#li $18 50
#sw $18 $17 0
#label l:3
####move $19 $8
#lw $19 $8 0
#li $20 98
####move $21 $7
#lw $21 $7 0
#sub $20 $20 $21
#li $22 1
#add $20 $20 $22
#sub $20 $19 $20
#bgtz $20 l:4
####move $23 $2
####move $24 $7
#lw $24 $7 0
#muli $25 $24 440
#add $23 $2 $25
####move $26 $8
#lw $26 $8 0
#muli $27 $26 4
#add $23 $23 $27
#li $28 1
#sw $28 $23 0
#label l:5
####move $29 $8
#move $30 $8
#lw $29 $8 0
#addi $31 $29 1
#sw $31 $30 0
#goto l:3
#label l:4
#label l:2
####move $32 $7
#move $33 $7
#lw $32 $7 0
#addi $34 $32 1
#sw $34 $33 0
#goto l:0
#label l:1
#move $35 $7
#li $36 1
#sw $36 $35 0
#label l:6
####move $37 $7
#lw $37 $7 0
#li $38 49
#sub $38 $37 $38
#bgtz $38 l:7
####move $39 $2
####move $40 $11
#lw $40 $11 0
#muli $41 $40 440
#add $39 $2 $41
####move $42 $7
#lw $42 $7 0
#muli $43 $42 4
#add $39 $39 $43
#li $44 1
#sw $44 $39 0
#label l:8
####move $45 $7
#move $46 $7
#lw $45 $7 0
#addi $47 $45 1
#sw $47 $46 0
#goto l:6
#label l:7
#move $48 $7
#li $49 50
#sw $49 $48 0
#label l:9
####move $50 $7
#lw $50 $7 0
#li $51 98
#sub $51 $50 $51
#bgtz $51 l:10
####move $52 $2
####move $53 $7
#lw $53 $7 0
#muli $54 $53 440
#add $52 $2 $54
####move $55 $12
#lw $55 $12 0
#muli $56 $55 4
#add $52 $52 $56
#li $57 1
#sw $57 $52 0
#label l:11
####move $58 $7
#move $59 $7
#lw $58 $7 0
#addi $60 $58 1
#sw $60 $59 0
#goto l:9
#label l:10
#li $61 0
#addi $62 $0 12
#sw $61 $62 0
#return
#return
#----------------------------
#func #find
#addi $63 $0 0
#addi $64 $0 4
#addi $65 $0 8
#move $66 $9
#li $67 0
#sw $67 $66 0
#move $68 $10
#li $69 1
#sw $69 $68 0
#move $70 $7
#li $71 1
#sw $71 $70 0
#label l:12
####move $72 $7
#lw $72 $7 0
####move $73 $63
#lw $73 $63 0
#sub $73 $72 $73
#bgtz $73 l:13
####move $74 $4
####move $75 $7
#lw $75 $7 0
#muli $76 $75 4
#add $74 $4 $76
#li $77 0
#sw $77 $74 0
#label l:14
####move $78 $7
#move $79 $7
#lw $78 $7 0
#addi $80 $78 1
#sw $80 $79 0
#goto l:12
#label l:13
####move $81 $6
#li $82 1
#muli $83 $82 4
#add $81 $6 $83
####move $84 $64
#lw $84 $64 0
#sw $84 $81 0
####move $85 $4
####move $86 $64
#lw $86 $64 0
#muli $87 $86 4
#add $85 $4 $87
#li $88 1
#sw $88 $85 0
####move $89 $5
####move $90 $64
#lw $90 $64 0
#muli $91 $90 4
#add $89 $5 $91
#li $92 0
#sw $92 $89 0
#move $93 $65
#li $94 0
#sw $94 $93 0
#label l:15
####move $95 $9
#lw $95 $9 0
####move $96 $10
#lw $96 $10 0
#sub $96 $95 $96
#bgez $96 l:16
####move $97 $65
#lw $97 $65 0
#li $98 0
#sub $98 $97 $98
#bnez $98 l:16
####move $99 $9
#move $100 $9
#lw $99 $9 0
#addi $101 $99 1
#sw $101 $100 0
#move $102 $7
####move $103 $6
####move $104 $9
#lw $104 $9 0
#muli $105 $104 4
#add $103 $6 $105
#lw $103 $103 0
#sw $103 $102 0
#move $106 $8
#li $107 1
#sw $107 $106 0
#label l:17
####move $108 $8
#lw $108 $8 0
####move $109 $63
#lw $109 $63 0
#sub $109 $108 $109
#bgtz $109 l:18
####move $110 $2
####move $111 $7
#lw $111 $7 0
#muli $112 $111 440
#add $110 $2 $112
####move $113 $8
#lw $113 $8 0
#muli $114 $113 4
#add $110 $110 $114
#lw $110 $110 0
#li $115 0
#sub $115 $110 $115
#blez $115 l:20
####move $116 $4
####move $117 $8
#lw $117 $8 0
#muli $118 $117 4
#add $116 $4 $118
#lw $116 $116 0
#li $119 0
#sub $119 $116 $119
#bnez $119 l:20
####move $120 $4
####move $121 $8
#lw $121 $8 0
#muli $122 $121 4
#add $120 $4 $122
#li $123 1
#sw $123 $120 0
####move $124 $10
#move $125 $10
#lw $124 $10 0
#addi $126 $124 1
#sw $126 $125 0
####move $127 $6
####move $128 $10
#lw $128 $10 0
#muli $129 $128 4
#add $127 $6 $129
####move $130 $8
#lw $130 $8 0
#sw $130 $127 0
####move $131 $5
####move $132 $8
#lw $132 $8 0
#muli $133 $132 4
#add $131 $5 $133
####move $134 $7
#lw $134 $7 0
#sw $134 $131 0
####move $135 $10
#lw $135 $10 0
####move $136 $63
#lw $136 $63 0
#sub $136 $135 $136
#bnez $136 l:21
#move $137 $65
#li $138 1
#sw $138 $137 0
#label l:21
#label l:20
#label l:19
####move $139 $8
#move $140 $8
#lw $139 $8 0
#addi $141 $139 1
#sw $141 $140 0
#goto l:17
#label l:18
#goto l:15
#label l:16
####move $142 $65
#addi $143 $0 16
#lw $142 $65 0
#sw $142 $143 0
#return
#return
#----------------------------
#func #improve
#addi $144 $0 0
#move $145 $7
####move $146 $144
#lw $146 $144 0
#sw $146 $145 0
####move $147 $3
#move $148 $3
#lw $147 $3 0
#addi $149 $147 1
#sw $149 $148 0
#label l:22
####move $150 $5
####move $151 $7
#lw $151 $7 0
#muli $152 $151 4
#add $150 $5 $152
#lw $150 $150 0
#li $153 0
#sub $153 $150 $153
#blez $153 l:23
#move $154 $8
####move $155 $5
####move $156 $7
#lw $156 $7 0
#muli $157 $156 4
#add $155 $5 $157
#lw $155 $155 0
#sw $155 $154 0
####move $158 $2
####move $159 $8
#lw $159 $8 0
#muli $160 $159 440
#add $158 $2 $160
####move $161 $7
#lw $161 $7 0
#muli $162 $161 4
#add $158 $158 $162
#move $163 $158
#lw $158 $158 0
#subi $164 $158 1
#sw $164 $163 0
####move $165 $2
####move $166 $7
#lw $166 $7 0
#muli $167 $166 440
#add $165 $2 $167
####move $168 $8
#lw $168 $8 0
#muli $169 $168 4
#add $165 $165 $169
#move $170 $165
#lw $165 $165 0
#addi $171 $165 1
#sw $171 $170 0
#move $172 $7
####move $173 $8
#lw $173 $8 0
#sw $173 $172 0
#goto l:22
#label l:23
#li $174 0
#addi $175 $0 8
#sw $174 $175 0
#return
#return
#----------------------------
#func #main
#addi $177 $0 -180
#move $176 $177
#addi $179 $0 -184
#move $178 $179
#addi $181 $0 -188
#move $180 $181
#addi $183 $0 -192
#move $182 $183
#addi $185 $0 -196
#move $184 $185
#move $186 $177
#li $187 0
#sw $187 $186 0
#move $188 $179
#li $189 99
#sw $189 $188 0
#move $190 $181
#li $191 100
#sw $191 $190 0
#move $192 $183
#li $193 0
#sw $193 $192 0
####move $195 $181
#addi $196 $0 -208
#lw $195 $181 0
#sw $195 $196 0
####move $197 $179
#addi $198 $0 -212
#lw $197 $179 0
#sw $197 $198 0
#addi $0 $0 -212
#call #build
#subi $0 $0 -212
#addi $199 $0 -200
#move $194 $199
#label l:24
####move $201 $182
#addi $202 $0 -208
#lw $201 $182 0
#sw $201 $202 0
####move $203 $178
#addi $204 $0 -212
#lw $203 $178 0
#sw $203 $204 0
####move $205 $180
#addi $206 $0 -216
#lw $205 $180 0
#sw $205 $206 0
#addi $0 $0 -216
#call #find
#subi $0 $0 -216
#addi $207 $0 -200
####move $200 $207
#lw $200 $207 0
#li $208 0
#sub $208 $200 $208
#blez $208 l:25
####move $210 $180
#addi $211 $0 -208
#lw $210 $180 0
#sw $210 $211 0
#addi $0 $0 -208
#call #improve
#subi $0 $0 -208
#addi $212 $0 -200
#move $209 $212
#goto l:24
#label l:25
####move $214 $3
#addi $215 $0 -204
#lw $214 $3 0
#sw $214 $215 0
#move $216 $217
#addi $218 $0 -208
#sw $216 $218 0
#addi $0 $0 -208
#call #printf
#subi $0 $0 -208
#li $219 0
#addi $220 $0 4
#sw $219 $220 0
#return
#return
