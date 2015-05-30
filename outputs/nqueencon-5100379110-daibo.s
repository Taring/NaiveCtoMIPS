.data
temp: .space 684
var0: .asciiz " ."
.align 2
var1: .asciiz " O"
.align 2
var2: .asciiz "\n"
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

__printrow:
add $8, $29, 0
sw $8, -4($sp)
add $8, $29, 4
sw $8, -8($sp)
add $8, $29, -136
sw $8, -16($sp)
lw $9, -16($sp)
move $8, $9
sw $8, -12($sp)
lw $9, -16($sp)
move $8, $9
sw $8, -20($sp)
li $8, 1
sw $8, -24($sp)
lw $8, -24($sp)
lw $9, -20($sp)
sw $8, 0($9)
label0:
lw $9, -12($sp)
lw $8, 0($9)
sw $8, -28($sp)
lw $9, -4($sp)
lw $8, 0($9)
sw $8, -32($sp)
li $8, 1
sw $8, -36($sp)
lw $9, -32($sp)
lw $10, -36($sp)
sub $8, $9, $10
sw $8, -32($sp)
lw $9, -28($sp)
lw $10, -32($sp)
sub $8, $9, $10
sw $8, -32($sp)
lw $8, -32($sp)
bgtz $8, label1
sw $31, -140($29)
lw $9, 52($a3)
move $8, $9
sw $8, -44($sp)
add $8, $29, -144
sw $8, -48($sp)
lw $8, -44($sp)
lw $9, -48($sp)
sw $8, 0($9)
add $29, $29, -144
jal __printf_single
sub $29, $29, -144
lw $31, -140($29)
label2:
lw $9, -12($sp)
move $8, $9
sw $8, -56($sp)
lw $9, -12($sp)
lw $8, 0($9)
sw $8, -52($sp)
lw $9, -52($sp)
add $8, $9, 1
sw $8, -52($sp)
lw $8, -52($sp)
lw $9, -56($sp)
sw $8, 0($9)
j label0
label1:
sw $31, -140($29)
lw $9, 76($a3)
move $8, $9
sw $8, -64($sp)
add $8, $29, -144
sw $8, -68($sp)
lw $8, -64($sp)
lw $9, -68($sp)
sw $8, 0($9)
add $29, $29, -144
jal __printf_single
sub $29, $29, -144
lw $31, -140($29)
lw $9, -12($sp)
move $8, $9
sw $8, -72($sp)
lw $9, -4($sp)
lw $8, 0($9)
sw $8, -76($sp)
li $8, 1
sw $8, -80($sp)
lw $9, -76($sp)
lw $10, -80($sp)
add $8, $9, $10
sw $8, -76($sp)
lw $8, -76($sp)
lw $9, -72($sp)
sw $8, 0($9)
label3:
lw $9, -12($sp)
lw $8, 0($9)
sw $8, -84($sp)
lw $9, -8($sp)
lw $8, 0($9)
sw $8, -88($sp)
lw $9, -84($sp)
lw $10, -88($sp)
sub $8, $9, $10
sw $8, -88($sp)
lw $8, -88($sp)
bgtz $8, label4
sw $31, -140($29)
lw $9, 52($a3)
move $8, $9
sw $8, -96($sp)
add $8, $29, -144
sw $8, -100($sp)
lw $8, -96($sp)
lw $9, -100($sp)
sw $8, 0($9)
add $29, $29, -144
jal __printf_single
sub $29, $29, -144
lw $31, -140($29)
label5:
lw $9, -12($sp)
move $8, $9
sw $8, -108($sp)
lw $9, -12($sp)
lw $8, 0($9)
sw $8, -104($sp)
lw $9, -104($sp)
add $8, $9, 1
sw $8, -112($sp)
lw $8, -112($sp)
lw $9, -108($sp)
sw $8, 0($9)
j label3
label4:
sw $31, -140($29)
lw $9, 136($a3)
move $8, $9
sw $8, -120($sp)
add $8, $29, -144
sw $8, -124($sp)
lw $8, -120($sp)
lw $9, -124($sp)
sw $8, 0($9)
add $29, $29, -144
jal __printf_single
sub $29, $29, -144
lw $31, -140($29)
li $8, 0
sw $8, -128($sp)
add $8, $29, 12
sw $8, -132($sp)
lw $8, -128($sp)
lw $9, -132($sp)
sw $8, 0($9)
jr $ra
jr $ra
__nqueen:
add $8, $29, 0
sw $8, -4($sp)
add $8, $29, -468
sw $8, -12($sp)
lw $9, -12($sp)
move $8, $9
sw $8, -8($sp)
li $8, 0
sw $8, -16($sp)
lw $8, -16($sp)
lw $9, -8($sp)
sw $8, 0($9)
add $8, $29, -472
sw $8, -24($sp)
lw $9, -24($sp)
move $8, $9
sw $8, -20($sp)
lw $9, -4($sp)
lw $8, 0($9)
sw $8, -28($sp)
lw $8, -28($sp)
lw $9, -20($sp)
sw $8, 0($9)
add $8, $29, -476
sw $8, -36($sp)
lw $9, -36($sp)
move $8, $9
sw $8, -32($sp)
lw $9, -4($sp)
lw $8, 0($9)
sw $8, -40($sp)
li $8, 2
sw $8, -44($sp)
lw $9, -40($sp)
lw $10, -44($sp)
rem $8, $9, $10
sw $8, -40($sp)
lw $8, -40($sp)
lw $9, -32($sp)
sw $8, 0($9)
lw $9, -4($sp)
lw $8, 0($9)
sw $8, -48($sp)
li $8, 2
sw $8, -52($sp)
lw $9, -48($sp)
lw $10, -52($sp)
div $8, $9, $10
sw $8, -48($sp)
li $8, 3
sw $8, -56($sp)
lw $9, -48($sp)
lw $10, -56($sp)
rem $8, $9, $10
sw $8, -48($sp)
li $8, 1
sw $8, -60($sp)
lw $9, -48($sp)
lw $10, -60($sp)
sub $8, $9, $10
sw $8, -60($sp)
lw $8, -60($sp)
beqz $8, label6
sw $31, -484($29)
add $8, $29, -488
sw $8, -72($sp)
lw $9, -20($sp)
lw $8, 0($9)
sw $8, -68($sp)
lw $8, -68($sp)
lw $9, -72($sp)
sw $8, 0($9)
li $8, 2
sw $8, -76($sp)
add $8, $29, -492
sw $8, -80($sp)
lw $8, -76($sp)
lw $9, -80($sp)
sw $8, 0($9)
add $29, $29, -492
jal __printrow
sub $29, $29, -492
lw $31, -484($29)
add $8, $29, -480
sw $8, -84($sp)
lw $9, -84($sp)
move $8, $9
sw $8, -64($sp)
lw $9, -8($sp)
move $8, $9
sw $8, -88($sp)
li $8, 4
sw $8, -92($sp)
lw $8, -92($sp)
lw $9, -88($sp)
sw $8, 0($9)
label8:
lw $9, -8($sp)
lw $8, 0($9)
sw $8, -96($sp)
lw $9, -4($sp)
lw $8, 0($9)
sw $8, -100($sp)
lw $9, -96($sp)
lw $10, -100($sp)
sub $8, $9, $10
sw $8, -100($sp)
lw $8, -100($sp)
bgtz $8, label9
sw $31, -484($29)
add $8, $29, -488
sw $8, -112($sp)
lw $9, -20($sp)
lw $8, 0($9)
sw $8, -108($sp)
lw $8, -108($sp)
lw $9, -112($sp)
sw $8, 0($9)
add $8, $29, -492
sw $8, -120($sp)
lw $9, -8($sp)
lw $8, 0($9)
sw $8, -116($sp)
lw $8, -116($sp)
lw $9, -120($sp)
sw $8, 0($9)
add $29, $29, -492
jal __printrow
sub $29, $29, -492
lw $31, -484($29)
add $8, $29, -480
sw $8, -124($sp)
lw $9, -124($sp)
move $8, $9
sw $8, -104($sp)
lw $9, -8($sp)
move $8, $9
sw $8, -128($sp)
li $8, 2
sw $8, -132($sp)
lw $9, -8($sp)
lw $8, 0($9)
sw $8, -136($sp)
lw $9, -136($sp)
lw $10, -132($sp)
add $8, $9, $10
sw $8, -136($sp)
lw $8, -136($sp)
lw $9, -128($sp)
sw $8, 0($9)
j label8
label9:
lw $9, -8($sp)
move $8, $9
sw $8, -140($sp)
li $8, 1
sw $8, -144($sp)
lw $8, -144($sp)
lw $9, -140($sp)
sw $8, 0($9)
label10:
lw $9, -8($sp)
lw $8, 0($9)
sw $8, -148($sp)
lw $9, -4($sp)
lw $8, 0($9)
sw $8, -152($sp)
lw $9, -148($sp)
lw $10, -152($sp)
sub $8, $9, $10
sw $8, -152($sp)
lw $8, -152($sp)
bgtz $8, label11
sw $31, -484($29)
add $8, $29, -488
sw $8, -164($sp)
lw $9, -20($sp)
lw $8, 0($9)
sw $8, -160($sp)
lw $8, -160($sp)
lw $9, -164($sp)
sw $8, 0($9)
add $8, $29, -492
sw $8, -172($sp)
lw $9, -8($sp)
lw $8, 0($9)
sw $8, -168($sp)
lw $8, -168($sp)
lw $9, -172($sp)
sw $8, 0($9)
add $29, $29, -492
jal __printrow
sub $29, $29, -492
lw $31, -484($29)
add $8, $29, -480
sw $8, -176($sp)
lw $9, -176($sp)
move $8, $9
sw $8, -156($sp)
lw $9, -8($sp)
move $8, $9
sw $8, -180($sp)
li $8, 2
sw $8, -184($sp)
lw $9, -8($sp)
lw $8, 0($9)
sw $8, -188($sp)
lw $9, -188($sp)
lw $10, -184($sp)
add $8, $9, $10
sw $8, -188($sp)
lw $8, -188($sp)
lw $9, -180($sp)
sw $8, 0($9)
j label10
label11:
j label7
label6:
lw $9, -4($sp)
move $8, $9
sw $8, -192($sp)
lw $9, -4($sp)
lw $8, 0($9)
sw $8, -196($sp)
lw $9, -32($sp)
lw $8, 0($9)
sw $8, -200($sp)
lw $9, -196($sp)
lw $10, -200($sp)
sub $8, $9, $10
sw $8, -196($sp)
lw $8, -196($sp)
lw $9, -192($sp)
sw $8, 0($9)
sw $31, -484($29)
add $8, $29, -488
sw $8, -212($sp)
lw $9, -20($sp)
lw $8, 0($9)
sw $8, -208($sp)
lw $8, -208($sp)
lw $9, -212($sp)
sw $8, 0($9)
lw $9, -4($sp)
lw $8, 0($9)
sw $8, -216($sp)
li $8, 2
sw $8, -220($sp)
lw $9, -216($sp)
lw $10, -220($sp)
div $8, $9, $10
sw $8, -216($sp)
add $8, $29, -492
sw $8, -224($sp)
lw $8, -216($sp)
lw $9, -224($sp)
sw $8, 0($9)
add $29, $29, -492
jal __printrow
sub $29, $29, -492
lw $31, -484($29)
add $8, $29, -480
sw $8, -228($sp)
lw $9, -228($sp)
move $8, $9
sw $8, -204($sp)
lw $9, -8($sp)
move $8, $9
sw $8, -232($sp)
lw $9, -4($sp)
lw $8, 0($9)
sw $8, -236($sp)
li $8, 2
sw $8, -240($sp)
lw $9, -236($sp)
lw $10, -240($sp)
div $8, $9, $10
sw $8, -236($sp)
li $8, 1
sw $8, -244($sp)
lw $9, -236($sp)
lw $10, -244($sp)
add $8, $9, $10
sw $8, -236($sp)
lw $8, -236($sp)
lw $9, -232($sp)
sw $8, 0($9)
label12:
lw $9, -8($sp)
lw $8, 0($9)
sw $8, -248($sp)
lw $9, -4($sp)
lw $8, 0($9)
sw $8, -252($sp)
li $8, 2
sw $8, -256($sp)
lw $9, -252($sp)
lw $10, -256($sp)
div $8, $9, $10
sw $8, -252($sp)
li $8, 1
sw $8, -260($sp)
lw $9, -252($sp)
lw $10, -260($sp)
sub $8, $9, $10
sw $8, -252($sp)
lw $9, -248($sp)
lw $10, -252($sp)
sub $8, $9, $10
sw $8, -252($sp)
lw $8, -252($sp)
beqz $8, label13
sw $31, -484($29)
add $8, $29, -488
sw $8, -272($sp)
lw $9, -20($sp)
lw $8, 0($9)
sw $8, -268($sp)
lw $8, -268($sp)
lw $9, -272($sp)
sw $8, 0($9)
lw $9, -8($sp)
lw $8, 0($9)
sw $8, -276($sp)
li $8, 1
sw $8, -280($sp)
lw $9, -276($sp)
lw $10, -280($sp)
add $8, $9, $10
sw $8, -276($sp)
add $8, $29, -492
sw $8, -284($sp)
lw $8, -276($sp)
lw $9, -284($sp)
sw $8, 0($9)
add $29, $29, -492
jal __printrow
sub $29, $29, -492
lw $31, -484($29)
add $8, $29, -480
sw $8, -288($sp)
lw $9, -288($sp)
move $8, $9
sw $8, -264($sp)
lw $9, -8($sp)
move $8, $9
sw $8, -292($sp)
lw $9, -8($sp)
lw $8, 0($9)
sw $8, -296($sp)
li $8, 2
sw $8, -300($sp)
lw $9, -296($sp)
lw $10, -300($sp)
add $8, $9, $10
sw $8, -296($sp)
lw $9, -4($sp)
lw $8, 0($9)
sw $8, -304($sp)
lw $9, -296($sp)
lw $10, -304($sp)
rem $8, $9, $10
sw $8, -296($sp)
lw $8, -296($sp)
lw $9, -292($sp)
sw $8, 0($9)
j label12
label13:
lw $9, -8($sp)
move $8, $9
sw $8, -308($sp)
lw $9, -8($sp)
lw $8, 0($9)
sw $8, -312($sp)
li $8, 2
sw $8, -316($sp)
lw $9, -312($sp)
lw $10, -316($sp)
sub $8, $9, $10
sw $8, -312($sp)
lw $9, -4($sp)
lw $8, 0($9)
sw $8, -320($sp)
lw $9, -312($sp)
lw $10, -320($sp)
rem $8, $9, $10
sw $8, -312($sp)
lw $8, -312($sp)
lw $9, -308($sp)
sw $8, 0($9)
label14:
lw $9, -8($sp)
lw $8, 0($9)
sw $8, -324($sp)
lw $9, -4($sp)
lw $8, 0($9)
sw $8, -328($sp)
li $8, 2
sw $8, -332($sp)
lw $9, -328($sp)
lw $10, -332($sp)
div $8, $9, $10
sw $8, -328($sp)
li $8, 1
sw $8, -336($sp)
lw $9, -328($sp)
lw $10, -336($sp)
sub $8, $9, $10
sw $8, -328($sp)
lw $9, -324($sp)
lw $10, -328($sp)
sub $8, $9, $10
sw $8, -328($sp)
lw $8, -328($sp)
beqz $8, label15
sw $31, -484($29)
add $8, $29, -488
sw $8, -348($sp)
lw $9, -20($sp)
lw $8, 0($9)
sw $8, -344($sp)
lw $8, -344($sp)
lw $9, -348($sp)
sw $8, 0($9)
lw $9, -4($sp)
lw $8, 0($9)
sw $8, -352($sp)
lw $9, -8($sp)
lw $8, 0($9)
sw $8, -356($sp)
lw $9, -352($sp)
lw $10, -356($sp)
sub $8, $9, $10
sw $8, -352($sp)
add $8, $29, -492
sw $8, -360($sp)
lw $8, -352($sp)
lw $9, -360($sp)
sw $8, 0($9)
add $29, $29, -492
jal __printrow
sub $29, $29, -492
lw $31, -484($29)
add $8, $29, -480
sw $8, -364($sp)
lw $9, -364($sp)
move $8, $9
sw $8, -340($sp)
lw $9, -8($sp)
move $8, $9
sw $8, -368($sp)
lw $9, -8($sp)
lw $8, 0($9)
sw $8, -372($sp)
li $8, 2
sw $8, -376($sp)
lw $9, -372($sp)
lw $10, -376($sp)
sub $8, $9, $10
sw $8, -372($sp)
lw $9, -4($sp)
lw $8, 0($9)
sw $8, -380($sp)
lw $9, -372($sp)
lw $10, -380($sp)
add $8, $9, $10
sw $8, -372($sp)
lw $9, -4($sp)
lw $8, 0($9)
sw $8, -384($sp)
lw $9, -372($sp)
lw $10, -384($sp)
rem $8, $9, $10
sw $8, -372($sp)
lw $8, -372($sp)
lw $9, -368($sp)
sw $8, 0($9)
j label14
label15:
sw $31, -484($29)
add $8, $29, -488
sw $8, -396($sp)
lw $9, -20($sp)
lw $8, 0($9)
sw $8, -392($sp)
lw $8, -392($sp)
lw $9, -396($sp)
sw $8, 0($9)
lw $9, -4($sp)
lw $8, 0($9)
sw $8, -400($sp)
lw $9, -8($sp)
lw $8, 0($9)
sw $8, -404($sp)
lw $9, -400($sp)
lw $10, -404($sp)
sub $8, $9, $10
sw $8, -400($sp)
add $8, $29, -492
sw $8, -408($sp)
lw $8, -400($sp)
lw $9, -408($sp)
sw $8, 0($9)
add $29, $29, -492
jal __printrow
sub $29, $29, -492
lw $31, -484($29)
add $8, $29, -480
sw $8, -412($sp)
lw $9, -412($sp)
move $8, $9
sw $8, -388($sp)
lw $9, -32($sp)
lw $8, 0($9)
sw $8, -416($sp)
lw $8, -416($sp)
beqz $8, label16
sw $31, -484($29)
add $8, $29, -488
sw $8, -428($sp)
lw $9, -20($sp)
lw $8, 0($9)
sw $8, -424($sp)
lw $8, -424($sp)
lw $9, -428($sp)
sw $8, 0($9)
lw $9, -4($sp)
lw $8, 0($9)
sw $8, -432($sp)
li $8, 1
sw $8, -436($sp)
lw $9, -432($sp)
lw $10, -436($sp)
add $8, $9, $10
sw $8, -432($sp)
add $8, $29, -492
sw $8, -440($sp)
lw $8, -432($sp)
lw $9, -440($sp)
sw $8, 0($9)
add $29, $29, -492
jal __printrow
sub $29, $29, -492
lw $31, -484($29)
add $8, $29, -480
sw $8, -444($sp)
lw $9, -444($sp)
move $8, $9
sw $8, -420($sp)
label16:
label7:
sw $31, -480($29)
lw $9, 136($a3)
move $8, $9
sw $8, -452($sp)
add $8, $29, -484
sw $8, -456($sp)
lw $8, -452($sp)
lw $9, -456($sp)
sw $8, 0($9)
add $29, $29, -484
jal __printf_single
sub $29, $29, -484
lw $31, -480($29)
li $8, 0
sw $8, -460($sp)
add $8, $29, 8
sw $8, -464($sp)
lw $8, -460($sp)
lw $9, -464($sp)
sw $8, 0($9)
jr $ra
jr $ra
main:
la $a3, temp
la $t0, var0
sw $t0, 52($a3)
la $t0, var1
sw $t0, 76($a3)
la $t0, var2
sw $t0, 136($a3)
add $8, $29, -72
sw $8, -8($sp)
lw $9, -8($sp)
move $8, $9
sw $8, -4($sp)
lw $9, -8($sp)
move $8, $9
sw $8, -12($sp)
add $29, $29, -80
jal __getchar
sub $29, $29, -80
add $8, $29, -76
sw $8, -20($sp)
lw $9, -20($sp)
lw $8, 0($9)
sw $8, -16($sp)
li $8, 48
sw $8, -24($sp)
lw $9, -16($sp)
lw $10, -24($sp)
sub $8, $9, $10
sw $8, -16($sp)
lw $8, -16($sp)
lw $9, -12($sp)
sw $8, 0($9)
label17:
lw $9, -4($sp)
lw $8, 0($9)
sw $8, -28($sp)
li $8, 11
sw $8, -32($sp)
lw $9, -28($sp)
lw $10, -32($sp)
sub $8, $9, $10
sw $8, -32($sp)
lw $8, -32($sp)
bgtz $8, label18
add $8, $29, -84
sw $8, -44($sp)
lw $9, -4($sp)
lw $8, 0($9)
sw $8, -40($sp)
lw $8, -40($sp)
lw $9, -44($sp)
sw $8, 0($9)
add $29, $29, -84
jal __nqueen
sub $29, $29, -84
add $8, $29, -76
sw $8, -48($sp)
lw $9, -48($sp)
move $8, $9
sw $8, -36($sp)
label19:
lw $9, -4($sp)
move $8, $9
sw $8, -56($sp)
lw $9, -4($sp)
lw $8, 0($9)
sw $8, -52($sp)
lw $9, -52($sp)
add $8, $9, 1
sw $8, -60($sp)
lw $8, -60($sp)
lw $9, -56($sp)
sw $8, 0($9)
j label17
label18:
li $8, 0
sw $8, -64($sp)
add $8, $29, 4
sw $8, -68($sp)
lw $8, -64($sp)
lw $9, -68($sp)
sw $8, 0($9)
j __main_end
j __main_end
__main_end:
li $v0, 10
syscall
#string $13 # .
#string $19 # O
#string $34 #\n
#----------------------------
#func #printrow
#addi $2 $0 0
#addi $3 $0 4
#addi $5 $0 -136
#move $4 $5
#move $6 $5
#li $7 1
#sw $7 $6 0
#label l:0
####move $8 $4
#lw $8 $4 0
####move $9 $2
#lw $9 $2 0
#li $10 1
#sub $9 $9 $10
#sub $9 $8 $9
#bgtz $9 l:1
#sw $1 $0 -140
#move $12 $13
#addi $14 $0 -144
#sw $12 $14 0
#addi $0 $0 -144
#call #printf_single
#subi $0 $0 -144
#lw $1 $0 -140
#label l:2
####move $15 $4
#move $16 $4
#lw $15 $4 0
#addi $15 $15 1
#sw $15 $16 0
#goto l:0
#label l:1
#sw $1 $0 -140
#move $18 $19
#addi $20 $0 -144
#sw $18 $20 0
#addi $0 $0 -144
#call #printf_single
#subi $0 $0 -144
#lw $1 $0 -140
#move $21 $4
####move $22 $2
#lw $22 $2 0
#li $23 1
#add $22 $22 $23
#sw $22 $21 0
#label l:3
####move $24 $4
#lw $24 $4 0
####move $25 $3
#lw $25 $3 0
#sub $25 $24 $25
#bgtz $25 l:4
#sw $1 $0 -140
#move $27 $13
#addi $28 $0 -144
#sw $27 $28 0
#addi $0 $0 -144
#call #printf_single
#subi $0 $0 -144
#lw $1 $0 -140
#label l:5
####move $29 $4
#move $30 $4
#lw $29 $4 0
#addi $31 $29 1
#sw $31 $30 0
#goto l:3
#label l:4
#sw $1 $0 -140
#move $33 $34
#addi $35 $0 -144
#sw $33 $35 0
#addi $0 $0 -144
#call #printf_single
#subi $0 $0 -144
#lw $1 $0 -140
#li $36 0
#addi $37 $0 12
#sw $36 $37 0
#return
#return
#----------------------------
#func #nqueen
#addi $38 $0 0
#addi $40 $0 -468
#move $39 $40
#li $41 0
#sw $41 $39 0
#addi $43 $0 -472
#move $42 $43
####move $44 $38
#lw $44 $38 0
#sw $44 $42 0
#addi $46 $0 -476
#move $45 $46
####move $47 $38
#lw $47 $38 0
#li $48 2
#mod $47 $47 $48
#sw $47 $45 0
####move $49 $38
#lw $49 $38 0
#li $50 2
#div $49 $49 $50
#li $51 3
#mod $49 $49 $51
#li $52 1
#sub $52 $49 $52
#beqz $52 l:6
#sw $1 $0 -484
####move $54 $42
#addi $55 $0 -488
#lw $54 $42 0
#sw $54 $55 0
#li $56 2
#addi $57 $0 -492
#sw $56 $57 0
#addi $0 $0 -492
#call #printrow
#subi $0 $0 -492
#lw $1 $0 -484
#addi $58 $0 -480
#move $53 $58
#move $59 $39
#li $60 4
#sw $60 $59 0
#label l:8
####move $61 $39
#lw $61 $39 0
####move $62 $38
#lw $62 $38 0
#sub $62 $61 $62
#bgtz $62 l:9
#sw $1 $0 -484
####move $64 $42
#addi $65 $0 -488
#lw $64 $42 0
#sw $64 $65 0
####move $66 $39
#addi $67 $0 -492
#lw $66 $39 0
#sw $66 $67 0
#addi $0 $0 -492
#call #printrow
#subi $0 $0 -492
#lw $1 $0 -484
#addi $68 $0 -480
#move $63 $68
#move $69 $39
#li $70 2
#lw $71 $39 0
#add $71 $71 $70
#sw $71 $69 0
#goto l:8
#label l:9
#move $72 $39
#li $73 1
#sw $73 $72 0
#label l:10
####move $74 $39
#lw $74 $39 0
####move $75 $38
#lw $75 $38 0
#sub $75 $74 $75
#bgtz $75 l:11
#sw $1 $0 -484
####move $77 $42
#addi $78 $0 -488
#lw $77 $42 0
#sw $77 $78 0
####move $79 $39
#addi $80 $0 -492
#lw $79 $39 0
#sw $79 $80 0
#addi $0 $0 -492
#call #printrow
#subi $0 $0 -492
#lw $1 $0 -484
#addi $81 $0 -480
#move $76 $81
#move $82 $39
#li $83 2
#lw $84 $39 0
#add $84 $84 $83
#sw $84 $82 0
#goto l:10
#label l:11
#goto l:7
#label l:6
#move $85 $38
####move $86 $38
#lw $86 $38 0
####move $87 $45
#lw $87 $45 0
#sub $86 $86 $87
#sw $86 $85 0
#sw $1 $0 -484
####move $89 $42
#addi $90 $0 -488
#lw $89 $42 0
#sw $89 $90 0
####move $91 $38
#lw $91 $38 0
#li $92 2
#div $91 $91 $92
#addi $93 $0 -492
#sw $91 $93 0
#addi $0 $0 -492
#call #printrow
#subi $0 $0 -492
#lw $1 $0 -484
#addi $94 $0 -480
#move $88 $94
#move $95 $39
####move $96 $38
#lw $96 $38 0
#li $97 2
#div $96 $96 $97
#li $98 1
#add $96 $96 $98
#sw $96 $95 0
#label l:12
####move $99 $39
#lw $99 $39 0
####move $100 $38
#lw $100 $38 0
#li $101 2
#div $100 $100 $101
#li $102 1
#sub $100 $100 $102
#sub $100 $99 $100
#beqz $100 l:13
#sw $1 $0 -484
####move $104 $42
#addi $105 $0 -488
#lw $104 $42 0
#sw $104 $105 0
####move $106 $39
#lw $106 $39 0
#li $107 1
#add $106 $106 $107
#addi $108 $0 -492
#sw $106 $108 0
#addi $0 $0 -492
#call #printrow
#subi $0 $0 -492
#lw $1 $0 -484
#addi $109 $0 -480
#move $103 $109
#move $110 $39
####move $111 $39
#lw $111 $39 0
#li $112 2
#add $111 $111 $112
####move $113 $38
#lw $113 $38 0
#mod $111 $111 $113
#sw $111 $110 0
#goto l:12
#label l:13
#move $114 $39
####move $115 $39
#lw $115 $39 0
#li $116 2
#sub $115 $115 $116
####move $117 $38
#lw $117 $38 0
#mod $115 $115 $117
#sw $115 $114 0
#label l:14
####move $118 $39
#lw $118 $39 0
####move $119 $38
#lw $119 $38 0
#li $120 2
#div $119 $119 $120
#li $121 1
#sub $119 $119 $121
#sub $119 $118 $119
#beqz $119 l:15
#sw $1 $0 -484
####move $123 $42
#addi $124 $0 -488
#lw $123 $42 0
#sw $123 $124 0
####move $125 $38
#lw $125 $38 0
####move $126 $39
#lw $126 $39 0
#sub $125 $125 $126
#addi $127 $0 -492
#sw $125 $127 0
#addi $0 $0 -492
#call #printrow
#subi $0 $0 -492
#lw $1 $0 -484
#addi $128 $0 -480
#move $122 $128
#move $129 $39
####move $130 $39
#lw $130 $39 0
#li $131 2
#sub $130 $130 $131
####move $132 $38
#lw $132 $38 0
#add $130 $130 $132
####move $133 $38
#lw $133 $38 0
#mod $130 $130 $133
#sw $130 $129 0
#goto l:14
#label l:15
#sw $1 $0 -484
####move $135 $42
#addi $136 $0 -488
#lw $135 $42 0
#sw $135 $136 0
####move $137 $38
#lw $137 $38 0
####move $138 $39
#lw $138 $39 0
#sub $137 $137 $138
#addi $139 $0 -492
#sw $137 $139 0
#addi $0 $0 -492
#call #printrow
#subi $0 $0 -492
#lw $1 $0 -484
#addi $140 $0 -480
#move $134 $140
####move $141 $45
#lw $141 $45 0
#beqz $141 l:16
#sw $1 $0 -484
####move $143 $42
#addi $144 $0 -488
#lw $143 $42 0
#sw $143 $144 0
####move $145 $38
#lw $145 $38 0
#li $146 1
#add $145 $145 $146
#addi $147 $0 -492
#sw $145 $147 0
#addi $0 $0 -492
#call #printrow
#subi $0 $0 -492
#lw $1 $0 -484
#addi $148 $0 -480
#move $142 $148
#label l:16
#label l:7
#sw $1 $0 -480
#move $150 $34
#addi $151 $0 -484
#sw $150 $151 0
#addi $0 $0 -484
#call #printf_single
#subi $0 $0 -484
#lw $1 $0 -480
#li $152 0
#addi $153 $0 8
#sw $152 $153 0
#return
#return
#----------------------------
#func #main
#addi $155 $0 -72
#move $154 $155
#move $156 $155
#addi $0 $0 -80
#call #getchar
#subi $0 $0 -80
#addi $158 $0 -76
####move $157 $158
#lw $157 $158 0
#li $159 48
#sub $157 $157 $159
#sw $157 $156 0
#label l:17
####move $160 $154
#lw $160 $154 0
#li $161 11
#sub $161 $160 $161
#bgtz $161 l:18
####move $163 $154
#addi $164 $0 -84
#lw $163 $154 0
#sw $163 $164 0
#addi $0 $0 -84
#call #nqueen
#subi $0 $0 -84
#addi $165 $0 -76
#move $162 $165
#label l:19
####move $166 $154
#move $167 $154
#lw $166 $154 0
#addi $168 $166 1
#sw $168 $167 0
#goto l:17
#label l:18
#li $169 0
#addi $170 $0 4
#sw $169 $170 0
#return
#return
