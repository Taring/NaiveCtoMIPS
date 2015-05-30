.data
temp: .space 272
var0: .asciiz "%d "
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

__manyArguments:
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
sw $31, -148($29)
add $8, $29, -152
sw $8, -36($sp)
lw $9, -4($sp)
lw $8, 0($9)
sw $8, -32($sp)
lw $8, -32($sp)
lw $9, -36($sp)
sw $8, 0($9)
lw $9, 48($a3)
move $8, $9
sw $8, -40($sp)
add $8, $29, -156
sw $8, -44($sp)
lw $8, -40($sp)
lw $9, -44($sp)
sw $8, 0($9)
add $29, $29, -156
jal __printf
sub $29, $29, -156
lw $31, -148($29)
sw $31, -148($29)
add $8, $29, -152
sw $8, -56($sp)
lw $9, -8($sp)
lw $8, 0($9)
sw $8, -52($sp)
lw $8, -52($sp)
lw $9, -56($sp)
sw $8, 0($9)
lw $9, 48($a3)
move $8, $9
sw $8, -60($sp)
add $8, $29, -156
sw $8, -64($sp)
lw $8, -60($sp)
lw $9, -64($sp)
sw $8, 0($9)
add $29, $29, -156
jal __printf
sub $29, $29, -156
lw $31, -148($29)
sw $31, -148($29)
add $8, $29, -152
sw $8, -76($sp)
lw $9, -12($sp)
lw $8, 0($9)
sw $8, -72($sp)
lw $8, -72($sp)
lw $9, -76($sp)
sw $8, 0($9)
lw $9, 48($a3)
move $8, $9
sw $8, -80($sp)
add $8, $29, -156
sw $8, -84($sp)
lw $8, -80($sp)
lw $9, -84($sp)
sw $8, 0($9)
add $29, $29, -156
jal __printf
sub $29, $29, -156
lw $31, -148($29)
sw $31, -148($29)
add $8, $29, -152
sw $8, -96($sp)
lw $9, -16($sp)
lw $8, 0($9)
sw $8, -92($sp)
lw $8, -92($sp)
lw $9, -96($sp)
sw $8, 0($9)
lw $9, 48($a3)
move $8, $9
sw $8, -100($sp)
add $8, $29, -156
sw $8, -104($sp)
lw $8, -100($sp)
lw $9, -104($sp)
sw $8, 0($9)
add $29, $29, -156
jal __printf
sub $29, $29, -156
lw $31, -148($29)
sw $31, -148($29)
add $8, $29, -152
sw $8, -116($sp)
lw $9, -20($sp)
lw $8, 0($9)
sw $8, -112($sp)
lw $8, -112($sp)
lw $9, -116($sp)
sw $8, 0($9)
lw $9, 48($a3)
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
lw $31, -148($29)
sw $31, -148($29)
add $8, $29, -152
sw $8, -136($sp)
lw $9, -24($sp)
lw $8, 0($9)
sw $8, -132($sp)
lw $8, -132($sp)
lw $9, -136($sp)
sw $8, 0($9)
lw $9, 152($a3)
move $8, $9
sw $8, -140($sp)
add $8, $29, -156
sw $8, -144($sp)
lw $8, -140($sp)
lw $9, -144($sp)
sw $8, 0($9)
add $29, $29, -156
jal __printf
sub $29, $29, -156
lw $31, -148($29)
jr $ra
main:
la $a3, temp
la $t0, var0
sw $t0, 48($a3)
la $t0, var1
sw $t0, 152($a3)
li $8, 11
sw $8, -8($sp)
add $8, $29, -120
sw $8, -12($sp)
lw $8, -8($sp)
lw $9, -12($sp)
sw $8, 0($9)
li $8, 4
sw $8, -16($sp)
add $8, $29, -124
sw $8, -20($sp)
lw $8, -16($sp)
lw $9, -20($sp)
sw $8, 0($9)
li $8, 3
sw $8, -24($sp)
add $8, $29, -128
sw $8, -28($sp)
lw $8, -24($sp)
lw $9, -28($sp)
sw $8, 0($9)
li $8, 2
sw $8, -32($sp)
add $8, $29, -132
sw $8, -36($sp)
lw $8, -32($sp)
lw $9, -36($sp)
sw $8, 0($9)
li $8, 1
sw $8, -40($sp)
add $8, $29, -136
sw $8, -44($sp)
lw $8, -40($sp)
lw $9, -44($sp)
sw $8, 0($9)
li $8, 0
sw $8, -48($sp)
add $8, $29, -140
sw $8, -52($sp)
lw $8, -48($sp)
lw $9, -52($sp)
sw $8, 0($9)
add $29, $29, -140
jal __manyArguments
sub $29, $29, -140
li $8, -1
sw $8, -60($sp)
add $8, $29, -120
sw $8, -64($sp)
lw $8, -60($sp)
lw $9, -64($sp)
sw $8, 0($9)
li $8, 4
sw $8, -68($sp)
add $8, $29, -124
sw $8, -72($sp)
lw $8, -68($sp)
lw $9, -72($sp)
sw $8, 0($9)
li $8, 12
sw $8, -76($sp)
add $8, $29, -128
sw $8, -80($sp)
lw $8, -76($sp)
lw $9, -80($sp)
sw $8, 0($9)
li $8, 2
sw $8, -84($sp)
add $8, $29, -132
sw $8, -88($sp)
lw $8, -84($sp)
lw $9, -88($sp)
sw $8, 0($9)
li $8, 1
sw $8, -92($sp)
add $8, $29, -136
sw $8, -96($sp)
lw $8, -92($sp)
lw $9, -96($sp)
sw $8, 0($9)
li $8, 0
sw $8, -100($sp)
add $8, $29, -140
sw $8, -104($sp)
lw $8, -100($sp)
lw $9, -104($sp)
sw $8, 0($9)
add $29, $29, -140
jal __manyArguments
sub $29, $29, -140
li $8, 0
sw $8, -108($sp)
add $8, $29, 4
sw $8, -112($sp)
lw $8, -108($sp)
lw $9, -112($sp)
sw $8, 0($9)
j __main_end
j __main_end
__main_end:
li $v0, 10
syscall
#string $12 #%d 
#string $38 #%d\n
#----------------------------
#func #manyArguments
#addi $2 $0 0
#addi $3 $0 4
#addi $4 $0 8
#addi $5 $0 12
#addi $6 $0 16
#addi $7 $0 20
#sw $1 $0 -148
####move $9 $2
#addi $10 $0 -152
#lw $9 $2 0
#sw $9 $10 0
#move $11 $12
#addi $13 $0 -156
#sw $11 $13 0
#addi $0 $0 -156
#call #printf
#subi $0 $0 -156
#lw $1 $0 -148
#sw $1 $0 -148
####move $15 $3
#addi $16 $0 -152
#lw $15 $3 0
#sw $15 $16 0
#move $17 $12
#addi $18 $0 -156
#sw $17 $18 0
#addi $0 $0 -156
#call #printf
#subi $0 $0 -156
#lw $1 $0 -148
#sw $1 $0 -148
####move $20 $4
#addi $21 $0 -152
#lw $20 $4 0
#sw $20 $21 0
#move $22 $12
#addi $23 $0 -156
#sw $22 $23 0
#addi $0 $0 -156
#call #printf
#subi $0 $0 -156
#lw $1 $0 -148
#sw $1 $0 -148
####move $25 $5
#addi $26 $0 -152
#lw $25 $5 0
#sw $25 $26 0
#move $27 $12
#addi $28 $0 -156
#sw $27 $28 0
#addi $0 $0 -156
#call #printf
#subi $0 $0 -156
#lw $1 $0 -148
#sw $1 $0 -148
####move $30 $6
#addi $31 $0 -152
#lw $30 $6 0
#sw $30 $31 0
#move $32 $12
#addi $33 $0 -156
#sw $32 $33 0
#addi $0 $0 -156
#call #printf
#subi $0 $0 -156
#lw $1 $0 -148
#sw $1 $0 -148
####move $35 $7
#addi $36 $0 -152
#lw $35 $7 0
#sw $35 $36 0
#move $37 $38
#addi $39 $0 -156
#sw $37 $39 0
#addi $0 $0 -156
#call #printf
#subi $0 $0 -156
#lw $1 $0 -148
#return
#----------------------------
#func #main
#li $41 11
#addi $42 $0 -120
#sw $41 $42 0
#li $43 4
#addi $44 $0 -124
#sw $43 $44 0
#li $45 3
#addi $46 $0 -128
#sw $45 $46 0
#li $47 2
#addi $48 $0 -132
#sw $47 $48 0
#li $49 1
#addi $50 $0 -136
#sw $49 $50 0
#li $51 0
#addi $52 $0 -140
#sw $51 $52 0
#addi $0 $0 -140
#call #manyArguments
#subi $0 $0 -140
#li $54 -1
#addi $55 $0 -120
#sw $54 $55 0
#li $56 4
#addi $57 $0 -124
#sw $56 $57 0
#li $58 12
#addi $59 $0 -128
#sw $58 $59 0
#li $60 2
#addi $61 $0 -132
#sw $60 $61 0
#li $62 1
#addi $63 $0 -136
#sw $62 $63 0
#li $64 0
#addi $65 $0 -140
#sw $64 $65 0
#addi $0 $0 -140
#call #manyArguments
#subi $0 $0 -140
#li $66 0
#addi $67 $0 4
#sw $66 $67 0
#return
#return
