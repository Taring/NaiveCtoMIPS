.data
temp: .space 1064
var0: .space 3740
var1: .space 4
var2: .space 4
var3: .space 80
var4: .space 6400
var5: .asciiz "%d"
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

__Levelup:
add $8, $29, 0
sw $8, -4($sp)
lw $9, -4($sp)
lw $8, 0($9)
sw $8, -12($sp)
lw $9, -12($sp)
mul $8, $9, 340
sw $8, -16($sp)
lw $9, 8($a3)
lw $10, -16($sp)
add $8, $9, $10
sw $8, -8($sp)
lw $9, -8($sp)
add $8, $9, 0
sw $8, -8($sp)
lw $9, -8($sp)
lw $8, 0($9)
sw $8, -8($sp)
li $8, 5
sw $8, -20($sp)
lw $9, -8($sp)
lw $10, -20($sp)
sub $8, $9, $10
sw $8, -20($sp)
lw $8, -20($sp)
blez $8, label0
lw $9, -4($sp)
lw $8, 0($9)
sw $8, -28($sp)
lw $9, -28($sp)
mul $8, $9, 340
sw $8, -32($sp)
lw $9, 8($a3)
lw $10, -32($sp)
add $8, $9, $10
sw $8, -24($sp)
lw $9, -24($sp)
add $8, $9, 28
sw $8, -24($sp)
lw $9, -24($sp)
move $8, $9
sw $8, -36($sp)
lw $9, -24($sp)
lw $8, 0($9)
sw $8, -24($sp)
lw $9, -24($sp)
add $8, $9, 1
sw $8, -40($sp)
lw $8, -40($sp)
lw $9, -36($sp)
sw $8, 0($9)
j label1
label0:
lw $9, -4($sp)
lw $8, 0($9)
sw $8, -48($sp)
lw $9, -48($sp)
mul $8, $9, 340
sw $8, -52($sp)
lw $9, 8($a3)
lw $10, -52($sp)
add $8, $9, $10
sw $8, -44($sp)
lw $9, -44($sp)
add $8, $9, 0
sw $8, -44($sp)
lw $9, -44($sp)
lw $8, 0($9)
sw $8, -44($sp)
li $8, 0
sw $8, -56($sp)
lw $9, -44($sp)
lw $10, -56($sp)
sub $8, $9, $10
sw $8, -56($sp)
lw $8, -56($sp)
blez $8, label2
lw $9, -4($sp)
lw $8, 0($9)
sw $8, -64($sp)
lw $9, -64($sp)
mul $8, $9, 340
sw $8, -68($sp)
lw $9, 8($a3)
lw $10, -68($sp)
add $8, $9, $10
sw $8, -60($sp)
lw $9, -60($sp)
add $8, $9, 32
sw $8, -60($sp)
lw $9, -60($sp)
move $8, $9
sw $8, -72($sp)
lw $9, -60($sp)
lw $8, 0($9)
sw $8, -60($sp)
lw $9, -60($sp)
add $8, $9, 1
sw $8, -76($sp)
lw $8, -76($sp)
lw $9, -72($sp)
sw $8, 0($9)
j label3
label2:
jr $ra
label3:
label1:
lw $9, -4($sp)
lw $8, 0($9)
sw $8, -84($sp)
lw $9, -84($sp)
mul $8, $9, 340
sw $8, -88($sp)
lw $9, 8($a3)
lw $10, -88($sp)
add $8, $9, $10
sw $8, -80($sp)
lw $9, -80($sp)
add $8, $9, 0
sw $8, -80($sp)
lw $9, -80($sp)
move $8, $9
sw $8, -92($sp)
lw $9, -80($sp)
lw $8, 0($9)
sw $8, -80($sp)
lw $9, -80($sp)
sub $8, $9, 1
sw $8, -96($sp)
lw $8, -96($sp)
lw $9, -92($sp)
sw $8, 0($9)
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
sw $t0, 1056($a3)
add $8, $29, -940
sw $8, -8($sp)
lw $9, -8($sp)
move $8, $9
sw $8, -4($sp)
li $8, 0
sw $8, -12($sp)
lw $8, -12($sp)
lw $9, -4($sp)
sw $8, 0($9)
add $8, $29, -944
sw $8, -20($sp)
lw $9, -20($sp)
move $8, $9
sw $8, -16($sp)
add $29, $29, -952
jal __getchar
sub $29, $29, -952
add $8, $29, -948
sw $8, -28($sp)
lw $9, -28($sp)
lw $8, 0($9)
sw $8, -24($sp)
lw $8, -24($sp)
lw $9, -16($sp)
sw $8, 0($9)
add $8, $29, -948
sw $8, -36($sp)
lw $9, -36($sp)
move $8, $9
sw $8, -32($sp)
add $8, $29, -952
sw $8, -44($sp)
lw $9, -44($sp)
move $8, $9
sw $8, -40($sp)
add $8, $29, -956
sw $8, -52($sp)
lw $9, -52($sp)
move $8, $9
sw $8, -48($sp)
add $8, $29, -960
sw $8, -60($sp)
lw $9, -60($sp)
move $8, $9
sw $8, -56($sp)
add $8, $29, -964
sw $8, -68($sp)
lw $9, -68($sp)
move $8, $9
sw $8, -64($sp)
lw $9, 12($a3)
move $8, $9
sw $8, -72($sp)
li $8, 1
sw $8, -76($sp)
lw $8, -76($sp)
lw $9, -72($sp)
sw $8, 0($9)
label4:
lw $9, 12($a3)
lw $8, 0($9)
sw $8, -80($sp)
li $8, 10
sw $8, -84($sp)
lw $9, -80($sp)
lw $10, -84($sp)
sub $8, $9, $10
sw $8, -84($sp)
lw $8, -84($sp)
bgtz $8, label5
lw $9, 12($a3)
lw $8, 0($9)
sw $8, -92($sp)
lw $9, -92($sp)
mul $8, $9, 340
sw $8, -96($sp)
lw $9, 8($a3)
lw $10, -96($sp)
add $8, $9, $10
sw $8, -88($sp)
lw $9, -88($sp)
add $8, $9, 0
sw $8, -88($sp)
lw $9, 12($a3)
lw $8, 0($9)
sw $8, -100($sp)
li $8, 2
sw $8, -104($sp)
lw $9, -100($sp)
lw $10, -104($sp)
mul $8, $9, $10
sw $8, -100($sp)
lw $9, -16($sp)
lw $8, 0($9)
sw $8, -108($sp)
lw $9, -100($sp)
lw $10, -108($sp)
add $8, $9, $10
sw $8, -100($sp)
lw $8, -100($sp)
lw $9, -88($sp)
sw $8, 0($9)
lw $9, 12($a3)
lw $8, 0($9)
sw $8, -116($sp)
lw $9, -116($sp)
mul $8, $9, 340
sw $8, -120($sp)
lw $9, 8($a3)
lw $10, -120($sp)
add $8, $9, $10
sw $8, -112($sp)
lw $9, -112($sp)
add $8, $9, 4
sw $8, -112($sp)
li $8, 1
sw $8, -124($sp)
lw $8, -124($sp)
lw $9, -112($sp)
sw $8, 0($9)
lw $9, 12($a3)
lw $8, 0($9)
sw $8, -132($sp)
lw $9, -132($sp)
mul $8, $9, 340
sw $8, -136($sp)
lw $9, 8($a3)
lw $10, -136($sp)
add $8, $9, $10
sw $8, -128($sp)
lw $9, -128($sp)
add $8, $9, 8
sw $8, -128($sp)
li $8, 0
sw $8, -140($sp)
lw $8, -140($sp)
lw $9, -128($sp)
sw $8, 0($9)
lw $9, 12($a3)
lw $8, 0($9)
sw $8, -148($sp)
lw $9, -148($sp)
mul $8, $9, 340
sw $8, -152($sp)
lw $9, 8($a3)
lw $10, -152($sp)
add $8, $9, $10
sw $8, -144($sp)
lw $9, -144($sp)
add $8, $9, 20
sw $8, -144($sp)
lw $9, 12($a3)
lw $8, 0($9)
sw $8, -160($sp)
lw $9, -160($sp)
mul $8, $9, 340
sw $8, -164($sp)
lw $9, 8($a3)
lw $10, -164($sp)
add $8, $9, $10
sw $8, -156($sp)
lw $9, -156($sp)
add $8, $9, 24
sw $8, -156($sp)
li $8, 0
sw $8, -168($sp)
lw $8, -168($sp)
lw $9, -156($sp)
sw $8, 0($9)
lw $9, -156($sp)
lw $8, 0($9)
sw $8, -156($sp)
lw $8, -156($sp)
lw $9, -144($sp)
sw $8, 0($9)
lw $9, 12($a3)
lw $8, 0($9)
sw $8, -176($sp)
lw $9, -176($sp)
mul $8, $9, 340
sw $8, -180($sp)
lw $9, 8($a3)
lw $10, -180($sp)
add $8, $9, $10
sw $8, -172($sp)
lw $9, -172($sp)
add $8, $9, 28
sw $8, -172($sp)
lw $9, 12($a3)
lw $8, 0($9)
sw $8, -188($sp)
lw $9, -188($sp)
mul $8, $9, 340
sw $8, -192($sp)
lw $9, 8($a3)
lw $10, -192($sp)
add $8, $9, $10
sw $8, -184($sp)
lw $9, -184($sp)
add $8, $9, 32
sw $8, -184($sp)
li $8, 0
sw $8, -196($sp)
lw $8, -196($sp)
lw $9, -184($sp)
sw $8, 0($9)
lw $9, -184($sp)
lw $8, 0($9)
sw $8, -184($sp)
lw $8, -184($sp)
lw $9, -172($sp)
sw $8, 0($9)
lw $9, 12($a3)
lw $8, 0($9)
sw $8, -204($sp)
lw $9, -204($sp)
mul $8, $9, 340
sw $8, -208($sp)
lw $9, 8($a3)
lw $10, -208($sp)
add $8, $9, $10
sw $8, -200($sp)
lw $9, -200($sp)
add $8, $9, 36
sw $8, -200($sp)
lw $9, 12($a3)
lw $8, 0($9)
sw $8, -216($sp)
lw $9, -216($sp)
mul $8, $9, 340
sw $8, -220($sp)
lw $9, 8($a3)
lw $10, -220($sp)
add $8, $9, $10
sw $8, -212($sp)
lw $9, -212($sp)
add $8, $9, 72
sw $8, -212($sp)
li $8, 0
sw $8, -224($sp)
lw $8, -224($sp)
lw $9, -212($sp)
sw $8, 0($9)
lw $9, -212($sp)
lw $8, 0($9)
sw $8, -212($sp)
lw $8, -212($sp)
lw $9, -200($sp)
sw $8, 0($9)
lw $9, 12($a3)
lw $8, 0($9)
sw $8, -232($sp)
lw $9, -232($sp)
mul $8, $9, 340
sw $8, -236($sp)
lw $9, 8($a3)
lw $10, -236($sp)
add $8, $9, $10
sw $8, -228($sp)
lw $9, -228($sp)
add $8, $9, 76
sw $8, -228($sp)
lw $9, 12($a3)
lw $8, 0($9)
sw $8, -244($sp)
lw $9, -244($sp)
mul $8, $9, 340
sw $8, -248($sp)
lw $9, 8($a3)
lw $10, -248($sp)
add $8, $9, $10
sw $8, -240($sp)
lw $9, -240($sp)
add $8, $9, 80
sw $8, -240($sp)
li $8, 0
sw $8, -252($sp)
lw $8, -252($sp)
lw $9, -240($sp)
sw $8, 0($9)
lw $9, -240($sp)
lw $8, 0($9)
sw $8, -240($sp)
lw $8, -240($sp)
lw $9, -228($sp)
sw $8, 0($9)
label6:
lw $9, 12($a3)
move $8, $9
sw $8, -260($sp)
lw $9, 12($a3)
lw $8, 0($9)
sw $8, -256($sp)
lw $9, -256($sp)
add $8, $9, 1
sw $8, -264($sp)
lw $8, -264($sp)
lw $9, -260($sp)
sw $8, 0($9)
j label4
label5:
lw $9, -32($sp)
move $8, $9
sw $8, -268($sp)
li $8, 0
sw $8, -272($sp)
lw $8, -272($sp)
lw $9, -268($sp)
sw $8, 0($9)
label7:
lw $9, -32($sp)
lw $8, 0($9)
sw $8, -276($sp)
li $8, 100
sw $8, -280($sp)
lw $9, -276($sp)
lw $10, -280($sp)
sub $8, $9, $10
sw $8, -280($sp)
lw $8, -280($sp)
bgez $8, label8
lw $9, 12($a3)
move $8, $9
sw $8, -284($sp)
li $8, 1
sw $8, -288($sp)
lw $8, -288($sp)
lw $9, -284($sp)
sw $8, 0($9)
label10:
lw $9, 12($a3)
lw $8, 0($9)
sw $8, -292($sp)
li $8, 10
sw $8, -296($sp)
lw $9, -292($sp)
lw $10, -296($sp)
sub $8, $9, $10
sw $8, -296($sp)
lw $8, -296($sp)
bgtz $8, label11
lw $9, 12($a3)
lw $8, 0($9)
sw $8, -304($sp)
lw $9, -304($sp)
mul $8, $9, 340
sw $8, -308($sp)
lw $9, 8($a3)
lw $10, -308($sp)
add $8, $9, $10
sw $8, -300($sp)
lw $9, -300($sp)
add $8, $9, 72
sw $8, -300($sp)
lw $9, -300($sp)
lw $8, 0($9)
sw $8, -300($sp)
li $8, 0
sw $8, -312($sp)
lw $9, -300($sp)
lw $10, -312($sp)
sub $8, $9, $10
sw $8, -312($sp)
lw $8, -312($sp)
bnez $8, label13
lw $9, 12($a3)
lw $8, 0($9)
sw $8, -324($sp)
lw $9, -324($sp)
mul $8, $9, 340
sw $8, -328($sp)
lw $9, 8($a3)
lw $10, -328($sp)
add $8, $9, $10
sw $8, -320($sp)
lw $9, -320($sp)
add $8, $9, 8
sw $8, -320($sp)
lw $9, -320($sp)
move $8, $9
sw $8, -332($sp)
lw $9, -320($sp)
lw $8, 0($9)
sw $8, -320($sp)
lw $9, -320($sp)
add $8, $9, 1
sw $8, -336($sp)
lw $8, -336($sp)
lw $9, -332($sp)
sw $8, 0($9)
add $8, $29, -972
sw $8, -344($sp)
lw $9, 12($a3)
lw $8, 0($9)
sw $8, -340($sp)
lw $8, -340($sp)
lw $9, -344($sp)
sw $8, 0($9)
add $29, $29, -972
jal __Levelup
sub $29, $29, -972
label13:
lw $9, 12($a3)
lw $8, 0($9)
sw $8, -352($sp)
lw $9, -352($sp)
mul $8, $9, 340
sw $8, -356($sp)
lw $9, 8($a3)
lw $10, -356($sp)
add $8, $9, $10
sw $8, -348($sp)
lw $9, -348($sp)
add $8, $9, 76
sw $8, -348($sp)
lw $9, 12($a3)
lw $8, 0($9)
sw $8, -364($sp)
lw $9, -364($sp)
mul $8, $9, 340
sw $8, -368($sp)
lw $9, 8($a3)
lw $10, -368($sp)
add $8, $9, $10
sw $8, -360($sp)
lw $9, -360($sp)
add $8, $9, 80
sw $8, -360($sp)
li $8, 0
sw $8, -372($sp)
lw $8, -372($sp)
lw $9, -360($sp)
sw $8, 0($9)
lw $9, -360($sp)
lw $8, 0($9)
sw $8, -360($sp)
lw $8, -360($sp)
lw $9, -348($sp)
sw $8, 0($9)
lw $9, 12($a3)
lw $8, 0($9)
sw $8, -380($sp)
lw $9, -380($sp)
mul $8, $9, 340
sw $8, -384($sp)
lw $9, 8($a3)
lw $10, -384($sp)
add $8, $9, $10
sw $8, -376($sp)
lw $9, -376($sp)
add $8, $9, 64
sw $8, -376($sp)
lw $9, 12($a3)
lw $8, 0($9)
sw $8, -392($sp)
lw $9, -392($sp)
mul $8, $9, 340
sw $8, -396($sp)
lw $9, 8($a3)
lw $10, -396($sp)
add $8, $9, $10
sw $8, -388($sp)
lw $9, -388($sp)
add $8, $9, 8
sw $8, -388($sp)
lw $9, -388($sp)
lw $8, 0($9)
sw $8, -388($sp)
lw $9, 12($a3)
lw $8, 0($9)
sw $8, -404($sp)
lw $9, -404($sp)
mul $8, $9, 340
sw $8, -408($sp)
lw $9, 8($a3)
lw $10, -408($sp)
add $8, $9, $10
sw $8, -400($sp)
lw $9, -400($sp)
add $8, $9, 40
sw $8, -400($sp)
lw $9, -400($sp)
lw $8, 0($9)
sw $8, -400($sp)
li $8, 5
sw $8, -412($sp)
lw $9, -400($sp)
lw $10, -412($sp)
mul $8, $9, $10
sw $8, -400($sp)
lw $9, -388($sp)
lw $10, -400($sp)
add $8, $9, $10
sw $8, -388($sp)
lw $9, 12($a3)
lw $8, 0($9)
sw $8, -420($sp)
lw $9, -420($sp)
mul $8, $9, 340
sw $8, -424($sp)
lw $9, 8($a3)
lw $10, -424($sp)
add $8, $9, $10
sw $8, -416($sp)
lw $9, -416($sp)
add $8, $9, 44
sw $8, -416($sp)
lw $9, -416($sp)
lw $8, 0($9)
sw $8, -416($sp)
lw $9, 12($a3)
lw $8, 0($9)
sw $8, -432($sp)
lw $9, -432($sp)
mul $8, $9, 340
sw $8, -436($sp)
lw $9, 8($a3)
lw $10, -436($sp)
add $8, $9, $10
sw $8, -428($sp)
lw $9, -428($sp)
add $8, $9, 44
sw $8, -428($sp)
lw $9, -428($sp)
lw $8, 0($9)
sw $8, -428($sp)
lw $9, -416($sp)
lw $10, -428($sp)
mul $8, $9, $10
sw $8, -416($sp)
li $8, 5
sw $8, -440($sp)
lw $9, -416($sp)
lw $10, -440($sp)
div $8, $9, $10
sw $8, -416($sp)
lw $9, -388($sp)
lw $10, -416($sp)
sub $8, $9, $10
sw $8, -388($sp)
lw $8, -388($sp)
lw $9, -376($sp)
sw $8, 0($9)
lw $9, 12($a3)
lw $8, 0($9)
sw $8, -448($sp)
lw $9, -448($sp)
mul $8, $9, 4
sw $8, -452($sp)
lw $9, 20($a3)
lw $10, -452($sp)
add $8, $9, $10
sw $8, -444($sp)
lw $9, 12($a3)
lw $8, 0($9)
sw $8, -456($sp)
lw $8, -456($sp)
lw $9, -444($sp)
sw $8, 0($9)
label12:
lw $9, 12($a3)
move $8, $9
sw $8, -464($sp)
lw $9, 12($a3)
lw $8, 0($9)
sw $8, -460($sp)
lw $9, -460($sp)
add $8, $9, 1
sw $8, -460($sp)
lw $8, -460($sp)
lw $9, -464($sp)
sw $8, 0($9)
j label10
label11:
lw $9, 12($a3)
move $8, $9
sw $8, -468($sp)
li $8, 1
sw $8, -472($sp)
lw $8, -472($sp)
lw $9, -468($sp)
sw $8, 0($9)
label14:
lw $9, 12($a3)
lw $8, 0($9)
sw $8, -476($sp)
li $8, 10
sw $8, -480($sp)
lw $9, -476($sp)
lw $10, -480($sp)
sub $8, $9, $10
sw $8, -480($sp)
lw $8, -480($sp)
bgtz $8, label15
lw $9, 16($a3)
move $8, $9
sw $8, -484($sp)
lw $9, 12($a3)
lw $8, 0($9)
sw $8, -488($sp)
lw $8, -488($sp)
lw $9, -484($sp)
sw $8, 0($9)
label17:
lw $9, 16($a3)
lw $8, 0($9)
sw $8, -492($sp)
li $8, 10
sw $8, -496($sp)
lw $9, -492($sp)
lw $10, -496($sp)
sub $8, $9, $10
sw $8, -496($sp)
lw $8, -496($sp)
bgtz $8, label18
lw $9, 12($a3)
lw $8, 0($9)
sw $8, -504($sp)
lw $9, -504($sp)
mul $8, $9, 4
sw $8, -508($sp)
lw $9, 20($a3)
lw $10, -508($sp)
add $8, $9, $10
sw $8, -500($sp)
lw $9, -500($sp)
lw $8, 0($9)
sw $8, -500($sp)
lw $9, 16($a3)
lw $8, 0($9)
sw $8, -516($sp)
lw $9, -516($sp)
mul $8, $9, 4
sw $8, -520($sp)
lw $9, 20($a3)
lw $10, -520($sp)
add $8, $9, $10
sw $8, -512($sp)
lw $9, -512($sp)
lw $8, 0($9)
sw $8, -512($sp)
lw $9, -500($sp)
lw $10, -512($sp)
sub $8, $9, $10
sw $8, -512($sp)
lw $8, -512($sp)
blez $8, label20
lw $9, -40($sp)
move $8, $9
sw $8, -524($sp)
lw $9, 12($a3)
lw $8, 0($9)
sw $8, -532($sp)
lw $9, -532($sp)
mul $8, $9, 4
sw $8, -536($sp)
lw $9, 20($a3)
lw $10, -536($sp)
add $8, $9, $10
sw $8, -528($sp)
lw $9, -528($sp)
lw $8, 0($9)
sw $8, -528($sp)
lw $8, -528($sp)
lw $9, -524($sp)
sw $8, 0($9)
lw $9, 12($a3)
lw $8, 0($9)
sw $8, -544($sp)
lw $9, -544($sp)
mul $8, $9, 4
sw $8, -548($sp)
lw $9, 20($a3)
lw $10, -548($sp)
add $8, $9, $10
sw $8, -540($sp)
lw $9, 16($a3)
lw $8, 0($9)
sw $8, -556($sp)
lw $9, -556($sp)
mul $8, $9, 4
sw $8, -560($sp)
lw $9, 20($a3)
lw $10, -560($sp)
add $8, $9, $10
sw $8, -552($sp)
lw $9, -552($sp)
lw $8, 0($9)
sw $8, -552($sp)
lw $8, -552($sp)
lw $9, -540($sp)
sw $8, 0($9)
lw $9, 16($a3)
lw $8, 0($9)
sw $8, -568($sp)
lw $9, -568($sp)
mul $8, $9, 4
sw $8, -572($sp)
lw $9, 20($a3)
lw $10, -572($sp)
add $8, $9, $10
sw $8, -564($sp)
lw $9, -40($sp)
lw $8, 0($9)
sw $8, -576($sp)
lw $8, -576($sp)
lw $9, -564($sp)
sw $8, 0($9)
label20:
label19:
lw $9, 16($a3)
move $8, $9
sw $8, -584($sp)
lw $9, 16($a3)
lw $8, 0($9)
sw $8, -580($sp)
lw $9, -580($sp)
add $8, $9, 1
sw $8, -580($sp)
lw $8, -580($sp)
lw $9, -584($sp)
sw $8, 0($9)
j label17
label18:
label16:
lw $9, 12($a3)
move $8, $9
sw $8, -592($sp)
lw $9, 12($a3)
lw $8, 0($9)
sw $8, -588($sp)
lw $9, -588($sp)
add $8, $9, 1
sw $8, -588($sp)
lw $8, -588($sp)
lw $9, -592($sp)
sw $8, 0($9)
j label14
label15:
lw $9, 12($a3)
move $8, $9
sw $8, -596($sp)
li $8, 1
sw $8, -600($sp)
lw $8, -600($sp)
lw $9, -596($sp)
sw $8, 0($9)
label21:
lw $9, 12($a3)
lw $8, 0($9)
sw $8, -604($sp)
li $8, 10
sw $8, -608($sp)
lw $9, -604($sp)
lw $10, -608($sp)
sub $8, $9, $10
sw $8, -608($sp)
lw $8, -608($sp)
bgtz $8, label22
lw $9, -48($sp)
move $8, $9
sw $8, -612($sp)
lw $9, 12($a3)
lw $8, 0($9)
sw $8, -620($sp)
lw $9, -620($sp)
mul $8, $9, 4
sw $8, -624($sp)
lw $9, 20($a3)
lw $10, -624($sp)
add $8, $9, $10
sw $8, -616($sp)
lw $9, -616($sp)
lw $8, 0($9)
sw $8, -616($sp)
lw $8, -616($sp)
lw $9, -612($sp)
sw $8, 0($9)
lw $9, -48($sp)
lw $8, 0($9)
sw $8, -632($sp)
lw $9, -632($sp)
mul $8, $9, 340
sw $8, -636($sp)
lw $9, 8($a3)
lw $10, -636($sp)
add $8, $9, $10
sw $8, -628($sp)
lw $9, -628($sp)
add $8, $9, 72
sw $8, -628($sp)
lw $9, -628($sp)
lw $8, 0($9)
sw $8, -628($sp)
li $8, 1
sw $8, -640($sp)
lw $9, -628($sp)
lw $10, -640($sp)
sub $8, $9, $10
sw $8, -640($sp)
lw $8, -640($sp)
bnez $8, label24
lw $9, -56($sp)
move $8, $9
sw $8, -648($sp)
li $8, 0
sw $8, -652($sp)
lw $8, -652($sp)
lw $9, -648($sp)
sw $8, 0($9)
lw $9, -64($sp)
move $8, $9
sw $8, -644($sp)
li $8, 0
sw $8, -656($sp)
lw $8, -656($sp)
lw $9, -644($sp)
sw $8, 0($9)
lw $9, -48($sp)
lw $8, 0($9)
sw $8, -664($sp)
lw $9, -664($sp)
mul $8, $9, 340
sw $8, -668($sp)
lw $9, 8($a3)
lw $10, -668($sp)
add $8, $9, $10
sw $8, -660($sp)
lw $9, -660($sp)
add $8, $9, 20
sw $8, -660($sp)
lw $9, -48($sp)
lw $8, 0($9)
sw $8, -676($sp)
lw $9, -676($sp)
mul $8, $9, 340
sw $8, -680($sp)
lw $9, 8($a3)
lw $10, -680($sp)
add $8, $9, $10
sw $8, -672($sp)
lw $9, -672($sp)
add $8, $9, 24
sw $8, -672($sp)
lw $9, -672($sp)
lw $8, 0($9)
sw $8, -672($sp)
li $8, 4
sw $8, -684($sp)
lw $9, -672($sp)
lw $10, -684($sp)
div $8, $9, $10
sw $8, -672($sp)
lw $8, -672($sp)
lw $9, -660($sp)
sw $8, 0($9)
lw $9, -48($sp)
lw $8, 0($9)
sw $8, -696($sp)
lw $9, -696($sp)
mul $8, $9, 340
sw $8, -700($sp)
lw $9, 8($a3)
lw $10, -700($sp)
add $8, $9, $10
sw $8, -692($sp)
lw $9, -692($sp)
add $8, $9, 12
sw $8, -692($sp)
lw $9, -56($sp)
lw $8, 0($9)
sw $8, -704($sp)
lw $8, -704($sp)
lw $9, -692($sp)
sw $8, 0($9)
lw $9, -48($sp)
lw $8, 0($9)
sw $8, -708($sp)
lw $9, -708($sp)
mul $8, $9, 340
sw $8, -712($sp)
lw $9, 8($a3)
lw $10, -712($sp)
add $8, $9, $10
sw $8, -688($sp)
lw $9, -688($sp)
add $8, $9, 16
sw $8, -688($sp)
lw $9, -64($sp)
lw $8, 0($9)
sw $8, -716($sp)
lw $8, -716($sp)
lw $9, -688($sp)
sw $8, 0($9)
lw $9, -48($sp)
lw $8, 0($9)
sw $8, -724($sp)
lw $9, -724($sp)
mul $8, $9, 340
sw $8, -728($sp)
lw $9, 8($a3)
lw $10, -728($sp)
add $8, $9, $10
sw $8, -720($sp)
lw $9, -720($sp)
add $8, $9, 72
sw $8, -720($sp)
lw $9, -720($sp)
move $8, $9
sw $8, -732($sp)
lw $9, -720($sp)
lw $8, 0($9)
sw $8, -720($sp)
lw $9, -720($sp)
sub $8, $9, 1
sw $8, -736($sp)
lw $8, -736($sp)
lw $9, -732($sp)
sw $8, 0($9)
lw $9, -56($sp)
lw $8, 0($9)
sw $8, -744($sp)
lw $9, -744($sp)
mul $8, $9, 160
sw $8, -748($sp)
lw $9, 24($a3)
lw $10, -748($sp)
add $8, $9, $10
sw $8, -740($sp)
lw $9, -64($sp)
lw $8, 0($9)
sw $8, -752($sp)
lw $9, -752($sp)
mul $8, $9, 4
sw $8, -756($sp)
lw $9, -740($sp)
lw $10, -756($sp)
add $8, $9, $10
sw $8, -740($sp)
lw $9, -48($sp)
lw $8, 0($9)
sw $8, -760($sp)
lw $8, -760($sp)
lw $9, -740($sp)
sw $8, 0($9)
label24:
lw $9, -48($sp)
lw $8, 0($9)
sw $8, -768($sp)
lw $9, -768($sp)
mul $8, $9, 340
sw $8, -772($sp)
lw $9, 8($a3)
lw $10, -772($sp)
add $8, $9, $10
sw $8, -764($sp)
lw $9, -764($sp)
add $8, $9, 72
sw $8, -764($sp)
lw $9, -764($sp)
lw $8, 0($9)
sw $8, -764($sp)
li $8, 1
sw $8, -776($sp)
lw $9, -764($sp)
lw $10, -776($sp)
sub $8, $9, $10
sw $8, -776($sp)
lw $8, -776($sp)
blez $8, label25
lw $9, -48($sp)
lw $8, 0($9)
sw $8, -784($sp)
lw $9, -784($sp)
mul $8, $9, 340
sw $8, -788($sp)
lw $9, 8($a3)
lw $10, -788($sp)
add $8, $9, $10
sw $8, -780($sp)
lw $9, -780($sp)
add $8, $9, 72
sw $8, -780($sp)
lw $9, -780($sp)
move $8, $9
sw $8, -792($sp)
lw $9, -780($sp)
lw $8, 0($9)
sw $8, -780($sp)
lw $9, -780($sp)
sub $8, $9, 1
sw $8, -796($sp)
lw $8, -796($sp)
lw $9, -792($sp)
sw $8, 0($9)
label25:
label23:
lw $9, 12($a3)
move $8, $9
sw $8, -804($sp)
lw $9, 12($a3)
lw $8, 0($9)
sw $8, -800($sp)
lw $9, -800($sp)
add $8, $9, 1
sw $8, -800($sp)
lw $8, -800($sp)
lw $9, -804($sp)
sw $8, 0($9)
j label21
label22:
label9:
lw $9, -32($sp)
move $8, $9
sw $8, -812($sp)
lw $9, -32($sp)
lw $8, 0($9)
sw $8, -808($sp)
lw $9, -808($sp)
add $8, $9, 1
sw $8, -816($sp)
lw $8, -816($sp)
lw $9, -812($sp)
sw $8, 0($9)
j label7
label8:
lw $9, 12($a3)
move $8, $9
sw $8, -820($sp)
li $8, 1
sw $8, -824($sp)
lw $8, -824($sp)
lw $9, -820($sp)
sw $8, 0($9)
label26:
lw $9, 12($a3)
lw $8, 0($9)
sw $8, -828($sp)
li $8, 10
sw $8, -832($sp)
lw $9, -828($sp)
lw $10, -832($sp)
sub $8, $9, $10
sw $8, -832($sp)
lw $8, -832($sp)
bgtz $8, label27
lw $9, -4($sp)
move $8, $9
sw $8, -836($sp)
lw $9, 12($a3)
lw $8, 0($9)
sw $8, -844($sp)
lw $9, -844($sp)
mul $8, $9, 340
sw $8, -848($sp)
lw $9, 8($a3)
lw $10, -848($sp)
add $8, $9, $10
sw $8, -840($sp)
lw $9, -840($sp)
add $8, $9, 0
sw $8, -840($sp)
lw $9, -840($sp)
lw $8, 0($9)
sw $8, -840($sp)
li $8, 9
sw $8, -852($sp)
lw $9, -840($sp)
lw $10, -852($sp)
mul $8, $9, $10
sw $8, -840($sp)
lw $9, 12($a3)
lw $8, 0($9)
sw $8, -860($sp)
lw $9, -860($sp)
mul $8, $9, 340
sw $8, -864($sp)
lw $9, 8($a3)
lw $10, -864($sp)
add $8, $9, $10
sw $8, -856($sp)
lw $9, -856($sp)
add $8, $9, 4
sw $8, -856($sp)
lw $9, -856($sp)
lw $8, 0($9)
sw $8, -856($sp)
li $8, 8
sw $8, -868($sp)
lw $9, -856($sp)
lw $10, -868($sp)
mul $8, $9, $10
sw $8, -856($sp)
lw $9, -840($sp)
lw $10, -856($sp)
add $8, $9, $10
sw $8, -840($sp)
lw $9, 12($a3)
lw $8, 0($9)
sw $8, -876($sp)
lw $9, -876($sp)
mul $8, $9, 340
sw $8, -880($sp)
lw $9, 8($a3)
lw $10, -880($sp)
add $8, $9, $10
sw $8, -872($sp)
lw $9, -872($sp)
add $8, $9, 8
sw $8, -872($sp)
lw $9, -872($sp)
lw $8, 0($9)
sw $8, -872($sp)
li $8, 7
sw $8, -884($sp)
lw $9, -872($sp)
lw $10, -884($sp)
mul $8, $9, $10
sw $8, -872($sp)
lw $9, -840($sp)
lw $10, -872($sp)
add $8, $9, $10
sw $8, -840($sp)
lw $9, 12($a3)
lw $8, 0($9)
sw $8, -892($sp)
lw $9, -892($sp)
mul $8, $9, 340
sw $8, -896($sp)
lw $9, 8($a3)
lw $10, -896($sp)
add $8, $9, $10
sw $8, -888($sp)
lw $9, -888($sp)
add $8, $9, 28
sw $8, -888($sp)
lw $9, -888($sp)
lw $8, 0($9)
sw $8, -888($sp)
li $8, 6
sw $8, -900($sp)
lw $9, -888($sp)
lw $10, -900($sp)
mul $8, $9, $10
sw $8, -888($sp)
lw $9, -840($sp)
lw $10, -888($sp)
add $8, $9, $10
sw $8, -840($sp)
lw $9, -4($sp)
lw $8, 0($9)
sw $8, -904($sp)
lw $9, -904($sp)
lw $10, -840($sp)
add $8, $9, $10
sw $8, -904($sp)
lw $8, -904($sp)
lw $9, -836($sp)
sw $8, 0($9)
label28:
lw $9, 12($a3)
move $8, $9
sw $8, -912($sp)
lw $9, 12($a3)
lw $8, 0($9)
sw $8, -908($sp)
lw $9, -908($sp)
add $8, $9, 1
sw $8, -916($sp)
lw $8, -916($sp)
lw $9, -912($sp)
sw $8, 0($9)
j label26
label27:
add $8, $29, -972
sw $8, -928($sp)
lw $9, -4($sp)
lw $8, 0($9)
sw $8, -924($sp)
lw $8, -924($sp)
lw $9, -928($sp)
sw $8, 0($9)
lw $9, 1056($a3)
move $8, $9
sw $8, -932($sp)
add $8, $29, -976
sw $8, -936($sp)
lw $8, -932($sp)
lw $9, -936($sp)
sw $8, 0($9)
add $29, $29, -976
jal __printf
sub $29, $29, -976
j __main_end
__main_end:
li $v0, 10
syscall
#global $2 3740
#global $3 4
#global $4 4
#global $5 80
#global $6 6400
#string $264 #%d
#----------------------------
#func #Levelup
#addi $7 $0 0
####move $8 $2
####move $9 $7
#lw $9 $7 0
#muli $10 $9 340
#add $8 $2 $10
#addi $8 $8 0
#lw $8 $8 0
#li $11 5
#sub $11 $8 $11
#blez $11 l:0
####move $12 $2
####move $13 $7
#lw $13 $7 0
#muli $14 $13 340
#add $12 $2 $14
#addi $12 $12 28
#move $15 $12
#lw $12 $12 0
#addi $16 $12 1
#sw $16 $15 0
#goto l:1
#label l:0
####move $17 $2
####move $18 $7
#lw $18 $7 0
#muli $19 $18 340
#add $17 $2 $19
#addi $17 $17 0
#lw $17 $17 0
#li $20 0
#sub $20 $17 $20
#blez $20 l:2
####move $21 $2
####move $22 $7
#lw $22 $7 0
#muli $23 $22 340
#add $21 $2 $23
#addi $21 $21 32
#move $24 $21
#lw $21 $21 0
#addi $25 $21 1
#sw $25 $24 0
#goto l:3
#label l:2
#return
#label l:3
#label l:1
####move $26 $2
####move $27 $7
#lw $27 $7 0
#muli $28 $27 340
#add $26 $2 $28
#addi $26 $26 0
#move $29 $26
#lw $26 $26 0
#subi $30 $26 1
#sw $30 $29 0
#return
#----------------------------
#func #main
#addi $32 $0 -940
#move $31 $32
#li $33 0
#sw $33 $31 0
#addi $35 $0 -944
#move $34 $35
#addi $0 $0 -952
#call #getchar
#subi $0 $0 -952
#addi $37 $0 -948
####move $36 $37
#lw $36 $37 0
#sw $36 $34 0
#addi $39 $0 -948
#move $38 $39
#addi $41 $0 -952
#move $40 $41
#addi $43 $0 -956
#move $42 $43
#addi $45 $0 -960
#move $44 $45
#addi $47 $0 -964
#move $46 $47
#move $48 $3
#li $49 1
#sw $49 $48 0
#label l:4
####move $50 $3
#lw $50 $3 0
#li $51 10
#sub $51 $50 $51
#bgtz $51 l:5
####move $52 $2
####move $53 $3
#lw $53 $3 0
#muli $54 $53 340
#add $52 $2 $54
#addi $52 $52 0
####move $55 $3
#lw $55 $3 0
#li $56 2
#mul $55 $55 $56
####move $57 $34
#lw $57 $34 0
#add $55 $55 $57
#sw $55 $52 0
####move $58 $2
####move $59 $3
#lw $59 $3 0
#muli $60 $59 340
#add $58 $2 $60
#addi $58 $58 4
#li $61 1
#sw $61 $58 0
####move $62 $2
####move $63 $3
#lw $63 $3 0
#muli $64 $63 340
#add $62 $2 $64
#addi $62 $62 8
#li $65 0
#sw $65 $62 0
####move $66 $2
####move $67 $3
#lw $67 $3 0
#muli $68 $67 340
#add $66 $2 $68
#addi $66 $66 20
####move $69 $2
####move $70 $3
#lw $70 $3 0
#muli $71 $70 340
#add $69 $2 $71
#addi $69 $69 24
#li $72 0
#sw $72 $69 0
#lw $69 $69 0
#sw $69 $66 0
####move $73 $2
####move $74 $3
#lw $74 $3 0
#muli $75 $74 340
#add $73 $2 $75
#addi $73 $73 28
####move $76 $2
####move $77 $3
#lw $77 $3 0
#muli $78 $77 340
#add $76 $2 $78
#addi $76 $76 32
#li $79 0
#sw $79 $76 0
#lw $76 $76 0
#sw $76 $73 0
####move $80 $2
####move $81 $3
#lw $81 $3 0
#muli $82 $81 340
#add $80 $2 $82
#addi $80 $80 36
####move $83 $2
####move $84 $3
#lw $84 $3 0
#muli $85 $84 340
#add $83 $2 $85
#addi $83 $83 72
#li $86 0
#sw $86 $83 0
#lw $83 $83 0
#sw $83 $80 0
####move $87 $2
####move $88 $3
#lw $88 $3 0
#muli $89 $88 340
#add $87 $2 $89
#addi $87 $87 76
####move $90 $2
####move $91 $3
#lw $91 $3 0
#muli $92 $91 340
#add $90 $2 $92
#addi $90 $90 80
#li $93 0
#sw $93 $90 0
#lw $90 $90 0
#sw $90 $87 0
#label l:6
####move $94 $3
#move $95 $3
#lw $94 $3 0
#addi $96 $94 1
#sw $96 $95 0
#goto l:4
#label l:5
#move $97 $38
#li $98 0
#sw $98 $97 0
#label l:7
####move $99 $38
#lw $99 $38 0
#li $100 100
#sub $100 $99 $100
#bgez $100 l:8
#move $101 $3
#li $102 1
#sw $102 $101 0
#label l:10
####move $103 $3
#lw $103 $3 0
#li $104 10
#sub $104 $103 $104
#bgtz $104 l:11
####move $105 $2
####move $106 $3
#lw $106 $3 0
#muli $107 $106 340
#add $105 $2 $107
#addi $105 $105 72
#lw $105 $105 0
#li $108 0
#sub $108 $105 $108
#bnez $108 l:13
####move $110 $2
####move $111 $3
#lw $111 $3 0
#muli $112 $111 340
#add $110 $2 $112
#addi $110 $110 8
#move $113 $110
#lw $110 $110 0
#addi $114 $110 1
#sw $114 $113 0
####move $115 $3
#addi $116 $0 -972
#lw $115 $3 0
#sw $115 $116 0
#addi $0 $0 -972
#call #Levelup
#subi $0 $0 -972
#label l:13
####move $117 $2
####move $118 $3
#lw $118 $3 0
#muli $119 $118 340
#add $117 $2 $119
#addi $117 $117 76
####move $120 $2
####move $121 $3
#lw $121 $3 0
#muli $122 $121 340
#add $120 $2 $122
#addi $120 $120 80
#li $123 0
#sw $123 $120 0
#lw $120 $120 0
#sw $120 $117 0
####move $124 $2
####move $125 $3
#lw $125 $3 0
#muli $126 $125 340
#add $124 $2 $126
#addi $124 $124 64
####move $127 $2
####move $128 $3
#lw $128 $3 0
#muli $129 $128 340
#add $127 $2 $129
#addi $127 $127 8
#lw $127 $127 0
####move $130 $2
####move $131 $3
#lw $131 $3 0
#muli $132 $131 340
#add $130 $2 $132
#addi $130 $130 40
#lw $130 $130 0
#li $133 5
#mul $130 $130 $133
#add $127 $127 $130
####move $134 $2
####move $135 $3
#lw $135 $3 0
#muli $136 $135 340
#add $134 $2 $136
#addi $134 $134 44
#lw $134 $134 0
####move $137 $2
####move $138 $3
#lw $138 $3 0
#muli $139 $138 340
#add $137 $2 $139
#addi $137 $137 44
#lw $137 $137 0
#mul $134 $134 $137
#li $140 5
#div $134 $134 $140
#sub $127 $127 $134
#sw $127 $124 0
####move $141 $5
####move $142 $3
#lw $142 $3 0
#muli $143 $142 4
#add $141 $5 $143
####move $144 $3
#lw $144 $3 0
#sw $144 $141 0
#label l:12
####move $145 $3
#move $146 $3
#lw $145 $3 0
#addi $145 $145 1
#sw $145 $146 0
#goto l:10
#label l:11
#move $147 $3
#li $148 1
#sw $148 $147 0
#label l:14
####move $149 $3
#lw $149 $3 0
#li $150 10
#sub $150 $149 $150
#bgtz $150 l:15
#move $151 $4
####move $152 $3
#lw $152 $3 0
#sw $152 $151 0
#label l:17
####move $153 $4
#lw $153 $4 0
#li $154 10
#sub $154 $153 $154
#bgtz $154 l:18
####move $155 $5
####move $156 $3
#lw $156 $3 0
#muli $157 $156 4
#add $155 $5 $157
#lw $155 $155 0
####move $158 $5
####move $159 $4
#lw $159 $4 0
#muli $160 $159 4
#add $158 $5 $160
#lw $158 $158 0
#sub $158 $155 $158
#blez $158 l:20
#move $161 $40
####move $162 $5
####move $163 $3
#lw $163 $3 0
#muli $164 $163 4
#add $162 $5 $164
#lw $162 $162 0
#sw $162 $161 0
####move $165 $5
####move $166 $3
#lw $166 $3 0
#muli $167 $166 4
#add $165 $5 $167
####move $168 $5
####move $169 $4
#lw $169 $4 0
#muli $170 $169 4
#add $168 $5 $170
#lw $168 $168 0
#sw $168 $165 0
####move $171 $5
####move $172 $4
#lw $172 $4 0
#muli $173 $172 4
#add $171 $5 $173
####move $174 $40
#lw $174 $40 0
#sw $174 $171 0
#label l:20
#label l:19
####move $175 $4
#move $176 $4
#lw $175 $4 0
#addi $175 $175 1
#sw $175 $176 0
#goto l:17
#label l:18
#label l:16
####move $177 $3
#move $178 $3
#lw $177 $3 0
#addi $177 $177 1
#sw $177 $178 0
#goto l:14
#label l:15
#move $179 $3
#li $180 1
#sw $180 $179 0
#label l:21
####move $181 $3
#lw $181 $3 0
#li $182 10
#sub $182 $181 $182
#bgtz $182 l:22
#move $183 $42
####move $184 $5
####move $185 $3
#lw $185 $3 0
#muli $186 $185 4
#add $184 $5 $186
#lw $184 $184 0
#sw $184 $183 0
####move $187 $2
####move $188 $42
#lw $188 $42 0
#muli $189 $188 340
#add $187 $2 $189
#addi $187 $187 72
#lw $187 $187 0
#li $190 1
#sub $190 $187 $190
#bnez $190 l:24
#move $192 $44
#li $193 0
#sw $193 $192 0
#move $191 $46
#li $194 0
#sw $194 $191 0
####move $195 $2
####move $196 $42
#lw $196 $42 0
#muli $197 $196 340
#add $195 $2 $197
#addi $195 $195 20
####move $198 $2
####move $199 $42
#lw $199 $42 0
#muli $200 $199 340
#add $198 $2 $200
#addi $198 $198 24
#lw $198 $198 0
#li $201 4
#div $198 $198 $201
#sw $198 $195 0
####move $203 $2
####move $204 $42
#lw $204 $42 0
#muli $205 $204 340
#add $203 $2 $205
#addi $203 $203 12
####move $206 $44
#lw $206 $44 0
#sw $206 $203 0
####move $202 $2
####move $207 $42
#lw $207 $42 0
#muli $208 $207 340
#add $202 $2 $208
#addi $202 $202 16
####move $209 $46
#lw $209 $46 0
#sw $209 $202 0
####move $210 $2
####move $211 $42
#lw $211 $42 0
#muli $212 $211 340
#add $210 $2 $212
#addi $210 $210 72
#move $213 $210
#lw $210 $210 0
#subi $214 $210 1
#sw $214 $213 0
####move $215 $6
####move $216 $44
#lw $216 $44 0
#muli $217 $216 160
#add $215 $6 $217
####move $218 $46
#lw $218 $46 0
#muli $219 $218 4
#add $215 $215 $219
####move $220 $42
#lw $220 $42 0
#sw $220 $215 0
#label l:24
####move $221 $2
####move $222 $42
#lw $222 $42 0
#muli $223 $222 340
#add $221 $2 $223
#addi $221 $221 72
#lw $221 $221 0
#li $224 1
#sub $224 $221 $224
#blez $224 l:25
####move $225 $2
####move $226 $42
#lw $226 $42 0
#muli $227 $226 340
#add $225 $2 $227
#addi $225 $225 72
#move $228 $225
#lw $225 $225 0
#subi $229 $225 1
#sw $229 $228 0
#label l:25
#label l:23
####move $230 $3
#move $231 $3
#lw $230 $3 0
#addi $230 $230 1
#sw $230 $231 0
#goto l:21
#label l:22
#label l:9
####move $232 $38
#move $233 $38
#lw $232 $38 0
#addi $234 $232 1
#sw $234 $233 0
#goto l:7
#label l:8
#move $235 $3
#li $236 1
#sw $236 $235 0
#label l:26
####move $237 $3
#lw $237 $3 0
#li $238 10
#sub $238 $237 $238
#bgtz $238 l:27
#move $239 $31
####move $240 $2
####move $241 $3
#lw $241 $3 0
#muli $242 $241 340
#add $240 $2 $242
#addi $240 $240 0
#lw $240 $240 0
#li $243 9
#mul $240 $240 $243
####move $244 $2
####move $245 $3
#lw $245 $3 0
#muli $246 $245 340
#add $244 $2 $246
#addi $244 $244 4
#lw $244 $244 0
#li $247 8
#mul $244 $244 $247
#add $240 $240 $244
####move $248 $2
####move $249 $3
#lw $249 $3 0
#muli $250 $249 340
#add $248 $2 $250
#addi $248 $248 8
#lw $248 $248 0
#li $251 7
#mul $248 $248 $251
#add $240 $240 $248
####move $252 $2
####move $253 $3
#lw $253 $3 0
#muli $254 $253 340
#add $252 $2 $254
#addi $252 $252 28
#lw $252 $252 0
#li $255 6
#mul $252 $252 $255
#add $240 $240 $252
#lw $256 $31 0
#add $256 $256 $240
#sw $256 $239 0
#label l:28
####move $257 $3
#move $258 $3
#lw $257 $3 0
#addi $259 $257 1
#sw $259 $258 0
#goto l:26
#label l:27
####move $261 $31
#addi $262 $0 -972
#lw $261 $31 0
#sw $261 $262 0
#move $263 $264
#addi $265 $0 -976
#sw $263 $265 0
#addi $0 $0 -976
#call #printf
#subi $0 $0 -976
#return
