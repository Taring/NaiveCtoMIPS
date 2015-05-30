.data
temp: .space 288
var0: .space 4
var1: .space 4
var2: .space 4
var3: .asciiz "%d queens:\n"
.align 2
var4: .asciiz "%d\n"
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

__test:
add $8, $29, 0
sw $8, -4($sp)
add $8, $29, 4
sw $8, -8($sp)
add $8, $29, 8
sw $8, -12($sp)
lw $9, -4($sp)
lw $8, 0($9)
sw $8, -16($sp)
lw $9, 20($a3)
lw $8, 0($9)
sw $8, -20($sp)
lw $9, -16($sp)
lw $10, -20($sp)
sub $8, $9, $10
sw $8, -20($sp)
lw $8, -20($sp)
beqz $8, label0
add $8, $29, -140
sw $8, -28($sp)
lw $9, -28($sp)
move $8, $9
sw $8, -24($sp)
lw $9, 20($a3)
lw $8, 0($9)
sw $8, -32($sp)
lw $9, -4($sp)
lw $8, 0($9)
sw $8, -36($sp)
lw $9, -8($sp)
lw $8, 0($9)
sw $8, -40($sp)
lw $9, -36($sp)
lw $10, -40($sp)
or $8, $9, $10
sw $8, -36($sp)
lw $9, -12($sp)
lw $8, 0($9)
sw $8, -44($sp)
lw $9, -36($sp)
lw $10, -44($sp)
or $8, $9, $10
sw $8, -36($sp)
lw $9, -36($sp)
not $8, $9
sw $8, -36($sp)
lw $9, -32($sp)
lw $10, -36($sp)
and $8, $9, $10
sw $8, -32($sp)
lw $8, -32($sp)
lw $9, -24($sp)
sw $8, 0($9)
label2:
lw $9, -24($sp)
lw $8, 0($9)
sw $8, -48($sp)
lw $8, -48($sp)
beqz $8, label3
add $8, $29, -144
sw $8, -56($sp)
lw $9, -56($sp)
move $8, $9
sw $8, -52($sp)
lw $9, -24($sp)
lw $8, 0($9)
sw $8, -60($sp)
lw $9, -24($sp)
lw $8, 0($9)
sw $8, -64($sp)
lw $9, -64($sp)
neg $8, $9
sw $8, -64($sp)
lw $9, -60($sp)
lw $10, -64($sp)
and $8, $9, $10
sw $8, -60($sp)
lw $8, -60($sp)
lw $9, -52($sp)
sw $8, 0($9)
lw $9, -24($sp)
move $8, $9
sw $8, -68($sp)
lw $9, -24($sp)
lw $8, 0($9)
sw $8, -76($sp)
lw $9, -52($sp)
lw $8, 0($9)
sw $8, -72($sp)
lw $9, -76($sp)
lw $10, -72($sp)
sub $8, $9, $10
sw $8, -76($sp)
lw $8, -76($sp)
lw $9, -68($sp)
sw $8, 0($9)
sw $31, -148($29)
lw $9, -12($sp)
lw $8, 0($9)
sw $8, -84($sp)
lw $9, -52($sp)
lw $8, 0($9)
sw $8, -88($sp)
lw $9, -84($sp)
lw $10, -88($sp)
add $8, $9, $10
sw $8, -84($sp)
li $8, 1
sw $8, -92($sp)
lw $9, -84($sp)
lw $10, -92($sp)
srl $8, $9, $10
sw $8, -84($sp)
add $8, $29, -152
sw $8, -96($sp)
lw $8, -84($sp)
lw $9, -96($sp)
sw $8, 0($9)
lw $9, -8($sp)
lw $8, 0($9)
sw $8, -100($sp)
lw $9, -52($sp)
lw $8, 0($9)
sw $8, -104($sp)
lw $9, -100($sp)
lw $10, -104($sp)
add $8, $9, $10
sw $8, -100($sp)
li $8, 1
sw $8, -108($sp)
lw $9, -100($sp)
lw $10, -108($sp)
sll $8, $9, $10
sw $8, -100($sp)
add $8, $29, -156
sw $8, -112($sp)
lw $8, -100($sp)
lw $9, -112($sp)
sw $8, 0($9)
lw $9, -4($sp)
lw $8, 0($9)
sw $8, -116($sp)
lw $9, -52($sp)
lw $8, 0($9)
sw $8, -120($sp)
lw $9, -116($sp)
lw $10, -120($sp)
add $8, $9, $10
sw $8, -116($sp)
add $8, $29, -160
sw $8, -124($sp)
lw $8, -116($sp)
lw $9, -124($sp)
sw $8, 0($9)
add $29, $29, -160
jal __test
sub $29, $29, -160
lw $31, -148($29)
j label2
label3:
j label1
label0:
lw $9, 12($a3)
move $8, $9
sw $8, -132($sp)
lw $9, 12($a3)
lw $8, 0($9)
sw $8, -128($sp)
lw $9, -128($sp)
add $8, $9, 1
sw $8, -136($sp)
lw $8, -136($sp)
lw $9, -132($sp)
sw $8, 0($9)
label1:
jr $ra
main:
la $a3, temp
la $t0, var0
sw $t0, 8($a3)
la $t0, var1
sw $t0, 12($a3)
la $t0, var2
sw $t0, 20($a3)
la $t0, var3
sw $t0, 204($a3)
la $t0, var4
sw $t0, 272($a3)
li $8, 0
sw $8, 16($a3)
lw $8, 16($a3)
lw $9, 12($a3)
sw $8, 0($9)
li $8, 1
sw $8, 24($a3)
lw $8, 24($a3)
lw $9, 20($a3)
sw $8, 0($9)
add $8, $29, 0
sw $8, -4($sp)
add $8, $29, 4
sw $8, -8($sp)
lw $9, 8($a3)
move $8, $9
sw $8, -12($sp)
add $29, $29, -124
jal __getchar
sub $29, $29, -124
add $8, $29, -120
sw $8, -20($sp)
lw $9, -20($sp)
lw $8, 0($9)
sw $8, -16($sp)
li $8, 48
sw $8, -24($sp)
lw $9, -16($sp)
lw $10, -24($sp)
sub $8, $9, $10
sw $8, -16($sp)
lw $8, -16($sp)
lw $9, -12($sp)
sw $8, 0($9)
add $8, $29, -124
sw $8, -36($sp)
lw $9, 8($a3)
lw $8, 0($9)
sw $8, -32($sp)
lw $8, -32($sp)
lw $9, -36($sp)
sw $8, 0($9)
lw $9, 204($a3)
move $8, $9
sw $8, -40($sp)
add $8, $29, -128
sw $8, -44($sp)
lw $8, -40($sp)
lw $9, -44($sp)
sw $8, 0($9)
add $29, $29, -128
jal __printf
sub $29, $29, -128
lw $9, 20($a3)
move $8, $9
sw $8, -48($sp)
lw $9, 20($a3)
lw $8, 0($9)
sw $8, -52($sp)
lw $9, 8($a3)
lw $8, 0($9)
sw $8, -56($sp)
lw $9, -52($sp)
lw $10, -56($sp)
sll $8, $9, $10
sw $8, -52($sp)
li $8, 1
sw $8, -60($sp)
lw $9, -52($sp)
lw $10, -60($sp)
sub $8, $9, $10
sw $8, -52($sp)
lw $8, -52($sp)
lw $9, -48($sp)
sw $8, 0($9)
li $8, 0
sw $8, -68($sp)
add $8, $29, -124
sw $8, -72($sp)
lw $8, -68($sp)
lw $9, -72($sp)
sw $8, 0($9)
li $8, 0
sw $8, -76($sp)
add $8, $29, -128
sw $8, -80($sp)
lw $8, -76($sp)
lw $9, -80($sp)
sw $8, 0($9)
li $8, 0
sw $8, -84($sp)
add $8, $29, -132
sw $8, -88($sp)
lw $8, -84($sp)
lw $9, -88($sp)
sw $8, 0($9)
add $29, $29, -132
jal __test
sub $29, $29, -132
add $8, $29, -124
sw $8, -100($sp)
lw $9, 12($a3)
lw $8, 0($9)
sw $8, -96($sp)
lw $8, -96($sp)
lw $9, -100($sp)
sw $8, 0($9)
lw $9, 272($a3)
move $8, $9
sw $8, -104($sp)
add $8, $29, -128
sw $8, -108($sp)
lw $8, -104($sp)
lw $9, -108($sp)
sw $8, 0($9)
add $29, $29, -128
jal __printf
sub $29, $29, -128
li $8, 0
sw $8, -112($sp)
add $8, $29, 12
sw $8, -116($sp)
lw $8, -112($sp)
lw $9, -116($sp)
sw $8, 0($9)
j __main_end
j __main_end
__main_end:
li $v0, 10
syscall
#global $2 4
#global $3 4
#global $5 4
#string $51 #%d queens:\n
#string $68 #%d\n
#li $4 0
#sw $4 $3 0
#li $6 1
#sw $6 $5 0
#----------------------------
#func #test
#addi $7 $0 0
#addi $8 $0 4
#addi $9 $0 8
####move $10 $7
#lw $10 $7 0
####move $11 $5
#lw $11 $5 0
#sub $11 $10 $11
#beqz $11 l:0
#addi $13 $0 -140
#move $12 $13
####move $14 $5
#lw $14 $5 0
####move $15 $7
#lw $15 $7 0
####move $16 $8
#lw $16 $8 0
#or $15 $15 $16
####move $17 $9
#lw $17 $9 0
#or $15 $15 $17
#not $15 $15
#and $14 $14 $15
#sw $14 $12 0
#label l:2
####move $18 $12
#lw $18 $12 0
#beqz $18 l:3
#addi $20 $0 -144
#move $19 $20
####move $21 $12
#lw $21 $12 0
####move $22 $12
#lw $22 $12 0
#neg $22 $22
#and $21 $21 $22
#sw $21 $19 0
#move $23 $12
####move $24 $19
#lw $25 $12 0
#lw $24 $19 0
#sub $25 $25 $24
#sw $25 $23 0
#sw $1 $0 -148
####move $27 $9
#lw $27 $9 0
####move $28 $19
#lw $28 $19 0
#add $27 $27 $28
#li $29 1
#shr $27 $27 $29
#addi $30 $0 -152
#sw $27 $30 0
####move $31 $8
#lw $31 $8 0
####move $32 $19
#lw $32 $19 0
#add $31 $31 $32
#li $33 1
#shl $31 $31 $33
#addi $34 $0 -156
#sw $31 $34 0
####move $35 $7
#lw $35 $7 0
####move $36 $19
#lw $36 $19 0
#add $35 $35 $36
#addi $37 $0 -160
#sw $35 $37 0
#addi $0 $0 -160
#call #test
#subi $0 $0 -160
#lw $1 $0 -148
#goto l:2
#label l:3
#goto l:1
#label l:0
####move $38 $3
#move $39 $3
#lw $38 $3 0
#addi $40 $38 1
#sw $40 $39 0
#label l:1
#return
#----------------------------
#func #main
#addi $41 $0 0
#addi $42 $0 4
#move $43 $2
#addi $0 $0 -124
#call #getchar
#subi $0 $0 -124
#addi $45 $0 -120
####move $44 $45
#lw $44 $45 0
#li $46 48
#sub $44 $44 $46
#sw $44 $43 0
####move $48 $2
#addi $49 $0 -124
#lw $48 $2 0
#sw $48 $49 0
#move $50 $51
#addi $52 $0 -128
#sw $50 $52 0
#addi $0 $0 -128
#call #printf
#subi $0 $0 -128
#move $53 $5
####move $54 $5
#lw $54 $5 0
####move $55 $2
#lw $55 $2 0
#shl $54 $54 $55
#li $56 1
#sub $54 $54 $56
#sw $54 $53 0
#li $58 0
#addi $59 $0 -124
#sw $58 $59 0
#li $60 0
#addi $61 $0 -128
#sw $60 $61 0
#li $62 0
#addi $63 $0 -132
#sw $62 $63 0
#addi $0 $0 -132
#call #test
#subi $0 $0 -132
####move $65 $3
#addi $66 $0 -124
#lw $65 $3 0
#sw $65 $66 0
#move $67 $68
#addi $69 $0 -128
#sw $67 $69 0
#addi $0 $0 -128
#call #printf
#subi $0 $0 -128
#li $70 0
#addi $71 $0 12
#sw $70 $71 0
#return
#return
