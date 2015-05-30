.data
temp: .space 2388
var0: .space 40000
var1: .space 40000
var2: .space 40000
var3: .space 40000
var4: .space 120000
var5: .space 120000
var6: .asciiz "%d "
.align 2
var7: .asciiz "\n"
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

__F:
add $8, $29, 0
sw $8, -4($sp)
add $8, $29, 4
sw $8, -8($sp)
lw $9, -4($sp)
lw $8, 0($9)
sw $8, -12($sp)
li $8, 3
sw $8, -16($sp)
lw $9, -12($sp)
lw $10, -16($sp)
rem $8, $9, $10
sw $8, -12($sp)
li $8, 1
sw $8, -20($sp)
lw $9, -12($sp)
lw $10, -20($sp)
sub $8, $9, $10
sw $8, -20($sp)
lw $8, -20($sp)
bnez $8, label0
lw $9, -4($sp)
lw $8, 0($9)
sw $8, -24($sp)
li $8, 3
sw $8, -28($sp)
lw $9, -24($sp)
lw $10, -28($sp)
div $8, $9, $10
sw $8, -24($sp)
add $8, $29, 12
sw $8, -32($sp)
lw $8, -24($sp)
lw $9, -32($sp)
sw $8, 0($9)
jr $ra
j label1
label0:
lw $9, -4($sp)
lw $8, 0($9)
sw $8, -36($sp)
li $8, 3
sw $8, -40($sp)
lw $9, -36($sp)
lw $10, -40($sp)
div $8, $9, $10
sw $8, -36($sp)
lw $9, -8($sp)
lw $8, 0($9)
sw $8, -44($sp)
lw $9, -36($sp)
lw $10, -44($sp)
add $8, $9, $10
sw $8, -36($sp)
add $8, $29, 12
sw $8, -48($sp)
lw $8, -36($sp)
lw $9, -48($sp)
sw $8, 0($9)
jr $ra
label1:
jr $ra
__G:
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
bgez $8, label2
lw $9, -4($sp)
lw $8, 0($9)
sw $8, -20($sp)
li $8, 3
sw $8, -24($sp)
lw $9, -20($sp)
lw $10, -24($sp)
mul $8, $9, $10
sw $8, -20($sp)
li $8, 1
sw $8, -28($sp)
lw $9, -20($sp)
lw $10, -28($sp)
add $8, $9, $10
sw $8, -20($sp)
add $8, $29, 12
sw $8, -32($sp)
lw $8, -20($sp)
lw $9, -32($sp)
sw $8, 0($9)
jr $ra
j label3
label2:
lw $9, -4($sp)
lw $8, 0($9)
sw $8, -36($sp)
lw $9, -8($sp)
lw $8, 0($9)
sw $8, -40($sp)
lw $9, -36($sp)
lw $10, -40($sp)
sub $8, $9, $10
sw $8, -36($sp)
li $8, 3
sw $8, -44($sp)
lw $9, -36($sp)
lw $10, -44($sp)
mul $8, $9, $10
sw $8, -36($sp)
li $8, 2
sw $8, -48($sp)
lw $9, -36($sp)
lw $10, -48($sp)
add $8, $9, $10
sw $8, -36($sp)
add $8, $29, 12
sw $8, -52($sp)
lw $8, -36($sp)
lw $9, -52($sp)
sw $8, 0($9)
jr $ra
label3:
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
blez $8, label4
add $8, $29, 12
sw $8, -24($sp)
lw $9, -4($sp)
lw $8, 0($9)
sw $8, -20($sp)
lw $8, -20($sp)
lw $9, -24($sp)
sw $8, 0($9)
jr $ra
j label5
label4:
add $8, $29, 12
sw $8, -32($sp)
lw $9, -8($sp)
lw $8, 0($9)
sw $8, -28($sp)
lw $8, -28($sp)
lw $9, -32($sp)
sw $8, 0($9)
jr $ra
label5:
jr $ra
__c0:
add $8, $29, 0
sw $8, -4($sp)
add $8, $29, 4
sw $8, -8($sp)
add $8, $29, 8
sw $8, -12($sp)
lw $9, -4($sp)
lw $8, 0($9)
sw $8, -16($sp)
lw $9, -8($sp)
lw $8, 0($9)
sw $8, -20($sp)
lw $9, -20($sp)
mul $8, $9, 4
sw $8, -24($sp)
lw $9, -16($sp)
lw $10, -24($sp)
add $8, $9, $10
sw $8, -16($sp)
lw $9, -16($sp)
lw $8, 0($9)
sw $8, -16($sp)
lw $9, -4($sp)
lw $8, 0($9)
sw $8, -28($sp)
lw $9, -12($sp)
lw $8, 0($9)
sw $8, -32($sp)
lw $9, -32($sp)
mul $8, $9, 4
sw $8, -36($sp)
lw $9, -28($sp)
lw $10, -36($sp)
add $8, $9, $10
sw $8, -28($sp)
lw $9, -28($sp)
lw $8, 0($9)
sw $8, -28($sp)
lw $9, -16($sp)
lw $10, -28($sp)
sub $8, $9, $10
sw $8, -28($sp)
li $8, 1
sw $8, -16($sp)
lw $8, -28($sp)
beqz $8, label6
li $8, 0
sw $8, -16($sp)
label6:
lw $8, -16($sp)
beqz $8, label7
lw $9, -4($sp)
lw $8, 0($9)
sw $8, -16($sp)
lw $9, -8($sp)
lw $8, 0($9)
sw $8, -40($sp)
li $8, 1
sw $8, -48($sp)
lw $9, -40($sp)
lw $10, -48($sp)
add $8, $9, $10
sw $8, -40($sp)
lw $9, -40($sp)
mul $8, $9, 4
sw $8, -44($sp)
lw $9, -16($sp)
lw $10, -44($sp)
add $8, $9, $10
sw $8, -16($sp)
lw $9, -16($sp)
lw $8, 0($9)
sw $8, -16($sp)
lw $9, -4($sp)
lw $8, 0($9)
sw $8, -52($sp)
lw $9, -12($sp)
lw $8, 0($9)
sw $8, -56($sp)
li $8, 1
sw $8, -64($sp)
lw $9, -56($sp)
lw $10, -64($sp)
add $8, $9, $10
sw $8, -56($sp)
lw $9, -56($sp)
mul $8, $9, 4
sw $8, -60($sp)
lw $9, -52($sp)
lw $10, -60($sp)
add $8, $9, $10
sw $8, -52($sp)
lw $9, -52($sp)
lw $8, 0($9)
sw $8, -52($sp)
lw $9, -16($sp)
lw $10, -52($sp)
sub $8, $9, $10
sw $8, -52($sp)
li $8, 1
sw $8, -16($sp)
lw $8, -52($sp)
beqz $8, label8
li $8, 0
sw $8, -16($sp)
label8:
label7:
lw $9, -16($sp)
andi $8, $9, 1
sw $8, -16($sp)
lw $8, -16($sp)
beqz $8, label9
lw $9, -4($sp)
lw $8, 0($9)
sw $8, -16($sp)
lw $9, -8($sp)
lw $8, 0($9)
sw $8, -68($sp)
li $8, 2
sw $8, -76($sp)
lw $9, -68($sp)
lw $10, -76($sp)
add $8, $9, $10
sw $8, -68($sp)
lw $9, -68($sp)
mul $8, $9, 4
sw $8, -72($sp)
lw $9, -16($sp)
lw $10, -72($sp)
add $8, $9, $10
sw $8, -16($sp)
lw $9, -16($sp)
lw $8, 0($9)
sw $8, -16($sp)
lw $9, -4($sp)
lw $8, 0($9)
sw $8, -80($sp)
lw $9, -12($sp)
lw $8, 0($9)
sw $8, -84($sp)
li $8, 2
sw $8, -92($sp)
lw $9, -84($sp)
lw $10, -92($sp)
add $8, $9, $10
sw $8, -84($sp)
lw $9, -84($sp)
mul $8, $9, 4
sw $8, -88($sp)
lw $9, -80($sp)
lw $10, -88($sp)
add $8, $9, $10
sw $8, -80($sp)
lw $9, -80($sp)
lw $8, 0($9)
sw $8, -80($sp)
lw $9, -16($sp)
lw $10, -80($sp)
sub $8, $9, $10
sw $8, -80($sp)
li $8, 1
sw $8, -16($sp)
lw $8, -80($sp)
beqz $8, label10
li $8, 0
sw $8, -16($sp)
label10:
label9:
lw $9, -16($sp)
andi $8, $9, 1
sw $8, -16($sp)
add $8, $29, 16
sw $8, -96($sp)
lw $8, -16($sp)
lw $9, -96($sp)
sw $8, 0($9)
jr $ra
jr $ra
__c12:
add $8, $29, 0
sw $8, -4($sp)
add $8, $29, 4
sw $8, -8($sp)
add $8, $29, 8
sw $8, -12($sp)
add $8, $29, 12
sw $8, -16($sp)
lw $9, -4($sp)
lw $8, 0($9)
sw $8, -20($sp)
li $8, 2
sw $8, -24($sp)
lw $9, -20($sp)
lw $10, -24($sp)
sub $8, $9, $10
sw $8, -24($sp)
lw $8, -24($sp)
bnez $8, label11
lw $9, -8($sp)
lw $8, 0($9)
sw $8, -28($sp)
lw $9, -12($sp)
lw $8, 0($9)
sw $8, -32($sp)
lw $9, -32($sp)
mul $8, $9, 4
sw $8, -36($sp)
lw $9, -28($sp)
lw $10, -36($sp)
add $8, $9, $10
sw $8, -28($sp)
lw $9, -28($sp)
lw $8, 0($9)
sw $8, -28($sp)
lw $9, -8($sp)
lw $8, 0($9)
sw $8, -40($sp)
lw $9, -16($sp)
lw $8, 0($9)
sw $8, -44($sp)
lw $9, -44($sp)
mul $8, $9, 4
sw $8, -48($sp)
lw $9, -40($sp)
lw $10, -48($sp)
add $8, $9, $10
sw $8, -40($sp)
lw $9, -40($sp)
lw $8, 0($9)
sw $8, -40($sp)
lw $9, -28($sp)
lw $10, -40($sp)
sub $8, $9, $10
sw $8, -40($sp)
li $8, 1
sw $8, -28($sp)
lw $8, -40($sp)
bltz $8, label13
li $8, 0
sw $8, -28($sp)
label13:
lw $8, -28($sp)
bnez $8, label14
lw $9, -8($sp)
lw $8, 0($9)
sw $8, -28($sp)
lw $9, -12($sp)
lw $8, 0($9)
sw $8, -52($sp)
lw $9, -52($sp)
mul $8, $9, 4
sw $8, -56($sp)
lw $9, -28($sp)
lw $10, -56($sp)
add $8, $9, $10
sw $8, -28($sp)
lw $9, -28($sp)
lw $8, 0($9)
sw $8, -28($sp)
lw $9, -8($sp)
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
lw $9, -60($sp)
lw $8, 0($9)
sw $8, -60($sp)
lw $9, -28($sp)
lw $10, -60($sp)
sub $8, $9, $10
sw $8, -60($sp)
li $8, 1
sw $8, -28($sp)
lw $8, -60($sp)
beqz $8, label15
li $8, 0
sw $8, -28($sp)
label15:
lw $8, -28($sp)
beqz $8, label16
sw $31, -200($29)
lw $9, -16($sp)
lw $8, 0($9)
sw $8, -72($sp)
li $8, 1
sw $8, -76($sp)
lw $9, -72($sp)
lw $10, -76($sp)
add $8, $9, $10
sw $8, -72($sp)
add $8, $29, -204
sw $8, -80($sp)
lw $8, -72($sp)
lw $9, -80($sp)
sw $8, 0($9)
lw $9, -12($sp)
lw $8, 0($9)
sw $8, -84($sp)
li $8, 1
sw $8, -88($sp)
lw $9, -84($sp)
lw $10, -88($sp)
add $8, $9, $10
sw $8, -84($sp)
add $8, $29, -208
sw $8, -92($sp)
lw $8, -84($sp)
lw $9, -92($sp)
sw $8, 0($9)
add $8, $29, -212
sw $8, -100($sp)
lw $9, -8($sp)
lw $8, 0($9)
sw $8, -96($sp)
lw $8, -96($sp)
lw $9, -100($sp)
sw $8, 0($9)
li $8, 1
sw $8, -104($sp)
add $8, $29, -216
sw $8, -108($sp)
lw $8, -104($sp)
lw $9, -108($sp)
sw $8, 0($9)
add $29, $29, -216
jal __c12
sub $29, $29, -216
lw $31, -200($29)
add $8, $29, -196
sw $8, -112($sp)
lw $9, -112($sp)
lw $8, 0($9)
sw $8, -28($sp)
label16:
lw $9, -28($sp)
andi $8, $9, 1
sw $8, -28($sp)
label14:
lw $9, -28($sp)
andi $8, $9, 1
sw $8, -28($sp)
add $8, $29, 20
sw $8, -116($sp)
lw $8, -28($sp)
lw $9, -116($sp)
sw $8, 0($9)
jr $ra
j label12
label11:
lw $9, -8($sp)
lw $8, 0($9)
sw $8, -120($sp)
lw $9, -12($sp)
lw $8, 0($9)
sw $8, -124($sp)
lw $9, -124($sp)
mul $8, $9, 4
sw $8, -128($sp)
lw $9, -120($sp)
lw $10, -128($sp)
add $8, $9, $10
sw $8, -120($sp)
lw $9, -120($sp)
lw $8, 0($9)
sw $8, -120($sp)
lw $9, -8($sp)
lw $8, 0($9)
sw $8, -132($sp)
lw $9, -16($sp)
lw $8, 0($9)
sw $8, -136($sp)
lw $9, -136($sp)
mul $8, $9, 4
sw $8, -140($sp)
lw $9, -132($sp)
lw $10, -140($sp)
add $8, $9, $10
sw $8, -132($sp)
lw $9, -132($sp)
lw $8, 0($9)
sw $8, -132($sp)
lw $9, -120($sp)
lw $10, -132($sp)
sub $8, $9, $10
sw $8, -132($sp)
li $8, 1
sw $8, -120($sp)
lw $8, -132($sp)
bltz $8, label17
li $8, 0
sw $8, -120($sp)
label17:
lw $8, -120($sp)
bnez $8, label18
lw $9, -8($sp)
lw $8, 0($9)
sw $8, -120($sp)
lw $9, -12($sp)
lw $8, 0($9)
sw $8, -144($sp)
lw $9, -144($sp)
mul $8, $9, 4
sw $8, -148($sp)
lw $9, -120($sp)
lw $10, -148($sp)
add $8, $9, $10
sw $8, -120($sp)
lw $9, -120($sp)
lw $8, 0($9)
sw $8, -120($sp)
lw $9, -8($sp)
lw $8, 0($9)
sw $8, -152($sp)
lw $9, -16($sp)
lw $8, 0($9)
sw $8, -156($sp)
lw $9, -156($sp)
mul $8, $9, 4
sw $8, -160($sp)
lw $9, -152($sp)
lw $10, -160($sp)
add $8, $9, $10
sw $8, -152($sp)
lw $9, -152($sp)
lw $8, 0($9)
sw $8, -152($sp)
lw $9, -120($sp)
lw $10, -152($sp)
sub $8, $9, $10
sw $8, -152($sp)
li $8, 1
sw $8, -120($sp)
lw $8, -152($sp)
beqz $8, label19
li $8, 0
sw $8, -120($sp)
label19:
lw $8, -120($sp)
beqz $8, label20
lw $9, -12($sp)
lw $8, 0($9)
sw $8, -164($sp)
li $8, 1
sw $8, -172($sp)
lw $9, -164($sp)
lw $10, -172($sp)
add $8, $9, $10
sw $8, -164($sp)
lw $9, -164($sp)
mul $8, $9, 4
sw $8, -168($sp)
lw $9, 148($a3)
lw $10, -168($sp)
add $8, $9, $10
sw $8, -120($sp)
lw $9, -120($sp)
lw $8, 0($9)
sw $8, -120($sp)
lw $9, -16($sp)
lw $8, 0($9)
sw $8, -180($sp)
li $8, 1
sw $8, -188($sp)
lw $9, -180($sp)
lw $10, -188($sp)
add $8, $9, $10
sw $8, -180($sp)
lw $9, -180($sp)
mul $8, $9, 4
sw $8, -184($sp)
lw $9, 148($a3)
lw $10, -184($sp)
add $8, $9, $10
sw $8, -176($sp)
lw $9, -176($sp)
lw $8, 0($9)
sw $8, -176($sp)
lw $9, -120($sp)
lw $10, -176($sp)
sub $8, $9, $10
sw $8, -176($sp)
li $8, 1
sw $8, -120($sp)
lw $8, -176($sp)
bltz $8, label21
li $8, 0
sw $8, -120($sp)
label21:
label20:
lw $9, -120($sp)
andi $8, $9, 1
sw $8, -120($sp)
label18:
lw $9, -120($sp)
andi $8, $9, 1
sw $8, -120($sp)
add $8, $29, 20
sw $8, -192($sp)
lw $8, -120($sp)
lw $9, -192($sp)
sw $8, 0($9)
jr $ra
label12:
jr $ra
__sort:
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
add $8, $29, -328
sw $8, -28($sp)
lw $9, -28($sp)
move $8, $9
sw $8, -24($sp)
lw $9, -28($sp)
move $8, $9
sw $8, -32($sp)
li $8, 0
sw $8, -36($sp)
lw $8, -36($sp)
lw $9, -32($sp)
sw $8, 0($9)
label22:
lw $9, -24($sp)
lw $8, 0($9)
sw $8, -40($sp)
lw $9, -16($sp)
lw $8, 0($9)
sw $8, -44($sp)
lw $9, -40($sp)
lw $10, -44($sp)
sub $8, $9, $10
sw $8, -44($sp)
lw $8, -44($sp)
bgez $8, label23
lw $9, -24($sp)
lw $8, 0($9)
sw $8, -52($sp)
lw $9, -52($sp)
mul $8, $9, 4
sw $8, -56($sp)
lw $9, 148($a3)
lw $10, -56($sp)
add $8, $9, $10
sw $8, -48($sp)
lw $9, -4($sp)
lw $8, 0($9)
sw $8, -60($sp)
lw $9, -8($sp)
lw $8, 0($9)
sw $8, -64($sp)
lw $9, -24($sp)
lw $8, 0($9)
sw $8, -72($sp)
lw $9, -72($sp)
mul $8, $9, 4
sw $8, -76($sp)
lw $9, -64($sp)
lw $10, -76($sp)
add $8, $9, $10
sw $8, -64($sp)
lw $9, -64($sp)
lw $8, 0($9)
sw $8, -64($sp)
lw $9, -64($sp)
mul $8, $9, 4
sw $8, -68($sp)
lw $9, -60($sp)
lw $10, -68($sp)
add $8, $9, $10
sw $8, -60($sp)
lw $9, -60($sp)
lw $8, 0($9)
sw $8, -60($sp)
lw $8, -60($sp)
lw $9, -48($sp)
sw $8, 0($9)
label24:
lw $9, -24($sp)
move $8, $9
sw $8, -84($sp)
lw $9, -24($sp)
lw $8, 0($9)
sw $8, -80($sp)
lw $9, -80($sp)
add $8, $9, 1
sw $8, -88($sp)
lw $8, -88($sp)
lw $9, -84($sp)
sw $8, 0($9)
j label22
label23:
lw $9, -24($sp)
move $8, $9
sw $8, -92($sp)
li $8, 0
sw $8, -96($sp)
lw $8, -96($sp)
lw $9, -92($sp)
sw $8, 0($9)
label25:
lw $9, -24($sp)
lw $8, 0($9)
sw $8, -100($sp)
lw $9, -20($sp)
lw $8, 0($9)
sw $8, -104($sp)
lw $9, -100($sp)
lw $10, -104($sp)
sub $8, $9, $10
sw $8, -104($sp)
lw $8, -104($sp)
bgez $8, label26
lw $9, -24($sp)
lw $8, 0($9)
sw $8, -112($sp)
lw $9, -112($sp)
mul $8, $9, 4
sw $8, -116($sp)
lw $9, 152($a3)
lw $10, -116($sp)
add $8, $9, $10
sw $8, -108($sp)
li $8, 0
sw $8, -120($sp)
lw $8, -120($sp)
lw $9, -108($sp)
sw $8, 0($9)
label27:
lw $9, -24($sp)
move $8, $9
sw $8, -128($sp)
lw $9, -24($sp)
lw $8, 0($9)
sw $8, -124($sp)
lw $9, -124($sp)
add $8, $9, 1
sw $8, -132($sp)
lw $8, -132($sp)
lw $9, -128($sp)
sw $8, 0($9)
j label25
label26:
lw $9, -24($sp)
move $8, $9
sw $8, -136($sp)
li $8, 0
sw $8, -140($sp)
lw $8, -140($sp)
lw $9, -136($sp)
sw $8, 0($9)
label28:
lw $9, -24($sp)
lw $8, 0($9)
sw $8, -144($sp)
lw $9, -16($sp)
lw $8, 0($9)
sw $8, -148($sp)
lw $9, -144($sp)
lw $10, -148($sp)
sub $8, $9, $10
sw $8, -148($sp)
lw $8, -148($sp)
bgez $8, label29
lw $9, -24($sp)
lw $8, 0($9)
sw $8, -164($sp)
lw $9, -164($sp)
mul $8, $9, 4
sw $8, -168($sp)
lw $9, 148($a3)
lw $10, -168($sp)
add $8, $9, $10
sw $8, -156($sp)
lw $9, -156($sp)
lw $8, 0($9)
sw $8, -156($sp)
lw $9, -156($sp)
mul $8, $9, 4
sw $8, -160($sp)
lw $9, 152($a3)
lw $10, -160($sp)
add $8, $9, $10
sw $8, -152($sp)
lw $9, -152($sp)
move $8, $9
sw $8, -172($sp)
lw $9, -152($sp)
lw $8, 0($9)
sw $8, -152($sp)
lw $9, -152($sp)
add $8, $9, 1
sw $8, -176($sp)
lw $8, -176($sp)
lw $9, -172($sp)
sw $8, 0($9)
label30:
lw $9, -24($sp)
move $8, $9
sw $8, -184($sp)
lw $9, -24($sp)
lw $8, 0($9)
sw $8, -180($sp)
lw $9, -180($sp)
add $8, $9, 1
sw $8, -188($sp)
lw $8, -188($sp)
lw $9, -184($sp)
sw $8, 0($9)
j label28
label29:
lw $9, -24($sp)
move $8, $9
sw $8, -192($sp)
li $8, 1
sw $8, -196($sp)
lw $8, -196($sp)
lw $9, -192($sp)
sw $8, 0($9)
label31:
lw $9, -24($sp)
lw $8, 0($9)
sw $8, -200($sp)
lw $9, -20($sp)
lw $8, 0($9)
sw $8, -204($sp)
lw $9, -200($sp)
lw $10, -204($sp)
sub $8, $9, $10
sw $8, -204($sp)
lw $8, -204($sp)
bgez $8, label32
lw $9, -24($sp)
lw $8, 0($9)
sw $8, -212($sp)
lw $9, -212($sp)
mul $8, $9, 4
sw $8, -216($sp)
lw $9, 152($a3)
lw $10, -216($sp)
add $8, $9, $10
sw $8, -208($sp)
lw $9, -24($sp)
lw $8, 0($9)
sw $8, -224($sp)
li $8, 1
sw $8, -232($sp)
lw $9, -224($sp)
lw $10, -232($sp)
sub $8, $9, $10
sw $8, -224($sp)
lw $9, -224($sp)
mul $8, $9, 4
sw $8, -228($sp)
lw $9, 152($a3)
lw $10, -228($sp)
add $8, $9, $10
sw $8, -220($sp)
lw $9, -208($sp)
lw $8, 0($9)
sw $8, -236($sp)
lw $9, -220($sp)
lw $8, 0($9)
sw $8, -220($sp)
lw $9, -236($sp)
lw $10, -220($sp)
add $8, $9, $10
sw $8, -236($sp)
lw $8, -236($sp)
lw $9, -208($sp)
sw $8, 0($9)
label33:
lw $9, -24($sp)
move $8, $9
sw $8, -244($sp)
lw $9, -24($sp)
lw $8, 0($9)
sw $8, -240($sp)
lw $9, -240($sp)
add $8, $9, 1
sw $8, -248($sp)
lw $8, -248($sp)
lw $9, -244($sp)
sw $8, 0($9)
j label31
label32:
lw $9, -24($sp)
move $8, $9
sw $8, -252($sp)
lw $9, -16($sp)
lw $8, 0($9)
sw $8, -256($sp)
li $8, 1
sw $8, -260($sp)
lw $9, -256($sp)
lw $10, -260($sp)
sub $8, $9, $10
sw $8, -256($sp)
lw $8, -256($sp)
lw $9, -252($sp)
sw $8, 0($9)
label34:
lw $9, -24($sp)
lw $8, 0($9)
sw $8, -264($sp)
li $8, 0
sw $8, -268($sp)
lw $9, -264($sp)
lw $10, -268($sp)
sub $8, $9, $10
sw $8, -268($sp)
lw $8, -268($sp)
bltz $8, label35
lw $9, -12($sp)
lw $8, 0($9)
sw $8, -272($sp)
lw $9, -24($sp)
lw $8, 0($9)
sw $8, -292($sp)
lw $9, -292($sp)
mul $8, $9, 4
sw $8, -296($sp)
lw $9, 148($a3)
lw $10, -296($sp)
add $8, $9, $10
sw $8, -284($sp)
lw $9, -284($sp)
lw $8, 0($9)
sw $8, -284($sp)
lw $9, -284($sp)
mul $8, $9, 4
sw $8, -288($sp)
lw $9, 152($a3)
lw $10, -288($sp)
add $8, $9, $10
sw $8, -276($sp)
lw $9, -276($sp)
move $8, $9
sw $8, -300($sp)
lw $9, -276($sp)
lw $8, 0($9)
sw $8, -276($sp)
lw $9, -276($sp)
sub $8, $9, 1
sw $8, -276($sp)
lw $8, -276($sp)
lw $9, -300($sp)
sw $8, 0($9)
lw $9, -276($sp)
mul $8, $9, 4
sw $8, -280($sp)
lw $9, -272($sp)
lw $10, -280($sp)
add $8, $9, $10
sw $8, -272($sp)
lw $9, -8($sp)
lw $8, 0($9)
sw $8, -304($sp)
lw $9, -24($sp)
lw $8, 0($9)
sw $8, -308($sp)
lw $9, -308($sp)
mul $8, $9, 4
sw $8, -312($sp)
lw $9, -304($sp)
lw $10, -312($sp)
add $8, $9, $10
sw $8, -304($sp)
lw $9, -304($sp)
lw $8, 0($9)
sw $8, -304($sp)
lw $8, -304($sp)
lw $9, -272($sp)
sw $8, 0($9)
label36:
lw $9, -24($sp)
move $8, $9
sw $8, -320($sp)
lw $9, -24($sp)
lw $8, 0($9)
sw $8, -316($sp)
lw $9, -316($sp)
sub $8, $9, 1
sw $8, -324($sp)
lw $8, -324($sp)
lw $9, -320($sp)
sw $8, 0($9)
j label34
label35:
jr $ra
__dc3:
add $8, $29, 0
sw $8, -4($sp)
add $8, $29, 4
sw $8, -8($sp)
add $8, $29, 8
sw $8, -12($sp)
add $8, $29, 12
sw $8, -16($sp)
add $8, $29, -1220
sw $8, -24($sp)
lw $9, -24($sp)
move $8, $9
sw $8, -20($sp)
add $8, $29, -1224
sw $8, -32($sp)
lw $9, -32($sp)
move $8, $9
sw $8, -28($sp)
add $8, $29, -1228
sw $8, -40($sp)
lw $9, -40($sp)
move $8, $9
sw $8, -36($sp)
lw $9, -4($sp)
lw $8, 0($9)
sw $8, -44($sp)
lw $9, -12($sp)
lw $8, 0($9)
sw $8, -48($sp)
lw $9, -48($sp)
mul $8, $9, 4
sw $8, -48($sp)
lw $9, -44($sp)
lw $10, -48($sp)
add $8, $9, $10
sw $8, -44($sp)
lw $8, -44($sp)
lw $9, -36($sp)
sw $8, 0($9)
add $8, $29, -1232
sw $8, -56($sp)
lw $9, -56($sp)
move $8, $9
sw $8, -52($sp)
lw $9, -8($sp)
lw $8, 0($9)
sw $8, -60($sp)
lw $9, -12($sp)
lw $8, 0($9)
sw $8, -64($sp)
lw $9, -64($sp)
mul $8, $9, 4
sw $8, -64($sp)
lw $9, -60($sp)
lw $10, -64($sp)
add $8, $9, $10
sw $8, -60($sp)
lw $8, -60($sp)
lw $9, -52($sp)
sw $8, 0($9)
add $8, $29, -1236
sw $8, -72($sp)
lw $9, -72($sp)
move $8, $9
sw $8, -68($sp)
li $8, 0
sw $8, -76($sp)
lw $8, -76($sp)
lw $9, -68($sp)
sw $8, 0($9)
add $8, $29, -1240
sw $8, -84($sp)
lw $9, -84($sp)
move $8, $9
sw $8, -80($sp)
lw $9, -12($sp)
lw $8, 0($9)
sw $8, -88($sp)
li $8, 1
sw $8, -92($sp)
lw $9, -88($sp)
lw $10, -92($sp)
add $8, $9, $10
sw $8, -88($sp)
li $8, 3
sw $8, -96($sp)
lw $9, -88($sp)
lw $10, -96($sp)
div $8, $9, $10
sw $8, -88($sp)
lw $8, -88($sp)
lw $9, -80($sp)
sw $8, 0($9)
add $8, $29, -1244
sw $8, -104($sp)
lw $9, -104($sp)
move $8, $9
sw $8, -100($sp)
li $8, 0
sw $8, -108($sp)
lw $8, -108($sp)
lw $9, -100($sp)
sw $8, 0($9)
add $8, $29, -1248
sw $8, -116($sp)
lw $9, -116($sp)
move $8, $9
sw $8, -112($sp)
lw $9, -4($sp)
lw $8, 0($9)
sw $8, -120($sp)
lw $9, -12($sp)
lw $8, 0($9)
sw $8, -124($sp)
lw $9, -124($sp)
mul $8, $9, 4
sw $8, -128($sp)
lw $9, -120($sp)
lw $10, -128($sp)
add $8, $9, $10
sw $8, -120($sp)
lw $9, -4($sp)
lw $8, 0($9)
sw $8, -132($sp)
lw $9, -12($sp)
lw $8, 0($9)
sw $8, -136($sp)
li $8, 1
sw $8, -144($sp)
lw $9, -136($sp)
lw $10, -144($sp)
add $8, $9, $10
sw $8, -136($sp)
lw $9, -136($sp)
mul $8, $9, 4
sw $8, -140($sp)
lw $9, -132($sp)
lw $10, -140($sp)
add $8, $9, $10
sw $8, -132($sp)
li $8, 0
sw $8, -148($sp)
lw $8, -148($sp)
lw $9, -132($sp)
sw $8, 0($9)
lw $9, -132($sp)
lw $8, 0($9)
sw $8, -132($sp)
lw $8, -132($sp)
lw $9, -120($sp)
sw $8, 0($9)
lw $9, -24($sp)
move $8, $9
sw $8, -152($sp)
li $8, 0
sw $8, -156($sp)
lw $8, -156($sp)
lw $9, -152($sp)
sw $8, 0($9)
label37:
lw $9, -20($sp)
lw $8, 0($9)
sw $8, -160($sp)
lw $9, -12($sp)
lw $8, 0($9)
sw $8, -164($sp)
lw $9, -160($sp)
lw $10, -164($sp)
sub $8, $9, $10
sw $8, -164($sp)
lw $8, -164($sp)
bgez $8, label38
lw $9, -20($sp)
lw $8, 0($9)
sw $8, -168($sp)
li $8, 3
sw $8, -172($sp)
lw $9, -168($sp)
lw $10, -172($sp)
rem $8, $9, $10
sw $8, -168($sp)
li $8, 0
sw $8, -176($sp)
lw $9, -168($sp)
lw $10, -176($sp)
sub $8, $9, $10
sw $8, -176($sp)
lw $8, -176($sp)
beqz $8, label40
lw $9, -100($sp)
move $8, $9
sw $8, -192($sp)
lw $9, -100($sp)
lw $8, 0($9)
sw $8, -184($sp)
lw $9, -184($sp)
add $8, $9, 1
sw $8, -196($sp)
lw $8, -196($sp)
lw $9, -192($sp)
sw $8, 0($9)
lw $9, -184($sp)
mul $8, $9, 4
sw $8, -188($sp)
lw $9, 140($a3)
lw $10, -188($sp)
add $8, $9, $10
sw $8, -180($sp)
lw $9, -20($sp)
lw $8, 0($9)
sw $8, -200($sp)
lw $8, -200($sp)
lw $9, -180($sp)
sw $8, 0($9)
label40:
label39:
lw $9, -20($sp)
move $8, $9
sw $8, -208($sp)
lw $9, -20($sp)
lw $8, 0($9)
sw $8, -204($sp)
lw $9, -204($sp)
add $8, $9, 1
sw $8, -212($sp)
lw $8, -212($sp)
lw $9, -208($sp)
sw $8, 0($9)
j label37
label38:
sw $31, -1252($29)
add $8, $29, -1256
sw $8, -224($sp)
lw $9, -16($sp)
lw $8, 0($9)
sw $8, -220($sp)
lw $8, -220($sp)
lw $9, -224($sp)
sw $8, 0($9)
add $8, $29, -1260
sw $8, -232($sp)
lw $9, -100($sp)
lw $8, 0($9)
sw $8, -228($sp)
lw $8, -228($sp)
lw $9, -232($sp)
sw $8, 0($9)
lw $9, 144($a3)
move $8, $9
sw $8, -236($sp)
add $8, $29, -1264
sw $8, -240($sp)
lw $8, -236($sp)
lw $9, -240($sp)
sw $8, 0($9)
lw $9, 140($a3)
move $8, $9
sw $8, -244($sp)
add $8, $29, -1268
sw $8, -248($sp)
lw $8, -244($sp)
lw $9, -248($sp)
sw $8, 0($9)
lw $9, -4($sp)
lw $8, 0($9)
sw $8, -252($sp)
li $8, 2
sw $8, -256($sp)
lw $9, -256($sp)
mul $8, $9, 4
sw $8, -256($sp)
lw $9, -252($sp)
lw $10, -256($sp)
add $8, $9, $10
sw $8, -252($sp)
add $8, $29, -1272
sw $8, -260($sp)
lw $8, -252($sp)
lw $9, -260($sp)
sw $8, 0($9)
add $29, $29, -1272
jal __sort
sub $29, $29, -1272
lw $31, -1252($29)
sw $31, -1252($29)
add $8, $29, -1256
sw $8, -272($sp)
lw $9, -16($sp)
lw $8, 0($9)
sw $8, -268($sp)
lw $8, -268($sp)
lw $9, -272($sp)
sw $8, 0($9)
add $8, $29, -1260
sw $8, -280($sp)
lw $9, -100($sp)
lw $8, 0($9)
sw $8, -276($sp)
lw $8, -276($sp)
lw $9, -280($sp)
sw $8, 0($9)
lw $9, 140($a3)
move $8, $9
sw $8, -284($sp)
add $8, $29, -1264
sw $8, -288($sp)
lw $8, -284($sp)
lw $9, -288($sp)
sw $8, 0($9)
lw $9, 144($a3)
move $8, $9
sw $8, -292($sp)
add $8, $29, -1268
sw $8, -296($sp)
lw $8, -292($sp)
lw $9, -296($sp)
sw $8, 0($9)
lw $9, -4($sp)
lw $8, 0($9)
sw $8, -300($sp)
li $8, 1
sw $8, -304($sp)
lw $9, -304($sp)
mul $8, $9, 4
sw $8, -304($sp)
lw $9, -300($sp)
lw $10, -304($sp)
add $8, $9, $10
sw $8, -300($sp)
add $8, $29, -1272
sw $8, -308($sp)
lw $8, -300($sp)
lw $9, -308($sp)
sw $8, 0($9)
add $29, $29, -1272
jal __sort
sub $29, $29, -1272
lw $31, -1252($29)
sw $31, -1252($29)
add $8, $29, -1256
sw $8, -320($sp)
lw $9, -16($sp)
lw $8, 0($9)
sw $8, -316($sp)
lw $8, -316($sp)
lw $9, -320($sp)
sw $8, 0($9)
add $8, $29, -1260
sw $8, -328($sp)
lw $9, -100($sp)
lw $8, 0($9)
sw $8, -324($sp)
lw $8, -324($sp)
lw $9, -328($sp)
sw $8, 0($9)
lw $9, 144($a3)
move $8, $9
sw $8, -332($sp)
add $8, $29, -1264
sw $8, -336($sp)
lw $8, -332($sp)
lw $9, -336($sp)
sw $8, 0($9)
lw $9, 140($a3)
move $8, $9
sw $8, -340($sp)
add $8, $29, -1268
sw $8, -344($sp)
lw $8, -340($sp)
lw $9, -344($sp)
sw $8, 0($9)
add $8, $29, -1272
sw $8, -352($sp)
lw $9, -4($sp)
lw $8, 0($9)
sw $8, -348($sp)
lw $8, -348($sp)
lw $9, -352($sp)
sw $8, 0($9)
add $29, $29, -1272
jal __sort
sub $29, $29, -1272
lw $31, -1252($29)
lw $9, -112($sp)
move $8, $9
sw $8, -360($sp)
li $8, 1
sw $8, -364($sp)
lw $8, -364($sp)
lw $9, -360($sp)
sw $8, 0($9)
lw $9, -36($sp)
lw $8, 0($9)
sw $8, -368($sp)
sw $31, -1256($29)
add $8, $29, -1260
sw $8, -384($sp)
lw $9, -80($sp)
lw $8, 0($9)
sw $8, -380($sp)
lw $8, -380($sp)
lw $9, -384($sp)
sw $8, 0($9)
li $8, 0
sw $8, -392($sp)
lw $9, -392($sp)
mul $8, $9, 4
sw $8, -396($sp)
lw $9, 144($a3)
lw $10, -396($sp)
add $8, $9, $10
sw $8, -388($sp)
add $8, $29, -1264
sw $8, -400($sp)
lw $9, -388($sp)
lw $8, 0($9)
sw $8, -388($sp)
lw $8, -388($sp)
lw $9, -400($sp)
sw $8, 0($9)
add $29, $29, -1264
jal __F
sub $29, $29, -1264
lw $31, -1256($29)
add $8, $29, -1252
sw $8, -404($sp)
lw $9, -404($sp)
lw $8, 0($9)
sw $8, -372($sp)
lw $9, -372($sp)
mul $8, $9, 4
sw $8, -376($sp)
lw $9, -368($sp)
lw $10, -376($sp)
add $8, $9, $10
sw $8, -368($sp)
li $8, 0
sw $8, -408($sp)
lw $8, -408($sp)
lw $9, -368($sp)
sw $8, 0($9)
lw $9, -20($sp)
move $8, $9
sw $8, -356($sp)
li $8, 1
sw $8, -412($sp)
lw $8, -412($sp)
lw $9, -356($sp)
sw $8, 0($9)
label41:
lw $9, -20($sp)
lw $8, 0($9)
sw $8, -416($sp)
lw $9, -100($sp)
lw $8, 0($9)
sw $8, -420($sp)
lw $9, -416($sp)
lw $10, -420($sp)
sub $8, $9, $10
sw $8, -420($sp)
lw $8, -420($sp)
bgez $8, label42
sw $31, -1256($29)
lw $9, -20($sp)
lw $8, 0($9)
sw $8, -432($sp)
lw $9, -432($sp)
mul $8, $9, 4
sw $8, -436($sp)
lw $9, 144($a3)
lw $10, -436($sp)
add $8, $9, $10
sw $8, -428($sp)
add $8, $29, -1260
sw $8, -440($sp)
lw $9, -428($sp)
lw $8, 0($9)
sw $8, -428($sp)
lw $8, -428($sp)
lw $9, -440($sp)
sw $8, 0($9)
lw $9, -20($sp)
lw $8, 0($9)
sw $8, -448($sp)
li $8, 1
sw $8, -456($sp)
lw $9, -448($sp)
lw $10, -456($sp)
sub $8, $9, $10
sw $8, -448($sp)
lw $9, -448($sp)
mul $8, $9, 4
sw $8, -452($sp)
lw $9, 144($a3)
lw $10, -452($sp)
add $8, $9, $10
sw $8, -444($sp)
add $8, $29, -1264
sw $8, -460($sp)
lw $9, -444($sp)
lw $8, 0($9)
sw $8, -444($sp)
lw $8, -444($sp)
lw $9, -460($sp)
sw $8, 0($9)
add $8, $29, -1268
sw $8, -468($sp)
lw $9, -4($sp)
lw $8, 0($9)
sw $8, -464($sp)
lw $8, -464($sp)
lw $9, -468($sp)
sw $8, 0($9)
add $29, $29, -1268
jal __c0
sub $29, $29, -1268
lw $31, -1256($29)
add $8, $29, -1252
sw $8, -472($sp)
lw $9, -472($sp)
lw $8, 0($9)
sw $8, -424($sp)
lw $8, -424($sp)
beqz $8, label44
lw $9, -36($sp)
lw $8, 0($9)
sw $8, -476($sp)
sw $31, -1256($29)
add $8, $29, -1260
sw $8, -492($sp)
lw $9, -80($sp)
lw $8, 0($9)
sw $8, -488($sp)
lw $8, -488($sp)
lw $9, -492($sp)
sw $8, 0($9)
lw $9, -20($sp)
lw $8, 0($9)
sw $8, -500($sp)
lw $9, -500($sp)
mul $8, $9, 4
sw $8, -504($sp)
lw $9, 144($a3)
lw $10, -504($sp)
add $8, $9, $10
sw $8, -496($sp)
add $8, $29, -1264
sw $8, -508($sp)
lw $9, -496($sp)
lw $8, 0($9)
sw $8, -496($sp)
lw $8, -496($sp)
lw $9, -508($sp)
sw $8, 0($9)
add $29, $29, -1264
jal __F
sub $29, $29, -1264
lw $31, -1256($29)
add $8, $29, -1252
sw $8, -512($sp)
lw $9, -512($sp)
lw $8, 0($9)
sw $8, -480($sp)
lw $9, -480($sp)
mul $8, $9, 4
sw $8, -484($sp)
lw $9, -476($sp)
lw $10, -484($sp)
add $8, $9, $10
sw $8, -476($sp)
lw $9, -112($sp)
lw $8, 0($9)
sw $8, -516($sp)
li $8, 1
sw $8, -520($sp)
lw $9, -516($sp)
lw $10, -520($sp)
sub $8, $9, $10
sw $8, -516($sp)
lw $8, -516($sp)
lw $9, -476($sp)
sw $8, 0($9)
j label45
label44:
lw $9, -36($sp)
lw $8, 0($9)
sw $8, -524($sp)
sw $31, -1256($29)
add $8, $29, -1260
sw $8, -540($sp)
lw $9, -80($sp)
lw $8, 0($9)
sw $8, -536($sp)
lw $8, -536($sp)
lw $9, -540($sp)
sw $8, 0($9)
lw $9, -20($sp)
lw $8, 0($9)
sw $8, -548($sp)
lw $9, -548($sp)
mul $8, $9, 4
sw $8, -552($sp)
lw $9, 144($a3)
lw $10, -552($sp)
add $8, $9, $10
sw $8, -544($sp)
add $8, $29, -1264
sw $8, -556($sp)
lw $9, -544($sp)
lw $8, 0($9)
sw $8, -544($sp)
lw $8, -544($sp)
lw $9, -556($sp)
sw $8, 0($9)
add $29, $29, -1264
jal __F
sub $29, $29, -1264
lw $31, -1256($29)
add $8, $29, -1252
sw $8, -560($sp)
lw $9, -560($sp)
lw $8, 0($9)
sw $8, -528($sp)
lw $9, -528($sp)
mul $8, $9, 4
sw $8, -532($sp)
lw $9, -524($sp)
lw $10, -532($sp)
add $8, $9, $10
sw $8, -524($sp)
lw $9, -112($sp)
move $8, $9
sw $8, -568($sp)
lw $9, -112($sp)
lw $8, 0($9)
sw $8, -564($sp)
lw $9, -564($sp)
add $8, $9, 1
sw $8, -572($sp)
lw $8, -572($sp)
lw $9, -568($sp)
sw $8, 0($9)
lw $8, -564($sp)
lw $9, -524($sp)
sw $8, 0($9)
label45:
label43:
lw $9, -20($sp)
move $8, $9
sw $8, -580($sp)
lw $9, -20($sp)
lw $8, 0($9)
sw $8, -576($sp)
lw $9, -576($sp)
add $8, $9, 1
sw $8, -584($sp)
lw $8, -584($sp)
lw $9, -580($sp)
sw $8, 0($9)
j label41
label42:
lw $9, -112($sp)
lw $8, 0($9)
sw $8, -588($sp)
lw $9, -100($sp)
lw $8, 0($9)
sw $8, -592($sp)
lw $9, -588($sp)
lw $10, -592($sp)
sub $8, $9, $10
sw $8, -592($sp)
lw $8, -592($sp)
bgez $8, label46
sw $31, -1252($29)
add $8, $29, -1256
sw $8, -604($sp)
lw $9, -112($sp)
lw $8, 0($9)
sw $8, -600($sp)
lw $8, -600($sp)
lw $9, -604($sp)
sw $8, 0($9)
add $8, $29, -1260
sw $8, -612($sp)
lw $9, -100($sp)
lw $8, 0($9)
sw $8, -608($sp)
lw $8, -608($sp)
lw $9, -612($sp)
sw $8, 0($9)
add $8, $29, -1264
sw $8, -620($sp)
lw $9, -52($sp)
lw $8, 0($9)
sw $8, -616($sp)
lw $8, -616($sp)
lw $9, -620($sp)
sw $8, 0($9)
add $8, $29, -1268
sw $8, -628($sp)
lw $9, -36($sp)
lw $8, 0($9)
sw $8, -624($sp)
lw $8, -624($sp)
lw $9, -628($sp)
sw $8, 0($9)
add $29, $29, -1268
jal __dc3
sub $29, $29, -1268
lw $31, -1252($29)
j label47
label46:
lw $9, -20($sp)
move $8, $9
sw $8, -632($sp)
li $8, 0
sw $8, -636($sp)
lw $8, -636($sp)
lw $9, -632($sp)
sw $8, 0($9)
label48:
lw $9, -20($sp)
lw $8, 0($9)
sw $8, -640($sp)
lw $9, -100($sp)
lw $8, 0($9)
sw $8, -644($sp)
lw $9, -640($sp)
lw $10, -644($sp)
sub $8, $9, $10
sw $8, -644($sp)
lw $8, -644($sp)
bgez $8, label49
lw $9, -52($sp)
lw $8, 0($9)
sw $8, -648($sp)
lw $9, -36($sp)
lw $8, 0($9)
sw $8, -652($sp)
lw $9, -20($sp)
lw $8, 0($9)
sw $8, -660($sp)
lw $9, -660($sp)
mul $8, $9, 4
sw $8, -664($sp)
lw $9, -652($sp)
lw $10, -664($sp)
add $8, $9, $10
sw $8, -652($sp)
lw $9, -652($sp)
lw $8, 0($9)
sw $8, -652($sp)
lw $9, -652($sp)
mul $8, $9, 4
sw $8, -656($sp)
lw $9, -648($sp)
lw $10, -656($sp)
add $8, $9, $10
sw $8, -648($sp)
lw $9, -20($sp)
lw $8, 0($9)
sw $8, -668($sp)
lw $8, -668($sp)
lw $9, -648($sp)
sw $8, 0($9)
label50:
lw $9, -20($sp)
move $8, $9
sw $8, -676($sp)
lw $9, -20($sp)
lw $8, 0($9)
sw $8, -672($sp)
lw $9, -672($sp)
add $8, $9, 1
sw $8, -680($sp)
lw $8, -680($sp)
lw $9, -676($sp)
sw $8, 0($9)
j label48
label49:
label47:
lw $9, -20($sp)
move $8, $9
sw $8, -684($sp)
li $8, 0
sw $8, -688($sp)
lw $8, -688($sp)
lw $9, -684($sp)
sw $8, 0($9)
label51:
lw $9, -20($sp)
lw $8, 0($9)
sw $8, -692($sp)
lw $9, -100($sp)
lw $8, 0($9)
sw $8, -696($sp)
lw $9, -692($sp)
lw $10, -696($sp)
sub $8, $9, $10
sw $8, -696($sp)
lw $8, -696($sp)
bgez $8, label52
lw $9, -52($sp)
lw $8, 0($9)
sw $8, -700($sp)
lw $9, -20($sp)
lw $8, 0($9)
sw $8, -704($sp)
lw $9, -704($sp)
mul $8, $9, 4
sw $8, -708($sp)
lw $9, -700($sp)
lw $10, -708($sp)
add $8, $9, $10
sw $8, -700($sp)
lw $9, -700($sp)
lw $8, 0($9)
sw $8, -700($sp)
lw $9, -80($sp)
lw $8, 0($9)
sw $8, -712($sp)
lw $9, -700($sp)
lw $10, -712($sp)
sub $8, $9, $10
sw $8, -712($sp)
lw $8, -712($sp)
bgez $8, label54
lw $9, -68($sp)
move $8, $9
sw $8, -728($sp)
lw $9, -68($sp)
lw $8, 0($9)
sw $8, -720($sp)
lw $9, -720($sp)
add $8, $9, 1
sw $8, -732($sp)
lw $8, -732($sp)
lw $9, -728($sp)
sw $8, 0($9)
lw $9, -720($sp)
mul $8, $9, 4
sw $8, -724($sp)
lw $9, 144($a3)
lw $10, -724($sp)
add $8, $9, $10
sw $8, -716($sp)
lw $9, -52($sp)
lw $8, 0($9)
sw $8, -736($sp)
lw $9, -20($sp)
lw $8, 0($9)
sw $8, -740($sp)
lw $9, -740($sp)
mul $8, $9, 4
sw $8, -744($sp)
lw $9, -736($sp)
lw $10, -744($sp)
add $8, $9, $10
sw $8, -736($sp)
lw $9, -736($sp)
lw $8, 0($9)
sw $8, -736($sp)
li $8, 3
sw $8, -748($sp)
lw $9, -736($sp)
lw $10, -748($sp)
mul $8, $9, $10
sw $8, -736($sp)
lw $8, -736($sp)
lw $9, -716($sp)
sw $8, 0($9)
label54:
label53:
lw $9, -20($sp)
move $8, $9
sw $8, -756($sp)
lw $9, -20($sp)
lw $8, 0($9)
sw $8, -752($sp)
lw $9, -752($sp)
add $8, $9, 1
sw $8, -760($sp)
lw $8, -760($sp)
lw $9, -756($sp)
sw $8, 0($9)
j label51
label52:
lw $9, -12($sp)
lw $8, 0($9)
sw $8, -764($sp)
li $8, 3
sw $8, -768($sp)
lw $9, -764($sp)
lw $10, -768($sp)
rem $8, $9, $10
sw $8, -764($sp)
li $8, 1
sw $8, -772($sp)
lw $9, -764($sp)
lw $10, -772($sp)
sub $8, $9, $10
sw $8, -772($sp)
lw $8, -772($sp)
bnez $8, label55
lw $9, -68($sp)
move $8, $9
sw $8, -788($sp)
lw $9, -68($sp)
lw $8, 0($9)
sw $8, -780($sp)
lw $9, -780($sp)
add $8, $9, 1
sw $8, -792($sp)
lw $8, -792($sp)
lw $9, -788($sp)
sw $8, 0($9)
lw $9, -780($sp)
mul $8, $9, 4
sw $8, -784($sp)
lw $9, 144($a3)
lw $10, -784($sp)
add $8, $9, $10
sw $8, -776($sp)
lw $9, -12($sp)
lw $8, 0($9)
sw $8, -796($sp)
li $8, 1
sw $8, -800($sp)
lw $9, -796($sp)
lw $10, -800($sp)
sub $8, $9, $10
sw $8, -796($sp)
lw $8, -796($sp)
lw $9, -776($sp)
sw $8, 0($9)
label55:
sw $31, -1252($29)
add $8, $29, -1256
sw $8, -812($sp)
lw $9, -16($sp)
lw $8, 0($9)
sw $8, -808($sp)
lw $8, -808($sp)
lw $9, -812($sp)
sw $8, 0($9)
add $8, $29, -1260
sw $8, -820($sp)
lw $9, -68($sp)
lw $8, 0($9)
sw $8, -816($sp)
lw $8, -816($sp)
lw $9, -820($sp)
sw $8, 0($9)
lw $9, 140($a3)
move $8, $9
sw $8, -824($sp)
add $8, $29, -1264
sw $8, -828($sp)
lw $8, -824($sp)
lw $9, -828($sp)
sw $8, 0($9)
lw $9, 144($a3)
move $8, $9
sw $8, -832($sp)
add $8, $29, -1268
sw $8, -836($sp)
lw $8, -832($sp)
lw $9, -836($sp)
sw $8, 0($9)
add $8, $29, -1272
sw $8, -844($sp)
lw $9, -4($sp)
lw $8, 0($9)
sw $8, -840($sp)
lw $8, -840($sp)
lw $9, -844($sp)
sw $8, 0($9)
add $29, $29, -1272
jal __sort
sub $29, $29, -1272
lw $31, -1252($29)
lw $9, -20($sp)
move $8, $9
sw $8, -848($sp)
li $8, 0
sw $8, -852($sp)
lw $8, -852($sp)
lw $9, -848($sp)
sw $8, 0($9)
label56:
lw $9, -20($sp)
lw $8, 0($9)
sw $8, -856($sp)
lw $9, -100($sp)
lw $8, 0($9)
sw $8, -860($sp)
lw $9, -856($sp)
lw $10, -860($sp)
sub $8, $9, $10
sw $8, -860($sp)
lw $8, -860($sp)
bgez $8, label57
lw $9, -20($sp)
lw $8, 0($9)
sw $8, -876($sp)
lw $9, -876($sp)
mul $8, $9, 4
sw $8, -880($sp)
lw $9, 144($a3)
lw $10, -880($sp)
add $8, $9, $10
sw $8, -868($sp)
sw $31, -1256($29)
add $8, $29, -1260
sw $8, -892($sp)
lw $9, -80($sp)
lw $8, 0($9)
sw $8, -888($sp)
lw $8, -888($sp)
lw $9, -892($sp)
sw $8, 0($9)
lw $9, -52($sp)
lw $8, 0($9)
sw $8, -896($sp)
lw $9, -20($sp)
lw $8, 0($9)
sw $8, -900($sp)
lw $9, -900($sp)
mul $8, $9, 4
sw $8, -904($sp)
lw $9, -896($sp)
lw $10, -904($sp)
add $8, $9, $10
sw $8, -896($sp)
add $8, $29, -1264
sw $8, -908($sp)
lw $9, -896($sp)
lw $8, 0($9)
sw $8, -896($sp)
lw $8, -896($sp)
lw $9, -908($sp)
sw $8, 0($9)
add $29, $29, -1264
jal __G
sub $29, $29, -1264
lw $31, -1256($29)
add $8, $29, -1252
sw $8, -912($sp)
lw $9, -912($sp)
lw $8, 0($9)
sw $8, -884($sp)
lw $8, -884($sp)
lw $9, -868($sp)
sw $8, 0($9)
lw $9, -868($sp)
lw $8, 0($9)
sw $8, -868($sp)
lw $9, -868($sp)
mul $8, $9, 4
sw $8, -872($sp)
lw $9, 148($a3)
lw $10, -872($sp)
add $8, $9, $10
sw $8, -864($sp)
lw $9, -20($sp)
lw $8, 0($9)
sw $8, -916($sp)
lw $8, -916($sp)
lw $9, -864($sp)
sw $8, 0($9)
label58:
lw $9, -20($sp)
move $8, $9
sw $8, -924($sp)
lw $9, -20($sp)
lw $8, 0($9)
sw $8, -920($sp)
lw $9, -920($sp)
add $8, $9, 1
sw $8, -928($sp)
lw $8, -928($sp)
lw $9, -924($sp)
sw $8, 0($9)
j label56
label57:
lw $9, -20($sp)
move $8, $9
sw $8, -936($sp)
li $8, 0
sw $8, -940($sp)
lw $8, -940($sp)
lw $9, -936($sp)
sw $8, 0($9)
lw $9, -28($sp)
move $8, $9
sw $8, -944($sp)
li $8, 0
sw $8, -948($sp)
lw $8, -948($sp)
lw $9, -944($sp)
sw $8, 0($9)
lw $9, -112($sp)
move $8, $9
sw $8, -932($sp)
li $8, 0
sw $8, -952($sp)
lw $8, -952($sp)
lw $9, -932($sp)
sw $8, 0($9)
label59:
lw $9, -20($sp)
lw $8, 0($9)
sw $8, -956($sp)
lw $9, -68($sp)
lw $8, 0($9)
sw $8, -960($sp)
lw $9, -956($sp)
lw $10, -960($sp)
sub $8, $9, $10
sw $8, -960($sp)
lw $8, -960($sp)
bgez $8, label60
lw $9, -28($sp)
lw $8, 0($9)
sw $8, -964($sp)
lw $9, -100($sp)
lw $8, 0($9)
sw $8, -968($sp)
lw $9, -964($sp)
lw $10, -968($sp)
sub $8, $9, $10
sw $8, -968($sp)
lw $8, -968($sp)
bgez $8, label60
sw $31, -1256($29)
lw $9, -28($sp)
lw $8, 0($9)
sw $8, -980($sp)
lw $9, -980($sp)
mul $8, $9, 4
sw $8, -984($sp)
lw $9, 144($a3)
lw $10, -984($sp)
add $8, $9, $10
sw $8, -976($sp)
add $8, $29, -1260
sw $8, -988($sp)
lw $9, -976($sp)
lw $8, 0($9)
sw $8, -976($sp)
lw $8, -976($sp)
lw $9, -988($sp)
sw $8, 0($9)
lw $9, -20($sp)
lw $8, 0($9)
sw $8, -996($sp)
lw $9, -996($sp)
mul $8, $9, 4
sw $8, -1000($sp)
lw $9, 140($a3)
lw $10, -1000($sp)
add $8, $9, $10
sw $8, -992($sp)
add $8, $29, -1264
sw $8, -1004($sp)
lw $9, -992($sp)
lw $8, 0($9)
sw $8, -992($sp)
lw $8, -992($sp)
lw $9, -1004($sp)
sw $8, 0($9)
add $8, $29, -1268
sw $8, -1012($sp)
lw $9, -4($sp)
lw $8, 0($9)
sw $8, -1008($sp)
lw $8, -1008($sp)
lw $9, -1012($sp)
sw $8, 0($9)
lw $9, -28($sp)
lw $8, 0($9)
sw $8, -1020($sp)
lw $9, -1020($sp)
mul $8, $9, 4
sw $8, -1024($sp)
lw $9, 144($a3)
lw $10, -1024($sp)
add $8, $9, $10
sw $8, -1016($sp)
lw $9, -1016($sp)
lw $8, 0($9)
sw $8, -1016($sp)
li $8, 3
sw $8, -1028($sp)
lw $9, -1016($sp)
lw $10, -1028($sp)
rem $8, $9, $10
sw $8, -1016($sp)
add $8, $29, -1272
sw $8, -1032($sp)
lw $8, -1016($sp)
lw $9, -1032($sp)
sw $8, 0($9)
add $29, $29, -1272
jal __c12
sub $29, $29, -1272
lw $31, -1256($29)
add $8, $29, -1252
sw $8, -1036($sp)
lw $9, -1036($sp)
lw $8, 0($9)
sw $8, -972($sp)
lw $8, -972($sp)
beqz $8, label62
lw $9, -8($sp)
lw $8, 0($9)
sw $8, -1040($sp)
lw $9, -112($sp)
lw $8, 0($9)
sw $8, -1044($sp)
lw $9, -1044($sp)
mul $8, $9, 4
sw $8, -1048($sp)
lw $9, -1040($sp)
lw $10, -1048($sp)
add $8, $9, $10
sw $8, -1040($sp)
lw $9, -20($sp)
move $8, $9
sw $8, -1064($sp)
lw $9, -20($sp)
lw $8, 0($9)
sw $8, -1056($sp)
lw $9, -1056($sp)
add $8, $9, 1
sw $8, -1068($sp)
lw $8, -1068($sp)
lw $9, -1064($sp)
sw $8, 0($9)
lw $9, -1056($sp)
mul $8, $9, 4
sw $8, -1060($sp)
lw $9, 140($a3)
lw $10, -1060($sp)
add $8, $9, $10
sw $8, -1052($sp)
lw $9, -1052($sp)
lw $8, 0($9)
sw $8, -1052($sp)
lw $8, -1052($sp)
lw $9, -1040($sp)
sw $8, 0($9)
j label63
label62:
lw $9, -8($sp)
lw $8, 0($9)
sw $8, -1072($sp)
lw $9, -112($sp)
lw $8, 0($9)
sw $8, -1076($sp)
lw $9, -1076($sp)
mul $8, $9, 4
sw $8, -1080($sp)
lw $9, -1072($sp)
lw $10, -1080($sp)
add $8, $9, $10
sw $8, -1072($sp)
lw $9, -28($sp)
move $8, $9
sw $8, -1096($sp)
lw $9, -28($sp)
lw $8, 0($9)
sw $8, -1088($sp)
lw $9, -1088($sp)
add $8, $9, 1
sw $8, -1100($sp)
lw $8, -1100($sp)
lw $9, -1096($sp)
sw $8, 0($9)
lw $9, -1088($sp)
mul $8, $9, 4
sw $8, -1092($sp)
lw $9, 144($a3)
lw $10, -1092($sp)
add $8, $9, $10
sw $8, -1084($sp)
lw $9, -1084($sp)
lw $8, 0($9)
sw $8, -1084($sp)
lw $8, -1084($sp)
lw $9, -1072($sp)
sw $8, 0($9)
label63:
label61:
lw $9, -112($sp)
move $8, $9
sw $8, -1108($sp)
lw $9, -112($sp)
lw $8, 0($9)
sw $8, -1104($sp)
lw $9, -1104($sp)
add $8, $9, 1
sw $8, -1112($sp)
lw $8, -1112($sp)
lw $9, -1108($sp)
sw $8, 0($9)
j label59
label60:
label64:
lw $9, -20($sp)
lw $8, 0($9)
sw $8, -1116($sp)
lw $9, -68($sp)
lw $8, 0($9)
sw $8, -1120($sp)
lw $9, -1116($sp)
lw $10, -1120($sp)
sub $8, $9, $10
sw $8, -1120($sp)
lw $8, -1120($sp)
bgez $8, label65
lw $9, -8($sp)
lw $8, 0($9)
sw $8, -1124($sp)
lw $9, -112($sp)
lw $8, 0($9)
sw $8, -1128($sp)
lw $9, -1128($sp)
mul $8, $9, 4
sw $8, -1132($sp)
lw $9, -1124($sp)
lw $10, -1132($sp)
add $8, $9, $10
sw $8, -1124($sp)
lw $9, -20($sp)
move $8, $9
sw $8, -1148($sp)
lw $9, -20($sp)
lw $8, 0($9)
sw $8, -1140($sp)
lw $9, -1140($sp)
add $8, $9, 1
sw $8, -1152($sp)
lw $8, -1152($sp)
lw $9, -1148($sp)
sw $8, 0($9)
lw $9, -1140($sp)
mul $8, $9, 4
sw $8, -1144($sp)
lw $9, 140($a3)
lw $10, -1144($sp)
add $8, $9, $10
sw $8, -1136($sp)
lw $9, -1136($sp)
lw $8, 0($9)
sw $8, -1136($sp)
lw $8, -1136($sp)
lw $9, -1124($sp)
sw $8, 0($9)
label66:
lw $9, -112($sp)
move $8, $9
sw $8, -1160($sp)
lw $9, -112($sp)
lw $8, 0($9)
sw $8, -1156($sp)
lw $9, -1156($sp)
add $8, $9, 1
sw $8, -1164($sp)
lw $8, -1164($sp)
lw $9, -1160($sp)
sw $8, 0($9)
j label64
label65:
label67:
lw $9, -28($sp)
lw $8, 0($9)
sw $8, -1168($sp)
lw $9, -100($sp)
lw $8, 0($9)
sw $8, -1172($sp)
lw $9, -1168($sp)
lw $10, -1172($sp)
sub $8, $9, $10
sw $8, -1172($sp)
lw $8, -1172($sp)
bgez $8, label68
lw $9, -8($sp)
lw $8, 0($9)
sw $8, -1176($sp)
lw $9, -112($sp)
lw $8, 0($9)
sw $8, -1180($sp)
lw $9, -1180($sp)
mul $8, $9, 4
sw $8, -1184($sp)
lw $9, -1176($sp)
lw $10, -1184($sp)
add $8, $9, $10
sw $8, -1176($sp)
lw $9, -28($sp)
move $8, $9
sw $8, -1200($sp)
lw $9, -28($sp)
lw $8, 0($9)
sw $8, -1192($sp)
lw $9, -1192($sp)
add $8, $9, 1
sw $8, -1204($sp)
lw $8, -1204($sp)
lw $9, -1200($sp)
sw $8, 0($9)
lw $9, -1192($sp)
mul $8, $9, 4
sw $8, -1196($sp)
lw $9, 144($a3)
lw $10, -1196($sp)
add $8, $9, $10
sw $8, -1188($sp)
lw $9, -1188($sp)
lw $8, 0($9)
sw $8, -1188($sp)
lw $8, -1188($sp)
lw $9, -1176($sp)
sw $8, 0($9)
label69:
lw $9, -112($sp)
move $8, $9
sw $8, -1212($sp)
lw $9, -112($sp)
lw $8, 0($9)
sw $8, -1208($sp)
lw $9, -1208($sp)
add $8, $9, 1
sw $8, -1216($sp)
lw $8, -1216($sp)
lw $9, -1212($sp)
sw $8, 0($9)
j label67
label68:
jr $ra
__getInt:
add $8, $29, -116
sw $8, -8($sp)
lw $9, -8($sp)
move $8, $9
sw $8, -4($sp)
sw $31, -124($29)
add $29, $29, -124
jal __getchar
sub $29, $29, -124
lw $31, -124($29)
add $8, $29, -120
sw $8, -16($sp)
lw $9, -16($sp)
lw $8, 0($9)
sw $8, -12($sp)
lw $8, -12($sp)
lw $9, -4($sp)
sw $8, 0($9)
add $8, $29, -120
sw $8, -24($sp)
lw $9, -24($sp)
move $8, $9
sw $8, -20($sp)
li $8, 0
sw $8, -28($sp)
lw $8, -28($sp)
lw $9, -20($sp)
sw $8, 0($9)
label70:
lw $9, -4($sp)
lw $8, 0($9)
sw $8, -32($sp)
li $8, 48
sw $8, -36($sp)
lw $9, -32($sp)
lw $10, -36($sp)
sub $8, $9, $10
sw $8, -36($sp)
lw $8, -36($sp)
bltz $8, label72
lw $9, -4($sp)
lw $8, 0($9)
sw $8, -40($sp)
li $8, 57
sw $8, -44($sp)
lw $9, -40($sp)
lw $10, -44($sp)
sub $8, $9, $10
sw $8, -44($sp)
lw $8, -44($sp)
blez $8, label71
label72:
lw $9, -4($sp)
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
j label70
label71:
label73:
lw $9, -4($sp)
lw $8, 0($9)
sw $8, -60($sp)
li $8, 48
sw $8, -64($sp)
lw $9, -60($sp)
lw $10, -64($sp)
sub $8, $9, $10
sw $8, -64($sp)
lw $8, -64($sp)
bltz $8, label74
lw $9, -4($sp)
lw $8, 0($9)
sw $8, -68($sp)
li $8, 57
sw $8, -72($sp)
lw $9, -68($sp)
lw $10, -72($sp)
sub $8, $9, $10
sw $8, -72($sp)
lw $8, -72($sp)
bgtz $8, label74
lw $9, -20($sp)
move $8, $9
sw $8, -76($sp)
lw $9, -20($sp)
lw $8, 0($9)
sw $8, -80($sp)
li $8, 10
sw $8, -84($sp)
lw $9, -80($sp)
lw $10, -84($sp)
mul $8, $9, $10
sw $8, -80($sp)
lw $9, -4($sp)
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
lw $9, -4($sp)
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
j label73
label74:
add $8, $29, 4
sw $8, -112($sp)
lw $9, -20($sp)
lw $8, 0($9)
sw $8, -108($sp)
lw $8, -108($sp)
lw $9, -112($sp)
sw $8, 0($9)
jr $ra
jr $ra
main:
la $a3, temp
la $t0, var0
sw $t0, 140($a3)
la $t0, var1
sw $t0, 144($a3)
la $t0, var2
sw $t0, 148($a3)
la $t0, var3
sw $t0, 152($a3)
la $t0, var4
sw $t0, 156($a3)
la $t0, var5
sw $t0, 160($a3)
la $t0, var6
sw $t0, 2352($a3)
la $t0, var7
sw $t0, 2380($a3)
add $8, $29, -280
sw $8, -8($sp)
lw $9, -8($sp)
move $8, $9
sw $8, -4($sp)
add $8, $29, -284
sw $8, -16($sp)
lw $9, -16($sp)
move $8, $9
sw $8, -12($sp)
li $8, 0
sw $8, -20($sp)
lw $8, -20($sp)
lw $9, -12($sp)
sw $8, 0($9)
add $8, $29, -288
sw $8, -28($sp)
lw $9, -28($sp)
move $8, $9
sw $8, -24($sp)
lw $9, -8($sp)
move $8, $9
sw $8, -32($sp)
add $29, $29, -296
jal __getInt
sub $29, $29, -296
add $8, $29, -292
sw $8, -40($sp)
lw $9, -40($sp)
lw $8, 0($9)
sw $8, -36($sp)
lw $8, -36($sp)
lw $9, -32($sp)
sw $8, 0($9)
lw $9, -28($sp)
move $8, $9
sw $8, -44($sp)
li $8, 0
sw $8, -48($sp)
lw $8, -48($sp)
lw $9, -44($sp)
sw $8, 0($9)
label75:
lw $9, -24($sp)
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
bgez $8, label76
lw $9, -24($sp)
lw $8, 0($9)
sw $8, -68($sp)
lw $9, -68($sp)
mul $8, $9, 4
sw $8, -72($sp)
lw $9, 156($a3)
lw $10, -72($sp)
add $8, $9, $10
sw $8, -64($sp)
add $29, $29, -296
jal __getInt
sub $29, $29, -296
add $8, $29, -292
sw $8, -80($sp)
lw $9, -80($sp)
lw $8, 0($9)
sw $8, -76($sp)
lw $8, -76($sp)
lw $9, -64($sp)
sw $8, 0($9)
lw $9, -24($sp)
lw $8, 0($9)
sw $8, -88($sp)
lw $9, -88($sp)
mul $8, $9, 4
sw $8, -92($sp)
lw $9, 156($a3)
lw $10, -92($sp)
add $8, $9, $10
sw $8, -84($sp)
lw $9, -84($sp)
move $8, $9
sw $8, -96($sp)
lw $9, -84($sp)
lw $8, 0($9)
sw $8, -84($sp)
lw $9, -84($sp)
add $8, $9, 1
sw $8, -100($sp)
lw $8, -100($sp)
lw $9, -96($sp)
sw $8, 0($9)
lw $9, -12($sp)
move $8, $9
sw $8, -60($sp)
add $8, $29, -300
sw $8, -112($sp)
lw $9, -12($sp)
lw $8, 0($9)
sw $8, -108($sp)
lw $8, -108($sp)
lw $9, -112($sp)
sw $8, 0($9)
lw $9, -24($sp)
lw $8, 0($9)
sw $8, -120($sp)
lw $9, -120($sp)
mul $8, $9, 4
sw $8, -124($sp)
lw $9, 156($a3)
lw $10, -124($sp)
add $8, $9, $10
sw $8, -116($sp)
lw $9, -116($sp)
lw $8, 0($9)
sw $8, -116($sp)
li $8, 1
sw $8, -128($sp)
lw $9, -116($sp)
lw $10, -128($sp)
add $8, $9, $10
sw $8, -116($sp)
add $8, $29, -304
sw $8, -132($sp)
lw $8, -116($sp)
lw $9, -132($sp)
sw $8, 0($9)
add $29, $29, -304
jal __max
sub $29, $29, -304
add $8, $29, -292
sw $8, -136($sp)
lw $9, -136($sp)
lw $8, 0($9)
sw $8, -104($sp)
lw $8, -104($sp)
lw $9, -60($sp)
sw $8, 0($9)
label77:
lw $9, -24($sp)
move $8, $9
sw $8, -144($sp)
lw $9, -24($sp)
lw $8, 0($9)
sw $8, -140($sp)
lw $9, -140($sp)
add $8, $9, 1
sw $8, -148($sp)
lw $8, -148($sp)
lw $9, -144($sp)
sw $8, 0($9)
j label75
label76:
lw $9, -4($sp)
move $8, $9
sw $8, -164($sp)
lw $9, -4($sp)
lw $8, 0($9)
sw $8, -156($sp)
lw $9, -156($sp)
add $8, $9, 1
sw $8, -168($sp)
lw $8, -168($sp)
lw $9, -164($sp)
sw $8, 0($9)
lw $9, -156($sp)
mul $8, $9, 4
sw $8, -160($sp)
lw $9, 156($a3)
lw $10, -160($sp)
add $8, $9, $10
sw $8, -152($sp)
li $8, 0
sw $8, -172($sp)
lw $8, -172($sp)
lw $9, -152($sp)
sw $8, 0($9)
add $8, $29, -296
sw $8, -184($sp)
lw $9, -12($sp)
lw $8, 0($9)
sw $8, -180($sp)
lw $8, -180($sp)
lw $9, -184($sp)
sw $8, 0($9)
add $8, $29, -300
sw $8, -192($sp)
lw $9, -4($sp)
lw $8, 0($9)
sw $8, -188($sp)
lw $8, -188($sp)
lw $9, -192($sp)
sw $8, 0($9)
lw $9, 160($a3)
move $8, $9
sw $8, -196($sp)
add $8, $29, -304
sw $8, -200($sp)
lw $8, -196($sp)
lw $9, -200($sp)
sw $8, 0($9)
lw $9, 156($a3)
move $8, $9
sw $8, -204($sp)
add $8, $29, -308
sw $8, -208($sp)
lw $8, -204($sp)
lw $9, -208($sp)
sw $8, 0($9)
add $29, $29, -308
jal __dc3
sub $29, $29, -308
lw $9, -24($sp)
move $8, $9
sw $8, -212($sp)
li $8, 0
sw $8, -216($sp)
lw $8, -216($sp)
lw $9, -212($sp)
sw $8, 0($9)
label78:
lw $9, -24($sp)
lw $8, 0($9)
sw $8, -220($sp)
lw $9, -4($sp)
lw $8, 0($9)
sw $8, -224($sp)
lw $9, -220($sp)
lw $10, -224($sp)
sub $8, $9, $10
sw $8, -224($sp)
lw $8, -224($sp)
bgez $8, label79
lw $9, -24($sp)
lw $8, 0($9)
sw $8, -236($sp)
lw $9, -236($sp)
mul $8, $9, 4
sw $8, -240($sp)
lw $9, 160($a3)
lw $10, -240($sp)
add $8, $9, $10
sw $8, -232($sp)
add $8, $29, -296
sw $8, -244($sp)
lw $9, -232($sp)
lw $8, 0($9)
sw $8, -232($sp)
lw $8, -232($sp)
lw $9, -244($sp)
sw $8, 0($9)
lw $9, 2352($a3)
move $8, $9
sw $8, -248($sp)
add $8, $29, -300
sw $8, -252($sp)
lw $8, -248($sp)
lw $9, -252($sp)
sw $8, 0($9)
add $29, $29, -300
jal __printf
sub $29, $29, -300
label80:
lw $9, -24($sp)
move $8, $9
sw $8, -260($sp)
lw $9, -24($sp)
lw $8, 0($9)
sw $8, -256($sp)
lw $9, -256($sp)
add $8, $9, 1
sw $8, -264($sp)
lw $8, -264($sp)
lw $9, -260($sp)
sw $8, 0($9)
j label78
label79:
lw $9, 2380($a3)
move $8, $9
sw $8, -272($sp)
add $8, $29, -296
sw $8, -276($sp)
lw $8, -272($sp)
lw $9, -276($sp)
sw $8, 0($9)
add $29, $29, -296
jal __printf_single
sub $29, $29, -296
j __main_end
__main_end:
li $v0, 10
syscall
#global $35 40000
#global $36 40000
#global $37 40000
#global $38 40000
#global $39 120000
#global $40 120000
#string $588 #%d 
#string $595 #\n
#----------------------------
#func #F
#addi $2 $0 0
#addi $3 $0 4
####move $4 $2
#lw $4 $2 0
#li $5 3
#mod $4 $4 $5
#li $6 1
#sub $6 $4 $6
#bnez $6 l:0
####move $7 $2
#lw $7 $2 0
#li $8 3
#div $7 $7 $8
#addi $9 $0 12
#sw $7 $9 0
#return
#goto l:1
#label l:0
####move $10 $2
#lw $10 $2 0
#li $11 3
#div $10 $10 $11
####move $12 $3
#lw $12 $3 0
#add $10 $10 $12
#addi $13 $0 12
#sw $10 $13 0
#return
#label l:1
#return
#----------------------------
#func #G
#addi $14 $0 0
#addi $15 $0 4
####move $16 $14
#lw $16 $14 0
####move $17 $15
#lw $17 $15 0
#sub $17 $16 $17
#bgez $17 l:2
####move $18 $14
#lw $18 $14 0
#li $19 3
#mul $18 $18 $19
#li $20 1
#add $18 $18 $20
#addi $21 $0 12
#sw $18 $21 0
#return
#goto l:3
#label l:2
####move $22 $14
#lw $22 $14 0
####move $23 $15
#lw $23 $15 0
#sub $22 $22 $23
#li $24 3
#mul $22 $22 $24
#li $25 2
#add $22 $22 $25
#addi $26 $0 12
#sw $22 $26 0
#return
#label l:3
#return
#----------------------------
#func #max
#addi $27 $0 0
#addi $28 $0 4
####move $29 $27
#lw $29 $27 0
####move $30 $28
#lw $30 $28 0
#sub $30 $29 $30
#blez $30 l:4
####move $31 $27
#addi $32 $0 12
#lw $31 $27 0
#sw $31 $32 0
#return
#goto l:5
#label l:4
####move $33 $28
#addi $34 $0 12
#lw $33 $28 0
#sw $33 $34 0
#return
#label l:5
#return
#----------------------------
#func #c0
#addi $41 $0 0
#addi $42 $0 4
#addi $43 $0 8
####move $44 $41
#lw $44 $41 0
####move $45 $42
#lw $45 $42 0
#muli $46 $45 4
#add $44 $44 $46
#lw $44 $44 0
####move $47 $41
#lw $47 $41 0
####move $48 $43
#lw $48 $43 0
#muli $49 $48 4
#add $47 $47 $49
#lw $47 $47 0
#sub $47 $44 $47
#li $44 1
#beqz $47 l:6
#li $44 0
#label l:6
#beqz $44 l:7
####move $44 $41
#lw $44 $41 0
####move $50 $42
#lw $50 $42 0
#li $52 1
#add $50 $50 $52
#muli $51 $50 4
#add $44 $44 $51
#lw $44 $44 0
####move $53 $41
#lw $53 $41 0
####move $54 $43
#lw $54 $43 0
#li $56 1
#add $54 $54 $56
#muli $55 $54 4
#add $53 $53 $55
#lw $53 $53 0
#sub $53 $44 $53
#li $44 1
#beqz $53 l:8
#li $44 0
#label l:8
#label l:7
#andi $44 $44 1
#beqz $44 l:9
####move $44 $41
#lw $44 $41 0
####move $57 $42
#lw $57 $42 0
#li $59 2
#add $57 $57 $59
#muli $58 $57 4
#add $44 $44 $58
#lw $44 $44 0
####move $60 $41
#lw $60 $41 0
####move $61 $43
#lw $61 $43 0
#li $63 2
#add $61 $61 $63
#muli $62 $61 4
#add $60 $60 $62
#lw $60 $60 0
#sub $60 $44 $60
#li $44 1
#beqz $60 l:10
#li $44 0
#label l:10
#label l:9
#andi $44 $44 1
#addi $64 $0 16
#sw $44 $64 0
#return
#return
#----------------------------
#func #c12
#addi $65 $0 0
#addi $66 $0 4
#addi $67 $0 8
#addi $68 $0 12
####move $69 $65
#lw $69 $65 0
#li $70 2
#sub $70 $69 $70
#bnez $70 l:11
####move $71 $66
#lw $71 $66 0
####move $72 $67
#lw $72 $67 0
#muli $73 $72 4
#add $71 $71 $73
#lw $71 $71 0
####move $74 $66
#lw $74 $66 0
####move $75 $68
#lw $75 $68 0
#muli $76 $75 4
#add $74 $74 $76
#lw $74 $74 0
#sub $74 $71 $74
#li $71 1
#bltz $74 l:13
#li $71 0
#label l:13
#bnez $71 l:14
####move $71 $66
#lw $71 $66 0
####move $77 $67
#lw $77 $67 0
#muli $78 $77 4
#add $71 $71 $78
#lw $71 $71 0
####move $79 $66
#lw $79 $66 0
####move $80 $68
#lw $80 $68 0
#muli $81 $80 4
#add $79 $79 $81
#lw $79 $79 0
#sub $79 $71 $79
#li $71 1
#beqz $79 l:15
#li $71 0
#label l:15
#beqz $71 l:16
#sw $1 $0 -200
####move $82 $68
#lw $82 $68 0
#li $83 1
#add $82 $82 $83
#addi $84 $0 -204
#sw $82 $84 0
####move $85 $67
#lw $85 $67 0
#li $86 1
#add $85 $85 $86
#addi $87 $0 -208
#sw $85 $87 0
####move $88 $66
#addi $89 $0 -212
#lw $88 $66 0
#sw $88 $89 0
#li $90 1
#addi $91 $0 -216
#sw $90 $91 0
#addi $0 $0 -216
#call #c12
#subi $0 $0 -216
#lw $1 $0 -200
#addi $92 $0 -196
####move $71 $92
#lw $71 $92 0
#label l:16
#andi $71 $71 1
#label l:14
#andi $71 $71 1
#addi $93 $0 20
#sw $71 $93 0
#return
#goto l:12
#label l:11
####move $94 $66
#lw $94 $66 0
####move $95 $67
#lw $95 $67 0
#muli $96 $95 4
#add $94 $94 $96
#lw $94 $94 0
####move $97 $66
#lw $97 $66 0
####move $98 $68
#lw $98 $68 0
#muli $99 $98 4
#add $97 $97 $99
#lw $97 $97 0
#sub $97 $94 $97
#li $94 1
#bltz $97 l:17
#li $94 0
#label l:17
#bnez $94 l:18
####move $94 $66
#lw $94 $66 0
####move $100 $67
#lw $100 $67 0
#muli $101 $100 4
#add $94 $94 $101
#lw $94 $94 0
####move $102 $66
#lw $102 $66 0
####move $103 $68
#lw $103 $68 0
#muli $104 $103 4
#add $102 $102 $104
#lw $102 $102 0
#sub $102 $94 $102
#li $94 1
#beqz $102 l:19
#li $94 0
#label l:19
#beqz $94 l:20
####move $94 $37
####move $105 $67
#lw $105 $67 0
#li $107 1
#add $105 $105 $107
#muli $106 $105 4
#add $94 $37 $106
#lw $94 $94 0
####move $108 $37
####move $109 $68
#lw $109 $68 0
#li $111 1
#add $109 $109 $111
#muli $110 $109 4
#add $108 $37 $110
#lw $108 $108 0
#sub $108 $94 $108
#li $94 1
#bltz $108 l:21
#li $94 0
#label l:21
#label l:20
#andi $94 $94 1
#label l:18
#andi $94 $94 1
#addi $112 $0 20
#sw $94 $112 0
#return
#label l:12
#return
#----------------------------
#func #sort
#addi $113 $0 0
#addi $114 $0 4
#addi $115 $0 8
#addi $116 $0 12
#addi $117 $0 16
#addi $119 $0 -328
#move $118 $119
#move $120 $119
#li $121 0
#sw $121 $120 0
#label l:22
####move $122 $118
#lw $122 $118 0
####move $123 $116
#lw $123 $116 0
#sub $123 $122 $123
#bgez $123 l:23
####move $124 $37
####move $125 $118
#lw $125 $118 0
#muli $126 $125 4
#add $124 $37 $126
####move $127 $113
#lw $127 $113 0
####move $128 $114
#lw $128 $114 0
####move $130 $118
#lw $130 $118 0
#muli $131 $130 4
#add $128 $128 $131
#lw $128 $128 0
#muli $129 $128 4
#add $127 $127 $129
#lw $127 $127 0
#sw $127 $124 0
#label l:24
####move $132 $118
#move $133 $118
#lw $132 $118 0
#addi $134 $132 1
#sw $134 $133 0
#goto l:22
#label l:23
#move $135 $118
#li $136 0
#sw $136 $135 0
#label l:25
####move $137 $118
#lw $137 $118 0
####move $138 $117
#lw $138 $117 0
#sub $138 $137 $138
#bgez $138 l:26
####move $139 $38
####move $140 $118
#lw $140 $118 0
#muli $141 $140 4
#add $139 $38 $141
#li $142 0
#sw $142 $139 0
#label l:27
####move $143 $118
#move $144 $118
#lw $143 $118 0
#addi $145 $143 1
#sw $145 $144 0
#goto l:25
#label l:26
#move $146 $118
#li $147 0
#sw $147 $146 0
#label l:28
####move $148 $118
#lw $148 $118 0
####move $149 $116
#lw $149 $116 0
#sub $149 $148 $149
#bgez $149 l:29
####move $150 $38
####move $151 $37
####move $153 $118
#lw $153 $118 0
#muli $154 $153 4
#add $151 $37 $154
#lw $151 $151 0
#muli $152 $151 4
#add $150 $38 $152
#move $155 $150
#lw $150 $150 0
#addi $156 $150 1
#sw $156 $155 0
#label l:30
####move $157 $118
#move $158 $118
#lw $157 $118 0
#addi $159 $157 1
#sw $159 $158 0
#goto l:28
#label l:29
#move $160 $118
#li $161 1
#sw $161 $160 0
#label l:31
####move $162 $118
#lw $162 $118 0
####move $163 $117
#lw $163 $117 0
#sub $163 $162 $163
#bgez $163 l:32
####move $164 $38
####move $165 $118
#lw $165 $118 0
#muli $166 $165 4
#add $164 $38 $166
####move $167 $38
####move $168 $118
#lw $168 $118 0
#li $170 1
#sub $168 $168 $170
#muli $169 $168 4
#add $167 $38 $169
#lw $171 $164 0
#lw $167 $167 0
#add $171 $171 $167
#sw $171 $164 0
#label l:33
####move $172 $118
#move $173 $118
#lw $172 $118 0
#addi $174 $172 1
#sw $174 $173 0
#goto l:31
#label l:32
#move $175 $118
####move $176 $116
#lw $176 $116 0
#li $177 1
#sub $176 $176 $177
#sw $176 $175 0
#label l:34
####move $178 $118
#lw $178 $118 0
#li $179 0
#sub $179 $178 $179
#bltz $179 l:35
####move $180 $115
#lw $180 $115 0
####move $181 $38
####move $183 $37
####move $185 $118
#lw $185 $118 0
#muli $186 $185 4
#add $183 $37 $186
#lw $183 $183 0
#muli $184 $183 4
#add $181 $38 $184
#move $187 $181
#lw $181 $181 0
#subi $181 $181 1
#sw $181 $187 0
#muli $182 $181 4
#add $180 $180 $182
####move $188 $114
#lw $188 $114 0
####move $189 $118
#lw $189 $118 0
#muli $190 $189 4
#add $188 $188 $190
#lw $188 $188 0
#sw $188 $180 0
#label l:36
####move $191 $118
#move $192 $118
#lw $191 $118 0
#subi $193 $191 1
#sw $193 $192 0
#goto l:34
#label l:35
#return
#----------------------------
#func #dc3
#addi $194 $0 0
#addi $195 $0 4
#addi $196 $0 8
#addi $197 $0 12
#addi $199 $0 -1220
#move $198 $199
#addi $201 $0 -1224
#move $200 $201
#addi $203 $0 -1228
#move $202 $203
####move $204 $194
#lw $204 $194 0
####move $205 $196
#lw $205 $196 0
#muli $205 $205 4
#add $204 $204 $205
#sw $204 $202 0
#addi $207 $0 -1232
#move $206 $207
####move $208 $195
#lw $208 $195 0
####move $209 $196
#lw $209 $196 0
#muli $209 $209 4
#add $208 $208 $209
#sw $208 $206 0
#addi $211 $0 -1236
#move $210 $211
#li $212 0
#sw $212 $210 0
#addi $214 $0 -1240
#move $213 $214
####move $215 $196
#lw $215 $196 0
#li $216 1
#add $215 $215 $216
#li $217 3
#div $215 $215 $217
#sw $215 $213 0
#addi $219 $0 -1244
#move $218 $219
#li $220 0
#sw $220 $218 0
#addi $222 $0 -1248
#move $221 $222
####move $223 $194
#lw $223 $194 0
####move $224 $196
#lw $224 $196 0
#muli $225 $224 4
#add $223 $223 $225
####move $226 $194
#lw $226 $194 0
####move $227 $196
#lw $227 $196 0
#li $229 1
#add $227 $227 $229
#muli $228 $227 4
#add $226 $226 $228
#li $230 0
#sw $230 $226 0
#lw $226 $226 0
#sw $226 $223 0
#move $231 $199
#li $232 0
#sw $232 $231 0
#label l:37
####move $233 $198
#lw $233 $198 0
####move $234 $196
#lw $234 $196 0
#sub $234 $233 $234
#bgez $234 l:38
####move $235 $198
#lw $235 $198 0
#li $236 3
#mod $235 $235 $236
#li $237 0
#sub $237 $235 $237
#beqz $237 l:40
####move $238 $35
####move $239 $218
#move $241 $218
#lw $239 $218 0
#addi $242 $239 1
#sw $242 $241 0
#muli $240 $239 4
#add $238 $35 $240
####move $243 $198
#lw $243 $198 0
#sw $243 $238 0
#label l:40
#label l:39
####move $244 $198
#move $245 $198
#lw $244 $198 0
#addi $246 $244 1
#sw $246 $245 0
#goto l:37
#label l:38
#sw $1 $0 -1252
####move $248 $197
#addi $249 $0 -1256
#lw $248 $197 0
#sw $248 $249 0
####move $250 $218
#addi $251 $0 -1260
#lw $250 $218 0
#sw $250 $251 0
#move $252 $36
#addi $253 $0 -1264
#sw $252 $253 0
#move $254 $35
#addi $255 $0 -1268
#sw $254 $255 0
####move $256 $194
#lw $256 $194 0
#li $257 2
#muli $257 $257 4
#add $256 $256 $257
#addi $258 $0 -1272
#sw $256 $258 0
#addi $0 $0 -1272
#call #sort
#subi $0 $0 -1272
#lw $1 $0 -1252
#sw $1 $0 -1252
####move $260 $197
#addi $261 $0 -1256
#lw $260 $197 0
#sw $260 $261 0
####move $262 $218
#addi $263 $0 -1260
#lw $262 $218 0
#sw $262 $263 0
#move $264 $35
#addi $265 $0 -1264
#sw $264 $265 0
#move $266 $36
#addi $267 $0 -1268
#sw $266 $267 0
####move $268 $194
#lw $268 $194 0
#li $269 1
#muli $269 $269 4
#add $268 $268 $269
#addi $270 $0 -1272
#sw $268 $270 0
#addi $0 $0 -1272
#call #sort
#subi $0 $0 -1272
#lw $1 $0 -1252
#sw $1 $0 -1252
####move $272 $197
#addi $273 $0 -1256
#lw $272 $197 0
#sw $272 $273 0
####move $274 $218
#addi $275 $0 -1260
#lw $274 $218 0
#sw $274 $275 0
#move $276 $36
#addi $277 $0 -1264
#sw $276 $277 0
#move $278 $35
#addi $279 $0 -1268
#sw $278 $279 0
####move $280 $194
#addi $281 $0 -1272
#lw $280 $194 0
#sw $280 $281 0
#addi $0 $0 -1272
#call #sort
#subi $0 $0 -1272
#lw $1 $0 -1252
#move $283 $221
#li $284 1
#sw $284 $283 0
####move $285 $202
#lw $285 $202 0
#sw $1 $0 -1256
####move $288 $213
#addi $289 $0 -1260
#lw $288 $213 0
#sw $288 $289 0
####move $290 $36
#li $291 0
#muli $292 $291 4
#add $290 $36 $292
#addi $293 $0 -1264
#lw $290 $290 0
#sw $290 $293 0
#addi $0 $0 -1264
#call #F
#subi $0 $0 -1264
#lw $1 $0 -1256
#addi $294 $0 -1252
####move $286 $294
#lw $286 $294 0
#muli $287 $286 4
#add $285 $285 $287
#li $295 0
#sw $295 $285 0
#move $282 $198
#li $296 1
#sw $296 $282 0
#label l:41
####move $297 $198
#lw $297 $198 0
####move $298 $218
#lw $298 $218 0
#sub $298 $297 $298
#bgez $298 l:42
#sw $1 $0 -1256
####move $300 $36
####move $301 $198
#lw $301 $198 0
#muli $302 $301 4
#add $300 $36 $302
#addi $303 $0 -1260
#lw $300 $300 0
#sw $300 $303 0
####move $304 $36
####move $305 $198
#lw $305 $198 0
#li $307 1
#sub $305 $305 $307
#muli $306 $305 4
#add $304 $36 $306
#addi $308 $0 -1264
#lw $304 $304 0
#sw $304 $308 0
####move $309 $194
#addi $310 $0 -1268
#lw $309 $194 0
#sw $309 $310 0
#addi $0 $0 -1268
#call #c0
#subi $0 $0 -1268
#lw $1 $0 -1256
#addi $311 $0 -1252
####move $299 $311
#lw $299 $311 0
#beqz $299 l:44
####move $312 $202
#lw $312 $202 0
#sw $1 $0 -1256
####move $315 $213
#addi $316 $0 -1260
#lw $315 $213 0
#sw $315 $316 0
####move $317 $36
####move $318 $198
#lw $318 $198 0
#muli $319 $318 4
#add $317 $36 $319
#addi $320 $0 -1264
#lw $317 $317 0
#sw $317 $320 0
#addi $0 $0 -1264
#call #F
#subi $0 $0 -1264
#lw $1 $0 -1256
#addi $321 $0 -1252
####move $313 $321
#lw $313 $321 0
#muli $314 $313 4
#add $312 $312 $314
####move $322 $221
#lw $322 $221 0
#li $323 1
#sub $322 $322 $323
#sw $322 $312 0
#goto l:45
#label l:44
####move $324 $202
#lw $324 $202 0
#sw $1 $0 -1256
####move $327 $213
#addi $328 $0 -1260
#lw $327 $213 0
#sw $327 $328 0
####move $329 $36
####move $330 $198
#lw $330 $198 0
#muli $331 $330 4
#add $329 $36 $331
#addi $332 $0 -1264
#lw $329 $329 0
#sw $329 $332 0
#addi $0 $0 -1264
#call #F
#subi $0 $0 -1264
#lw $1 $0 -1256
#addi $333 $0 -1252
####move $325 $333
#lw $325 $333 0
#muli $326 $325 4
#add $324 $324 $326
####move $334 $221
#move $335 $221
#lw $334 $221 0
#addi $336 $334 1
#sw $336 $335 0
#sw $334 $324 0
#label l:45
#label l:43
####move $337 $198
#move $338 $198
#lw $337 $198 0
#addi $339 $337 1
#sw $339 $338 0
#goto l:41
#label l:42
####move $340 $221
#lw $340 $221 0
####move $341 $218
#lw $341 $218 0
#sub $341 $340 $341
#bgez $341 l:46
#sw $1 $0 -1252
####move $343 $221
#addi $344 $0 -1256
#lw $343 $221 0
#sw $343 $344 0
####move $345 $218
#addi $346 $0 -1260
#lw $345 $218 0
#sw $345 $346 0
####move $347 $206
#addi $348 $0 -1264
#lw $347 $206 0
#sw $347 $348 0
####move $349 $202
#addi $350 $0 -1268
#lw $349 $202 0
#sw $349 $350 0
#addi $0 $0 -1268
#call #dc3
#subi $0 $0 -1268
#lw $1 $0 -1252
#goto l:47
#label l:46
#move $351 $198
#li $352 0
#sw $352 $351 0
#label l:48
####move $353 $198
#lw $353 $198 0
####move $354 $218
#lw $354 $218 0
#sub $354 $353 $354
#bgez $354 l:49
####move $355 $206
#lw $355 $206 0
####move $356 $202
#lw $356 $202 0
####move $358 $198
#lw $358 $198 0
#muli $359 $358 4
#add $356 $356 $359
#lw $356 $356 0
#muli $357 $356 4
#add $355 $355 $357
####move $360 $198
#lw $360 $198 0
#sw $360 $355 0
#label l:50
####move $361 $198
#move $362 $198
#lw $361 $198 0
#addi $363 $361 1
#sw $363 $362 0
#goto l:48
#label l:49
#label l:47
#move $364 $198
#li $365 0
#sw $365 $364 0
#label l:51
####move $366 $198
#lw $366 $198 0
####move $367 $218
#lw $367 $218 0
#sub $367 $366 $367
#bgez $367 l:52
####move $368 $206
#lw $368 $206 0
####move $369 $198
#lw $369 $198 0
#muli $370 $369 4
#add $368 $368 $370
#lw $368 $368 0
####move $371 $213
#lw $371 $213 0
#sub $371 $368 $371
#bgez $371 l:54
####move $372 $36
####move $373 $210
#move $375 $210
#lw $373 $210 0
#addi $376 $373 1
#sw $376 $375 0
#muli $374 $373 4
#add $372 $36 $374
####move $377 $206
#lw $377 $206 0
####move $378 $198
#lw $378 $198 0
#muli $379 $378 4
#add $377 $377 $379
#lw $377 $377 0
#li $380 3
#mul $377 $377 $380
#sw $377 $372 0
#label l:54
#label l:53
####move $381 $198
#move $382 $198
#lw $381 $198 0
#addi $383 $381 1
#sw $383 $382 0
#goto l:51
#label l:52
####move $384 $196
#lw $384 $196 0
#li $385 3
#mod $384 $384 $385
#li $386 1
#sub $386 $384 $386
#bnez $386 l:55
####move $387 $36
####move $388 $210
#move $390 $210
#lw $388 $210 0
#addi $391 $388 1
#sw $391 $390 0
#muli $389 $388 4
#add $387 $36 $389
####move $392 $196
#lw $392 $196 0
#li $393 1
#sub $392 $392 $393
#sw $392 $387 0
#label l:55
#sw $1 $0 -1252
####move $395 $197
#addi $396 $0 -1256
#lw $395 $197 0
#sw $395 $396 0
####move $397 $210
#addi $398 $0 -1260
#lw $397 $210 0
#sw $397 $398 0
#move $399 $35
#addi $400 $0 -1264
#sw $399 $400 0
#move $401 $36
#addi $402 $0 -1268
#sw $401 $402 0
####move $403 $194
#addi $404 $0 -1272
#lw $403 $194 0
#sw $403 $404 0
#addi $0 $0 -1272
#call #sort
#subi $0 $0 -1272
#lw $1 $0 -1252
#move $405 $198
#li $406 0
#sw $406 $405 0
#label l:56
####move $407 $198
#lw $407 $198 0
####move $408 $218
#lw $408 $218 0
#sub $408 $407 $408
#bgez $408 l:57
####move $409 $37
####move $410 $36
####move $412 $198
#lw $412 $198 0
#muli $413 $412 4
#add $410 $36 $413
#sw $1 $0 -1256
####move $415 $213
#addi $416 $0 -1260
#lw $415 $213 0
#sw $415 $416 0
####move $417 $206
#lw $417 $206 0
####move $418 $198
#lw $418 $198 0
#muli $419 $418 4
#add $417 $417 $419
#addi $420 $0 -1264
#lw $417 $417 0
#sw $417 $420 0
#addi $0 $0 -1264
#call #G
#subi $0 $0 -1264
#lw $1 $0 -1256
#addi $421 $0 -1252
####move $414 $421
#lw $414 $421 0
#sw $414 $410 0
#lw $410 $410 0
#muli $411 $410 4
#add $409 $37 $411
####move $422 $198
#lw $422 $198 0
#sw $422 $409 0
#label l:58
####move $423 $198
#move $424 $198
#lw $423 $198 0
#addi $425 $423 1
#sw $425 $424 0
#goto l:56
#label l:57
#move $427 $198
#li $428 0
#sw $428 $427 0
#move $429 $200
#li $430 0
#sw $430 $429 0
#move $426 $221
#li $431 0
#sw $431 $426 0
#label l:59
####move $432 $198
#lw $432 $198 0
####move $433 $210
#lw $433 $210 0
#sub $433 $432 $433
#bgez $433 l:60
####move $434 $200
#lw $434 $200 0
####move $435 $218
#lw $435 $218 0
#sub $435 $434 $435
#bgez $435 l:60
#sw $1 $0 -1256
####move $437 $36
####move $438 $200
#lw $438 $200 0
#muli $439 $438 4
#add $437 $36 $439
#addi $440 $0 -1260
#lw $437 $437 0
#sw $437 $440 0
####move $441 $35
####move $442 $198
#lw $442 $198 0
#muli $443 $442 4
#add $441 $35 $443
#addi $444 $0 -1264
#lw $441 $441 0
#sw $441 $444 0
####move $445 $194
#addi $446 $0 -1268
#lw $445 $194 0
#sw $445 $446 0
####move $447 $36
####move $448 $200
#lw $448 $200 0
#muli $449 $448 4
#add $447 $36 $449
#lw $447 $447 0
#li $450 3
#mod $447 $447 $450
#addi $451 $0 -1272
#sw $447 $451 0
#addi $0 $0 -1272
#call #c12
#subi $0 $0 -1272
#lw $1 $0 -1256
#addi $452 $0 -1252
####move $436 $452
#lw $436 $452 0
#beqz $436 l:62
####move $453 $195
#lw $453 $195 0
####move $454 $221
#lw $454 $221 0
#muli $455 $454 4
#add $453 $453 $455
####move $456 $35
####move $457 $198
#move $459 $198
#lw $457 $198 0
#addi $460 $457 1
#sw $460 $459 0
#muli $458 $457 4
#add $456 $35 $458
#lw $456 $456 0
#sw $456 $453 0
#goto l:63
#label l:62
####move $461 $195
#lw $461 $195 0
####move $462 $221
#lw $462 $221 0
#muli $463 $462 4
#add $461 $461 $463
####move $464 $36
####move $465 $200
#move $467 $200
#lw $465 $200 0
#addi $468 $465 1
#sw $468 $467 0
#muli $466 $465 4
#add $464 $36 $466
#lw $464 $464 0
#sw $464 $461 0
#label l:63
#label l:61
####move $469 $221
#move $470 $221
#lw $469 $221 0
#addi $471 $469 1
#sw $471 $470 0
#goto l:59
#label l:60
#label l:64
####move $472 $198
#lw $472 $198 0
####move $473 $210
#lw $473 $210 0
#sub $473 $472 $473
#bgez $473 l:65
####move $474 $195
#lw $474 $195 0
####move $475 $221
#lw $475 $221 0
#muli $476 $475 4
#add $474 $474 $476
####move $477 $35
####move $478 $198
#move $480 $198
#lw $478 $198 0
#addi $481 $478 1
#sw $481 $480 0
#muli $479 $478 4
#add $477 $35 $479
#lw $477 $477 0
#sw $477 $474 0
#label l:66
####move $482 $221
#move $483 $221
#lw $482 $221 0
#addi $484 $482 1
#sw $484 $483 0
#goto l:64
#label l:65
#label l:67
####move $485 $200
#lw $485 $200 0
####move $486 $218
#lw $486 $218 0
#sub $486 $485 $486
#bgez $486 l:68
####move $487 $195
#lw $487 $195 0
####move $488 $221
#lw $488 $221 0
#muli $489 $488 4
#add $487 $487 $489
####move $490 $36
####move $491 $200
#move $493 $200
#lw $491 $200 0
#addi $494 $491 1
#sw $494 $493 0
#muli $492 $491 4
#add $490 $36 $492
#lw $490 $490 0
#sw $490 $487 0
#label l:69
####move $495 $221
#move $496 $221
#lw $495 $221 0
#addi $497 $495 1
#sw $497 $496 0
#goto l:67
#label l:68
#return
#----------------------------
#func #getInt
#addi $499 $0 -116
#move $498 $499
#sw $1 $0 -124
#addi $0 $0 -124
#call #getchar
#subi $0 $0 -124
#lw $1 $0 -124
#addi $501 $0 -120
####move $500 $501
#lw $500 $501 0
#sw $500 $498 0
#addi $503 $0 -120
#move $502 $503
#li $504 0
#sw $504 $502 0
#label l:70
####move $505 $498
#lw $505 $498 0
#li $506 48
#sub $506 $505 $506
#bltz $506 l:72
####move $507 $498
#lw $507 $498 0
#li $508 57
#sub $508 $507 $508
#blez $508 l:71
#label l:72
#move $509 $498
#sw $1 $0 -128
#addi $0 $0 -128
#call #getchar
#subi $0 $0 -128
#lw $1 $0 -128
#addi $511 $0 -124
####move $510 $511
#lw $510 $511 0
#sw $510 $509 0
#goto l:70
#label l:71
#label l:73
####move $512 $498
#lw $512 $498 0
#li $513 48
#sub $513 $512 $513
#bltz $513 l:74
####move $514 $498
#lw $514 $498 0
#li $515 57
#sub $515 $514 $515
#bgtz $515 l:74
#move $516 $502
####move $517 $502
#lw $517 $502 0
#li $518 10
#mul $517 $517 $518
####move $519 $498
#lw $519 $498 0
#add $517 $517 $519
#li $520 48
#sub $517 $517 $520
#sw $517 $516 0
#move $521 $498
#sw $1 $0 -128
#addi $0 $0 -128
#call #getchar
#subi $0 $0 -128
#lw $1 $0 -128
#addi $523 $0 -124
####move $522 $523
#lw $522 $523 0
#sw $522 $521 0
#goto l:73
#label l:74
####move $524 $502
#addi $525 $0 4
#lw $524 $502 0
#sw $524 $525 0
#return
#return
#----------------------------
#func #main
#addi $527 $0 -280
#move $526 $527
#addi $529 $0 -284
#move $528 $529
#li $530 0
#sw $530 $528 0
#addi $532 $0 -288
#move $531 $532
#move $533 $527
#addi $0 $0 -296
#call #getInt
#subi $0 $0 -296
#addi $535 $0 -292
####move $534 $535
#lw $534 $535 0
#sw $534 $533 0
#move $536 $532
#li $537 0
#sw $537 $536 0
#label l:75
####move $538 $531
#lw $538 $531 0
####move $539 $526
#lw $539 $526 0
#sub $539 $538 $539
#bgez $539 l:76
####move $541 $39
####move $542 $531
#lw $542 $531 0
#muli $543 $542 4
#add $541 $39 $543
#addi $0 $0 -296
#call #getInt
#subi $0 $0 -296
#addi $545 $0 -292
####move $544 $545
#lw $544 $545 0
#sw $544 $541 0
####move $546 $39
####move $547 $531
#lw $547 $531 0
#muli $548 $547 4
#add $546 $39 $548
#move $549 $546
#lw $546 $546 0
#addi $550 $546 1
#sw $550 $549 0
#move $540 $528
####move $552 $528
#addi $553 $0 -300
#lw $552 $528 0
#sw $552 $553 0
####move $554 $39
####move $555 $531
#lw $555 $531 0
#muli $556 $555 4
#add $554 $39 $556
#lw $554 $554 0
#li $557 1
#add $554 $554 $557
#addi $558 $0 -304
#sw $554 $558 0
#addi $0 $0 -304
#call #max
#subi $0 $0 -304
#addi $559 $0 -292
####move $551 $559
#lw $551 $559 0
#sw $551 $540 0
#label l:77
####move $560 $531
#move $561 $531
#lw $560 $531 0
#addi $562 $560 1
#sw $562 $561 0
#goto l:75
#label l:76
####move $563 $39
####move $564 $526
#move $566 $526
#lw $564 $526 0
#addi $567 $564 1
#sw $567 $566 0
#muli $565 $564 4
#add $563 $39 $565
#li $568 0
#sw $568 $563 0
####move $570 $528
#addi $571 $0 -296
#lw $570 $528 0
#sw $570 $571 0
####move $572 $526
#addi $573 $0 -300
#lw $572 $526 0
#sw $572 $573 0
#move $574 $40
#addi $575 $0 -304
#sw $574 $575 0
#move $576 $39
#addi $577 $0 -308
#sw $576 $577 0
#addi $0 $0 -308
#call #dc3
#subi $0 $0 -308
#move $578 $531
#li $579 0
#sw $579 $578 0
#label l:78
####move $580 $531
#lw $580 $531 0
####move $581 $526
#lw $581 $526 0
#sub $581 $580 $581
#bgez $581 l:79
####move $583 $40
####move $584 $531
#lw $584 $531 0
#muli $585 $584 4
#add $583 $40 $585
#addi $586 $0 -296
#lw $583 $583 0
#sw $583 $586 0
#move $587 $588
#addi $589 $0 -300
#sw $587 $589 0
#addi $0 $0 -300
#call #printf
#subi $0 $0 -300
#label l:80
####move $590 $531
#move $591 $531
#lw $590 $531 0
#addi $592 $590 1
#sw $592 $591 0
#goto l:78
#label l:79
#move $594 $595
#addi $596 $0 -296
#sw $594 $596 0
#addi $0 $0 -296
#call #printf_single
#subi $0 $0 -296
#return
