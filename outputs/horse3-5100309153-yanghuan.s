.data
temp: .space 900
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
var13: .space 32
var14: .space 36
var15: .space 44944
var16: .space 4
var17: .space 4
var18: .asciiz "%d\n"
.align 2
var19: .asciiz "no solution!\n"
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
lw $9, -4($sp)
lw $8, 0($9)
sw $8, -8($sp)
lw $9, 8($a3)
lw $8, 0($9)
sw $8, -12($sp)
lw $9, -8($sp)
lw $10, -12($sp)
sub $8, $9, $10
sw $8, -12($sp)
li $8, 1
sw $8, -8($sp)
lw $8, -12($sp)
bltz $8, label0
li $8, 0
sw $8, -8($sp)
label0:
lw $8, -8($sp)
beqz $8, label1
lw $9, -4($sp)
lw $8, 0($9)
sw $8, -8($sp)
li $8, 0
sw $8, -16($sp)
lw $9, -8($sp)
lw $10, -16($sp)
sub $8, $9, $10
sw $8, -16($sp)
li $8, 1
sw $8, -8($sp)
lw $8, -16($sp)
bgez $8, label2
li $8, 0
sw $8, -8($sp)
label2:
label1:
lw $9, -8($sp)
andi $8, $9, 1
sw $8, -8($sp)
add $8, $29, 8
sw $8, -20($sp)
lw $8, -8($sp)
lw $9, -20($sp)
sw $8, 0($9)
jr $ra
jr $ra
__addList:
add $8, $29, 0
sw $8, -4($sp)
add $8, $29, 4
sw $8, -8($sp)
sw $31, -176($29)
add $8, $29, -180
sw $8, -20($sp)
lw $9, -4($sp)
lw $8, 0($9)
sw $8, -16($sp)
lw $8, -16($sp)
lw $9, -20($sp)
sw $8, 0($9)
add $29, $29, -180
jal __check
sub $29, $29, -180
lw $31, -176($29)
add $8, $29, -172
sw $8, -24($sp)
lw $9, -24($sp)
lw $8, 0($9)
sw $8, -12($sp)
li $8, 1
sw $8, -28($sp)
lw $9, -12($sp)
lw $10, -28($sp)
sub $8, $9, $10
sw $8, -28($sp)
lw $8, -28($sp)
bnez $8, label3
sw $31, -176($29)
add $8, $29, -180
sw $8, -40($sp)
lw $9, -8($sp)
lw $8, 0($9)
sw $8, -36($sp)
lw $8, -36($sp)
lw $9, -40($sp)
sw $8, 0($9)
add $29, $29, -180
jal __check
sub $29, $29, -180
lw $31, -176($29)
add $8, $29, -172
sw $8, -44($sp)
lw $9, -44($sp)
lw $8, 0($9)
sw $8, -32($sp)
li $8, 1
sw $8, -48($sp)
lw $9, -32($sp)
lw $10, -48($sp)
sub $8, $9, $10
sw $8, -48($sp)
lw $8, -48($sp)
bnez $8, label3
lw $9, -4($sp)
lw $8, 0($9)
sw $8, -56($sp)
lw $9, -56($sp)
mul $8, $9, 424
sw $8, -60($sp)
lw $9, 68($a3)
lw $10, -60($sp)
add $8, $9, $10
sw $8, -52($sp)
lw $9, -8($sp)
lw $8, 0($9)
sw $8, -64($sp)
lw $9, -64($sp)
mul $8, $9, 4
sw $8, -68($sp)
lw $9, -52($sp)
lw $10, -68($sp)
add $8, $9, $10
sw $8, -52($sp)
lw $9, -52($sp)
lw $8, 0($9)
sw $8, -52($sp)
li $8, -1
sw $8, -72($sp)
lw $9, -52($sp)
lw $10, -72($sp)
sub $8, $9, $10
sw $8, -72($sp)
lw $8, -72($sp)
bnez $8, label3
lw $9, 48($a3)
move $8, $9
sw $8, -80($sp)
lw $9, 48($a3)
lw $8, 0($9)
sw $8, -76($sp)
lw $9, -76($sp)
add $8, $9, 1
sw $8, -84($sp)
lw $8, -84($sp)
lw $9, -80($sp)
sw $8, 0($9)
lw $9, 48($a3)
lw $8, 0($9)
sw $8, -92($sp)
lw $9, -92($sp)
mul $8, $9, 4
sw $8, -96($sp)
lw $9, 40($a3)
lw $10, -96($sp)
add $8, $9, $10
sw $8, -88($sp)
lw $9, -4($sp)
lw $8, 0($9)
sw $8, -100($sp)
lw $8, -100($sp)
lw $9, -88($sp)
sw $8, 0($9)
lw $9, 48($a3)
lw $8, 0($9)
sw $8, -108($sp)
lw $9, -108($sp)
mul $8, $9, 4
sw $8, -112($sp)
lw $9, 44($a3)
lw $10, -112($sp)
add $8, $9, $10
sw $8, -104($sp)
lw $9, -8($sp)
lw $8, 0($9)
sw $8, -116($sp)
lw $8, -116($sp)
lw $9, -104($sp)
sw $8, 0($9)
lw $9, -4($sp)
lw $8, 0($9)
sw $8, -124($sp)
lw $9, -124($sp)
mul $8, $9, 424
sw $8, -128($sp)
lw $9, 68($a3)
lw $10, -128($sp)
add $8, $9, $10
sw $8, -120($sp)
lw $9, -8($sp)
lw $8, 0($9)
sw $8, -132($sp)
lw $9, -132($sp)
mul $8, $9, 4
sw $8, -136($sp)
lw $9, -120($sp)
lw $10, -136($sp)
add $8, $9, $10
sw $8, -120($sp)
lw $9, 56($a3)
lw $8, 0($9)
sw $8, -140($sp)
li $8, 1
sw $8, -144($sp)
lw $9, -140($sp)
lw $10, -144($sp)
add $8, $9, $10
sw $8, -140($sp)
lw $8, -140($sp)
lw $9, -120($sp)
sw $8, 0($9)
lw $9, -4($sp)
lw $8, 0($9)
sw $8, -148($sp)
lw $9, 24($a3)
lw $8, 0($9)
sw $8, -152($sp)
lw $9, -148($sp)
lw $10, -152($sp)
sub $8, $9, $10
sw $8, -152($sp)
li $8, 1
sw $8, -148($sp)
lw $8, -152($sp)
beqz $8, label5
li $8, 0
sw $8, -148($sp)
label5:
lw $8, -148($sp)
beqz $8, label4
lw $9, -8($sp)
lw $8, 0($9)
sw $8, -156($sp)
lw $9, 28($a3)
lw $8, 0($9)
sw $8, -160($sp)
lw $9, -156($sp)
lw $10, -160($sp)
sub $8, $9, $10
sw $8, -160($sp)
li $8, 1
sw $8, -156($sp)
lw $8, -160($sp)
beqz $8, label6
li $8, 0
sw $8, -156($sp)
label6:
lw $8, -156($sp)
beqz $8, label4
lw $9, 52($a3)
move $8, $9
sw $8, -164($sp)
li $8, 1
sw $8, -168($sp)
lw $8, -168($sp)
lw $9, -164($sp)
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
sw $t0, 72($a3)
la $t0, var17
sw $t0, 76($a3)
la $t0, var18
sw $t0, 868($a3)
la $t0, var19
sw $t0, 884($a3)
lw $9, 8($a3)
move $8, $9
sw $8, -4($sp)
li $8, 100
sw $8, -8($sp)
add $29, $29, -632
jal __getchar
sub $29, $29, -632
add $8, $29, -628
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
add $29, $29, -632
jal __getchar
sub $29, $29, -632
add $8, $29, -628
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
add $29, $29, -632
jal __getchar
sub $29, $29, -632
add $8, $29, -628
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
lw $9, 72($a3)
move $8, $9
sw $8, -68($sp)
li $8, 0
sw $8, -72($sp)
lw $8, -72($sp)
lw $9, -68($sp)
sw $8, 0($9)
label7:
lw $9, 72($a3)
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
lw $9, 76($a3)
move $8, $9
sw $8, -84($sp)
li $8, 0
sw $8, -88($sp)
lw $8, -88($sp)
lw $9, -84($sp)
sw $8, 0($9)
label10:
lw $9, 76($a3)
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
lw $9, 72($a3)
lw $8, 0($9)
sw $8, -104($sp)
lw $9, -104($sp)
mul $8, $9, 424
sw $8, -108($sp)
lw $9, 68($a3)
lw $10, -108($sp)
add $8, $9, $10
sw $8, -100($sp)
lw $9, 76($a3)
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
lw $9, 76($a3)
move $8, $9
sw $8, -128($sp)
lw $9, 76($a3)
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
lw $9, 72($a3)
move $8, $9
sw $8, -140($sp)
lw $9, 72($a3)
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
li $8, 0
sw $8, -152($sp)
lw $9, -152($sp)
mul $8, $9, 4
sw $8, -156($sp)
lw $9, 60($a3)
lw $10, -156($sp)
add $8, $9, $10
sw $8, -148($sp)
li $8, -2
sw $8, -160($sp)
lw $8, -160($sp)
lw $9, -148($sp)
sw $8, 0($9)
li $8, 0
sw $8, -168($sp)
lw $9, -168($sp)
mul $8, $9, 4
sw $8, -172($sp)
lw $9, 64($a3)
lw $10, -172($sp)
add $8, $9, $10
sw $8, -164($sp)
li $8, -1
sw $8, -176($sp)
lw $8, -176($sp)
lw $9, -164($sp)
sw $8, 0($9)
li $8, 1
sw $8, -184($sp)
lw $9, -184($sp)
mul $8, $9, 4
sw $8, -188($sp)
lw $9, 60($a3)
lw $10, -188($sp)
add $8, $9, $10
sw $8, -180($sp)
li $8, -2
sw $8, -192($sp)
lw $8, -192($sp)
lw $9, -180($sp)
sw $8, 0($9)
li $8, 1
sw $8, -200($sp)
lw $9, -200($sp)
mul $8, $9, 4
sw $8, -204($sp)
lw $9, 64($a3)
lw $10, -204($sp)
add $8, $9, $10
sw $8, -196($sp)
li $8, 1
sw $8, -208($sp)
lw $8, -208($sp)
lw $9, -196($sp)
sw $8, 0($9)
li $8, 2
sw $8, -216($sp)
lw $9, -216($sp)
mul $8, $9, 4
sw $8, -220($sp)
lw $9, 60($a3)
lw $10, -220($sp)
add $8, $9, $10
sw $8, -212($sp)
li $8, 2
sw $8, -224($sp)
lw $8, -224($sp)
lw $9, -212($sp)
sw $8, 0($9)
li $8, 2
sw $8, -232($sp)
lw $9, -232($sp)
mul $8, $9, 4
sw $8, -236($sp)
lw $9, 64($a3)
lw $10, -236($sp)
add $8, $9, $10
sw $8, -228($sp)
li $8, -1
sw $8, -240($sp)
lw $8, -240($sp)
lw $9, -228($sp)
sw $8, 0($9)
li $8, 3
sw $8, -248($sp)
lw $9, -248($sp)
mul $8, $9, 4
sw $8, -252($sp)
lw $9, 60($a3)
lw $10, -252($sp)
add $8, $9, $10
sw $8, -244($sp)
li $8, 2
sw $8, -256($sp)
lw $8, -256($sp)
lw $9, -244($sp)
sw $8, 0($9)
li $8, 3
sw $8, -264($sp)
lw $9, -264($sp)
mul $8, $9, 4
sw $8, -268($sp)
lw $9, 64($a3)
lw $10, -268($sp)
add $8, $9, $10
sw $8, -260($sp)
li $8, 1
sw $8, -272($sp)
lw $8, -272($sp)
lw $9, -260($sp)
sw $8, 0($9)
li $8, 4
sw $8, -280($sp)
lw $9, -280($sp)
mul $8, $9, 4
sw $8, -284($sp)
lw $9, 60($a3)
lw $10, -284($sp)
add $8, $9, $10
sw $8, -276($sp)
li $8, -1
sw $8, -288($sp)
lw $8, -288($sp)
lw $9, -276($sp)
sw $8, 0($9)
li $8, 4
sw $8, -296($sp)
lw $9, -296($sp)
mul $8, $9, 4
sw $8, -300($sp)
lw $9, 64($a3)
lw $10, -300($sp)
add $8, $9, $10
sw $8, -292($sp)
li $8, -2
sw $8, -304($sp)
lw $8, -304($sp)
lw $9, -292($sp)
sw $8, 0($9)
li $8, 5
sw $8, -312($sp)
lw $9, -312($sp)
mul $8, $9, 4
sw $8, -316($sp)
lw $9, 60($a3)
lw $10, -316($sp)
add $8, $9, $10
sw $8, -308($sp)
li $8, -1
sw $8, -320($sp)
lw $8, -320($sp)
lw $9, -308($sp)
sw $8, 0($9)
li $8, 5
sw $8, -328($sp)
lw $9, -328($sp)
mul $8, $9, 4
sw $8, -332($sp)
lw $9, 64($a3)
lw $10, -332($sp)
add $8, $9, $10
sw $8, -324($sp)
li $8, 2
sw $8, -336($sp)
lw $8, -336($sp)
lw $9, -324($sp)
sw $8, 0($9)
li $8, 6
sw $8, -344($sp)
lw $9, -344($sp)
mul $8, $9, 4
sw $8, -348($sp)
lw $9, 60($a3)
lw $10, -348($sp)
add $8, $9, $10
sw $8, -340($sp)
li $8, 1
sw $8, -352($sp)
lw $8, -352($sp)
lw $9, -340($sp)
sw $8, 0($9)
li $8, 6
sw $8, -360($sp)
lw $9, -360($sp)
mul $8, $9, 4
sw $8, -364($sp)
lw $9, 64($a3)
lw $10, -364($sp)
add $8, $9, $10
sw $8, -356($sp)
li $8, -2
sw $8, -368($sp)
lw $8, -368($sp)
lw $9, -356($sp)
sw $8, 0($9)
li $8, 7
sw $8, -376($sp)
lw $9, -376($sp)
mul $8, $9, 4
sw $8, -380($sp)
lw $9, 60($a3)
lw $10, -380($sp)
add $8, $9, $10
sw $8, -372($sp)
li $8, 1
sw $8, -384($sp)
lw $8, -384($sp)
lw $9, -372($sp)
sw $8, 0($9)
li $8, 7
sw $8, -392($sp)
lw $9, -392($sp)
mul $8, $9, 4
sw $8, -396($sp)
lw $9, 64($a3)
lw $10, -396($sp)
add $8, $9, $10
sw $8, -388($sp)
li $8, 2
sw $8, -400($sp)
lw $8, -400($sp)
lw $9, -388($sp)
sw $8, 0($9)
label13:
lw $9, 12($a3)
lw $8, 0($9)
sw $8, -404($sp)
lw $9, 48($a3)
lw $8, 0($9)
sw $8, -408($sp)
lw $9, -404($sp)
lw $10, -408($sp)
sub $8, $9, $10
sw $8, -408($sp)
lw $8, -408($sp)
bgtz $8, label14
lw $9, 32($a3)
move $8, $9
sw $8, -412($sp)
lw $9, 12($a3)
lw $8, 0($9)
sw $8, -420($sp)
lw $9, -420($sp)
mul $8, $9, 4
sw $8, -424($sp)
lw $9, 40($a3)
lw $10, -424($sp)
add $8, $9, $10
sw $8, -416($sp)
lw $9, -416($sp)
lw $8, 0($9)
sw $8, -416($sp)
lw $8, -416($sp)
lw $9, -412($sp)
sw $8, 0($9)
lw $9, 36($a3)
move $8, $9
sw $8, -428($sp)
lw $9, 12($a3)
lw $8, 0($9)
sw $8, -436($sp)
lw $9, -436($sp)
mul $8, $9, 4
sw $8, -440($sp)
lw $9, 44($a3)
lw $10, -440($sp)
add $8, $9, $10
sw $8, -432($sp)
lw $9, -432($sp)
lw $8, 0($9)
sw $8, -432($sp)
lw $8, -432($sp)
lw $9, -428($sp)
sw $8, 0($9)
lw $9, 56($a3)
move $8, $9
sw $8, -444($sp)
lw $9, 32($a3)
lw $8, 0($9)
sw $8, -452($sp)
lw $9, -452($sp)
mul $8, $9, 424
sw $8, -456($sp)
lw $9, 68($a3)
lw $10, -456($sp)
add $8, $9, $10
sw $8, -448($sp)
lw $9, 36($a3)
lw $8, 0($9)
sw $8, -460($sp)
lw $9, -460($sp)
mul $8, $9, 4
sw $8, -464($sp)
lw $9, -448($sp)
lw $10, -464($sp)
add $8, $9, $10
sw $8, -448($sp)
lw $9, -448($sp)
lw $8, 0($9)
sw $8, -448($sp)
lw $8, -448($sp)
lw $9, -444($sp)
sw $8, 0($9)
lw $9, 76($a3)
move $8, $9
sw $8, -468($sp)
li $8, 0
sw $8, -472($sp)
lw $8, -472($sp)
lw $9, -468($sp)
sw $8, 0($9)
label15:
lw $9, 76($a3)
lw $8, 0($9)
sw $8, -476($sp)
li $8, 8
sw $8, -480($sp)
lw $9, -476($sp)
lw $10, -480($sp)
sub $8, $9, $10
sw $8, -480($sp)
lw $8, -480($sp)
bgez $8, label16
lw $9, 36($a3)
lw $8, 0($9)
sw $8, -488($sp)
lw $9, 76($a3)
lw $8, 0($9)
sw $8, -496($sp)
lw $9, -496($sp)
mul $8, $9, 4
sw $8, -500($sp)
lw $9, 64($a3)
lw $10, -500($sp)
add $8, $9, $10
sw $8, -492($sp)
lw $9, -492($sp)
lw $8, 0($9)
sw $8, -492($sp)
lw $9, -488($sp)
lw $10, -492($sp)
add $8, $9, $10
sw $8, -488($sp)
add $8, $29, -636
sw $8, -504($sp)
lw $8, -488($sp)
lw $9, -504($sp)
sw $8, 0($9)
lw $9, 32($a3)
lw $8, 0($9)
sw $8, -508($sp)
lw $9, 76($a3)
lw $8, 0($9)
sw $8, -516($sp)
lw $9, -516($sp)
mul $8, $9, 4
sw $8, -520($sp)
lw $9, 60($a3)
lw $10, -520($sp)
add $8, $9, $10
sw $8, -512($sp)
lw $9, -512($sp)
lw $8, 0($9)
sw $8, -512($sp)
lw $9, -508($sp)
lw $10, -512($sp)
add $8, $9, $10
sw $8, -508($sp)
add $8, $29, -640
sw $8, -524($sp)
lw $8, -508($sp)
lw $9, -524($sp)
sw $8, 0($9)
add $29, $29, -640
jal __addList
sub $29, $29, -640
add $8, $29, -628
sw $8, -528($sp)
lw $9, -528($sp)
move $8, $9
sw $8, -484($sp)
label17:
lw $9, 76($a3)
move $8, $9
sw $8, -536($sp)
lw $9, 76($a3)
lw $8, 0($9)
sw $8, -532($sp)
lw $9, -532($sp)
add $8, $9, 1
sw $8, -540($sp)
lw $8, -540($sp)
lw $9, -536($sp)
sw $8, 0($9)
j label15
label16:
lw $9, 52($a3)
lw $8, 0($9)
sw $8, -544($sp)
li $8, 1
sw $8, -548($sp)
lw $9, -544($sp)
lw $10, -548($sp)
sub $8, $9, $10
sw $8, -548($sp)
lw $8, -548($sp)
bnez $8, label18
j label14
label18:
lw $9, 12($a3)
move $8, $9
sw $8, -556($sp)
lw $9, 12($a3)
lw $8, 0($9)
sw $8, -552($sp)
lw $9, -552($sp)
add $8, $9, 1
sw $8, -560($sp)
lw $8, -560($sp)
lw $9, -556($sp)
sw $8, 0($9)
j label13
label14:
lw $9, 52($a3)
lw $8, 0($9)
sw $8, -564($sp)
li $8, 1
sw $8, -568($sp)
lw $9, -564($sp)
lw $10, -568($sp)
sub $8, $9, $10
sw $8, -568($sp)
lw $8, -568($sp)
bnez $8, label19
lw $9, 24($a3)
lw $8, 0($9)
sw $8, -580($sp)
lw $9, -580($sp)
mul $8, $9, 424
sw $8, -584($sp)
lw $9, 68($a3)
lw $10, -584($sp)
add $8, $9, $10
sw $8, -576($sp)
lw $9, 28($a3)
lw $8, 0($9)
sw $8, -588($sp)
lw $9, -588($sp)
mul $8, $9, 4
sw $8, -592($sp)
lw $9, -576($sp)
lw $10, -592($sp)
add $8, $9, $10
sw $8, -576($sp)
add $8, $29, -632
sw $8, -596($sp)
lw $9, -576($sp)
lw $8, 0($9)
sw $8, -576($sp)
lw $8, -576($sp)
lw $9, -596($sp)
sw $8, 0($9)
lw $9, 868($a3)
move $8, $9
sw $8, -600($sp)
add $8, $29, -636
sw $8, -604($sp)
lw $8, -600($sp)
lw $9, -604($sp)
sw $8, 0($9)
add $29, $29, -636
jal __printf
sub $29, $29, -636
j label20
label19:
lw $9, 884($a3)
move $8, $9
sw $8, -612($sp)
add $8, $29, -632
sw $8, -616($sp)
lw $8, -612($sp)
lw $9, -616($sp)
sw $8, 0($9)
add $29, $29, -632
jal __printf_single
sub $29, $29, -632
label20:
li $8, 0
sw $8, -620($sp)
add $8, $29, 4
sw $8, -624($sp)
lw $8, -620($sp)
lw $9, -624($sp)
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
#global $15 32
#global $16 36
#global $17 44944
#global $18 4
#global $19 4
#string $217 #%d\n
#string $221 #no solution!\n
#----------------------------
#func #check
#addi $20 $0 0
####move $21 $20
#lw $21 $20 0
####move $22 $2
#lw $22 $2 0
#sub $22 $21 $22
#li $21 1
#bltz $22 l:0
#li $21 0
#label l:0
#beqz $21 l:1
####move $21 $20
#lw $21 $20 0
#li $23 0
#sub $23 $21 $23
#li $21 1
#bgez $23 l:2
#li $21 0
#label l:2
#label l:1
#andi $21 $21 1
#addi $24 $0 8
#sw $21 $24 0
#return
#return
#----------------------------
#func #addList
#addi $25 $0 0
#addi $26 $0 4
#sw $1 $0 -176
####move $28 $25
#addi $29 $0 -180
#lw $28 $25 0
#sw $28 $29 0
#addi $0 $0 -180
#call #check
#subi $0 $0 -180
#lw $1 $0 -176
#addi $30 $0 -172
####move $27 $30
#lw $27 $30 0
#li $31 1
#sub $31 $27 $31
#bnez $31 l:3
#sw $1 $0 -176
####move $33 $26
#addi $34 $0 -180
#lw $33 $26 0
#sw $33 $34 0
#addi $0 $0 -180
#call #check
#subi $0 $0 -180
#lw $1 $0 -176
#addi $35 $0 -172
####move $32 $35
#lw $32 $35 0
#li $36 1
#sub $36 $32 $36
#bnez $36 l:3
####move $37 $17
####move $38 $25
#lw $38 $25 0
#muli $39 $38 424
#add $37 $17 $39
####move $40 $26
#lw $40 $26 0
#muli $41 $40 4
#add $37 $37 $41
#lw $37 $37 0
#li $42 -1
#sub $42 $37 $42
#bnez $42 l:3
####move $43 $12
#move $44 $12
#lw $43 $12 0
#addi $45 $43 1
#sw $45 $44 0
####move $46 $10
####move $47 $12
#lw $47 $12 0
#muli $48 $47 4
#add $46 $10 $48
####move $49 $25
#lw $49 $25 0
#sw $49 $46 0
####move $50 $11
####move $51 $12
#lw $51 $12 0
#muli $52 $51 4
#add $50 $11 $52
####move $53 $26
#lw $53 $26 0
#sw $53 $50 0
####move $54 $17
####move $55 $25
#lw $55 $25 0
#muli $56 $55 424
#add $54 $17 $56
####move $57 $26
#lw $57 $26 0
#muli $58 $57 4
#add $54 $54 $58
####move $59 $14
#lw $59 $14 0
#li $60 1
#add $59 $59 $60
#sw $59 $54 0
####move $61 $25
#lw $61 $25 0
####move $62 $6
#lw $62 $6 0
#sub $62 $61 $62
#li $61 1
#beqz $62 l:5
#li $61 0
#label l:5
#beqz $61 l:4
####move $63 $26
#lw $63 $26 0
####move $64 $7
#lw $64 $7 0
#sub $64 $63 $64
#li $63 1
#beqz $64 l:6
#li $63 0
#label l:6
#beqz $63 l:4
#move $65 $13
#li $66 1
#sw $66 $65 0
#label l:4
#label l:3
#return
#----------------------------
#func #main
#move $67 $2
#li $68 100
#addi $0 $0 -632
#call #getchar
#subi $0 $0 -632
#addi $70 $0 -628
####move $69 $70
#lw $69 $70 0
#li $71 48
#sub $69 $69 $71
#mul $68 $68 $69
#li $72 10
#addi $0 $0 -632
#call #getchar
#subi $0 $0 -632
#addi $74 $0 -628
####move $73 $74
#lw $73 $74 0
#li $75 48
#sub $73 $73 $75
#mul $72 $72 $73
#add $68 $68 $72
#addi $0 $0 -632
#call #getchar
#subi $0 $0 -632
#addi $77 $0 -628
####move $76 $77
#lw $76 $77 0
#add $68 $68 $76
#li $78 48
#sub $68 $68 $78
#sw $68 $67 0
#move $79 $6
#move $80 $7
####move $81 $2
#lw $81 $2 0
#li $82 1
#sub $81 $81 $82
#sw $81 $80 0
#lw $80 $80 0
#sw $80 $79 0
#move $83 $18
#li $84 0
#sw $84 $83 0
#label l:7
####move $85 $18
#lw $85 $18 0
####move $86 $2
#lw $86 $2 0
#sub $86 $85 $86
#bgez $86 l:8
#move $87 $19
#li $88 0
#sw $88 $87 0
#label l:10
####move $89 $19
#lw $89 $19 0
####move $90 $2
#lw $90 $2 0
#sub $90 $89 $90
#bgez $90 l:11
####move $91 $17
####move $92 $18
#lw $92 $18 0
#muli $93 $92 424
#add $91 $17 $93
####move $94 $19
#lw $94 $19 0
#muli $95 $94 4
#add $91 $91 $95
#li $96 -1
#sw $96 $91 0
#label l:12
####move $97 $19
#move $98 $19
#lw $97 $19 0
#addi $99 $97 1
#sw $99 $98 0
#goto l:10
#label l:11
#label l:9
####move $100 $18
#move $101 $18
#lw $100 $18 0
#addi $102 $100 1
#sw $102 $101 0
#goto l:7
#label l:8
####move $103 $15
#li $104 0
#muli $105 $104 4
#add $103 $15 $105
#li $106 -2
#sw $106 $103 0
####move $107 $16
#li $108 0
#muli $109 $108 4
#add $107 $16 $109
#li $110 -1
#sw $110 $107 0
####move $111 $15
#li $112 1
#muli $113 $112 4
#add $111 $15 $113
#li $114 -2
#sw $114 $111 0
####move $115 $16
#li $116 1
#muli $117 $116 4
#add $115 $16 $117
#li $118 1
#sw $118 $115 0
####move $119 $15
#li $120 2
#muli $121 $120 4
#add $119 $15 $121
#li $122 2
#sw $122 $119 0
####move $123 $16
#li $124 2
#muli $125 $124 4
#add $123 $16 $125
#li $126 -1
#sw $126 $123 0
####move $127 $15
#li $128 3
#muli $129 $128 4
#add $127 $15 $129
#li $130 2
#sw $130 $127 0
####move $131 $16
#li $132 3
#muli $133 $132 4
#add $131 $16 $133
#li $134 1
#sw $134 $131 0
####move $135 $15
#li $136 4
#muli $137 $136 4
#add $135 $15 $137
#li $138 -1
#sw $138 $135 0
####move $139 $16
#li $140 4
#muli $141 $140 4
#add $139 $16 $141
#li $142 -2
#sw $142 $139 0
####move $143 $15
#li $144 5
#muli $145 $144 4
#add $143 $15 $145
#li $146 -1
#sw $146 $143 0
####move $147 $16
#li $148 5
#muli $149 $148 4
#add $147 $16 $149
#li $150 2
#sw $150 $147 0
####move $151 $15
#li $152 6
#muli $153 $152 4
#add $151 $15 $153
#li $154 1
#sw $154 $151 0
####move $155 $16
#li $156 6
#muli $157 $156 4
#add $155 $16 $157
#li $158 -2
#sw $158 $155 0
####move $159 $15
#li $160 7
#muli $161 $160 4
#add $159 $15 $161
#li $162 1
#sw $162 $159 0
####move $163 $16
#li $164 7
#muli $165 $164 4
#add $163 $16 $165
#li $166 2
#sw $166 $163 0
#label l:13
####move $167 $3
#lw $167 $3 0
####move $168 $12
#lw $168 $12 0
#sub $168 $167 $168
#bgtz $168 l:14
#move $169 $8
####move $170 $10
####move $171 $3
#lw $171 $3 0
#muli $172 $171 4
#add $170 $10 $172
#lw $170 $170 0
#sw $170 $169 0
#move $173 $9
####move $174 $11
####move $175 $3
#lw $175 $3 0
#muli $176 $175 4
#add $174 $11 $176
#lw $174 $174 0
#sw $174 $173 0
#move $177 $14
####move $178 $17
####move $179 $8
#lw $179 $8 0
#muli $180 $179 424
#add $178 $17 $180
####move $181 $9
#lw $181 $9 0
#muli $182 $181 4
#add $178 $178 $182
#lw $178 $178 0
#sw $178 $177 0
#move $183 $19
#li $184 0
#sw $184 $183 0
#label l:15
####move $185 $19
#lw $185 $19 0
#li $186 8
#sub $186 $185 $186
#bgez $186 l:16
####move $188 $9
#lw $188 $9 0
####move $189 $16
####move $190 $19
#lw $190 $19 0
#muli $191 $190 4
#add $189 $16 $191
#lw $189 $189 0
#add $188 $188 $189
#addi $192 $0 -636
#sw $188 $192 0
####move $193 $8
#lw $193 $8 0
####move $194 $15
####move $195 $19
#lw $195 $19 0
#muli $196 $195 4
#add $194 $15 $196
#lw $194 $194 0
#add $193 $193 $194
#addi $197 $0 -640
#sw $193 $197 0
#addi $0 $0 -640
#call #addList
#subi $0 $0 -640
#addi $198 $0 -628
#move $187 $198
#label l:17
####move $199 $19
#move $200 $19
#lw $199 $19 0
#addi $201 $199 1
#sw $201 $200 0
#goto l:15
#label l:16
####move $202 $13
#lw $202 $13 0
#li $203 1
#sub $203 $202 $203
#bnez $203 l:18
#goto l:14
#label l:18
####move $204 $3
#move $205 $3
#lw $204 $3 0
#addi $206 $204 1
#sw $206 $205 0
#goto l:13
#label l:14
####move $207 $13
#lw $207 $13 0
#li $208 1
#sub $208 $207 $208
#bnez $208 l:19
####move $210 $17
####move $211 $6
#lw $211 $6 0
#muli $212 $211 424
#add $210 $17 $212
####move $213 $7
#lw $213 $7 0
#muli $214 $213 4
#add $210 $210 $214
#addi $215 $0 -632
#lw $210 $210 0
#sw $210 $215 0
#move $216 $217
#addi $218 $0 -636
#sw $216 $218 0
#addi $0 $0 -636
#call #printf
#subi $0 $0 -636
#goto l:20
#label l:19
#move $220 $221
#addi $222 $0 -632
#sw $220 $222 0
#addi $0 $0 -632
#call #printf_single
#subi $0 $0 -632
#label l:20
#li $223 0
#addi $224 $0 4
#sw $223 $224 0
#return
#return
