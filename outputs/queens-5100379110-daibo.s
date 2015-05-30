.data
temp: .space 504
var0: .space 4
var1: .space 32
var2: .space 32
var3: .space 120
var4: .asciiz " O"
.align 2
var5: .asciiz " ."
.align 2
var6: .asciiz "\n"
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

__printBoard:
add $8, $29, -140
sw $8, -8($sp)
lw $9, -8($sp)
move $8, $9
sw $8, -4($sp)
add $8, $29, -144
sw $8, -16($sp)
lw $9, -16($sp)
move $8, $9
sw $8, -12($sp)
lw $9, -8($sp)
move $8, $9
sw $8, -20($sp)
li $8, 0
sw $8, -24($sp)
lw $8, -24($sp)
lw $9, -20($sp)
sw $8, 0($9)
label0:
lw $9, -4($sp)
lw $8, 0($9)
sw $8, -28($sp)
lw $9, 8($a3)
lw $8, 0($9)
sw $8, -32($sp)
lw $9, -28($sp)
lw $10, -32($sp)
sub $8, $9, $10
sw $8, -32($sp)
lw $8, -32($sp)
bgez $8, label1
lw $9, -12($sp)
move $8, $9
sw $8, -36($sp)
li $8, 0
sw $8, -40($sp)
lw $8, -40($sp)
lw $9, -36($sp)
sw $8, 0($9)
label3:
lw $9, -12($sp)
lw $8, 0($9)
sw $8, -44($sp)
lw $9, 8($a3)
lw $8, 0($9)
sw $8, -48($sp)
lw $9, -44($sp)
lw $10, -48($sp)
sub $8, $9, $10
sw $8, -48($sp)
lw $8, -48($sp)
bgez $8, label4
lw $9, -4($sp)
lw $8, 0($9)
sw $8, -56($sp)
lw $9, -56($sp)
mul $8, $9, 4
sw $8, -60($sp)
lw $9, 20($a3)
lw $10, -60($sp)
add $8, $9, $10
sw $8, -52($sp)
lw $9, -52($sp)
lw $8, 0($9)
sw $8, -52($sp)
lw $9, -12($sp)
lw $8, 0($9)
sw $8, -64($sp)
lw $9, -52($sp)
lw $10, -64($sp)
sub $8, $9, $10
sw $8, -64($sp)
lw $8, -64($sp)
bnez $8, label6
sw $31, -148($29)
lw $9, 100($a3)
move $8, $9
sw $8, -72($sp)
add $8, $29, -152
sw $8, -76($sp)
lw $8, -72($sp)
lw $9, -76($sp)
sw $8, 0($9)
add $29, $29, -152
jal __printf_single
sub $29, $29, -152
lw $31, -148($29)
j label7
label6:
sw $31, -148($29)
lw $9, 116($a3)
move $8, $9
sw $8, -84($sp)
add $8, $29, -152
sw $8, -88($sp)
lw $8, -84($sp)
lw $9, -88($sp)
sw $8, 0($9)
add $29, $29, -152
jal __printf_single
sub $29, $29, -152
lw $31, -148($29)
label7:
label5:
lw $9, -12($sp)
move $8, $9
sw $8, -96($sp)
lw $9, -12($sp)
lw $8, 0($9)
sw $8, -92($sp)
lw $9, -92($sp)
add $8, $9, 1
sw $8, -100($sp)
lw $8, -100($sp)
lw $9, -96($sp)
sw $8, 0($9)
j label3
label4:
sw $31, -148($29)
lw $9, 144($a3)
move $8, $9
sw $8, -108($sp)
add $8, $29, -152
sw $8, -112($sp)
lw $8, -108($sp)
lw $9, -112($sp)
sw $8, 0($9)
add $29, $29, -152
jal __printf_single
sub $29, $29, -152
lw $31, -148($29)
label2:
lw $9, -4($sp)
move $8, $9
sw $8, -120($sp)
lw $9, -4($sp)
lw $8, 0($9)
sw $8, -116($sp)
lw $9, -116($sp)
add $8, $9, 1
sw $8, -124($sp)
lw $8, -124($sp)
lw $9, -120($sp)
sw $8, 0($9)
j label0
label1:
sw $31, -148($29)
lw $9, 144($a3)
move $8, $9
sw $8, -132($sp)
add $8, $29, -152
sw $8, -136($sp)
lw $8, -132($sp)
lw $9, -136($sp)
sw $8, 0($9)
add $29, $29, -152
jal __printf_single
sub $29, $29, -152
lw $31, -148($29)
jr $ra
__search:
add $8, $29, 0
sw $8, -4($sp)
lw $9, -4($sp)
lw $8, 0($9)
sw $8, -8($sp)
lw $9, 8($a3)
lw $8, 0($9)
sw $8, -12($sp)
lw $9, -8($sp)
lw $10, -12($sp)
sub $8, $9, $10
sw $8, -12($sp)
lw $8, -12($sp)
bnez $8, label8
sw $31, -312($29)
add $29, $29, -312
jal __printBoard
sub $29, $29, -312
lw $31, -312($29)
j label9
label8:
add $8, $29, -312
sw $8, -24($sp)
lw $9, -24($sp)
move $8, $9
sw $8, -20($sp)
lw $9, -24($sp)
move $8, $9
sw $8, -28($sp)
li $8, 0
sw $8, -32($sp)
lw $8, -32($sp)
lw $9, -28($sp)
sw $8, 0($9)
label10:
lw $9, -20($sp)
lw $8, 0($9)
sw $8, -36($sp)
lw $9, 8($a3)
lw $8, 0($9)
sw $8, -40($sp)
lw $9, -36($sp)
lw $10, -40($sp)
sub $8, $9, $10
sw $8, -40($sp)
lw $8, -40($sp)
bgez $8, label11
lw $9, -20($sp)
lw $8, 0($9)
sw $8, -48($sp)
lw $9, -48($sp)
mul $8, $9, 4
sw $8, -52($sp)
lw $9, 16($a3)
lw $10, -52($sp)
add $8, $9, $10
sw $8, -44($sp)
lw $9, -44($sp)
lw $8, 0($9)
sw $8, -44($sp)
li $8, 0
sw $8, -56($sp)
lw $9, -44($sp)
lw $10, -56($sp)
sub $8, $9, $10
sw $8, -56($sp)
lw $8, -56($sp)
bnez $8, label13
li $8, 0
sw $8, -64($sp)
lw $9, -64($sp)
mul $8, $9, 60
sw $8, -68($sp)
lw $9, 24($a3)
lw $10, -68($sp)
add $8, $9, $10
sw $8, -60($sp)
lw $9, -20($sp)
lw $8, 0($9)
sw $8, -72($sp)
lw $9, -4($sp)
lw $8, 0($9)
sw $8, -80($sp)
lw $9, -72($sp)
lw $10, -80($sp)
add $8, $9, $10
sw $8, -72($sp)
lw $9, -72($sp)
mul $8, $9, 4
sw $8, -76($sp)
lw $9, -60($sp)
lw $10, -76($sp)
add $8, $9, $10
sw $8, -60($sp)
lw $9, -60($sp)
lw $8, 0($9)
sw $8, -60($sp)
li $8, 0
sw $8, -84($sp)
lw $9, -60($sp)
lw $10, -84($sp)
sub $8, $9, $10
sw $8, -84($sp)
lw $8, -84($sp)
bnez $8, label13
li $8, 1
sw $8, -92($sp)
lw $9, -92($sp)
mul $8, $9, 60
sw $8, -96($sp)
lw $9, 24($a3)
lw $10, -96($sp)
add $8, $9, $10
sw $8, -88($sp)
lw $9, -20($sp)
lw $8, 0($9)
sw $8, -100($sp)
lw $9, 8($a3)
lw $8, 0($9)
sw $8, -108($sp)
lw $9, -100($sp)
lw $10, -108($sp)
add $8, $9, $10
sw $8, -100($sp)
li $8, 1
sw $8, -112($sp)
lw $9, -100($sp)
lw $10, -112($sp)
sub $8, $9, $10
sw $8, -100($sp)
lw $9, -4($sp)
lw $8, 0($9)
sw $8, -116($sp)
lw $9, -100($sp)
lw $10, -116($sp)
sub $8, $9, $10
sw $8, -100($sp)
lw $9, -100($sp)
mul $8, $9, 4
sw $8, -104($sp)
lw $9, -88($sp)
lw $10, -104($sp)
add $8, $9, $10
sw $8, -88($sp)
lw $9, -88($sp)
lw $8, 0($9)
sw $8, -88($sp)
li $8, 0
sw $8, -120($sp)
lw $9, -88($sp)
lw $10, -120($sp)
sub $8, $9, $10
sw $8, -120($sp)
lw $8, -120($sp)
bnez $8, label13
lw $9, -20($sp)
lw $8, 0($9)
sw $8, -128($sp)
lw $9, -128($sp)
mul $8, $9, 4
sw $8, -132($sp)
lw $9, 16($a3)
lw $10, -132($sp)
add $8, $9, $10
sw $8, -124($sp)
li $8, 0
sw $8, -140($sp)
lw $9, -140($sp)
mul $8, $9, 60
sw $8, -144($sp)
lw $9, 24($a3)
lw $10, -144($sp)
add $8, $9, $10
sw $8, -136($sp)
lw $9, -20($sp)
lw $8, 0($9)
sw $8, -148($sp)
lw $9, -4($sp)
lw $8, 0($9)
sw $8, -156($sp)
lw $9, -148($sp)
lw $10, -156($sp)
add $8, $9, $10
sw $8, -148($sp)
lw $9, -148($sp)
mul $8, $9, 4
sw $8, -152($sp)
lw $9, -136($sp)
lw $10, -152($sp)
add $8, $9, $10
sw $8, -136($sp)
li $8, 1
sw $8, -164($sp)
lw $9, -164($sp)
mul $8, $9, 60
sw $8, -168($sp)
lw $9, 24($a3)
lw $10, -168($sp)
add $8, $9, $10
sw $8, -160($sp)
lw $9, -20($sp)
lw $8, 0($9)
sw $8, -172($sp)
lw $9, 8($a3)
lw $8, 0($9)
sw $8, -180($sp)
lw $9, -172($sp)
lw $10, -180($sp)
add $8, $9, $10
sw $8, -172($sp)
li $8, 1
sw $8, -184($sp)
lw $9, -172($sp)
lw $10, -184($sp)
sub $8, $9, $10
sw $8, -172($sp)
lw $9, -4($sp)
lw $8, 0($9)
sw $8, -188($sp)
lw $9, -172($sp)
lw $10, -188($sp)
sub $8, $9, $10
sw $8, -172($sp)
lw $9, -172($sp)
mul $8, $9, 4
sw $8, -176($sp)
lw $9, -160($sp)
lw $10, -176($sp)
add $8, $9, $10
sw $8, -160($sp)
li $8, 1
sw $8, -192($sp)
lw $8, -192($sp)
lw $9, -160($sp)
sw $8, 0($9)
lw $9, -160($sp)
lw $8, 0($9)
sw $8, -160($sp)
lw $8, -160($sp)
lw $9, -136($sp)
sw $8, 0($9)
lw $9, -136($sp)
lw $8, 0($9)
sw $8, -136($sp)
lw $8, -136($sp)
lw $9, -124($sp)
sw $8, 0($9)
lw $9, -4($sp)
lw $8, 0($9)
sw $8, -200($sp)
lw $9, -200($sp)
mul $8, $9, 4
sw $8, -204($sp)
lw $9, 20($a3)
lw $10, -204($sp)
add $8, $9, $10
sw $8, -196($sp)
lw $9, -20($sp)
lw $8, 0($9)
sw $8, -208($sp)
lw $8, -208($sp)
lw $9, -196($sp)
sw $8, 0($9)
sw $31, -316($29)
lw $9, -4($sp)
lw $8, 0($9)
sw $8, -216($sp)
li $8, 1
sw $8, -220($sp)
lw $9, -216($sp)
lw $10, -220($sp)
add $8, $9, $10
sw $8, -216($sp)
add $8, $29, -320
sw $8, -224($sp)
lw $8, -216($sp)
lw $9, -224($sp)
sw $8, 0($9)
add $29, $29, -320
jal __search
sub $29, $29, -320
lw $31, -316($29)
lw $9, -20($sp)
lw $8, 0($9)
sw $8, -232($sp)
lw $9, -232($sp)
mul $8, $9, 4
sw $8, -236($sp)
lw $9, 16($a3)
lw $10, -236($sp)
add $8, $9, $10
sw $8, -228($sp)
li $8, 0
sw $8, -244($sp)
lw $9, -244($sp)
mul $8, $9, 60
sw $8, -248($sp)
lw $9, 24($a3)
lw $10, -248($sp)
add $8, $9, $10
sw $8, -240($sp)
lw $9, -20($sp)
lw $8, 0($9)
sw $8, -252($sp)
lw $9, -4($sp)
lw $8, 0($9)
sw $8, -260($sp)
lw $9, -252($sp)
lw $10, -260($sp)
add $8, $9, $10
sw $8, -252($sp)
lw $9, -252($sp)
mul $8, $9, 4
sw $8, -256($sp)
lw $9, -240($sp)
lw $10, -256($sp)
add $8, $9, $10
sw $8, -240($sp)
li $8, 1
sw $8, -268($sp)
lw $9, -268($sp)
mul $8, $9, 60
sw $8, -272($sp)
lw $9, 24($a3)
lw $10, -272($sp)
add $8, $9, $10
sw $8, -264($sp)
lw $9, -20($sp)
lw $8, 0($9)
sw $8, -276($sp)
lw $9, 8($a3)
lw $8, 0($9)
sw $8, -284($sp)
lw $9, -276($sp)
lw $10, -284($sp)
add $8, $9, $10
sw $8, -276($sp)
li $8, 1
sw $8, -288($sp)
lw $9, -276($sp)
lw $10, -288($sp)
sub $8, $9, $10
sw $8, -276($sp)
lw $9, -4($sp)
lw $8, 0($9)
sw $8, -292($sp)
lw $9, -276($sp)
lw $10, -292($sp)
sub $8, $9, $10
sw $8, -276($sp)
lw $9, -276($sp)
mul $8, $9, 4
sw $8, -280($sp)
lw $9, -264($sp)
lw $10, -280($sp)
add $8, $9, $10
sw $8, -264($sp)
li $8, 0
sw $8, -296($sp)
lw $8, -296($sp)
lw $9, -264($sp)
sw $8, 0($9)
lw $9, -264($sp)
lw $8, 0($9)
sw $8, -264($sp)
lw $8, -264($sp)
lw $9, -240($sp)
sw $8, 0($9)
lw $9, -240($sp)
lw $8, 0($9)
sw $8, -240($sp)
lw $8, -240($sp)
lw $9, -228($sp)
sw $8, 0($9)
label13:
label12:
lw $9, -20($sp)
move $8, $9
sw $8, -304($sp)
lw $9, -20($sp)
lw $8, 0($9)
sw $8, -300($sp)
lw $9, -300($sp)
add $8, $9, 1
sw $8, -308($sp)
lw $8, -308($sp)
lw $9, -304($sp)
sw $8, 0($9)
j label10
label11:
label9:
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
sw $t0, 100($a3)
la $t0, var5
sw $t0, 116($a3)
la $t0, var6
sw $t0, 144($a3)
li $8, 8
sw $8, 12($a3)
lw $8, 12($a3)
lw $9, 8($a3)
sw $8, 0($9)
li $8, 0
sw $8, -8($sp)
add $8, $29, -28
sw $8, -12($sp)
lw $8, -8($sp)
lw $9, -12($sp)
sw $8, 0($9)
add $29, $29, -28
jal __search
sub $29, $29, -28
li $8, 0
sw $8, -16($sp)
add $8, $29, 4
sw $8, -20($sp)
lw $8, -16($sp)
lw $9, -20($sp)
sw $8, 0($9)
j __main_end
j __main_end
__main_end:
li $v0, 10
syscall
#global $2 4
#global $4 32
#global $5 32
#global $6 120
#string $25 # O
#string $29 # .
#string $36 #\n
#li $3 8
#sw $3 $2 0
#----------------------------
#func #printBoard
#addi $8 $0 -140
#move $7 $8
#addi $10 $0 -144
#move $9 $10
#move $11 $8
#li $12 0
#sw $12 $11 0
#label l:0
####move $13 $7
#lw $13 $7 0
####move $14 $2
#lw $14 $2 0
#sub $14 $13 $14
#bgez $14 l:1
#move $15 $9
#li $16 0
#sw $16 $15 0
#label l:3
####move $17 $9
#lw $17 $9 0
####move $18 $2
#lw $18 $2 0
#sub $18 $17 $18
#bgez $18 l:4
####move $19 $5
####move $20 $7
#lw $20 $7 0
#muli $21 $20 4
#add $19 $5 $21
#lw $19 $19 0
####move $22 $9
#lw $22 $9 0
#sub $22 $19 $22
#bnez $22 l:6
#sw $1 $0 -148
#move $24 $25
#addi $26 $0 -152
#sw $24 $26 0
#addi $0 $0 -152
#call #printf_single
#subi $0 $0 -152
#lw $1 $0 -148
#goto l:7
#label l:6
#sw $1 $0 -148
#move $28 $29
#addi $30 $0 -152
#sw $28 $30 0
#addi $0 $0 -152
#call #printf_single
#subi $0 $0 -152
#lw $1 $0 -148
#label l:7
#label l:5
####move $31 $9
#move $32 $9
#lw $31 $9 0
#addi $33 $31 1
#sw $33 $32 0
#goto l:3
#label l:4
#sw $1 $0 -148
#move $35 $36
#addi $37 $0 -152
#sw $35 $37 0
#addi $0 $0 -152
#call #printf_single
#subi $0 $0 -152
#lw $1 $0 -148
#label l:2
####move $38 $7
#move $39 $7
#lw $38 $7 0
#addi $40 $38 1
#sw $40 $39 0
#goto l:0
#label l:1
#sw $1 $0 -148
#move $42 $36
#addi $43 $0 -152
#sw $42 $43 0
#addi $0 $0 -152
#call #printf_single
#subi $0 $0 -152
#lw $1 $0 -148
#return
#----------------------------
#func #search
#addi $44 $0 0
####move $45 $44
#lw $45 $44 0
####move $46 $2
#lw $46 $2 0
#sub $46 $45 $46
#bnez $46 l:8
#sw $1 $0 -312
#addi $0 $0 -312
#call #printBoard
#subi $0 $0 -312
#lw $1 $0 -312
#goto l:9
#label l:8
#addi $49 $0 -312
#move $48 $49
#move $50 $49
#li $51 0
#sw $51 $50 0
#label l:10
####move $52 $48
#lw $52 $48 0
####move $53 $2
#lw $53 $2 0
#sub $53 $52 $53
#bgez $53 l:11
####move $54 $4
####move $55 $48
#lw $55 $48 0
#muli $56 $55 4
#add $54 $4 $56
#lw $54 $54 0
#li $57 0
#sub $57 $54 $57
#bnez $57 l:13
####move $58 $6
#li $59 0
#muli $60 $59 60
#add $58 $6 $60
####move $61 $48
#lw $61 $48 0
####move $63 $44
#lw $63 $44 0
#add $61 $61 $63
#muli $62 $61 4
#add $58 $58 $62
#lw $58 $58 0
#li $64 0
#sub $64 $58 $64
#bnez $64 l:13
####move $65 $6
#li $66 1
#muli $67 $66 60
#add $65 $6 $67
####move $68 $48
#lw $68 $48 0
####move $70 $2
#lw $70 $2 0
#add $68 $68 $70
#li $71 1
#sub $68 $68 $71
####move $72 $44
#lw $72 $44 0
#sub $68 $68 $72
#muli $69 $68 4
#add $65 $65 $69
#lw $65 $65 0
#li $73 0
#sub $73 $65 $73
#bnez $73 l:13
####move $74 $4
####move $75 $48
#lw $75 $48 0
#muli $76 $75 4
#add $74 $4 $76
####move $77 $6
#li $78 0
#muli $79 $78 60
#add $77 $6 $79
####move $80 $48
#lw $80 $48 0
####move $82 $44
#lw $82 $44 0
#add $80 $80 $82
#muli $81 $80 4
#add $77 $77 $81
####move $83 $6
#li $84 1
#muli $85 $84 60
#add $83 $6 $85
####move $86 $48
#lw $86 $48 0
####move $88 $2
#lw $88 $2 0
#add $86 $86 $88
#li $89 1
#sub $86 $86 $89
####move $90 $44
#lw $90 $44 0
#sub $86 $86 $90
#muli $87 $86 4
#add $83 $83 $87
#li $91 1
#sw $91 $83 0
#lw $83 $83 0
#sw $83 $77 0
#lw $77 $77 0
#sw $77 $74 0
####move $92 $5
####move $93 $44
#lw $93 $44 0
#muli $94 $93 4
#add $92 $5 $94
####move $95 $48
#lw $95 $48 0
#sw $95 $92 0
#sw $1 $0 -316
####move $97 $44
#lw $97 $44 0
#li $98 1
#add $97 $97 $98
#addi $99 $0 -320
#sw $97 $99 0
#addi $0 $0 -320
#call #search
#subi $0 $0 -320
#lw $1 $0 -316
####move $100 $4
####move $101 $48
#lw $101 $48 0
#muli $102 $101 4
#add $100 $4 $102
####move $103 $6
#li $104 0
#muli $105 $104 60
#add $103 $6 $105
####move $106 $48
#lw $106 $48 0
####move $108 $44
#lw $108 $44 0
#add $106 $106 $108
#muli $107 $106 4
#add $103 $103 $107
####move $109 $6
#li $110 1
#muli $111 $110 60
#add $109 $6 $111
####move $112 $48
#lw $112 $48 0
####move $114 $2
#lw $114 $2 0
#add $112 $112 $114
#li $115 1
#sub $112 $112 $115
####move $116 $44
#lw $116 $44 0
#sub $112 $112 $116
#muli $113 $112 4
#add $109 $109 $113
#li $117 0
#sw $117 $109 0
#lw $109 $109 0
#sw $109 $103 0
#lw $103 $103 0
#sw $103 $100 0
#label l:13
#label l:12
####move $118 $48
#move $119 $48
#lw $118 $48 0
#addi $120 $118 1
#sw $120 $119 0
#goto l:10
#label l:11
#label l:9
#return
#----------------------------
#func #main
#li $122 0
#addi $123 $0 -28
#sw $122 $123 0
#addi $0 $0 -28
#call #search
#subi $0 $0 -28
#li $124 0
#addi $125 $0 4
#sw $124 $125 0
#return
#return
