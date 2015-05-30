.data
temp: .space 336
var0: .space 4
var1: .space 8
var2: .asciiz "%c %d\n"
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

__is_digit:
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
__get_d:
add $8, $29, -116
sw $8, -8($sp)
lw $9, -8($sp)
move $8, $9
sw $8, -4($sp)
sw $31, -124($29)
add $29, $29, -124
jal __getchar
sub $29, $29, -124
lw $31, -124($29)
add $8, $29, -120
sw $8, -16($sp)
lw $9, -16($sp)
lw $8, 0($9)
sw $8, -12($sp)
lw $8, -12($sp)
lw $9, -4($sp)
sw $8, 0($9)
add $8, $29, -120
sw $8, -24($sp)
lw $9, -24($sp)
move $8, $9
sw $8, -20($sp)
li $8, 0
sw $8, -28($sp)
lw $8, -28($sp)
lw $9, -20($sp)
sw $8, 0($9)
label3:
sw $31, -128($29)
add $8, $29, -132
sw $8, -40($sp)
lw $9, -4($sp)
lb $8, 0($9)
sw $8, -36($sp)
lw $8, -36($sp)
lw $9, -40($sp)
sb $8, 0($9)
add $29, $29, -132
jal __is_digit
sub $29, $29, -132
lw $31, -128($29)
add $8, $29, -124
sw $8, -44($sp)
lw $9, -44($sp)
lw $8, 0($9)
sw $8, -32($sp)
lw $9, -32($sp)
li $8, 1
beqz $9, lnot0
li $8, 0
lnot0:
sw $8, -32($sp)
lw $8, -32($sp)
beqz $8, label4
lw $9, -4($sp)
move $8, $9
sw $8, -48($sp)
sw $31, -128($29)
add $29, $29, -128
jal __getchar
sub $29, $29, -128
lw $31, -128($29)
add $8, $29, -124
sw $8, -56($sp)
lw $9, -56($sp)
lw $8, 0($9)
sw $8, -52($sp)
lw $8, -52($sp)
lw $9, -48($sp)
sw $8, 0($9)
j label3
label4:
label5:
sw $31, -128($29)
add $8, $29, -132
sw $8, -68($sp)
lw $9, -4($sp)
lb $8, 0($9)
sw $8, -64($sp)
lw $8, -64($sp)
lw $9, -68($sp)
sb $8, 0($9)
add $29, $29, -132
jal __is_digit
sub $29, $29, -132
lw $31, -128($29)
add $8, $29, -124
sw $8, -72($sp)
lw $9, -72($sp)
lw $8, 0($9)
sw $8, -60($sp)
lw $8, -60($sp)
beqz $8, label6
lw $9, -20($sp)
move $8, $9
sw $8, -76($sp)
lw $9, -20($sp)
lw $8, 0($9)
sw $8, -80($sp)
li $8, 10
sw $8, -84($sp)
lw $9, -80($sp)
lw $10, -84($sp)
mul $8, $9, $10
sw $8, -80($sp)
lw $9, -4($sp)
lw $8, 0($9)
sw $8, -88($sp)
lw $9, -80($sp)
lw $10, -88($sp)
add $8, $9, $10
sw $8, -80($sp)
li $8, 48
sw $8, -92($sp)
lw $9, -80($sp)
lw $10, -92($sp)
sub $8, $9, $10
sw $8, -80($sp)
lw $8, -80($sp)
lw $9, -76($sp)
sw $8, 0($9)
lw $9, -4($sp)
move $8, $9
sw $8, -96($sp)
sw $31, -128($29)
add $29, $29, -128
jal __getchar
sub $29, $29, -128
lw $31, -128($29)
add $8, $29, -124
sw $8, -104($sp)
lw $9, -104($sp)
lw $8, 0($9)
sw $8, -100($sp)
lw $8, -100($sp)
lw $9, -96($sp)
sw $8, 0($9)
j label5
label6:
add $8, $29, 4
sw $8, -112($sp)
lw $9, -20($sp)
lw $8, 0($9)
sw $8, -108($sp)
lw $8, -108($sp)
lw $9, -112($sp)
sw $8, 0($9)
jr $ra
jr $ra
main:
la $a3, temp
la $t0, var0
sw $t0, 8($a3)
la $t0, var1
sw $t0, 12($a3)
la $t0, var2
sw $t0, 212($a3)
add $8, $29, -188
sw $8, -8($sp)
lw $9, -8($sp)
move $8, $9
sw $8, -4($sp)
add $29, $29, -196
jal __getchar
sub $29, $29, -196
add $8, $29, -192
sw $8, -16($sp)
lw $9, -16($sp)
lw $8, 0($9)
sw $8, -12($sp)
lw $8, -12($sp)
lw $9, -4($sp)
sw $8, 0($9)
add $8, $29, -192
sw $8, -24($sp)
lw $9, -24($sp)
move $8, $9
sw $8, -20($sp)
add $29, $29, -200
jal __get_d
sub $29, $29, -200
add $8, $29, -196
sw $8, -32($sp)
lw $9, -32($sp)
lw $8, 0($9)
sw $8, -28($sp)
lw $8, -28($sp)
lw $9, -20($sp)
sw $8, 0($9)
lw $9, 8($a3)
add $8, $9, 0
sw $8, -36($sp)
lw $9, -4($sp)
lb $8, 0($9)
sw $8, -40($sp)
lw $8, -40($sp)
lw $9, -36($sp)
sb $8, 0($9)
lw $9, 8($a3)
add $8, $9, 0
sw $8, -48($sp)
add $8, $29, -200
sw $8, -52($sp)
lw $9, -48($sp)
lw $8, 0($9)
sw $8, -48($sp)
lw $8, -48($sp)
lw $9, -52($sp)
sw $8, 0($9)
lw $9, 8($a3)
add $8, $9, 0
sw $8, -56($sp)
add $8, $29, -204
sw $8, -60($sp)
lw $9, -56($sp)
lb $8, 0($9)
sw $8, -56($sp)
lw $8, -56($sp)
lw $9, -60($sp)
sb $8, 0($9)
lw $9, 212($a3)
move $8, $9
sw $8, -64($sp)
add $8, $29, -208
sw $8, -68($sp)
lw $8, -64($sp)
lw $9, -68($sp)
sw $8, 0($9)
add $29, $29, -208
jal __printf
sub $29, $29, -208
lw $9, 12($a3)
add $8, $9, 0
sw $8, -72($sp)
lw $9, 8($a3)
add $8, $9, 0
sw $8, -76($sp)
lw $9, -76($sp)
lb $8, 0($9)
sw $8, -76($sp)
lw $8, -76($sp)
lw $9, -72($sp)
sb $8, 0($9)
lw $9, 12($a3)
add $8, $9, 4
sw $8, -84($sp)
add $8, $29, -200
sw $8, -88($sp)
lw $9, -84($sp)
lw $8, 0($9)
sw $8, -84($sp)
lw $8, -84($sp)
lw $9, -88($sp)
sw $8, 0($9)
lw $9, 12($a3)
add $8, $9, 0
sw $8, -92($sp)
add $8, $29, -204
sw $8, -96($sp)
lw $9, -92($sp)
lb $8, 0($9)
sw $8, -92($sp)
lw $8, -92($sp)
lw $9, -96($sp)
sb $8, 0($9)
lw $9, 212($a3)
move $8, $9
sw $8, -100($sp)
add $8, $29, -208
sw $8, -104($sp)
lw $8, -100($sp)
lw $9, -104($sp)
sw $8, 0($9)
add $29, $29, -208
jal __printf
sub $29, $29, -208
lw $9, 8($a3)
add $8, $9, 0
sw $8, -108($sp)
lw $9, -20($sp)
lw $8, 0($9)
sw $8, -112($sp)
lw $8, -112($sp)
lw $9, -108($sp)
sw $8, 0($9)
lw $9, 8($a3)
add $8, $9, 0
sw $8, -120($sp)
add $8, $29, -200
sw $8, -124($sp)
lw $9, -120($sp)
lw $8, 0($9)
sw $8, -120($sp)
lw $8, -120($sp)
lw $9, -124($sp)
sw $8, 0($9)
lw $9, 8($a3)
add $8, $9, 0
sw $8, -128($sp)
add $8, $29, -204
sw $8, -132($sp)
lw $9, -128($sp)
lb $8, 0($9)
sw $8, -128($sp)
lw $8, -128($sp)
lw $9, -132($sp)
sb $8, 0($9)
lw $9, 212($a3)
move $8, $9
sw $8, -136($sp)
add $8, $29, -208
sw $8, -140($sp)
lw $8, -136($sp)
lw $9, -140($sp)
sw $8, 0($9)
add $29, $29, -208
jal __printf
sub $29, $29, -208
lw $9, 12($a3)
add $8, $9, 4
sw $8, -144($sp)
lw $9, 8($a3)
add $8, $9, 0
sw $8, -148($sp)
lw $9, -148($sp)
lw $8, 0($9)
sw $8, -148($sp)
lw $8, -148($sp)
lw $9, -144($sp)
sw $8, 0($9)
lw $9, 12($a3)
add $8, $9, 4
sw $8, -156($sp)
add $8, $29, -200
sw $8, -160($sp)
lw $9, -156($sp)
lw $8, 0($9)
sw $8, -156($sp)
lw $8, -156($sp)
lw $9, -160($sp)
sw $8, 0($9)
lw $9, 12($a3)
add $8, $9, 0
sw $8, -164($sp)
add $8, $29, -204
sw $8, -168($sp)
lw $9, -164($sp)
lb $8, 0($9)
sw $8, -164($sp)
lw $8, -164($sp)
lw $9, -168($sp)
sb $8, 0($9)
lw $9, 212($a3)
move $8, $9
sw $8, -172($sp)
add $8, $29, -208
sw $8, -176($sp)
lw $8, -172($sp)
lw $9, -176($sp)
sw $8, 0($9)
add $29, $29, -208
jal __printf
sub $29, $29, -208
li $8, 0
sw $8, -180($sp)
add $8, $29, 4
sw $8, -184($sp)
lw $8, -180($sp)
lw $9, -184($sp)
sw $8, 0($9)
j __main_end
j __main_end
__main_end:
li $v0, 10
syscall
#global $2 4
#global $3 8
#string $53 #%c %d\n
#----------------------------
#func #is_digit
#addi $4 $0 0
####move $5 $4
#lb $5 $4 0
#li $6 48
#sub $6 $5 $6
#li $5 1
#bgez $6 l:0
#li $5 0
#label l:0
#beqz $5 l:1
####move $5 $4
#lb $5 $4 0
#li $7 57
#sub $7 $5 $7
#li $5 1
#blez $7 l:2
#li $5 0
#label l:2
#label l:1
#andi $5 $5 1
#addi $8 $0 8
#sw $5 $8 0
#return
#return
#----------------------------
#func #get_d
#addi $10 $0 -116
#move $9 $10
#sw $1 $0 -124
#addi $0 $0 -124
#call #getchar
#subi $0 $0 -124
#lw $1 $0 -124
#addi $12 $0 -120
####move $11 $12
#lw $11 $12 0
#sw $11 $9 0
#addi $14 $0 -120
#move $13 $14
#li $15 0
#sw $15 $13 0
#label l:3
#sw $1 $0 -128
####move $17 $9
#addi $18 $0 -132
#lb $17 $9 0
#sb $17 $18 0
#addi $0 $0 -132
#call #is_digit
#subi $0 $0 -132
#lw $1 $0 -128
#addi $19 $0 -124
####move $16 $19
#lw $16 $19 0
#lnot $16 $16
#beqz $16 l:4
#move $20 $9
#sw $1 $0 -128
#addi $0 $0 -128
#call #getchar
#subi $0 $0 -128
#lw $1 $0 -128
#addi $22 $0 -124
####move $21 $22
#lw $21 $22 0
#sw $21 $20 0
#goto l:3
#label l:4
#label l:5
#sw $1 $0 -128
####move $24 $9
#addi $25 $0 -132
#lb $24 $9 0
#sb $24 $25 0
#addi $0 $0 -132
#call #is_digit
#subi $0 $0 -132
#lw $1 $0 -128
#addi $26 $0 -124
####move $23 $26
#lw $23 $26 0
#beqz $23 l:6
#move $27 $13
####move $28 $13
#lw $28 $13 0
#li $29 10
#mul $28 $28 $29
####move $30 $9
#lw $30 $9 0
#add $28 $28 $30
#li $31 48
#sub $28 $28 $31
#sw $28 $27 0
#move $32 $9
#sw $1 $0 -128
#addi $0 $0 -128
#call #getchar
#subi $0 $0 -128
#lw $1 $0 -128
#addi $34 $0 -124
####move $33 $34
#lw $33 $34 0
#sw $33 $32 0
#goto l:5
#label l:6
####move $35 $13
#addi $36 $0 4
#lw $35 $13 0
#sw $35 $36 0
#return
#return
#----------------------------
#func #main
#addi $38 $0 -188
#move $37 $38
#addi $0 $0 -196
#call #getchar
#subi $0 $0 -196
#addi $40 $0 -192
####move $39 $40
#lw $39 $40 0
#sw $39 $37 0
#addi $42 $0 -192
#move $41 $42
#addi $0 $0 -200
#call #get_d
#subi $0 $0 -200
#addi $44 $0 -196
####move $43 $44
#lw $43 $44 0
#sw $43 $41 0
####move $45 $2
#addi $45 $2 0
####move $46 $37
#lb $46 $37 0
#sb $46 $45 0
####move $48 $2
#addi $48 $2 0
#addi $49 $0 -200
#lw $48 $48 0
#sw $48 $49 0
####move $50 $2
#addi $50 $2 0
#addi $51 $0 -204
#lb $50 $50 0
#sb $50 $51 0
#move $52 $53
#addi $54 $0 -208
#sw $52 $54 0
#addi $0 $0 -208
#call #printf
#subi $0 $0 -208
####move $55 $3
#addi $55 $3 0
####move $56 $2
#addi $56 $2 0
#lb $56 $56 0
#sb $56 $55 0
####move $58 $3
#addi $58 $3 4
#addi $59 $0 -200
#lw $58 $58 0
#sw $58 $59 0
####move $60 $3
#addi $60 $3 0
#addi $61 $0 -204
#lb $60 $60 0
#sb $60 $61 0
#move $62 $53
#addi $63 $0 -208
#sw $62 $63 0
#addi $0 $0 -208
#call #printf
#subi $0 $0 -208
####move $64 $2
#addi $64 $2 0
####move $65 $41
#lw $65 $41 0
#sw $65 $64 0
####move $67 $2
#addi $67 $2 0
#addi $68 $0 -200
#lw $67 $67 0
#sw $67 $68 0
####move $69 $2
#addi $69 $2 0
#addi $70 $0 -204
#lb $69 $69 0
#sb $69 $70 0
#move $71 $53
#addi $72 $0 -208
#sw $71 $72 0
#addi $0 $0 -208
#call #printf
#subi $0 $0 -208
####move $73 $3
#addi $73 $3 4
####move $74 $2
#addi $74 $2 0
#lw $74 $74 0
#sw $74 $73 0
####move $76 $3
#addi $76 $3 4
#addi $77 $0 -200
#lw $76 $76 0
#sw $76 $77 0
####move $78 $3
#addi $78 $3 0
#addi $79 $0 -204
#lb $78 $78 0
#sb $78 $79 0
#move $80 $53
#addi $81 $0 -208
#sw $80 $81 0
#addi $0 $0 -208
#call #printf
#subi $0 $0 -208
#li $82 0
#addi $83 $0 4
#sw $82 $83 0
#return
#return
