.data
temp: .space 488
var0: .asciiz "explode %d\n"
.align 2
var1: .asciiz "Wow, congratulations!\nt1 = %d\n"
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

__isdecdigit:
add $8, $29, 0
sw $8, -4($sp)
lw $9, -4($sp)
lb $8, 0($9)
sw $8, -8($sp)
li $8, 48
sw $8, -12($sp)
lw $9, -8($sp)
lw $10, -12($sp)
sub $8, $9, $10
sw $8, -12($sp)
li $8, 1
sw $8, -8($sp)
lw $8, -12($sp)
bgez $8, label0
li $8, 0
sw $8, -8($sp)
label0:
lw $8, -8($sp)
beqz $8, label1
lw $9, -4($sp)
lb $8, 0($9)
sw $8, -8($sp)
li $8, 57
sw $8, -16($sp)
lw $9, -8($sp)
lw $10, -16($sp)
sub $8, $9, $10
sw $8, -16($sp)
li $8, 1
sw $8, -8($sp)
lw $8, -16($sp)
blez $8, label2
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
__getint:
add $8, $29, -108
sw $8, -8($sp)
lw $9, -8($sp)
move $8, $9
sw $8, -4($sp)
add $8, $29, -112
sw $8, -16($sp)
lw $9, -16($sp)
move $8, $9
sw $8, -12($sp)
label3:
sw $31, -120($29)
lw $9, -4($sp)
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
add $8, $29, -124
sw $8, -36($sp)
lw $9, -24($sp)
lb $8, 0($9)
sw $8, -24($sp)
lw $8, -24($sp)
lw $9, -36($sp)
sb $8, 0($9)
add $29, $29, -124
jal __isdecdigit
sub $29, $29, -124
lw $31, -120($29)
add $8, $29, -116
sw $8, -40($sp)
lw $9, -40($sp)
lw $8, 0($9)
sw $8, -20($sp)
lw $9, -20($sp)
li $8, 1
beqz $9, lnot0
li $8, 0
lnot0:
sw $8, -20($sp)
lw $8, -20($sp)
beqz $8, label4
j label3
j label3
label4:
lw $9, -12($sp)
move $8, $9
sw $8, -44($sp)
lw $9, -4($sp)
lw $8, 0($9)
sw $8, -48($sp)
li $8, 48
sw $8, -52($sp)
lw $9, -48($sp)
lw $10, -52($sp)
sub $8, $9, $10
sw $8, -48($sp)
lw $8, -48($sp)
lw $9, -44($sp)
sw $8, 0($9)
label5:
sw $31, -120($29)
lw $9, -4($sp)
move $8, $9
sw $8, -60($sp)
sw $31, -132($29)
add $29, $29, -132
jal __getchar
sub $29, $29, -132
lw $31, -132($29)
add $8, $29, -128
sw $8, -68($sp)
lw $9, -68($sp)
lw $8, 0($9)
sw $8, -64($sp)
lw $8, -64($sp)
lw $9, -60($sp)
sw $8, 0($9)
add $8, $29, -124
sw $8, -72($sp)
lw $9, -60($sp)
lb $8, 0($9)
sw $8, -60($sp)
lw $8, -60($sp)
lw $9, -72($sp)
sb $8, 0($9)
add $29, $29, -124
jal __isdecdigit
sub $29, $29, -124
lw $31, -120($29)
add $8, $29, -116
sw $8, -76($sp)
lw $9, -76($sp)
lw $8, 0($9)
sw $8, -56($sp)
lw $8, -56($sp)
beqz $8, label6
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
j label5
label6:
add $8, $29, 4
sw $8, -104($sp)
lw $9, -12($sp)
lw $8, 0($9)
sw $8, -100($sp)
lw $8, -100($sp)
lw $9, -104($sp)
sw $8, 0($9)
jr $ra
jr $ra
__explode:
add $8, $29, 0
sw $8, -4($sp)
lw $9, -4($sp)
lw $8, 0($9)
sw $8, -8($sp)
lw $8, -8($sp)
beqz $8, label7
add $8, $29, -72
sw $8, -16($sp)
lw $9, -16($sp)
move $8, $9
sw $8, -12($sp)
lw $9, -16($sp)
move $8, $9
sw $8, -20($sp)
li $8, 0
sw $8, -24($sp)
lw $8, -24($sp)
lw $9, -20($sp)
sw $8, 0($9)
label8:
lw $9, -12($sp)
lw $8, 0($9)
sw $8, -28($sp)
li $8, 1000
sw $8, -32($sp)
lw $9, -28($sp)
lw $10, -32($sp)
sub $8, $9, $10
sw $8, -32($sp)
lw $8, -32($sp)
bgez $8, label9
sw $31, -76($29)
add $8, $29, -80
sw $8, -44($sp)
lw $9, -12($sp)
lw $8, 0($9)
sw $8, -40($sp)
lw $8, -40($sp)
lw $9, -44($sp)
sw $8, 0($9)
lw $9, 180($a3)
move $8, $9
sw $8, -48($sp)
add $8, $29, -84
sw $8, -52($sp)
lw $8, -48($sp)
lw $9, -52($sp)
sw $8, 0($9)
add $29, $29, -84
jal __printf
sub $29, $29, -84
lw $31, -76($29)
label10:
lw $9, -12($sp)
move $8, $9
sw $8, -60($sp)
lw $9, -12($sp)
lw $8, 0($9)
sw $8, -56($sp)
lw $9, -56($sp)
add $8, $9, 1
sw $8, -56($sp)
lw $8, -56($sp)
lw $9, -60($sp)
sw $8, 0($9)
j label8
label9:
label7:
li $8, 1
sw $8, -64($sp)
add $8, $29, 8
sw $8, -68($sp)
lw $8, -64($sp)
lw $9, -68($sp)
sw $8, 0($9)
jr $ra
jr $ra
main:
la $a3, temp
la $t0, var0
sw $t0, 180($a3)
la $t0, var1
sw $t0, 432($a3)
add $8, $29, -284
sw $8, -8($sp)
lw $9, -8($sp)
move $8, $9
sw $8, -4($sp)
add $29, $29, -292
jal __getint
sub $29, $29, -292
add $8, $29, -288
sw $8, -16($sp)
lw $9, -16($sp)
lw $8, 0($9)
sw $8, -12($sp)
li $8, 1
sw $8, -20($sp)
lw $9, -12($sp)
lw $10, -20($sp)
add $8, $9, $10
sw $8, -12($sp)
lw $8, -12($sp)
lw $9, -4($sp)
sw $8, 0($9)
add $8, $29, -288
sw $8, -28($sp)
lw $9, -28($sp)
move $8, $9
sw $8, -24($sp)
add $29, $29, -296
jal __getint
sub $29, $29, -296
add $8, $29, -292
sw $8, -36($sp)
lw $9, -36($sp)
lw $8, 0($9)
sw $8, -32($sp)
li $8, 2
sw $8, -40($sp)
lw $9, -32($sp)
lw $10, -40($sp)
add $8, $9, $10
sw $8, -32($sp)
lw $8, -32($sp)
lw $9, -24($sp)
sw $8, 0($9)
add $8, $29, -292
sw $8, -48($sp)
lw $9, -48($sp)
move $8, $9
sw $8, -44($sp)
add $29, $29, -300
jal __getint
sub $29, $29, -300
add $8, $29, -296
sw $8, -56($sp)
lw $9, -56($sp)
lw $8, 0($9)
sw $8, -52($sp)
li $8, 3
sw $8, -60($sp)
lw $9, -52($sp)
lw $10, -60($sp)
add $8, $9, $10
sw $8, -52($sp)
lw $8, -52($sp)
lw $9, -44($sp)
sw $8, 0($9)
add $8, $29, -296
sw $8, -68($sp)
lw $9, -68($sp)
move $8, $9
sw $8, -64($sp)
li $8, 100
sw $8, -72($sp)
lw $8, -72($sp)
lw $9, -64($sp)
sw $8, 0($9)
label11:
lw $9, -64($sp)
lw $8, 0($9)
sw $8, -76($sp)
li $8, 0
sw $8, -80($sp)
lw $9, -76($sp)
lw $10, -80($sp)
sub $8, $9, $10
sw $8, -80($sp)
lw $8, -80($sp)
blez $8, label12
lw $9, -4($sp)
lw $8, 0($9)
sw $8, -84($sp)
li $8, 0
sw $8, -88($sp)
lw $9, -84($sp)
lw $10, -88($sp)
sub $8, $9, $10
sw $8, -88($sp)
lw $8, -88($sp)
bgtz $8, label15
add $8, $29, -308
sw $8, -100($sp)
lw $9, -4($sp)
lw $8, 0($9)
sw $8, -96($sp)
lw $8, -96($sp)
lw $9, -100($sp)
sw $8, 0($9)
add $29, $29, -308
jal __explode
sub $29, $29, -308
add $8, $29, -300
sw $8, -104($sp)
lw $9, -104($sp)
lw $8, 0($9)
sw $8, -92($sp)
lw $8, -92($sp)
beqz $8, label13
label15:
lw $9, -24($sp)
lw $8, 0($9)
sw $8, -108($sp)
li $8, 1
sw $8, -112($sp)
lw $9, -108($sp)
lw $10, -112($sp)
sub $8, $9, $10
sw $8, -112($sp)
li $8, 1
sw $8, -108($sp)
lw $8, -112($sp)
bgtz $8, label19
li $8, 0
sw $8, -108($sp)
label19:
lw $8, -108($sp)
beqz $8, label20
lw $9, -44($sp)
lw $8, 0($9)
sw $8, -108($sp)
li $8, 2
sw $8, -116($sp)
lw $9, -108($sp)
lw $10, -116($sp)
sub $8, $9, $10
sw $8, -116($sp)
li $8, 1
sw $8, -108($sp)
lw $8, -116($sp)
bgtz $8, label21
li $8, 0
sw $8, -108($sp)
label21:
label20:
lw $9, -108($sp)
andi $8, $9, 1
sw $8, -108($sp)
lw $8, -108($sp)
bnez $8, label18
add $8, $29, -308
sw $8, -128($sp)
lw $9, -24($sp)
lw $8, 0($9)
sw $8, -124($sp)
lw $8, -124($sp)
lw $9, -128($sp)
sw $8, 0($9)
add $29, $29, -308
jal __explode
sub $29, $29, -308
add $8, $29, -300
sw $8, -132($sp)
lw $9, -132($sp)
lw $8, 0($9)
sw $8, -120($sp)
lw $8, -120($sp)
beqz $8, label16
label18:
lw $9, -24($sp)
lw $8, 0($9)
sw $8, -136($sp)
li $8, 0
sw $8, -140($sp)
lw $9, -136($sp)
lw $10, -140($sp)
sub $8, $9, $10
sw $8, -140($sp)
lw $8, -140($sp)
bgtz $8, label22
add $8, $29, -308
sw $8, -152($sp)
lw $9, -44($sp)
lw $8, 0($9)
sw $8, -148($sp)
lw $8, -148($sp)
lw $9, -152($sp)
sw $8, 0($9)
add $29, $29, -308
jal __explode
sub $29, $29, -308
add $8, $29, -300
sw $8, -156($sp)
lw $9, -156($sp)
lw $8, 0($9)
sw $8, -144($sp)
lw $8, -144($sp)
beqz $8, label22
add $8, $29, -308
sw $8, -168($sp)
lw $9, -44($sp)
lw $8, 0($9)
sw $8, -164($sp)
lw $8, -164($sp)
lw $9, -168($sp)
sw $8, 0($9)
add $29, $29, -308
jal __explode
sub $29, $29, -308
add $8, $29, -300
sw $8, -172($sp)
lw $9, -172($sp)
move $8, $9
sw $8, -160($sp)
j label23
label22:
j label24
li $8, 1000
sw $8, -180($sp)
add $8, $29, -308
sw $8, -184($sp)
lw $8, -180($sp)
lw $9, -184($sp)
sw $8, 0($9)
add $29, $29, -308
jal __explode
sub $29, $29, -308
add $8, $29, -300
sw $8, -188($sp)
lw $9, -188($sp)
move $8, $9
sw $8, -176($sp)
j label25
label24:
li $8, 0
sw $8, -196($sp)
add $8, $29, -308
sw $8, -200($sp)
lw $8, -196($sp)
lw $9, -200($sp)
sw $8, 0($9)
add $29, $29, -308
jal __explode
sub $29, $29, -308
add $8, $29, -300
sw $8, -204($sp)
lw $9, -204($sp)
lw $8, 0($9)
sw $8, -192($sp)
lw $8, -192($sp)
beqz $8, label26
lw $9, -64($sp)
lw $8, 0($9)
sw $8, -208($sp)
li $8, 1
sw $8, -212($sp)
lw $9, -208($sp)
lw $10, -212($sp)
sub $8, $9, $10
sw $8, -212($sp)
lw $8, -212($sp)
bnez $8, label26
add $8, $29, -304
sw $8, -224($sp)
lw $9, -4($sp)
lw $8, 0($9)
sw $8, -220($sp)
lw $8, -220($sp)
lw $9, -224($sp)
sw $8, 0($9)
lw $9, 432($a3)
move $8, $9
sw $8, -228($sp)
add $8, $29, -308
sw $8, -232($sp)
lw $8, -228($sp)
lw $9, -232($sp)
sw $8, 0($9)
add $29, $29, -308
jal __printf
sub $29, $29, -308
label26:
label25:
label23:
j label17
label16:
add $8, $29, -308
sw $8, -244($sp)
lw $9, -24($sp)
lw $8, 0($9)
sw $8, -240($sp)
lw $8, -240($sp)
lw $9, -244($sp)
sw $8, 0($9)
add $29, $29, -308
jal __explode
sub $29, $29, -308
add $8, $29, -300
sw $8, -248($sp)
lw $9, -248($sp)
move $8, $9
sw $8, -236($sp)
label17:
j label14
label13:
add $8, $29, -308
sw $8, -260($sp)
lw $9, -4($sp)
lw $8, 0($9)
sw $8, -256($sp)
lw $8, -256($sp)
lw $9, -260($sp)
sw $8, 0($9)
add $29, $29, -308
jal __explode
sub $29, $29, -308
add $8, $29, -300
sw $8, -264($sp)
lw $9, -264($sp)
move $8, $9
sw $8, -252($sp)
label14:
lw $9, -64($sp)
move $8, $9
sw $8, -272($sp)
lw $9, -64($sp)
lw $8, 0($9)
sw $8, -268($sp)
lw $9, -268($sp)
sub $8, $9, 1
sw $8, -268($sp)
lw $8, -268($sp)
lw $9, -272($sp)
sw $8, 0($9)
j label11
label12:
li $8, 0
sw $8, -276($sp)
add $8, $29, 4
sw $8, -280($sp)
lw $8, -276($sp)
lw $9, -280($sp)
sw $8, 0($9)
j __main_end
j __main_end
__main_end:
li $v0, 10
syscall
#string $45 #explode %d\n
#string $108 #Wow, congratulations!\nt1 = %d\n
#----------------------------
#func #isdecdigit
#addi $2 $0 0
####move $3 $2
#lb $3 $2 0
#li $4 48
#sub $4 $3 $4
#li $3 1
#bgez $4 l:0
#li $3 0
#label l:0
#beqz $3 l:1
####move $3 $2
#lb $3 $2 0
#li $5 57
#sub $5 $3 $5
#li $3 1
#blez $5 l:2
#li $3 0
#label l:2
#label l:1
#andi $3 $3 1
#addi $6 $0 8
#sw $3 $6 0
#return
#return
#----------------------------
#func #getint
#addi $8 $0 -108
#move $7 $8
#addi $10 $0 -112
#move $9 $10
#label l:3
#sw $1 $0 -120
#move $12 $7
#sw $1 $0 -132
#addi $0 $0 -132
#call #getchar
#subi $0 $0 -132
#lw $1 $0 -132
#addi $14 $0 -128
####move $13 $14
#lw $13 $14 0
#sw $13 $12 0
#addi $15 $0 -124
#lb $12 $12 0
#sb $12 $15 0
#addi $0 $0 -124
#call #isdecdigit
#subi $0 $0 -124
#lw $1 $0 -120
#addi $16 $0 -116
####move $11 $16
#lw $11 $16 0
#lnot $11 $11
#beqz $11 l:4
#goto l:3
#goto l:3
#label l:4
#move $17 $9
####move $18 $7
#lw $18 $7 0
#li $19 48
#sub $18 $18 $19
#sw $18 $17 0
#label l:5
#sw $1 $0 -120
#move $21 $7
#sw $1 $0 -132
#addi $0 $0 -132
#call #getchar
#subi $0 $0 -132
#lw $1 $0 -132
#addi $23 $0 -128
####move $22 $23
#lw $22 $23 0
#sw $22 $21 0
#addi $24 $0 -124
#lb $21 $21 0
#sb $21 $24 0
#addi $0 $0 -124
#call #isdecdigit
#subi $0 $0 -124
#lw $1 $0 -120
#addi $25 $0 -116
####move $20 $25
#lw $20 $25 0
#beqz $20 l:6
#move $26 $9
####move $27 $9
#lw $27 $9 0
#li $28 10
#mul $27 $27 $28
####move $29 $7
#lw $29 $7 0
#add $27 $27 $29
#li $30 48
#sub $27 $27 $30
#sw $27 $26 0
#goto l:5
#label l:6
####move $31 $9
#addi $32 $0 4
#lw $31 $9 0
#sw $31 $32 0
#return
#return
#----------------------------
#func #explode
#addi $33 $0 0
####move $34 $33
#lw $34 $33 0
#beqz $34 l:7
#addi $36 $0 -72
#move $35 $36
#move $37 $36
#li $38 0
#sw $38 $37 0
#label l:8
####move $39 $35
#lw $39 $35 0
#li $40 1000
#sub $40 $39 $40
#bgez $40 l:9
#sw $1 $0 -76
####move $42 $35
#addi $43 $0 -80
#lw $42 $35 0
#sw $42 $43 0
#move $44 $45
#addi $46 $0 -84
#sw $44 $46 0
#addi $0 $0 -84
#call #printf
#subi $0 $0 -84
#lw $1 $0 -76
#label l:10
####move $47 $35
#move $48 $35
#lw $47 $35 0
#addi $47 $47 1
#sw $47 $48 0
#goto l:8
#label l:9
#label l:7
#li $49 1
#addi $50 $0 8
#sw $49 $50 0
#return
#return
#----------------------------
#func #main
#addi $52 $0 -284
#move $51 $52
#addi $0 $0 -292
#call #getint
#subi $0 $0 -292
#addi $54 $0 -288
####move $53 $54
#lw $53 $54 0
#li $55 1
#add $53 $53 $55
#sw $53 $51 0
#addi $57 $0 -288
#move $56 $57
#addi $0 $0 -296
#call #getint
#subi $0 $0 -296
#addi $59 $0 -292
####move $58 $59
#lw $58 $59 0
#li $60 2
#add $58 $58 $60
#sw $58 $56 0
#addi $62 $0 -292
#move $61 $62
#addi $0 $0 -300
#call #getint
#subi $0 $0 -300
#addi $64 $0 -296
####move $63 $64
#lw $63 $64 0
#li $65 3
#add $63 $63 $65
#sw $63 $61 0
#addi $67 $0 -296
#move $66 $67
#li $68 100
#sw $68 $66 0
#label l:11
####move $69 $66
#lw $69 $66 0
#li $70 0
#sub $70 $69 $70
#blez $70 l:12
####move $71 $51
#lw $71 $51 0
#li $72 0
#sub $72 $71 $72
#bgtz $72 l:15
####move $74 $51
#addi $75 $0 -308
#lw $74 $51 0
#sw $74 $75 0
#addi $0 $0 -308
#call #explode
#subi $0 $0 -308
#addi $76 $0 -300
####move $73 $76
#lw $73 $76 0
#beqz $73 l:13
#label l:15
####move $77 $56
#lw $77 $56 0
#li $78 1
#sub $78 $77 $78
#li $77 1
#bgtz $78 l:19
#li $77 0
#label l:19
#beqz $77 l:20
####move $77 $61
#lw $77 $61 0
#li $79 2
#sub $79 $77 $79
#li $77 1
#bgtz $79 l:21
#li $77 0
#label l:21
#label l:20
#andi $77 $77 1
#bnez $77 l:18
####move $81 $56
#addi $82 $0 -308
#lw $81 $56 0
#sw $81 $82 0
#addi $0 $0 -308
#call #explode
#subi $0 $0 -308
#addi $83 $0 -300
####move $80 $83
#lw $80 $83 0
#beqz $80 l:16
#label l:18
####move $84 $56
#lw $84 $56 0
#li $85 0
#sub $85 $84 $85
#bgtz $85 l:22
####move $87 $61
#addi $88 $0 -308
#lw $87 $61 0
#sw $87 $88 0
#addi $0 $0 -308
#call #explode
#subi $0 $0 -308
#addi $89 $0 -300
####move $86 $89
#lw $86 $89 0
#beqz $86 l:22
####move $91 $61
#addi $92 $0 -308
#lw $91 $61 0
#sw $91 $92 0
#addi $0 $0 -308
#call #explode
#subi $0 $0 -308
#addi $93 $0 -300
#move $90 $93
#goto l:23
#label l:22
#goto l:24
#li $95 1000
#addi $96 $0 -308
#sw $95 $96 0
#addi $0 $0 -308
#call #explode
#subi $0 $0 -308
#addi $97 $0 -300
#move $94 $97
#goto l:25
#label l:24
#li $99 0
#addi $100 $0 -308
#sw $99 $100 0
#addi $0 $0 -308
#call #explode
#subi $0 $0 -308
#addi $101 $0 -300
####move $98 $101
#lw $98 $101 0
#beqz $98 l:26
####move $102 $66
#lw $102 $66 0
#li $103 1
#sub $103 $102 $103
#bnez $103 l:26
####move $105 $51
#addi $106 $0 -304
#lw $105 $51 0
#sw $105 $106 0
#move $107 $108
#addi $109 $0 -308
#sw $107 $109 0
#addi $0 $0 -308
#call #printf
#subi $0 $0 -308
#label l:26
#label l:25
#label l:23
#goto l:17
#label l:16
####move $111 $56
#addi $112 $0 -308
#lw $111 $56 0
#sw $111 $112 0
#addi $0 $0 -308
#call #explode
#subi $0 $0 -308
#addi $113 $0 -300
#move $110 $113
#label l:17
#goto l:14
#label l:13
####move $115 $51
#addi $116 $0 -308
#lw $115 $51 0
#sw $115 $116 0
#addi $0 $0 -308
#call #explode
#subi $0 $0 -308
#addi $117 $0 -300
#move $114 $117
#label l:14
####move $118 $66
#move $119 $66
#lw $118 $66 0
#subi $118 $118 1
#sw $118 $119 0
#goto l:11
#label l:12
#li $120 0
#addi $121 $0 4
#sw $120 $121 0
#return
#return
