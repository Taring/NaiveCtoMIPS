.data
temp: .space 1280
var0: .space 4
var1: .space 4
var2: .space 4
var3: .space 400
var4: .space 4
var5: .space 4
var6: .space 4
var7: .space 4
var8: .space 4
var9: .asciiz "%d "
.align 2
var10: .asciiz "%c"
.align 2
var11: .asciiz "Sorry, the number n must be a number s.t. there exists i satisfying n=1+2+...+i\n"
.align 2
var12: .asciiz "Let's start!\n"
.align 2
var13: .asciiz "%d\n"
.align 2
var14: .asciiz "step %d:\n"
.align 2
var15: .asciiz "Total: %d step(s)\n"
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

__random:
add $8, $29, -72
sw $8, -8($sp)
lw $9, -8($sp)
move $8, $9
sw $8, -4($sp)
lw $9, 28($a3)
lw $8, 0($9)
sw $8, -12($sp)
lw $9, 52($a3)
lw $8, 0($9)
sw $8, -16($sp)
lw $9, 44($a3)
lw $8, 0($9)
sw $8, -20($sp)
lw $9, -16($sp)
lw $10, -20($sp)
rem $8, $9, $10
sw $8, -16($sp)
lw $9, -12($sp)
lw $10, -16($sp)
mul $8, $9, $10
sw $8, -12($sp)
lw $9, 48($a3)
lw $8, 0($9)
sw $8, -24($sp)
lw $9, 52($a3)
lw $8, 0($9)
sw $8, -28($sp)
lw $9, 44($a3)
lw $8, 0($9)
sw $8, -32($sp)
lw $9, -28($sp)
lw $10, -32($sp)
div $8, $9, $10
sw $8, -28($sp)
lw $9, -24($sp)
lw $10, -28($sp)
mul $8, $9, $10
sw $8, -24($sp)
lw $9, -12($sp)
lw $10, -24($sp)
sub $8, $9, $10
sw $8, -12($sp)
lw $8, -12($sp)
lw $9, -4($sp)
sw $8, 0($9)
lw $9, -4($sp)
lw $8, 0($9)
sw $8, -36($sp)
li $8, 0
sw $8, -40($sp)
lw $9, -36($sp)
lw $10, -40($sp)
sub $8, $9, $10
sw $8, -40($sp)
lw $8, -40($sp)
bltz $8, label0
lw $9, 52($a3)
move $8, $9
sw $8, -44($sp)
lw $9, -4($sp)
lw $8, 0($9)
sw $8, -48($sp)
lw $8, -48($sp)
lw $9, -44($sp)
sw $8, 0($9)
j label1
label0:
lw $9, 52($a3)
move $8, $9
sw $8, -52($sp)
lw $9, -4($sp)
lw $8, 0($9)
sw $8, -56($sp)
lw $9, 36($a3)
lw $8, 0($9)
sw $8, -60($sp)
lw $9, -56($sp)
lw $10, -60($sp)
add $8, $9, $10
sw $8, -56($sp)
lw $8, -56($sp)
lw $9, -52($sp)
sw $8, 0($9)
label1:
add $8, $29, 4
sw $8, -68($sp)
lw $9, 52($a3)
lw $8, 0($9)
sw $8, -64($sp)
lw $8, -64($sp)
lw $9, -68($sp)
sw $8, 0($9)
jr $ra
jr $ra
__initialize:
add $8, $29, 0
sw $8, -4($sp)
lw $9, 52($a3)
move $8, $9
sw $8, -8($sp)
lw $9, -4($sp)
lw $8, 0($9)
sw $8, -12($sp)
lw $8, -12($sp)
lw $9, -8($sp)
sw $8, 0($9)
jr $ra
__swap:
add $8, $29, 0
sw $8, -4($sp)
add $8, $29, 4
sw $8, -8($sp)
add $8, $29, -72
sw $8, -16($sp)
lw $9, -16($sp)
move $8, $9
sw $8, -12($sp)
lw $9, -4($sp)
lw $8, 0($9)
sw $8, -24($sp)
lw $9, -24($sp)
mul $8, $9, 4
sw $8, -28($sp)
lw $9, 24($a3)
lw $10, -28($sp)
add $8, $9, $10
sw $8, -20($sp)
lw $9, -20($sp)
lw $8, 0($9)
sw $8, -20($sp)
lw $8, -20($sp)
lw $9, -12($sp)
sw $8, 0($9)
lw $9, -4($sp)
lw $8, 0($9)
sw $8, -36($sp)
lw $9, -36($sp)
mul $8, $9, 4
sw $8, -40($sp)
lw $9, 24($a3)
lw $10, -40($sp)
add $8, $9, $10
sw $8, -32($sp)
lw $9, -8($sp)
lw $8, 0($9)
sw $8, -48($sp)
lw $9, -48($sp)
mul $8, $9, 4
sw $8, -52($sp)
lw $9, 24($a3)
lw $10, -52($sp)
add $8, $9, $10
sw $8, -44($sp)
lw $9, -44($sp)
lw $8, 0($9)
sw $8, -44($sp)
lw $8, -44($sp)
lw $9, -32($sp)
sw $8, 0($9)
lw $9, -8($sp)
lw $8, 0($9)
sw $8, -60($sp)
lw $9, -60($sp)
mul $8, $9, 4
sw $8, -64($sp)
lw $9, 24($a3)
lw $10, -64($sp)
add $8, $9, $10
sw $8, -56($sp)
lw $9, -12($sp)
lw $8, 0($9)
sw $8, -68($sp)
lw $8, -68($sp)
lw $9, -56($sp)
sw $8, 0($9)
jr $ra
__pd:
add $8, $29, 0
sw $8, -4($sp)
label2:
lw $9, 16($a3)
lw $8, 0($9)
sw $8, -8($sp)
lw $9, -4($sp)
lw $8, 0($9)
sw $8, -12($sp)
lw $9, -8($sp)
lw $10, -12($sp)
sub $8, $9, $10
sw $8, -12($sp)
lw $8, -12($sp)
bgtz $8, label3
lw $9, -4($sp)
lw $8, 0($9)
sw $8, -16($sp)
lw $9, 16($a3)
lw $8, 0($9)
sw $8, -20($sp)
lw $9, 16($a3)
lw $8, 0($9)
sw $8, -24($sp)
li $8, 1
sw $8, -28($sp)
lw $9, -24($sp)
lw $10, -28($sp)
add $8, $9, $10
sw $8, -24($sp)
lw $9, -20($sp)
lw $10, -24($sp)
mul $8, $9, $10
sw $8, -20($sp)
li $8, 2
sw $8, -32($sp)
lw $9, -20($sp)
lw $10, -32($sp)
div $8, $9, $10
sw $8, -20($sp)
lw $9, -16($sp)
lw $10, -20($sp)
sub $8, $9, $10
sw $8, -20($sp)
lw $8, -20($sp)
bnez $8, label5
li $8, 1
sw $8, -36($sp)
add $8, $29, 8
sw $8, -40($sp)
lw $8, -36($sp)
lw $9, -40($sp)
sw $8, 0($9)
jr $ra
label5:
label4:
lw $9, 16($a3)
move $8, $9
sw $8, -48($sp)
lw $9, 16($a3)
lw $8, 0($9)
sw $8, -44($sp)
lw $9, -44($sp)
add $8, $9, 1
sw $8, -44($sp)
lw $8, -44($sp)
lw $9, -48($sp)
sw $8, 0($9)
j label2
label3:
li $8, 0
sw $8, -52($sp)
add $8, $29, 8
sw $8, -56($sp)
lw $8, -52($sp)
lw $9, -56($sp)
sw $8, 0($9)
jr $ra
jr $ra
__show:
add $8, $29, -84
sw $8, -8($sp)
lw $9, -8($sp)
move $8, $9
sw $8, -4($sp)
lw $9, -8($sp)
move $8, $9
sw $8, -12($sp)
li $8, 0
sw $8, -16($sp)
lw $8, -16($sp)
lw $9, -12($sp)
sw $8, 0($9)
label6:
lw $9, -4($sp)
lw $8, 0($9)
sw $8, -20($sp)
lw $9, 20($a3)
lw $8, 0($9)
sw $8, -24($sp)
lw $9, -20($sp)
lw $10, -24($sp)
sub $8, $9, $10
sw $8, -24($sp)
lw $8, -24($sp)
bgez $8, label7
sw $31, -88($29)
lw $9, -4($sp)
lw $8, 0($9)
sw $8, -36($sp)
lw $9, -36($sp)
mul $8, $9, 4
sw $8, -40($sp)
lw $9, 24($a3)
lw $10, -40($sp)
add $8, $9, $10
sw $8, -32($sp)
add $8, $29, -92
sw $8, -44($sp)
lw $9, -32($sp)
lw $8, 0($9)
sw $8, -32($sp)
lw $8, -32($sp)
lw $9, -44($sp)
sw $8, 0($9)
lw $9, 312($a3)
move $8, $9
sw $8, -48($sp)
add $8, $29, -96
sw $8, -52($sp)
lw $8, -48($sp)
lw $9, -52($sp)
sw $8, 0($9)
add $29, $29, -96
jal __printf
sub $29, $29, -96
lw $31, -88($29)
label8:
lw $9, -4($sp)
move $8, $9
sw $8, -60($sp)
lw $9, -4($sp)
lw $8, 0($9)
sw $8, -56($sp)
lw $9, -56($sp)
add $8, $9, 1
sw $8, -56($sp)
lw $8, -56($sp)
lw $9, -60($sp)
sw $8, 0($9)
j label6
label7:
sw $31, -88($29)
li $8, 10
sw $8, -68($sp)
add $8, $29, -92
sw $8, -72($sp)
lw $8, -68($sp)
lw $9, -72($sp)
sw $8, 0($9)
lw $9, 344($a3)
move $8, $9
sw $8, -76($sp)
add $8, $29, -96
sw $8, -80($sp)
lw $8, -76($sp)
lw $9, -80($sp)
sw $8, 0($9)
add $29, $29, -96
jal __printf
sub $29, $29, -96
lw $31, -88($29)
jr $ra
__win:
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
li $8, 0
sw $8, -20($sp)
lw $8, -20($sp)
lw $9, -12($sp)
sw $8, 0($9)
add $8, $29, -700
sw $8, -28($sp)
lw $9, -28($sp)
move $8, $9
sw $8, -24($sp)
add $8, $29, -704
sw $8, -36($sp)
lw $9, -36($sp)
move $8, $9
sw $8, -32($sp)
lw $9, 20($a3)
lw $8, 0($9)
sw $8, -40($sp)
lw $9, 16($a3)
lw $8, 0($9)
sw $8, -44($sp)
lw $9, -40($sp)
lw $10, -44($sp)
sub $8, $9, $10
sw $8, -44($sp)
lw $8, -44($sp)
beqz $8, label9
li $8, 0
sw $8, -48($sp)
add $8, $29, 4
sw $8, -52($sp)
lw $8, -48($sp)
lw $9, -52($sp)
sw $8, 0($9)
jr $ra
label9:
lw $9, -12($sp)
move $8, $9
sw $8, -56($sp)
label10:
lw $9, -12($sp)
lw $8, 0($9)
sw $8, -60($sp)
lw $9, 20($a3)
lw $8, 0($9)
sw $8, -64($sp)
lw $9, -60($sp)
lw $10, -64($sp)
sub $8, $9, $10
sw $8, -64($sp)
lw $8, -64($sp)
bgez $8, label11
lw $9, -12($sp)
lw $8, 0($9)
sw $8, -72($sp)
lw $9, -72($sp)
mul $8, $9, 4
sw $8, -76($sp)
lw $9, -24($sp)
lw $10, -76($sp)
add $8, $9, $10
sw $8, -68($sp)
lw $9, -12($sp)
lw $8, 0($9)
sw $8, -84($sp)
lw $9, -84($sp)
mul $8, $9, 4
sw $8, -88($sp)
lw $9, 24($a3)
lw $10, -88($sp)
add $8, $9, $10
sw $8, -80($sp)
lw $9, -80($sp)
lw $8, 0($9)
sw $8, -80($sp)
lw $8, -80($sp)
lw $9, -68($sp)
sw $8, 0($9)
label12:
lw $9, -12($sp)
move $8, $9
sw $8, -96($sp)
lw $9, -12($sp)
lw $8, 0($9)
sw $8, -92($sp)
lw $9, -92($sp)
add $8, $9, 1
sw $8, -92($sp)
lw $8, -92($sp)
lw $9, -96($sp)
sw $8, 0($9)
j label10
label11:
lw $9, -4($sp)
move $8, $9
sw $8, -100($sp)
li $8, 0
sw $8, -104($sp)
lw $8, -104($sp)
lw $9, -100($sp)
sw $8, 0($9)
label13:
lw $9, -4($sp)
lw $8, 0($9)
sw $8, -108($sp)
lw $9, 20($a3)
lw $8, 0($9)
sw $8, -112($sp)
li $8, 1
sw $8, -116($sp)
lw $9, -112($sp)
lw $10, -116($sp)
sub $8, $9, $10
sw $8, -112($sp)
lw $9, -108($sp)
lw $10, -112($sp)
sub $8, $9, $10
sw $8, -112($sp)
lw $8, -112($sp)
bgez $8, label14
lw $9, -12($sp)
move $8, $9
sw $8, -120($sp)
lw $9, -4($sp)
lw $8, 0($9)
sw $8, -124($sp)
li $8, 1
sw $8, -128($sp)
lw $9, -124($sp)
lw $10, -128($sp)
add $8, $9, $10
sw $8, -124($sp)
lw $8, -124($sp)
lw $9, -120($sp)
sw $8, 0($9)
label16:
lw $9, -12($sp)
lw $8, 0($9)
sw $8, -132($sp)
lw $9, 20($a3)
lw $8, 0($9)
sw $8, -136($sp)
lw $9, -132($sp)
lw $10, -136($sp)
sub $8, $9, $10
sw $8, -136($sp)
lw $8, -136($sp)
bgez $8, label17
lw $9, -4($sp)
lw $8, 0($9)
sw $8, -144($sp)
lw $9, -144($sp)
mul $8, $9, 4
sw $8, -148($sp)
lw $9, -24($sp)
lw $10, -148($sp)
add $8, $9, $10
sw $8, -140($sp)
lw $9, -140($sp)
lw $8, 0($9)
sw $8, -140($sp)
lw $9, -12($sp)
lw $8, 0($9)
sw $8, -156($sp)
lw $9, -156($sp)
mul $8, $9, 4
sw $8, -160($sp)
lw $9, -24($sp)
lw $10, -160($sp)
add $8, $9, $10
sw $8, -152($sp)
lw $9, -152($sp)
lw $8, 0($9)
sw $8, -152($sp)
lw $9, -140($sp)
lw $10, -152($sp)
sub $8, $9, $10
sw $8, -152($sp)
lw $8, -152($sp)
blez $8, label19
lw $9, -32($sp)
move $8, $9
sw $8, -164($sp)
lw $9, -4($sp)
lw $8, 0($9)
sw $8, -172($sp)
lw $9, -172($sp)
mul $8, $9, 4
sw $8, -176($sp)
lw $9, -24($sp)
lw $10, -176($sp)
add $8, $9, $10
sw $8, -168($sp)
lw $9, -168($sp)
lw $8, 0($9)
sw $8, -168($sp)
lw $8, -168($sp)
lw $9, -164($sp)
sw $8, 0($9)
lw $9, -4($sp)
lw $8, 0($9)
sw $8, -184($sp)
lw $9, -184($sp)
mul $8, $9, 4
sw $8, -188($sp)
lw $9, -24($sp)
lw $10, -188($sp)
add $8, $9, $10
sw $8, -180($sp)
lw $9, -12($sp)
lw $8, 0($9)
sw $8, -196($sp)
lw $9, -196($sp)
mul $8, $9, 4
sw $8, -200($sp)
lw $9, -24($sp)
lw $10, -200($sp)
add $8, $9, $10
sw $8, -192($sp)
lw $9, -192($sp)
lw $8, 0($9)
sw $8, -192($sp)
lw $8, -192($sp)
lw $9, -180($sp)
sw $8, 0($9)
lw $9, -12($sp)
lw $8, 0($9)
sw $8, -208($sp)
lw $9, -208($sp)
mul $8, $9, 4
sw $8, -212($sp)
lw $9, -24($sp)
lw $10, -212($sp)
add $8, $9, $10
sw $8, -204($sp)
lw $9, -32($sp)
lw $8, 0($9)
sw $8, -216($sp)
lw $8, -216($sp)
lw $9, -204($sp)
sw $8, 0($9)
label19:
label18:
lw $9, -12($sp)
move $8, $9
sw $8, -224($sp)
lw $9, -12($sp)
lw $8, 0($9)
sw $8, -220($sp)
lw $9, -220($sp)
add $8, $9, 1
sw $8, -220($sp)
lw $8, -220($sp)
lw $9, -224($sp)
sw $8, 0($9)
j label16
label17:
label15:
lw $9, -4($sp)
move $8, $9
sw $8, -232($sp)
lw $9, -4($sp)
lw $8, 0($9)
sw $8, -228($sp)
lw $9, -228($sp)
add $8, $9, 1
sw $8, -228($sp)
lw $8, -228($sp)
lw $9, -232($sp)
sw $8, 0($9)
j label13
label14:
lw $9, -4($sp)
move $8, $9
sw $8, -236($sp)
li $8, 0
sw $8, -240($sp)
lw $8, -240($sp)
lw $9, -236($sp)
sw $8, 0($9)
label20:
lw $9, -4($sp)
lw $8, 0($9)
sw $8, -244($sp)
lw $9, 20($a3)
lw $8, 0($9)
sw $8, -248($sp)
lw $9, -244($sp)
lw $10, -248($sp)
sub $8, $9, $10
sw $8, -248($sp)
lw $8, -248($sp)
bgez $8, label21
lw $9, -4($sp)
lw $8, 0($9)
sw $8, -256($sp)
lw $9, -256($sp)
mul $8, $9, 4
sw $8, -260($sp)
lw $9, -24($sp)
lw $10, -260($sp)
add $8, $9, $10
sw $8, -252($sp)
lw $9, -252($sp)
lw $8, 0($9)
sw $8, -252($sp)
lw $9, -4($sp)
lw $8, 0($9)
sw $8, -264($sp)
li $8, 1
sw $8, -268($sp)
lw $9, -264($sp)
lw $10, -268($sp)
add $8, $9, $10
sw $8, -264($sp)
lw $9, -252($sp)
lw $10, -264($sp)
sub $8, $9, $10
sw $8, -264($sp)
lw $8, -264($sp)
beqz $8, label23
li $8, 0
sw $8, -272($sp)
add $8, $29, 4
sw $8, -276($sp)
lw $8, -272($sp)
lw $9, -276($sp)
sw $8, 0($9)
jr $ra
label23:
label22:
lw $9, -4($sp)
move $8, $9
sw $8, -284($sp)
lw $9, -4($sp)
lw $8, 0($9)
sw $8, -280($sp)
lw $9, -280($sp)
add $8, $9, 1
sw $8, -280($sp)
lw $8, -280($sp)
lw $9, -284($sp)
sw $8, 0($9)
j label20
label21:
li $8, 1
sw $8, -288($sp)
add $8, $29, 4
sw $8, -292($sp)
lw $8, -288($sp)
lw $9, -292($sp)
sw $8, 0($9)
jr $ra
jr $ra
__merge:
add $8, $29, -164
sw $8, -8($sp)
lw $9, -8($sp)
move $8, $9
sw $8, -4($sp)
li $8, 0
sw $8, -12($sp)
lw $8, -12($sp)
lw $9, -4($sp)
sw $8, 0($9)
lw $9, -4($sp)
move $8, $9
sw $8, -16($sp)
label24:
lw $9, -4($sp)
lw $8, 0($9)
sw $8, -20($sp)
lw $9, 20($a3)
lw $8, 0($9)
sw $8, -24($sp)
lw $9, -20($sp)
lw $10, -24($sp)
sub $8, $9, $10
sw $8, -24($sp)
lw $8, -24($sp)
bgez $8, label25
lw $9, -4($sp)
lw $8, 0($9)
sw $8, -32($sp)
lw $9, -32($sp)
mul $8, $9, 4
sw $8, -36($sp)
lw $9, 24($a3)
lw $10, -36($sp)
add $8, $9, $10
sw $8, -28($sp)
lw $9, -28($sp)
lw $8, 0($9)
sw $8, -28($sp)
lw $9, -28($sp)
li $8, 1
beqz $9, lnot0
li $8, 0
lnot0:
sw $8, -28($sp)
lw $8, -28($sp)
beqz $8, label27
add $8, $29, -168
sw $8, -44($sp)
lw $9, -44($sp)
move $8, $9
sw $8, -40($sp)
lw $9, -44($sp)
move $8, $9
sw $8, -48($sp)
lw $9, -4($sp)
lw $8, 0($9)
sw $8, -52($sp)
li $8, 1
sw $8, -56($sp)
lw $9, -52($sp)
lw $10, -56($sp)
add $8, $9, $10
sw $8, -52($sp)
lw $8, -52($sp)
lw $9, -48($sp)
sw $8, 0($9)
label28:
lw $9, -40($sp)
lw $8, 0($9)
sw $8, -60($sp)
lw $9, 20($a3)
lw $8, 0($9)
sw $8, -64($sp)
lw $9, -60($sp)
lw $10, -64($sp)
sub $8, $9, $10
sw $8, -64($sp)
lw $8, -64($sp)
bgez $8, label29
lw $9, -40($sp)
lw $8, 0($9)
sw $8, -72($sp)
lw $9, -72($sp)
mul $8, $9, 4
sw $8, -76($sp)
lw $9, 24($a3)
lw $10, -76($sp)
add $8, $9, $10
sw $8, -68($sp)
lw $9, -68($sp)
lw $8, 0($9)
sw $8, -68($sp)
li $8, 0
sw $8, -80($sp)
lw $9, -68($sp)
lw $10, -80($sp)
sub $8, $9, $10
sw $8, -80($sp)
lw $8, -80($sp)
beqz $8, label31
sw $31, -172($29)
add $8, $29, -176
sw $8, -92($sp)
lw $9, -40($sp)
lw $8, 0($9)
sw $8, -88($sp)
lw $8, -88($sp)
lw $9, -92($sp)
sw $8, 0($9)
add $8, $29, -180
sw $8, -100($sp)
lw $9, -4($sp)
lw $8, 0($9)
sw $8, -96($sp)
lw $8, -96($sp)
lw $9, -100($sp)
sw $8, 0($9)
add $29, $29, -180
jal __swap
sub $29, $29, -180
lw $31, -172($29)
j label29
label31:
label30:
lw $9, -40($sp)
move $8, $9
sw $8, -108($sp)
lw $9, -40($sp)
lw $8, 0($9)
sw $8, -104($sp)
lw $9, -104($sp)
add $8, $9, 1
sw $8, -104($sp)
lw $8, -104($sp)
lw $9, -108($sp)
sw $8, 0($9)
j label28
label29:
label27:
label26:
lw $9, -4($sp)
move $8, $9
sw $8, -116($sp)
lw $9, -4($sp)
lw $8, 0($9)
sw $8, -112($sp)
lw $9, -112($sp)
add $8, $9, 1
sw $8, -112($sp)
lw $8, -112($sp)
lw $9, -116($sp)
sw $8, 0($9)
j label24
label25:
lw $9, -4($sp)
move $8, $9
sw $8, -120($sp)
li $8, 0
sw $8, -124($sp)
lw $8, -124($sp)
lw $9, -120($sp)
sw $8, 0($9)
label32:
lw $9, -4($sp)
lw $8, 0($9)
sw $8, -128($sp)
lw $9, 20($a3)
lw $8, 0($9)
sw $8, -132($sp)
lw $9, -128($sp)
lw $10, -132($sp)
sub $8, $9, $10
sw $8, -132($sp)
lw $8, -132($sp)
bgez $8, label33
lw $9, -4($sp)
lw $8, 0($9)
sw $8, -140($sp)
lw $9, -140($sp)
mul $8, $9, 4
sw $8, -144($sp)
lw $9, 24($a3)
lw $10, -144($sp)
add $8, $9, $10
sw $8, -136($sp)
lw $9, -136($sp)
lw $8, 0($9)
sw $8, -136($sp)
lw $9, -136($sp)
li $8, 1
beqz $9, lnot1
li $8, 0
lnot1:
sw $8, -136($sp)
lw $8, -136($sp)
beqz $8, label35
lw $9, 20($a3)
move $8, $9
sw $8, -148($sp)
lw $9, -4($sp)
lw $8, 0($9)
sw $8, -152($sp)
lw $8, -152($sp)
lw $9, -148($sp)
sw $8, 0($9)
j label33
label35:
label34:
lw $9, -4($sp)
move $8, $9
sw $8, -160($sp)
lw $9, -4($sp)
lw $8, 0($9)
sw $8, -156($sp)
lw $9, -156($sp)
add $8, $9, 1
sw $8, -156($sp)
lw $8, -156($sp)
lw $9, -160($sp)
sw $8, 0($9)
j label32
label33:
jr $ra
__move:
add $8, $29, -80
sw $8, -8($sp)
lw $9, -8($sp)
move $8, $9
sw $8, -4($sp)
li $8, 0
sw $8, -12($sp)
lw $8, -12($sp)
lw $9, -4($sp)
sw $8, 0($9)
label36:
lw $9, -4($sp)
lw $8, 0($9)
sw $8, -16($sp)
lw $9, 20($a3)
lw $8, 0($9)
sw $8, -20($sp)
lw $9, -16($sp)
lw $10, -20($sp)
sub $8, $9, $10
sw $8, -20($sp)
lw $8, -20($sp)
bgez $8, label37
label38:
lw $9, -4($sp)
lw $8, 0($9)
sw $8, -32($sp)
lw $9, -32($sp)
mul $8, $9, 4
sw $8, -36($sp)
lw $9, 24($a3)
lw $10, -36($sp)
add $8, $9, $10
sw $8, -28($sp)
lw $9, -28($sp)
move $8, $9
sw $8, -40($sp)
lw $9, -28($sp)
lw $8, 0($9)
sw $8, -28($sp)
lw $9, -28($sp)
sub $8, $9, 1
sw $8, -28($sp)
lw $8, -28($sp)
lw $9, -40($sp)
sw $8, 0($9)
lw $9, -4($sp)
move $8, $9
sw $8, -24($sp)
lw $9, -4($sp)
lw $8, 0($9)
sw $8, -44($sp)
li $8, 1
sw $8, -48($sp)
lw $9, -44($sp)
lw $10, -48($sp)
add $8, $9, $10
sw $8, -44($sp)
lw $8, -44($sp)
lw $9, -24($sp)
sw $8, 0($9)
j label36
label37:
lw $9, 20($a3)
lw $8, 0($9)
sw $8, -56($sp)
lw $9, -56($sp)
mul $8, $9, 4
sw $8, -60($sp)
lw $9, 24($a3)
lw $10, -60($sp)
add $8, $9, $10
sw $8, -52($sp)
lw $9, 20($a3)
lw $8, 0($9)
sw $8, -64($sp)
lw $8, -64($sp)
lw $9, -52($sp)
sw $8, 0($9)
lw $9, 20($a3)
move $8, $9
sw $8, -72($sp)
lw $9, 20($a3)
lw $8, 0($9)
sw $8, -68($sp)
lw $9, -68($sp)
add $8, $9, 1
sw $8, -76($sp)
lw $8, -76($sp)
lw $9, -72($sp)
sw $8, 0($9)
jr $ra
main:
la $a3, temp
la $t0, var0
sw $t0, 8($a3)
la $t0, var1
sw $t0, 16($a3)
la $t0, var2
sw $t0, 20($a3)
la $t0, var3
sw $t0, 24($a3)
la $t0, var4
sw $t0, 28($a3)
la $t0, var5
sw $t0, 36($a3)
la $t0, var6
sw $t0, 44($a3)
la $t0, var7
sw $t0, 48($a3)
la $t0, var8
sw $t0, 52($a3)
la $t0, var9
sw $t0, 312($a3)
la $t0, var10
sw $t0, 344($a3)
la $t0, var11
sw $t0, 964($a3)
la $t0, var12
sw $t0, 988($a3)
la $t0, var13
sw $t0, 1044($a3)
la $t0, var14
sw $t0, 1228($a3)
la $t0, var15
sw $t0, 1264($a3)
li $8, 210
sw $8, 12($a3)
lw $8, 12($a3)
lw $9, 8($a3)
sw $8, 0($9)
li $8, 48271
sw $8, 32($a3)
lw $8, 32($a3)
lw $9, 28($a3)
sw $8, 0($9)
li $8, 2147483647
sw $8, 40($a3)
lw $8, 40($a3)
lw $9, 36($a3)
sw $8, 0($9)
li $8, 1
sw $8, 56($a3)
lw $8, 56($a3)
lw $9, 52($a3)
sw $8, 0($9)
add $8, $29, -384
sw $8, -8($sp)
lw $9, -8($sp)
move $8, $9
sw $8, -4($sp)
li $8, 0
sw $8, -12($sp)
lw $8, -12($sp)
lw $9, -4($sp)
sw $8, 0($9)
add $8, $29, -388
sw $8, -20($sp)
lw $9, -20($sp)
move $8, $9
sw $8, -16($sp)
li $8, 0
sw $8, -24($sp)
lw $8, -24($sp)
lw $9, -16($sp)
sw $8, 0($9)
add $8, $29, -392
sw $8, -32($sp)
lw $9, -32($sp)
move $8, $9
sw $8, -28($sp)
li $8, 0
sw $8, -36($sp)
lw $8, -36($sp)
lw $9, -28($sp)
sw $8, 0($9)
lw $9, 44($a3)
move $8, $9
sw $8, -44($sp)
lw $9, 36($a3)
lw $8, 0($9)
sw $8, -48($sp)
lw $9, 28($a3)
lw $8, 0($9)
sw $8, -52($sp)
lw $9, -48($sp)
lw $10, -52($sp)
div $8, $9, $10
sw $8, -48($sp)
lw $8, -48($sp)
lw $9, -44($sp)
sw $8, 0($9)
lw $9, 48($a3)
move $8, $9
sw $8, -40($sp)
lw $9, 36($a3)
lw $8, 0($9)
sw $8, -56($sp)
lw $9, 28($a3)
lw $8, 0($9)
sw $8, -60($sp)
lw $9, -56($sp)
lw $10, -60($sp)
rem $8, $9, $10
sw $8, -56($sp)
lw $8, -56($sp)
lw $9, -40($sp)
sw $8, 0($9)
add $8, $29, -404
sw $8, -72($sp)
lw $9, 8($a3)
lw $8, 0($9)
sw $8, -68($sp)
lw $8, -68($sp)
lw $9, -72($sp)
sw $8, 0($9)
add $29, $29, -404
jal __pd
sub $29, $29, -404
add $8, $29, -396
sw $8, -76($sp)
lw $9, -76($sp)
lw $8, 0($9)
sw $8, -64($sp)
lw $9, -64($sp)
li $8, 1
beqz $9, lnot2
li $8, 0
lnot2:
sw $8, -64($sp)
lw $8, -64($sp)
beqz $8, label39
lw $9, 964($a3)
move $8, $9
sw $8, -84($sp)
add $8, $29, -400
sw $8, -88($sp)
lw $8, -84($sp)
lw $9, -88($sp)
sw $8, 0($9)
add $29, $29, -400
jal __printf_single
sub $29, $29, -400
li $8, 1
sw $8, -92($sp)
add $8, $29, 4
sw $8, -96($sp)
lw $8, -92($sp)
lw $9, -96($sp)
sw $8, 0($9)
j __main_end
label39:
lw $9, 988($a3)
move $8, $9
sw $8, -104($sp)
add $8, $29, -400
sw $8, -108($sp)
lw $8, -104($sp)
lw $9, -108($sp)
sw $8, 0($9)
add $29, $29, -400
jal __printf_single
sub $29, $29, -400
li $8, 3654898
sw $8, -116($sp)
add $8, $29, -400
sw $8, -120($sp)
lw $8, -116($sp)
lw $9, -120($sp)
sw $8, 0($9)
add $29, $29, -400
jal __initialize
sub $29, $29, -400
lw $9, 20($a3)
move $8, $9
sw $8, -124($sp)
add $29, $29, -400
jal __random
sub $29, $29, -400
add $8, $29, -396
sw $8, -132($sp)
lw $9, -132($sp)
lw $8, 0($9)
sw $8, -128($sp)
li $8, 10
sw $8, -136($sp)
lw $9, -128($sp)
lw $10, -136($sp)
rem $8, $9, $10
sw $8, -128($sp)
li $8, 1
sw $8, -140($sp)
lw $9, -128($sp)
lw $10, -140($sp)
add $8, $9, $10
sw $8, -128($sp)
lw $8, -128($sp)
lw $9, -124($sp)
sw $8, 0($9)
add $8, $29, -400
sw $8, -152($sp)
lw $9, 20($a3)
lw $8, 0($9)
sw $8, -148($sp)
lw $8, -148($sp)
lw $9, -152($sp)
sw $8, 0($9)
lw $9, 1044($a3)
move $8, $9
sw $8, -156($sp)
add $8, $29, -404
sw $8, -160($sp)
lw $8, -156($sp)
lw $9, -160($sp)
sw $8, 0($9)
add $29, $29, -404
jal __printf
sub $29, $29, -404
label40:
lw $9, -4($sp)
lw $8, 0($9)
sw $8, -164($sp)
lw $9, 20($a3)
lw $8, 0($9)
sw $8, -168($sp)
li $8, 1
sw $8, -172($sp)
lw $9, -168($sp)
lw $10, -172($sp)
sub $8, $9, $10
sw $8, -168($sp)
lw $9, -164($sp)
lw $10, -168($sp)
sub $8, $9, $10
sw $8, -168($sp)
lw $8, -168($sp)
bgez $8, label41
lw $9, -4($sp)
lw $8, 0($9)
sw $8, -180($sp)
lw $9, -180($sp)
mul $8, $9, 4
sw $8, -184($sp)
lw $9, 24($a3)
lw $10, -184($sp)
add $8, $9, $10
sw $8, -176($sp)
add $29, $29, -400
jal __random
sub $29, $29, -400
add $8, $29, -396
sw $8, -192($sp)
lw $9, -192($sp)
lw $8, 0($9)
sw $8, -188($sp)
li $8, 10
sw $8, -196($sp)
lw $9, -188($sp)
lw $10, -196($sp)
rem $8, $9, $10
sw $8, -188($sp)
li $8, 1
sw $8, -200($sp)
lw $9, -188($sp)
lw $10, -200($sp)
add $8, $9, $10
sw $8, -188($sp)
lw $8, -188($sp)
lw $9, -176($sp)
sw $8, 0($9)
label43:
lw $9, -4($sp)
lw $8, 0($9)
sw $8, -208($sp)
lw $9, -208($sp)
mul $8, $9, 4
sw $8, -212($sp)
lw $9, 24($a3)
lw $10, -212($sp)
add $8, $9, $10
sw $8, -204($sp)
lw $9, -204($sp)
lw $8, 0($9)
sw $8, -204($sp)
lw $9, -16($sp)
lw $8, 0($9)
sw $8, -216($sp)
lw $9, -204($sp)
lw $10, -216($sp)
add $8, $9, $10
sw $8, -204($sp)
lw $9, 8($a3)
lw $8, 0($9)
sw $8, -220($sp)
lw $9, -204($sp)
lw $10, -220($sp)
sub $8, $9, $10
sw $8, -220($sp)
lw $8, -220($sp)
blez $8, label44
lw $9, -4($sp)
lw $8, 0($9)
sw $8, -228($sp)
lw $9, -228($sp)
mul $8, $9, 4
sw $8, -232($sp)
lw $9, 24($a3)
lw $10, -232($sp)
add $8, $9, $10
sw $8, -224($sp)
add $29, $29, -400
jal __random
sub $29, $29, -400
add $8, $29, -396
sw $8, -240($sp)
lw $9, -240($sp)
lw $8, 0($9)
sw $8, -236($sp)
li $8, 10
sw $8, -244($sp)
lw $9, -236($sp)
lw $10, -244($sp)
rem $8, $9, $10
sw $8, -236($sp)
li $8, 1
sw $8, -248($sp)
lw $9, -236($sp)
lw $10, -248($sp)
add $8, $9, $10
sw $8, -236($sp)
lw $8, -236($sp)
lw $9, -224($sp)
sw $8, 0($9)
j label43
label44:
lw $9, -16($sp)
move $8, $9
sw $8, -252($sp)
lw $9, -4($sp)
lw $8, 0($9)
sw $8, -260($sp)
lw $9, -260($sp)
mul $8, $9, 4
sw $8, -264($sp)
lw $9, 24($a3)
lw $10, -264($sp)
add $8, $9, $10
sw $8, -256($sp)
lw $9, -16($sp)
lw $8, 0($9)
sw $8, -268($sp)
lw $9, -256($sp)
lw $8, 0($9)
sw $8, -256($sp)
lw $9, -268($sp)
lw $10, -256($sp)
add $8, $9, $10
sw $8, -268($sp)
lw $8, -268($sp)
lw $9, -252($sp)
sw $8, 0($9)
label42:
lw $9, -4($sp)
move $8, $9
sw $8, -276($sp)
lw $9, -4($sp)
lw $8, 0($9)
sw $8, -272($sp)
lw $9, -272($sp)
add $8, $9, 1
sw $8, -272($sp)
lw $8, -272($sp)
lw $9, -276($sp)
sw $8, 0($9)
j label40
label41:
lw $9, 20($a3)
lw $8, 0($9)
sw $8, -284($sp)
li $8, 1
sw $8, -292($sp)
lw $9, -284($sp)
lw $10, -292($sp)
sub $8, $9, $10
sw $8, -284($sp)
lw $9, -284($sp)
mul $8, $9, 4
sw $8, -288($sp)
lw $9, 24($a3)
lw $10, -288($sp)
add $8, $9, $10
sw $8, -280($sp)
lw $9, 8($a3)
lw $8, 0($9)
sw $8, -296($sp)
lw $9, -16($sp)
lw $8, 0($9)
sw $8, -300($sp)
lw $9, -296($sp)
lw $10, -300($sp)
sub $8, $9, $10
sw $8, -296($sp)
lw $8, -296($sp)
lw $9, -280($sp)
sw $8, 0($9)
add $29, $29, -396
jal __show
sub $29, $29, -396
add $29, $29, -396
jal __merge
sub $29, $29, -396
label45:
add $29, $29, -400
jal __win
sub $29, $29, -400
add $8, $29, -396
sw $8, -316($sp)
lw $9, -316($sp)
lw $8, 0($9)
sw $8, -312($sp)
lw $9, -312($sp)
li $8, 1
beqz $9, lnot3
li $8, 0
lnot3:
sw $8, -312($sp)
lw $8, -312($sp)
beqz $8, label46
lw $9, -28($sp)
move $8, $9
sw $8, -328($sp)
lw $9, -28($sp)
lw $8, 0($9)
sw $8, -324($sp)
lw $9, -324($sp)
add $8, $9, 1
sw $8, -324($sp)
lw $8, -324($sp)
lw $9, -328($sp)
sw $8, 0($9)
add $8, $29, -400
sw $8, -332($sp)
lw $8, -324($sp)
lw $9, -332($sp)
sw $8, 0($9)
lw $9, 1228($a3)
move $8, $9
sw $8, -336($sp)
add $8, $29, -404
sw $8, -340($sp)
lw $8, -336($sp)
lw $9, -340($sp)
sw $8, 0($9)
add $29, $29, -404
jal __printf
sub $29, $29, -404
add $29, $29, -396
jal __move
sub $29, $29, -396
add $29, $29, -396
jal __merge
sub $29, $29, -396
add $29, $29, -396
jal __show
sub $29, $29, -396
j label45
label46:
add $8, $29, -400
sw $8, -364($sp)
lw $9, -28($sp)
lw $8, 0($9)
sw $8, -360($sp)
lw $8, -360($sp)
lw $9, -364($sp)
sw $8, 0($9)
lw $9, 1264($a3)
move $8, $9
sw $8, -368($sp)
add $8, $29, -404
sw $8, -372($sp)
lw $8, -368($sp)
lw $9, -372($sp)
sw $8, 0($9)
add $29, $29, -404
jal __printf
sub $29, $29, -404
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
#global $4 4
#global $5 4
#global $6 400
#global $7 4
#global $9 4
#global $11 4
#global $12 4
#global $13 4
#string $78 #%d 
#string $86 #%c
#string $241 #Sorry, the number n must be a number s.t. there exists i satisfying n=1+2+...+i\n
#string $247 #Let's start!\n
#string $261 #%d\n
#string $307 #step %d:\n
#string $316 #Total: %d step(s)\n
#li $3 210
#sw $3 $2 0
#li $8 48271
#sw $8 $7 0
#li $10 2147483647
#sw $10 $9 0
#li $14 1
#sw $14 $13 0
#----------------------------
#func #random
#addi $16 $0 -72
#move $15 $16
####move $17 $7
#lw $17 $7 0
####move $18 $13
#lw $18 $13 0
####move $19 $11
#lw $19 $11 0
#mod $18 $18 $19
#mul $17 $17 $18
####move $20 $12
#lw $20 $12 0
####move $21 $13
#lw $21 $13 0
####move $22 $11
#lw $22 $11 0
#div $21 $21 $22
#mul $20 $20 $21
#sub $17 $17 $20
#sw $17 $15 0
####move $23 $15
#lw $23 $15 0
#li $24 0
#sub $24 $23 $24
#bltz $24 l:0
#move $25 $13
####move $26 $15
#lw $26 $15 0
#sw $26 $25 0
#goto l:1
#label l:0
#move $27 $13
####move $28 $15
#lw $28 $15 0
####move $29 $9
#lw $29 $9 0
#add $28 $28 $29
#sw $28 $27 0
#label l:1
####move $30 $13
#addi $31 $0 4
#lw $30 $13 0
#sw $30 $31 0
#return
#return
#----------------------------
#func #initialize
#addi $32 $0 0
#move $33 $13
####move $34 $32
#lw $34 $32 0
#sw $34 $33 0
#return
#----------------------------
#func #swap
#addi $35 $0 0
#addi $36 $0 4
#addi $38 $0 -72
#move $37 $38
####move $39 $6
####move $40 $35
#lw $40 $35 0
#muli $41 $40 4
#add $39 $6 $41
#lw $39 $39 0
#sw $39 $37 0
####move $42 $6
####move $43 $35
#lw $43 $35 0
#muli $44 $43 4
#add $42 $6 $44
####move $45 $6
####move $46 $36
#lw $46 $36 0
#muli $47 $46 4
#add $45 $6 $47
#lw $45 $45 0
#sw $45 $42 0
####move $48 $6
####move $49 $36
#lw $49 $36 0
#muli $50 $49 4
#add $48 $6 $50
####move $51 $37
#lw $51 $37 0
#sw $51 $48 0
#return
#----------------------------
#func #pd
#addi $52 $0 0
#label l:2
####move $53 $4
#lw $53 $4 0
####move $54 $52
#lw $54 $52 0
#sub $54 $53 $54
#bgtz $54 l:3
####move $55 $52
#lw $55 $52 0
####move $56 $4
#lw $56 $4 0
####move $57 $4
#lw $57 $4 0
#li $58 1
#add $57 $57 $58
#mul $56 $56 $57
#li $59 2
#div $56 $56 $59
#sub $56 $55 $56
#bnez $56 l:5
#li $60 1
#addi $61 $0 8
#sw $60 $61 0
#return
#label l:5
#label l:4
####move $62 $4
#move $63 $4
#lw $62 $4 0
#addi $62 $62 1
#sw $62 $63 0
#goto l:2
#label l:3
#li $64 0
#addi $65 $0 8
#sw $64 $65 0
#return
#return
#----------------------------
#func #show
#addi $67 $0 -84
#move $66 $67
#move $68 $67
#li $69 0
#sw $69 $68 0
#label l:6
####move $70 $66
#lw $70 $66 0
####move $71 $5
#lw $71 $5 0
#sub $71 $70 $71
#bgez $71 l:7
#sw $1 $0 -88
####move $73 $6
####move $74 $66
#lw $74 $66 0
#muli $75 $74 4
#add $73 $6 $75
#addi $76 $0 -92
#lw $73 $73 0
#sw $73 $76 0
#move $77 $78
#addi $79 $0 -96
#sw $77 $79 0
#addi $0 $0 -96
#call #printf
#subi $0 $0 -96
#lw $1 $0 -88
#label l:8
####move $80 $66
#move $81 $66
#lw $80 $66 0
#addi $80 $80 1
#sw $80 $81 0
#goto l:6
#label l:7
#sw $1 $0 -88
#li $83 10
#addi $84 $0 -92
#sw $83 $84 0
#move $85 $86
#addi $87 $0 -96
#sw $85 $87 0
#addi $0 $0 -96
#call #printf
#subi $0 $0 -96
#lw $1 $0 -88
#return
#----------------------------
#func #win
#addi $89 $0 -296
#move $88 $89
#addi $91 $0 -300
#move $90 $91
#li $92 0
#sw $92 $90 0
#addi $94 $0 -700
#move $93 $94
#addi $96 $0 -704
#move $95 $96
####move $97 $5
#lw $97 $5 0
####move $98 $4
#lw $98 $4 0
#sub $98 $97 $98
#beqz $98 l:9
#li $99 0
#addi $100 $0 4
#sw $99 $100 0
#return
#label l:9
#move $101 $90
#label l:10
####move $102 $90
#lw $102 $90 0
####move $103 $5
#lw $103 $5 0
#sub $103 $102 $103
#bgez $103 l:11
####move $104 $93
####move $105 $90
#lw $105 $90 0
#muli $106 $105 4
#add $104 $93 $106
####move $107 $6
####move $108 $90
#lw $108 $90 0
#muli $109 $108 4
#add $107 $6 $109
#lw $107 $107 0
#sw $107 $104 0
#label l:12
####move $110 $90
#move $111 $90
#lw $110 $90 0
#addi $110 $110 1
#sw $110 $111 0
#goto l:10
#label l:11
#move $112 $88
#li $113 0
#sw $113 $112 0
#label l:13
####move $114 $88
#lw $114 $88 0
####move $115 $5
#lw $115 $5 0
#li $116 1
#sub $115 $115 $116
#sub $115 $114 $115
#bgez $115 l:14
#move $117 $90
####move $118 $88
#lw $118 $88 0
#li $119 1
#add $118 $118 $119
#sw $118 $117 0
#label l:16
####move $120 $90
#lw $120 $90 0
####move $121 $5
#lw $121 $5 0
#sub $121 $120 $121
#bgez $121 l:17
####move $122 $93
####move $123 $88
#lw $123 $88 0
#muli $124 $123 4
#add $122 $93 $124
#lw $122 $122 0
####move $125 $93
####move $126 $90
#lw $126 $90 0
#muli $127 $126 4
#add $125 $93 $127
#lw $125 $125 0
#sub $125 $122 $125
#blez $125 l:19
#move $128 $95
####move $129 $93
####move $130 $88
#lw $130 $88 0
#muli $131 $130 4
#add $129 $93 $131
#lw $129 $129 0
#sw $129 $128 0
####move $132 $93
####move $133 $88
#lw $133 $88 0
#muli $134 $133 4
#add $132 $93 $134
####move $135 $93
####move $136 $90
#lw $136 $90 0
#muli $137 $136 4
#add $135 $93 $137
#lw $135 $135 0
#sw $135 $132 0
####move $138 $93
####move $139 $90
#lw $139 $90 0
#muli $140 $139 4
#add $138 $93 $140
####move $141 $95
#lw $141 $95 0
#sw $141 $138 0
#label l:19
#label l:18
####move $142 $90
#move $143 $90
#lw $142 $90 0
#addi $142 $142 1
#sw $142 $143 0
#goto l:16
#label l:17
#label l:15
####move $144 $88
#move $145 $88
#lw $144 $88 0
#addi $144 $144 1
#sw $144 $145 0
#goto l:13
#label l:14
#move $146 $88
#li $147 0
#sw $147 $146 0
#label l:20
####move $148 $88
#lw $148 $88 0
####move $149 $5
#lw $149 $5 0
#sub $149 $148 $149
#bgez $149 l:21
####move $150 $93
####move $151 $88
#lw $151 $88 0
#muli $152 $151 4
#add $150 $93 $152
#lw $150 $150 0
####move $153 $88
#lw $153 $88 0
#li $154 1
#add $153 $153 $154
#sub $153 $150 $153
#beqz $153 l:23
#li $155 0
#addi $156 $0 4
#sw $155 $156 0
#return
#label l:23
#label l:22
####move $157 $88
#move $158 $88
#lw $157 $88 0
#addi $157 $157 1
#sw $157 $158 0
#goto l:20
#label l:21
#li $159 1
#addi $160 $0 4
#sw $159 $160 0
#return
#return
#----------------------------
#func #merge
#addi $162 $0 -164
#move $161 $162
#li $163 0
#sw $163 $161 0
#move $164 $161
#label l:24
####move $165 $161
#lw $165 $161 0
####move $166 $5
#lw $166 $5 0
#sub $166 $165 $166
#bgez $166 l:25
####move $167 $6
####move $168 $161
#lw $168 $161 0
#muli $169 $168 4
#add $167 $6 $169
#lw $167 $167 0
#lnot $167 $167
#beqz $167 l:27
#addi $171 $0 -168
#move $170 $171
#move $172 $171
####move $173 $161
#lw $173 $161 0
#li $174 1
#add $173 $173 $174
#sw $173 $172 0
#label l:28
####move $175 $170
#lw $175 $170 0
####move $176 $5
#lw $176 $5 0
#sub $176 $175 $176
#bgez $176 l:29
####move $177 $6
####move $178 $170
#lw $178 $170 0
#muli $179 $178 4
#add $177 $6 $179
#lw $177 $177 0
#li $180 0
#sub $180 $177 $180
#beqz $180 l:31
#sw $1 $0 -172
####move $182 $170
#addi $183 $0 -176
#lw $182 $170 0
#sw $182 $183 0
####move $184 $161
#addi $185 $0 -180
#lw $184 $161 0
#sw $184 $185 0
#addi $0 $0 -180
#call #swap
#subi $0 $0 -180
#lw $1 $0 -172
#goto l:29
#label l:31
#label l:30
####move $186 $170
#move $187 $170
#lw $186 $170 0
#addi $186 $186 1
#sw $186 $187 0
#goto l:28
#label l:29
#label l:27
#label l:26
####move $188 $161
#move $189 $161
#lw $188 $161 0
#addi $188 $188 1
#sw $188 $189 0
#goto l:24
#label l:25
#move $190 $161
#li $191 0
#sw $191 $190 0
#label l:32
####move $192 $161
#lw $192 $161 0
####move $193 $5
#lw $193 $5 0
#sub $193 $192 $193
#bgez $193 l:33
####move $194 $6
####move $195 $161
#lw $195 $161 0
#muli $196 $195 4
#add $194 $6 $196
#lw $194 $194 0
#lnot $194 $194
#beqz $194 l:35
#move $197 $5
####move $198 $161
#lw $198 $161 0
#sw $198 $197 0
#goto l:33
#label l:35
#label l:34
####move $199 $161
#move $200 $161
#lw $199 $161 0
#addi $199 $199 1
#sw $199 $200 0
#goto l:32
#label l:33
#return
#----------------------------
#func #move
#addi $202 $0 -80
#move $201 $202
#li $203 0
#sw $203 $201 0
#label l:36
####move $204 $201
#lw $204 $201 0
####move $205 $5
#lw $205 $5 0
#sub $205 $204 $205
#bgez $205 l:37
#label l:38
####move $207 $6
####move $208 $201
#lw $208 $201 0
#muli $209 $208 4
#add $207 $6 $209
#move $210 $207
#lw $207 $207 0
#subi $207 $207 1
#sw $207 $210 0
#move $206 $201
####move $211 $201
#lw $211 $201 0
#li $212 1
#add $211 $211 $212
#sw $211 $206 0
#goto l:36
#label l:37
####move $213 $6
####move $214 $5
#lw $214 $5 0
#muli $215 $214 4
#add $213 $6 $215
####move $216 $5
#lw $216 $5 0
#sw $216 $213 0
####move $217 $5
#move $218 $5
#lw $217 $5 0
#addi $219 $217 1
#sw $219 $218 0
#return
#----------------------------
#func #main
#addi $221 $0 -384
#move $220 $221
#li $222 0
#sw $222 $220 0
#addi $224 $0 -388
#move $223 $224
#li $225 0
#sw $225 $223 0
#addi $227 $0 -392
#move $226 $227
#li $228 0
#sw $228 $226 0
#move $230 $11
####move $231 $9
#lw $231 $9 0
####move $232 $7
#lw $232 $7 0
#div $231 $231 $232
#sw $231 $230 0
#move $229 $12
####move $233 $9
#lw $233 $9 0
####move $234 $7
#lw $234 $7 0
#mod $233 $233 $234
#sw $233 $229 0
####move $236 $2
#addi $237 $0 -404
#lw $236 $2 0
#sw $236 $237 0
#addi $0 $0 -404
#call #pd
#subi $0 $0 -404
#addi $238 $0 -396
####move $235 $238
#lw $235 $238 0
#lnot $235 $235
#beqz $235 l:39
#move $240 $241
#addi $242 $0 -400
#sw $240 $242 0
#addi $0 $0 -400
#call #printf_single
#subi $0 $0 -400
#li $243 1
#addi $244 $0 4
#sw $243 $244 0
#return
#label l:39
#move $246 $247
#addi $248 $0 -400
#sw $246 $248 0
#addi $0 $0 -400
#call #printf_single
#subi $0 $0 -400
#li $250 3654898
#addi $251 $0 -400
#sw $250 $251 0
#addi $0 $0 -400
#call #initialize
#subi $0 $0 -400
#move $252 $5
#addi $0 $0 -400
#call #random
#subi $0 $0 -400
#addi $254 $0 -396
####move $253 $254
#lw $253 $254 0
#li $255 10
#mod $253 $253 $255
#li $256 1
#add $253 $253 $256
#sw $253 $252 0
####move $258 $5
#addi $259 $0 -400
#lw $258 $5 0
#sw $258 $259 0
#move $260 $261
#addi $262 $0 -404
#sw $260 $262 0
#addi $0 $0 -404
#call #printf
#subi $0 $0 -404
#label l:40
####move $263 $220
#lw $263 $220 0
####move $264 $5
#lw $264 $5 0
#li $265 1
#sub $264 $264 $265
#sub $264 $263 $264
#bgez $264 l:41
####move $266 $6
####move $267 $220
#lw $267 $220 0
#muli $268 $267 4
#add $266 $6 $268
#addi $0 $0 -400
#call #random
#subi $0 $0 -400
#addi $270 $0 -396
####move $269 $270
#lw $269 $270 0
#li $271 10
#mod $269 $269 $271
#li $272 1
#add $269 $269 $272
#sw $269 $266 0
#label l:43
####move $273 $6
####move $274 $220
#lw $274 $220 0
#muli $275 $274 4
#add $273 $6 $275
#lw $273 $273 0
####move $276 $223
#lw $276 $223 0
#add $273 $273 $276
####move $277 $2
#lw $277 $2 0
#sub $277 $273 $277
#blez $277 l:44
####move $278 $6
####move $279 $220
#lw $279 $220 0
#muli $280 $279 4
#add $278 $6 $280
#addi $0 $0 -400
#call #random
#subi $0 $0 -400
#addi $282 $0 -396
####move $281 $282
#lw $281 $282 0
#li $283 10
#mod $281 $281 $283
#li $284 1
#add $281 $281 $284
#sw $281 $278 0
#goto l:43
#label l:44
#move $285 $223
####move $286 $6
####move $287 $220
#lw $287 $220 0
#muli $288 $287 4
#add $286 $6 $288
#lw $289 $223 0
#lw $286 $286 0
#add $289 $289 $286
#sw $289 $285 0
#label l:42
####move $290 $220
#move $291 $220
#lw $290 $220 0
#addi $290 $290 1
#sw $290 $291 0
#goto l:40
#label l:41
####move $292 $6
####move $293 $5
#lw $293 $5 0
#li $295 1
#sub $293 $293 $295
#muli $294 $293 4
#add $292 $6 $294
####move $296 $2
#lw $296 $2 0
####move $297 $223
#lw $297 $223 0
#sub $296 $296 $297
#sw $296 $292 0
#addi $0 $0 -396
#call #show
#subi $0 $0 -396
#addi $0 $0 -396
#call #merge
#subi $0 $0 -396
#label l:45
#addi $0 $0 -400
#call #win
#subi $0 $0 -400
#addi $301 $0 -396
####move $300 $301
#lw $300 $301 0
#lnot $300 $300
#beqz $300 l:46
####move $303 $226
#move $304 $226
#lw $303 $226 0
#addi $303 $303 1
#sw $303 $304 0
#addi $305 $0 -400
#sw $303 $305 0
#move $306 $307
#addi $308 $0 -404
#sw $306 $308 0
#addi $0 $0 -404
#call #printf
#subi $0 $0 -404
#addi $0 $0 -396
#call #move
#subi $0 $0 -396
#addi $0 $0 -396
#call #merge
#subi $0 $0 -396
#addi $0 $0 -396
#call #show
#subi $0 $0 -396
#goto l:45
#label l:46
####move $313 $226
#addi $314 $0 -400
#lw $313 $226 0
#sw $313 $314 0
#move $315 $316
#addi $317 $0 -404
#sw $315 $317 0
#addi $0 $0 -404
#call #printf
#subi $0 $0 -404
#li $318 0
#addi $319 $0 4
#sw $318 $319 0
#return
#return
