.data
temp: .space 352
var0: .asciiz "%d\n"
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

__tak:
add $8, $29, 0
sw $8, -4($sp)
add $8, $29, 4
sw $8, -8($sp)
add $8, $29, 8
sw $8, -12($sp)
lw $9, -8($sp)
lw $8, 0($9)
sw $8, -16($sp)
lw $9, -4($sp)
lw $8, 0($9)
sw $8, -20($sp)
lw $9, -16($sp)
lw $10, -20($sp)
sub $8, $9, $10
sw $8, -20($sp)
lw $8, -20($sp)
bgez $8, label0
li $8, 1
sw $8, -24($sp)
sw $31, -172($29)
sw $31, -184($29)
add $8, $29, -188
sw $8, -40($sp)
lw $9, -8($sp)
lw $8, 0($9)
sw $8, -36($sp)
lw $8, -36($sp)
lw $9, -40($sp)
sw $8, 0($9)
add $8, $29, -192
sw $8, -48($sp)
lw $9, -4($sp)
lw $8, 0($9)
sw $8, -44($sp)
lw $8, -44($sp)
lw $9, -48($sp)
sw $8, 0($9)
lw $9, -12($sp)
lw $8, 0($9)
sw $8, -52($sp)
li $8, 1
sw $8, -56($sp)
lw $9, -52($sp)
lw $10, -56($sp)
sub $8, $9, $10
sw $8, -52($sp)
add $8, $29, -196
sw $8, -60($sp)
lw $8, -52($sp)
lw $9, -60($sp)
sw $8, 0($9)
add $29, $29, -196
jal __tak
sub $29, $29, -196
lw $31, -184($29)
add $8, $29, -180
sw $8, -64($sp)
add $8, $29, -176
sw $8, -68($sp)
lw $9, -64($sp)
lw $8, 0($9)
sw $8, -32($sp)
lw $8, -32($sp)
lw $9, -68($sp)
sw $8, 0($9)
sw $31, -188($29)
add $8, $29, -192
sw $8, -80($sp)
lw $9, -4($sp)
lw $8, 0($9)
sw $8, -76($sp)
lw $8, -76($sp)
lw $9, -80($sp)
sw $8, 0($9)
add $8, $29, -196
sw $8, -88($sp)
lw $9, -12($sp)
lw $8, 0($9)
sw $8, -84($sp)
lw $8, -84($sp)
lw $9, -88($sp)
sw $8, 0($9)
lw $9, -8($sp)
lw $8, 0($9)
sw $8, -92($sp)
li $8, 1
sw $8, -96($sp)
lw $9, -92($sp)
lw $10, -96($sp)
sub $8, $9, $10
sw $8, -92($sp)
add $8, $29, -200
sw $8, -100($sp)
lw $8, -92($sp)
lw $9, -100($sp)
sw $8, 0($9)
add $29, $29, -200
jal __tak
sub $29, $29, -200
lw $31, -188($29)
add $8, $29, -184
sw $8, -104($sp)
add $8, $29, -180
sw $8, -108($sp)
lw $9, -104($sp)
lw $8, 0($9)
sw $8, -72($sp)
lw $8, -72($sp)
lw $9, -108($sp)
sw $8, 0($9)
sw $31, -192($29)
add $8, $29, -196
sw $8, -120($sp)
lw $9, -12($sp)
lw $8, 0($9)
sw $8, -116($sp)
lw $8, -116($sp)
lw $9, -120($sp)
sw $8, 0($9)
add $8, $29, -200
sw $8, -128($sp)
lw $9, -8($sp)
lw $8, 0($9)
sw $8, -124($sp)
lw $8, -124($sp)
lw $9, -128($sp)
sw $8, 0($9)
lw $9, -4($sp)
lw $8, 0($9)
sw $8, -132($sp)
li $8, 1
sw $8, -136($sp)
lw $9, -132($sp)
lw $10, -136($sp)
sub $8, $9, $10
sw $8, -132($sp)
add $8, $29, -204
sw $8, -140($sp)
lw $8, -132($sp)
lw $9, -140($sp)
sw $8, 0($9)
add $29, $29, -204
jal __tak
sub $29, $29, -204
lw $31, -192($29)
add $8, $29, -188
sw $8, -144($sp)
add $8, $29, -184
sw $8, -148($sp)
lw $9, -144($sp)
lw $8, 0($9)
sw $8, -112($sp)
lw $8, -112($sp)
lw $9, -148($sp)
sw $8, 0($9)
add $29, $29, -184
jal __tak
sub $29, $29, -184
lw $31, -172($29)
add $8, $29, -168
sw $8, -152($sp)
lw $9, -152($sp)
lw $8, 0($9)
sw $8, -28($sp)
lw $9, -24($sp)
lw $10, -28($sp)
add $8, $9, $10
sw $8, -24($sp)
add $8, $29, 16
sw $8, -156($sp)
lw $8, -24($sp)
lw $9, -156($sp)
sw $8, 0($9)
jr $ra
j label1
label0:
add $8, $29, 16
sw $8, -164($sp)
lw $9, -12($sp)
lw $8, 0($9)
sw $8, -160($sp)
lw $8, -160($sp)
lw $9, -164($sp)
sw $8, 0($9)
jr $ra
label1:
jr $ra
main:
la $a3, temp
la $t0, var0
sw $t0, 336($a3)
add $8, $29, -180
sw $8, -8($sp)
add $8, $29, -184
sw $8, -16($sp)
add $8, $29, -188
sw $8, -24($sp)
lw $9, -8($sp)
move $8, $9
sw $8, -28($sp)
li $8, 10
sw $8, -32($sp)
add $29, $29, -196
jal __getchar
sub $29, $29, -196
add $8, $29, -192
sw $8, -40($sp)
lw $9, -40($sp)
lw $8, 0($9)
sw $8, -36($sp)
li $8, 48
sw $8, -44($sp)
lw $9, -36($sp)
lw $10, -44($sp)
sub $8, $9, $10
sw $8, -36($sp)
lw $9, -32($sp)
lw $10, -36($sp)
mul $8, $9, $10
sw $8, -32($sp)
add $29, $29, -196
jal __getchar
sub $29, $29, -196
add $8, $29, -192
sw $8, -52($sp)
lw $9, -52($sp)
lw $8, 0($9)
sw $8, -48($sp)
lw $9, -32($sp)
lw $10, -48($sp)
add $8, $9, $10
sw $8, -32($sp)
li $8, 48
sw $8, -56($sp)
lw $9, -32($sp)
lw $10, -56($sp)
sub $8, $9, $10
sw $8, -32($sp)
lw $8, -32($sp)
lw $9, -28($sp)
sw $8, 0($9)
add $29, $29, -196
jal __getchar
sub $29, $29, -196
add $8, $29, -192
sw $8, -64($sp)
lw $9, -16($sp)
move $8, $9
sw $8, -68($sp)
li $8, 10
sw $8, -72($sp)
add $29, $29, -196
jal __getchar
sub $29, $29, -196
add $8, $29, -192
sw $8, -80($sp)
lw $9, -80($sp)
lw $8, 0($9)
sw $8, -76($sp)
li $8, 48
sw $8, -84($sp)
lw $9, -76($sp)
lw $10, -84($sp)
sub $8, $9, $10
sw $8, -76($sp)
lw $9, -72($sp)
lw $10, -76($sp)
mul $8, $9, $10
sw $8, -72($sp)
add $29, $29, -196
jal __getchar
sub $29, $29, -196
add $8, $29, -192
sw $8, -92($sp)
lw $9, -92($sp)
lw $8, 0($9)
sw $8, -88($sp)
lw $9, -72($sp)
lw $10, -88($sp)
add $8, $9, $10
sw $8, -72($sp)
li $8, 48
sw $8, -96($sp)
lw $9, -72($sp)
lw $10, -96($sp)
sub $8, $9, $10
sw $8, -72($sp)
lw $8, -72($sp)
lw $9, -68($sp)
sw $8, 0($9)
add $29, $29, -196
jal __getchar
sub $29, $29, -196
add $8, $29, -192
sw $8, -104($sp)
lw $9, -24($sp)
move $8, $9
sw $8, -108($sp)
add $29, $29, -196
jal __getchar
sub $29, $29, -196
add $8, $29, -192
sw $8, -116($sp)
lw $9, -116($sp)
lw $8, 0($9)
sw $8, -112($sp)
li $8, 48
sw $8, -120($sp)
lw $9, -112($sp)
lw $10, -120($sp)
sub $8, $9, $10
sw $8, -112($sp)
lw $8, -112($sp)
lw $9, -108($sp)
sw $8, 0($9)
add $8, $29, -208
sw $8, -136($sp)
lw $9, -24($sp)
lw $8, 0($9)
sw $8, -132($sp)
lw $8, -132($sp)
lw $9, -136($sp)
sw $8, 0($9)
add $8, $29, -212
sw $8, -144($sp)
lw $9, -16($sp)
lw $8, 0($9)
sw $8, -140($sp)
lw $8, -140($sp)
lw $9, -144($sp)
sw $8, 0($9)
add $8, $29, -216
sw $8, -152($sp)
lw $9, -8($sp)
lw $8, 0($9)
sw $8, -148($sp)
lw $8, -148($sp)
lw $9, -152($sp)
sw $8, 0($9)
add $29, $29, -216
jal __tak
sub $29, $29, -216
add $8, $29, -200
sw $8, -156($sp)
add $8, $29, -196
sw $8, -160($sp)
lw $9, -156($sp)
lw $8, 0($9)
sw $8, -128($sp)
lw $8, -128($sp)
lw $9, -160($sp)
sw $8, 0($9)
lw $9, 336($a3)
move $8, $9
sw $8, -164($sp)
add $8, $29, -200
sw $8, -168($sp)
lw $8, -164($sp)
lw $9, -168($sp)
sw $8, 0($9)
add $29, $29, -200
jal __printf
sub $29, $29, -200
li $8, 0
sw $8, -172($sp)
add $8, $29, 4
sw $8, -176($sp)
lw $8, -172($sp)
lw $9, -176($sp)
sw $8, 0($9)
j __main_end
j __main_end
__main_end:
li $v0, 10
syscall
#string $84 #%d\n
#----------------------------
#func #tak
#addi $2 $0 0
#addi $3 $0 4
#addi $4 $0 8
####move $5 $3
#lw $5 $3 0
####move $6 $2
#lw $6 $2 0
#sub $6 $5 $6
#bgez $6 l:0
#li $7 1
#sw $1 $0 -172
#sw $1 $0 -184
####move $10 $3
#addi $11 $0 -188
#lw $10 $3 0
#sw $10 $11 0
####move $12 $2
#addi $13 $0 -192
#lw $12 $2 0
#sw $12 $13 0
####move $14 $4
#lw $14 $4 0
#li $15 1
#sub $14 $14 $15
#addi $16 $0 -196
#sw $14 $16 0
#addi $0 $0 -196
#call #tak
#subi $0 $0 -196
#lw $1 $0 -184
#addi $17 $0 -180
####move $9 $17
#addi $18 $0 -176
#lw $9 $17 0
#sw $9 $18 0
#sw $1 $0 -188
####move $20 $2
#addi $21 $0 -192
#lw $20 $2 0
#sw $20 $21 0
####move $22 $4
#addi $23 $0 -196
#lw $22 $4 0
#sw $22 $23 0
####move $24 $3
#lw $24 $3 0
#li $25 1
#sub $24 $24 $25
#addi $26 $0 -200
#sw $24 $26 0
#addi $0 $0 -200
#call #tak
#subi $0 $0 -200
#lw $1 $0 -188
#addi $27 $0 -184
####move $19 $27
#addi $28 $0 -180
#lw $19 $27 0
#sw $19 $28 0
#sw $1 $0 -192
####move $30 $4
#addi $31 $0 -196
#lw $30 $4 0
#sw $30 $31 0
####move $32 $3
#addi $33 $0 -200
#lw $32 $3 0
#sw $32 $33 0
####move $34 $2
#lw $34 $2 0
#li $35 1
#sub $34 $34 $35
#addi $36 $0 -204
#sw $34 $36 0
#addi $0 $0 -204
#call #tak
#subi $0 $0 -204
#lw $1 $0 -192
#addi $37 $0 -188
####move $29 $37
#addi $38 $0 -184
#lw $29 $37 0
#sw $29 $38 0
#addi $0 $0 -184
#call #tak
#subi $0 $0 -184
#lw $1 $0 -172
#addi $39 $0 -168
####move $8 $39
#lw $8 $39 0
#add $7 $7 $8
#addi $40 $0 16
#sw $7 $40 0
#return
#goto l:1
#label l:0
####move $41 $4
#addi $42 $0 16
#lw $41 $4 0
#sw $41 $42 0
#return
#label l:1
#return
#----------------------------
#func #main
#addi $44 $0 -180
####move $43 $44
#addi $46 $0 -184
####move $45 $46
#addi $48 $0 -188
####move $47 $48
#move $49 $44
#li $50 10
#addi $0 $0 -196
#call #getchar
#subi $0 $0 -196
#addi $52 $0 -192
####move $51 $52
#lw $51 $52 0
#li $53 48
#sub $51 $51 $53
#mul $50 $50 $51
#addi $0 $0 -196
#call #getchar
#subi $0 $0 -196
#addi $55 $0 -192
####move $54 $55
#lw $54 $55 0
#add $50 $50 $54
#li $56 48
#sub $50 $50 $56
#sw $50 $49 0
#addi $0 $0 -196
#call #getchar
#subi $0 $0 -196
#addi $58 $0 -192
####move $57 $58
#move $59 $46
#li $60 10
#addi $0 $0 -196
#call #getchar
#subi $0 $0 -196
#addi $62 $0 -192
####move $61 $62
#lw $61 $62 0
#li $63 48
#sub $61 $61 $63
#mul $60 $60 $61
#addi $0 $0 -196
#call #getchar
#subi $0 $0 -196
#addi $65 $0 -192
####move $64 $65
#lw $64 $65 0
#add $60 $60 $64
#li $66 48
#sub $60 $60 $66
#sw $60 $59 0
#addi $0 $0 -196
#call #getchar
#subi $0 $0 -196
#addi $68 $0 -192
####move $67 $68
#move $69 $48
#addi $0 $0 -196
#call #getchar
#subi $0 $0 -196
#addi $71 $0 -192
####move $70 $71
#lw $70 $71 0
#li $72 48
#sub $70 $70 $72
#sw $70 $69 0
####move $75 $48
#addi $76 $0 -208
#lw $75 $48 0
#sw $75 $76 0
####move $77 $46
#addi $78 $0 -212
#lw $77 $46 0
#sw $77 $78 0
####move $79 $44
#addi $80 $0 -216
#lw $79 $44 0
#sw $79 $80 0
#addi $0 $0 -216
#call #tak
#subi $0 $0 -216
#addi $81 $0 -200
####move $74 $81
#addi $82 $0 -196
#lw $74 $81 0
#sw $74 $82 0
#move $83 $84
#addi $85 $0 -200
#sw $83 $85 0
#addi $0 $0 -200
#call #printf
#subi $0 $0 -200
#li $86 0
#addi $87 $0 4
#sw $86 $87 0
#return
#return
