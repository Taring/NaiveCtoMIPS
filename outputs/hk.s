.data
temp: .space 1156
var0: .space 4
var1: .space 4
var2: .space 4
var3: .space 1640
var4: .space 820
var5: .space 820
var6: .space 1640
var7: .space 1640
var8: .space 4
var9: .space 820
var10: .space 820
var11: .space 820
var12: .space 820
var13: .space 820
var14: .asciiz "%d\n"
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

__read:
add $8, $29, -116
sw $8, -8($sp)
lw $9, -8($sp)
move $8, $9
sw $8, -4($sp)
li $8, 0
sw $8, -12($sp)
lw $8, -12($sp)
lw $9, -4($sp)
sw $8, 0($9)
add $8, $29, -120
sw $8, -20($sp)
lw $9, -20($sp)
move $8, $9
sw $8, -16($sp)
sw $31, -128($29)
add $29, $29, -128
jal __getchar
sub $29, $29, -128
lw $31, -128($29)
add $8, $29, -124
sw $8, -28($sp)
lw $9, -28($sp)
lw $8, 0($9)
sw $8, -24($sp)
lw $8, -24($sp)
lw $9, -16($sp)
sw $8, 0($9)
label0:
lw $9, -16($sp)
lw $8, 0($9)
sw $8, -32($sp)
li $8, 48
sw $8, -36($sp)
lw $9, -32($sp)
lw $10, -36($sp)
sub $8, $9, $10
sw $8, -36($sp)
lw $8, -36($sp)
bltz $8, label3
li $8, 57
sw $8, -40($sp)
lw $9, -16($sp)
lw $8, 0($9)
sw $8, -44($sp)
lw $9, -40($sp)
lw $10, -44($sp)
sub $8, $9, $10
sw $8, -44($sp)
lw $8, -44($sp)
bgez $8, label1
label3:
label2:
lw $9, -16($sp)
move $8, $9
sw $8, -48($sp)
sw $31, -128($29)
add $29, $29, -128
jal __getchar
sub $29, $29, -128
lw $31, -128($29)
add $8, $29, -124
sw $8, -56($sp)
lw $9, -56($sp)
lw $8, 0($9)
sw $8, -52($sp)
lw $8, -52($sp)
lw $9, -48($sp)
sw $8, 0($9)
j label0
label1:
label4:
li $8, 48
sw $8, -60($sp)
lw $9, -16($sp)
lw $8, 0($9)
sw $8, -64($sp)
lw $9, -60($sp)
lw $10, -64($sp)
sub $8, $9, $10
sw $8, -64($sp)
lw $8, -64($sp)
bgtz $8, label5
lw $9, -16($sp)
lw $8, 0($9)
sw $8, -68($sp)
li $8, 57
sw $8, -72($sp)
lw $9, -68($sp)
lw $10, -72($sp)
sub $8, $9, $10
sw $8, -72($sp)
lw $8, -72($sp)
bgtz $8, label5
lw $9, -4($sp)
move $8, $9
sw $8, -76($sp)
li $8, 10
sw $8, -80($sp)
lw $9, -4($sp)
lw $8, 0($9)
sw $8, -84($sp)
lw $9, -80($sp)
lw $10, -84($sp)
mul $8, $9, $10
sw $8, -80($sp)
lw $9, -16($sp)
lw $8, 0($9)
sw $8, -88($sp)
lw $9, -80($sp)
lw $10, -88($sp)
add $8, $9, $10
sw $8, -80($sp)
li $8, 48
sw $8, -92($sp)
lw $9, -80($sp)
lw $10, -92($sp)
sub $8, $9, $10
sw $8, -80($sp)
lw $8, -80($sp)
lw $9, -76($sp)
sw $8, 0($9)
label6:
lw $9, -16($sp)
move $8, $9
sw $8, -96($sp)
sw $31, -128($29)
add $29, $29, -128
jal __getchar
sub $29, $29, -128
lw $31, -128($29)
add $8, $29, -124
sw $8, -104($sp)
lw $9, -104($sp)
lw $8, 0($9)
sw $8, -100($sp)
lw $8, -100($sp)
lw $9, -96($sp)
sw $8, 0($9)
j label4
label5:
add $8, $29, 4
sw $8, -112($sp)
lw $9, -4($sp)
lw $8, 0($9)
sw $8, -108($sp)
lw $8, -108($sp)
lw $9, -112($sp)
sw $8, 0($9)
jr $ra
jr $ra
__edge_add:
add $8, $29, 0
sw $8, -4($sp)
add $8, $29, 4
sw $8, -8($sp)
lw $9, 156($a3)
move $8, $9
sw $8, -24($sp)
lw $9, 156($a3)
lw $8, 0($9)
sw $8, -16($sp)
lw $9, -16($sp)
add $8, $9, 1
sw $8, -16($sp)
lw $8, -16($sp)
lw $9, -24($sp)
sw $8, 0($9)
lw $9, -16($sp)
mul $8, $9, 4
sw $8, -20($sp)
lw $9, 148($a3)
lw $10, -20($sp)
add $8, $9, $10
sw $8, -12($sp)
lw $9, -8($sp)
lw $8, 0($9)
sw $8, -28($sp)
lw $8, -28($sp)
lw $9, -12($sp)
sw $8, 0($9)
lw $9, 156($a3)
lw $8, 0($9)
sw $8, -36($sp)
lw $9, -36($sp)
mul $8, $9, 4
sw $8, -40($sp)
lw $9, 152($a3)
lw $10, -40($sp)
add $8, $9, $10
sw $8, -32($sp)
lw $9, -4($sp)
lw $8, 0($9)
sw $8, -48($sp)
lw $9, -48($sp)
mul $8, $9, 4
sw $8, -52($sp)
lw $9, 144($a3)
lw $10, -52($sp)
add $8, $9, $10
sw $8, -44($sp)
lw $9, -44($sp)
lw $8, 0($9)
sw $8, -44($sp)
lw $8, -44($sp)
lw $9, -32($sp)
sw $8, 0($9)
lw $9, -4($sp)
lw $8, 0($9)
sw $8, -60($sp)
lw $9, -60($sp)
mul $8, $9, 4
sw $8, -64($sp)
lw $9, 144($a3)
lw $10, -64($sp)
add $8, $9, $10
sw $8, -56($sp)
lw $9, 156($a3)
lw $8, 0($9)
sw $8, -68($sp)
lw $8, -68($sp)
lw $9, -56($sp)
sw $8, 0($9)
jr $ra
__search:
add $8, $29, -400
sw $8, -8($sp)
lw $9, -8($sp)
move $8, $9
sw $8, -4($sp)
li $8, 1
sw $8, -12($sp)
lw $8, -12($sp)
lw $9, -4($sp)
sw $8, 0($9)
add $8, $29, -404
sw $8, -20($sp)
lw $9, -20($sp)
move $8, $9
sw $8, -16($sp)
li $8, 0
sw $8, -24($sp)
lw $8, -24($sp)
lw $9, -16($sp)
sw $8, 0($9)
add $8, $29, -408
sw $8, -32($sp)
lw $9, -32($sp)
move $8, $9
sw $8, -28($sp)
li $8, 0
sw $8, -36($sp)
lw $8, -36($sp)
lw $9, -28($sp)
sw $8, 0($9)
add $8, $29, -412
sw $8, -44($sp)
lw $9, -44($sp)
move $8, $9
sw $8, -40($sp)
add $8, $29, -416
sw $8, -52($sp)
lw $9, -52($sp)
move $8, $9
sw $8, -48($sp)
add $8, $29, -420
sw $8, -60($sp)
lw $9, -60($sp)
move $8, $9
sw $8, -56($sp)
add $8, $29, -424
sw $8, -68($sp)
lw $9, -68($sp)
move $8, $9
sw $8, -64($sp)
lw $9, -44($sp)
move $8, $9
sw $8, -72($sp)
li $8, 1
sw $8, -76($sp)
lw $8, -76($sp)
lw $9, -72($sp)
sw $8, 0($9)
label7:
lw $9, -40($sp)
lw $8, 0($9)
sw $8, -80($sp)
lw $9, 120($a3)
lw $8, 0($9)
sw $8, -84($sp)
lw $9, -80($sp)
lw $10, -84($sp)
sub $8, $9, $10
sw $8, -84($sp)
lw $8, -84($sp)
bgtz $8, label8
lw $9, -40($sp)
lw $8, 0($9)
sw $8, -92($sp)
lw $9, -92($sp)
mul $8, $9, 4
sw $8, -96($sp)
lw $9, 240($a3)
lw $10, -96($sp)
add $8, $9, $10
sw $8, -88($sp)
lw $9, -40($sp)
lw $8, 0($9)
sw $8, -104($sp)
lw $9, -104($sp)
mul $8, $9, 4
sw $8, -108($sp)
lw $9, 244($a3)
lw $10, -108($sp)
add $8, $9, $10
sw $8, -100($sp)
li $8, 0
sw $8, -112($sp)
lw $8, -112($sp)
lw $9, -100($sp)
sw $8, 0($9)
lw $9, -100($sp)
lw $8, 0($9)
sw $8, -100($sp)
lw $8, -100($sp)
lw $9, -88($sp)
sw $8, 0($9)
label9:
lw $9, -40($sp)
move $8, $9
sw $8, -120($sp)
lw $9, -40($sp)
lw $8, 0($9)
sw $8, -116($sp)
lw $9, -116($sp)
add $8, $9, 1
sw $8, -116($sp)
lw $8, -116($sp)
lw $9, -120($sp)
sw $8, 0($9)
j label7
label8:
lw $9, -40($sp)
move $8, $9
sw $8, -124($sp)
li $8, 1
sw $8, -128($sp)
lw $8, -128($sp)
lw $9, -124($sp)
sw $8, 0($9)
label10:
lw $9, -40($sp)
lw $8, 0($9)
sw $8, -132($sp)
lw $9, 120($a3)
lw $8, 0($9)
sw $8, -136($sp)
lw $9, -132($sp)
lw $10, -136($sp)
sub $8, $9, $10
sw $8, -136($sp)
lw $8, -136($sp)
bgtz $8, label11
lw $9, -40($sp)
lw $8, 0($9)
sw $8, -144($sp)
lw $9, -144($sp)
mul $8, $9, 4
sw $8, -148($sp)
lw $9, 236($a3)
lw $10, -148($sp)
add $8, $9, $10
sw $8, -140($sp)
lw $9, -140($sp)
lw $8, 0($9)
sw $8, -140($sp)
lw $9, -140($sp)
li $8, 1
beqz $9, lnot0
li $8, 0
lnot0:
sw $8, -140($sp)
lw $8, -140($sp)
beqz $8, label13
lw $9, -16($sp)
move $8, $9
sw $8, -168($sp)
lw $9, -16($sp)
lw $8, 0($9)
sw $8, -160($sp)
lw $9, -160($sp)
add $8, $9, 1
sw $8, -160($sp)
lw $8, -160($sp)
lw $9, -168($sp)
sw $8, 0($9)
lw $9, -160($sp)
mul $8, $9, 4
sw $8, -164($sp)
lw $9, 248($a3)
lw $10, -164($sp)
add $8, $9, $10
sw $8, -156($sp)
lw $9, -40($sp)
lw $8, 0($9)
sw $8, -172($sp)
lw $8, -172($sp)
lw $9, -156($sp)
sw $8, 0($9)
lw $9, -40($sp)
lw $8, 0($9)
sw $8, -176($sp)
lw $9, -176($sp)
mul $8, $9, 4
sw $8, -180($sp)
lw $9, 240($a3)
lw $10, -180($sp)
add $8, $9, $10
sw $8, -152($sp)
li $8, 1
sw $8, -184($sp)
lw $8, -184($sp)
lw $9, -152($sp)
sw $8, 0($9)
label13:
label12:
lw $9, -40($sp)
move $8, $9
sw $8, -192($sp)
lw $9, -40($sp)
lw $8, 0($9)
sw $8, -188($sp)
lw $9, -188($sp)
add $8, $9, 1
sw $8, -188($sp)
lw $8, -188($sp)
lw $9, -192($sp)
sw $8, 0($9)
j label10
label11:
label14:
lw $9, -4($sp)
lw $8, 0($9)
sw $8, -196($sp)
lw $9, -16($sp)
lw $8, 0($9)
sw $8, -200($sp)
lw $9, -196($sp)
lw $10, -200($sp)
sub $8, $9, $10
sw $8, -200($sp)
lw $8, -200($sp)
bgtz $8, label15
lw $9, -48($sp)
move $8, $9
sw $8, -204($sp)
lw $9, -4($sp)
lw $8, 0($9)
sw $8, -212($sp)
lw $9, -212($sp)
mul $8, $9, 4
sw $8, -216($sp)
lw $9, 248($a3)
lw $10, -216($sp)
add $8, $9, $10
sw $8, -208($sp)
lw $9, -208($sp)
lw $8, 0($9)
sw $8, -208($sp)
lw $8, -208($sp)
lw $9, -204($sp)
sw $8, 0($9)
lw $9, -64($sp)
move $8, $9
sw $8, -220($sp)
lw $9, -48($sp)
lw $8, 0($9)
sw $8, -228($sp)
lw $9, -228($sp)
mul $8, $9, 4
sw $8, -232($sp)
lw $9, 144($a3)
lw $10, -232($sp)
add $8, $9, $10
sw $8, -224($sp)
lw $9, -224($sp)
lw $8, 0($9)
sw $8, -224($sp)
lw $8, -224($sp)
lw $9, -220($sp)
sw $8, 0($9)
label17:
lw $9, -64($sp)
lw $8, 0($9)
sw $8, -236($sp)
lw $8, -236($sp)
beqz $8, label18
lw $9, -56($sp)
move $8, $9
sw $8, -240($sp)
lw $9, -64($sp)
lw $8, 0($9)
sw $8, -248($sp)
lw $9, -248($sp)
mul $8, $9, 4
sw $8, -252($sp)
lw $9, 148($a3)
lw $10, -252($sp)
add $8, $9, $10
sw $8, -244($sp)
lw $9, -244($sp)
lw $8, 0($9)
sw $8, -244($sp)
lw $8, -244($sp)
lw $9, -240($sp)
sw $8, 0($9)
lw $9, -56($sp)
lw $8, 0($9)
sw $8, -260($sp)
lw $9, -260($sp)
mul $8, $9, 4
sw $8, -264($sp)
lw $9, 244($a3)
lw $10, -264($sp)
add $8, $9, $10
sw $8, -256($sp)
lw $9, -256($sp)
lw $8, 0($9)
sw $8, -256($sp)
lw $8, -256($sp)
beqz $8, label20
j label19
label20:
lw $9, -56($sp)
lw $8, 0($9)
sw $8, -272($sp)
lw $9, -272($sp)
mul $8, $9, 4
sw $8, -276($sp)
lw $9, 244($a3)
lw $10, -276($sp)
add $8, $9, $10
sw $8, -268($sp)
lw $9, -48($sp)
lw $8, 0($9)
sw $8, -284($sp)
lw $9, -284($sp)
mul $8, $9, 4
sw $8, -288($sp)
lw $9, 240($a3)
lw $10, -288($sp)
add $8, $9, $10
sw $8, -280($sp)
lw $9, -280($sp)
lw $8, 0($9)
sw $8, -280($sp)
li $8, 1
sw $8, -292($sp)
lw $9, -280($sp)
lw $10, -292($sp)
add $8, $9, $10
sw $8, -280($sp)
lw $8, -280($sp)
lw $9, -268($sp)
sw $8, 0($9)
lw $9, -56($sp)
lw $8, 0($9)
sw $8, -300($sp)
lw $9, -300($sp)
mul $8, $9, 4
sw $8, -304($sp)
lw $9, 232($a3)
lw $10, -304($sp)
add $8, $9, $10
sw $8, -296($sp)
lw $9, -296($sp)
lw $8, 0($9)
sw $8, -296($sp)
lw $9, -296($sp)
li $8, 1
beqz $9, lnot1
li $8, 0
lnot1:
sw $8, -296($sp)
lw $8, -296($sp)
beqz $8, label21
lw $9, -28($sp)
move $8, $9
sw $8, -308($sp)
li $8, 1
sw $8, -312($sp)
lw $8, -312($sp)
lw $9, -308($sp)
sw $8, 0($9)
j label22
label21:
lw $9, -16($sp)
move $8, $9
sw $8, -336($sp)
lw $9, -16($sp)
lw $8, 0($9)
sw $8, -328($sp)
lw $9, -328($sp)
add $8, $9, 1
sw $8, -328($sp)
lw $8, -328($sp)
lw $9, -336($sp)
sw $8, 0($9)
lw $9, -328($sp)
mul $8, $9, 4
sw $8, -332($sp)
lw $9, 248($a3)
lw $10, -332($sp)
add $8, $9, $10
sw $8, -320($sp)
lw $9, -56($sp)
lw $8, 0($9)
sw $8, -344($sp)
lw $9, -344($sp)
mul $8, $9, 4
sw $8, -348($sp)
lw $9, 232($a3)
lw $10, -348($sp)
add $8, $9, $10
sw $8, -340($sp)
lw $9, -340($sp)
lw $8, 0($9)
sw $8, -340($sp)
lw $8, -340($sp)
lw $9, -320($sp)
sw $8, 0($9)
lw $9, -320($sp)
lw $8, 0($9)
sw $8, -320($sp)
lw $9, -320($sp)
mul $8, $9, 4
sw $8, -324($sp)
lw $9, 240($a3)
lw $10, -324($sp)
add $8, $9, $10
sw $8, -316($sp)
lw $9, -56($sp)
lw $8, 0($9)
sw $8, -356($sp)
lw $9, -356($sp)
mul $8, $9, 4
sw $8, -360($sp)
lw $9, 244($a3)
lw $10, -360($sp)
add $8, $9, $10
sw $8, -352($sp)
lw $9, -352($sp)
lw $8, 0($9)
sw $8, -352($sp)
li $8, 1
sw $8, -364($sp)
lw $9, -352($sp)
lw $10, -364($sp)
add $8, $9, $10
sw $8, -352($sp)
lw $8, -352($sp)
lw $9, -316($sp)
sw $8, 0($9)
label22:
label19:
lw $9, -64($sp)
move $8, $9
sw $8, -368($sp)
lw $9, -64($sp)
lw $8, 0($9)
sw $8, -376($sp)
lw $9, -376($sp)
mul $8, $9, 4
sw $8, -380($sp)
lw $9, 152($a3)
lw $10, -380($sp)
add $8, $9, $10
sw $8, -372($sp)
lw $9, -372($sp)
lw $8, 0($9)
sw $8, -372($sp)
lw $8, -372($sp)
lw $9, -368($sp)
sw $8, 0($9)
j label17
label18:
label16:
lw $9, -4($sp)
move $8, $9
sw $8, -388($sp)
lw $9, -4($sp)
lw $8, 0($9)
sw $8, -384($sp)
lw $9, -384($sp)
add $8, $9, 1
sw $8, -384($sp)
lw $8, -384($sp)
lw $9, -388($sp)
sw $8, 0($9)
j label14
label15:
add $8, $29, 4
sw $8, -396($sp)
lw $9, -28($sp)
lw $8, 0($9)
sw $8, -392($sp)
lw $8, -392($sp)
lw $9, -396($sp)
sw $8, 0($9)
jr $ra
jr $ra
__Extend_Path:
add $8, $29, 0
sw $8, -4($sp)
add $8, $29, -276
sw $8, -12($sp)
lw $9, -12($sp)
move $8, $9
sw $8, -8($sp)
add $8, $29, -280
sw $8, -20($sp)
lw $9, -20($sp)
move $8, $9
sw $8, -16($sp)
add $8, $29, -284
sw $8, -28($sp)
lw $9, -28($sp)
move $8, $9
sw $8, -24($sp)
lw $9, -20($sp)
move $8, $9
sw $8, -32($sp)
lw $9, -4($sp)
lw $8, 0($9)
sw $8, -40($sp)
lw $9, -40($sp)
mul $8, $9, 4
sw $8, -44($sp)
lw $9, 144($a3)
lw $10, -44($sp)
add $8, $9, $10
sw $8, -36($sp)
lw $9, -36($sp)
lw $8, 0($9)
sw $8, -36($sp)
lw $8, -36($sp)
lw $9, -32($sp)
sw $8, 0($9)
label23:
lw $9, -16($sp)
lw $8, 0($9)
sw $8, -48($sp)
lw $8, -48($sp)
beqz $8, label24
lw $9, -8($sp)
move $8, $9
sw $8, -52($sp)
lw $9, -16($sp)
lw $8, 0($9)
sw $8, -60($sp)
lw $9, -60($sp)
mul $8, $9, 4
sw $8, -64($sp)
lw $9, 148($a3)
lw $10, -64($sp)
add $8, $9, $10
sw $8, -56($sp)
lw $9, -56($sp)
lw $8, 0($9)
sw $8, -56($sp)
lw $8, -56($sp)
lw $9, -52($sp)
sw $8, 0($9)
lw $9, -8($sp)
lw $8, 0($9)
sw $8, -72($sp)
lw $9, -72($sp)
mul $8, $9, 4
sw $8, -76($sp)
lw $9, 244($a3)
lw $10, -76($sp)
add $8, $9, $10
sw $8, -68($sp)
lw $9, -68($sp)
lw $8, 0($9)
sw $8, -68($sp)
lw $9, -4($sp)
lw $8, 0($9)
sw $8, -84($sp)
lw $9, -84($sp)
mul $8, $9, 4
sw $8, -88($sp)
lw $9, 240($a3)
lw $10, -88($sp)
add $8, $9, $10
sw $8, -80($sp)
lw $9, -80($sp)
lw $8, 0($9)
sw $8, -80($sp)
li $8, 1
sw $8, -92($sp)
lw $9, -80($sp)
lw $10, -92($sp)
add $8, $9, $10
sw $8, -80($sp)
lw $9, -68($sp)
lw $10, -80($sp)
sub $8, $9, $10
sw $8, -80($sp)
lw $8, -80($sp)
beqz $8, label26
j label25
label26:
lw $9, -8($sp)
lw $8, 0($9)
sw $8, -100($sp)
lw $9, -100($sp)
mul $8, $9, 4
sw $8, -104($sp)
lw $9, 244($a3)
lw $10, -104($sp)
add $8, $9, $10
sw $8, -96($sp)
li $8, 0
sw $8, -108($sp)
lw $8, -108($sp)
lw $9, -96($sp)
sw $8, 0($9)
lw $9, -24($sp)
move $8, $9
sw $8, -112($sp)
lw $9, -8($sp)
lw $8, 0($9)
sw $8, -120($sp)
lw $9, -120($sp)
mul $8, $9, 4
sw $8, -124($sp)
lw $9, 232($a3)
lw $10, -124($sp)
add $8, $9, $10
sw $8, -116($sp)
lw $9, -116($sp)
lw $8, 0($9)
sw $8, -116($sp)
lw $8, -116($sp)
lw $9, -112($sp)
sw $8, 0($9)
lw $9, -8($sp)
lw $8, 0($9)
sw $8, -132($sp)
lw $9, -132($sp)
mul $8, $9, 4
sw $8, -136($sp)
lw $9, 232($a3)
lw $10, -136($sp)
add $8, $9, $10
sw $8, -128($sp)
lw $9, -4($sp)
lw $8, 0($9)
sw $8, -140($sp)
lw $8, -140($sp)
lw $9, -128($sp)
sw $8, 0($9)
lw $9, -4($sp)
lw $8, 0($9)
sw $8, -148($sp)
lw $9, -148($sp)
mul $8, $9, 4
sw $8, -152($sp)
lw $9, 236($a3)
lw $10, -152($sp)
add $8, $9, $10
sw $8, -144($sp)
lw $9, -8($sp)
lw $8, 0($9)
sw $8, -156($sp)
lw $8, -156($sp)
lw $9, -144($sp)
sw $8, 0($9)
lw $9, -24($sp)
lw $8, 0($9)
sw $8, -164($sp)
lw $9, -164($sp)
mul $8, $9, 4
sw $8, -168($sp)
lw $9, 236($a3)
lw $10, -168($sp)
add $8, $9, $10
sw $8, -160($sp)
li $8, 0
sw $8, -172($sp)
lw $8, -172($sp)
lw $9, -160($sp)
sw $8, 0($9)
lw $9, -24($sp)
lw $8, 0($9)
sw $8, -176($sp)
lw $9, -176($sp)
li $8, 1
beqz $9, lnot2
li $8, 0
lnot2:
sw $8, -176($sp)
lw $8, -176($sp)
bnez $8, label28
sw $31, -292($29)
add $8, $29, -296
sw $8, -188($sp)
lw $9, -24($sp)
lw $8, 0($9)
sw $8, -184($sp)
lw $8, -184($sp)
lw $9, -188($sp)
sw $8, 0($9)
add $29, $29, -296
jal __Extend_Path
sub $29, $29, -296
lw $31, -292($29)
add $8, $29, -288
sw $8, -192($sp)
lw $9, -192($sp)
lw $8, 0($9)
sw $8, -180($sp)
lw $8, -180($sp)
beqz $8, label27
label28:
li $8, 1
sw $8, -196($sp)
add $8, $29, 8
sw $8, -200($sp)
lw $8, -196($sp)
lw $9, -200($sp)
sw $8, 0($9)
jr $ra
label27:
lw $9, -4($sp)
lw $8, 0($9)
sw $8, -208($sp)
lw $9, -208($sp)
mul $8, $9, 4
sw $8, -212($sp)
lw $9, 236($a3)
lw $10, -212($sp)
add $8, $9, $10
sw $8, -204($sp)
li $8, 0
sw $8, -216($sp)
lw $8, -216($sp)
lw $9, -204($sp)
sw $8, 0($9)
lw $9, -8($sp)
lw $8, 0($9)
sw $8, -224($sp)
lw $9, -224($sp)
mul $8, $9, 4
sw $8, -228($sp)
lw $9, 232($a3)
lw $10, -228($sp)
add $8, $9, $10
sw $8, -220($sp)
lw $9, -24($sp)
lw $8, 0($9)
sw $8, -232($sp)
lw $8, -232($sp)
lw $9, -220($sp)
sw $8, 0($9)
lw $9, -24($sp)
lw $8, 0($9)
sw $8, -240($sp)
lw $9, -240($sp)
mul $8, $9, 4
sw $8, -244($sp)
lw $9, 236($a3)
lw $10, -244($sp)
add $8, $9, $10
sw $8, -236($sp)
lw $9, -8($sp)
lw $8, 0($9)
sw $8, -248($sp)
lw $8, -248($sp)
lw $9, -236($sp)
sw $8, 0($9)
label25:
lw $9, -16($sp)
move $8, $9
sw $8, -252($sp)
lw $9, -16($sp)
lw $8, 0($9)
sw $8, -260($sp)
lw $9, -260($sp)
mul $8, $9, 4
sw $8, -264($sp)
lw $9, 152($a3)
lw $10, -264($sp)
add $8, $9, $10
sw $8, -256($sp)
lw $9, -256($sp)
lw $8, 0($9)
sw $8, -256($sp)
lw $8, -256($sp)
lw $9, -252($sp)
sw $8, 0($9)
j label23
label24:
li $8, 0
sw $8, -268($sp)
add $8, $29, 8
sw $8, -272($sp)
lw $8, -268($sp)
lw $9, -272($sp)
sw $8, 0($9)
jr $ra
jr $ra
__Hopcroft_Karp:
add $8, $29, -80
sw $8, -8($sp)
lw $9, -8($sp)
move $8, $9
sw $8, -4($sp)
label29:
sw $31, -88($29)
add $29, $29, -88
jal __search
sub $29, $29, -88
lw $31, -88($29)
add $8, $29, -84
sw $8, -16($sp)
lw $9, -16($sp)
lw $8, 0($9)
sw $8, -12($sp)
lw $8, -12($sp)
beqz $8, label30
lw $9, -4($sp)
move $8, $9
sw $8, -20($sp)
li $8, 1
sw $8, -24($sp)
lw $8, -24($sp)
lw $9, -20($sp)
sw $8, 0($9)
label31:
lw $9, -4($sp)
lw $8, 0($9)
sw $8, -28($sp)
lw $9, 120($a3)
lw $8, 0($9)
sw $8, -32($sp)
lw $9, -28($sp)
lw $10, -32($sp)
sub $8, $9, $10
sw $8, -32($sp)
lw $8, -32($sp)
bgtz $8, label32
lw $9, -4($sp)
lw $8, 0($9)
sw $8, -40($sp)
lw $9, -40($sp)
mul $8, $9, 4
sw $8, -44($sp)
lw $9, 236($a3)
lw $10, -44($sp)
add $8, $9, $10
sw $8, -36($sp)
lw $9, -36($sp)
lw $8, 0($9)
sw $8, -36($sp)
lw $9, -36($sp)
li $8, 1
beqz $9, lnot3
li $8, 0
lnot3:
sw $8, -36($sp)
lw $8, -36($sp)
beqz $8, label34
sw $31, -88($29)
add $8, $29, -92
sw $8, -56($sp)
lw $9, -4($sp)
lw $8, 0($9)
sw $8, -52($sp)
lw $8, -52($sp)
lw $9, -56($sp)
sw $8, 0($9)
add $29, $29, -92
jal __Extend_Path
sub $29, $29, -92
lw $31, -88($29)
add $8, $29, -84
sw $8, -60($sp)
lw $9, -60($sp)
lw $8, 0($9)
sw $8, -48($sp)
lw $8, -48($sp)
beqz $8, label34
lw $9, 128($a3)
move $8, $9
sw $8, -68($sp)
lw $9, 128($a3)
lw $8, 0($9)
sw $8, -64($sp)
lw $9, -64($sp)
add $8, $9, 1
sw $8, -64($sp)
lw $8, -64($sp)
lw $9, -68($sp)
sw $8, 0($9)
label34:
label33:
lw $9, -4($sp)
move $8, $9
sw $8, -76($sp)
lw $9, -4($sp)
lw $8, 0($9)
sw $8, -72($sp)
lw $9, -72($sp)
add $8, $9, 1
sw $8, -72($sp)
lw $8, -72($sp)
lw $9, -76($sp)
sw $8, 0($9)
j label31
label32:
j label29
label30:
jr $ra
main:
la $a3, temp
la $t0, var0
sw $t0, 120($a3)
la $t0, var1
sw $t0, 124($a3)
la $t0, var2
sw $t0, 128($a3)
la $t0, var3
sw $t0, 136($a3)
la $t0, var4
sw $t0, 140($a3)
la $t0, var5
sw $t0, 144($a3)
la $t0, var6
sw $t0, 148($a3)
la $t0, var7
sw $t0, 152($a3)
la $t0, var8
sw $t0, 156($a3)
la $t0, var9
sw $t0, 232($a3)
la $t0, var10
sw $t0, 236($a3)
la $t0, var11
sw $t0, 240($a3)
la $t0, var12
sw $t0, 244($a3)
la $t0, var13
sw $t0, 248($a3)
la $t0, var14
sw $t0, 1148($a3)
li $8, 0
sw $8, 132($a3)
lw $8, 132($a3)
lw $9, 128($a3)
sw $8, 0($9)
li $8, 0
sw $8, 160($a3)
lw $8, 160($a3)
lw $9, 156($a3)
sw $8, 0($9)
add $8, $29, -160
sw $8, -8($sp)
lw $9, -8($sp)
move $8, $9
sw $8, -4($sp)
lw $9, 120($a3)
move $8, $9
sw $8, -12($sp)
add $29, $29, -168
jal __read
sub $29, $29, -168
add $8, $29, -164
sw $8, -20($sp)
lw $9, -20($sp)
lw $8, 0($9)
sw $8, -16($sp)
lw $8, -16($sp)
lw $9, -12($sp)
sw $8, 0($9)
lw $9, 124($a3)
move $8, $9
sw $8, -24($sp)
add $29, $29, -168
jal __read
sub $29, $29, -168
add $8, $29, -164
sw $8, -32($sp)
lw $9, -32($sp)
lw $8, 0($9)
sw $8, -28($sp)
lw $8, -28($sp)
lw $9, -24($sp)
sw $8, 0($9)
lw $9, -8($sp)
move $8, $9
sw $8, -36($sp)
li $8, 1
sw $8, -40($sp)
lw $8, -40($sp)
lw $9, -36($sp)
sw $8, 0($9)
label35:
lw $9, -4($sp)
lw $8, 0($9)
sw $8, -44($sp)
lw $9, 124($a3)
lw $8, 0($9)
sw $8, -48($sp)
lw $9, -44($sp)
lw $10, -48($sp)
sub $8, $9, $10
sw $8, -48($sp)
lw $8, -48($sp)
bgtz $8, label36
lw $9, -4($sp)
lw $8, 0($9)
sw $8, -56($sp)
lw $9, -56($sp)
mul $8, $9, 8
sw $8, -60($sp)
lw $9, 136($a3)
lw $10, -60($sp)
add $8, $9, $10
sw $8, -52($sp)
lw $9, -52($sp)
add $8, $9, 0
sw $8, -52($sp)
add $29, $29, -168
jal __read
sub $29, $29, -168
add $8, $29, -164
sw $8, -68($sp)
lw $9, -68($sp)
lw $8, 0($9)
sw $8, -64($sp)
lw $8, -64($sp)
lw $9, -52($sp)
sw $8, 0($9)
lw $9, -4($sp)
lw $8, 0($9)
sw $8, -76($sp)
lw $9, -76($sp)
mul $8, $9, 8
sw $8, -80($sp)
lw $9, 136($a3)
lw $10, -80($sp)
add $8, $9, $10
sw $8, -72($sp)
lw $9, -72($sp)
add $8, $9, 4
sw $8, -72($sp)
add $29, $29, -168
jal __read
sub $29, $29, -168
add $8, $29, -164
sw $8, -88($sp)
lw $9, -88($sp)
lw $8, 0($9)
sw $8, -84($sp)
lw $8, -84($sp)
lw $9, -72($sp)
sw $8, 0($9)
lw $9, -4($sp)
lw $8, 0($9)
sw $8, -100($sp)
lw $9, -100($sp)
mul $8, $9, 8
sw $8, -104($sp)
lw $9, 136($a3)
lw $10, -104($sp)
add $8, $9, $10
sw $8, -96($sp)
lw $9, -96($sp)
add $8, $9, 4
sw $8, -96($sp)
add $8, $29, -168
sw $8, -108($sp)
lw $9, -96($sp)
lw $8, 0($9)
sw $8, -96($sp)
lw $8, -96($sp)
lw $9, -108($sp)
sw $8, 0($9)
lw $9, -4($sp)
lw $8, 0($9)
sw $8, -116($sp)
lw $9, -116($sp)
mul $8, $9, 8
sw $8, -120($sp)
lw $9, 136($a3)
lw $10, -120($sp)
add $8, $9, $10
sw $8, -112($sp)
lw $9, -112($sp)
add $8, $9, 0
sw $8, -112($sp)
add $8, $29, -172
sw $8, -124($sp)
lw $9, -112($sp)
lw $8, 0($9)
sw $8, -112($sp)
lw $8, -112($sp)
lw $9, -124($sp)
sw $8, 0($9)
add $29, $29, -172
jal __edge_add
sub $29, $29, -172
label37:
lw $9, -4($sp)
move $8, $9
sw $8, -132($sp)
lw $9, -4($sp)
lw $8, 0($9)
sw $8, -128($sp)
lw $9, -128($sp)
add $8, $9, 1
sw $8, -128($sp)
lw $8, -128($sp)
lw $9, -132($sp)
sw $8, 0($9)
j label35
label36:
add $29, $29, -164
jal __Hopcroft_Karp
sub $29, $29, -164
add $8, $29, -168
sw $8, -148($sp)
lw $9, 128($a3)
lw $8, 0($9)
sw $8, -144($sp)
lw $8, -144($sp)
lw $9, -148($sp)
sw $8, 0($9)
lw $9, 1148($a3)
move $8, $9
sw $8, -152($sp)
add $8, $29, -172
sw $8, -156($sp)
lw $8, -152($sp)
lw $9, -156($sp)
sw $8, 0($9)
add $29, $29, -172
jal __printf
sub $29, $29, -172
j __main_end
__main_end:
li $v0, 10
syscall
#global $30 4
#global $31 4
#global $32 4
#global $34 1640
#global $35 820
#global $36 820
#global $37 1640
#global $38 1640
#global $39 4
#global $58 820
#global $59 820
#global $60 820
#global $61 820
#global $62 820
#string $287 #%d\n
#li $33 0
#sw $33 $32 0
#li $40 0
#sw $40 $39 0
#----------------------------
#func #read
#addi $3 $0 -116
#move $2 $3
#li $4 0
#sw $4 $2 0
#addi $6 $0 -120
#move $5 $6
#sw $1 $0 -128
#addi $0 $0 -128
#call #getchar
#subi $0 $0 -128
#lw $1 $0 -128
#addi $8 $0 -124
####move $7 $8
#lw $7 $8 0
#sw $7 $5 0
#label l:0
####move $9 $5
#lw $9 $5 0
#li $10 48
#sub $10 $9 $10
#bltz $10 l:3
#li $11 57
####move $12 $5
#lw $12 $5 0
#sub $12 $11 $12
#bgez $12 l:1
#label l:3
#label l:2
#move $13 $5
#sw $1 $0 -128
#addi $0 $0 -128
#call #getchar
#subi $0 $0 -128
#lw $1 $0 -128
#addi $15 $0 -124
####move $14 $15
#lw $14 $15 0
#sw $14 $13 0
#goto l:0
#label l:1
#label l:4
#li $16 48
####move $17 $5
#lw $17 $5 0
#sub $17 $16 $17
#bgtz $17 l:5
####move $18 $5
#lw $18 $5 0
#li $19 57
#sub $19 $18 $19
#bgtz $19 l:5
#move $20 $2
#li $21 10
####move $22 $2
#lw $22 $2 0
#mul $21 $21 $22
####move $23 $5
#lw $23 $5 0
#add $21 $21 $23
#li $24 48
#sub $21 $21 $24
#sw $21 $20 0
#label l:6
#move $25 $5
#sw $1 $0 -128
#addi $0 $0 -128
#call #getchar
#subi $0 $0 -128
#lw $1 $0 -128
#addi $27 $0 -124
####move $26 $27
#lw $26 $27 0
#sw $26 $25 0
#goto l:4
#label l:5
####move $28 $2
#addi $29 $0 4
#lw $28 $2 0
#sw $28 $29 0
#return
#return
#----------------------------
#func #edge_add
#addi $41 $0 0
#addi $42 $0 4
####move $43 $37
####move $44 $39
#move $46 $39
#lw $44 $39 0
#addi $44 $44 1
#sw $44 $46 0
#muli $45 $44 4
#add $43 $37 $45
####move $47 $42
#lw $47 $42 0
#sw $47 $43 0
####move $48 $38
####move $49 $39
#lw $49 $39 0
#muli $50 $49 4
#add $48 $38 $50
####move $51 $36
####move $52 $41
#lw $52 $41 0
#muli $53 $52 4
#add $51 $36 $53
#lw $51 $51 0
#sw $51 $48 0
####move $54 $36
####move $55 $41
#lw $55 $41 0
#muli $56 $55 4
#add $54 $36 $56
####move $57 $39
#lw $57 $39 0
#sw $57 $54 0
#return
#----------------------------
#func #search
#addi $64 $0 -400
#move $63 $64
#li $65 1
#sw $65 $63 0
#addi $67 $0 -404
#move $66 $67
#li $68 0
#sw $68 $66 0
#addi $70 $0 -408
#move $69 $70
#li $71 0
#sw $71 $69 0
#addi $73 $0 -412
#move $72 $73
#addi $75 $0 -416
#move $74 $75
#addi $77 $0 -420
#move $76 $77
#addi $79 $0 -424
#move $78 $79
#move $80 $73
#li $81 1
#sw $81 $80 0
#label l:7
####move $82 $72
#lw $82 $72 0
####move $83 $30
#lw $83 $30 0
#sub $83 $82 $83
#bgtz $83 l:8
####move $84 $60
####move $85 $72
#lw $85 $72 0
#muli $86 $85 4
#add $84 $60 $86
####move $87 $61
####move $88 $72
#lw $88 $72 0
#muli $89 $88 4
#add $87 $61 $89
#li $90 0
#sw $90 $87 0
#lw $87 $87 0
#sw $87 $84 0
#label l:9
####move $91 $72
#move $92 $72
#lw $91 $72 0
#addi $91 $91 1
#sw $91 $92 0
#goto l:7
#label l:8
#move $93 $72
#li $94 1
#sw $94 $93 0
#label l:10
####move $95 $72
#lw $95 $72 0
####move $96 $30
#lw $96 $30 0
#sub $96 $95 $96
#bgtz $96 l:11
####move $97 $59
####move $98 $72
#lw $98 $72 0
#muli $99 $98 4
#add $97 $59 $99
#lw $97 $97 0
#lnot $97 $97
#beqz $97 l:13
####move $101 $62
####move $102 $66
#move $104 $66
#lw $102 $66 0
#addi $102 $102 1
#sw $102 $104 0
#muli $103 $102 4
#add $101 $62 $103
####move $105 $72
#lw $105 $72 0
#sw $105 $101 0
####move $100 $60
####move $106 $72
#lw $106 $72 0
#muli $107 $106 4
#add $100 $60 $107
#li $108 1
#sw $108 $100 0
#label l:13
#label l:12
####move $109 $72
#move $110 $72
#lw $109 $72 0
#addi $109 $109 1
#sw $109 $110 0
#goto l:10
#label l:11
#label l:14
####move $111 $63
#lw $111 $63 0
####move $112 $66
#lw $112 $66 0
#sub $112 $111 $112
#bgtz $112 l:15
#move $113 $74
####move $114 $62
####move $115 $63
#lw $115 $63 0
#muli $116 $115 4
#add $114 $62 $116
#lw $114 $114 0
#sw $114 $113 0
#move $117 $78
####move $118 $36
####move $119 $74
#lw $119 $74 0
#muli $120 $119 4
#add $118 $36 $120
#lw $118 $118 0
#sw $118 $117 0
#label l:17
####move $121 $78
#lw $121 $78 0
#beqz $121 l:18
#move $122 $76
####move $123 $37
####move $124 $78
#lw $124 $78 0
#muli $125 $124 4
#add $123 $37 $125
#lw $123 $123 0
#sw $123 $122 0
####move $126 $61
####move $127 $76
#lw $127 $76 0
#muli $128 $127 4
#add $126 $61 $128
#lw $126 $126 0
#beqz $126 l:20
#goto l:19
#label l:20
####move $129 $61
####move $130 $76
#lw $130 $76 0
#muli $131 $130 4
#add $129 $61 $131
####move $132 $60
####move $133 $74
#lw $133 $74 0
#muli $134 $133 4
#add $132 $60 $134
#lw $132 $132 0
#li $135 1
#add $132 $132 $135
#sw $132 $129 0
####move $136 $58
####move $137 $76
#lw $137 $76 0
#muli $138 $137 4
#add $136 $58 $138
#lw $136 $136 0
#lnot $136 $136
#beqz $136 l:21
#move $139 $69
#li $140 1
#sw $140 $139 0
#goto l:22
#label l:21
####move $141 $60
####move $142 $62
####move $144 $66
#move $146 $66
#lw $144 $66 0
#addi $144 $144 1
#sw $144 $146 0
#muli $145 $144 4
#add $142 $62 $145
####move $147 $58
####move $148 $76
#lw $148 $76 0
#muli $149 $148 4
#add $147 $58 $149
#lw $147 $147 0
#sw $147 $142 0
#lw $142 $142 0
#muli $143 $142 4
#add $141 $60 $143
####move $150 $61
####move $151 $76
#lw $151 $76 0
#muli $152 $151 4
#add $150 $61 $152
#lw $150 $150 0
#li $153 1
#add $150 $150 $153
#sw $150 $141 0
#label l:22
#label l:19
#move $154 $78
####move $155 $38
####move $156 $78
#lw $156 $78 0
#muli $157 $156 4
#add $155 $38 $157
#lw $155 $155 0
#sw $155 $154 0
#goto l:17
#label l:18
#label l:16
####move $158 $63
#move $159 $63
#lw $158 $63 0
#addi $158 $158 1
#sw $158 $159 0
#goto l:14
#label l:15
####move $160 $69
#addi $161 $0 4
#lw $160 $69 0
#sw $160 $161 0
#return
#return
#----------------------------
#func #Extend_Path
#addi $162 $0 0
#addi $164 $0 -276
#move $163 $164
#addi $166 $0 -280
#move $165 $166
#addi $168 $0 -284
#move $167 $168
#move $169 $166
####move $170 $36
####move $171 $162
#lw $171 $162 0
#muli $172 $171 4
#add $170 $36 $172
#lw $170 $170 0
#sw $170 $169 0
#label l:23
####move $173 $165
#lw $173 $165 0
#beqz $173 l:24
#move $174 $163
####move $175 $37
####move $176 $165
#lw $176 $165 0
#muli $177 $176 4
#add $175 $37 $177
#lw $175 $175 0
#sw $175 $174 0
####move $178 $61
####move $179 $163
#lw $179 $163 0
#muli $180 $179 4
#add $178 $61 $180
#lw $178 $178 0
####move $181 $60
####move $182 $162
#lw $182 $162 0
#muli $183 $182 4
#add $181 $60 $183
#lw $181 $181 0
#li $184 1
#add $181 $181 $184
#sub $181 $178 $181
#beqz $181 l:26
#goto l:25
#label l:26
####move $185 $61
####move $186 $163
#lw $186 $163 0
#muli $187 $186 4
#add $185 $61 $187
#li $188 0
#sw $188 $185 0
#move $189 $167
####move $190 $58
####move $191 $163
#lw $191 $163 0
#muli $192 $191 4
#add $190 $58 $192
#lw $190 $190 0
#sw $190 $189 0
####move $193 $58
####move $194 $163
#lw $194 $163 0
#muli $195 $194 4
#add $193 $58 $195
####move $196 $162
#lw $196 $162 0
#sw $196 $193 0
####move $197 $59
####move $198 $162
#lw $198 $162 0
#muli $199 $198 4
#add $197 $59 $199
####move $200 $163
#lw $200 $163 0
#sw $200 $197 0
####move $201 $59
####move $202 $167
#lw $202 $167 0
#muli $203 $202 4
#add $201 $59 $203
#li $204 0
#sw $204 $201 0
####move $205 $167
#lw $205 $167 0
#lnot $205 $205
#bnez $205 l:28
#sw $1 $0 -292
####move $207 $167
#addi $208 $0 -296
#lw $207 $167 0
#sw $207 $208 0
#addi $0 $0 -296
#call #Extend_Path
#subi $0 $0 -296
#lw $1 $0 -292
#addi $209 $0 -288
####move $206 $209
#lw $206 $209 0
#beqz $206 l:27
#label l:28
#li $210 1
#addi $211 $0 8
#sw $210 $211 0
#return
#label l:27
####move $212 $59
####move $213 $162
#lw $213 $162 0
#muli $214 $213 4
#add $212 $59 $214
#li $215 0
#sw $215 $212 0
####move $216 $58
####move $217 $163
#lw $217 $163 0
#muli $218 $217 4
#add $216 $58 $218
####move $219 $167
#lw $219 $167 0
#sw $219 $216 0
####move $220 $59
####move $221 $167
#lw $221 $167 0
#muli $222 $221 4
#add $220 $59 $222
####move $223 $163
#lw $223 $163 0
#sw $223 $220 0
#label l:25
#move $224 $165
####move $225 $38
####move $226 $165
#lw $226 $165 0
#muli $227 $226 4
#add $225 $38 $227
#lw $225 $225 0
#sw $225 $224 0
#goto l:23
#label l:24
#li $228 0
#addi $229 $0 8
#sw $228 $229 0
#return
#return
#----------------------------
#func #Hopcroft_Karp
#addi $231 $0 -80
#move $230 $231
#label l:29
#sw $1 $0 -88
#addi $0 $0 -88
#call #search
#subi $0 $0 -88
#lw $1 $0 -88
#addi $233 $0 -84
####move $232 $233
#lw $232 $233 0
#beqz $232 l:30
#move $234 $230
#li $235 1
#sw $235 $234 0
#label l:31
####move $236 $230
#lw $236 $230 0
####move $237 $30
#lw $237 $30 0
#sub $237 $236 $237
#bgtz $237 l:32
####move $238 $59
####move $239 $230
#lw $239 $230 0
#muli $240 $239 4
#add $238 $59 $240
#lw $238 $238 0
#lnot $238 $238
#beqz $238 l:34
#sw $1 $0 -88
####move $242 $230
#addi $243 $0 -92
#lw $242 $230 0
#sw $242 $243 0
#addi $0 $0 -92
#call #Extend_Path
#subi $0 $0 -92
#lw $1 $0 -88
#addi $244 $0 -84
####move $241 $244
#lw $241 $244 0
#beqz $241 l:34
####move $245 $32
#move $246 $32
#lw $245 $32 0
#addi $245 $245 1
#sw $245 $246 0
#label l:34
#label l:33
####move $247 $230
#move $248 $230
#lw $247 $230 0
#addi $247 $247 1
#sw $247 $248 0
#goto l:31
#label l:32
#goto l:29
#label l:30
#return
#----------------------------
#func #main
#addi $250 $0 -160
#move $249 $250
#move $251 $30
#addi $0 $0 -168
#call #read
#subi $0 $0 -168
#addi $253 $0 -164
####move $252 $253
#lw $252 $253 0
#sw $252 $251 0
#move $254 $31
#addi $0 $0 -168
#call #read
#subi $0 $0 -168
#addi $256 $0 -164
####move $255 $256
#lw $255 $256 0
#sw $255 $254 0
#move $257 $250
#li $258 1
#sw $258 $257 0
#label l:35
####move $259 $249
#lw $259 $249 0
####move $260 $31
#lw $260 $31 0
#sub $260 $259 $260
#bgtz $260 l:36
####move $261 $34
####move $262 $249
#lw $262 $249 0
#muli $263 $262 8
#add $261 $34 $263
#addi $261 $261 0
#addi $0 $0 -168
#call #read
#subi $0 $0 -168
#addi $265 $0 -164
####move $264 $265
#lw $264 $265 0
#sw $264 $261 0
####move $266 $34
####move $267 $249
#lw $267 $249 0
#muli $268 $267 8
#add $266 $34 $268
#addi $266 $266 4
#addi $0 $0 -168
#call #read
#subi $0 $0 -168
#addi $270 $0 -164
####move $269 $270
#lw $269 $270 0
#sw $269 $266 0
####move $272 $34
####move $273 $249
#lw $273 $249 0
#muli $274 $273 8
#add $272 $34 $274
#addi $272 $272 4
#addi $275 $0 -168
#lw $272 $272 0
#sw $272 $275 0
####move $276 $34
####move $277 $249
#lw $277 $249 0
#muli $278 $277 8
#add $276 $34 $278
#addi $276 $276 0
#addi $279 $0 -172
#lw $276 $276 0
#sw $276 $279 0
#addi $0 $0 -172
#call #edge_add
#subi $0 $0 -172
#label l:37
####move $280 $249
#move $281 $249
#lw $280 $249 0
#addi $280 $280 1
#sw $280 $281 0
#goto l:35
#label l:36
#addi $0 $0 -164
#call #Hopcroft_Karp
#subi $0 $0 -164
####move $284 $32
#addi $285 $0 -168
#lw $284 $32 0
#sw $284 $285 0
#move $286 $287
#addi $288 $0 -172
#sw $286 $288 0
#addi $0 $0 -172
#call #printf
#subi $0 $0 -172
#return
