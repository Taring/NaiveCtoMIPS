.data
temp: .space 732
var0: .space 124
var1: .space 4
var2: .space 4
var3: .space 4
var4: .space 4
var5: .space 40
var6: .space 40
var7: .asciiz "%d\n"
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

__addEdge:
add $8, $29, 0
sw $8, -4($sp)
add $8, $29, 4
sw $8, -8($sp)
lw $9, 8($a3)
add $8, $9, 0
sw $8, -12($sp)
lw $9, 8($a3)
add $8, $9, 120
sw $8, -16($sp)
lw $9, -16($sp)
lw $8, 0($9)
sw $8, -16($sp)
lw $9, -16($sp)
mul $8, $9, 4
sw $8, -20($sp)
lw $9, -12($sp)
lw $10, -20($sp)
add $8, $9, $10
sw $8, -12($sp)
lw $9, -8($sp)
lw $8, 0($9)
sw $8, -24($sp)
lw $8, -24($sp)
lw $9, -12($sp)
sw $8, 0($9)
lw $9, 8($a3)
add $8, $9, 40
sw $8, -28($sp)
lw $9, 8($a3)
add $8, $9, 120
sw $8, -32($sp)
lw $9, -32($sp)
lw $8, 0($9)
sw $8, -32($sp)
lw $9, -32($sp)
mul $8, $9, 4
sw $8, -36($sp)
lw $9, -28($sp)
lw $10, -36($sp)
add $8, $9, $10
sw $8, -28($sp)
lw $9, 8($a3)
add $8, $9, 80
sw $8, -40($sp)
lw $9, -4($sp)
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
lw $8, -40($sp)
lw $9, -28($sp)
sw $8, 0($9)
lw $9, 8($a3)
add $8, $9, 80
sw $8, -52($sp)
lw $9, -4($sp)
lw $8, 0($9)
sw $8, -56($sp)
lw $9, -56($sp)
mul $8, $9, 4
sw $8, -60($sp)
lw $9, -52($sp)
lw $10, -60($sp)
add $8, $9, $10
sw $8, -52($sp)
lw $9, 8($a3)
add $8, $9, 120
sw $8, -64($sp)
lw $9, -64($sp)
move $8, $9
sw $8, -68($sp)
lw $9, -64($sp)
lw $8, 0($9)
sw $8, -64($sp)
lw $9, -64($sp)
add $8, $9, 1
sw $8, -72($sp)
lw $8, -72($sp)
lw $9, -68($sp)
sw $8, 0($9)
lw $8, -64($sp)
lw $9, -52($sp)
sw $8, 0($9)
jr $ra
__dfs:
add $8, $29, 0
sw $8, -4($sp)
add $8, $29, -168
sw $8, -12($sp)
lw $9, -12($sp)
move $8, $9
sw $8, -8($sp)
add $8, $29, -172
sw $8, -20($sp)
lw $9, -20($sp)
move $8, $9
sw $8, -16($sp)
lw $9, -12($sp)
move $8, $9
sw $8, -24($sp)
lw $9, 8($a3)
add $8, $9, 80
sw $8, -28($sp)
lw $9, -4($sp)
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
lw $8, -28($sp)
lw $9, -24($sp)
sw $8, 0($9)
label0:
lw $9, -8($sp)
lw $8, 0($9)
sw $8, -40($sp)
lw $9, -40($sp)
not $8, $9
sw $8, -40($sp)
lw $8, -40($sp)
beqz $8, label1
lw $9, -16($sp)
move $8, $9
sw $8, -44($sp)
lw $9, 8($a3)
add $8, $9, 0
sw $8, -48($sp)
lw $9, -8($sp)
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
lw $8, -48($sp)
lw $9, -44($sp)
sw $8, 0($9)
lw $9, -16($sp)
lw $8, 0($9)
sw $8, -64($sp)
lw $9, -64($sp)
mul $8, $9, 4
sw $8, -68($sp)
lw $9, 104($a3)
lw $10, -68($sp)
add $8, $9, $10
sw $8, -60($sp)
lw $9, -60($sp)
lw $8, 0($9)
sw $8, -60($sp)
lw $8, -60($sp)
beqz $8, label3
j label2
label3:
lw $9, -16($sp)
lw $8, 0($9)
sw $8, -76($sp)
lw $9, -76($sp)
mul $8, $9, 4
sw $8, -80($sp)
lw $9, 104($a3)
lw $10, -80($sp)
add $8, $9, $10
sw $8, -72($sp)
li $8, 1
sw $8, -84($sp)
lw $8, -84($sp)
lw $9, -72($sp)
sw $8, 0($9)
lw $9, -16($sp)
lw $8, 0($9)
sw $8, -92($sp)
lw $9, -92($sp)
mul $8, $9, 4
sw $8, -96($sp)
lw $9, 100($a3)
lw $10, -96($sp)
add $8, $9, $10
sw $8, -88($sp)
lw $9, -88($sp)
lw $8, 0($9)
sw $8, -88($sp)
li $8, -1
sw $8, -100($sp)
lw $9, -88($sp)
lw $10, -100($sp)
sub $8, $9, $10
sw $8, -100($sp)
lw $8, -100($sp)
beqz $8, label5
sw $31, -180($29)
add $8, $29, -184
sw $8, -112($sp)
lw $9, -16($sp)
lw $8, 0($9)
sw $8, -108($sp)
lw $8, -108($sp)
lw $9, -112($sp)
sw $8, 0($9)
add $29, $29, -184
jal __dfs
sub $29, $29, -184
lw $31, -180($29)
add $8, $29, -176
sw $8, -116($sp)
lw $9, -116($sp)
lw $8, 0($9)
sw $8, -104($sp)
lw $8, -104($sp)
beqz $8, label4
label5:
lw $9, -16($sp)
lw $8, 0($9)
sw $8, -124($sp)
lw $9, -124($sp)
mul $8, $9, 4
sw $8, -128($sp)
lw $9, 100($a3)
lw $10, -128($sp)
add $8, $9, $10
sw $8, -120($sp)
lw $9, -4($sp)
lw $8, 0($9)
sw $8, -132($sp)
lw $8, -132($sp)
lw $9, -120($sp)
sw $8, 0($9)
li $8, 1
sw $8, -136($sp)
add $8, $29, 8
sw $8, -140($sp)
lw $8, -136($sp)
lw $9, -140($sp)
sw $8, 0($9)
jr $ra
label4:
label2:
lw $9, -8($sp)
move $8, $9
sw $8, -144($sp)
lw $9, 8($a3)
add $8, $9, 40
sw $8, -148($sp)
lw $9, -8($sp)
lw $8, 0($9)
sw $8, -152($sp)
lw $9, -152($sp)
mul $8, $9, 4
sw $8, -156($sp)
lw $9, -148($sp)
lw $10, -156($sp)
add $8, $9, $10
sw $8, -148($sp)
lw $9, -148($sp)
lw $8, 0($9)
sw $8, -148($sp)
lw $8, -148($sp)
lw $9, -144($sp)
sw $8, 0($9)
j label0
label1:
li $8, 0
sw $8, -160($sp)
add $8, $29, 8
sw $8, -164($sp)
lw $8, -160($sp)
lw $9, -164($sp)
sw $8, 0($9)
jr $ra
jr $ra
__getInt:
add $8, $29, -120
sw $8, -8($sp)
lw $9, -8($sp)
move $8, $9
sw $8, -4($sp)
add $8, $29, -124
sw $8, -16($sp)
lw $9, -16($sp)
move $8, $9
sw $8, -12($sp)
li $8, 0
sw $8, -20($sp)
lw $8, -20($sp)
lw $9, -12($sp)
sw $8, 0($9)
lw $9, -8($sp)
move $8, $9
sw $8, -24($sp)
sw $31, -132($29)
add $29, $29, -132
jal __getchar
sub $29, $29, -132
lw $31, -132($29)
add $8, $29, -128
sw $8, -32($sp)
lw $9, -32($sp)
lw $8, 0($9)
sw $8, -28($sp)
lw $8, -28($sp)
lw $9, -24($sp)
sw $8, 0($9)
label6:
lw $9, -4($sp)
lw $8, 0($9)
sw $8, -36($sp)
li $8, 48
sw $8, -40($sp)
lw $9, -36($sp)
lw $10, -40($sp)
sub $8, $9, $10
sw $8, -40($sp)
lw $8, -40($sp)
bltz $8, label8
lw $9, -4($sp)
lw $8, 0($9)
sw $8, -44($sp)
li $8, 57
sw $8, -48($sp)
lw $9, -44($sp)
lw $10, -48($sp)
sub $8, $9, $10
sw $8, -48($sp)
lw $8, -48($sp)
blez $8, label7
label8:
lw $9, -4($sp)
move $8, $9
sw $8, -52($sp)
sw $31, -132($29)
add $29, $29, -132
jal __getchar
sub $29, $29, -132
lw $31, -132($29)
add $8, $29, -128
sw $8, -60($sp)
lw $9, -60($sp)
lw $8, 0($9)
sw $8, -56($sp)
lw $8, -56($sp)
lw $9, -52($sp)
sw $8, 0($9)
j label6
label7:
label9:
lw $9, -4($sp)
lw $8, 0($9)
sw $8, -64($sp)
li $8, 48
sw $8, -68($sp)
lw $9, -64($sp)
lw $10, -68($sp)
sub $8, $9, $10
sw $8, -68($sp)
lw $8, -68($sp)
bltz $8, label10
lw $9, -4($sp)
lw $8, 0($9)
sw $8, -72($sp)
li $8, 57
sw $8, -76($sp)
lw $9, -72($sp)
lw $10, -76($sp)
sub $8, $9, $10
sw $8, -76($sp)
lw $8, -76($sp)
bgtz $8, label10
lw $9, -12($sp)
move $8, $9
sw $8, -80($sp)
lw $9, -12($sp)
lw $8, 0($9)
sw $8, -84($sp)
li $8, 10
sw $8, -88($sp)
lw $9, -84($sp)
lw $10, -88($sp)
mul $8, $9, $10
sw $8, -84($sp)
lw $9, -4($sp)
lw $8, 0($9)
sw $8, -92($sp)
lw $9, -84($sp)
lw $10, -92($sp)
add $8, $9, $10
sw $8, -84($sp)
li $8, 48
sw $8, -96($sp)
lw $9, -84($sp)
lw $10, -96($sp)
sub $8, $9, $10
sw $8, -84($sp)
lw $8, -84($sp)
lw $9, -80($sp)
sw $8, 0($9)
lw $9, -4($sp)
move $8, $9
sw $8, -100($sp)
sw $31, -132($29)
add $29, $29, -132
jal __getchar
sub $29, $29, -132
lw $31, -132($29)
add $8, $29, -128
sw $8, -108($sp)
lw $9, -108($sp)
lw $8, 0($9)
sw $8, -104($sp)
lw $8, -104($sp)
lw $9, -100($sp)
sw $8, 0($9)
j label9
label10:
add $8, $29, 4
sw $8, -116($sp)
lw $9, -12($sp)
lw $8, 0($9)
sw $8, -112($sp)
lw $8, -112($sp)
lw $9, -116($sp)
sw $8, 0($9)
jr $ra
jr $ra
main:
la $a3, temp
la $t0, var0
sw $t0, 8($a3)
la $t0, var1
sw $t0, 84($a3)
la $t0, var2
sw $t0, 88($a3)
la $t0, var3
sw $t0, 92($a3)
la $t0, var4
sw $t0, 96($a3)
la $t0, var5
sw $t0, 100($a3)
la $t0, var6
sw $t0, 104($a3)
la $t0, var7
sw $t0, 716($a3)
add $8, $29, -344
sw $8, -8($sp)
lw $9, -8($sp)
move $8, $9
sw $8, -4($sp)
add $8, $29, -348
sw $8, -16($sp)
lw $9, -16($sp)
move $8, $9
sw $8, -12($sp)
add $8, $29, -352
sw $8, -24($sp)
lw $9, -24($sp)
move $8, $9
sw $8, -20($sp)
li $8, 0
sw $8, -28($sp)
lw $8, -28($sp)
lw $9, -20($sp)
sw $8, 0($9)
lw $9, 84($a3)
move $8, $9
sw $8, -32($sp)
add $29, $29, -360
jal __getInt
sub $29, $29, -360
add $8, $29, -356
sw $8, -40($sp)
lw $9, -40($sp)
lw $8, 0($9)
sw $8, -36($sp)
lw $8, -36($sp)
lw $9, -32($sp)
sw $8, 0($9)
lw $9, 88($a3)
move $8, $9
sw $8, -44($sp)
add $29, $29, -360
jal __getInt
sub $29, $29, -360
add $8, $29, -356
sw $8, -52($sp)
lw $9, -52($sp)
lw $8, 0($9)
sw $8, -48($sp)
lw $8, -48($sp)
lw $9, -44($sp)
sw $8, 0($9)
lw $9, 8($a3)
add $8, $9, 120
sw $8, -56($sp)
li $8, 0
sw $8, -60($sp)
lw $8, -60($sp)
lw $9, -56($sp)
sw $8, 0($9)
lw $9, -8($sp)
move $8, $9
sw $8, -64($sp)
li $8, 0
sw $8, -68($sp)
lw $8, -68($sp)
lw $9, -64($sp)
sw $8, 0($9)
label11:
lw $9, -4($sp)
lw $8, 0($9)
sw $8, -72($sp)
li $8, 10
sw $8, -76($sp)
lw $9, -72($sp)
lw $10, -76($sp)
sub $8, $9, $10
sw $8, -76($sp)
lw $8, -76($sp)
bgez $8, label12
lw $9, 8($a3)
add $8, $9, 80
sw $8, -80($sp)
lw $9, -4($sp)
lw $8, 0($9)
sw $8, -84($sp)
lw $9, -84($sp)
mul $8, $9, 4
sw $8, -88($sp)
lw $9, -80($sp)
lw $10, -88($sp)
add $8, $9, $10
sw $8, -80($sp)
li $8, -1
sw $8, -92($sp)
lw $8, -92($sp)
lw $9, -80($sp)
sw $8, 0($9)
label13:
lw $9, -4($sp)
move $8, $9
sw $8, -100($sp)
lw $9, -4($sp)
lw $8, 0($9)
sw $8, -96($sp)
lw $9, -96($sp)
add $8, $9, 1
sw $8, -104($sp)
lw $8, -104($sp)
lw $9, -100($sp)
sw $8, 0($9)
j label11
label12:
lw $9, -4($sp)
move $8, $9
sw $8, -108($sp)
li $8, 1
sw $8, -112($sp)
lw $8, -112($sp)
lw $9, -108($sp)
sw $8, 0($9)
label14:
lw $9, -4($sp)
lw $8, 0($9)
sw $8, -116($sp)
lw $9, 88($a3)
lw $8, 0($9)
sw $8, -120($sp)
lw $9, -116($sp)
lw $10, -120($sp)
sub $8, $9, $10
sw $8, -120($sp)
lw $8, -120($sp)
bgtz $8, label15
lw $9, 92($a3)
move $8, $9
sw $8, -124($sp)
add $29, $29, -360
jal __getInt
sub $29, $29, -360
add $8, $29, -356
sw $8, -132($sp)
lw $9, -132($sp)
lw $8, 0($9)
sw $8, -128($sp)
lw $8, -128($sp)
lw $9, -124($sp)
sw $8, 0($9)
lw $9, 96($a3)
move $8, $9
sw $8, -136($sp)
add $29, $29, -360
jal __getInt
sub $29, $29, -360
add $8, $29, -356
sw $8, -144($sp)
lw $9, -144($sp)
lw $8, 0($9)
sw $8, -140($sp)
lw $8, -140($sp)
lw $9, -136($sp)
sw $8, 0($9)
add $8, $29, -360
sw $8, -156($sp)
lw $9, 96($a3)
lw $8, 0($9)
sw $8, -152($sp)
lw $8, -152($sp)
lw $9, -156($sp)
sw $8, 0($9)
add $8, $29, -364
sw $8, -164($sp)
lw $9, 92($a3)
lw $8, 0($9)
sw $8, -160($sp)
lw $8, -160($sp)
lw $9, -164($sp)
sw $8, 0($9)
add $29, $29, -364
jal __addEdge
sub $29, $29, -364
label16:
lw $9, -4($sp)
move $8, $9
sw $8, -172($sp)
lw $9, -4($sp)
lw $8, 0($9)
sw $8, -168($sp)
lw $9, -168($sp)
add $8, $9, 1
sw $8, -176($sp)
lw $8, -176($sp)
lw $9, -172($sp)
sw $8, 0($9)
j label14
label15:
lw $9, -4($sp)
move $8, $9
sw $8, -180($sp)
li $8, 1
sw $8, -184($sp)
lw $8, -184($sp)
lw $9, -180($sp)
sw $8, 0($9)
label17:
lw $9, -4($sp)
lw $8, 0($9)
sw $8, -188($sp)
lw $9, 84($a3)
lw $8, 0($9)
sw $8, -192($sp)
lw $9, -188($sp)
lw $10, -192($sp)
sub $8, $9, $10
sw $8, -192($sp)
lw $8, -192($sp)
bgtz $8, label18
lw $9, -4($sp)
lw $8, 0($9)
sw $8, -200($sp)
lw $9, -200($sp)
mul $8, $9, 4
sw $8, -204($sp)
lw $9, 100($a3)
lw $10, -204($sp)
add $8, $9, $10
sw $8, -196($sp)
li $8, -1
sw $8, -208($sp)
lw $8, -208($sp)
lw $9, -196($sp)
sw $8, 0($9)
label19:
lw $9, -4($sp)
move $8, $9
sw $8, -216($sp)
lw $9, -4($sp)
lw $8, 0($9)
sw $8, -212($sp)
lw $9, -212($sp)
add $8, $9, 1
sw $8, -212($sp)
lw $8, -212($sp)
lw $9, -216($sp)
sw $8, 0($9)
j label17
label18:
lw $9, -4($sp)
move $8, $9
sw $8, -220($sp)
li $8, 1
sw $8, -224($sp)
lw $8, -224($sp)
lw $9, -220($sp)
sw $8, 0($9)
label20:
lw $9, -4($sp)
lw $8, 0($9)
sw $8, -228($sp)
lw $9, 84($a3)
lw $8, 0($9)
sw $8, -232($sp)
lw $9, -228($sp)
lw $10, -232($sp)
sub $8, $9, $10
sw $8, -232($sp)
lw $8, -232($sp)
bgtz $8, label21
lw $9, -12($sp)
move $8, $9
sw $8, -236($sp)
li $8, 1
sw $8, -240($sp)
lw $8, -240($sp)
lw $9, -236($sp)
sw $8, 0($9)
label23:
lw $9, -12($sp)
lw $8, 0($9)
sw $8, -244($sp)
lw $9, 84($a3)
lw $8, 0($9)
sw $8, -248($sp)
lw $9, -244($sp)
lw $10, -248($sp)
sub $8, $9, $10
sw $8, -248($sp)
lw $8, -248($sp)
bgtz $8, label24
lw $9, -12($sp)
lw $8, 0($9)
sw $8, -256($sp)
lw $9, -256($sp)
mul $8, $9, 4
sw $8, -260($sp)
lw $9, 104($a3)
lw $10, -260($sp)
add $8, $9, $10
sw $8, -252($sp)
li $8, 0
sw $8, -264($sp)
lw $8, -264($sp)
lw $9, -252($sp)
sw $8, 0($9)
label25:
lw $9, -12($sp)
move $8, $9
sw $8, -272($sp)
lw $9, -12($sp)
lw $8, 0($9)
sw $8, -268($sp)
lw $9, -268($sp)
add $8, $9, 1
sw $8, -276($sp)
lw $8, -276($sp)
lw $9, -272($sp)
sw $8, 0($9)
j label23
label24:
lw $9, -20($sp)
move $8, $9
sw $8, -280($sp)
add $8, $29, -364
sw $8, -292($sp)
lw $9, -4($sp)
lw $8, 0($9)
sw $8, -288($sp)
lw $8, -288($sp)
lw $9, -292($sp)
sw $8, 0($9)
add $29, $29, -364
jal __dfs
sub $29, $29, -364
add $8, $29, -356
sw $8, -296($sp)
lw $9, -20($sp)
lw $8, 0($9)
sw $8, -300($sp)
lw $9, -296($sp)
lw $8, 0($9)
sw $8, -284($sp)
lw $9, -300($sp)
lw $10, -284($sp)
add $8, $9, $10
sw $8, -300($sp)
lw $8, -300($sp)
lw $9, -280($sp)
sw $8, 0($9)
label22:
lw $9, -4($sp)
move $8, $9
sw $8, -308($sp)
lw $9, -4($sp)
lw $8, 0($9)
sw $8, -304($sp)
lw $9, -304($sp)
add $8, $9, 1
sw $8, -312($sp)
lw $8, -312($sp)
lw $9, -308($sp)
sw $8, 0($9)
j label20
label21:
add $8, $29, -360
sw $8, -324($sp)
lw $9, -20($sp)
lw $8, 0($9)
sw $8, -320($sp)
lw $8, -320($sp)
lw $9, -324($sp)
sw $8, 0($9)
lw $9, 716($a3)
move $8, $9
sw $8, -328($sp)
add $8, $29, -364
sw $8, -332($sp)
lw $8, -328($sp)
lw $9, -332($sp)
sw $8, 0($9)
add $29, $29, -364
jal __printf
sub $29, $29, -364
li $8, 0
sw $8, -336($sp)
add $8, $29, 4
sw $8, -340($sp)
lw $8, -336($sp)
lw $9, -340($sp)
sw $8, 0($9)
j __main_end
j __main_end
__main_end:
li $v0, 10
syscall
#global $2 124
#global $21 4
#global $22 4
#global $23 4
#global $24 4
#global $25 40
#global $26 40
#string $179 #%d\n
#----------------------------
#func #addEdge
#addi $3 $0 0
#addi $4 $0 4
####move $5 $2
#addi $5 $2 0
####move $6 $2
#addi $6 $2 120
#lw $6 $6 0
#muli $7 $6 4
#add $5 $5 $7
####move $8 $4
#lw $8 $4 0
#sw $8 $5 0
####move $9 $2
#addi $9 $2 40
####move $10 $2
#addi $10 $2 120
#lw $10 $10 0
#muli $11 $10 4
#add $9 $9 $11
####move $12 $2
#addi $12 $2 80
####move $13 $3
#lw $13 $3 0
#muli $14 $13 4
#add $12 $12 $14
#lw $12 $12 0
#sw $12 $9 0
####move $15 $2
#addi $15 $2 80
####move $16 $3
#lw $16 $3 0
#muli $17 $16 4
#add $15 $15 $17
####move $18 $2
#addi $18 $2 120
#move $19 $18
#lw $18 $18 0
#addi $20 $18 1
#sw $20 $19 0
#sw $18 $15 0
#return
#----------------------------
#func #dfs
#addi $27 $0 0
#addi $29 $0 -168
#move $28 $29
#addi $31 $0 -172
#move $30 $31
#move $32 $29
####move $33 $2
#addi $33 $2 80
####move $34 $27
#lw $34 $27 0
#muli $35 $34 4
#add $33 $33 $35
#lw $33 $33 0
#sw $33 $32 0
#label l:0
####move $36 $28
#lw $36 $28 0
#not $36 $36
#beqz $36 l:1
#move $37 $30
####move $38 $2
#addi $38 $2 0
####move $39 $28
#lw $39 $28 0
#muli $40 $39 4
#add $38 $38 $40
#lw $38 $38 0
#sw $38 $37 0
####move $41 $26
####move $42 $30
#lw $42 $30 0
#muli $43 $42 4
#add $41 $26 $43
#lw $41 $41 0
#beqz $41 l:3
#goto l:2
#label l:3
####move $44 $26
####move $45 $30
#lw $45 $30 0
#muli $46 $45 4
#add $44 $26 $46
#li $47 1
#sw $47 $44 0
####move $48 $25
####move $49 $30
#lw $49 $30 0
#muli $50 $49 4
#add $48 $25 $50
#lw $48 $48 0
#li $51 -1
#sub $51 $48 $51
#beqz $51 l:5
#sw $1 $0 -180
####move $53 $30
#addi $54 $0 -184
#lw $53 $30 0
#sw $53 $54 0
#addi $0 $0 -184
#call #dfs
#subi $0 $0 -184
#lw $1 $0 -180
#addi $55 $0 -176
####move $52 $55
#lw $52 $55 0
#beqz $52 l:4
#label l:5
####move $56 $25
####move $57 $30
#lw $57 $30 0
#muli $58 $57 4
#add $56 $25 $58
####move $59 $27
#lw $59 $27 0
#sw $59 $56 0
#li $60 1
#addi $61 $0 8
#sw $60 $61 0
#return
#label l:4
#label l:2
#move $62 $28
####move $63 $2
#addi $63 $2 40
####move $64 $28
#lw $64 $28 0
#muli $65 $64 4
#add $63 $63 $65
#lw $63 $63 0
#sw $63 $62 0
#goto l:0
#label l:1
#li $66 0
#addi $67 $0 8
#sw $66 $67 0
#return
#return
#----------------------------
#func #getInt
#addi $69 $0 -120
#move $68 $69
#addi $71 $0 -124
#move $70 $71
#li $72 0
#sw $72 $70 0
#move $73 $69
#sw $1 $0 -132
#addi $0 $0 -132
#call #getchar
#subi $0 $0 -132
#lw $1 $0 -132
#addi $75 $0 -128
####move $74 $75
#lw $74 $75 0
#sw $74 $73 0
#label l:6
####move $76 $68
#lw $76 $68 0
#li $77 48
#sub $77 $76 $77
#bltz $77 l:8
####move $78 $68
#lw $78 $68 0
#li $79 57
#sub $79 $78 $79
#blez $79 l:7
#label l:8
#move $80 $68
#sw $1 $0 -132
#addi $0 $0 -132
#call #getchar
#subi $0 $0 -132
#lw $1 $0 -132
#addi $82 $0 -128
####move $81 $82
#lw $81 $82 0
#sw $81 $80 0
#goto l:6
#label l:7
#label l:9
####move $83 $68
#lw $83 $68 0
#li $84 48
#sub $84 $83 $84
#bltz $84 l:10
####move $85 $68
#lw $85 $68 0
#li $86 57
#sub $86 $85 $86
#bgtz $86 l:10
#move $87 $70
####move $88 $70
#lw $88 $70 0
#li $89 10
#mul $88 $88 $89
####move $90 $68
#lw $90 $68 0
#add $88 $88 $90
#li $91 48
#sub $88 $88 $91
#sw $88 $87 0
#move $92 $68
#sw $1 $0 -132
#addi $0 $0 -132
#call #getchar
#subi $0 $0 -132
#lw $1 $0 -132
#addi $94 $0 -128
####move $93 $94
#lw $93 $94 0
#sw $93 $92 0
#goto l:9
#label l:10
####move $95 $70
#addi $96 $0 4
#lw $95 $70 0
#sw $95 $96 0
#return
#return
#----------------------------
#func #main
#addi $98 $0 -344
#move $97 $98
#addi $100 $0 -348
#move $99 $100
#addi $102 $0 -352
#move $101 $102
#li $103 0
#sw $103 $101 0
#move $104 $21
#addi $0 $0 -360
#call #getInt
#subi $0 $0 -360
#addi $106 $0 -356
####move $105 $106
#lw $105 $106 0
#sw $105 $104 0
#move $107 $22
#addi $0 $0 -360
#call #getInt
#subi $0 $0 -360
#addi $109 $0 -356
####move $108 $109
#lw $108 $109 0
#sw $108 $107 0
####move $110 $2
#addi $110 $2 120
#li $111 0
#sw $111 $110 0
#move $112 $98
#li $113 0
#sw $113 $112 0
#label l:11
####move $114 $97
#lw $114 $97 0
#li $115 10
#sub $115 $114 $115
#bgez $115 l:12
####move $116 $2
#addi $116 $2 80
####move $117 $97
#lw $117 $97 0
#muli $118 $117 4
#add $116 $116 $118
#li $119 -1
#sw $119 $116 0
#label l:13
####move $120 $97
#move $121 $97
#lw $120 $97 0
#addi $122 $120 1
#sw $122 $121 0
#goto l:11
#label l:12
#move $123 $97
#li $124 1
#sw $124 $123 0
#label l:14
####move $125 $97
#lw $125 $97 0
####move $126 $22
#lw $126 $22 0
#sub $126 $125 $126
#bgtz $126 l:15
#move $127 $23
#addi $0 $0 -360
#call #getInt
#subi $0 $0 -360
#addi $129 $0 -356
####move $128 $129
#lw $128 $129 0
#sw $128 $127 0
#move $130 $24
#addi $0 $0 -360
#call #getInt
#subi $0 $0 -360
#addi $132 $0 -356
####move $131 $132
#lw $131 $132 0
#sw $131 $130 0
####move $134 $24
#addi $135 $0 -360
#lw $134 $24 0
#sw $134 $135 0
####move $136 $23
#addi $137 $0 -364
#lw $136 $23 0
#sw $136 $137 0
#addi $0 $0 -364
#call #addEdge
#subi $0 $0 -364
#label l:16
####move $138 $97
#move $139 $97
#lw $138 $97 0
#addi $140 $138 1
#sw $140 $139 0
#goto l:14
#label l:15
#move $141 $97
#li $142 1
#sw $142 $141 0
#label l:17
####move $143 $97
#lw $143 $97 0
####move $144 $21
#lw $144 $21 0
#sub $144 $143 $144
#bgtz $144 l:18
####move $145 $25
####move $146 $97
#lw $146 $97 0
#muli $147 $146 4
#add $145 $25 $147
#li $148 -1
#sw $148 $145 0
#label l:19
####move $149 $97
#move $150 $97
#lw $149 $97 0
#addi $149 $149 1
#sw $149 $150 0
#goto l:17
#label l:18
#move $151 $97
#li $152 1
#sw $152 $151 0
#label l:20
####move $153 $97
#lw $153 $97 0
####move $154 $21
#lw $154 $21 0
#sub $154 $153 $154
#bgtz $154 l:21
#move $155 $99
#li $156 1
#sw $156 $155 0
#label l:23
####move $157 $99
#lw $157 $99 0
####move $158 $21
#lw $158 $21 0
#sub $158 $157 $158
#bgtz $158 l:24
####move $159 $26
####move $160 $99
#lw $160 $99 0
#muli $161 $160 4
#add $159 $26 $161
#li $162 0
#sw $162 $159 0
#label l:25
####move $163 $99
#move $164 $99
#lw $163 $99 0
#addi $165 $163 1
#sw $165 $164 0
#goto l:23
#label l:24
#move $166 $101
####move $168 $97
#addi $169 $0 -364
#lw $168 $97 0
#sw $168 $169 0
#addi $0 $0 -364
#call #dfs
#subi $0 $0 -364
#addi $170 $0 -356
####move $167 $170
#lw $171 $101 0
#lw $167 $170 0
#add $171 $171 $167
#sw $171 $166 0
#label l:22
####move $172 $97
#move $173 $97
#lw $172 $97 0
#addi $174 $172 1
#sw $174 $173 0
#goto l:20
#label l:21
####move $176 $101
#addi $177 $0 -360
#lw $176 $101 0
#sw $176 $177 0
#move $178 $179
#addi $180 $0 -364
#sw $178 $180 0
#addi $0 $0 -364
#call #printf
#subi $0 $0 -364
#li $181 0
#addi $182 $0 4
#sw $181 $182 0
#return
#return
