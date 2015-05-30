.data
temp: .space 748
var0: .space 200
var1: .space 4
var2: .space 8000
var3: .space 200
var4: .space 8000
var5: .space 4
var6: .space 4
var7: .asciiz "%d "
.align 2
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

__init:
add $8, $29, -48
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
sw $31, -56($29)
add $29, $29, -56
jal __getchar
sub $29, $29, -56
lw $31, -56($29)
add $8, $29, -52
sw $8, -24($sp)
lw $9, -24($sp)
lw $8, 0($9)
sw $8, -20($sp)
li $8, 48
sw $8, -28($sp)
lw $9, -20($sp)
lw $10, -28($sp)
sub $8, $9, $10
sw $8, -20($sp)
lw $8, -20($sp)
lw $9, -16($sp)
sw $8, 0($9)
sw $31, -56($29)
add $29, $29, -56
jal __getchar
sub $29, $29, -56
lw $31, -56($29)
add $8, $29, -52
sw $8, -36($sp)
add $8, $29, 4
sw $8, -44($sp)
lw $9, -4($sp)
lw $8, 0($9)
sw $8, -40($sp)
lw $8, -40($sp)
lw $9, -44($sp)
sw $8, 0($9)
jr $ra
jr $ra
__clear:
add $8, $29, -64
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
label0:
lw $9, -4($sp)
lw $8, 0($9)
sw $8, -20($sp)
li $8, 50
sw $8, -24($sp)
lw $9, -20($sp)
lw $10, -24($sp)
sub $8, $9, $10
sw $8, -24($sp)
lw $8, -24($sp)
bgtz $8, label1
lw $9, -4($sp)
lw $8, 0($9)
sw $8, -32($sp)
lw $9, -32($sp)
mul $8, $9, 4
sw $8, -36($sp)
lw $9, 8($a3)
lw $10, -36($sp)
add $8, $9, $10
sw $8, -28($sp)
li $8, 0
sw $8, -40($sp)
lw $8, -40($sp)
lw $9, -28($sp)
sw $8, 0($9)
label2:
lw $9, -4($sp)
move $8, $9
sw $8, -48($sp)
lw $9, -4($sp)
lw $8, 0($9)
sw $8, -44($sp)
lw $9, -44($sp)
add $8, $9, 1
sw $8, -52($sp)
lw $8, -52($sp)
lw $9, -48($sp)
sw $8, 0($9)
j label0
label1:
lw $9, 12($a3)
move $8, $9
sw $8, -56($sp)
li $8, 0
sw $8, -60($sp)
lw $8, -60($sp)
lw $9, -56($sp)
sw $8, 0($9)
jr $ra
__ins:
add $8, $29, 0
sw $8, -4($sp)
add $8, $29, 4
sw $8, -8($sp)
add $8, $29, 8
sw $8, -12($sp)
add $8, $29, -88
sw $8, -20($sp)
lw $9, -20($sp)
move $8, $9
sw $8, -16($sp)
sw $31, -96($29)
li $8, 12
sw $8, -28($sp)
add $8, $29, -100
sw $8, -32($sp)
lw $8, -28($sp)
lw $9, -32($sp)
sw $8, 0($9)
add $29, $29, -100
jal __malloc
sub $29, $29, -100
lw $31, -96($29)
add $8, $29, -92
sw $8, -36($sp)
lw $9, -36($sp)
lw $8, 0($9)
sw $8, -24($sp)
lw $8, -24($sp)
lw $9, -16($sp)
sw $8, 0($9)
lw $9, -16($sp)
lw $8, 0($9)
sw $8, -40($sp)
lw $9, -40($sp)
add $8, $9, 0
sw $8, -40($sp)
lw $9, -8($sp)
lw $8, 0($9)
sw $8, -44($sp)
lw $8, -44($sp)
lw $9, -40($sp)
sw $8, 0($9)
lw $9, -16($sp)
lw $8, 0($9)
sw $8, -48($sp)
lw $9, -48($sp)
add $8, $9, 8
sw $8, -48($sp)
lw $9, -4($sp)
lw $8, 0($9)
sw $8, -56($sp)
lw $9, -56($sp)
mul $8, $9, 4
sw $8, -60($sp)
lw $9, 8($a3)
lw $10, -60($sp)
add $8, $9, $10
sw $8, -52($sp)
lw $9, -52($sp)
lw $8, 0($9)
sw $8, -52($sp)
lw $8, -52($sp)
lw $9, -48($sp)
sw $8, 0($9)
lw $9, -16($sp)
lw $8, 0($9)
sw $8, -64($sp)
lw $9, -64($sp)
add $8, $9, 4
sw $8, -64($sp)
lw $9, -12($sp)
lw $8, 0($9)
sw $8, -68($sp)
lw $8, -68($sp)
lw $9, -64($sp)
sw $8, 0($9)
lw $9, -4($sp)
lw $8, 0($9)
sw $8, -76($sp)
lw $9, -76($sp)
mul $8, $9, 4
sw $8, -80($sp)
lw $9, 8($a3)
lw $10, -80($sp)
add $8, $9, $10
sw $8, -72($sp)
lw $9, -16($sp)
lw $8, 0($9)
sw $8, -84($sp)
lw $8, -84($sp)
lw $9, -72($sp)
sw $8, 0($9)
jr $ra
__dfs:
add $8, $29, 0
sw $8, -4($sp)
add $8, $29, -104
sw $8, -12($sp)
lw $9, -12($sp)
move $8, $9
sw $8, -8($sp)
lw $9, -4($sp)
lw $8, 0($9)
sw $8, -20($sp)
lw $9, -20($sp)
mul $8, $9, 4
sw $8, -24($sp)
lw $9, 8($a3)
lw $10, -24($sp)
add $8, $9, $10
sw $8, -16($sp)
lw $9, -16($sp)
lw $8, 0($9)
sw $8, -16($sp)
lw $8, -16($sp)
lw $9, -8($sp)
sw $8, 0($9)
label3:
lw $9, -8($sp)
lw $8, 0($9)
sw $8, -28($sp)
li $8, 0
sw $8, -32($sp)
lw $9, -28($sp)
lw $10, -32($sp)
sub $8, $9, $10
sw $8, -32($sp)
lw $8, -32($sp)
beqz $8, label4
lw $9, -8($sp)
lw $8, 0($9)
sw $8, -40($sp)
lw $9, -40($sp)
add $8, $9, 4
sw $8, -40($sp)
lw $9, -40($sp)
lw $8, 0($9)
sw $8, -40($sp)
lw $9, -40($sp)
mul $8, $9, 4
sw $8, -44($sp)
lw $9, 20($a3)
lw $10, -44($sp)
add $8, $9, $10
sw $8, -36($sp)
lw $9, -36($sp)
lw $8, 0($9)
sw $8, -36($sp)
lw $9, -36($sp)
li $8, 1
beqz $9, lnot0
li $8, 0
lnot0:
sw $8, -36($sp)
lw $8, -36($sp)
beqz $8, label5
lw $9, -8($sp)
lw $8, 0($9)
sw $8, -52($sp)
lw $9, -52($sp)
add $8, $9, 4
sw $8, -52($sp)
lw $9, -52($sp)
lw $8, 0($9)
sw $8, -52($sp)
lw $9, -52($sp)
mul $8, $9, 4
sw $8, -56($sp)
lw $9, 20($a3)
lw $10, -56($sp)
add $8, $9, $10
sw $8, -48($sp)
li $8, 1
sw $8, -60($sp)
lw $8, -60($sp)
lw $9, -48($sp)
sw $8, 0($9)
sw $31, -108($29)
lw $9, -8($sp)
lw $8, 0($9)
sw $8, -68($sp)
lw $9, -68($sp)
add $8, $9, 0
sw $8, -68($sp)
add $8, $29, -112
sw $8, -72($sp)
lw $9, -68($sp)
lw $8, 0($9)
sw $8, -68($sp)
lw $8, -68($sp)
lw $9, -72($sp)
sw $8, 0($9)
add $29, $29, -112
jal __dfs
sub $29, $29, -112
lw $31, -108($29)
lw $9, 12($a3)
move $8, $9
sw $8, -88($sp)
lw $9, 12($a3)
lw $8, 0($9)
sw $8, -80($sp)
lw $9, -80($sp)
add $8, $9, 1
sw $8, -80($sp)
lw $8, -80($sp)
lw $9, -88($sp)
sw $8, 0($9)
lw $9, -80($sp)
mul $8, $9, 4
sw $8, -84($sp)
lw $9, 28($a3)
lw $10, -84($sp)
add $8, $9, $10
sw $8, -76($sp)
lw $9, -8($sp)
lw $8, 0($9)
sw $8, -92($sp)
lw $9, -92($sp)
add $8, $9, 4
sw $8, -92($sp)
lw $9, -92($sp)
lw $8, 0($9)
sw $8, -92($sp)
lw $8, -92($sp)
lw $9, -76($sp)
sw $8, 0($9)
label5:
lw $9, -8($sp)
move $8, $9
sw $8, -96($sp)
lw $9, -8($sp)
lw $8, 0($9)
sw $8, -100($sp)
lw $9, -100($sp)
add $8, $9, 8
sw $8, -100($sp)
lw $9, -100($sp)
lw $8, 0($9)
sw $8, -100($sp)
lw $8, -100($sp)
lw $9, -96($sp)
sw $8, 0($9)
j label3
label4:
jr $ra
main:
la $a3, temp
la $t0, var0
sw $t0, 8($a3)
la $t0, var1
sw $t0, 12($a3)
la $t0, var2
sw $t0, 20($a3)
la $t0, var3
sw $t0, 24($a3)
la $t0, var4
sw $t0, 28($a3)
la $t0, var5
sw $t0, 32($a3)
la $t0, var6
sw $t0, 36($a3)
la $t0, var7
sw $t0, 688($a3)
la $t0, var8
sw $t0, 732($a3)
li $8, 0
sw $8, 16($a3)
lw $8, 16($a3)
lw $9, 12($a3)
sw $8, 0($9)
add $8, $29, -416
sw $8, -8($sp)
lw $9, -8($sp)
move $8, $9
sw $8, -4($sp)
add $8, $29, -420
sw $8, -16($sp)
lw $9, -16($sp)
move $8, $9
sw $8, -12($sp)
add $8, $29, -424
sw $8, -24($sp)
lw $9, -24($sp)
move $8, $9
sw $8, -20($sp)
li $8, 1
sw $8, -28($sp)
lw $8, -28($sp)
lw $9, -20($sp)
sw $8, 0($9)
lw $9, 32($a3)
move $8, $9
sw $8, -32($sp)
add $29, $29, -432
jal __init
sub $29, $29, -432
add $8, $29, -428
sw $8, -40($sp)
lw $9, -40($sp)
lw $8, 0($9)
sw $8, -36($sp)
lw $8, -36($sp)
lw $9, -32($sp)
sw $8, 0($9)
lw $9, 36($a3)
move $8, $9
sw $8, -44($sp)
add $29, $29, -432
jal __init
sub $29, $29, -432
add $8, $29, -428
sw $8, -52($sp)
lw $9, -52($sp)
lw $8, 0($9)
sw $8, -48($sp)
lw $8, -48($sp)
lw $9, -44($sp)
sw $8, 0($9)
lw $9, -8($sp)
move $8, $9
sw $8, -56($sp)
li $8, 1
sw $8, -60($sp)
lw $8, -60($sp)
lw $9, -56($sp)
sw $8, 0($9)
label6:
lw $9, -4($sp)
lw $8, 0($9)
sw $8, -64($sp)
lw $9, 36($a3)
lw $8, 0($9)
sw $8, -68($sp)
lw $9, -64($sp)
lw $10, -68($sp)
sub $8, $9, $10
sw $8, -68($sp)
lw $8, -68($sp)
bgtz $8, label7
add $8, $29, -428
sw $8, -76($sp)
lw $9, -76($sp)
move $8, $9
sw $8, -72($sp)
add $8, $29, -432
sw $8, -84($sp)
lw $9, -84($sp)
move $8, $9
sw $8, -80($sp)
add $8, $29, -436
sw $8, -92($sp)
lw $9, -92($sp)
move $8, $9
sw $8, -88($sp)
lw $9, -76($sp)
move $8, $9
sw $8, -96($sp)
add $29, $29, -444
jal __init
sub $29, $29, -444
add $8, $29, -440
sw $8, -104($sp)
lw $9, -104($sp)
lw $8, 0($9)
sw $8, -100($sp)
lw $8, -100($sp)
lw $9, -96($sp)
sw $8, 0($9)
lw $9, -84($sp)
move $8, $9
sw $8, -108($sp)
add $29, $29, -444
jal __init
sub $29, $29, -444
add $8, $29, -440
sw $8, -116($sp)
lw $9, -116($sp)
lw $8, 0($9)
sw $8, -112($sp)
lw $8, -112($sp)
lw $9, -108($sp)
sw $8, 0($9)
lw $9, -92($sp)
move $8, $9
sw $8, -120($sp)
add $29, $29, -444
jal __init
sub $29, $29, -444
add $8, $29, -440
sw $8, -128($sp)
lw $9, -128($sp)
lw $8, 0($9)
sw $8, -124($sp)
lw $8, -124($sp)
lw $9, -120($sp)
sw $8, 0($9)
add $8, $29, -444
sw $8, -140($sp)
lw $9, -92($sp)
lw $8, 0($9)
sw $8, -136($sp)
lw $8, -136($sp)
lw $9, -140($sp)
sw $8, 0($9)
add $8, $29, -448
sw $8, -148($sp)
lw $9, -84($sp)
lw $8, 0($9)
sw $8, -144($sp)
lw $8, -144($sp)
lw $9, -148($sp)
sw $8, 0($9)
add $8, $29, -452
sw $8, -156($sp)
lw $9, -76($sp)
lw $8, 0($9)
sw $8, -152($sp)
lw $8, -152($sp)
lw $9, -156($sp)
sw $8, 0($9)
add $29, $29, -452
jal __ins
sub $29, $29, -452
add $8, $29, -444
sw $8, -168($sp)
lw $9, -92($sp)
lw $8, 0($9)
sw $8, -164($sp)
lw $8, -164($sp)
lw $9, -168($sp)
sw $8, 0($9)
add $8, $29, -448
sw $8, -176($sp)
lw $9, -76($sp)
lw $8, 0($9)
sw $8, -172($sp)
lw $8, -172($sp)
lw $9, -176($sp)
sw $8, 0($9)
add $8, $29, -452
sw $8, -184($sp)
lw $9, -84($sp)
lw $8, 0($9)
sw $8, -180($sp)
lw $8, -180($sp)
lw $9, -184($sp)
sw $8, 0($9)
add $29, $29, -452
jal __ins
sub $29, $29, -452
lw $9, -76($sp)
lw $8, 0($9)
sw $8, -192($sp)
lw $9, -192($sp)
mul $8, $9, 4
sw $8, -196($sp)
lw $9, 24($a3)
lw $10, -196($sp)
add $8, $9, $10
sw $8, -188($sp)
lw $9, -188($sp)
move $8, $9
sw $8, -200($sp)
lw $9, -188($sp)
lw $8, 0($9)
sw $8, -188($sp)
lw $9, -188($sp)
add $8, $9, 1
sw $8, -204($sp)
lw $8, -204($sp)
lw $9, -200($sp)
sw $8, 0($9)
lw $9, -84($sp)
lw $8, 0($9)
sw $8, -212($sp)
lw $9, -212($sp)
mul $8, $9, 4
sw $8, -216($sp)
lw $9, 24($a3)
lw $10, -216($sp)
add $8, $9, $10
sw $8, -208($sp)
lw $9, -208($sp)
move $8, $9
sw $8, -220($sp)
lw $9, -208($sp)
lw $8, 0($9)
sw $8, -208($sp)
lw $9, -208($sp)
add $8, $9, 1
sw $8, -224($sp)
lw $8, -224($sp)
lw $9, -220($sp)
sw $8, 0($9)
label8:
lw $9, -4($sp)
move $8, $9
sw $8, -232($sp)
lw $9, -4($sp)
lw $8, 0($9)
sw $8, -228($sp)
lw $9, -228($sp)
add $8, $9, 1
sw $8, -236($sp)
lw $8, -236($sp)
lw $9, -232($sp)
sw $8, 0($9)
j label6
label7:
lw $9, -4($sp)
move $8, $9
sw $8, -240($sp)
li $8, 1
sw $8, -244($sp)
lw $8, -244($sp)
lw $9, -240($sp)
sw $8, 0($9)
label9:
lw $9, -4($sp)
lw $8, 0($9)
sw $8, -248($sp)
li $8, 50
sw $8, -252($sp)
lw $9, -248($sp)
lw $10, -252($sp)
sub $8, $9, $10
sw $8, -252($sp)
lw $8, -252($sp)
bgtz $8, label10
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
lw $9, -256($sp)
lw $8, 0($9)
sw $8, -256($sp)
li $8, 2
sw $8, -268($sp)
lw $9, -256($sp)
lw $10, -268($sp)
rem $8, $9, $10
sw $8, -256($sp)
li $8, 1
sw $8, -272($sp)
lw $9, -256($sp)
lw $10, -272($sp)
sub $8, $9, $10
sw $8, -272($sp)
lw $8, -272($sp)
bnez $8, label12
lw $9, -20($sp)
move $8, $9
sw $8, -276($sp)
li $8, 0
sw $8, -280($sp)
lw $8, -280($sp)
lw $9, -276($sp)
sw $8, 0($9)
j label10
label12:
label11:
lw $9, -4($sp)
move $8, $9
sw $8, -288($sp)
lw $9, -4($sp)
lw $8, 0($9)
sw $8, -284($sp)
lw $9, -284($sp)
add $8, $9, 1
sw $8, -292($sp)
lw $8, -292($sp)
lw $9, -288($sp)
sw $8, 0($9)
j label9
label10:
li $8, 0
sw $8, -300($sp)
lw $9, -300($sp)
mul $8, $9, 4
sw $8, -304($sp)
lw $9, 20($a3)
lw $10, -304($sp)
add $8, $9, $10
sw $8, -296($sp)
li $8, 1
sw $8, -308($sp)
lw $8, -308($sp)
lw $9, -296($sp)
sw $8, 0($9)
li $8, 1
sw $8, -316($sp)
add $8, $29, -432
sw $8, -320($sp)
lw $8, -316($sp)
lw $9, -320($sp)
sw $8, 0($9)
add $29, $29, -432
jal __dfs
sub $29, $29, -432
lw $9, -12($sp)
move $8, $9
sw $8, -324($sp)
lw $9, 12($a3)
lw $8, 0($9)
sw $8, -328($sp)
lw $8, -328($sp)
lw $9, -324($sp)
sw $8, 0($9)
label13:
lw $9, -12($sp)
lw $8, 0($9)
sw $8, -332($sp)
li $8, 1
sw $8, -336($sp)
lw $9, -332($sp)
lw $10, -336($sp)
sub $8, $9, $10
sw $8, -336($sp)
lw $8, -336($sp)
blez $8, label14
lw $9, -12($sp)
lw $8, 0($9)
sw $8, -348($sp)
lw $9, -348($sp)
mul $8, $9, 4
sw $8, -352($sp)
lw $9, 28($a3)
lw $10, -352($sp)
add $8, $9, $10
sw $8, -344($sp)
add $8, $29, -432
sw $8, -356($sp)
lw $9, -344($sp)
lw $8, 0($9)
sw $8, -344($sp)
lw $8, -344($sp)
lw $9, -356($sp)
sw $8, 0($9)
lw $9, 688($a3)
move $8, $9
sw $8, -360($sp)
add $8, $29, -436
sw $8, -364($sp)
lw $8, -360($sp)
lw $9, -364($sp)
sw $8, 0($9)
add $29, $29, -436
jal __printf
sub $29, $29, -436
label15:
lw $9, -12($sp)
move $8, $9
sw $8, -372($sp)
lw $9, -12($sp)
lw $8, 0($9)
sw $8, -368($sp)
lw $9, -368($sp)
sub $8, $9, 1
sw $8, -376($sp)
lw $8, -376($sp)
lw $9, -372($sp)
sw $8, 0($9)
j label13
label14:
li $8, 1
sw $8, -388($sp)
lw $9, -388($sp)
mul $8, $9, 4
sw $8, -392($sp)
lw $9, 28($a3)
lw $10, -392($sp)
add $8, $9, $10
sw $8, -384($sp)
add $8, $29, -432
sw $8, -396($sp)
lw $9, -384($sp)
lw $8, 0($9)
sw $8, -384($sp)
lw $8, -384($sp)
lw $9, -396($sp)
sw $8, 0($9)
lw $9, 732($a3)
move $8, $9
sw $8, -400($sp)
add $8, $29, -436
sw $8, -404($sp)
lw $8, -400($sp)
lw $9, -404($sp)
sw $8, 0($9)
add $29, $29, -436
jal __printf
sub $29, $29, -436
li $8, 0
sw $8, -408($sp)
add $8, $29, 4
sw $8, -412($sp)
lw $8, -408($sp)
lw $9, -412($sp)
sw $8, 0($9)
j __main_end
j __main_end
__main_end:
li $v0, 10
syscall
#global $2 200
#global $3 4
#global $5 8000
#global $6 200
#global $7 8000
#global $8 4
#global $9 4
#string $172 #%d 
#string $183 #%d\n
#li $4 0
#sw $4 $3 0
#----------------------------
#func #init
#addi $11 $0 -48
#move $10 $11
#li $12 0
#sw $12 $10 0
#move $13 $10
#sw $1 $0 -56
#addi $0 $0 -56
#call #getchar
#subi $0 $0 -56
#lw $1 $0 -56
#addi $15 $0 -52
####move $14 $15
#lw $14 $15 0
#li $16 48
#sub $14 $14 $16
#sw $14 $13 0
#sw $1 $0 -56
#addi $0 $0 -56
#call #getchar
#subi $0 $0 -56
#lw $1 $0 -56
#addi $18 $0 -52
####move $17 $18
####move $19 $10
#addi $20 $0 4
#lw $19 $10 0
#sw $19 $20 0
#return
#return
#----------------------------
#func #clear
#addi $22 $0 -64
#move $21 $22
#move $23 $22
#li $24 0
#sw $24 $23 0
#label l:0
####move $25 $21
#lw $25 $21 0
#li $26 50
#sub $26 $25 $26
#bgtz $26 l:1
####move $27 $2
####move $28 $21
#lw $28 $21 0
#muli $29 $28 4
#add $27 $2 $29
#li $30 0
#sw $30 $27 0
#label l:2
####move $31 $21
#move $32 $21
#lw $31 $21 0
#addi $33 $31 1
#sw $33 $32 0
#goto l:0
#label l:1
#move $34 $3
#li $35 0
#sw $35 $34 0
#return
#----------------------------
#func #ins
#addi $36 $0 0
#addi $37 $0 4
#addi $38 $0 8
#addi $40 $0 -88
#move $39 $40
#sw $1 $0 -96
#li $42 12
#addi $43 $0 -100
#sw $42 $43 0
#addi $0 $0 -100
#call #malloc
#subi $0 $0 -100
#lw $1 $0 -96
#addi $44 $0 -92
####move $41 $44
#lw $41 $44 0
#sw $41 $39 0
####move $45 $39
#lw $45 $39 0
#addi $45 $45 0
####move $46 $37
#lw $46 $37 0
#sw $46 $45 0
####move $47 $39
#lw $47 $39 0
#addi $47 $47 8
####move $48 $2
####move $49 $36
#lw $49 $36 0
#muli $50 $49 4
#add $48 $2 $50
#lw $48 $48 0
#sw $48 $47 0
####move $51 $39
#lw $51 $39 0
#addi $51 $51 4
####move $52 $38
#lw $52 $38 0
#sw $52 $51 0
####move $53 $2
####move $54 $36
#lw $54 $36 0
#muli $55 $54 4
#add $53 $2 $55
####move $56 $39
#lw $56 $39 0
#sw $56 $53 0
#return
#----------------------------
#func #dfs
#addi $57 $0 0
#addi $59 $0 -104
#move $58 $59
####move $60 $2
####move $61 $57
#lw $61 $57 0
#muli $62 $61 4
#add $60 $2 $62
#lw $60 $60 0
#sw $60 $58 0
#label l:3
####move $63 $58
#lw $63 $58 0
#li $64 0
#sub $64 $63 $64
#beqz $64 l:4
####move $65 $5
####move $66 $58
#lw $66 $58 0
#addi $66 $66 4
#lw $66 $66 0
#muli $67 $66 4
#add $65 $5 $67
#lw $65 $65 0
#lnot $65 $65
#beqz $65 l:5
####move $68 $5
####move $69 $58
#lw $69 $58 0
#addi $69 $69 4
#lw $69 $69 0
#muli $70 $69 4
#add $68 $5 $70
#li $71 1
#sw $71 $68 0
#sw $1 $0 -108
####move $73 $58
#lw $73 $58 0
#addi $73 $73 0
#addi $74 $0 -112
#lw $73 $73 0
#sw $73 $74 0
#addi $0 $0 -112
#call #dfs
#subi $0 $0 -112
#lw $1 $0 -108
####move $75 $7
####move $76 $3
#move $78 $3
#lw $76 $3 0
#addi $76 $76 1
#sw $76 $78 0
#muli $77 $76 4
#add $75 $7 $77
####move $79 $58
#lw $79 $58 0
#addi $79 $79 4
#lw $79 $79 0
#sw $79 $75 0
#label l:5
#move $80 $58
####move $81 $58
#lw $81 $58 0
#addi $81 $81 8
#lw $81 $81 0
#sw $81 $80 0
#goto l:3
#label l:4
#return
#----------------------------
#func #main
#addi $83 $0 -416
#move $82 $83
#addi $85 $0 -420
#move $84 $85
#addi $87 $0 -424
#move $86 $87
#li $88 1
#sw $88 $86 0
#move $89 $8
#addi $0 $0 -432
#call #init
#subi $0 $0 -432
#addi $91 $0 -428
####move $90 $91
#lw $90 $91 0
#sw $90 $89 0
#move $92 $9
#addi $0 $0 -432
#call #init
#subi $0 $0 -432
#addi $94 $0 -428
####move $93 $94
#lw $93 $94 0
#sw $93 $92 0
#move $95 $83
#li $96 1
#sw $96 $95 0
#label l:6
####move $97 $82
#lw $97 $82 0
####move $98 $9
#lw $98 $9 0
#sub $98 $97 $98
#bgtz $98 l:7
#addi $100 $0 -428
#move $99 $100
#addi $102 $0 -432
#move $101 $102
#addi $104 $0 -436
#move $103 $104
#move $105 $100
#addi $0 $0 -444
#call #init
#subi $0 $0 -444
#addi $107 $0 -440
####move $106 $107
#lw $106 $107 0
#sw $106 $105 0
#move $108 $102
#addi $0 $0 -444
#call #init
#subi $0 $0 -444
#addi $110 $0 -440
####move $109 $110
#lw $109 $110 0
#sw $109 $108 0
#move $111 $104
#addi $0 $0 -444
#call #init
#subi $0 $0 -444
#addi $113 $0 -440
####move $112 $113
#lw $112 $113 0
#sw $112 $111 0
####move $115 $104
#addi $116 $0 -444
#lw $115 $104 0
#sw $115 $116 0
####move $117 $102
#addi $118 $0 -448
#lw $117 $102 0
#sw $117 $118 0
####move $119 $100
#addi $120 $0 -452
#lw $119 $100 0
#sw $119 $120 0
#addi $0 $0 -452
#call #ins
#subi $0 $0 -452
####move $122 $104
#addi $123 $0 -444
#lw $122 $104 0
#sw $122 $123 0
####move $124 $100
#addi $125 $0 -448
#lw $124 $100 0
#sw $124 $125 0
####move $126 $102
#addi $127 $0 -452
#lw $126 $102 0
#sw $126 $127 0
#addi $0 $0 -452
#call #ins
#subi $0 $0 -452
####move $128 $6
####move $129 $100
#lw $129 $100 0
#muli $130 $129 4
#add $128 $6 $130
#move $131 $128
#lw $128 $128 0
#addi $132 $128 1
#sw $132 $131 0
####move $133 $6
####move $134 $102
#lw $134 $102 0
#muli $135 $134 4
#add $133 $6 $135
#move $136 $133
#lw $133 $133 0
#addi $137 $133 1
#sw $137 $136 0
#label l:8
####move $138 $82
#move $139 $82
#lw $138 $82 0
#addi $140 $138 1
#sw $140 $139 0
#goto l:6
#label l:7
#move $141 $82
#li $142 1
#sw $142 $141 0
#label l:9
####move $143 $82
#lw $143 $82 0
#li $144 50
#sub $144 $143 $144
#bgtz $144 l:10
####move $145 $6
####move $146 $82
#lw $146 $82 0
#muli $147 $146 4
#add $145 $6 $147
#lw $145 $145 0
#li $148 2
#mod $145 $145 $148
#li $149 1
#sub $149 $145 $149
#bnez $149 l:12
#move $150 $86
#li $151 0
#sw $151 $150 0
#goto l:10
#label l:12
#label l:11
####move $152 $82
#move $153 $82
#lw $152 $82 0
#addi $154 $152 1
#sw $154 $153 0
#goto l:9
#label l:10
####move $155 $5
#li $156 0
#muli $157 $156 4
#add $155 $5 $157
#li $158 1
#sw $158 $155 0
#li $160 1
#addi $161 $0 -432
#sw $160 $161 0
#addi $0 $0 -432
#call #dfs
#subi $0 $0 -432
#move $162 $84
####move $163 $3
#lw $163 $3 0
#sw $163 $162 0
#label l:13
####move $164 $84
#lw $164 $84 0
#li $165 1
#sub $165 $164 $165
#blez $165 l:14
####move $167 $7
####move $168 $84
#lw $168 $84 0
#muli $169 $168 4
#add $167 $7 $169
#addi $170 $0 -432
#lw $167 $167 0
#sw $167 $170 0
#move $171 $172
#addi $173 $0 -436
#sw $171 $173 0
#addi $0 $0 -436
#call #printf
#subi $0 $0 -436
#label l:15
####move $174 $84
#move $175 $84
#lw $174 $84 0
#subi $176 $174 1
#sw $176 $175 0
#goto l:13
#label l:14
####move $178 $7
#li $179 1
#muli $180 $179 4
#add $178 $7 $180
#addi $181 $0 -432
#lw $178 $178 0
#sw $178 $181 0
#move $182 $183
#addi $184 $0 -436
#sw $182 $184 0
#addi $0 $0 -436
#call #printf
#subi $0 $0 -436
#li $185 0
#addi $186 $0 4
#sw $185 $186 0
#return
#return
