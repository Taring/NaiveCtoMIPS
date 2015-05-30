.data
temp: .space 132
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

__nfactor:
add $8, $29, 0
sw $8, -4($sp)
lw $9, -4($sp)
lw $8, 0($9)
sw $8, -8($sp)
li $8, 0
sw $8, -12($sp)
lw $9, -8($sp)
lw $10, -12($sp)
sub $8, $9, $10
sw $8, -12($sp)
lw $8, -12($sp)
bnez $8, label0
li $8, 1
sw $8, -16($sp)
add $8, $29, 8
sw $8, -20($sp)
lw $8, -16($sp)
lw $9, -20($sp)
sw $8, 0($9)
jr $ra
j label1
label0:
lw $9, -4($sp)
lw $8, 0($9)
sw $8, -24($sp)
sw $31, -56($29)
lw $9, -4($sp)
lw $8, 0($9)
sw $8, -32($sp)
li $8, 1
sw $8, -36($sp)
lw $9, -32($sp)
lw $10, -36($sp)
sub $8, $9, $10
sw $8, -32($sp)
add $8, $29, -60
sw $8, -40($sp)
lw $8, -32($sp)
lw $9, -40($sp)
sw $8, 0($9)
add $29, $29, -60
jal __nfactor
sub $29, $29, -60
lw $31, -56($29)
add $8, $29, -52
sw $8, -44($sp)
lw $9, -44($sp)
lw $8, 0($9)
sw $8, -28($sp)
lw $9, -24($sp)
lw $10, -28($sp)
mul $8, $9, $10
sw $8, -24($sp)
add $8, $29, 8
sw $8, -48($sp)
lw $8, -24($sp)
lw $9, -48($sp)
sw $8, 0($9)
jr $ra
label1:
jr $ra
main:
la $a3, temp
la $t0, var0
sw $t0, 116($a3)
add $8, $29, -76
sw $8, -8($sp)
lw $9, -8($sp)
move $8, $9
sw $8, -4($sp)
add $29, $29, -84
jal __getchar
sub $29, $29, -84
add $8, $29, -80
sw $8, -16($sp)
lw $9, -16($sp)
lw $8, 0($9)
sw $8, -12($sp)
li $8, 48
sw $8, -20($sp)
lw $9, -12($sp)
lw $10, -20($sp)
sub $8, $9, $10
sw $8, -12($sp)
lw $8, -12($sp)
lw $9, -4($sp)
sw $8, 0($9)
add $8, $29, -80
sw $8, -28($sp)
lw $9, -28($sp)
move $8, $9
sw $8, -24($sp)
add $8, $29, -92
sw $8, -40($sp)
lw $9, -4($sp)
lw $8, 0($9)
sw $8, -36($sp)
lw $8, -36($sp)
lw $9, -40($sp)
sw $8, 0($9)
add $29, $29, -92
jal __nfactor
sub $29, $29, -92
add $8, $29, -84
sw $8, -44($sp)
lw $9, -44($sp)
lw $8, 0($9)
sw $8, -32($sp)
lw $8, -32($sp)
lw $9, -24($sp)
sw $8, 0($9)
add $8, $29, -88
sw $8, -56($sp)
lw $9, -24($sp)
lw $8, 0($9)
sw $8, -52($sp)
lw $8, -52($sp)
lw $9, -56($sp)
sw $8, 0($9)
lw $9, 116($a3)
move $8, $9
sw $8, -60($sp)
add $8, $29, -92
sw $8, -64($sp)
lw $8, -60($sp)
lw $9, -64($sp)
sw $8, 0($9)
add $29, $29, -92
jal __printf
sub $29, $29, -92
add $8, $29, 4
sw $8, -72($sp)
lw $9, -24($sp)
lw $8, 0($9)
sw $8, -68($sp)
lw $8, -68($sp)
lw $9, -72($sp)
sw $8, 0($9)
j __main_end
j __main_end
__main_end:
li $v0, 10
syscall
#string $29 #%d\n
#----------------------------
#func #nfactor
#addi $2 $0 0
####move $3 $2
#lw $3 $2 0
#li $4 0
#sub $4 $3 $4
#bnez $4 l:0
#li $5 1
#addi $6 $0 8
#sw $5 $6 0
#return
#goto l:1
#label l:0
####move $7 $2
#lw $7 $2 0
#sw $1 $0 -56
####move $9 $2
#lw $9 $2 0
#li $10 1
#sub $9 $9 $10
#addi $11 $0 -60
#sw $9 $11 0
#addi $0 $0 -60
#call #nfactor
#subi $0 $0 -60
#lw $1 $0 -56
#addi $12 $0 -52
####move $8 $12
#lw $8 $12 0
#mul $7 $7 $8
#addi $13 $0 8
#sw $7 $13 0
#return
#label l:1
#return
#----------------------------
#func #main
#addi $15 $0 -76
#move $14 $15
#addi $0 $0 -84
#call #getchar
#subi $0 $0 -84
#addi $17 $0 -80
####move $16 $17
#lw $16 $17 0
#li $18 48
#sub $16 $16 $18
#sw $16 $14 0
#addi $20 $0 -80
#move $19 $20
####move $22 $14
#addi $23 $0 -92
#lw $22 $14 0
#sw $22 $23 0
#addi $0 $0 -92
#call #nfactor
#subi $0 $0 -92
#addi $24 $0 -84
####move $21 $24
#lw $21 $24 0
#sw $21 $19 0
####move $26 $19
#addi $27 $0 -88
#lw $26 $19 0
#sw $26 $27 0
#move $28 $29
#addi $30 $0 -92
#sw $28 $30 0
#addi $0 $0 -92
#call #printf
#subi $0 $0 -92
####move $31 $19
#addi $32 $0 4
#lw $31 $19 0
#sw $31 $32 0
#return
#return
