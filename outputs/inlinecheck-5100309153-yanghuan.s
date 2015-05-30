.data
temp: .space 232
var0: .asciiz "%d"
.align 2
var1: .asciiz "\n"
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

__inline1:
add $8, $29, 0
sw $8, -4($sp)
sw $31, -36($29)
add $8, $29, -40
sw $8, -16($sp)
lw $9, -4($sp)
lw $8, 0($9)
sw $8, -12($sp)
lw $8, -12($sp)
lw $9, -16($sp)
sw $8, 0($9)
lw $9, 28($a3)
move $8, $9
sw $8, -20($sp)
add $8, $29, -44
sw $8, -24($sp)
lw $8, -20($sp)
lw $9, -24($sp)
sw $8, 0($9)
add $29, $29, -44
jal __printf
sub $29, $29, -44
lw $31, -36($29)
li $8, 1
sw $8, -28($sp)
add $8, $29, 8
sw $8, -32($sp)
lw $8, -28($sp)
lw $9, -32($sp)
sw $8, 0($9)
jr $ra
jr $ra
__inline2:
add $8, $29, 0
sw $8, -4($sp)
add $8, $29, 4
sw $8, -8($sp)
sw $31, -48($29)
add $8, $29, -52
sw $8, -20($sp)
lw $9, -8($sp)
lw $8, 0($9)
sw $8, -16($sp)
lw $8, -16($sp)
lw $9, -20($sp)
sw $8, 0($9)
add $29, $29, -52
jal __inline1
sub $29, $29, -52
lw $31, -48($29)
add $8, $29, -44
sw $8, -24($sp)
lw $9, -4($sp)
move $8, $9
sw $8, -28($sp)
li $8, 1
sw $8, -32($sp)
lw $8, -32($sp)
lw $9, -28($sp)
sw $8, 0($9)
li $8, 1
sw $8, -36($sp)
add $8, $29, 12
sw $8, -40($sp)
lw $8, -36($sp)
lw $9, -40($sp)
sw $8, 0($9)
jr $ra
jr $ra
main:
la $a3, temp
la $t0, var0
sw $t0, 28($a3)
la $t0, var1
sw $t0, 216($a3)
add $8, $29, -148
sw $8, -8($sp)
lw $9, -8($sp)
move $8, $9
sw $8, -12($sp)
li $8, 0
sw $8, -16($sp)
lw $8, -16($sp)
lw $9, -12($sp)
sw $8, 0($9)
add $8, $29, -156
sw $8, -28($sp)
lw $9, -8($sp)
lw $8, 0($9)
sw $8, -24($sp)
lw $8, -24($sp)
lw $9, -28($sp)
sw $8, 0($9)
lw $9, 28($a3)
move $8, $9
sw $8, -32($sp)
add $8, $29, -160
sw $8, -36($sp)
lw $8, -32($sp)
lw $9, -36($sp)
sw $8, 0($9)
add $29, $29, -160
jal __printf
sub $29, $29, -160
add $8, $29, -160
sw $8, -48($sp)
lw $9, -8($sp)
lw $8, 0($9)
sw $8, -44($sp)
lw $8, -44($sp)
lw $9, -48($sp)
sw $8, 0($9)
li $8, 9
sw $8, -52($sp)
add $8, $29, -164
sw $8, -56($sp)
lw $8, -52($sp)
lw $9, -56($sp)
sw $8, 0($9)
add $29, $29, -164
jal __inline2
sub $29, $29, -164
add $8, $29, -152
sw $8, -60($sp)
add $8, $29, -156
sw $8, -72($sp)
lw $9, -8($sp)
lw $8, 0($9)
sw $8, -68($sp)
lw $8, -68($sp)
lw $9, -72($sp)
sw $8, 0($9)
lw $9, 28($a3)
move $8, $9
sw $8, -76($sp)
add $8, $29, -160
sw $8, -80($sp)
lw $8, -76($sp)
lw $9, -80($sp)
sw $8, 0($9)
add $29, $29, -160
jal __printf
sub $29, $29, -160
lw $9, -8($sp)
move $8, $9
sw $8, -84($sp)
li $8, 2
sw $8, -88($sp)
lw $8, -88($sp)
lw $9, -84($sp)
sw $8, 0($9)
add $8, $29, -160
sw $8, -100($sp)
lw $9, -8($sp)
lw $8, 0($9)
sw $8, -96($sp)
lw $8, -96($sp)
lw $9, -100($sp)
sw $8, 0($9)
add $29, $29, -160
jal __inline1
sub $29, $29, -160
add $8, $29, -152
sw $8, -104($sp)
add $8, $29, -156
sw $8, -116($sp)
lw $9, -8($sp)
lw $8, 0($9)
sw $8, -112($sp)
lw $8, -112($sp)
lw $9, -116($sp)
sw $8, 0($9)
lw $9, 28($a3)
move $8, $9
sw $8, -120($sp)
add $8, $29, -160
sw $8, -124($sp)
lw $8, -120($sp)
lw $9, -124($sp)
sw $8, 0($9)
add $29, $29, -160
jal __printf
sub $29, $29, -160
lw $9, 216($a3)
move $8, $9
sw $8, -132($sp)
add $8, $29, -156
sw $8, -136($sp)
lw $8, -132($sp)
lw $9, -136($sp)
sw $8, 0($9)
add $29, $29, -156
jal __printf_single
sub $29, $29, -156
li $8, 0
sw $8, -140($sp)
add $8, $29, 4
sw $8, -144($sp)
lw $8, -140($sp)
lw $9, -144($sp)
sw $8, 0($9)
j __main_end
j __main_end
__main_end:
li $v0, 10
syscall
#string $7 #%d
#string $54 #\n
#----------------------------
#func #inline1
#addi $2 $0 0
#sw $1 $0 -36
####move $4 $2
#addi $5 $0 -40
#lw $4 $2 0
#sw $4 $5 0
#move $6 $7
#addi $8 $0 -44
#sw $6 $8 0
#addi $0 $0 -44
#call #printf
#subi $0 $0 -44
#lw $1 $0 -36
#li $9 1
#addi $10 $0 8
#sw $9 $10 0
#return
#return
#----------------------------
#func #inline2
#addi $11 $0 0
#addi $12 $0 4
#sw $1 $0 -48
####move $14 $12
#addi $15 $0 -52
#lw $14 $12 0
#sw $14 $15 0
#addi $0 $0 -52
#call #inline1
#subi $0 $0 -52
#lw $1 $0 -48
#addi $16 $0 -44
####move $13 $16
#move $17 $11
#li $18 1
#sw $18 $17 0
#li $19 1
#addi $20 $0 12
#sw $19 $20 0
#return
#return
#----------------------------
#func #main
#addi $22 $0 -148
####move $21 $22
#move $23 $22
#li $24 0
#sw $24 $23 0
####move $26 $22
#addi $27 $0 -156
#lw $26 $22 0
#sw $26 $27 0
#move $28 $7
#addi $29 $0 -160
#sw $28 $29 0
#addi $0 $0 -160
#call #printf
#subi $0 $0 -160
####move $31 $22
#addi $32 $0 -160
#lw $31 $22 0
#sw $31 $32 0
#li $33 9
#addi $34 $0 -164
#sw $33 $34 0
#addi $0 $0 -164
#call #inline2
#subi $0 $0 -164
#addi $35 $0 -152
####move $30 $35
####move $37 $22
#addi $38 $0 -156
#lw $37 $22 0
#sw $37 $38 0
#move $39 $7
#addi $40 $0 -160
#sw $39 $40 0
#addi $0 $0 -160
#call #printf
#subi $0 $0 -160
#move $41 $22
#li $42 2
#sw $42 $41 0
####move $44 $22
#addi $45 $0 -160
#lw $44 $22 0
#sw $44 $45 0
#addi $0 $0 -160
#call #inline1
#subi $0 $0 -160
#addi $46 $0 -152
####move $43 $46
####move $48 $22
#addi $49 $0 -156
#lw $48 $22 0
#sw $48 $49 0
#move $50 $7
#addi $51 $0 -160
#sw $50 $51 0
#addi $0 $0 -160
#call #printf
#subi $0 $0 -160
#move $53 $54
#addi $55 $0 -156
#sw $53 $55 0
#addi $0 $0 -156
#call #printf_single
#subi $0 $0 -156
#li $56 0
#addi $57 $0 4
#sw $56 $57 0
#return
#return
