.data
temp: .space 344
var0: .asciiz "%.3d : %s"
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

__getline1:
add $8, $29, 0
sw $8, -4($sp)
add $8, $29, -96
sw $8, -12($sp)
lw $9, -12($sp)
move $8, $9
sw $8, -8($sp)
lw $9, -12($sp)
move $8, $9
sw $8, -16($sp)
sw $31, -104($29)
add $29, $29, -104
jal __getchar
sub $29, $29, -104
lw $31, -104($29)
add $8, $29, -100
sw $8, -24($sp)
lw $9, -24($sp)
lw $8, 0($9)
sw $8, -20($sp)
lw $8, -20($sp)
lw $9, -16($sp)
sw $8, 0($9)
label0:
lw $9, -8($sp)
lw $8, 0($9)
sw $8, -28($sp)
li $8, 10
sw $8, -32($sp)
lw $9, -28($sp)
lw $10, -32($sp)
sub $8, $9, $10
sw $8, -32($sp)
lw $8, -32($sp)
beqz $8, label1
lw $9, -4($sp)
lw $8, 0($9)
sw $8, -36($sp)
lw $9, -8($sp)
lb $8, 0($9)
sw $8, -40($sp)
lw $8, -40($sp)
lw $9, -36($sp)
sb $8, 0($9)
lw $9, -4($sp)
move $8, $9
sw $8, -48($sp)
lw $9, -4($sp)
lw $8, 0($9)
sw $8, -44($sp)
lw $9, -44($sp)
add $8, $9, 1
sw $8, -44($sp)
lw $8, -44($sp)
lw $9, -48($sp)
sw $8, 0($9)
lw $9, -8($sp)
move $8, $9
sw $8, -52($sp)
sw $31, -104($29)
add $29, $29, -104
jal __getchar
sub $29, $29, -104
lw $31, -104($29)
add $8, $29, -100
sw $8, -60($sp)
lw $9, -60($sp)
lw $8, 0($9)
sw $8, -56($sp)
lw $8, -56($sp)
lw $9, -52($sp)
sw $8, 0($9)
j label0
label1:
lw $9, -8($sp)
lw $8, 0($9)
sw $8, -64($sp)
li $8, 10
sw $8, -68($sp)
lw $9, -64($sp)
lw $10, -68($sp)
sub $8, $9, $10
sw $8, -68($sp)
lw $8, -68($sp)
bnez $8, label2
lw $9, -4($sp)
lw $8, 0($9)
sw $8, -72($sp)
li $8, 10
sw $8, -76($sp)
lw $8, -76($sp)
lw $9, -72($sp)
sb $8, 0($9)
lw $9, -4($sp)
move $8, $9
sw $8, -84($sp)
lw $9, -4($sp)
lw $8, 0($9)
sw $8, -80($sp)
lw $9, -80($sp)
add $8, $9, 1
sw $8, -80($sp)
lw $8, -80($sp)
lw $9, -84($sp)
sw $8, 0($9)
label2:
lw $9, -4($sp)
lw $8, 0($9)
sw $8, -88($sp)
li $8, 0
sw $8, -92($sp)
lw $8, -92($sp)
lw $9, -88($sp)
sb $8, 0($9)
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
bgez $8, label3
li $8, 0
sw $8, -8($sp)
label3:
lw $8, -8($sp)
beqz $8, label4
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
blez $8, label5
li $8, 0
sw $8, -8($sp)
label5:
label4:
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
label6:
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
beqz $8, label7
j label6
j label6
label7:
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
label8:
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
beqz $8, label9
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
j label8
label9:
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
main:
la $a3, temp
la $t0, var0
sw $t0, 328($a3)
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
add $29, $29, -132
jal __getint
sub $29, $29, -132
add $8, $29, -128
sw $8, -32($sp)
lw $9, -32($sp)
lw $8, 0($9)
sw $8, -28($sp)
lw $8, -28($sp)
lw $9, -24($sp)
sw $8, 0($9)
label10:
lw $9, -12($sp)
lw $8, 0($9)
sw $8, -36($sp)
lw $9, -4($sp)
lw $8, 0($9)
sw $8, -40($sp)
lw $9, -36($sp)
lw $10, -40($sp)
sub $8, $9, $10
sw $8, -40($sp)
lw $8, -40($sp)
bgez $8, label11
add $8, $29, -128
sw $8, -48($sp)
lw $9, -48($sp)
move $8, $9
sw $8, -44($sp)
li $8, 505
sw $8, -56($sp)
add $8, $29, -140
sw $8, -60($sp)
lw $8, -56($sp)
lw $9, -60($sp)
sw $8, 0($9)
add $29, $29, -140
jal __malloc
sub $29, $29, -140
add $8, $29, -132
sw $8, -64($sp)
lw $9, -64($sp)
lw $8, 0($9)
sw $8, -52($sp)
lw $8, -52($sp)
lw $9, -44($sp)
sw $8, 0($9)
add $8, $29, -136
sw $8, -76($sp)
lw $9, -44($sp)
lw $8, 0($9)
sw $8, -72($sp)
lw $8, -72($sp)
lw $9, -76($sp)
sw $8, 0($9)
add $29, $29, -136
jal __getline1
sub $29, $29, -136
add $8, $29, -136
sw $8, -88($sp)
lw $9, -44($sp)
lw $8, 0($9)
sw $8, -84($sp)
lw $8, -84($sp)
lw $9, -88($sp)
sw $8, 0($9)
lw $9, -12($sp)
move $8, $9
sw $8, -96($sp)
lw $9, -12($sp)
lw $8, 0($9)
sw $8, -92($sp)
lw $9, -92($sp)
add $8, $9, 1
sw $8, -92($sp)
lw $8, -92($sp)
lw $9, -96($sp)
sw $8, 0($9)
add $8, $29, -140
sw $8, -100($sp)
lw $8, -92($sp)
lw $9, -100($sp)
sw $8, 0($9)
lw $9, 328($a3)
move $8, $9
sw $8, -104($sp)
add $8, $29, -144
sw $8, -108($sp)
lw $8, -104($sp)
lw $9, -108($sp)
sw $8, 0($9)
add $29, $29, -144
jal __printf
sub $29, $29, -144
j label10
label11:
li $8, 0
sw $8, -112($sp)
add $8, $29, 4
sw $8, -116($sp)
lw $8, -112($sp)
lw $9, -116($sp)
sw $8, 0($9)
j __main_end
j __main_end
__main_end:
li $v0, 10
syscall
#string $82 #%.3d : %s
#----------------------------
#func #getline1
#addi $2 $0 0
#addi $4 $0 -96
#move $3 $4
#move $5 $4
#sw $1 $0 -104
#addi $0 $0 -104
#call #getchar
#subi $0 $0 -104
#lw $1 $0 -104
#addi $7 $0 -100
####move $6 $7
#lw $6 $7 0
#sw $6 $5 0
#label l:0
####move $8 $3
#lw $8 $3 0
#li $9 10
#sub $9 $8 $9
#beqz $9 l:1
####move $10 $2
#lw $10 $2 0
####move $11 $3
#lb $11 $3 0
#sb $11 $10 0
####move $12 $2
#move $13 $2
#lw $12 $2 0
#addi $12 $12 1
#sw $12 $13 0
#move $14 $3
#sw $1 $0 -104
#addi $0 $0 -104
#call #getchar
#subi $0 $0 -104
#lw $1 $0 -104
#addi $16 $0 -100
####move $15 $16
#lw $15 $16 0
#sw $15 $14 0
#goto l:0
#label l:1
####move $17 $3
#lw $17 $3 0
#li $18 10
#sub $18 $17 $18
#bnez $18 l:2
####move $19 $2
#lw $19 $2 0
#li $20 10
#sb $20 $19 0
####move $21 $2
#move $22 $2
#lw $21 $2 0
#addi $21 $21 1
#sw $21 $22 0
#label l:2
####move $23 $2
#lw $23 $2 0
#li $24 0
#sb $24 $23 0
#return
#----------------------------
#func #isdecdigit
#addi $25 $0 0
####move $26 $25
#lb $26 $25 0
#li $27 48
#sub $27 $26 $27
#li $26 1
#bgez $27 l:3
#li $26 0
#label l:3
#beqz $26 l:4
####move $26 $25
#lb $26 $25 0
#li $28 57
#sub $28 $26 $28
#li $26 1
#blez $28 l:5
#li $26 0
#label l:5
#label l:4
#andi $26 $26 1
#addi $29 $0 8
#sw $26 $29 0
#return
#return
#----------------------------
#func #getint
#addi $31 $0 -108
#move $30 $31
#addi $33 $0 -112
#move $32 $33
#label l:6
#sw $1 $0 -120
#move $35 $30
#sw $1 $0 -132
#addi $0 $0 -132
#call #getchar
#subi $0 $0 -132
#lw $1 $0 -132
#addi $37 $0 -128
####move $36 $37
#lw $36 $37 0
#sw $36 $35 0
#addi $38 $0 -124
#lb $35 $35 0
#sb $35 $38 0
#addi $0 $0 -124
#call #isdecdigit
#subi $0 $0 -124
#lw $1 $0 -120
#addi $39 $0 -116
####move $34 $39
#lw $34 $39 0
#lnot $34 $34
#beqz $34 l:7
#goto l:6
#goto l:6
#label l:7
#move $40 $32
####move $41 $30
#lw $41 $30 0
#li $42 48
#sub $41 $41 $42
#sw $41 $40 0
#label l:8
#sw $1 $0 -120
#move $44 $30
#sw $1 $0 -132
#addi $0 $0 -132
#call #getchar
#subi $0 $0 -132
#lw $1 $0 -132
#addi $46 $0 -128
####move $45 $46
#lw $45 $46 0
#sw $45 $44 0
#addi $47 $0 -124
#lb $44 $44 0
#sb $44 $47 0
#addi $0 $0 -124
#call #isdecdigit
#subi $0 $0 -124
#lw $1 $0 -120
#addi $48 $0 -116
####move $43 $48
#lw $43 $48 0
#beqz $43 l:9
#move $49 $32
####move $50 $32
#lw $50 $32 0
#li $51 10
#mul $50 $50 $51
####move $52 $30
#lw $52 $30 0
#add $50 $50 $52
#li $53 48
#sub $50 $50 $53
#sw $50 $49 0
#goto l:8
#label l:9
####move $54 $32
#addi $55 $0 4
#lw $54 $32 0
#sw $54 $55 0
#return
#return
#----------------------------
#func #main
#addi $57 $0 -120
#move $56 $57
#addi $59 $0 -124
#move $58 $59
#li $60 0
#sw $60 $58 0
#move $61 $57
#addi $0 $0 -132
#call #getint
#subi $0 $0 -132
#addi $63 $0 -128
####move $62 $63
#lw $62 $63 0
#sw $62 $61 0
#label l:10
####move $64 $58
#lw $64 $58 0
####move $65 $56
#lw $65 $56 0
#sub $65 $64 $65
#bgez $65 l:11
#addi $67 $0 -128
#move $66 $67
#li $69 505
#addi $70 $0 -140
#sw $69 $70 0
#addi $0 $0 -140
#call #malloc
#subi $0 $0 -140
#addi $71 $0 -132
####move $68 $71
#lw $68 $71 0
#sw $68 $66 0
####move $73 $66
#addi $74 $0 -136
#lw $73 $66 0
#sw $73 $74 0
#addi $0 $0 -136
#call #getline1
#subi $0 $0 -136
####move $76 $66
#addi $77 $0 -136
#lw $76 $66 0
#sw $76 $77 0
####move $78 $58
#move $79 $58
#lw $78 $58 0
#addi $78 $78 1
#sw $78 $79 0
#addi $80 $0 -140
#sw $78 $80 0
#move $81 $82
#addi $83 $0 -144
#sw $81 $83 0
#addi $0 $0 -144
#call #printf
#subi $0 $0 -144
#goto l:10
#label l:11
#li $84 0
#addi $85 $0 4
#sw $84 $85 0
#return
#return
