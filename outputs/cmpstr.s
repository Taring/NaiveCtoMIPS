.data
temp: .space 144
var0: .space 4
var1: .asciiz "abcdef"
.align 2
var2: .space 4
var3: .asciiz "abcedf"
.align 2
var4: .asciiz "%d:%c %c"
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
sw $t0, 8($a3)
la $t0, var1
sw $t0, 16($a3)
la $t0, var2
sw $t0, 20($a3)
la $t0, var3
sw $t0, 28($a3)
la $t0, var4
sw $t0, 124($a3)
lw $9, 16($a3)
move $8, $9
sw $8, 12($a3)
lw $8, 12($a3)
lw $9, 8($a3)
sw $8, 0($9)
lw $9, 28($a3)
move $8, $9
sw $8, 24($a3)
lw $8, 24($a3)
lw $9, 20($a3)
sw $8, 0($9)
add $8, $29, -112
sw $8, -8($sp)
lw $9, -8($sp)
move $8, $9
sw $8, -4($sp)
li $8, 0
sw $8, -12($sp)
lw $8, -12($sp)
lw $9, -4($sp)
sw $8, 0($9)
label0:
lw $9, -4($sp)
lw $8, 0($9)
sw $8, -16($sp)
li $8, 6
sw $8, -20($sp)
lw $9, -16($sp)
lw $10, -20($sp)
sub $8, $9, $10
sw $8, -20($sp)
lw $8, -20($sp)
bgez $8, label1
lw $9, 8($a3)
lw $8, 0($9)
sw $8, -24($sp)
lw $9, -4($sp)
lw $8, 0($9)
sw $8, -28($sp)
lw $9, -28($sp)
mul $8, $9, 1
sw $8, -32($sp)
lw $9, -24($sp)
lw $10, -32($sp)
add $8, $9, $10
sw $8, -24($sp)
lw $9, -24($sp)
lb $8, 0($9)
sw $8, -24($sp)
lw $9, 20($a3)
lw $8, 0($9)
sw $8, -36($sp)
lw $9, -4($sp)
lw $8, 0($9)
sw $8, -40($sp)
lw $9, -40($sp)
mul $8, $9, 1
sw $8, -44($sp)
lw $9, -36($sp)
lw $10, -44($sp)
add $8, $9, $10
sw $8, -36($sp)
lw $9, -36($sp)
lb $8, 0($9)
sw $8, -36($sp)
lw $9, -24($sp)
lw $10, -36($sp)
sub $8, $9, $10
sw $8, -36($sp)
lw $8, -36($sp)
beqz $8, label3
lw $9, 20($a3)
lw $8, 0($9)
sw $8, -52($sp)
lw $9, -4($sp)
lw $8, 0($9)
sw $8, -56($sp)
lw $9, -56($sp)
mul $8, $9, 1
sw $8, -60($sp)
lw $9, -52($sp)
lw $10, -60($sp)
add $8, $9, $10
sw $8, -52($sp)
add $8, $29, -120
sw $8, -64($sp)
lw $9, -52($sp)
lb $8, 0($9)
sw $8, -52($sp)
lw $8, -52($sp)
lw $9, -64($sp)
sb $8, 0($9)
lw $9, 8($a3)
lw $8, 0($9)
sw $8, -68($sp)
lw $9, -4($sp)
lw $8, 0($9)
sw $8, -72($sp)
lw $9, -72($sp)
mul $8, $9, 1
sw $8, -76($sp)
lw $9, -68($sp)
lw $10, -76($sp)
add $8, $9, $10
sw $8, -68($sp)
add $8, $29, -124
sw $8, -80($sp)
lw $9, -68($sp)
lb $8, 0($9)
sw $8, -68($sp)
lw $8, -68($sp)
lw $9, -80($sp)
sb $8, 0($9)
add $8, $29, -128
sw $8, -88($sp)
lw $9, -4($sp)
lw $8, 0($9)
sw $8, -84($sp)
lw $8, -84($sp)
lw $9, -88($sp)
sw $8, 0($9)
lw $9, 124($a3)
move $8, $9
sw $8, -92($sp)
add $8, $29, -132
sw $8, -96($sp)
lw $8, -92($sp)
lw $9, -96($sp)
sw $8, 0($9)
add $29, $29, -132
jal __printf
sub $29, $29, -132
j label1
label3:
label2:
lw $9, -4($sp)
move $8, $9
sw $8, -104($sp)
lw $9, -4($sp)
lw $8, 0($9)
sw $8, -100($sp)
lw $9, -100($sp)
add $8, $9, 1
sw $8, -108($sp)
lw $8, -108($sp)
lw $9, -104($sp)
sw $8, 0($9)
j label0
label1:
j __main_end
__main_end:
li $v0, 10
syscall
#global $2 4
#string $4 #abcdef
#global $5 4
#string $7 #abcedf
#string $31 #%d:%c %c
#move $3 $4
#sw $3 $2 0
#move $6 $7
#sw $6 $5 0
#----------------------------
#func #main
#addi $9 $0 -112
#move $8 $9
#li $10 0
#sw $10 $8 0
#label l:0
####move $11 $8
#lw $11 $8 0
#li $12 6
#sub $12 $11 $12
#bgez $12 l:1
####move $13 $2
#lw $13 $2 0
####move $14 $8
#lw $14 $8 0
#muli $15 $14 1
#add $13 $13 $15
#lb $13 $13 0
####move $16 $5
#lw $16 $5 0
####move $17 $8
#lw $17 $8 0
#muli $18 $17 1
#add $16 $16 $18
#lb $16 $16 0
#sub $16 $13 $16
#beqz $16 l:3
####move $20 $5
#lw $20 $5 0
####move $21 $8
#lw $21 $8 0
#muli $22 $21 1
#add $20 $20 $22
#addi $23 $0 -120
#lb $20 $20 0
#sb $20 $23 0
####move $24 $2
#lw $24 $2 0
####move $25 $8
#lw $25 $8 0
#muli $26 $25 1
#add $24 $24 $26
#addi $27 $0 -124
#lb $24 $24 0
#sb $24 $27 0
####move $28 $8
#addi $29 $0 -128
#lw $28 $8 0
#sw $28 $29 0
#move $30 $31
#addi $32 $0 -132
#sw $30 $32 0
#addi $0 $0 -132
#call #printf
#subi $0 $0 -132
#goto l:1
#label l:3
#label l:2
####move $33 $8
#move $34 $8
#lw $33 $8 0
#addi $35 $33 1
#sw $35 $34 0
#goto l:0
#label l:1
#return
