.data
temp: .space 476
var0: .space 800
var1: .space 4
var2: .asciiz "(%d,%d)\n"
.align 2
var3: .asciiz "[%d,%d]\n"
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
add $8, $29, -140
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
lw $9, 12($a3)
lw $8, 0($9)
sw $8, -24($sp)
lw $9, -20($sp)
lw $10, -24($sp)
sub $8, $9, $10
sw $8, -24($sp)
lw $8, -24($sp)
bgez $8, label1
lw $9, -4($sp)
lw $8, 0($9)
sw $8, -32($sp)
lw $9, -32($sp)
mul $8, $9, 8
sw $8, -36($sp)
lw $9, 8($a3)
lw $10, -36($sp)
add $8, $9, $10
sw $8, -28($sp)
lw $9, -28($sp)
add $8, $9, 0
sw $8, -28($sp)
lw $9, -4($sp)
lw $8, 0($9)
sw $8, -40($sp)
li $8, 2
sw $8, -44($sp)
lw $9, -40($sp)
lw $10, -44($sp)
mul $8, $9, $10
sw $8, -40($sp)
li $8, 1
sw $8, -48($sp)
lw $9, -40($sp)
lw $10, -48($sp)
add $8, $9, $10
sw $8, -40($sp)
li $8, 20
sw $8, -52($sp)
lw $9, -40($sp)
lw $10, -52($sp)
rem $8, $9, $10
sw $8, -40($sp)
lw $8, -40($sp)
lw $9, -28($sp)
sw $8, 0($9)
lw $9, -4($sp)
lw $8, 0($9)
sw $8, -60($sp)
lw $9, -60($sp)
mul $8, $9, 8
sw $8, -64($sp)
lw $9, 8($a3)
lw $10, -64($sp)
add $8, $9, $10
sw $8, -56($sp)
lw $9, -56($sp)
add $8, $9, 4
sw $8, -56($sp)
lw $9, -4($sp)
lw $8, 0($9)
sw $8, -68($sp)
li $8, 5
sw $8, -72($sp)
lw $9, -68($sp)
lw $10, -72($sp)
mul $8, $9, $10
sw $8, -68($sp)
li $8, 1
sw $8, -76($sp)
lw $9, -68($sp)
lw $10, -76($sp)
sub $8, $9, $10
sw $8, -68($sp)
li $8, 40
sw $8, -80($sp)
lw $9, -68($sp)
lw $10, -80($sp)
rem $8, $9, $10
sw $8, -68($sp)
lw $8, -68($sp)
lw $9, -56($sp)
sw $8, 0($9)
sw $31, -144($29)
lw $9, -4($sp)
lw $8, 0($9)
sw $8, -92($sp)
lw $9, -92($sp)
mul $8, $9, 8
sw $8, -96($sp)
lw $9, 8($a3)
lw $10, -96($sp)
add $8, $9, $10
sw $8, -88($sp)
lw $9, -88($sp)
add $8, $9, 4
sw $8, -88($sp)
add $8, $29, -148
sw $8, -100($sp)
lw $9, -88($sp)
lw $8, 0($9)
sw $8, -88($sp)
lw $8, -88($sp)
lw $9, -100($sp)
sw $8, 0($9)
lw $9, -4($sp)
lw $8, 0($9)
sw $8, -108($sp)
lw $9, -108($sp)
mul $8, $9, 8
sw $8, -112($sp)
lw $9, 8($a3)
lw $10, -112($sp)
add $8, $9, $10
sw $8, -104($sp)
lw $9, -104($sp)
add $8, $9, 0
sw $8, -104($sp)
add $8, $29, -152
sw $8, -116($sp)
lw $9, -104($sp)
lw $8, 0($9)
sw $8, -104($sp)
lw $8, -104($sp)
lw $9, -116($sp)
sw $8, 0($9)
lw $9, 140($a3)
move $8, $9
sw $8, -120($sp)
add $8, $29, -156
sw $8, -124($sp)
lw $8, -120($sp)
lw $9, -124($sp)
sw $8, 0($9)
add $29, $29, -156
jal __printf
sub $29, $29, -156
lw $31, -144($29)
label2:
lw $9, -4($sp)
move $8, $9
sw $8, -132($sp)
lw $9, -4($sp)
lw $8, 0($9)
sw $8, -128($sp)
lw $9, -128($sp)
add $8, $9, 1
sw $8, -136($sp)
lw $8, -136($sp)
lw $9, -132($sp)
sw $8, 0($9)
j label0
label1:
jr $ra
main:
la $a3, temp
la $t0, var0
sw $t0, 8($a3)
la $t0, var1
sw $t0, 12($a3)
la $t0, var2
sw $t0, 140($a3)
la $t0, var3
sw $t0, 460($a3)
li $8, 100
sw $8, 16($a3)
lw $8, 16($a3)
lw $9, 12($a3)
sw $8, 0($9)
add $8, $29, -316
sw $8, -8($sp)
lw $9, -8($sp)
move $8, $9
sw $8, -4($sp)
add $8, $29, -320
sw $8, -16($sp)
lw $9, -16($sp)
move $8, $9
sw $8, -12($sp)
add $8, $29, -328
sw $8, -24($sp)
lw $9, -24($sp)
move $8, $9
sw $8, -20($sp)
add $29, $29, -332
jal __init
sub $29, $29, -332
lw $9, -8($sp)
move $8, $9
sw $8, -32($sp)
li $8, 0
sw $8, -36($sp)
lw $8, -36($sp)
lw $9, -32($sp)
sw $8, 0($9)
label3:
lw $9, -4($sp)
lw $8, 0($9)
sw $8, -40($sp)
lw $9, 12($a3)
lw $8, 0($9)
sw $8, -44($sp)
lw $9, -40($sp)
lw $10, -44($sp)
sub $8, $9, $10
sw $8, -44($sp)
lw $8, -44($sp)
bgez $8, label4
lw $9, -12($sp)
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
label6:
lw $9, -12($sp)
lw $8, 0($9)
sw $8, -60($sp)
lw $9, 12($a3)
lw $8, 0($9)
sw $8, -64($sp)
lw $9, -60($sp)
lw $10, -64($sp)
sub $8, $9, $10
sw $8, -64($sp)
lw $8, -64($sp)
bgez $8, label7
lw $9, -4($sp)
lw $8, 0($9)
sw $8, -72($sp)
lw $9, -72($sp)
mul $8, $9, 8
sw $8, -76($sp)
lw $9, 8($a3)
lw $10, -76($sp)
add $8, $9, $10
sw $8, -68($sp)
lw $9, -68($sp)
add $8, $9, 0
sw $8, -68($sp)
lw $9, -68($sp)
lw $8, 0($9)
sw $8, -68($sp)
lw $9, -12($sp)
lw $8, 0($9)
sw $8, -84($sp)
lw $9, -84($sp)
mul $8, $9, 8
sw $8, -88($sp)
lw $9, 8($a3)
lw $10, -88($sp)
add $8, $9, $10
sw $8, -80($sp)
lw $9, -80($sp)
add $8, $9, 0
sw $8, -80($sp)
lw $9, -80($sp)
lw $8, 0($9)
sw $8, -80($sp)
lw $9, -68($sp)
lw $10, -80($sp)
sub $8, $9, $10
sw $8, -80($sp)
lw $8, -80($sp)
bgtz $8, label10
lw $9, -4($sp)
lw $8, 0($9)
sw $8, -96($sp)
lw $9, -96($sp)
mul $8, $9, 8
sw $8, -100($sp)
lw $9, 8($a3)
lw $10, -100($sp)
add $8, $9, $10
sw $8, -92($sp)
lw $9, -92($sp)
add $8, $9, 0
sw $8, -92($sp)
lw $9, -92($sp)
lw $8, 0($9)
sw $8, -92($sp)
lw $9, -12($sp)
lw $8, 0($9)
sw $8, -108($sp)
lw $9, -108($sp)
mul $8, $9, 8
sw $8, -112($sp)
lw $9, 8($a3)
lw $10, -112($sp)
add $8, $9, $10
sw $8, -104($sp)
lw $9, -104($sp)
add $8, $9, 0
sw $8, -104($sp)
lw $9, -104($sp)
lw $8, 0($9)
sw $8, -104($sp)
lw $9, -92($sp)
lw $10, -104($sp)
sub $8, $9, $10
sw $8, -104($sp)
li $8, 1
sw $8, -92($sp)
lw $8, -104($sp)
beqz $8, label11
li $8, 0
sw $8, -92($sp)
label11:
lw $8, -92($sp)
beqz $8, label12
lw $9, -4($sp)
lw $8, 0($9)
sw $8, -116($sp)
lw $9, -116($sp)
mul $8, $9, 8
sw $8, -120($sp)
lw $9, 8($a3)
lw $10, -120($sp)
add $8, $9, $10
sw $8, -92($sp)
lw $9, -92($sp)
add $8, $9, 4
sw $8, -92($sp)
lw $9, -92($sp)
lw $8, 0($9)
sw $8, -92($sp)
lw $9, -12($sp)
lw $8, 0($9)
sw $8, -128($sp)
lw $9, -128($sp)
mul $8, $9, 8
sw $8, -132($sp)
lw $9, 8($a3)
lw $10, -132($sp)
add $8, $9, $10
sw $8, -124($sp)
lw $9, -124($sp)
add $8, $9, 4
sw $8, -124($sp)
lw $9, -124($sp)
lw $8, 0($9)
sw $8, -124($sp)
lw $9, -92($sp)
lw $10, -124($sp)
sub $8, $9, $10
sw $8, -124($sp)
li $8, 1
sw $8, -92($sp)
lw $8, -124($sp)
bgtz $8, label13
li $8, 0
sw $8, -92($sp)
label13:
label12:
lw $9, -92($sp)
andi $8, $9, 1
sw $8, -92($sp)
lw $8, -92($sp)
beqz $8, label9
label10:
lw $9, -20($sp)
move $8, $9
sw $8, -136($sp)
lw $9, -4($sp)
lw $8, 0($9)
sw $8, -144($sp)
lw $9, -144($sp)
mul $8, $9, 8
sw $8, -148($sp)
lw $9, 8($a3)
lw $10, -148($sp)
add $8, $9, $10
sw $8, -140($sp)
lw $9, -20($sp)
move $8, $9
sw $8, -152($sp)
lw $9, -140($sp)
lw $8, 0($9)
sw $8, -160($sp)
lw $8, -160($sp)
lw $9, -152($sp)
sw $8, 0($9)
lw $9, -152($sp)
add $8, $9, 4
sw $8, -152($sp)
lw $9, -140($sp)
add $8, $9, 4
sw $8, -156($sp)
lw $9, -156($sp)
lw $8, 0($9)
sw $8, -160($sp)
lw $8, -160($sp)
lw $9, -152($sp)
sw $8, 0($9)
lw $9, -152($sp)
add $8, $9, 4
sw $8, -152($sp)
lw $9, -156($sp)
add $8, $9, 4
sw $8, -156($sp)
lw $9, -4($sp)
lw $8, 0($9)
sw $8, -168($sp)
lw $9, -168($sp)
mul $8, $9, 8
sw $8, -172($sp)
lw $9, 8($a3)
lw $10, -172($sp)
add $8, $9, $10
sw $8, -164($sp)
lw $9, -12($sp)
lw $8, 0($9)
sw $8, -180($sp)
lw $9, -180($sp)
mul $8, $9, 8
sw $8, -184($sp)
lw $9, 8($a3)
lw $10, -184($sp)
add $8, $9, $10
sw $8, -176($sp)
lw $9, -164($sp)
move $8, $9
sw $8, -188($sp)
lw $9, -176($sp)
lw $8, 0($9)
sw $8, -196($sp)
lw $8, -196($sp)
lw $9, -188($sp)
sw $8, 0($9)
lw $9, -188($sp)
add $8, $9, 4
sw $8, -188($sp)
lw $9, -176($sp)
add $8, $9, 4
sw $8, -192($sp)
lw $9, -192($sp)
lw $8, 0($9)
sw $8, -196($sp)
lw $8, -196($sp)
lw $9, -188($sp)
sw $8, 0($9)
lw $9, -188($sp)
add $8, $9, 4
sw $8, -188($sp)
lw $9, -192($sp)
add $8, $9, 4
sw $8, -192($sp)
lw $9, -12($sp)
lw $8, 0($9)
sw $8, -204($sp)
lw $9, -204($sp)
mul $8, $9, 8
sw $8, -208($sp)
lw $9, 8($a3)
lw $10, -208($sp)
add $8, $9, $10
sw $8, -200($sp)
lw $9, -20($sp)
move $8, $9
sw $8, -212($sp)
lw $9, -200($sp)
move $8, $9
sw $8, -216($sp)
lw $9, -20($sp)
lw $8, 0($9)
sw $8, -224($sp)
lw $8, -224($sp)
lw $9, -216($sp)
sw $8, 0($9)
lw $9, -216($sp)
add $8, $9, 4
sw $8, -216($sp)
lw $9, -20($sp)
add $8, $9, 4
sw $8, -220($sp)
lw $9, -220($sp)
lw $8, 0($9)
sw $8, -224($sp)
lw $8, -224($sp)
lw $9, -216($sp)
sw $8, 0($9)
lw $9, -216($sp)
add $8, $9, 4
sw $8, -216($sp)
lw $9, -220($sp)
add $8, $9, 4
sw $8, -220($sp)
label9:
label8:
lw $9, -12($sp)
move $8, $9
sw $8, -232($sp)
lw $9, -12($sp)
lw $8, 0($9)
sw $8, -228($sp)
lw $9, -228($sp)
add $8, $9, 1
sw $8, -228($sp)
lw $8, -228($sp)
lw $9, -232($sp)
sw $8, 0($9)
j label6
label7:
label5:
lw $9, -4($sp)
move $8, $9
sw $8, -240($sp)
lw $9, -4($sp)
lw $8, 0($9)
sw $8, -236($sp)
lw $9, -236($sp)
add $8, $9, 1
sw $8, -244($sp)
lw $8, -244($sp)
lw $9, -240($sp)
sw $8, 0($9)
j label3
label4:
lw $9, -4($sp)
move $8, $9
sw $8, -248($sp)
li $8, 0
sw $8, -252($sp)
lw $8, -252($sp)
lw $9, -248($sp)
sw $8, 0($9)
label14:
lw $9, -4($sp)
lw $8, 0($9)
sw $8, -256($sp)
lw $9, 12($a3)
lw $8, 0($9)
sw $8, -260($sp)
lw $9, -256($sp)
lw $10, -260($sp)
sub $8, $9, $10
sw $8, -260($sp)
lw $8, -260($sp)
bgez $8, label15
lw $9, -4($sp)
lw $8, 0($9)
sw $8, -272($sp)
lw $9, -272($sp)
mul $8, $9, 8
sw $8, -276($sp)
lw $9, 8($a3)
lw $10, -276($sp)
add $8, $9, $10
sw $8, -268($sp)
lw $9, -268($sp)
add $8, $9, 4
sw $8, -268($sp)
add $8, $29, -336
sw $8, -280($sp)
lw $9, -268($sp)
lw $8, 0($9)
sw $8, -268($sp)
lw $8, -268($sp)
lw $9, -280($sp)
sw $8, 0($9)
lw $9, -4($sp)
lw $8, 0($9)
sw $8, -288($sp)
lw $9, -288($sp)
mul $8, $9, 8
sw $8, -292($sp)
lw $9, 8($a3)
lw $10, -292($sp)
add $8, $9, $10
sw $8, -284($sp)
lw $9, -284($sp)
add $8, $9, 0
sw $8, -284($sp)
add $8, $29, -340
sw $8, -296($sp)
lw $9, -284($sp)
lw $8, 0($9)
sw $8, -284($sp)
lw $8, -284($sp)
lw $9, -296($sp)
sw $8, 0($9)
lw $9, 460($a3)
move $8, $9
sw $8, -300($sp)
add $8, $29, -344
sw $8, -304($sp)
lw $8, -300($sp)
lw $9, -304($sp)
sw $8, 0($9)
add $29, $29, -344
jal __printf
sub $29, $29, -344
label16:
lw $9, -4($sp)
move $8, $9
sw $8, -312($sp)
lw $9, -4($sp)
lw $8, 0($9)
sw $8, -308($sp)
lw $9, -308($sp)
add $8, $9, 1
sw $8, -308($sp)
lw $8, -308($sp)
lw $9, -312($sp)
sw $8, 0($9)
j label14
label15:
j __main_end
__main_end:
li $v0, 10
syscall
#global $2 800
#global $3 4
#string $35 #(%d,%d)\n
#string $115 #[%d,%d]\n
#li $4 100
#sw $4 $3 0
#----------------------------
#func #init
#addi $6 $0 -140
#move $5 $6
#move $7 $6
#li $8 0
#sw $8 $7 0
#label l:0
####move $9 $5
#lw $9 $5 0
####move $10 $3
#lw $10 $3 0
#sub $10 $9 $10
#bgez $10 l:1
####move $11 $2
####move $12 $5
#lw $12 $5 0
#muli $13 $12 8
#add $11 $2 $13
#addi $11 $11 0
####move $14 $5
#lw $14 $5 0
#li $15 2
#mul $14 $14 $15
#li $16 1
#add $14 $14 $16
#li $17 20
#mod $14 $14 $17
#sw $14 $11 0
####move $18 $2
####move $19 $5
#lw $19 $5 0
#muli $20 $19 8
#add $18 $2 $20
#addi $18 $18 4
####move $21 $5
#lw $21 $5 0
#li $22 5
#mul $21 $21 $22
#li $23 1
#sub $21 $21 $23
#li $24 40
#mod $21 $21 $24
#sw $21 $18 0
#sw $1 $0 -144
####move $26 $2
####move $27 $5
#lw $27 $5 0
#muli $28 $27 8
#add $26 $2 $28
#addi $26 $26 4
#addi $29 $0 -148
#lw $26 $26 0
#sw $26 $29 0
####move $30 $2
####move $31 $5
#lw $31 $5 0
#muli $32 $31 8
#add $30 $2 $32
#addi $30 $30 0
#addi $33 $0 -152
#lw $30 $30 0
#sw $30 $33 0
#move $34 $35
#addi $36 $0 -156
#sw $34 $36 0
#addi $0 $0 -156
#call #printf
#subi $0 $0 -156
#lw $1 $0 -144
#label l:2
####move $37 $5
#move $38 $5
#lw $37 $5 0
#addi $39 $37 1
#sw $39 $38 0
#goto l:0
#label l:1
#return
#----------------------------
#func #main
#addi $41 $0 -316
#move $40 $41
#addi $43 $0 -320
#move $42 $43
#addi $45 $0 -328
#move $44 $45
#addi $0 $0 -332
#call #init
#subi $0 $0 -332
#move $47 $41
#li $48 0
#sw $48 $47 0
#label l:3
####move $49 $40
#lw $49 $40 0
####move $50 $3
#lw $50 $3 0
#sub $50 $49 $50
#bgez $50 l:4
#move $51 $42
####move $52 $40
#lw $52 $40 0
#li $53 1
#add $52 $52 $53
#sw $52 $51 0
#label l:6
####move $54 $42
#lw $54 $42 0
####move $55 $3
#lw $55 $3 0
#sub $55 $54 $55
#bgez $55 l:7
####move $56 $2
####move $57 $40
#lw $57 $40 0
#muli $58 $57 8
#add $56 $2 $58
#addi $56 $56 0
#lw $56 $56 0
####move $59 $2
####move $60 $42
#lw $60 $42 0
#muli $61 $60 8
#add $59 $2 $61
#addi $59 $59 0
#lw $59 $59 0
#sub $59 $56 $59
#bgtz $59 l:10
####move $62 $2
####move $63 $40
#lw $63 $40 0
#muli $64 $63 8
#add $62 $2 $64
#addi $62 $62 0
#lw $62 $62 0
####move $65 $2
####move $66 $42
#lw $66 $42 0
#muli $67 $66 8
#add $65 $2 $67
#addi $65 $65 0
#lw $65 $65 0
#sub $65 $62 $65
#li $62 1
#beqz $65 l:11
#li $62 0
#label l:11
#beqz $62 l:12
####move $62 $2
####move $68 $40
#lw $68 $40 0
#muli $69 $68 8
#add $62 $2 $69
#addi $62 $62 4
#lw $62 $62 0
####move $70 $2
####move $71 $42
#lw $71 $42 0
#muli $72 $71 8
#add $70 $2 $72
#addi $70 $70 4
#lw $70 $70 0
#sub $70 $62 $70
#li $62 1
#bgtz $70 l:13
#li $62 0
#label l:13
#label l:12
#andi $62 $62 1
#beqz $62 l:9
#label l:10
#move $73 $44
####move $74 $2
####move $75 $40
#lw $75 $40 0
#muli $76 $75 8
#add $74 $2 $76
#move $77 $44
####move $78 $74
#lw $79 $74 0
#sw $79 $77 0
#addi $77 $77 4
#addi $78 $74 4
#lw $79 $78 0
#sw $79 $77 0
#addi $77 $77 4
#addi $78 $78 4
####move $80 $2
####move $81 $40
#lw $81 $40 0
#muli $82 $81 8
#add $80 $2 $82
####move $83 $2
####move $84 $42
#lw $84 $42 0
#muli $85 $84 8
#add $83 $2 $85
#move $86 $80
####move $87 $83
#lw $88 $83 0
#sw $88 $86 0
#addi $86 $86 4
#addi $87 $83 4
#lw $88 $87 0
#sw $88 $86 0
#addi $86 $86 4
#addi $87 $87 4
####move $89 $2
####move $90 $42
#lw $90 $42 0
#muli $91 $90 8
#add $89 $2 $91
#move $92 $44
#move $93 $89
####move $94 $44
#lw $95 $44 0
#sw $95 $93 0
#addi $93 $93 4
#addi $94 $44 4
#lw $95 $94 0
#sw $95 $93 0
#addi $93 $93 4
#addi $94 $94 4
#label l:9
#label l:8
####move $96 $42
#move $97 $42
#lw $96 $42 0
#addi $96 $96 1
#sw $96 $97 0
#goto l:6
#label l:7
#label l:5
####move $98 $40
#move $99 $40
#lw $98 $40 0
#addi $100 $98 1
#sw $100 $99 0
#goto l:3
#label l:4
#move $101 $40
#li $102 0
#sw $102 $101 0
#label l:14
####move $103 $40
#lw $103 $40 0
####move $104 $3
#lw $104 $3 0
#sub $104 $103 $104
#bgez $104 l:15
####move $106 $2
####move $107 $40
#lw $107 $40 0
#muli $108 $107 8
#add $106 $2 $108
#addi $106 $106 4
#addi $109 $0 -336
#lw $106 $106 0
#sw $106 $109 0
####move $110 $2
####move $111 $40
#lw $111 $40 0
#muli $112 $111 8
#add $110 $2 $112
#addi $110 $110 0
#addi $113 $0 -340
#lw $110 $110 0
#sw $110 $113 0
#move $114 $115
#addi $116 $0 -344
#sw $114 $116 0
#addi $0 $0 -344
#call #printf
#subi $0 $0 -344
#label l:16
####move $117 $40
#move $118 $40
#lw $117 $40 0
#addi $117 $117 1
#sw $117 $118 0
#goto l:14
#label l:15
#return
