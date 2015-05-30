.data
temp: .space 512
var0: .space 4
var1: .space 400
var2: .asciiz "%d %d\n"
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

__getHash:
add $8, $29, 0
sw $8, -4($sp)
lw $9, -4($sp)
lw $8, 0($9)
sw $8, -8($sp)
li $8, 237
sw $8, -12($sp)
lw $9, -8($sp)
lw $10, -12($sp)
mul $8, $9, $10
sw $8, -8($sp)
lw $9, 8($a3)
lw $8, 0($9)
sw $8, -16($sp)
lw $9, -8($sp)
lw $10, -16($sp)
rem $8, $9, $10
sw $8, -8($sp)
add $8, $29, 8
sw $8, -20($sp)
lw $8, -8($sp)
lw $9, -20($sp)
sw $8, 0($9)
jr $ra
jr $ra
__put:
add $8, $29, 0
sw $8, -4($sp)
add $8, $29, 4
sw $8, -8($sp)
add $8, $29, -228
sw $8, -16($sp)
lw $9, -16($sp)
move $8, $9
sw $8, -12($sp)
add $8, $29, -232
sw $8, -24($sp)
lw $9, -24($sp)
move $8, $9
sw $8, -20($sp)
li $8, 0
sw $8, -28($sp)
lw $8, -28($sp)
lw $9, -20($sp)
sw $8, 0($9)
lw $9, -16($sp)
move $8, $9
sw $8, -32($sp)
sw $31, -240($29)
add $8, $29, -244
sw $8, -44($sp)
lw $9, -4($sp)
lw $8, 0($9)
sw $8, -40($sp)
lw $8, -40($sp)
lw $9, -44($sp)
sw $8, 0($9)
add $29, $29, -244
jal __getHash
sub $29, $29, -244
lw $31, -240($29)
add $8, $29, -236
sw $8, -48($sp)
lw $9, -48($sp)
lw $8, 0($9)
sw $8, -36($sp)
lw $8, -36($sp)
lw $9, -32($sp)
sw $8, 0($9)
lw $9, -16($sp)
lw $8, 0($9)
sw $8, -56($sp)
lw $9, -56($sp)
mul $8, $9, 4
sw $8, -60($sp)
lw $9, 16($a3)
lw $10, -60($sp)
add $8, $9, $10
sw $8, -52($sp)
lw $9, -52($sp)
lw $8, 0($9)
sw $8, -52($sp)
li $8, 0
sw $8, -64($sp)
lw $9, -52($sp)
lw $10, -64($sp)
sub $8, $9, $10
sw $8, -64($sp)
lw $8, -64($sp)
bnez $8, label0
lw $9, -16($sp)
lw $8, 0($9)
sw $8, -72($sp)
lw $9, -72($sp)
mul $8, $9, 4
sw $8, -76($sp)
lw $9, 16($a3)
lw $10, -76($sp)
add $8, $9, $10
sw $8, -68($sp)
sw $31, -240($29)
li $8, 12
sw $8, -84($sp)
add $8, $29, -244
sw $8, -88($sp)
lw $8, -84($sp)
lw $9, -88($sp)
sw $8, 0($9)
add $29, $29, -244
jal __malloc
sub $29, $29, -244
lw $31, -240($29)
add $8, $29, -236
sw $8, -92($sp)
lw $9, -92($sp)
lw $8, 0($9)
sw $8, -80($sp)
lw $8, -80($sp)
lw $9, -68($sp)
sw $8, 0($9)
lw $9, -16($sp)
lw $8, 0($9)
sw $8, -100($sp)
lw $9, -100($sp)
mul $8, $9, 4
sw $8, -104($sp)
lw $9, 16($a3)
lw $10, -104($sp)
add $8, $9, $10
sw $8, -96($sp)
lw $9, -96($sp)
lw $8, 0($9)
sw $8, -96($sp)
lw $9, -96($sp)
add $8, $9, 0
sw $8, -96($sp)
lw $9, -4($sp)
lw $8, 0($9)
sw $8, -108($sp)
lw $8, -108($sp)
lw $9, -96($sp)
sw $8, 0($9)
lw $9, -16($sp)
lw $8, 0($9)
sw $8, -116($sp)
lw $9, -116($sp)
mul $8, $9, 4
sw $8, -120($sp)
lw $9, 16($a3)
lw $10, -120($sp)
add $8, $9, $10
sw $8, -112($sp)
lw $9, -112($sp)
lw $8, 0($9)
sw $8, -112($sp)
lw $9, -112($sp)
add $8, $9, 4
sw $8, -112($sp)
lw $9, -8($sp)
lw $8, 0($9)
sw $8, -124($sp)
lw $8, -124($sp)
lw $9, -112($sp)
sw $8, 0($9)
lw $9, -16($sp)
lw $8, 0($9)
sw $8, -132($sp)
lw $9, -132($sp)
mul $8, $9, 4
sw $8, -136($sp)
lw $9, 16($a3)
lw $10, -136($sp)
add $8, $9, $10
sw $8, -128($sp)
lw $9, -128($sp)
lw $8, 0($9)
sw $8, -128($sp)
lw $9, -128($sp)
add $8, $9, 8
sw $8, -128($sp)
li $8, 0
sw $8, -140($sp)
lw $8, -140($sp)
lw $9, -128($sp)
sw $8, 0($9)
jr $ra
label0:
lw $9, -20($sp)
move $8, $9
sw $8, -144($sp)
lw $9, -12($sp)
lw $8, 0($9)
sw $8, -152($sp)
lw $9, -152($sp)
mul $8, $9, 4
sw $8, -156($sp)
lw $9, 16($a3)
lw $10, -156($sp)
add $8, $9, $10
sw $8, -148($sp)
lw $9, -148($sp)
lw $8, 0($9)
sw $8, -148($sp)
lw $8, -148($sp)
lw $9, -144($sp)
sw $8, 0($9)
label1:
lw $9, -20($sp)
lw $8, 0($9)
sw $8, -160($sp)
lw $9, -160($sp)
add $8, $9, 0
sw $8, -160($sp)
lw $9, -160($sp)
lw $8, 0($9)
sw $8, -160($sp)
lw $9, -4($sp)
lw $8, 0($9)
sw $8, -164($sp)
lw $9, -160($sp)
lw $10, -164($sp)
sub $8, $9, $10
sw $8, -164($sp)
lw $8, -164($sp)
beqz $8, label2
lw $9, -20($sp)
lw $8, 0($9)
sw $8, -168($sp)
lw $9, -168($sp)
add $8, $9, 8
sw $8, -168($sp)
lw $9, -168($sp)
lw $8, 0($9)
sw $8, -168($sp)
li $8, 0
sw $8, -172($sp)
lw $9, -168($sp)
lw $10, -172($sp)
sub $8, $9, $10
sw $8, -172($sp)
lw $8, -172($sp)
bnez $8, label3
lw $9, -20($sp)
lw $8, 0($9)
sw $8, -176($sp)
lw $9, -176($sp)
add $8, $9, 8
sw $8, -176($sp)
sw $31, -240($29)
li $8, 12
sw $8, -184($sp)
add $8, $29, -244
sw $8, -188($sp)
lw $8, -184($sp)
lw $9, -188($sp)
sw $8, 0($9)
add $29, $29, -244
jal __malloc
sub $29, $29, -244
lw $31, -240($29)
add $8, $29, -236
sw $8, -192($sp)
lw $9, -192($sp)
lw $8, 0($9)
sw $8, -180($sp)
lw $8, -180($sp)
lw $9, -176($sp)
sw $8, 0($9)
lw $9, -20($sp)
lw $8, 0($9)
sw $8, -196($sp)
lw $9, -196($sp)
add $8, $9, 8
sw $8, -196($sp)
lw $9, -196($sp)
lw $8, 0($9)
sw $8, -196($sp)
lw $9, -196($sp)
add $8, $9, 0
sw $8, -196($sp)
lw $9, -4($sp)
lw $8, 0($9)
sw $8, -200($sp)
lw $8, -200($sp)
lw $9, -196($sp)
sw $8, 0($9)
lw $9, -20($sp)
lw $8, 0($9)
sw $8, -204($sp)
lw $9, -204($sp)
add $8, $9, 8
sw $8, -204($sp)
lw $9, -204($sp)
lw $8, 0($9)
sw $8, -204($sp)
lw $9, -204($sp)
add $8, $9, 8
sw $8, -204($sp)
li $8, 0
sw $8, -208($sp)
lw $8, -208($sp)
lw $9, -204($sp)
sw $8, 0($9)
label3:
lw $9, -20($sp)
move $8, $9
sw $8, -212($sp)
lw $9, -20($sp)
lw $8, 0($9)
sw $8, -216($sp)
lw $9, -216($sp)
add $8, $9, 8
sw $8, -216($sp)
lw $9, -216($sp)
lw $8, 0($9)
sw $8, -216($sp)
lw $8, -216($sp)
lw $9, -212($sp)
sw $8, 0($9)
j label1
label2:
lw $9, -20($sp)
lw $8, 0($9)
sw $8, -220($sp)
lw $9, -220($sp)
add $8, $9, 4
sw $8, -220($sp)
lw $9, -8($sp)
lw $8, 0($9)
sw $8, -224($sp)
lw $8, -224($sp)
lw $9, -220($sp)
sw $8, 0($9)
jr $ra
__get:
add $8, $29, 0
sw $8, -4($sp)
add $8, $29, -80
sw $8, -12($sp)
lw $9, -12($sp)
move $8, $9
sw $8, -8($sp)
add $8, $29, -84
sw $8, -20($sp)
lw $9, -20($sp)
move $8, $9
sw $8, -16($sp)
li $8, 0
sw $8, -24($sp)
lw $8, -24($sp)
lw $9, -16($sp)
sw $8, 0($9)
lw $9, -16($sp)
move $8, $9
sw $8, -28($sp)
sw $31, -92($29)
add $8, $29, -96
sw $8, -48($sp)
lw $9, -4($sp)
lw $8, 0($9)
sw $8, -44($sp)
lw $8, -44($sp)
lw $9, -48($sp)
sw $8, 0($9)
add $29, $29, -96
jal __getHash
sub $29, $29, -96
lw $31, -92($29)
add $8, $29, -88
sw $8, -52($sp)
lw $9, -52($sp)
lw $8, 0($9)
sw $8, -36($sp)
lw $9, -36($sp)
mul $8, $9, 4
sw $8, -40($sp)
lw $9, 16($a3)
lw $10, -40($sp)
add $8, $9, $10
sw $8, -32($sp)
lw $9, -32($sp)
lw $8, 0($9)
sw $8, -32($sp)
lw $8, -32($sp)
lw $9, -28($sp)
sw $8, 0($9)
label4:
lw $9, -16($sp)
lw $8, 0($9)
sw $8, -56($sp)
lw $9, -56($sp)
add $8, $9, 0
sw $8, -56($sp)
lw $9, -56($sp)
lw $8, 0($9)
sw $8, -56($sp)
lw $9, -4($sp)
lw $8, 0($9)
sw $8, -60($sp)
lw $9, -56($sp)
lw $10, -60($sp)
sub $8, $9, $10
sw $8, -60($sp)
lw $8, -60($sp)
beqz $8, label5
lw $9, -16($sp)
move $8, $9
sw $8, -64($sp)
lw $9, -16($sp)
lw $8, 0($9)
sw $8, -68($sp)
lw $9, -68($sp)
add $8, $9, 8
sw $8, -68($sp)
lw $9, -68($sp)
lw $8, 0($9)
sw $8, -68($sp)
lw $8, -68($sp)
lw $9, -64($sp)
sw $8, 0($9)
j label4
label5:
lw $9, -16($sp)
lw $8, 0($9)
sw $8, -72($sp)
lw $9, -72($sp)
add $8, $9, 4
sw $8, -72($sp)
add $8, $29, 8
sw $8, -76($sp)
lw $9, -72($sp)
lw $8, 0($9)
sw $8, -72($sp)
lw $8, -72($sp)
lw $9, -76($sp)
sw $8, 0($9)
jr $ra
jr $ra
main:
la $a3, temp
la $t0, var0
sw $t0, 8($a3)
la $t0, var1
sw $t0, 16($a3)
la $t0, var2
sw $t0, 492($a3)
li $8, 100
sw $8, 12($a3)
lw $8, 12($a3)
lw $9, 8($a3)
sw $8, 0($9)
add $8, $29, -172
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
lw $9, 8($a3)
lw $8, 0($9)
sw $8, -24($sp)
lw $9, -20($sp)
lw $10, -24($sp)
sub $8, $9, $10
sw $8, -24($sp)
lw $8, -24($sp)
bgez $8, label7
lw $9, -4($sp)
lw $8, 0($9)
sw $8, -32($sp)
lw $9, -32($sp)
mul $8, $9, 4
sw $8, -36($sp)
lw $9, 16($a3)
lw $10, -36($sp)
add $8, $9, $10
sw $8, -28($sp)
li $8, 0
sw $8, -40($sp)
lw $8, -40($sp)
lw $9, -28($sp)
sw $8, 0($9)
label8:
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
j label6
label7:
lw $9, -4($sp)
move $8, $9
sw $8, -56($sp)
li $8, 0
sw $8, -60($sp)
lw $8, -60($sp)
lw $9, -56($sp)
sw $8, 0($9)
label9:
lw $9, -4($sp)
lw $8, 0($9)
sw $8, -64($sp)
li $8, 1000
sw $8, -68($sp)
lw $9, -64($sp)
lw $10, -68($sp)
sub $8, $9, $10
sw $8, -68($sp)
lw $8, -68($sp)
bgez $8, label10
add $8, $29, -180
sw $8, -80($sp)
lw $9, -4($sp)
lw $8, 0($9)
sw $8, -76($sp)
lw $8, -76($sp)
lw $9, -80($sp)
sw $8, 0($9)
add $8, $29, -184
sw $8, -88($sp)
lw $9, -4($sp)
lw $8, 0($9)
sw $8, -84($sp)
lw $8, -84($sp)
lw $9, -88($sp)
sw $8, 0($9)
add $29, $29, -184
jal __put
sub $29, $29, -184
label11:
lw $9, -4($sp)
move $8, $9
sw $8, -96($sp)
lw $9, -4($sp)
lw $8, 0($9)
sw $8, -92($sp)
lw $9, -92($sp)
add $8, $9, 1
sw $8, -100($sp)
lw $8, -100($sp)
lw $9, -96($sp)
sw $8, 0($9)
j label9
label10:
lw $9, -4($sp)
move $8, $9
sw $8, -104($sp)
li $8, 0
sw $8, -108($sp)
lw $8, -108($sp)
lw $9, -104($sp)
sw $8, 0($9)
label12:
lw $9, -4($sp)
lw $8, 0($9)
sw $8, -112($sp)
li $8, 1000
sw $8, -116($sp)
lw $9, -112($sp)
lw $10, -116($sp)
sub $8, $9, $10
sw $8, -116($sp)
lw $8, -116($sp)
bgez $8, label13
add $8, $29, -192
sw $8, -132($sp)
lw $9, -4($sp)
lw $8, 0($9)
sw $8, -128($sp)
lw $8, -128($sp)
lw $9, -132($sp)
sw $8, 0($9)
add $29, $29, -192
jal __get
sub $29, $29, -192
add $8, $29, -184
sw $8, -136($sp)
add $8, $29, -180
sw $8, -140($sp)
lw $9, -136($sp)
lw $8, 0($9)
sw $8, -124($sp)
lw $8, -124($sp)
lw $9, -140($sp)
sw $8, 0($9)
add $8, $29, -184
sw $8, -148($sp)
lw $9, -4($sp)
lw $8, 0($9)
sw $8, -144($sp)
lw $8, -144($sp)
lw $9, -148($sp)
sw $8, 0($9)
lw $9, 492($a3)
move $8, $9
sw $8, -152($sp)
add $8, $29, -188
sw $8, -156($sp)
lw $8, -152($sp)
lw $9, -156($sp)
sw $8, 0($9)
add $29, $29, -188
jal __printf
sub $29, $29, -188
label14:
lw $9, -4($sp)
move $8, $9
sw $8, -164($sp)
lw $9, -4($sp)
lw $8, 0($9)
sw $8, -160($sp)
lw $9, -160($sp)
add $8, $9, 1
sw $8, -168($sp)
lw $8, -168($sp)
lw $9, -164($sp)
sw $8, 0($9)
j label12
label13:
j __main_end
__main_end:
li $v0, 10
syscall
#global $2 4
#global $4 400
#string $123 #%d %d\n
#li $3 100
#sw $3 $2 0
#----------------------------
#func #getHash
#addi $5 $0 0
####move $6 $5
#lw $6 $5 0
#li $7 237
#mul $6 $6 $7
####move $8 $2
#lw $8 $2 0
#mod $6 $6 $8
#addi $9 $0 8
#sw $6 $9 0
#return
#return
#----------------------------
#func #put
#addi $10 $0 0
#addi $11 $0 4
#addi $13 $0 -228
#move $12 $13
#addi $15 $0 -232
#move $14 $15
#li $16 0
#sw $16 $14 0
#move $17 $13
#sw $1 $0 -240
####move $19 $10
#addi $20 $0 -244
#lw $19 $10 0
#sw $19 $20 0
#addi $0 $0 -244
#call #getHash
#subi $0 $0 -244
#lw $1 $0 -240
#addi $21 $0 -236
####move $18 $21
#lw $18 $21 0
#sw $18 $17 0
####move $22 $4
####move $23 $13
#lw $23 $13 0
#muli $24 $23 4
#add $22 $4 $24
#lw $22 $22 0
#li $25 0
#sub $25 $22 $25
#bnez $25 l:0
####move $26 $4
####move $27 $13
#lw $27 $13 0
#muli $28 $27 4
#add $26 $4 $28
#sw $1 $0 -240
#li $30 12
#addi $31 $0 -244
#sw $30 $31 0
#addi $0 $0 -244
#call #malloc
#subi $0 $0 -244
#lw $1 $0 -240
#addi $32 $0 -236
####move $29 $32
#lw $29 $32 0
#sw $29 $26 0
####move $33 $4
####move $34 $13
#lw $34 $13 0
#muli $35 $34 4
#add $33 $4 $35
#lw $33 $33 0
#addi $33 $33 0
####move $36 $10
#lw $36 $10 0
#sw $36 $33 0
####move $37 $4
####move $38 $13
#lw $38 $13 0
#muli $39 $38 4
#add $37 $4 $39
#lw $37 $37 0
#addi $37 $37 4
####move $40 $11
#lw $40 $11 0
#sw $40 $37 0
####move $41 $4
####move $42 $13
#lw $42 $13 0
#muli $43 $42 4
#add $41 $4 $43
#lw $41 $41 0
#addi $41 $41 8
#li $44 0
#sw $44 $41 0
#return
#label l:0
#move $45 $14
####move $46 $4
####move $47 $12
#lw $47 $12 0
#muli $48 $47 4
#add $46 $4 $48
#lw $46 $46 0
#sw $46 $45 0
#label l:1
####move $49 $14
#lw $49 $14 0
#addi $49 $49 0
#lw $49 $49 0
####move $50 $10
#lw $50 $10 0
#sub $50 $49 $50
#beqz $50 l:2
####move $51 $14
#lw $51 $14 0
#addi $51 $51 8
#lw $51 $51 0
#li $52 0
#sub $52 $51 $52
#bnez $52 l:3
####move $53 $14
#lw $53 $14 0
#addi $53 $53 8
#sw $1 $0 -240
#li $55 12
#addi $56 $0 -244
#sw $55 $56 0
#addi $0 $0 -244
#call #malloc
#subi $0 $0 -244
#lw $1 $0 -240
#addi $57 $0 -236
####move $54 $57
#lw $54 $57 0
#sw $54 $53 0
####move $58 $14
#lw $58 $14 0
#addi $58 $58 8
#lw $58 $58 0
#addi $58 $58 0
####move $59 $10
#lw $59 $10 0
#sw $59 $58 0
####move $60 $14
#lw $60 $14 0
#addi $60 $60 8
#lw $60 $60 0
#addi $60 $60 8
#li $61 0
#sw $61 $60 0
#label l:3
#move $62 $14
####move $63 $14
#lw $63 $14 0
#addi $63 $63 8
#lw $63 $63 0
#sw $63 $62 0
#goto l:1
#label l:2
####move $64 $14
#lw $64 $14 0
#addi $64 $64 4
####move $65 $11
#lw $65 $11 0
#sw $65 $64 0
#return
#----------------------------
#func #get
#addi $66 $0 0
#addi $68 $0 -80
#move $67 $68
#addi $70 $0 -84
#move $69 $70
#li $71 0
#sw $71 $69 0
#move $72 $69
####move $73 $4
#sw $1 $0 -92
####move $76 $66
#addi $77 $0 -96
#lw $76 $66 0
#sw $76 $77 0
#addi $0 $0 -96
#call #getHash
#subi $0 $0 -96
#lw $1 $0 -92
#addi $78 $0 -88
####move $74 $78
#lw $74 $78 0
#muli $75 $74 4
#add $73 $4 $75
#lw $73 $73 0
#sw $73 $72 0
#label l:4
####move $79 $69
#lw $79 $69 0
#addi $79 $79 0
#lw $79 $79 0
####move $80 $66
#lw $80 $66 0
#sub $80 $79 $80
#beqz $80 l:5
#move $81 $69
####move $82 $69
#lw $82 $69 0
#addi $82 $82 8
#lw $82 $82 0
#sw $82 $81 0
#goto l:4
#label l:5
####move $83 $69
#lw $83 $69 0
#addi $83 $83 4
#addi $84 $0 8
#lw $83 $83 0
#sw $83 $84 0
#return
#return
#----------------------------
#func #main
#addi $86 $0 -172
#move $85 $86
#move $87 $86
#li $88 0
#sw $88 $87 0
#label l:6
####move $89 $85
#lw $89 $85 0
####move $90 $2
#lw $90 $2 0
#sub $90 $89 $90
#bgez $90 l:7
####move $91 $4
####move $92 $85
#lw $92 $85 0
#muli $93 $92 4
#add $91 $4 $93
#li $94 0
#sw $94 $91 0
#label l:8
####move $95 $85
#move $96 $85
#lw $95 $85 0
#addi $97 $95 1
#sw $97 $96 0
#goto l:6
#label l:7
#move $98 $85
#li $99 0
#sw $99 $98 0
#label l:9
####move $100 $85
#lw $100 $85 0
#li $101 1000
#sub $101 $100 $101
#bgez $101 l:10
####move $103 $85
#addi $104 $0 -180
#lw $103 $85 0
#sw $103 $104 0
####move $105 $85
#addi $106 $0 -184
#lw $105 $85 0
#sw $105 $106 0
#addi $0 $0 -184
#call #put
#subi $0 $0 -184
#label l:11
####move $107 $85
#move $108 $85
#lw $107 $85 0
#addi $109 $107 1
#sw $109 $108 0
#goto l:9
#label l:10
#move $110 $85
#li $111 0
#sw $111 $110 0
#label l:12
####move $112 $85
#lw $112 $85 0
#li $113 1000
#sub $113 $112 $113
#bgez $113 l:13
####move $116 $85
#addi $117 $0 -192
#lw $116 $85 0
#sw $116 $117 0
#addi $0 $0 -192
#call #get
#subi $0 $0 -192
#addi $118 $0 -184
####move $115 $118
#addi $119 $0 -180
#lw $115 $118 0
#sw $115 $119 0
####move $120 $85
#addi $121 $0 -184
#lw $120 $85 0
#sw $120 $121 0
#move $122 $123
#addi $124 $0 -188
#sw $122 $124 0
#addi $0 $0 -188
#call #printf
#subi $0 $0 -188
#label l:14
####move $125 $85
#move $126 $85
#lw $125 $85 0
#addi $127 $125 1
#sw $127 $126 0
#goto l:12
#label l:13
#return
