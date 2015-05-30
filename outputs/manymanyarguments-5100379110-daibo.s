.data
temp: .space 288
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

__a:
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
add $8, $29, 20
sw $8, -24($sp)
add $8, $29, 24
sw $8, -28($sp)
add $8, $29, 28
sw $8, -32($sp)
add $8, $29, 32
sw $8, -36($sp)
add $8, $29, 36
sw $8, -40($sp)
add $8, $29, 40
sw $8, -44($sp)
add $8, $29, 44
sw $8, -48($sp)
add $8, $29, 48
sw $8, -52($sp)
add $8, $29, 52
sw $8, -56($sp)
add $8, $29, 56
sw $8, -60($sp)
lw $9, -4($sp)
lw $8, 0($9)
sw $8, -64($sp)
lw $9, -8($sp)
lw $8, 0($9)
sw $8, -68($sp)
lw $9, -64($sp)
lw $10, -68($sp)
add $8, $9, $10
sw $8, -64($sp)
lw $9, -12($sp)
lw $8, 0($9)
sw $8, -72($sp)
lw $9, -64($sp)
lw $10, -72($sp)
add $8, $9, $10
sw $8, -64($sp)
lw $9, -16($sp)
lw $8, 0($9)
sw $8, -76($sp)
lw $9, -64($sp)
lw $10, -76($sp)
add $8, $9, $10
sw $8, -64($sp)
lw $9, -20($sp)
lw $8, 0($9)
sw $8, -80($sp)
lw $9, -64($sp)
lw $10, -80($sp)
add $8, $9, $10
sw $8, -64($sp)
lw $9, -24($sp)
lw $8, 0($9)
sw $8, -84($sp)
lw $9, -64($sp)
lw $10, -84($sp)
add $8, $9, $10
sw $8, -64($sp)
lw $9, -28($sp)
lw $8, 0($9)
sw $8, -88($sp)
lw $9, -64($sp)
lw $10, -88($sp)
add $8, $9, $10
sw $8, -64($sp)
lw $9, -32($sp)
lw $8, 0($9)
sw $8, -92($sp)
lw $9, -64($sp)
lw $10, -92($sp)
add $8, $9, $10
sw $8, -64($sp)
lw $9, -36($sp)
lw $8, 0($9)
sw $8, -96($sp)
lw $9, -64($sp)
lw $10, -96($sp)
add $8, $9, $10
sw $8, -64($sp)
lw $9, -40($sp)
lw $8, 0($9)
sw $8, -100($sp)
lw $9, -64($sp)
lw $10, -100($sp)
add $8, $9, $10
sw $8, -64($sp)
lw $9, -44($sp)
lw $8, 0($9)
sw $8, -104($sp)
lw $9, -64($sp)
lw $10, -104($sp)
add $8, $9, $10
sw $8, -64($sp)
lw $9, -48($sp)
lw $8, 0($9)
sw $8, -108($sp)
lw $9, -64($sp)
lw $10, -108($sp)
add $8, $9, $10
sw $8, -64($sp)
lw $9, -52($sp)
lw $8, 0($9)
sw $8, -112($sp)
lw $9, -64($sp)
lw $10, -112($sp)
add $8, $9, $10
sw $8, -64($sp)
lw $9, -56($sp)
lw $8, 0($9)
sw $8, -116($sp)
lw $9, -64($sp)
lw $10, -116($sp)
add $8, $9, $10
sw $8, -64($sp)
lw $9, -60($sp)
lw $8, 0($9)
sw $8, -120($sp)
lw $9, -64($sp)
lw $10, -120($sp)
add $8, $9, $10
sw $8, -64($sp)
add $8, $29, 64
sw $8, -124($sp)
lw $8, -64($sp)
lw $9, -124($sp)
sw $8, 0($9)
jr $ra
jr $ra
main:
la $a3, temp
la $t0, var0
sw $t0, 272($a3)
li $8, 15
sw $8, -12($sp)
add $8, $29, -172
sw $8, -16($sp)
lw $8, -12($sp)
lw $9, -16($sp)
sw $8, 0($9)
li $8, 14
sw $8, -20($sp)
add $8, $29, -176
sw $8, -24($sp)
lw $8, -20($sp)
lw $9, -24($sp)
sw $8, 0($9)
li $8, 13
sw $8, -28($sp)
add $8, $29, -180
sw $8, -32($sp)
lw $8, -28($sp)
lw $9, -32($sp)
sw $8, 0($9)
li $8, 12
sw $8, -36($sp)
add $8, $29, -184
sw $8, -40($sp)
lw $8, -36($sp)
lw $9, -40($sp)
sw $8, 0($9)
li $8, 11
sw $8, -44($sp)
add $8, $29, -188
sw $8, -48($sp)
lw $8, -44($sp)
lw $9, -48($sp)
sw $8, 0($9)
li $8, 10
sw $8, -52($sp)
add $8, $29, -192
sw $8, -56($sp)
lw $8, -52($sp)
lw $9, -56($sp)
sw $8, 0($9)
li $8, 9
sw $8, -60($sp)
add $8, $29, -196
sw $8, -64($sp)
lw $8, -60($sp)
lw $9, -64($sp)
sw $8, 0($9)
li $8, 8
sw $8, -68($sp)
add $8, $29, -200
sw $8, -72($sp)
lw $8, -68($sp)
lw $9, -72($sp)
sw $8, 0($9)
li $8, 7
sw $8, -76($sp)
add $8, $29, -204
sw $8, -80($sp)
lw $8, -76($sp)
lw $9, -80($sp)
sw $8, 0($9)
li $8, 6
sw $8, -84($sp)
add $8, $29, -208
sw $8, -88($sp)
lw $8, -84($sp)
lw $9, -88($sp)
sw $8, 0($9)
li $8, 5
sw $8, -92($sp)
add $8, $29, -212
sw $8, -96($sp)
lw $8, -92($sp)
lw $9, -96($sp)
sw $8, 0($9)
li $8, 4
sw $8, -100($sp)
add $8, $29, -216
sw $8, -104($sp)
lw $8, -100($sp)
lw $9, -104($sp)
sw $8, 0($9)
li $8, 3
sw $8, -108($sp)
add $8, $29, -220
sw $8, -112($sp)
lw $8, -108($sp)
lw $9, -112($sp)
sw $8, 0($9)
li $8, 2
sw $8, -116($sp)
add $8, $29, -224
sw $8, -120($sp)
lw $8, -116($sp)
lw $9, -120($sp)
sw $8, 0($9)
li $8, 1
sw $8, -124($sp)
add $8, $29, -228
sw $8, -128($sp)
lw $8, -124($sp)
lw $9, -128($sp)
sw $8, 0($9)
add $29, $29, -228
jal __a
sub $29, $29, -228
add $8, $29, -164
sw $8, -132($sp)
add $8, $29, -160
sw $8, -136($sp)
lw $9, -132($sp)
lw $8, 0($9)
sw $8, -8($sp)
lw $8, -8($sp)
lw $9, -136($sp)
sw $8, 0($9)
lw $9, 272($a3)
move $8, $9
sw $8, -140($sp)
add $8, $29, -164
sw $8, -144($sp)
lw $8, -140($sp)
lw $9, -144($sp)
sw $8, 0($9)
add $29, $29, -164
jal __printf
sub $29, $29, -164
li $8, 0
sw $8, -148($sp)
add $8, $29, 4
sw $8, -152($sp)
lw $8, -148($sp)
lw $9, -152($sp)
sw $8, 0($9)
j __main_end
j __main_end
__main_end:
li $v0, 10
syscall
#string $68 #%d\n
#----------------------------
#func #a
#addi $2 $0 0
#addi $3 $0 4
#addi $4 $0 8
#addi $5 $0 12
#addi $6 $0 16
#addi $7 $0 20
#addi $8 $0 24
#addi $9 $0 28
#addi $10 $0 32
#addi $11 $0 36
#addi $12 $0 40
#addi $13 $0 44
#addi $14 $0 48
#addi $15 $0 52
#addi $16 $0 56
####move $17 $2
#lw $17 $2 0
####move $18 $3
#lw $18 $3 0
#add $17 $17 $18
####move $19 $4
#lw $19 $4 0
#add $17 $17 $19
####move $20 $5
#lw $20 $5 0
#add $17 $17 $20
####move $21 $6
#lw $21 $6 0
#add $17 $17 $21
####move $22 $7
#lw $22 $7 0
#add $17 $17 $22
####move $23 $8
#lw $23 $8 0
#add $17 $17 $23
####move $24 $9
#lw $24 $9 0
#add $17 $17 $24
####move $25 $10
#lw $25 $10 0
#add $17 $17 $25
####move $26 $11
#lw $26 $11 0
#add $17 $17 $26
####move $27 $12
#lw $27 $12 0
#add $17 $17 $27
####move $28 $13
#lw $28 $13 0
#add $17 $17 $28
####move $29 $14
#lw $29 $14 0
#add $17 $17 $29
####move $30 $15
#lw $30 $15 0
#add $17 $17 $30
####move $31 $16
#lw $31 $16 0
#add $17 $17 $31
#addi $32 $0 64
#sw $17 $32 0
#return
#return
#----------------------------
#func #main
#li $35 15
#addi $36 $0 -172
#sw $35 $36 0
#li $37 14
#addi $38 $0 -176
#sw $37 $38 0
#li $39 13
#addi $40 $0 -180
#sw $39 $40 0
#li $41 12
#addi $42 $0 -184
#sw $41 $42 0
#li $43 11
#addi $44 $0 -188
#sw $43 $44 0
#li $45 10
#addi $46 $0 -192
#sw $45 $46 0
#li $47 9
#addi $48 $0 -196
#sw $47 $48 0
#li $49 8
#addi $50 $0 -200
#sw $49 $50 0
#li $51 7
#addi $52 $0 -204
#sw $51 $52 0
#li $53 6
#addi $54 $0 -208
#sw $53 $54 0
#li $55 5
#addi $56 $0 -212
#sw $55 $56 0
#li $57 4
#addi $58 $0 -216
#sw $57 $58 0
#li $59 3
#addi $60 $0 -220
#sw $59 $60 0
#li $61 2
#addi $62 $0 -224
#sw $61 $62 0
#li $63 1
#addi $64 $0 -228
#sw $63 $64 0
#addi $0 $0 -228
#call #a
#subi $0 $0 -228
#addi $65 $0 -164
####move $34 $65
#addi $66 $0 -160
#lw $34 $65 0
#sw $34 $66 0
#move $67 $68
#addi $69 $0 -164
#sw $67 $69 0
#addi $0 $0 -164
#call #printf
#subi $0 $0 -164
#li $70 0
#addi $71 $0 4
#sw $70 $71 0
#return
#return
