.data
temp: .space 148
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

main:
la $a3, temp
la $t0, var0
sw $t0, 40($a3)
la $t0, var1
sw $t0, 56($a3)
add $8, $29, -136
sw $8, -8($sp)
lw $9, -8($sp)
move $8, $9
sw $8, -4($sp)
li $8, 10283
sw $8, -12($sp)
lw $8, -12($sp)
lw $9, -4($sp)
sw $8, 0($9)
li $8, 3
sw $8, -20($sp)
lw $9, -4($sp)
lw $8, 0($9)
sw $8, -24($sp)
lw $9, -20($sp)
lw $10, -24($sp)
add $8, $9, $10
sw $8, -20($sp)
add $8, $29, -144
sw $8, -28($sp)
lw $8, -20($sp)
lw $9, -28($sp)
sw $8, 0($9)
lw $9, 40($a3)
move $8, $9
sw $8, -32($sp)
add $8, $29, -148
sw $8, -36($sp)
lw $8, -32($sp)
lw $9, -36($sp)
sw $8, 0($9)
add $29, $29, -148
jal __printf
sub $29, $29, -148
lw $9, 56($a3)
move $8, $9
sw $8, -44($sp)
add $8, $29, -144
sw $8, -48($sp)
lw $8, -44($sp)
lw $9, -48($sp)
sw $8, 0($9)
add $29, $29, -144
jal __printf_single
sub $29, $29, -144
li $8, 3
sw $8, -56($sp)
add $29, $29, -152
jal __getchar
sub $29, $29, -152
add $8, $29, -148
sw $8, -64($sp)
lw $9, -64($sp)
lw $8, 0($9)
sw $8, -60($sp)
li $8, 48
sw $8, -68($sp)
lw $9, -60($sp)
lw $10, -68($sp)
sub $8, $9, $10
sw $8, -60($sp)
lw $9, -56($sp)
lw $10, -60($sp)
mul $8, $9, $10
sw $8, -56($sp)
add $8, $29, -144
sw $8, -72($sp)
lw $8, -56($sp)
lw $9, -72($sp)
sw $8, 0($9)
lw $9, 40($a3)
move $8, $9
sw $8, -76($sp)
add $8, $29, -148
sw $8, -80($sp)
lw $8, -76($sp)
lw $9, -80($sp)
sw $8, 0($9)
add $29, $29, -148
jal __printf
sub $29, $29, -148
lw $9, 56($a3)
move $8, $9
sw $8, -88($sp)
add $8, $29, -144
sw $8, -92($sp)
lw $8, -88($sp)
lw $9, -92($sp)
sw $8, 0($9)
add $29, $29, -144
jal __printf_single
sub $29, $29, -144
li $8, 3
sw $8, -100($sp)
add $8, $29, -144
sw $8, -104($sp)
lw $8, -100($sp)
lw $9, -104($sp)
sw $8, 0($9)
lw $9, 40($a3)
move $8, $9
sw $8, -108($sp)
add $8, $29, -148
sw $8, -112($sp)
lw $8, -108($sp)
lw $9, -112($sp)
sw $8, 0($9)
add $29, $29, -148
jal __printf
sub $29, $29, -148
lw $9, 56($a3)
move $8, $9
sw $8, -120($sp)
add $8, $29, -144
sw $8, -124($sp)
lw $8, -120($sp)
lw $9, -124($sp)
sw $8, 0($9)
add $29, $29, -144
jal __printf_single
sub $29, $29, -144
li $8, 0
sw $8, -128($sp)
add $8, $29, 4
sw $8, -132($sp)
lw $8, -128($sp)
lw $9, -132($sp)
sw $8, 0($9)
j __main_end
j __main_end
__main_end:
li $v0, 10
syscall
#string $10 #%d
#string $14 #\n
#----------------------------
#func #main
#addi $3 $0 -136
#move $2 $3
#li $4 10283
#sw $4 $2 0
#li $6 3
####move $7 $2
#lw $7 $2 0
#add $6 $6 $7
#addi $8 $0 -144
#sw $6 $8 0
#move $9 $10
#addi $11 $0 -148
#sw $9 $11 0
#addi $0 $0 -148
#call #printf
#subi $0 $0 -148
#move $13 $14
#addi $15 $0 -144
#sw $13 $15 0
#addi $0 $0 -144
#call #printf_single
#subi $0 $0 -144
#li $17 3
#addi $0 $0 -152
#call #getchar
#subi $0 $0 -152
#addi $19 $0 -148
####move $18 $19
#lw $18 $19 0
#li $20 48
#sub $18 $18 $20
#mul $17 $17 $18
#addi $21 $0 -144
#sw $17 $21 0
#move $22 $10
#addi $23 $0 -148
#sw $22 $23 0
#addi $0 $0 -148
#call #printf
#subi $0 $0 -148
#move $25 $14
#addi $26 $0 -144
#sw $25 $26 0
#addi $0 $0 -144
#call #printf_single
#subi $0 $0 -144
#li $28 3
#addi $29 $0 -144
#sw $28 $29 0
#move $30 $10
#addi $31 $0 -148
#sw $30 $31 0
#addi $0 $0 -148
#call #printf
#subi $0 $0 -148
#move $33 $14
#addi $34 $0 -144
#sw $33 $34 0
#addi $0 $0 -144
#call #printf_single
#subi $0 $0 -144
#li $35 0
#addi $36 $0 4
#sw $35 $36 0
#return
#return
