.data
temp: .space 416
var0: .space 4020
var1: .asciiz "%d "
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

__read:
add $8, $29, -120
sw $8, -8($sp)
lw $9, -8($sp)
move $8, $9
sw $8, -4($sp)
sw $31, -128($29)
add $29, $29, -128
jal __getchar
sub $29, $29, -128
lw $31, -128($29)
add $8, $29, -124
sw $8, -16($sp)
lw $9, -16($sp)
lw $8, 0($9)
sw $8, -12($sp)
lw $8, -12($sp)
lw $9, -4($sp)
sw $8, 0($9)
add $8, $29, -124
sw $8, -24($sp)
lw $9, -24($sp)
move $8, $9
sw $8, -20($sp)
label0:
lw $9, -4($sp)
lw $8, 0($9)
sw $8, -28($sp)
li $8, 48
sw $8, -32($sp)
lw $9, -28($sp)
lw $10, -32($sp)
sub $8, $9, $10
sw $8, -32($sp)
lw $8, -32($sp)
bltz $8, label2
lw $9, -4($sp)
lw $8, 0($9)
sw $8, -36($sp)
li $8, 57
sw $8, -40($sp)
lw $9, -36($sp)
lw $10, -40($sp)
sub $8, $9, $10
sw $8, -40($sp)
lw $8, -40($sp)
blez $8, label1
label2:
lw $9, -4($sp)
move $8, $9
sw $8, -44($sp)
sw $31, -132($29)
add $29, $29, -132
jal __getchar
sub $29, $29, -132
lw $31, -132($29)
add $8, $29, -128
sw $8, -52($sp)
lw $9, -52($sp)
lw $8, 0($9)
sw $8, -48($sp)
lw $8, -48($sp)
lw $9, -44($sp)
sw $8, 0($9)
j label0
label1:
lw $9, -20($sp)
move $8, $9
sw $8, -56($sp)
li $8, 0
sw $8, -60($sp)
lw $8, -60($sp)
lw $9, -56($sp)
sw $8, 0($9)
label3:
li $8, 48
sw $8, -64($sp)
lw $9, -4($sp)
lw $8, 0($9)
sw $8, -68($sp)
lw $9, -64($sp)
lw $10, -68($sp)
sub $8, $9, $10
sw $8, -68($sp)
lw $8, -68($sp)
bgtz $8, label4
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
bgtz $8, label4
lw $9, -20($sp)
move $8, $9
sw $8, -80($sp)
li $8, 10
sw $8, -84($sp)
lw $9, -20($sp)
lw $8, 0($9)
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
label5:
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
j label3
label4:
add $8, $29, 4
sw $8, -116($sp)
lw $9, -20($sp)
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
sw $t0, 356($a3)
la $t0, var2
sw $t0, 400($a3)
add $8, $29, -284
sw $8, -8($sp)
lw $9, -8($sp)
move $8, $9
sw $8, -4($sp)
add $8, $29, -288
sw $8, -16($sp)
lw $9, -16($sp)
move $8, $9
sw $8, -12($sp)
add $8, $29, -292
sw $8, -24($sp)
lw $9, -24($sp)
move $8, $9
sw $8, -20($sp)
add $8, $29, -296
sw $8, -32($sp)
lw $9, -32($sp)
move $8, $9
sw $8, -28($sp)
lw $9, -8($sp)
move $8, $9
sw $8, -36($sp)
add $29, $29, -304
jal __read
sub $29, $29, -304
add $8, $29, -300
sw $8, -44($sp)
lw $9, -44($sp)
lw $8, 0($9)
sw $8, -40($sp)
lw $8, -40($sp)
lw $9, -36($sp)
sw $8, 0($9)
lw $9, -16($sp)
move $8, $9
sw $8, -48($sp)
add $29, $29, -304
jal __read
sub $29, $29, -304
add $8, $29, -300
sw $8, -56($sp)
lw $9, -56($sp)
lw $8, 0($9)
sw $8, -52($sp)
lw $8, -52($sp)
lw $9, -48($sp)
sw $8, 0($9)
lw $9, -32($sp)
move $8, $9
sw $8, -60($sp)
li $8, 0
sw $8, -64($sp)
lw $8, -64($sp)
lw $9, -60($sp)
sw $8, 0($9)
label6:
lw $9, -28($sp)
lw $8, 0($9)
sw $8, -68($sp)
lw $9, -4($sp)
lw $8, 0($9)
sw $8, -72($sp)
lw $9, -68($sp)
lw $10, -72($sp)
sub $8, $9, $10
sw $8, -72($sp)
lw $8, -72($sp)
bgez $8, label7
lw $9, -28($sp)
lw $8, 0($9)
sw $8, -80($sp)
lw $9, -80($sp)
mul $8, $9, 4
sw $8, -84($sp)
lw $9, 8($a3)
lw $10, -84($sp)
add $8, $9, $10
sw $8, -76($sp)
lw $9, -28($sp)
lw $8, 0($9)
sw $8, -88($sp)
li $8, 1
sw $8, -92($sp)
lw $9, -88($sp)
lw $10, -92($sp)
add $8, $9, $10
sw $8, -88($sp)
lw $8, -88($sp)
lw $9, -76($sp)
sw $8, 0($9)
label8:
lw $9, -28($sp)
move $8, $9
sw $8, -100($sp)
lw $9, -28($sp)
lw $8, 0($9)
sw $8, -96($sp)
lw $9, -96($sp)
add $8, $9, 1
sw $8, -104($sp)
lw $8, -104($sp)
lw $9, -100($sp)
sw $8, 0($9)
j label6
label7:
lw $9, -28($sp)
move $8, $9
sw $8, -108($sp)
li $8, -1
sw $8, -112($sp)
lw $8, -112($sp)
lw $9, -108($sp)
sw $8, 0($9)
lw $9, -20($sp)
move $8, $9
sw $8, -116($sp)
lw $9, -4($sp)
lw $8, 0($9)
sw $8, -120($sp)
lw $8, -120($sp)
lw $9, -116($sp)
sw $8, 0($9)
label9:
lw $9, -20($sp)
lw $8, 0($9)
sw $8, -124($sp)
li $8, 0
sw $8, -128($sp)
lw $9, -124($sp)
lw $10, -128($sp)
sub $8, $9, $10
sw $8, -128($sp)
lw $8, -128($sp)
blez $8, label10
add $8, $29, -300
sw $8, -136($sp)
lw $9, -136($sp)
move $8, $9
sw $8, -132($sp)
li $8, 0
sw $8, -140($sp)
lw $8, -140($sp)
lw $9, -132($sp)
sw $8, 0($9)
label11:
lw $9, -132($sp)
lw $8, 0($9)
sw $8, -144($sp)
lw $9, -12($sp)
lw $8, 0($9)
sw $8, -148($sp)
lw $9, -144($sp)
lw $10, -148($sp)
sub $8, $9, $10
sw $8, -148($sp)
lw $8, -148($sp)
bgez $8, label12
lw $9, -28($sp)
move $8, $9
sw $8, -156($sp)
lw $9, -28($sp)
lw $8, 0($9)
sw $8, -152($sp)
lw $9, -152($sp)
add $8, $9, 1
sw $8, -160($sp)
lw $8, -160($sp)
lw $9, -156($sp)
sw $8, 0($9)
lw $9, -28($sp)
lw $8, 0($9)
sw $8, -164($sp)
lw $9, -4($sp)
lw $8, 0($9)
sw $8, -168($sp)
lw $9, -164($sp)
lw $10, -168($sp)
sub $8, $9, $10
sw $8, -168($sp)
lw $8, -168($sp)
bnez $8, label13
lw $9, -28($sp)
move $8, $9
sw $8, -172($sp)
li $8, 0
sw $8, -176($sp)
lw $8, -176($sp)
lw $9, -172($sp)
sw $8, 0($9)
label13:
lw $9, -28($sp)
lw $8, 0($9)
sw $8, -184($sp)
lw $9, -184($sp)
mul $8, $9, 4
sw $8, -188($sp)
lw $9, 8($a3)
lw $10, -188($sp)
add $8, $9, $10
sw $8, -180($sp)
lw $9, -180($sp)
lw $8, 0($9)
sw $8, -180($sp)
li $8, 0
sw $8, -192($sp)
lw $9, -180($sp)
lw $10, -192($sp)
sub $8, $9, $10
sw $8, -192($sp)
lw $8, -192($sp)
blez $8, label14
lw $9, -132($sp)
move $8, $9
sw $8, -200($sp)
lw $9, -132($sp)
lw $8, 0($9)
sw $8, -196($sp)
lw $9, -196($sp)
add $8, $9, 1
sw $8, -204($sp)
lw $8, -204($sp)
lw $9, -200($sp)
sw $8, 0($9)
label14:
j label11
label12:
lw $9, -28($sp)
lw $8, 0($9)
sw $8, -216($sp)
lw $9, -216($sp)
mul $8, $9, 4
sw $8, -220($sp)
lw $9, 8($a3)
lw $10, -220($sp)
add $8, $9, $10
sw $8, -212($sp)
add $8, $29, -308
sw $8, -224($sp)
lw $9, -212($sp)
lw $8, 0($9)
sw $8, -212($sp)
lw $8, -212($sp)
lw $9, -224($sp)
sw $8, 0($9)
lw $9, 356($a3)
move $8, $9
sw $8, -228($sp)
add $8, $29, -312
sw $8, -232($sp)
lw $8, -228($sp)
lw $9, -232($sp)
sw $8, 0($9)
add $29, $29, -312
jal __printf
sub $29, $29, -312
lw $9, -28($sp)
lw $8, 0($9)
sw $8, -240($sp)
lw $9, -240($sp)
mul $8, $9, 4
sw $8, -244($sp)
lw $9, 8($a3)
lw $10, -244($sp)
add $8, $9, $10
sw $8, -236($sp)
li $8, -1
sw $8, -248($sp)
lw $8, -248($sp)
lw $9, -236($sp)
sw $8, 0($9)
lw $9, -20($sp)
move $8, $9
sw $8, -256($sp)
lw $9, -20($sp)
lw $8, 0($9)
sw $8, -252($sp)
lw $9, -252($sp)
sub $8, $9, 1
sw $8, -260($sp)
lw $8, -260($sp)
lw $9, -256($sp)
sw $8, 0($9)
j label9
label10:
lw $9, 400($a3)
move $8, $9
sw $8, -268($sp)
add $8, $29, -304
sw $8, -272($sp)
lw $8, -268($sp)
lw $9, -272($sp)
sw $8, 0($9)
add $29, $29, -304
jal __printf_single
sub $29, $29, -304
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
#global $2 4020
#string $89 #%d 
#string $100 #\n
#----------------------------
#func #read
#addi $4 $0 -120
#move $3 $4
#sw $1 $0 -128
#addi $0 $0 -128
#call #getchar
#subi $0 $0 -128
#lw $1 $0 -128
#addi $6 $0 -124
####move $5 $6
#lw $5 $6 0
#sw $5 $3 0
#addi $8 $0 -124
#move $7 $8
#label l:0
####move $9 $3
#lw $9 $3 0
#li $10 48
#sub $10 $9 $10
#bltz $10 l:2
####move $11 $3
#lw $11 $3 0
#li $12 57
#sub $12 $11 $12
#blez $12 l:1
#label l:2
#move $13 $3
#sw $1 $0 -132
#addi $0 $0 -132
#call #getchar
#subi $0 $0 -132
#lw $1 $0 -132
#addi $15 $0 -128
####move $14 $15
#lw $14 $15 0
#sw $14 $13 0
#goto l:0
#label l:1
#move $16 $7
#li $17 0
#sw $17 $16 0
#label l:3
#li $18 48
####move $19 $3
#lw $19 $3 0
#sub $19 $18 $19
#bgtz $19 l:4
####move $20 $3
#lw $20 $3 0
#li $21 57
#sub $21 $20 $21
#bgtz $21 l:4
#move $22 $7
#li $23 10
####move $24 $7
#lw $24 $7 0
#mul $23 $23 $24
####move $25 $3
#lw $25 $3 0
#add $23 $23 $25
#li $26 48
#sub $23 $23 $26
#sw $23 $22 0
#label l:5
#move $27 $3
#sw $1 $0 -132
#addi $0 $0 -132
#call #getchar
#subi $0 $0 -132
#lw $1 $0 -132
#addi $29 $0 -128
####move $28 $29
#lw $28 $29 0
#sw $28 $27 0
#goto l:3
#label l:4
####move $30 $7
#addi $31 $0 4
#lw $30 $7 0
#sw $30 $31 0
#return
#return
#----------------------------
#func #main
#addi $33 $0 -284
#move $32 $33
#addi $35 $0 -288
#move $34 $35
#addi $37 $0 -292
#move $36 $37
#addi $39 $0 -296
#move $38 $39
#move $40 $33
#addi $0 $0 -304
#call #read
#subi $0 $0 -304
#addi $42 $0 -300
####move $41 $42
#lw $41 $42 0
#sw $41 $40 0
#move $43 $35
#addi $0 $0 -304
#call #read
#subi $0 $0 -304
#addi $45 $0 -300
####move $44 $45
#lw $44 $45 0
#sw $44 $43 0
#move $46 $39
#li $47 0
#sw $47 $46 0
#label l:6
####move $48 $38
#lw $48 $38 0
####move $49 $32
#lw $49 $32 0
#sub $49 $48 $49
#bgez $49 l:7
####move $50 $2
####move $51 $38
#lw $51 $38 0
#muli $52 $51 4
#add $50 $2 $52
####move $53 $38
#lw $53 $38 0
#li $54 1
#add $53 $53 $54
#sw $53 $50 0
#label l:8
####move $55 $38
#move $56 $38
#lw $55 $38 0
#addi $57 $55 1
#sw $57 $56 0
#goto l:6
#label l:7
#move $58 $38
#li $59 -1
#sw $59 $58 0
#move $60 $36
####move $61 $32
#lw $61 $32 0
#sw $61 $60 0
#label l:9
####move $62 $36
#lw $62 $36 0
#li $63 0
#sub $63 $62 $63
#blez $63 l:10
#addi $65 $0 -300
#move $64 $65
#li $66 0
#sw $66 $64 0
#label l:11
####move $67 $64
#lw $67 $64 0
####move $68 $34
#lw $68 $34 0
#sub $68 $67 $68
#bgez $68 l:12
####move $69 $38
#move $70 $38
#lw $69 $38 0
#addi $71 $69 1
#sw $71 $70 0
####move $72 $38
#lw $72 $38 0
####move $73 $32
#lw $73 $32 0
#sub $73 $72 $73
#bnez $73 l:13
#move $74 $38
#li $75 0
#sw $75 $74 0
#label l:13
####move $76 $2
####move $77 $38
#lw $77 $38 0
#muli $78 $77 4
#add $76 $2 $78
#lw $76 $76 0
#li $79 0
#sub $79 $76 $79
#blez $79 l:14
####move $80 $64
#move $81 $64
#lw $80 $64 0
#addi $82 $80 1
#sw $82 $81 0
#label l:14
#goto l:11
#label l:12
####move $84 $2
####move $85 $38
#lw $85 $38 0
#muli $86 $85 4
#add $84 $2 $86
#addi $87 $0 -308
#lw $84 $84 0
#sw $84 $87 0
#move $88 $89
#addi $90 $0 -312
#sw $88 $90 0
#addi $0 $0 -312
#call #printf
#subi $0 $0 -312
####move $91 $2
####move $92 $38
#lw $92 $38 0
#muli $93 $92 4
#add $91 $2 $93
#li $94 -1
#sw $94 $91 0
####move $95 $36
#move $96 $36
#lw $95 $36 0
#subi $97 $95 1
#sw $97 $96 0
#goto l:9
#label l:10
#move $99 $100
#addi $101 $0 -304
#sw $99 $101 0
#addi $0 $0 -304
#call #printf_single
#subi $0 $0 -304
#li $102 0
#addi $103 $0 4
#sw $102 $103 0
#return
#return
