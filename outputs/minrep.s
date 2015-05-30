.data
temp: .space 536
var0: .space 1028
var1: .asciiz "%d\n"
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

__getMax:
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
lw $9, -8($sp)
lw $8, 0($9)
sw $8, -20($sp)
lw $8, -20($sp)
lw $9, -24($sp)
sw $8, 0($9)
jr $ra
label0:
add $8, $29, 12
sw $8, -32($sp)
lw $9, -4($sp)
lw $8, 0($9)
sw $8, -28($sp)
lw $8, -28($sp)
lw $9, -32($sp)
sw $8, 0($9)
jr $ra
jr $ra
__minimalRepresentation:
add $8, $29, 0
sw $8, -4($sp)
add $8, $29, 4
sw $8, -8($sp)
add $8, $29, -312
sw $8, -16($sp)
lw $9, -16($sp)
move $8, $9
sw $8, -12($sp)
add $8, $29, -316
sw $8, -24($sp)
lw $9, -24($sp)
move $8, $9
sw $8, -20($sp)
add $8, $29, -320
sw $8, -32($sp)
lw $9, -32($sp)
move $8, $9
sw $8, -28($sp)
add $8, $29, -324
sw $8, -40($sp)
lw $9, -40($sp)
move $8, $9
sw $8, -36($sp)
lw $9, -16($sp)
move $8, $9
sw $8, -44($sp)
li $8, 0
sw $8, -48($sp)
lw $8, -48($sp)
lw $9, -44($sp)
sw $8, 0($9)
label1:
lw $9, -12($sp)
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
bgez $8, label2
lw $9, -8($sp)
lw $8, 0($9)
sw $8, -60($sp)
lw $9, -12($sp)
lw $8, 0($9)
sw $8, -64($sp)
lw $9, -4($sp)
lw $8, 0($9)
sw $8, -72($sp)
lw $9, -64($sp)
lw $10, -72($sp)
add $8, $9, $10
sw $8, -64($sp)
lw $9, -64($sp)
mul $8, $9, 1
sw $8, -68($sp)
lw $9, -60($sp)
lw $10, -68($sp)
add $8, $9, $10
sw $8, -60($sp)
lw $9, -8($sp)
lw $8, 0($9)
sw $8, -76($sp)
lw $9, -12($sp)
lw $8, 0($9)
sw $8, -80($sp)
lw $9, -80($sp)
mul $8, $9, 1
sw $8, -84($sp)
lw $9, -76($sp)
lw $10, -84($sp)
add $8, $9, $10
sw $8, -76($sp)
lw $9, -76($sp)
lb $8, 0($9)
sw $8, -76($sp)
lw $8, -76($sp)
lw $9, -60($sp)
sb $8, 0($9)
label3:
lw $9, -12($sp)
move $8, $9
sw $8, -92($sp)
lw $9, -12($sp)
lw $8, 0($9)
sw $8, -88($sp)
lw $9, -88($sp)
add $8, $9, 1
sw $8, -88($sp)
lw $8, -88($sp)
lw $9, -92($sp)
sw $8, 0($9)
j label1
label2:
lw $9, -8($sp)
lw $8, 0($9)
sw $8, -96($sp)
lw $9, -4($sp)
lw $8, 0($9)
sw $8, -100($sp)
lw $9, -4($sp)
lw $8, 0($9)
sw $8, -108($sp)
lw $9, -100($sp)
lw $10, -108($sp)
add $8, $9, $10
sw $8, -100($sp)
lw $9, -100($sp)
mul $8, $9, 1
sw $8, -104($sp)
lw $9, -96($sp)
lw $10, -104($sp)
add $8, $9, $10
sw $8, -96($sp)
li $8, 0
sw $8, -112($sp)
lw $8, -112($sp)
lw $9, -96($sp)
sb $8, 0($9)
lw $9, -12($sp)
move $8, $9
sw $8, -120($sp)
li $8, 0
sw $8, -124($sp)
lw $8, -124($sp)
lw $9, -120($sp)
sw $8, 0($9)
lw $9, -20($sp)
move $8, $9
sw $8, -116($sp)
li $8, 1
sw $8, -128($sp)
lw $8, -128($sp)
lw $9, -116($sp)
sw $8, 0($9)
label4:
lw $9, -20($sp)
lw $8, 0($9)
sw $8, -132($sp)
lw $9, -4($sp)
lw $8, 0($9)
sw $8, -136($sp)
lw $9, -132($sp)
lw $10, -136($sp)
sub $8, $9, $10
sw $8, -136($sp)
lw $8, -136($sp)
bgez $8, label5
lw $9, -28($sp)
move $8, $9
sw $8, -140($sp)
li $8, 0
sw $8, -144($sp)
lw $8, -144($sp)
lw $9, -140($sp)
sw $8, 0($9)
label6:
lw $9, -28($sp)
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
bgez $8, label7
lw $9, -8($sp)
lw $8, 0($9)
sw $8, -156($sp)
lw $9, -12($sp)
lw $8, 0($9)
sw $8, -160($sp)
lw $9, -28($sp)
lw $8, 0($9)
sw $8, -168($sp)
lw $9, -160($sp)
lw $10, -168($sp)
add $8, $9, $10
sw $8, -160($sp)
lw $9, -160($sp)
mul $8, $9, 1
sw $8, -164($sp)
lw $9, -156($sp)
lw $10, -164($sp)
add $8, $9, $10
sw $8, -156($sp)
lw $9, -156($sp)
lb $8, 0($9)
sw $8, -156($sp)
lw $9, -8($sp)
lw $8, 0($9)
sw $8, -172($sp)
lw $9, -20($sp)
lw $8, 0($9)
sw $8, -176($sp)
lw $9, -28($sp)
lw $8, 0($9)
sw $8, -184($sp)
lw $9, -176($sp)
lw $10, -184($sp)
add $8, $9, $10
sw $8, -176($sp)
lw $9, -176($sp)
mul $8, $9, 1
sw $8, -180($sp)
lw $9, -172($sp)
lw $10, -180($sp)
add $8, $9, $10
sw $8, -172($sp)
lw $9, -172($sp)
lb $8, 0($9)
sw $8, -172($sp)
lw $9, -156($sp)
lw $10, -172($sp)
sub $8, $9, $10
sw $8, -172($sp)
lw $8, -172($sp)
bnez $8, label7
label8:
lw $9, -28($sp)
move $8, $9
sw $8, -192($sp)
lw $9, -28($sp)
lw $8, 0($9)
sw $8, -188($sp)
lw $9, -188($sp)
add $8, $9, 1
sw $8, -188($sp)
lw $8, -188($sp)
lw $9, -192($sp)
sw $8, 0($9)
j label6
label7:
lw $9, -28($sp)
lw $8, 0($9)
sw $8, -196($sp)
lw $9, -4($sp)
lw $8, 0($9)
sw $8, -200($sp)
lw $9, -196($sp)
lw $10, -200($sp)
sub $8, $9, $10
sw $8, -200($sp)
lw $8, -200($sp)
bltz $8, label9
j label5
label9:
lw $9, -8($sp)
lw $8, 0($9)
sw $8, -204($sp)
lw $9, -12($sp)
lw $8, 0($9)
sw $8, -208($sp)
lw $9, -28($sp)
lw $8, 0($9)
sw $8, -216($sp)
lw $9, -208($sp)
lw $10, -216($sp)
add $8, $9, $10
sw $8, -208($sp)
lw $9, -208($sp)
mul $8, $9, 1
sw $8, -212($sp)
lw $9, -204($sp)
lw $10, -212($sp)
add $8, $9, $10
sw $8, -204($sp)
lw $9, -204($sp)
lb $8, 0($9)
sw $8, -204($sp)
lw $9, -8($sp)
lw $8, 0($9)
sw $8, -220($sp)
lw $9, -20($sp)
lw $8, 0($9)
sw $8, -224($sp)
lw $9, -28($sp)
lw $8, 0($9)
sw $8, -232($sp)
lw $9, -224($sp)
lw $10, -232($sp)
add $8, $9, $10
sw $8, -224($sp)
lw $9, -224($sp)
mul $8, $9, 1
sw $8, -228($sp)
lw $9, -220($sp)
lw $10, -228($sp)
add $8, $9, $10
sw $8, -220($sp)
lw $9, -220($sp)
lb $8, 0($9)
sw $8, -220($sp)
lw $9, -204($sp)
lw $10, -220($sp)
sub $8, $9, $10
sw $8, -220($sp)
lw $8, -220($sp)
bgez $8, label10
lw $9, -20($sp)
move $8, $9
sw $8, -236($sp)
lw $9, -28($sp)
lw $8, 0($9)
sw $8, -240($sp)
li $8, 1
sw $8, -244($sp)
lw $9, -240($sp)
lw $10, -244($sp)
add $8, $9, $10
sw $8, -240($sp)
lw $9, -20($sp)
lw $8, 0($9)
sw $8, -248($sp)
lw $9, -248($sp)
lw $10, -240($sp)
add $8, $9, $10
sw $8, -248($sp)
lw $8, -248($sp)
lw $9, -236($sp)
sw $8, 0($9)
j label11
label10:
lw $9, -36($sp)
move $8, $9
sw $8, -252($sp)
lw $9, -12($sp)
lw $8, 0($9)
sw $8, -256($sp)
lw $9, -28($sp)
lw $8, 0($9)
sw $8, -260($sp)
lw $9, -256($sp)
lw $10, -260($sp)
add $8, $9, $10
sw $8, -256($sp)
lw $8, -256($sp)
lw $9, -252($sp)
sw $8, 0($9)
lw $9, -12($sp)
move $8, $9
sw $8, -264($sp)
lw $9, -20($sp)
lw $8, 0($9)
sw $8, -268($sp)
lw $8, -268($sp)
lw $9, -264($sp)
sw $8, 0($9)
lw $9, -20($sp)
move $8, $9
sw $8, -272($sp)
sw $31, -332($29)
add $8, $29, -336
sw $8, -284($sp)
lw $9, -20($sp)
lw $8, 0($9)
sw $8, -280($sp)
lw $8, -280($sp)
lw $9, -284($sp)
sw $8, 0($9)
add $8, $29, -340
sw $8, -292($sp)
lw $9, -36($sp)
lw $8, 0($9)
sw $8, -288($sp)
lw $8, -288($sp)
lw $9, -292($sp)
sw $8, 0($9)
add $29, $29, -340
jal __getMax
sub $29, $29, -340
lw $31, -332($29)
add $8, $29, -328
sw $8, -296($sp)
lw $9, -296($sp)
lw $8, 0($9)
sw $8, -276($sp)
li $8, 1
sw $8, -300($sp)
lw $9, -276($sp)
lw $10, -300($sp)
add $8, $9, $10
sw $8, -276($sp)
lw $8, -276($sp)
lw $9, -272($sp)
sw $8, 0($9)
label11:
j label4
label5:
add $8, $29, 12
sw $8, -308($sp)
lw $9, -12($sp)
lw $8, 0($9)
sw $8, -304($sp)
lw $8, -304($sp)
lw $9, -308($sp)
sw $8, 0($9)
jr $ra
jr $ra
__getString:
add $8, $29, 0
sw $8, -4($sp)
add $8, $29, -112
sw $8, -12($sp)
lw $9, -12($sp)
move $8, $9
sw $8, -8($sp)
li $8, 0
sw $8, -16($sp)
lw $8, -16($sp)
lw $9, -8($sp)
sw $8, 0($9)
add $8, $29, -116
sw $8, -24($sp)
lw $9, -24($sp)
move $8, $9
sw $8, -20($sp)
label12:
lw $9, -20($sp)
move $8, $9
sw $8, -28($sp)
sw $31, -124($29)
add $29, $29, -124
jal __getchar
sub $29, $29, -124
lw $31, -124($29)
add $8, $29, -120
sw $8, -36($sp)
lw $9, -36($sp)
lw $8, 0($9)
sw $8, -32($sp)
lw $8, -32($sp)
lw $9, -28($sp)
sw $8, 0($9)
li $8, 97
sw $8, -40($sp)
lw $9, -20($sp)
lw $8, 0($9)
sw $8, -44($sp)
lw $9, -40($sp)
lw $10, -44($sp)
sub $8, $9, $10
sw $8, -44($sp)
li $8, 1
sw $8, -40($sp)
lw $8, -44($sp)
blez $8, label16
li $8, 0
sw $8, -40($sp)
label16:
lw $8, -40($sp)
beqz $8, label17
lw $9, -20($sp)
lw $8, 0($9)
sw $8, -40($sp)
li $8, 122
sw $8, -48($sp)
lw $9, -40($sp)
lw $10, -48($sp)
sub $8, $9, $10
sw $8, -48($sp)
li $8, 1
sw $8, -40($sp)
lw $8, -48($sp)
blez $8, label18
li $8, 0
sw $8, -40($sp)
label18:
label17:
lw $9, -40($sp)
andi $8, $9, 1
sw $8, -40($sp)
lw $8, -40($sp)
bnez $8, label15
li $8, 65
sw $8, -52($sp)
lw $9, -20($sp)
lw $8, 0($9)
sw $8, -56($sp)
lw $9, -52($sp)
lw $10, -56($sp)
sub $8, $9, $10
sw $8, -56($sp)
li $8, 1
sw $8, -52($sp)
lw $8, -56($sp)
blez $8, label19
li $8, 0
sw $8, -52($sp)
label19:
lw $8, -52($sp)
beqz $8, label20
lw $9, -20($sp)
lw $8, 0($9)
sw $8, -52($sp)
li $8, 90
sw $8, -60($sp)
lw $9, -52($sp)
lw $10, -60($sp)
sub $8, $9, $10
sw $8, -60($sp)
li $8, 1
sw $8, -52($sp)
lw $8, -60($sp)
blez $8, label21
li $8, 0
sw $8, -52($sp)
label21:
label20:
lw $9, -52($sp)
andi $8, $9, 1
sw $8, -52($sp)
lw $8, -52($sp)
beqz $8, label14
label15:
lw $9, -4($sp)
lw $8, 0($9)
sw $8, -64($sp)
lw $9, -8($sp)
move $8, $9
sw $8, -76($sp)
lw $9, -8($sp)
lw $8, 0($9)
sw $8, -68($sp)
lw $9, -68($sp)
add $8, $9, 1
sw $8, -80($sp)
lw $8, -80($sp)
lw $9, -76($sp)
sw $8, 0($9)
lw $9, -68($sp)
mul $8, $9, 1
sw $8, -72($sp)
lw $9, -64($sp)
lw $10, -72($sp)
add $8, $9, $10
sw $8, -64($sp)
lw $9, -20($sp)
lb $8, 0($9)
sw $8, -84($sp)
lw $8, -84($sp)
lw $9, -64($sp)
sb $8, 0($9)
j label12
label14:
j label13
j label12
label13:
lw $9, -4($sp)
lw $8, 0($9)
sw $8, -88($sp)
lw $9, -8($sp)
lw $8, 0($9)
sw $8, -92($sp)
lw $9, -92($sp)
mul $8, $9, 1
sw $8, -96($sp)
lw $9, -88($sp)
lw $10, -96($sp)
add $8, $9, $10
sw $8, -88($sp)
li $8, 0
sw $8, -100($sp)
lw $8, -100($sp)
lw $9, -88($sp)
sb $8, 0($9)
add $8, $29, 8
sw $8, -108($sp)
lw $9, -8($sp)
lw $8, 0($9)
sw $8, -104($sp)
lw $8, -104($sp)
lw $9, -108($sp)
sw $8, 0($9)
jr $ra
jr $ra
main:
la $a3, temp
la $t0, var0
sw $t0, 456($a3)
la $t0, var1
sw $t0, 520($a3)
add $8, $29, -76
sw $8, -8($sp)
lw $9, -8($sp)
move $8, $9
sw $8, -4($sp)
lw $9, 456($a3)
move $8, $9
sw $8, -16($sp)
add $8, $29, -88
sw $8, -20($sp)
lw $8, -16($sp)
lw $9, -20($sp)
sw $8, 0($9)
add $29, $29, -88
jal __getString
sub $29, $29, -88
add $8, $29, -80
sw $8, -24($sp)
lw $9, -24($sp)
lw $8, 0($9)
sw $8, -12($sp)
lw $8, -12($sp)
lw $9, -4($sp)
sw $8, 0($9)
lw $9, 456($a3)
move $8, $9
sw $8, -36($sp)
add $8, $29, -96
sw $8, -40($sp)
lw $8, -36($sp)
lw $9, -40($sp)
sw $8, 0($9)
add $8, $29, -100
sw $8, -48($sp)
lw $9, -4($sp)
lw $8, 0($9)
sw $8, -44($sp)
lw $8, -44($sp)
lw $9, -48($sp)
sw $8, 0($9)
add $29, $29, -100
jal __minimalRepresentation
sub $29, $29, -100
add $8, $29, -88
sw $8, -52($sp)
add $8, $29, -84
sw $8, -56($sp)
lw $9, -52($sp)
lw $8, 0($9)
sw $8, -32($sp)
lw $8, -32($sp)
lw $9, -56($sp)
sw $8, 0($9)
lw $9, 520($a3)
move $8, $9
sw $8, -60($sp)
add $8, $29, -88
sw $8, -64($sp)
lw $8, -60($sp)
lw $9, -64($sp)
sw $8, 0($9)
add $29, $29, -88
jal __printf
sub $29, $29, -88
li $8, 0
sw $8, -68($sp)
add $8, $29, 4
sw $8, -72($sp)
lw $8, -68($sp)
lw $9, -72($sp)
sw $8, 0($9)
j __main_end
j __main_end
__main_end:
li $v0, 10
syscall
#global $114 1028
#string $130 #%d\n
#----------------------------
#func #getMax
#addi $2 $0 0
#addi $3 $0 4
####move $4 $2
#lw $4 $2 0
####move $5 $3
#lw $5 $3 0
#sub $5 $4 $5
#bgez $5 l:0
####move $6 $3
#addi $7 $0 12
#lw $6 $3 0
#sw $6 $7 0
#return
#label l:0
####move $8 $2
#addi $9 $0 12
#lw $8 $2 0
#sw $8 $9 0
#return
#return
#----------------------------
#func #minimalRepresentation
#addi $10 $0 0
#addi $11 $0 4
#addi $13 $0 -312
#move $12 $13
#addi $15 $0 -316
#move $14 $15
#addi $17 $0 -320
#move $16 $17
#addi $19 $0 -324
#move $18 $19
#move $20 $13
#li $21 0
#sw $21 $20 0
#label l:1
####move $22 $12
#lw $22 $12 0
####move $23 $10
#lw $23 $10 0
#sub $23 $22 $23
#bgez $23 l:2
####move $24 $11
#lw $24 $11 0
####move $25 $12
#lw $25 $12 0
####move $27 $10
#lw $27 $10 0
#add $25 $25 $27
#muli $26 $25 1
#add $24 $24 $26
####move $28 $11
#lw $28 $11 0
####move $29 $12
#lw $29 $12 0
#muli $30 $29 1
#add $28 $28 $30
#lb $28 $28 0
#sb $28 $24 0
#label l:3
####move $31 $12
#move $32 $12
#lw $31 $12 0
#addi $31 $31 1
#sw $31 $32 0
#goto l:1
#label l:2
####move $33 $11
#lw $33 $11 0
####move $34 $10
#lw $34 $10 0
####move $36 $10
#lw $36 $10 0
#add $34 $34 $36
#muli $35 $34 1
#add $33 $33 $35
#li $37 0
#sb $37 $33 0
#move $39 $12
#li $40 0
#sw $40 $39 0
#move $38 $14
#li $41 1
#sw $41 $38 0
#label l:4
####move $42 $14
#lw $42 $14 0
####move $43 $10
#lw $43 $10 0
#sub $43 $42 $43
#bgez $43 l:5
#move $44 $16
#li $45 0
#sw $45 $44 0
#label l:6
####move $46 $16
#lw $46 $16 0
####move $47 $10
#lw $47 $10 0
#sub $47 $46 $47
#bgez $47 l:7
####move $48 $11
#lw $48 $11 0
####move $49 $12
#lw $49 $12 0
####move $51 $16
#lw $51 $16 0
#add $49 $49 $51
#muli $50 $49 1
#add $48 $48 $50
#lb $48 $48 0
####move $52 $11
#lw $52 $11 0
####move $53 $14
#lw $53 $14 0
####move $55 $16
#lw $55 $16 0
#add $53 $53 $55
#muli $54 $53 1
#add $52 $52 $54
#lb $52 $52 0
#sub $52 $48 $52
#bnez $52 l:7
#label l:8
####move $56 $16
#move $57 $16
#lw $56 $16 0
#addi $56 $56 1
#sw $56 $57 0
#goto l:6
#label l:7
####move $58 $16
#lw $58 $16 0
####move $59 $10
#lw $59 $10 0
#sub $59 $58 $59
#bltz $59 l:9
#goto l:5
#label l:9
####move $60 $11
#lw $60 $11 0
####move $61 $12
#lw $61 $12 0
####move $63 $16
#lw $63 $16 0
#add $61 $61 $63
#muli $62 $61 1
#add $60 $60 $62
#lb $60 $60 0
####move $64 $11
#lw $64 $11 0
####move $65 $14
#lw $65 $14 0
####move $67 $16
#lw $67 $16 0
#add $65 $65 $67
#muli $66 $65 1
#add $64 $64 $66
#lb $64 $64 0
#sub $64 $60 $64
#bgez $64 l:10
#move $68 $14
####move $69 $16
#lw $69 $16 0
#li $70 1
#add $69 $69 $70
#lw $71 $14 0
#add $71 $71 $69
#sw $71 $68 0
#goto l:11
#label l:10
#move $72 $18
####move $73 $12
#lw $73 $12 0
####move $74 $16
#lw $74 $16 0
#add $73 $73 $74
#sw $73 $72 0
#move $75 $12
####move $76 $14
#lw $76 $14 0
#sw $76 $75 0
#move $77 $14
#sw $1 $0 -332
####move $79 $14
#addi $80 $0 -336
#lw $79 $14 0
#sw $79 $80 0
####move $81 $18
#addi $82 $0 -340
#lw $81 $18 0
#sw $81 $82 0
#addi $0 $0 -340
#call #getMax
#subi $0 $0 -340
#lw $1 $0 -332
#addi $83 $0 -328
####move $78 $83
#lw $78 $83 0
#li $84 1
#add $78 $78 $84
#sw $78 $77 0
#label l:11
#goto l:4
#label l:5
####move $85 $12
#addi $86 $0 12
#lw $85 $12 0
#sw $85 $86 0
#return
#return
#----------------------------
#func #getString
#addi $87 $0 0
#addi $89 $0 -112
#move $88 $89
#li $90 0
#sw $90 $88 0
#addi $92 $0 -116
#move $91 $92
#label l:12
#move $93 $91
#sw $1 $0 -124
#addi $0 $0 -124
#call #getchar
#subi $0 $0 -124
#lw $1 $0 -124
#addi $95 $0 -120
####move $94 $95
#lw $94 $95 0
#sw $94 $93 0
#li $96 97
####move $97 $91
#lw $97 $91 0
#sub $97 $96 $97
#li $96 1
#blez $97 l:16
#li $96 0
#label l:16
#beqz $96 l:17
####move $96 $91
#lw $96 $91 0
#li $98 122
#sub $98 $96 $98
#li $96 1
#blez $98 l:18
#li $96 0
#label l:18
#label l:17
#andi $96 $96 1
#bnez $96 l:15
#li $99 65
####move $100 $91
#lw $100 $91 0
#sub $100 $99 $100
#li $99 1
#blez $100 l:19
#li $99 0
#label l:19
#beqz $99 l:20
####move $99 $91
#lw $99 $91 0
#li $101 90
#sub $101 $99 $101
#li $99 1
#blez $101 l:21
#li $99 0
#label l:21
#label l:20
#andi $99 $99 1
#beqz $99 l:14
#label l:15
####move $102 $87
#lw $102 $87 0
####move $103 $88
#move $105 $88
#lw $103 $88 0
#addi $106 $103 1
#sw $106 $105 0
#muli $104 $103 1
#add $102 $102 $104
####move $107 $91
#lb $107 $91 0
#sb $107 $102 0
#goto l:12
#label l:14
#goto l:13
#goto l:12
#label l:13
####move $108 $87
#lw $108 $87 0
####move $109 $88
#lw $109 $88 0
#muli $110 $109 1
#add $108 $108 $110
#li $111 0
#sb $111 $108 0
####move $112 $88
#addi $113 $0 8
#lw $112 $88 0
#sw $112 $113 0
#return
#return
#----------------------------
#func #main
#addi $116 $0 -76
#move $115 $116
#move $118 $114
#addi $119 $0 -88
#sw $118 $119 0
#addi $0 $0 -88
#call #getString
#subi $0 $0 -88
#addi $120 $0 -80
####move $117 $120
#lw $117 $120 0
#sw $117 $115 0
#move $123 $114
#addi $124 $0 -96
#sw $123 $124 0
####move $125 $115
#addi $126 $0 -100
#lw $125 $115 0
#sw $125 $126 0
#addi $0 $0 -100
#call #minimalRepresentation
#subi $0 $0 -100
#addi $127 $0 -88
####move $122 $127
#addi $128 $0 -84
#lw $122 $127 0
#sw $122 $128 0
#move $129 $130
#addi $131 $0 -88
#sw $129 $131 0
#addi $0 $0 -88
#call #printf
#subi $0 $0 -88
#li $132 0
#addi $133 $0 4
#sw $132 $133 0
#return
#return
