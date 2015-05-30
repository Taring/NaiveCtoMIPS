.data
temp: .space 656
var0: .space 4
var1: .space 4
var2: .space 4
var3: .space 4
var4: .space 4
var5: .space 4
var6: .asciiz "%d\n"
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

main:
la $a3, temp
la $t0, var0
sw $t0, 8($a3)
la $t0, var1
sw $t0, 12($a3)
la $t0, var2
sw $t0, 20($a3)
la $t0, var3
sw $t0, 28($a3)
la $t0, var4
sw $t0, 36($a3)
la $t0, var5
sw $t0, 44($a3)
la $t0, var6
sw $t0, 640($a3)
li $8, 99
sw $8, 16($a3)
lw $8, 16($a3)
lw $9, 12($a3)
sw $8, 0($9)
li $8, 100
sw $8, 24($a3)
lw $8, 24($a3)
lw $9, 20($a3)
sw $8, 0($9)
li $8, 101
sw $8, 32($a3)
lw $8, 32($a3)
lw $9, 28($a3)
sw $8, 0($9)
li $8, 102
sw $8, 40($a3)
lw $8, 40($a3)
lw $9, 36($a3)
sw $8, 0($9)
li $8, 0
sw $8, 48($a3)
lw $8, 48($a3)
lw $9, 44($a3)
sw $8, 0($9)
add $8, $29, -604
sw $8, -8($sp)
lw $9, -8($sp)
move $8, $9
sw $8, -4($sp)
add $8, $29, -608
sw $8, -16($sp)
lw $9, -16($sp)
move $8, $9
sw $8, -12($sp)
add $8, $29, -612
sw $8, -24($sp)
lw $9, -24($sp)
move $8, $9
sw $8, -20($sp)
add $8, $29, -616
sw $8, -32($sp)
lw $9, -32($sp)
move $8, $9
sw $8, -28($sp)
add $8, $29, -620
sw $8, -40($sp)
lw $9, -40($sp)
move $8, $9
sw $8, -36($sp)
add $8, $29, -624
sw $8, -48($sp)
lw $9, -48($sp)
move $8, $9
sw $8, -44($sp)
lw $9, 8($a3)
move $8, $9
sw $8, -52($sp)
add $29, $29, -632
jal __getchar
sub $29, $29, -632
add $8, $29, -628
sw $8, -60($sp)
lw $9, -60($sp)
lw $8, 0($9)
sw $8, -56($sp)
li $8, 48
sw $8, -64($sp)
lw $9, -56($sp)
lw $10, -64($sp)
sub $8, $9, $10
sw $8, -56($sp)
lw $8, -56($sp)
lw $9, -52($sp)
sw $8, 0($9)
lw $9, -8($sp)
move $8, $9
sw $8, -68($sp)
li $8, 1
sw $8, -72($sp)
lw $8, -72($sp)
lw $9, -68($sp)
sw $8, 0($9)
label0:
lw $9, -4($sp)
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
bgtz $8, label1
lw $9, -12($sp)
move $8, $9
sw $8, -84($sp)
li $8, 1
sw $8, -88($sp)
lw $8, -88($sp)
lw $9, -84($sp)
sw $8, 0($9)
label3:
lw $9, -12($sp)
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
bgtz $8, label4
lw $9, -20($sp)
move $8, $9
sw $8, -100($sp)
li $8, 1
sw $8, -104($sp)
lw $8, -104($sp)
lw $9, -100($sp)
sw $8, 0($9)
label6:
lw $9, -20($sp)
lw $8, 0($9)
sw $8, -108($sp)
lw $9, 8($a3)
lw $8, 0($9)
sw $8, -112($sp)
lw $9, -108($sp)
lw $10, -112($sp)
sub $8, $9, $10
sw $8, -112($sp)
lw $8, -112($sp)
bgtz $8, label7
lw $9, -28($sp)
move $8, $9
sw $8, -116($sp)
li $8, 1
sw $8, -120($sp)
lw $8, -120($sp)
lw $9, -116($sp)
sw $8, 0($9)
label9:
lw $9, -28($sp)
lw $8, 0($9)
sw $8, -124($sp)
lw $9, 8($a3)
lw $8, 0($9)
sw $8, -128($sp)
lw $9, -124($sp)
lw $10, -128($sp)
sub $8, $9, $10
sw $8, -128($sp)
lw $8, -128($sp)
bgtz $8, label10
lw $9, -36($sp)
move $8, $9
sw $8, -132($sp)
li $8, 1
sw $8, -136($sp)
lw $8, -136($sp)
lw $9, -132($sp)
sw $8, 0($9)
label12:
lw $9, -36($sp)
lw $8, 0($9)
sw $8, -140($sp)
lw $9, 8($a3)
lw $8, 0($9)
sw $8, -144($sp)
lw $9, -140($sp)
lw $10, -144($sp)
sub $8, $9, $10
sw $8, -144($sp)
lw $8, -144($sp)
bgtz $8, label13
lw $9, -44($sp)
move $8, $9
sw $8, -148($sp)
li $8, 1
sw $8, -152($sp)
lw $8, -152($sp)
lw $9, -148($sp)
sw $8, 0($9)
label15:
lw $9, -44($sp)
lw $8, 0($9)
sw $8, -156($sp)
lw $9, 8($a3)
lw $8, 0($9)
sw $8, -160($sp)
lw $9, -156($sp)
lw $10, -160($sp)
sub $8, $9, $10
sw $8, -160($sp)
lw $8, -160($sp)
bgtz $8, label16
lw $9, -4($sp)
lw $8, 0($9)
sw $8, -164($sp)
lw $9, -12($sp)
lw $8, 0($9)
sw $8, -168($sp)
lw $9, -164($sp)
lw $10, -168($sp)
sub $8, $9, $10
sw $8, -168($sp)
lw $8, -168($sp)
beqz $8, label18
lw $9, -4($sp)
lw $8, 0($9)
sw $8, -172($sp)
lw $9, -20($sp)
lw $8, 0($9)
sw $8, -176($sp)
lw $9, -172($sp)
lw $10, -176($sp)
sub $8, $9, $10
sw $8, -176($sp)
lw $8, -176($sp)
beqz $8, label18
lw $9, -4($sp)
lw $8, 0($9)
sw $8, -180($sp)
lw $9, -28($sp)
lw $8, 0($9)
sw $8, -184($sp)
lw $9, -180($sp)
lw $10, -184($sp)
sub $8, $9, $10
sw $8, -184($sp)
lw $8, -184($sp)
beqz $8, label18
lw $9, -4($sp)
lw $8, 0($9)
sw $8, -188($sp)
lw $9, -36($sp)
lw $8, 0($9)
sw $8, -192($sp)
lw $9, -188($sp)
lw $10, -192($sp)
sub $8, $9, $10
sw $8, -192($sp)
lw $8, -192($sp)
beqz $8, label18
lw $9, -4($sp)
lw $8, 0($9)
sw $8, -196($sp)
lw $9, -44($sp)
lw $8, 0($9)
sw $8, -200($sp)
lw $9, -196($sp)
lw $10, -200($sp)
sub $8, $9, $10
sw $8, -200($sp)
lw $8, -200($sp)
beqz $8, label18
lw $9, -4($sp)
lw $8, 0($9)
sw $8, -204($sp)
lw $9, 12($a3)
lw $8, 0($9)
sw $8, -208($sp)
lw $9, -204($sp)
lw $10, -208($sp)
sub $8, $9, $10
sw $8, -208($sp)
lw $8, -208($sp)
beqz $8, label18
lw $9, -4($sp)
lw $8, 0($9)
sw $8, -212($sp)
lw $9, 20($a3)
lw $8, 0($9)
sw $8, -216($sp)
lw $9, -212($sp)
lw $10, -216($sp)
sub $8, $9, $10
sw $8, -216($sp)
lw $8, -216($sp)
beqz $8, label18
lw $9, -4($sp)
lw $8, 0($9)
sw $8, -220($sp)
lw $9, 28($a3)
lw $8, 0($9)
sw $8, -224($sp)
lw $9, -220($sp)
lw $10, -224($sp)
sub $8, $9, $10
sw $8, -224($sp)
lw $8, -224($sp)
beqz $8, label18
lw $9, -4($sp)
lw $8, 0($9)
sw $8, -228($sp)
lw $9, 36($a3)
lw $8, 0($9)
sw $8, -232($sp)
lw $9, -228($sp)
lw $10, -232($sp)
sub $8, $9, $10
sw $8, -232($sp)
lw $8, -232($sp)
beqz $8, label18
lw $9, -12($sp)
lw $8, 0($9)
sw $8, -236($sp)
lw $9, -20($sp)
lw $8, 0($9)
sw $8, -240($sp)
lw $9, -236($sp)
lw $10, -240($sp)
sub $8, $9, $10
sw $8, -240($sp)
lw $8, -240($sp)
beqz $8, label18
lw $9, -12($sp)
lw $8, 0($9)
sw $8, -244($sp)
lw $9, -28($sp)
lw $8, 0($9)
sw $8, -248($sp)
lw $9, -244($sp)
lw $10, -248($sp)
sub $8, $9, $10
sw $8, -248($sp)
lw $8, -248($sp)
beqz $8, label18
lw $9, -12($sp)
lw $8, 0($9)
sw $8, -252($sp)
lw $9, -36($sp)
lw $8, 0($9)
sw $8, -256($sp)
lw $9, -252($sp)
lw $10, -256($sp)
sub $8, $9, $10
sw $8, -256($sp)
lw $8, -256($sp)
beqz $8, label18
lw $9, -12($sp)
lw $8, 0($9)
sw $8, -260($sp)
lw $9, -44($sp)
lw $8, 0($9)
sw $8, -264($sp)
lw $9, -260($sp)
lw $10, -264($sp)
sub $8, $9, $10
sw $8, -264($sp)
lw $8, -264($sp)
beqz $8, label18
lw $9, -12($sp)
lw $8, 0($9)
sw $8, -268($sp)
lw $9, 12($a3)
lw $8, 0($9)
sw $8, -272($sp)
lw $9, -268($sp)
lw $10, -272($sp)
sub $8, $9, $10
sw $8, -272($sp)
lw $8, -272($sp)
beqz $8, label18
lw $9, -12($sp)
lw $8, 0($9)
sw $8, -276($sp)
lw $9, 20($a3)
lw $8, 0($9)
sw $8, -280($sp)
lw $9, -276($sp)
lw $10, -280($sp)
sub $8, $9, $10
sw $8, -280($sp)
lw $8, -280($sp)
beqz $8, label18
lw $9, -12($sp)
lw $8, 0($9)
sw $8, -284($sp)
lw $9, 28($a3)
lw $8, 0($9)
sw $8, -288($sp)
lw $9, -284($sp)
lw $10, -288($sp)
sub $8, $9, $10
sw $8, -288($sp)
lw $8, -288($sp)
beqz $8, label18
lw $9, -12($sp)
lw $8, 0($9)
sw $8, -292($sp)
lw $9, 36($a3)
lw $8, 0($9)
sw $8, -296($sp)
lw $9, -292($sp)
lw $10, -296($sp)
sub $8, $9, $10
sw $8, -296($sp)
lw $8, -296($sp)
beqz $8, label18
lw $9, -20($sp)
lw $8, 0($9)
sw $8, -300($sp)
lw $9, -28($sp)
lw $8, 0($9)
sw $8, -304($sp)
lw $9, -300($sp)
lw $10, -304($sp)
sub $8, $9, $10
sw $8, -304($sp)
lw $8, -304($sp)
beqz $8, label18
lw $9, -20($sp)
lw $8, 0($9)
sw $8, -308($sp)
lw $9, -36($sp)
lw $8, 0($9)
sw $8, -312($sp)
lw $9, -308($sp)
lw $10, -312($sp)
sub $8, $9, $10
sw $8, -312($sp)
lw $8, -312($sp)
beqz $8, label18
lw $9, -20($sp)
lw $8, 0($9)
sw $8, -316($sp)
lw $9, -44($sp)
lw $8, 0($9)
sw $8, -320($sp)
lw $9, -316($sp)
lw $10, -320($sp)
sub $8, $9, $10
sw $8, -320($sp)
lw $8, -320($sp)
beqz $8, label18
lw $9, -20($sp)
lw $8, 0($9)
sw $8, -324($sp)
lw $9, 12($a3)
lw $8, 0($9)
sw $8, -328($sp)
lw $9, -324($sp)
lw $10, -328($sp)
sub $8, $9, $10
sw $8, -328($sp)
lw $8, -328($sp)
beqz $8, label18
lw $9, -20($sp)
lw $8, 0($9)
sw $8, -332($sp)
lw $9, 20($a3)
lw $8, 0($9)
sw $8, -336($sp)
lw $9, -332($sp)
lw $10, -336($sp)
sub $8, $9, $10
sw $8, -336($sp)
lw $8, -336($sp)
beqz $8, label18
lw $9, -20($sp)
lw $8, 0($9)
sw $8, -340($sp)
lw $9, 28($a3)
lw $8, 0($9)
sw $8, -344($sp)
lw $9, -340($sp)
lw $10, -344($sp)
sub $8, $9, $10
sw $8, -344($sp)
lw $8, -344($sp)
beqz $8, label18
lw $9, -20($sp)
lw $8, 0($9)
sw $8, -348($sp)
lw $9, 36($a3)
lw $8, 0($9)
sw $8, -352($sp)
lw $9, -348($sp)
lw $10, -352($sp)
sub $8, $9, $10
sw $8, -352($sp)
lw $8, -352($sp)
beqz $8, label18
lw $9, -28($sp)
lw $8, 0($9)
sw $8, -356($sp)
lw $9, -36($sp)
lw $8, 0($9)
sw $8, -360($sp)
lw $9, -356($sp)
lw $10, -360($sp)
sub $8, $9, $10
sw $8, -360($sp)
lw $8, -360($sp)
beqz $8, label18
lw $9, -28($sp)
lw $8, 0($9)
sw $8, -364($sp)
lw $9, -44($sp)
lw $8, 0($9)
sw $8, -368($sp)
lw $9, -364($sp)
lw $10, -368($sp)
sub $8, $9, $10
sw $8, -368($sp)
lw $8, -368($sp)
beqz $8, label18
lw $9, -28($sp)
lw $8, 0($9)
sw $8, -372($sp)
lw $9, 12($a3)
lw $8, 0($9)
sw $8, -376($sp)
lw $9, -372($sp)
lw $10, -376($sp)
sub $8, $9, $10
sw $8, -376($sp)
lw $8, -376($sp)
beqz $8, label18
lw $9, -28($sp)
lw $8, 0($9)
sw $8, -380($sp)
lw $9, 20($a3)
lw $8, 0($9)
sw $8, -384($sp)
lw $9, -380($sp)
lw $10, -384($sp)
sub $8, $9, $10
sw $8, -384($sp)
lw $8, -384($sp)
beqz $8, label18
lw $9, -28($sp)
lw $8, 0($9)
sw $8, -388($sp)
lw $9, 28($a3)
lw $8, 0($9)
sw $8, -392($sp)
lw $9, -388($sp)
lw $10, -392($sp)
sub $8, $9, $10
sw $8, -392($sp)
lw $8, -392($sp)
beqz $8, label18
lw $9, -28($sp)
lw $8, 0($9)
sw $8, -396($sp)
lw $9, 36($a3)
lw $8, 0($9)
sw $8, -400($sp)
lw $9, -396($sp)
lw $10, -400($sp)
sub $8, $9, $10
sw $8, -400($sp)
lw $8, -400($sp)
beqz $8, label18
lw $9, -36($sp)
lw $8, 0($9)
sw $8, -404($sp)
lw $9, -44($sp)
lw $8, 0($9)
sw $8, -408($sp)
lw $9, -404($sp)
lw $10, -408($sp)
sub $8, $9, $10
sw $8, -408($sp)
lw $8, -408($sp)
beqz $8, label18
lw $9, -36($sp)
lw $8, 0($9)
sw $8, -412($sp)
lw $9, 12($a3)
lw $8, 0($9)
sw $8, -416($sp)
lw $9, -412($sp)
lw $10, -416($sp)
sub $8, $9, $10
sw $8, -416($sp)
lw $8, -416($sp)
beqz $8, label18
lw $9, -36($sp)
lw $8, 0($9)
sw $8, -420($sp)
lw $9, 20($a3)
lw $8, 0($9)
sw $8, -424($sp)
lw $9, -420($sp)
lw $10, -424($sp)
sub $8, $9, $10
sw $8, -424($sp)
lw $8, -424($sp)
beqz $8, label18
lw $9, -36($sp)
lw $8, 0($9)
sw $8, -428($sp)
lw $9, 28($a3)
lw $8, 0($9)
sw $8, -432($sp)
lw $9, -428($sp)
lw $10, -432($sp)
sub $8, $9, $10
sw $8, -432($sp)
lw $8, -432($sp)
beqz $8, label18
lw $9, -36($sp)
lw $8, 0($9)
sw $8, -436($sp)
lw $9, 36($a3)
lw $8, 0($9)
sw $8, -440($sp)
lw $9, -436($sp)
lw $10, -440($sp)
sub $8, $9, $10
sw $8, -440($sp)
lw $8, -440($sp)
beqz $8, label18
lw $9, -44($sp)
lw $8, 0($9)
sw $8, -444($sp)
lw $9, 12($a3)
lw $8, 0($9)
sw $8, -448($sp)
lw $9, -444($sp)
lw $10, -448($sp)
sub $8, $9, $10
sw $8, -448($sp)
lw $8, -448($sp)
beqz $8, label18
lw $9, -44($sp)
lw $8, 0($9)
sw $8, -452($sp)
lw $9, 20($a3)
lw $8, 0($9)
sw $8, -456($sp)
lw $9, -452($sp)
lw $10, -456($sp)
sub $8, $9, $10
sw $8, -456($sp)
lw $8, -456($sp)
beqz $8, label18
lw $9, -44($sp)
lw $8, 0($9)
sw $8, -460($sp)
lw $9, 28($a3)
lw $8, 0($9)
sw $8, -464($sp)
lw $9, -460($sp)
lw $10, -464($sp)
sub $8, $9, $10
sw $8, -464($sp)
lw $8, -464($sp)
beqz $8, label18
lw $9, -44($sp)
lw $8, 0($9)
sw $8, -468($sp)
lw $9, 36($a3)
lw $8, 0($9)
sw $8, -472($sp)
lw $9, -468($sp)
lw $10, -472($sp)
sub $8, $9, $10
sw $8, -472($sp)
lw $8, -472($sp)
beqz $8, label18
lw $9, 20($a3)
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
beqz $8, label18
lw $9, 12($a3)
lw $8, 0($9)
sw $8, -484($sp)
lw $9, 36($a3)
lw $8, 0($9)
sw $8, -488($sp)
lw $9, -484($sp)
lw $10, -488($sp)
sub $8, $9, $10
sw $8, -488($sp)
lw $8, -488($sp)
beqz $8, label18
lw $9, 44($a3)
move $8, $9
sw $8, -496($sp)
lw $9, 44($a3)
lw $8, 0($9)
sw $8, -492($sp)
lw $9, -492($sp)
add $8, $9, 1
sw $8, -500($sp)
lw $8, -500($sp)
lw $9, -496($sp)
sw $8, 0($9)
label18:
label17:
lw $9, -44($sp)
move $8, $9
sw $8, -508($sp)
lw $9, -44($sp)
lw $8, 0($9)
sw $8, -504($sp)
lw $9, -504($sp)
add $8, $9, 1
sw $8, -512($sp)
lw $8, -512($sp)
lw $9, -508($sp)
sw $8, 0($9)
j label15
label16:
label14:
lw $9, -36($sp)
move $8, $9
sw $8, -520($sp)
lw $9, -36($sp)
lw $8, 0($9)
sw $8, -516($sp)
lw $9, -516($sp)
add $8, $9, 1
sw $8, -524($sp)
lw $8, -524($sp)
lw $9, -520($sp)
sw $8, 0($9)
j label12
label13:
label11:
lw $9, -28($sp)
move $8, $9
sw $8, -532($sp)
lw $9, -28($sp)
lw $8, 0($9)
sw $8, -528($sp)
lw $9, -528($sp)
add $8, $9, 1
sw $8, -536($sp)
lw $8, -536($sp)
lw $9, -532($sp)
sw $8, 0($9)
j label9
label10:
label8:
lw $9, -20($sp)
move $8, $9
sw $8, -544($sp)
lw $9, -20($sp)
lw $8, 0($9)
sw $8, -540($sp)
lw $9, -540($sp)
add $8, $9, 1
sw $8, -548($sp)
lw $8, -548($sp)
lw $9, -544($sp)
sw $8, 0($9)
j label6
label7:
label5:
lw $9, -12($sp)
move $8, $9
sw $8, -556($sp)
lw $9, -12($sp)
lw $8, 0($9)
sw $8, -552($sp)
lw $9, -552($sp)
add $8, $9, 1
sw $8, -560($sp)
lw $8, -560($sp)
lw $9, -556($sp)
sw $8, 0($9)
j label3
label4:
label2:
lw $9, -4($sp)
move $8, $9
sw $8, -568($sp)
lw $9, -4($sp)
lw $8, 0($9)
sw $8, -564($sp)
lw $9, -564($sp)
add $8, $9, 1
sw $8, -572($sp)
lw $8, -572($sp)
lw $9, -568($sp)
sw $8, 0($9)
j label0
label1:
add $8, $29, -632
sw $8, -584($sp)
lw $9, 44($a3)
lw $8, 0($9)
sw $8, -580($sp)
lw $8, -580($sp)
lw $9, -584($sp)
sw $8, 0($9)
lw $9, 640($a3)
move $8, $9
sw $8, -588($sp)
add $8, $29, -636
sw $8, -592($sp)
lw $8, -588($sp)
lw $9, -592($sp)
sw $8, 0($9)
add $29, $29, -636
jal __printf
sub $29, $29, -636
li $8, 0
sw $8, -596($sp)
add $8, $29, 4
sw $8, -600($sp)
lw $8, -596($sp)
lw $9, -600($sp)
sw $8, 0($9)
j __main_end
j __main_end
__main_end:
li $v0, 10
syscall
#global $2 4
#global $3 4
#global $5 4
#global $7 4
#global $9 4
#global $11 4
#string $160 #%d\n
#li $4 99
#sw $4 $3 0
#li $6 100
#sw $6 $5 0
#li $8 101
#sw $8 $7 0
#li $10 102
#sw $10 $9 0
#li $12 0
#sw $12 $11 0
#----------------------------
#func #main
#addi $14 $0 -604
#move $13 $14
#addi $16 $0 -608
#move $15 $16
#addi $18 $0 -612
#move $17 $18
#addi $20 $0 -616
#move $19 $20
#addi $22 $0 -620
#move $21 $22
#addi $24 $0 -624
#move $23 $24
#move $25 $2
#addi $0 $0 -632
#call #getchar
#subi $0 $0 -632
#addi $27 $0 -628
####move $26 $27
#lw $26 $27 0
#li $28 48
#sub $26 $26 $28
#sw $26 $25 0
#move $29 $14
#li $30 1
#sw $30 $29 0
#label l:0
####move $31 $13
#lw $31 $13 0
####move $32 $2
#lw $32 $2 0
#sub $32 $31 $32
#bgtz $32 l:1
#move $33 $15
#li $34 1
#sw $34 $33 0
#label l:3
####move $35 $15
#lw $35 $15 0
####move $36 $2
#lw $36 $2 0
#sub $36 $35 $36
#bgtz $36 l:4
#move $37 $17
#li $38 1
#sw $38 $37 0
#label l:6
####move $39 $17
#lw $39 $17 0
####move $40 $2
#lw $40 $2 0
#sub $40 $39 $40
#bgtz $40 l:7
#move $41 $19
#li $42 1
#sw $42 $41 0
#label l:9
####move $43 $19
#lw $43 $19 0
####move $44 $2
#lw $44 $2 0
#sub $44 $43 $44
#bgtz $44 l:10
#move $45 $21
#li $46 1
#sw $46 $45 0
#label l:12
####move $47 $21
#lw $47 $21 0
####move $48 $2
#lw $48 $2 0
#sub $48 $47 $48
#bgtz $48 l:13
#move $49 $23
#li $50 1
#sw $50 $49 0
#label l:15
####move $51 $23
#lw $51 $23 0
####move $52 $2
#lw $52 $2 0
#sub $52 $51 $52
#bgtz $52 l:16
####move $53 $13
#lw $53 $13 0
####move $54 $15
#lw $54 $15 0
#sub $54 $53 $54
#beqz $54 l:18
####move $55 $13
#lw $55 $13 0
####move $56 $17
#lw $56 $17 0
#sub $56 $55 $56
#beqz $56 l:18
####move $57 $13
#lw $57 $13 0
####move $58 $19
#lw $58 $19 0
#sub $58 $57 $58
#beqz $58 l:18
####move $59 $13
#lw $59 $13 0
####move $60 $21
#lw $60 $21 0
#sub $60 $59 $60
#beqz $60 l:18
####move $61 $13
#lw $61 $13 0
####move $62 $23
#lw $62 $23 0
#sub $62 $61 $62
#beqz $62 l:18
####move $63 $13
#lw $63 $13 0
####move $64 $3
#lw $64 $3 0
#sub $64 $63 $64
#beqz $64 l:18
####move $65 $13
#lw $65 $13 0
####move $66 $5
#lw $66 $5 0
#sub $66 $65 $66
#beqz $66 l:18
####move $67 $13
#lw $67 $13 0
####move $68 $7
#lw $68 $7 0
#sub $68 $67 $68
#beqz $68 l:18
####move $69 $13
#lw $69 $13 0
####move $70 $9
#lw $70 $9 0
#sub $70 $69 $70
#beqz $70 l:18
####move $71 $15
#lw $71 $15 0
####move $72 $17
#lw $72 $17 0
#sub $72 $71 $72
#beqz $72 l:18
####move $73 $15
#lw $73 $15 0
####move $74 $19
#lw $74 $19 0
#sub $74 $73 $74
#beqz $74 l:18
####move $75 $15
#lw $75 $15 0
####move $76 $21
#lw $76 $21 0
#sub $76 $75 $76
#beqz $76 l:18
####move $77 $15
#lw $77 $15 0
####move $78 $23
#lw $78 $23 0
#sub $78 $77 $78
#beqz $78 l:18
####move $79 $15
#lw $79 $15 0
####move $80 $3
#lw $80 $3 0
#sub $80 $79 $80
#beqz $80 l:18
####move $81 $15
#lw $81 $15 0
####move $82 $5
#lw $82 $5 0
#sub $82 $81 $82
#beqz $82 l:18
####move $83 $15
#lw $83 $15 0
####move $84 $7
#lw $84 $7 0
#sub $84 $83 $84
#beqz $84 l:18
####move $85 $15
#lw $85 $15 0
####move $86 $9
#lw $86 $9 0
#sub $86 $85 $86
#beqz $86 l:18
####move $87 $17
#lw $87 $17 0
####move $88 $19
#lw $88 $19 0
#sub $88 $87 $88
#beqz $88 l:18
####move $89 $17
#lw $89 $17 0
####move $90 $21
#lw $90 $21 0
#sub $90 $89 $90
#beqz $90 l:18
####move $91 $17
#lw $91 $17 0
####move $92 $23
#lw $92 $23 0
#sub $92 $91 $92
#beqz $92 l:18
####move $93 $17
#lw $93 $17 0
####move $94 $3
#lw $94 $3 0
#sub $94 $93 $94
#beqz $94 l:18
####move $95 $17
#lw $95 $17 0
####move $96 $5
#lw $96 $5 0
#sub $96 $95 $96
#beqz $96 l:18
####move $97 $17
#lw $97 $17 0
####move $98 $7
#lw $98 $7 0
#sub $98 $97 $98
#beqz $98 l:18
####move $99 $17
#lw $99 $17 0
####move $100 $9
#lw $100 $9 0
#sub $100 $99 $100
#beqz $100 l:18
####move $101 $19
#lw $101 $19 0
####move $102 $21
#lw $102 $21 0
#sub $102 $101 $102
#beqz $102 l:18
####move $103 $19
#lw $103 $19 0
####move $104 $23
#lw $104 $23 0
#sub $104 $103 $104
#beqz $104 l:18
####move $105 $19
#lw $105 $19 0
####move $106 $3
#lw $106 $3 0
#sub $106 $105 $106
#beqz $106 l:18
####move $107 $19
#lw $107 $19 0
####move $108 $5
#lw $108 $5 0
#sub $108 $107 $108
#beqz $108 l:18
####move $109 $19
#lw $109 $19 0
####move $110 $7
#lw $110 $7 0
#sub $110 $109 $110
#beqz $110 l:18
####move $111 $19
#lw $111 $19 0
####move $112 $9
#lw $112 $9 0
#sub $112 $111 $112
#beqz $112 l:18
####move $113 $21
#lw $113 $21 0
####move $114 $23
#lw $114 $23 0
#sub $114 $113 $114
#beqz $114 l:18
####move $115 $21
#lw $115 $21 0
####move $116 $3
#lw $116 $3 0
#sub $116 $115 $116
#beqz $116 l:18
####move $117 $21
#lw $117 $21 0
####move $118 $5
#lw $118 $5 0
#sub $118 $117 $118
#beqz $118 l:18
####move $119 $21
#lw $119 $21 0
####move $120 $7
#lw $120 $7 0
#sub $120 $119 $120
#beqz $120 l:18
####move $121 $21
#lw $121 $21 0
####move $122 $9
#lw $122 $9 0
#sub $122 $121 $122
#beqz $122 l:18
####move $123 $23
#lw $123 $23 0
####move $124 $3
#lw $124 $3 0
#sub $124 $123 $124
#beqz $124 l:18
####move $125 $23
#lw $125 $23 0
####move $126 $5
#lw $126 $5 0
#sub $126 $125 $126
#beqz $126 l:18
####move $127 $23
#lw $127 $23 0
####move $128 $7
#lw $128 $7 0
#sub $128 $127 $128
#beqz $128 l:18
####move $129 $23
#lw $129 $23 0
####move $130 $9
#lw $130 $9 0
#sub $130 $129 $130
#beqz $130 l:18
####move $131 $5
#lw $131 $5 0
####move $132 $7
#lw $132 $7 0
#sub $132 $131 $132
#beqz $132 l:18
####move $133 $3
#lw $133 $3 0
####move $134 $9
#lw $134 $9 0
#sub $134 $133 $134
#beqz $134 l:18
####move $135 $11
#move $136 $11
#lw $135 $11 0
#addi $137 $135 1
#sw $137 $136 0
#label l:18
#label l:17
####move $138 $23
#move $139 $23
#lw $138 $23 0
#addi $140 $138 1
#sw $140 $139 0
#goto l:15
#label l:16
#label l:14
####move $141 $21
#move $142 $21
#lw $141 $21 0
#addi $143 $141 1
#sw $143 $142 0
#goto l:12
#label l:13
#label l:11
####move $144 $19
#move $145 $19
#lw $144 $19 0
#addi $146 $144 1
#sw $146 $145 0
#goto l:9
#label l:10
#label l:8
####move $147 $17
#move $148 $17
#lw $147 $17 0
#addi $149 $147 1
#sw $149 $148 0
#goto l:6
#label l:7
#label l:5
####move $150 $15
#move $151 $15
#lw $150 $15 0
#addi $152 $150 1
#sw $152 $151 0
#goto l:3
#label l:4
#label l:2
####move $153 $13
#move $154 $13
#lw $153 $13 0
#addi $155 $153 1
#sw $155 $154 0
#goto l:0
#label l:1
####move $157 $11
#addi $158 $0 -632
#lw $157 $11 0
#sw $157 $158 0
#move $159 $160
#addi $161 $0 -636
#sw $159 $161 0
#addi $0 $0 -636
#call #printf
#subi $0 $0 -636
#li $162 0
#addi $163 $0 4
#sw $162 $163 0
#return
#return
