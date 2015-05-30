.data
temp: .space 400
var0: .asciiz "move %c --> %c\n"
.align 2
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

__cd:
add $8, $29, 0
sw $8, -4($sp)
add $8, $29, 4
sw $8, -8($sp)
add $8, $29, 8
sw $8, -12($sp)
add $8, $29, 12
sw $8, -16($sp)
add $8, $29, 16
sw $8, -20($sp)
lw $9, -4($sp)
lw $8, 0($9)
sw $8, -24($sp)
li $8, 1
sw $8, -28($sp)
lw $9, -24($sp)
lw $10, -28($sp)
sub $8, $9, $10
sw $8, -28($sp)
lw $8, -28($sp)
bnez $8, label0
sw $31, -232($29)
add $8, $29, -236
sw $8, -40($sp)
lw $9, -16($sp)
lb $8, 0($9)
sw $8, -36($sp)
lw $8, -36($sp)
lw $9, -40($sp)
sb $8, 0($9)
add $8, $29, -240
sw $8, -48($sp)
lw $9, -8($sp)
lb $8, 0($9)
sw $8, -44($sp)
lw $8, -44($sp)
lw $9, -48($sp)
sb $8, 0($9)
lw $9, 60($a3)
move $8, $9
sw $8, -52($sp)
add $8, $29, -244
sw $8, -56($sp)
lw $8, -52($sp)
lw $9, -56($sp)
sw $8, 0($9)
add $29, $29, -244
jal __printf
sub $29, $29, -244
lw $31, -232($29)
lw $9, -20($sp)
move $8, $9
sw $8, -64($sp)
lw $9, -20($sp)
lw $8, 0($9)
sw $8, -60($sp)
lw $9, -60($sp)
add $8, $9, 1
sw $8, -68($sp)
lw $8, -68($sp)
lw $9, -64($sp)
sw $8, 0($9)
j label1
label0:
lw $9, -20($sp)
move $8, $9
sw $8, -72($sp)
sw $31, -236($29)
add $8, $29, -240
sw $8, -84($sp)
lw $9, -20($sp)
lw $8, 0($9)
sw $8, -80($sp)
lw $8, -80($sp)
lw $9, -84($sp)
sw $8, 0($9)
add $8, $29, -244
sw $8, -92($sp)
lw $9, -12($sp)
lb $8, 0($9)
sw $8, -88($sp)
lw $8, -88($sp)
lw $9, -92($sp)
sb $8, 0($9)
add $8, $29, -248
sw $8, -100($sp)
lw $9, -16($sp)
lb $8, 0($9)
sw $8, -96($sp)
lw $8, -96($sp)
lw $9, -100($sp)
sb $8, 0($9)
add $8, $29, -252
sw $8, -108($sp)
lw $9, -8($sp)
lb $8, 0($9)
sw $8, -104($sp)
lw $8, -104($sp)
lw $9, -108($sp)
sb $8, 0($9)
lw $9, -4($sp)
lw $8, 0($9)
sw $8, -112($sp)
li $8, 1
sw $8, -116($sp)
lw $9, -112($sp)
lw $10, -116($sp)
sub $8, $9, $10
sw $8, -112($sp)
add $8, $29, -256
sw $8, -120($sp)
lw $8, -112($sp)
lw $9, -120($sp)
sw $8, 0($9)
add $29, $29, -256
jal __cd
sub $29, $29, -256
lw $31, -236($29)
add $8, $29, -232
sw $8, -124($sp)
lw $9, -124($sp)
lw $8, 0($9)
sw $8, -76($sp)
lw $8, -76($sp)
lw $9, -72($sp)
sw $8, 0($9)
sw $31, -232($29)
add $8, $29, -236
sw $8, -136($sp)
lw $9, -16($sp)
lb $8, 0($9)
sw $8, -132($sp)
lw $8, -132($sp)
lw $9, -136($sp)
sb $8, 0($9)
add $8, $29, -240
sw $8, -144($sp)
lw $9, -8($sp)
lb $8, 0($9)
sw $8, -140($sp)
lw $8, -140($sp)
lw $9, -144($sp)
sb $8, 0($9)
lw $9, 60($a3)
move $8, $9
sw $8, -148($sp)
add $8, $29, -244
sw $8, -152($sp)
lw $8, -148($sp)
lw $9, -152($sp)
sw $8, 0($9)
add $29, $29, -244
jal __printf
sub $29, $29, -244
lw $31, -232($29)
lw $9, -20($sp)
move $8, $9
sw $8, -156($sp)
sw $31, -236($29)
add $8, $29, -240
sw $8, -168($sp)
lw $9, -20($sp)
lw $8, 0($9)
sw $8, -164($sp)
lw $8, -164($sp)
lw $9, -168($sp)
sw $8, 0($9)
add $8, $29, -244
sw $8, -176($sp)
lw $9, -16($sp)
lb $8, 0($9)
sw $8, -172($sp)
lw $8, -172($sp)
lw $9, -176($sp)
sb $8, 0($9)
add $8, $29, -248
sw $8, -184($sp)
lw $9, -8($sp)
lb $8, 0($9)
sw $8, -180($sp)
lw $8, -180($sp)
lw $9, -184($sp)
sb $8, 0($9)
add $8, $29, -252
sw $8, -192($sp)
lw $9, -12($sp)
lb $8, 0($9)
sw $8, -188($sp)
lw $8, -188($sp)
lw $9, -192($sp)
sb $8, 0($9)
lw $9, -4($sp)
lw $8, 0($9)
sw $8, -196($sp)
li $8, 1
sw $8, -200($sp)
lw $9, -196($sp)
lw $10, -200($sp)
sub $8, $9, $10
sw $8, -196($sp)
add $8, $29, -256
sw $8, -204($sp)
lw $8, -196($sp)
lw $9, -204($sp)
sw $8, 0($9)
add $29, $29, -256
jal __cd
sub $29, $29, -256
lw $31, -236($29)
add $8, $29, -232
sw $8, -208($sp)
lw $9, -208($sp)
lw $8, 0($9)
sw $8, -160($sp)
lw $8, -160($sp)
lw $9, -156($sp)
sw $8, 0($9)
lw $9, -20($sp)
move $8, $9
sw $8, -216($sp)
lw $9, -20($sp)
lw $8, 0($9)
sw $8, -212($sp)
lw $9, -212($sp)
add $8, $9, 1
sw $8, -220($sp)
lw $8, -220($sp)
lw $9, -216($sp)
sw $8, 0($9)
label1:
add $8, $29, 24
sw $8, -228($sp)
lw $9, -20($sp)
lw $8, 0($9)
sw $8, -224($sp)
lw $8, -224($sp)
lw $9, -228($sp)
sw $8, 0($9)
jr $ra
jr $ra
main:
la $a3, temp
la $t0, var0
sw $t0, 60($a3)
la $t0, var1
sw $t0, 384($a3)
add $8, $29, -160
sw $8, -8($sp)
lw $9, -8($sp)
move $8, $9
sw $8, -4($sp)
li $8, 65
sw $8, -12($sp)
lw $8, -12($sp)
lw $9, -4($sp)
sw $8, 0($9)
add $8, $29, -164
sw $8, -20($sp)
lw $9, -20($sp)
move $8, $9
sw $8, -16($sp)
li $8, 66
sw $8, -24($sp)
lw $8, -24($sp)
lw $9, -16($sp)
sw $8, 0($9)
add $8, $29, -168
sw $8, -32($sp)
lw $9, -32($sp)
move $8, $9
sw $8, -28($sp)
li $8, 67
sw $8, -36($sp)
lw $8, -36($sp)
lw $9, -28($sp)
sw $8, 0($9)
add $8, $29, -172
sw $8, -44($sp)
lw $9, -44($sp)
move $8, $9
sw $8, -40($sp)
li $8, 10
sw $8, -48($sp)
add $29, $29, -180
jal __getchar
sub $29, $29, -180
add $8, $29, -176
sw $8, -56($sp)
lw $9, -56($sp)
lw $8, 0($9)
sw $8, -52($sp)
li $8, 48
sw $8, -60($sp)
lw $9, -52($sp)
lw $10, -60($sp)
sub $8, $9, $10
sw $8, -52($sp)
lw $9, -48($sp)
lw $10, -52($sp)
mul $8, $9, $10
sw $8, -48($sp)
add $29, $29, -180
jal __getchar
sub $29, $29, -180
add $8, $29, -176
sw $8, -68($sp)
lw $9, -68($sp)
lw $8, 0($9)
sw $8, -64($sp)
lw $9, -48($sp)
lw $10, -64($sp)
add $8, $9, $10
sw $8, -48($sp)
li $8, 48
sw $8, -72($sp)
lw $9, -48($sp)
lw $10, -72($sp)
sub $8, $9, $10
sw $8, -48($sp)
lw $8, -48($sp)
lw $9, -40($sp)
sw $8, 0($9)
add $8, $29, -176
sw $8, -80($sp)
lw $9, -80($sp)
move $8, $9
sw $8, -76($sp)
li $8, 0
sw $8, -88($sp)
add $8, $29, -188
sw $8, -92($sp)
lw $8, -88($sp)
lw $9, -92($sp)
sw $8, 0($9)
add $8, $29, -192
sw $8, -100($sp)
lw $9, -28($sp)
lb $8, 0($9)
sw $8, -96($sp)
lw $8, -96($sp)
lw $9, -100($sp)
sb $8, 0($9)
add $8, $29, -196
sw $8, -108($sp)
lw $9, -16($sp)
lb $8, 0($9)
sw $8, -104($sp)
lw $8, -104($sp)
lw $9, -108($sp)
sb $8, 0($9)
add $8, $29, -200
sw $8, -116($sp)
lw $9, -4($sp)
lb $8, 0($9)
sw $8, -112($sp)
lw $8, -112($sp)
lw $9, -116($sp)
sb $8, 0($9)
add $8, $29, -204
sw $8, -124($sp)
lw $9, -40($sp)
lw $8, 0($9)
sw $8, -120($sp)
lw $8, -120($sp)
lw $9, -124($sp)
sw $8, 0($9)
add $29, $29, -204
jal __cd
sub $29, $29, -204
add $8, $29, -180
sw $8, -128($sp)
lw $9, -128($sp)
lw $8, 0($9)
sw $8, -84($sp)
lw $8, -84($sp)
lw $9, -76($sp)
sw $8, 0($9)
add $8, $29, -184
sw $8, -140($sp)
lw $9, -76($sp)
lw $8, 0($9)
sw $8, -136($sp)
lw $8, -136($sp)
lw $9, -140($sp)
sw $8, 0($9)
lw $9, 384($a3)
move $8, $9
sw $8, -144($sp)
add $8, $29, -188
sw $8, -148($sp)
lw $8, -144($sp)
lw $9, -148($sp)
sw $8, 0($9)
add $29, $29, -188
jal __printf
sub $29, $29, -188
li $8, 0
sw $8, -152($sp)
add $8, $29, 4
sw $8, -156($sp)
lw $8, -152($sp)
lw $9, -156($sp)
sw $8, 0($9)
j __main_end
j __main_end
__main_end:
li $v0, 10
syscall
#string $15 #move %c --> %c\n
#string $96 #%d\n
#----------------------------
#func #cd
#addi $2 $0 0
#addi $3 $0 4
#addi $4 $0 8
#addi $5 $0 12
#addi $6 $0 16
####move $7 $2
#lw $7 $2 0
#li $8 1
#sub $8 $7 $8
#bnez $8 l:0
#sw $1 $0 -232
####move $10 $5
#addi $11 $0 -236
#lb $10 $5 0
#sb $10 $11 0
####move $12 $3
#addi $13 $0 -240
#lb $12 $3 0
#sb $12 $13 0
#move $14 $15
#addi $16 $0 -244
#sw $14 $16 0
#addi $0 $0 -244
#call #printf
#subi $0 $0 -244
#lw $1 $0 -232
####move $17 $6
#move $18 $6
#lw $17 $6 0
#addi $19 $17 1
#sw $19 $18 0
#goto l:1
#label l:0
#move $20 $6
#sw $1 $0 -236
####move $22 $6
#addi $23 $0 -240
#lw $22 $6 0
#sw $22 $23 0
####move $24 $4
#addi $25 $0 -244
#lb $24 $4 0
#sb $24 $25 0
####move $26 $5
#addi $27 $0 -248
#lb $26 $5 0
#sb $26 $27 0
####move $28 $3
#addi $29 $0 -252
#lb $28 $3 0
#sb $28 $29 0
####move $30 $2
#lw $30 $2 0
#li $31 1
#sub $30 $30 $31
#addi $32 $0 -256
#sw $30 $32 0
#addi $0 $0 -256
#call #cd
#subi $0 $0 -256
#lw $1 $0 -236
#addi $33 $0 -232
####move $21 $33
#lw $21 $33 0
#sw $21 $20 0
#sw $1 $0 -232
####move $35 $5
#addi $36 $0 -236
#lb $35 $5 0
#sb $35 $36 0
####move $37 $3
#addi $38 $0 -240
#lb $37 $3 0
#sb $37 $38 0
#move $39 $15
#addi $40 $0 -244
#sw $39 $40 0
#addi $0 $0 -244
#call #printf
#subi $0 $0 -244
#lw $1 $0 -232
#move $41 $6
#sw $1 $0 -236
####move $43 $6
#addi $44 $0 -240
#lw $43 $6 0
#sw $43 $44 0
####move $45 $5
#addi $46 $0 -244
#lb $45 $5 0
#sb $45 $46 0
####move $47 $3
#addi $48 $0 -248
#lb $47 $3 0
#sb $47 $48 0
####move $49 $4
#addi $50 $0 -252
#lb $49 $4 0
#sb $49 $50 0
####move $51 $2
#lw $51 $2 0
#li $52 1
#sub $51 $51 $52
#addi $53 $0 -256
#sw $51 $53 0
#addi $0 $0 -256
#call #cd
#subi $0 $0 -256
#lw $1 $0 -236
#addi $54 $0 -232
####move $42 $54
#lw $42 $54 0
#sw $42 $41 0
####move $55 $6
#move $56 $6
#lw $55 $6 0
#addi $57 $55 1
#sw $57 $56 0
#label l:1
####move $58 $6
#addi $59 $0 24
#lw $58 $6 0
#sw $58 $59 0
#return
#return
#----------------------------
#func #main
#addi $61 $0 -160
#move $60 $61
#li $62 65
#sw $62 $60 0
#addi $64 $0 -164
#move $63 $64
#li $65 66
#sw $65 $63 0
#addi $67 $0 -168
#move $66 $67
#li $68 67
#sw $68 $66 0
#addi $70 $0 -172
#move $69 $70
#li $71 10
#addi $0 $0 -180
#call #getchar
#subi $0 $0 -180
#addi $73 $0 -176
####move $72 $73
#lw $72 $73 0
#li $74 48
#sub $72 $72 $74
#mul $71 $71 $72
#addi $0 $0 -180
#call #getchar
#subi $0 $0 -180
#addi $76 $0 -176
####move $75 $76
#lw $75 $76 0
#add $71 $71 $75
#li $77 48
#sub $71 $71 $77
#sw $71 $69 0
#addi $79 $0 -176
#move $78 $79
#li $81 0
#addi $82 $0 -188
#sw $81 $82 0
####move $83 $66
#addi $84 $0 -192
#lb $83 $66 0
#sb $83 $84 0
####move $85 $63
#addi $86 $0 -196
#lb $85 $63 0
#sb $85 $86 0
####move $87 $60
#addi $88 $0 -200
#lb $87 $60 0
#sb $87 $88 0
####move $89 $69
#addi $90 $0 -204
#lw $89 $69 0
#sw $89 $90 0
#addi $0 $0 -204
#call #cd
#subi $0 $0 -204
#addi $91 $0 -180
####move $80 $91
#lw $80 $91 0
#sw $80 $78 0
####move $93 $78
#addi $94 $0 -184
#lw $93 $78 0
#sw $93 $94 0
#move $95 $96
#addi $97 $0 -188
#sw $95 $97 0
#addi $0 $0 -188
#call #printf
#subi $0 $0 -188
#li $98 0
#addi $99 $0 4
#sw $98 $99 0
#return
#return
