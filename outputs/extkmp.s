.data
temp: .space 1088
var0: .space 200
var1: .space 200
var2: .space 500
var3: .space 4
var4: .space 4
var5: .space 4
var6: .space 800
var7: .space 4
var8: .asciiz "%d\n"
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

__min:
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
bgez $8, label0
add $8, $29, 12
sw $8, -24($sp)
lw $9, -4($sp)
lw $8, 0($9)
sw $8, -20($sp)
lw $8, -20($sp)
lw $9, -24($sp)
sw $8, 0($9)
jr $ra
label0:
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
__max:
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
blez $8, label1
add $8, $29, 12
sw $8, -24($sp)
lw $9, -4($sp)
lw $8, 0($9)
sw $8, -20($sp)
lw $8, -20($sp)
lw $9, -24($sp)
sw $8, 0($9)
jr $ra
label1:
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
__get_val:
add $8, $29, -76
sw $8, -8($sp)
lw $9, -8($sp)
move $8, $9
sw $8, -4($sp)
li $8, 0
sw $8, -12($sp)
lw $8, -12($sp)
lw $9, -4($sp)
sw $8, 0($9)
add $8, $29, -80
sw $8, -20($sp)
lw $9, -20($sp)
move $8, $9
sw $8, -16($sp)
label2:
lw $9, -16($sp)
move $8, $9
sw $8, -24($sp)
sw $31, -88($29)
add $29, $29, -88
jal __getchar
sub $29, $29, -88
lw $31, -88($29)
add $8, $29, -84
sw $8, -32($sp)
lw $9, -32($sp)
lw $8, 0($9)
sw $8, -28($sp)
lw $8, -28($sp)
lw $9, -24($sp)
sw $8, 0($9)
lw $9, -24($sp)
lw $8, 0($9)
sw $8, -24($sp)
li $8, 48
sw $8, -36($sp)
lw $9, -24($sp)
lw $10, -36($sp)
sub $8, $9, $10
sw $8, -36($sp)
lw $8, -36($sp)
bltz $8, label3
lw $9, -16($sp)
lw $8, 0($9)
sw $8, -40($sp)
li $8, 57
sw $8, -44($sp)
lw $9, -40($sp)
lw $10, -44($sp)
sub $8, $9, $10
sw $8, -44($sp)
lw $8, -44($sp)
bgtz $8, label3
lw $9, -4($sp)
move $8, $9
sw $8, -48($sp)
lw $9, -4($sp)
lw $8, 0($9)
sw $8, -52($sp)
li $8, 10
sw $8, -56($sp)
lw $9, -52($sp)
lw $10, -56($sp)
mul $8, $9, $10
sw $8, -52($sp)
lw $9, -16($sp)
lw $8, 0($9)
sw $8, -60($sp)
lw $9, -52($sp)
lw $10, -60($sp)
add $8, $9, $10
sw $8, -52($sp)
li $8, 48
sw $8, -64($sp)
lw $9, -52($sp)
lw $10, -64($sp)
sub $8, $9, $10
sw $8, -52($sp)
lw $8, -52($sp)
lw $9, -48($sp)
sw $8, 0($9)
j label2
label3:
add $8, $29, 4
sw $8, -72($sp)
lw $9, -4($sp)
lw $8, 0($9)
sw $8, -68($sp)
lw $8, -68($sp)
lw $9, -72($sp)
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
sw $t0, 1060($a3)
add $8, $29, -912
sw $8, -8($sp)
lw $9, -8($sp)
move $8, $9
sw $8, -4($sp)
add $8, $29, -916
sw $8, -16($sp)
lw $9, -16($sp)
move $8, $9
sw $8, -12($sp)
add $8, $29, -920
sw $8, -24($sp)
lw $9, -24($sp)
move $8, $9
sw $8, -20($sp)
add $8, $29, -924
sw $8, -32($sp)
lw $9, -32($sp)
move $8, $9
sw $8, -28($sp)
lw $9, 36($a3)
move $8, $9
sw $8, -36($sp)
add $29, $29, -932
jal __get_val
sub $29, $29, -932
add $8, $29, -928
sw $8, -44($sp)
lw $9, -44($sp)
lw $8, 0($9)
sw $8, -40($sp)
lw $8, -40($sp)
lw $9, -36($sp)
sw $8, 0($9)
label4:
lw $9, 36($a3)
lw $8, 0($9)
sw $8, -48($sp)
lw $8, -48($sp)
beqz $8, label5
lw $9, -20($sp)
move $8, $9
sw $8, -52($sp)
li $8, 1
sw $8, -56($sp)
lw $8, -56($sp)
lw $9, -52($sp)
sw $8, 0($9)
lw $9, 20($a3)
move $8, $9
sw $8, -64($sp)
li $8, 0
sw $8, -68($sp)
lw $8, -68($sp)
lw $9, -64($sp)
sw $8, 0($9)
lw $9, 24($a3)
move $8, $9
sw $8, -60($sp)
li $8, 0
sw $8, -72($sp)
lw $8, -72($sp)
lw $9, -60($sp)
sw $8, 0($9)
lw $9, -28($sp)
move $8, $9
sw $8, -76($sp)
add $29, $29, -932
jal __getchar
sub $29, $29, -932
add $8, $29, -928
sw $8, -84($sp)
lw $9, -84($sp)
lw $8, 0($9)
sw $8, -80($sp)
lw $8, -80($sp)
lw $9, -76($sp)
sw $8, 0($9)
label7:
lw $9, -28($sp)
lw $8, 0($9)
sw $8, -88($sp)
li $8, 97
sw $8, -92($sp)
lw $9, -88($sp)
lw $10, -92($sp)
sub $8, $9, $10
sw $8, -92($sp)
lw $8, -92($sp)
bltz $8, label10
lw $9, -28($sp)
lw $8, 0($9)
sw $8, -96($sp)
li $8, 122
sw $8, -100($sp)
lw $9, -96($sp)
lw $10, -100($sp)
sub $8, $9, $10
sw $8, -100($sp)
lw $8, -100($sp)
blez $8, label8
label10:
label9:
lw $9, -28($sp)
move $8, $9
sw $8, -104($sp)
add $29, $29, -932
jal __getchar
sub $29, $29, -932
add $8, $29, -928
sw $8, -112($sp)
lw $9, -112($sp)
lw $8, 0($9)
sw $8, -108($sp)
lw $8, -108($sp)
lw $9, -104($sp)
sw $8, 0($9)
j label7
label8:
lw $9, 20($a3)
move $8, $9
sw $8, -128($sp)
lw $9, 20($a3)
lw $8, 0($9)
sw $8, -120($sp)
lw $9, -120($sp)
add $8, $9, 1
sw $8, -120($sp)
lw $8, -120($sp)
lw $9, -128($sp)
sw $8, 0($9)
lw $9, -120($sp)
mul $8, $9, 1
sw $8, -124($sp)
lw $9, 8($a3)
lw $10, -124($sp)
add $8, $9, $10
sw $8, -116($sp)
lw $9, -28($sp)
lb $8, 0($9)
sw $8, -132($sp)
lw $8, -132($sp)
lw $9, -116($sp)
sb $8, 0($9)
lw $9, -28($sp)
move $8, $9
sw $8, -136($sp)
add $29, $29, -932
jal __getchar
sub $29, $29, -932
add $8, $29, -928
sw $8, -144($sp)
lw $9, -144($sp)
lw $8, 0($9)
sw $8, -140($sp)
lw $8, -140($sp)
lw $9, -136($sp)
sw $8, 0($9)
label11:
li $8, 97
sw $8, -148($sp)
lw $9, -28($sp)
lw $8, 0($9)
sw $8, -152($sp)
lw $9, -148($sp)
lw $10, -152($sp)
sub $8, $9, $10
sw $8, -152($sp)
lw $8, -152($sp)
bgtz $8, label12
lw $9, -28($sp)
lw $8, 0($9)
sw $8, -156($sp)
li $8, 122
sw $8, -160($sp)
lw $9, -156($sp)
lw $10, -160($sp)
sub $8, $9, $10
sw $8, -160($sp)
lw $8, -160($sp)
bgtz $8, label12
lw $9, 20($a3)
move $8, $9
sw $8, -176($sp)
lw $9, 20($a3)
lw $8, 0($9)
sw $8, -168($sp)
lw $9, -168($sp)
add $8, $9, 1
sw $8, -168($sp)
lw $8, -168($sp)
lw $9, -176($sp)
sw $8, 0($9)
lw $9, -168($sp)
mul $8, $9, 1
sw $8, -172($sp)
lw $9, 8($a3)
lw $10, -172($sp)
add $8, $9, $10
sw $8, -164($sp)
lw $9, -28($sp)
lb $8, 0($9)
sw $8, -180($sp)
lw $8, -180($sp)
lw $9, -164($sp)
sb $8, 0($9)
label13:
lw $9, -28($sp)
move $8, $9
sw $8, -184($sp)
add $29, $29, -932
jal __getchar
sub $29, $29, -932
add $8, $29, -928
sw $8, -192($sp)
lw $9, -192($sp)
lw $8, 0($9)
sw $8, -188($sp)
lw $8, -188($sp)
lw $9, -184($sp)
sw $8, 0($9)
j label11
label12:
label14:
lw $9, -28($sp)
lw $8, 0($9)
sw $8, -196($sp)
li $8, 97
sw $8, -200($sp)
lw $9, -196($sp)
lw $10, -200($sp)
sub $8, $9, $10
sw $8, -200($sp)
lw $8, -200($sp)
bltz $8, label17
lw $9, -28($sp)
lw $8, 0($9)
sw $8, -204($sp)
li $8, 122
sw $8, -208($sp)
lw $9, -204($sp)
lw $10, -208($sp)
sub $8, $9, $10
sw $8, -208($sp)
lw $8, -208($sp)
blez $8, label15
label17:
label16:
lw $9, -28($sp)
move $8, $9
sw $8, -212($sp)
add $29, $29, -932
jal __getchar
sub $29, $29, -932
add $8, $29, -928
sw $8, -220($sp)
lw $9, -220($sp)
lw $8, 0($9)
sw $8, -216($sp)
lw $8, -216($sp)
lw $9, -212($sp)
sw $8, 0($9)
j label14
label15:
lw $9, 24($a3)
move $8, $9
sw $8, -236($sp)
lw $9, 24($a3)
lw $8, 0($9)
sw $8, -228($sp)
lw $9, -228($sp)
add $8, $9, 1
sw $8, -228($sp)
lw $8, -228($sp)
lw $9, -236($sp)
sw $8, 0($9)
lw $9, -228($sp)
mul $8, $9, 1
sw $8, -232($sp)
lw $9, 12($a3)
lw $10, -232($sp)
add $8, $9, $10
sw $8, -224($sp)
lw $9, -28($sp)
lb $8, 0($9)
sw $8, -240($sp)
lw $8, -240($sp)
lw $9, -224($sp)
sb $8, 0($9)
lw $9, -28($sp)
move $8, $9
sw $8, -244($sp)
add $29, $29, -932
jal __getchar
sub $29, $29, -932
add $8, $29, -928
sw $8, -252($sp)
lw $9, -252($sp)
lw $8, 0($9)
sw $8, -248($sp)
lw $8, -248($sp)
lw $9, -244($sp)
sw $8, 0($9)
label18:
li $8, 97
sw $8, -256($sp)
lw $9, -28($sp)
lw $8, 0($9)
sw $8, -260($sp)
lw $9, -256($sp)
lw $10, -260($sp)
sub $8, $9, $10
sw $8, -260($sp)
lw $8, -260($sp)
bgtz $8, label19
lw $9, -28($sp)
lw $8, 0($9)
sw $8, -264($sp)
li $8, 122
sw $8, -268($sp)
lw $9, -264($sp)
lw $10, -268($sp)
sub $8, $9, $10
sw $8, -268($sp)
lw $8, -268($sp)
bgtz $8, label19
lw $9, 24($a3)
move $8, $9
sw $8, -284($sp)
lw $9, 24($a3)
lw $8, 0($9)
sw $8, -276($sp)
lw $9, -276($sp)
add $8, $9, 1
sw $8, -276($sp)
lw $8, -276($sp)
lw $9, -284($sp)
sw $8, 0($9)
lw $9, -276($sp)
mul $8, $9, 1
sw $8, -280($sp)
lw $9, 12($a3)
lw $10, -280($sp)
add $8, $9, $10
sw $8, -272($sp)
lw $9, -28($sp)
lb $8, 0($9)
sw $8, -288($sp)
lw $8, -288($sp)
lw $9, -272($sp)
sb $8, 0($9)
label20:
lw $9, -28($sp)
move $8, $9
sw $8, -292($sp)
add $29, $29, -932
jal __getchar
sub $29, $29, -932
add $8, $29, -928
sw $8, -300($sp)
lw $9, -300($sp)
lw $8, 0($9)
sw $8, -296($sp)
lw $8, -296($sp)
lw $9, -292($sp)
sw $8, 0($9)
j label18
label19:
lw $9, 28($a3)
move $8, $9
sw $8, -304($sp)
li $8, 0
sw $8, -308($sp)
lw $8, -308($sp)
lw $9, -304($sp)
sw $8, 0($9)
lw $9, -4($sp)
move $8, $9
sw $8, -312($sp)
li $8, 1
sw $8, -316($sp)
lw $8, -316($sp)
lw $9, -312($sp)
sw $8, 0($9)
label21:
lw $9, -4($sp)
lw $8, 0($9)
sw $8, -320($sp)
lw $9, 24($a3)
lw $8, 0($9)
sw $8, -324($sp)
lw $9, -320($sp)
lw $10, -324($sp)
sub $8, $9, $10
sw $8, -324($sp)
lw $8, -324($sp)
bgtz $8, label22
lw $9, 28($a3)
move $8, $9
sw $8, -340($sp)
lw $9, 28($a3)
lw $8, 0($9)
sw $8, -332($sp)
lw $9, -332($sp)
add $8, $9, 1
sw $8, -332($sp)
lw $8, -332($sp)
lw $9, -340($sp)
sw $8, 0($9)
lw $9, -332($sp)
mul $8, $9, 1
sw $8, -336($sp)
lw $9, 16($a3)
lw $10, -336($sp)
add $8, $9, $10
sw $8, -328($sp)
lw $9, -4($sp)
lw $8, 0($9)
sw $8, -348($sp)
lw $9, -348($sp)
mul $8, $9, 1
sw $8, -352($sp)
lw $9, 12($a3)
lw $10, -352($sp)
add $8, $9, $10
sw $8, -344($sp)
lw $9, -344($sp)
lb $8, 0($9)
sw $8, -344($sp)
lw $8, -344($sp)
lw $9, -328($sp)
sb $8, 0($9)
label23:
lw $9, -4($sp)
move $8, $9
sw $8, -360($sp)
lw $9, -4($sp)
lw $8, 0($9)
sw $8, -356($sp)
lw $9, -356($sp)
add $8, $9, 1
sw $8, -364($sp)
lw $8, -364($sp)
lw $9, -360($sp)
sw $8, 0($9)
j label21
label22:
lw $9, 28($a3)
move $8, $9
sw $8, -380($sp)
lw $9, 28($a3)
lw $8, 0($9)
sw $8, -372($sp)
lw $9, -372($sp)
add $8, $9, 1
sw $8, -372($sp)
lw $8, -372($sp)
lw $9, -380($sp)
sw $8, 0($9)
lw $9, -372($sp)
mul $8, $9, 1
sw $8, -376($sp)
lw $9, 16($a3)
lw $10, -376($sp)
add $8, $9, $10
sw $8, -368($sp)
li $8, 36
sw $8, -384($sp)
lw $8, -384($sp)
lw $9, -368($sp)
sb $8, 0($9)
lw $9, -4($sp)
move $8, $9
sw $8, -388($sp)
li $8, 1
sw $8, -392($sp)
lw $8, -392($sp)
lw $9, -388($sp)
sw $8, 0($9)
label24:
lw $9, -4($sp)
lw $8, 0($9)
sw $8, -396($sp)
lw $9, 20($a3)
lw $8, 0($9)
sw $8, -400($sp)
lw $9, -396($sp)
lw $10, -400($sp)
sub $8, $9, $10
sw $8, -400($sp)
lw $8, -400($sp)
bgtz $8, label25
lw $9, 28($a3)
move $8, $9
sw $8, -416($sp)
lw $9, 28($a3)
lw $8, 0($9)
sw $8, -408($sp)
lw $9, -408($sp)
add $8, $9, 1
sw $8, -408($sp)
lw $8, -408($sp)
lw $9, -416($sp)
sw $8, 0($9)
lw $9, -408($sp)
mul $8, $9, 1
sw $8, -412($sp)
lw $9, 16($a3)
lw $10, -412($sp)
add $8, $9, $10
sw $8, -404($sp)
lw $9, -4($sp)
lw $8, 0($9)
sw $8, -424($sp)
lw $9, -424($sp)
mul $8, $9, 1
sw $8, -428($sp)
lw $9, 8($a3)
lw $10, -428($sp)
add $8, $9, $10
sw $8, -420($sp)
lw $9, -420($sp)
lb $8, 0($9)
sw $8, -420($sp)
lw $8, -420($sp)
lw $9, -404($sp)
sb $8, 0($9)
label26:
lw $9, -4($sp)
move $8, $9
sw $8, -436($sp)
lw $9, -4($sp)
lw $8, 0($9)
sw $8, -432($sp)
lw $9, -432($sp)
add $8, $9, 1
sw $8, -440($sp)
lw $8, -440($sp)
lw $9, -436($sp)
sw $8, 0($9)
j label24
label25:
li $8, 1
sw $8, -452($sp)
lw $9, -452($sp)
mul $8, $9, 4
sw $8, -456($sp)
lw $9, 32($a3)
lw $10, -456($sp)
add $8, $9, $10
sw $8, -448($sp)
li $8, 0
sw $8, -460($sp)
lw $8, -460($sp)
lw $9, -448($sp)
sw $8, 0($9)
lw $9, -12($sp)
move $8, $9
sw $8, -444($sp)
li $8, 1
sw $8, -464($sp)
lw $8, -464($sp)
lw $9, -444($sp)
sw $8, 0($9)
lw $9, -4($sp)
move $8, $9
sw $8, -468($sp)
li $8, 2
sw $8, -472($sp)
lw $8, -472($sp)
lw $9, -468($sp)
sw $8, 0($9)
label27:
lw $9, -4($sp)
lw $8, 0($9)
sw $8, -476($sp)
lw $9, 28($a3)
lw $8, 0($9)
sw $8, -480($sp)
lw $9, -476($sp)
lw $10, -480($sp)
sub $8, $9, $10
sw $8, -480($sp)
lw $8, -480($sp)
bgtz $8, label28
lw $9, -12($sp)
lw $8, 0($9)
sw $8, -484($sp)
lw $9, -12($sp)
lw $8, 0($9)
sw $8, -492($sp)
lw $9, -492($sp)
mul $8, $9, 4
sw $8, -496($sp)
lw $9, 32($a3)
lw $10, -496($sp)
add $8, $9, $10
sw $8, -488($sp)
lw $9, -488($sp)
lw $8, 0($9)
sw $8, -488($sp)
lw $9, -484($sp)
lw $10, -488($sp)
add $8, $9, $10
sw $8, -484($sp)
lw $9, -4($sp)
lw $8, 0($9)
sw $8, -500($sp)
lw $9, -484($sp)
lw $10, -500($sp)
sub $8, $9, $10
sw $8, -500($sp)
lw $8, -500($sp)
bltz $8, label30
lw $9, -4($sp)
lw $8, 0($9)
sw $8, -508($sp)
lw $9, -508($sp)
mul $8, $9, 4
sw $8, -512($sp)
lw $9, 32($a3)
lw $10, -512($sp)
add $8, $9, $10
sw $8, -504($sp)
lw $9, -12($sp)
lw $8, 0($9)
sw $8, -520($sp)
lw $9, -12($sp)
lw $8, 0($9)
sw $8, -528($sp)
lw $9, -528($sp)
mul $8, $9, 4
sw $8, -532($sp)
lw $9, 32($a3)
lw $10, -532($sp)
add $8, $9, $10
sw $8, -524($sp)
lw $9, -524($sp)
lw $8, 0($9)
sw $8, -524($sp)
lw $9, -520($sp)
lw $10, -524($sp)
add $8, $9, $10
sw $8, -520($sp)
lw $9, -4($sp)
lw $8, 0($9)
sw $8, -536($sp)
lw $9, -520($sp)
lw $10, -536($sp)
sub $8, $9, $10
sw $8, -520($sp)
add $8, $29, -936
sw $8, -540($sp)
lw $8, -520($sp)
lw $9, -540($sp)
sw $8, 0($9)
lw $9, -4($sp)
lw $8, 0($9)
sw $8, -548($sp)
lw $9, -12($sp)
lw $8, 0($9)
sw $8, -556($sp)
lw $9, -548($sp)
lw $10, -556($sp)
sub $8, $9, $10
sw $8, -548($sp)
li $8, 1
sw $8, -560($sp)
lw $9, -548($sp)
lw $10, -560($sp)
add $8, $9, $10
sw $8, -548($sp)
lw $9, -548($sp)
mul $8, $9, 4
sw $8, -552($sp)
lw $9, 32($a3)
lw $10, -552($sp)
add $8, $9, $10
sw $8, -544($sp)
add $8, $29, -940
sw $8, -564($sp)
lw $9, -544($sp)
lw $8, 0($9)
sw $8, -544($sp)
lw $8, -544($sp)
lw $9, -564($sp)
sw $8, 0($9)
add $29, $29, -940
jal __min
sub $29, $29, -940
add $8, $29, -928
sw $8, -568($sp)
lw $9, -568($sp)
lw $8, 0($9)
sw $8, -516($sp)
lw $8, -516($sp)
lw $9, -504($sp)
sw $8, 0($9)
j label31
label30:
lw $9, -4($sp)
lw $8, 0($9)
sw $8, -576($sp)
lw $9, -576($sp)
mul $8, $9, 4
sw $8, -580($sp)
lw $9, 32($a3)
lw $10, -580($sp)
add $8, $9, $10
sw $8, -572($sp)
li $8, 0
sw $8, -584($sp)
lw $8, -584($sp)
lw $9, -572($sp)
sw $8, 0($9)
label31:
lw $9, -4($sp)
lw $8, 0($9)
sw $8, -592($sp)
lw $9, -592($sp)
mul $8, $9, 4
sw $8, -596($sp)
lw $9, 32($a3)
lw $10, -596($sp)
add $8, $9, $10
sw $8, -588($sp)
li $8, 0
sw $8, -604($sp)
add $8, $29, -936
sw $8, -608($sp)
lw $8, -604($sp)
lw $9, -608($sp)
sw $8, 0($9)
lw $9, -4($sp)
lw $8, 0($9)
sw $8, -616($sp)
lw $9, -616($sp)
mul $8, $9, 4
sw $8, -620($sp)
lw $9, 32($a3)
lw $10, -620($sp)
add $8, $9, $10
sw $8, -612($sp)
add $8, $29, -940
sw $8, -624($sp)
lw $9, -612($sp)
lw $8, 0($9)
sw $8, -612($sp)
lw $8, -612($sp)
lw $9, -624($sp)
sw $8, 0($9)
add $29, $29, -940
jal __max
sub $29, $29, -940
add $8, $29, -928
sw $8, -628($sp)
lw $9, -628($sp)
lw $8, 0($9)
sw $8, -600($sp)
lw $8, -600($sp)
lw $9, -588($sp)
sw $8, 0($9)
label32:
lw $9, -4($sp)
lw $8, 0($9)
sw $8, -636($sp)
lw $9, -636($sp)
mul $8, $9, 4
sw $8, -640($sp)
lw $9, 32($a3)
lw $10, -640($sp)
add $8, $9, $10
sw $8, -632($sp)
lw $9, -632($sp)
lw $8, 0($9)
sw $8, -632($sp)
li $8, 0
sw $8, -644($sp)
lw $9, -632($sp)
lw $10, -644($sp)
sub $8, $9, $10
sw $8, -644($sp)
li $8, 1
sw $8, -632($sp)
lw $8, -644($sp)
bgez $8, label34
li $8, 0
sw $8, -632($sp)
label34:
lw $8, -632($sp)
beqz $8, label33
lw $9, -4($sp)
lw $8, 0($9)
sw $8, -648($sp)
lw $9, -4($sp)
lw $8, 0($9)
sw $8, -656($sp)
lw $9, -656($sp)
mul $8, $9, 4
sw $8, -660($sp)
lw $9, 32($a3)
lw $10, -660($sp)
add $8, $9, $10
sw $8, -652($sp)
lw $9, -652($sp)
lw $8, 0($9)
sw $8, -652($sp)
lw $9, -648($sp)
lw $10, -652($sp)
add $8, $9, $10
sw $8, -648($sp)
lw $9, 28($a3)
lw $8, 0($9)
sw $8, -664($sp)
lw $9, -648($sp)
lw $10, -664($sp)
sub $8, $9, $10
sw $8, -664($sp)
li $8, 1
sw $8, -648($sp)
lw $8, -664($sp)
blez $8, label35
li $8, 0
sw $8, -648($sp)
label35:
lw $8, -648($sp)
beqz $8, label33
li $8, 1
sw $8, -672($sp)
lw $9, -4($sp)
lw $8, 0($9)
sw $8, -684($sp)
lw $9, -684($sp)
mul $8, $9, 4
sw $8, -688($sp)
lw $9, 32($a3)
lw $10, -688($sp)
add $8, $9, $10
sw $8, -680($sp)
lw $9, -680($sp)
lw $8, 0($9)
sw $8, -680($sp)
lw $9, -672($sp)
lw $10, -680($sp)
add $8, $9, $10
sw $8, -672($sp)
lw $9, -672($sp)
mul $8, $9, 1
sw $8, -676($sp)
lw $9, 16($a3)
lw $10, -676($sp)
add $8, $9, $10
sw $8, -668($sp)
lw $9, -668($sp)
lb $8, 0($9)
sw $8, -668($sp)
lw $9, -4($sp)
lw $8, 0($9)
sw $8, -696($sp)
lw $9, -4($sp)
lw $8, 0($9)
sw $8, -708($sp)
lw $9, -708($sp)
mul $8, $9, 4
sw $8, -712($sp)
lw $9, 32($a3)
lw $10, -712($sp)
add $8, $9, $10
sw $8, -704($sp)
lw $9, -704($sp)
lw $8, 0($9)
sw $8, -704($sp)
lw $9, -696($sp)
lw $10, -704($sp)
add $8, $9, $10
sw $8, -696($sp)
lw $9, -696($sp)
mul $8, $9, 1
sw $8, -700($sp)
lw $9, 16($a3)
lw $10, -700($sp)
add $8, $9, $10
sw $8, -692($sp)
lw $9, -692($sp)
lb $8, 0($9)
sw $8, -692($sp)
lw $9, -668($sp)
lw $10, -692($sp)
sub $8, $9, $10
sw $8, -692($sp)
li $8, 1
sw $8, -668($sp)
lw $8, -692($sp)
beqz $8, label36
li $8, 0
sw $8, -668($sp)
label36:
lw $8, -668($sp)
beqz $8, label33
lw $9, -4($sp)
lw $8, 0($9)
sw $8, -720($sp)
lw $9, -720($sp)
mul $8, $9, 4
sw $8, -724($sp)
lw $9, 32($a3)
lw $10, -724($sp)
add $8, $9, $10
sw $8, -716($sp)
lw $9, -716($sp)
move $8, $9
sw $8, -728($sp)
lw $9, -716($sp)
lw $8, 0($9)
sw $8, -716($sp)
lw $9, -716($sp)
add $8, $9, 1
sw $8, -732($sp)
lw $8, -732($sp)
lw $9, -728($sp)
sw $8, 0($9)
j label32
label33:
lw $9, -4($sp)
lw $8, 0($9)
sw $8, -740($sp)
lw $9, -740($sp)
mul $8, $9, 4
sw $8, -744($sp)
lw $9, 32($a3)
lw $10, -744($sp)
add $8, $9, $10
sw $8, -736($sp)
lw $9, -736($sp)
move $8, $9
sw $8, -748($sp)
lw $9, -736($sp)
lw $8, 0($9)
sw $8, -736($sp)
lw $9, -736($sp)
sub $8, $9, 1
sw $8, -752($sp)
lw $8, -752($sp)
lw $9, -748($sp)
sw $8, 0($9)
lw $9, -4($sp)
lw $8, 0($9)
sw $8, -756($sp)
lw $9, -4($sp)
lw $8, 0($9)
sw $8, -764($sp)
lw $9, -764($sp)
mul $8, $9, 4
sw $8, -768($sp)
lw $9, 32($a3)
lw $10, -768($sp)
add $8, $9, $10
sw $8, -760($sp)
lw $9, -760($sp)
lw $8, 0($9)
sw $8, -760($sp)
lw $9, -756($sp)
lw $10, -760($sp)
add $8, $9, $10
sw $8, -756($sp)
lw $9, -12($sp)
lw $8, 0($9)
sw $8, -772($sp)
lw $9, -12($sp)
lw $8, 0($9)
sw $8, -780($sp)
lw $9, -780($sp)
mul $8, $9, 4
sw $8, -784($sp)
lw $9, 32($a3)
lw $10, -784($sp)
add $8, $9, $10
sw $8, -776($sp)
lw $9, -776($sp)
lw $8, 0($9)
sw $8, -776($sp)
lw $9, -772($sp)
lw $10, -776($sp)
add $8, $9, $10
sw $8, -772($sp)
lw $9, -756($sp)
lw $10, -772($sp)
sub $8, $9, $10
sw $8, -772($sp)
lw $8, -772($sp)
blez $8, label37
lw $9, -12($sp)
move $8, $9
sw $8, -788($sp)
lw $9, -4($sp)
lw $8, 0($9)
sw $8, -792($sp)
lw $8, -792($sp)
lw $9, -788($sp)
sw $8, 0($9)
label37:
label29:
lw $9, -4($sp)
move $8, $9
sw $8, -800($sp)
lw $9, -4($sp)
lw $8, 0($9)
sw $8, -796($sp)
lw $9, -796($sp)
add $8, $9, 1
sw $8, -804($sp)
lw $8, -804($sp)
lw $9, -800($sp)
sw $8, 0($9)
j label27
label28:
lw $9, -4($sp)
move $8, $9
sw $8, -808($sp)
lw $9, 24($a3)
lw $8, 0($9)
sw $8, -812($sp)
li $8, 2
sw $8, -816($sp)
lw $9, -812($sp)
lw $10, -816($sp)
add $8, $9, $10
sw $8, -812($sp)
lw $8, -812($sp)
lw $9, -808($sp)
sw $8, 0($9)
label38:
lw $9, -4($sp)
lw $8, 0($9)
sw $8, -820($sp)
lw $9, 28($a3)
lw $8, 0($9)
sw $8, -824($sp)
lw $9, -820($sp)
lw $10, -824($sp)
sub $8, $9, $10
sw $8, -824($sp)
lw $8, -824($sp)
bgtz $8, label39
lw $9, -4($sp)
lw $8, 0($9)
sw $8, -828($sp)
lw $9, -4($sp)
lw $8, 0($9)
sw $8, -836($sp)
lw $9, -836($sp)
mul $8, $9, 4
sw $8, -840($sp)
lw $9, 32($a3)
lw $10, -840($sp)
add $8, $9, $10
sw $8, -832($sp)
lw $9, -832($sp)
lw $8, 0($9)
sw $8, -832($sp)
lw $9, -828($sp)
lw $10, -832($sp)
add $8, $9, $10
sw $8, -828($sp)
lw $9, 28($a3)
lw $8, 0($9)
sw $8, -844($sp)
lw $9, -828($sp)
lw $10, -844($sp)
sub $8, $9, $10
sw $8, -844($sp)
lw $8, -844($sp)
bnez $8, label41
lw $9, -20($sp)
move $8, $9
sw $8, -852($sp)
lw $9, -20($sp)
lw $8, 0($9)
sw $8, -848($sp)
lw $9, -848($sp)
add $8, $9, 1
sw $8, -856($sp)
lw $8, -856($sp)
lw $9, -852($sp)
sw $8, 0($9)
label41:
label40:
lw $9, -4($sp)
move $8, $9
sw $8, -864($sp)
lw $9, -4($sp)
lw $8, 0($9)
sw $8, -860($sp)
lw $9, -860($sp)
add $8, $9, 1
sw $8, -868($sp)
lw $8, -868($sp)
lw $9, -864($sp)
sw $8, 0($9)
j label38
label39:
add $8, $29, -932
sw $8, -880($sp)
lw $9, -20($sp)
lw $8, 0($9)
sw $8, -876($sp)
lw $8, -876($sp)
lw $9, -880($sp)
sw $8, 0($9)
lw $9, 1060($a3)
move $8, $9
sw $8, -884($sp)
add $8, $29, -936
sw $8, -888($sp)
lw $8, -884($sp)
lw $9, -888($sp)
sw $8, 0($9)
add $29, $29, -936
jal __printf
sub $29, $29, -936
label6:
lw $9, 36($a3)
move $8, $9
sw $8, -896($sp)
lw $9, 36($a3)
lw $8, 0($9)
sw $8, -892($sp)
lw $9, -892($sp)
sub $8, $9, 1
sw $8, -900($sp)
lw $8, -900($sp)
lw $9, -896($sp)
sw $8, 0($9)
j label4
label5:
li $8, 0
sw $8, -904($sp)
add $8, $29, 4
sw $8, -908($sp)
lw $8, -904($sp)
lw $9, -908($sp)
sw $8, 0($9)
j __main_end
j __main_end
__main_end:
li $v0, 10
syscall
#global $2 200
#global $3 200
#global $4 500
#global $5 4
#global $6 4
#global $7 4
#global $8 800
#global $9 4
#string $265 #%d\n
#----------------------------
#func #min
#addi $10 $0 0
#addi $11 $0 4
####move $12 $10
#lw $12 $10 0
####move $13 $11
#lw $13 $11 0
#sub $13 $12 $13
#bgez $13 l:0
####move $14 $10
#addi $15 $0 12
#lw $14 $10 0
#sw $14 $15 0
#return
#label l:0
####move $16 $11
#addi $17 $0 12
#lw $16 $11 0
#sw $16 $17 0
#return
#return
#----------------------------
#func #max
#addi $18 $0 0
#addi $19 $0 4
####move $20 $18
#lw $20 $18 0
####move $21 $19
#lw $21 $19 0
#sub $21 $20 $21
#blez $21 l:1
####move $22 $18
#addi $23 $0 12
#lw $22 $18 0
#sw $22 $23 0
#return
#label l:1
####move $24 $19
#addi $25 $0 12
#lw $24 $19 0
#sw $24 $25 0
#return
#return
#----------------------------
#func #get_val
#addi $27 $0 -76
#move $26 $27
#li $28 0
#sw $28 $26 0
#addi $30 $0 -80
#move $29 $30
#label l:2
#move $31 $29
#sw $1 $0 -88
#addi $0 $0 -88
#call #getchar
#subi $0 $0 -88
#lw $1 $0 -88
#addi $33 $0 -84
####move $32 $33
#lw $32 $33 0
#sw $32 $31 0
#lw $31 $31 0
#li $34 48
#sub $34 $31 $34
#bltz $34 l:3
####move $35 $29
#lw $35 $29 0
#li $36 57
#sub $36 $35 $36
#bgtz $36 l:3
#move $37 $26
####move $38 $26
#lw $38 $26 0
#li $39 10
#mul $38 $38 $39
####move $40 $29
#lw $40 $29 0
#add $38 $38 $40
#li $41 48
#sub $38 $38 $41
#sw $38 $37 0
#goto l:2
#label l:3
####move $42 $26
#addi $43 $0 4
#lw $42 $26 0
#sw $42 $43 0
#return
#return
#----------------------------
#func #main
#addi $45 $0 -912
#move $44 $45
#addi $47 $0 -916
#move $46 $47
#addi $49 $0 -920
#move $48 $49
#addi $51 $0 -924
#move $50 $51
#move $52 $9
#addi $0 $0 -932
#call #get_val
#subi $0 $0 -932
#addi $54 $0 -928
####move $53 $54
#lw $53 $54 0
#sw $53 $52 0
#label l:4
####move $55 $9
#lw $55 $9 0
#beqz $55 l:5
#move $56 $48
#li $57 1
#sw $57 $56 0
#move $59 $5
#li $60 0
#sw $60 $59 0
#move $58 $6
#li $61 0
#sw $61 $58 0
#move $62 $50
#addi $0 $0 -932
#call #getchar
#subi $0 $0 -932
#addi $64 $0 -928
####move $63 $64
#lw $63 $64 0
#sw $63 $62 0
#label l:7
####move $65 $50
#lw $65 $50 0
#li $66 97
#sub $66 $65 $66
#bltz $66 l:10
####move $67 $50
#lw $67 $50 0
#li $68 122
#sub $68 $67 $68
#blez $68 l:8
#label l:10
#label l:9
#move $69 $50
#addi $0 $0 -932
#call #getchar
#subi $0 $0 -932
#addi $71 $0 -928
####move $70 $71
#lw $70 $71 0
#sw $70 $69 0
#goto l:7
#label l:8
####move $72 $2
####move $73 $5
#move $75 $5
#lw $73 $5 0
#addi $73 $73 1
#sw $73 $75 0
#muli $74 $73 1
#add $72 $2 $74
####move $76 $50
#lb $76 $50 0
#sb $76 $72 0
#move $77 $50
#addi $0 $0 -932
#call #getchar
#subi $0 $0 -932
#addi $79 $0 -928
####move $78 $79
#lw $78 $79 0
#sw $78 $77 0
#label l:11
#li $80 97
####move $81 $50
#lw $81 $50 0
#sub $81 $80 $81
#bgtz $81 l:12
####move $82 $50
#lw $82 $50 0
#li $83 122
#sub $83 $82 $83
#bgtz $83 l:12
####move $84 $2
####move $85 $5
#move $87 $5
#lw $85 $5 0
#addi $85 $85 1
#sw $85 $87 0
#muli $86 $85 1
#add $84 $2 $86
####move $88 $50
#lb $88 $50 0
#sb $88 $84 0
#label l:13
#move $89 $50
#addi $0 $0 -932
#call #getchar
#subi $0 $0 -932
#addi $91 $0 -928
####move $90 $91
#lw $90 $91 0
#sw $90 $89 0
#goto l:11
#label l:12
#label l:14
####move $92 $50
#lw $92 $50 0
#li $93 97
#sub $93 $92 $93
#bltz $93 l:17
####move $94 $50
#lw $94 $50 0
#li $95 122
#sub $95 $94 $95
#blez $95 l:15
#label l:17
#label l:16
#move $96 $50
#addi $0 $0 -932
#call #getchar
#subi $0 $0 -932
#addi $98 $0 -928
####move $97 $98
#lw $97 $98 0
#sw $97 $96 0
#goto l:14
#label l:15
####move $99 $3
####move $100 $6
#move $102 $6
#lw $100 $6 0
#addi $100 $100 1
#sw $100 $102 0
#muli $101 $100 1
#add $99 $3 $101
####move $103 $50
#lb $103 $50 0
#sb $103 $99 0
#move $104 $50
#addi $0 $0 -932
#call #getchar
#subi $0 $0 -932
#addi $106 $0 -928
####move $105 $106
#lw $105 $106 0
#sw $105 $104 0
#label l:18
#li $107 97
####move $108 $50
#lw $108 $50 0
#sub $108 $107 $108
#bgtz $108 l:19
####move $109 $50
#lw $109 $50 0
#li $110 122
#sub $110 $109 $110
#bgtz $110 l:19
####move $111 $3
####move $112 $6
#move $114 $6
#lw $112 $6 0
#addi $112 $112 1
#sw $112 $114 0
#muli $113 $112 1
#add $111 $3 $113
####move $115 $50
#lb $115 $50 0
#sb $115 $111 0
#label l:20
#move $116 $50
#addi $0 $0 -932
#call #getchar
#subi $0 $0 -932
#addi $118 $0 -928
####move $117 $118
#lw $117 $118 0
#sw $117 $116 0
#goto l:18
#label l:19
#move $119 $7
#li $120 0
#sw $120 $119 0
#move $121 $44
#li $122 1
#sw $122 $121 0
#label l:21
####move $123 $44
#lw $123 $44 0
####move $124 $6
#lw $124 $6 0
#sub $124 $123 $124
#bgtz $124 l:22
####move $125 $4
####move $126 $7
#move $128 $7
#lw $126 $7 0
#addi $126 $126 1
#sw $126 $128 0
#muli $127 $126 1
#add $125 $4 $127
####move $129 $3
####move $130 $44
#lw $130 $44 0
#muli $131 $130 1
#add $129 $3 $131
#lb $129 $129 0
#sb $129 $125 0
#label l:23
####move $132 $44
#move $133 $44
#lw $132 $44 0
#addi $134 $132 1
#sw $134 $133 0
#goto l:21
#label l:22
####move $135 $4
####move $136 $7
#move $138 $7
#lw $136 $7 0
#addi $136 $136 1
#sw $136 $138 0
#muli $137 $136 1
#add $135 $4 $137
#li $139 36
#sb $139 $135 0
#move $140 $44
#li $141 1
#sw $141 $140 0
#label l:24
####move $142 $44
#lw $142 $44 0
####move $143 $5
#lw $143 $5 0
#sub $143 $142 $143
#bgtz $143 l:25
####move $144 $4
####move $145 $7
#move $147 $7
#lw $145 $7 0
#addi $145 $145 1
#sw $145 $147 0
#muli $146 $145 1
#add $144 $4 $146
####move $148 $2
####move $149 $44
#lw $149 $44 0
#muli $150 $149 1
#add $148 $2 $150
#lb $148 $148 0
#sb $148 $144 0
#label l:26
####move $151 $44
#move $152 $44
#lw $151 $44 0
#addi $153 $151 1
#sw $153 $152 0
#goto l:24
#label l:25
####move $155 $8
#li $156 1
#muli $157 $156 4
#add $155 $8 $157
#li $158 0
#sw $158 $155 0
#move $154 $46
#li $159 1
#sw $159 $154 0
#move $160 $44
#li $161 2
#sw $161 $160 0
#label l:27
####move $162 $44
#lw $162 $44 0
####move $163 $7
#lw $163 $7 0
#sub $163 $162 $163
#bgtz $163 l:28
####move $164 $46
#lw $164 $46 0
####move $165 $8
####move $166 $46
#lw $166 $46 0
#muli $167 $166 4
#add $165 $8 $167
#lw $165 $165 0
#add $164 $164 $165
####move $168 $44
#lw $168 $44 0
#sub $168 $164 $168
#bltz $168 l:30
####move $169 $8
####move $170 $44
#lw $170 $44 0
#muli $171 $170 4
#add $169 $8 $171
####move $173 $46
#lw $173 $46 0
####move $174 $8
####move $175 $46
#lw $175 $46 0
#muli $176 $175 4
#add $174 $8 $176
#lw $174 $174 0
#add $173 $173 $174
####move $177 $44
#lw $177 $44 0
#sub $173 $173 $177
#addi $178 $0 -936
#sw $173 $178 0
####move $179 $8
####move $180 $44
#lw $180 $44 0
####move $182 $46
#lw $182 $46 0
#sub $180 $180 $182
#li $183 1
#add $180 $180 $183
#muli $181 $180 4
#add $179 $8 $181
#addi $184 $0 -940
#lw $179 $179 0
#sw $179 $184 0
#addi $0 $0 -940
#call #min
#subi $0 $0 -940
#addi $185 $0 -928
####move $172 $185
#lw $172 $185 0
#sw $172 $169 0
#goto l:31
#label l:30
####move $186 $8
####move $187 $44
#lw $187 $44 0
#muli $188 $187 4
#add $186 $8 $188
#li $189 0
#sw $189 $186 0
#label l:31
####move $190 $8
####move $191 $44
#lw $191 $44 0
#muli $192 $191 4
#add $190 $8 $192
#li $194 0
#addi $195 $0 -936
#sw $194 $195 0
####move $196 $8
####move $197 $44
#lw $197 $44 0
#muli $198 $197 4
#add $196 $8 $198
#addi $199 $0 -940
#lw $196 $196 0
#sw $196 $199 0
#addi $0 $0 -940
#call #max
#subi $0 $0 -940
#addi $200 $0 -928
####move $193 $200
#lw $193 $200 0
#sw $193 $190 0
#label l:32
####move $201 $8
####move $202 $44
#lw $202 $44 0
#muli $203 $202 4
#add $201 $8 $203
#lw $201 $201 0
#li $204 0
#sub $204 $201 $204
#li $201 1
#bgez $204 l:34
#li $201 0
#label l:34
#beqz $201 l:33
####move $205 $44
#lw $205 $44 0
####move $206 $8
####move $207 $44
#lw $207 $44 0
#muli $208 $207 4
#add $206 $8 $208
#lw $206 $206 0
#add $205 $205 $206
####move $209 $7
#lw $209 $7 0
#sub $209 $205 $209
#li $205 1
#blez $209 l:35
#li $205 0
#label l:35
#beqz $205 l:33
####move $210 $4
#li $211 1
####move $213 $8
####move $214 $44
#lw $214 $44 0
#muli $215 $214 4
#add $213 $8 $215
#lw $213 $213 0
#add $211 $211 $213
#muli $212 $211 1
#add $210 $4 $212
#lb $210 $210 0
####move $216 $4
####move $217 $44
#lw $217 $44 0
####move $219 $8
####move $220 $44
#lw $220 $44 0
#muli $221 $220 4
#add $219 $8 $221
#lw $219 $219 0
#add $217 $217 $219
#muli $218 $217 1
#add $216 $4 $218
#lb $216 $216 0
#sub $216 $210 $216
#li $210 1
#beqz $216 l:36
#li $210 0
#label l:36
#beqz $210 l:33
####move $222 $8
####move $223 $44
#lw $223 $44 0
#muli $224 $223 4
#add $222 $8 $224
#move $225 $222
#lw $222 $222 0
#addi $226 $222 1
#sw $226 $225 0
#goto l:32
#label l:33
####move $227 $8
####move $228 $44
#lw $228 $44 0
#muli $229 $228 4
#add $227 $8 $229
#move $230 $227
#lw $227 $227 0
#subi $231 $227 1
#sw $231 $230 0
####move $232 $44
#lw $232 $44 0
####move $233 $8
####move $234 $44
#lw $234 $44 0
#muli $235 $234 4
#add $233 $8 $235
#lw $233 $233 0
#add $232 $232 $233
####move $236 $46
#lw $236 $46 0
####move $237 $8
####move $238 $46
#lw $238 $46 0
#muli $239 $238 4
#add $237 $8 $239
#lw $237 $237 0
#add $236 $236 $237
#sub $236 $232 $236
#blez $236 l:37
#move $240 $46
####move $241 $44
#lw $241 $44 0
#sw $241 $240 0
#label l:37
#label l:29
####move $242 $44
#move $243 $44
#lw $242 $44 0
#addi $244 $242 1
#sw $244 $243 0
#goto l:27
#label l:28
#move $245 $44
####move $246 $6
#lw $246 $6 0
#li $247 2
#add $246 $246 $247
#sw $246 $245 0
#label l:38
####move $248 $44
#lw $248 $44 0
####move $249 $7
#lw $249 $7 0
#sub $249 $248 $249
#bgtz $249 l:39
####move $250 $44
#lw $250 $44 0
####move $251 $8
####move $252 $44
#lw $252 $44 0
#muli $253 $252 4
#add $251 $8 $253
#lw $251 $251 0
#add $250 $250 $251
####move $254 $7
#lw $254 $7 0
#sub $254 $250 $254
#bnez $254 l:41
####move $255 $48
#move $256 $48
#lw $255 $48 0
#addi $257 $255 1
#sw $257 $256 0
#label l:41
#label l:40
####move $258 $44
#move $259 $44
#lw $258 $44 0
#addi $260 $258 1
#sw $260 $259 0
#goto l:38
#label l:39
####move $262 $48
#addi $263 $0 -932
#lw $262 $48 0
#sw $262 $263 0
#move $264 $265
#addi $266 $0 -936
#sw $264 $266 0
#addi $0 $0 -936
#call #printf
#subi $0 $0 -936
#label l:6
####move $267 $9
#move $268 $9
#lw $267 $9 0
#subi $269 $267 1
#sw $269 $268 0
#goto l:4
#label l:5
#li $270 0
#addi $271 $0 4
#sw $270 $271 0
#return
#return
