.data
temp: .space 508
var0: .space 4
var1: .space 32
var2: .space 32
var3: .space 120
var4: .asciiz " O"
.align 2
var5: .asciiz " ."
.align 2
var6: .asciiz "\n"
.align 2
var7: .asciiz "\n"
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
beq $a2, '%', __printf_format
beq $a2, '\\', __printf_trans
__printf_normal:
li $v0, 11
lb $a0, ($t1)
syscall
j __printf_loop

__printf_format:
lb $t0, 1($t1)
beq $t0, 'c', __printf_format_c
beq $t0, 'd', __printf_format_d
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

__printBoard:
add $11, $29, -140
move $18, $11
add $19, $29, -144
move $20, $19
move $19, $11
li $11, 0
sw $11, 0($19)
l0:
lw $11, 0($18)
lw $16, 8($a3)
lw $19, 0($16)
sub $19, $11, $19
bgez $19, l1
move $11, $20
li $19, 0
sw $19, 0($11)
l3:
lw $11, 0($20)
lw $19, 0($16)
sub $19, $11, $19
bgez $19, l4
lw $11, 0($18)
mul $19, $11, 4
lw $15, 20($a3)
add $11, $15, $19
lw $11, 0($11)
lw $19, 0($20)
sub $19, $11, $19
bnez $19, l6
sw $31, -148($29)
lw $14, 100($a3)
move $11, $14
add $19, $29, -152
sw $11, 0($19)
add $29, $29, -152
jal __printf_single
sub $29, $29, -152
lw $31, -148($29)
j l7
l6:
sw $31, -148($29)
lw $13, 116($a3)
move $11, $13
add $19, $29, -152
sw $11, 0($19)
add $29, $29, -152
jal __printf_single
sub $29, $29, -152
lw $31, -148($29)
l7:
l5:
move $11, $20
lw $19, 0($20)
add $21, $19, 1
sw $21, 0($11)
j l3
l4:
sw $31, -148($29)
lw $12, 144($a3)
move $11, $12
add $19, $29, -152
sw $11, 0($19)
add $29, $29, -152
jal __printf_single
sub $29, $29, -152
lw $31, -148($29)
l2:
move $11, $18
lw $19, 0($18)
add $21, $19, 1
sw $21, 0($11)
j l0
l1:
sw $31, -148($29)
lw $17, 172($a3)
move $11, $17
add $12, $29, -152
sw $11, 0($12)
add $29, $29, -152
jal __printf_single
sub $29, $29, -152
lw $31, -148($29)
jr $ra
__search:
add $15, $29, 0
lw $16, 0($15)
lw $14, 8($a3)
lw $17, 0($14)
sub $17, $16, $17
bnez $17, l8
sw $31, -312($29)
add $29, $29, -312
sw $14, 8($a3)
sw $15, 308($sp)
jal __printBoard
lw $14, 8($a3)
lw $15, 308($sp)
sub $29, $29, -312
lw $31, -312($29)
j l9
l8:
add $16, $29, -312
move $17, $16
move $18, $16
li $16, 0
sw $16, 0($18)
l10:
lw $16, 0($17)
lw $18, 0($14)
sub $18, $16, $18
bgez $18, l11
lw $16, 0($17)
mul $18, $16, 4
lw $13, 16($a3)
add $16, $13, $18
lw $16, 0($16)
li $18, 0
sub $18, $16, $18
bnez $18, l13
li $16, 0
mul $18, $16, 60
lw $12, 24($a3)
add $16, $12, $18
lw $18, 0($17)
lw $19, 0($15)
add $18, $18, $19
mul $19, $18, 4
add $16, $16, $19
lw $16, 0($16)
li $18, 0
sub $18, $16, $18
bnez $18, l13
li $16, 1
mul $18, $16, 60
add $16, $12, $18
lw $18, 0($17)
lw $19, 0($14)
add $18, $18, $19
sub $18, $18, 1
lw $19, 0($15)
sub $18, $18, $19
mul $19, $18, 4
add $16, $16, $19
lw $16, 0($16)
li $18, 0
sub $18, $16, $18
bnez $18, l13
lw $16, 0($17)
mul $18, $16, 4
add $16, $13, $18
li $18, 0
mul $19, $18, 60
add $18, $12, $19
lw $19, 0($17)
lw $20, 0($15)
add $19, $19, $20
mul $20, $19, 4
add $18, $18, $20
li $19, 1
mul $20, $19, 60
add $19, $12, $20
lw $20, 0($17)
lw $21, 0($14)
add $20, $20, $21
sub $20, $20, 1
lw $21, 0($15)
sub $20, $20, $21
mul $21, $20, 4
add $19, $19, $21
li $20, 1
sw $20, 0($19)
lw $19, 0($19)
sw $19, 0($18)
lw $18, 0($18)
sw $18, 0($16)
lw $16, 0($15)
mul $18, $16, 4
lw $11, 20($a3)
add $16, $11, $18
lw $18, 0($17)
sw $18, 0($16)
sw $31, -316($29)
lw $16, 0($15)
add $16, $16, 1
add $18, $29, -320
sw $16, 0($18)
add $29, $29, -320
sw $11, 20($a3)
sw $12, 24($a3)
sw $13, 16($a3)
sw $14, 8($a3)
sw $15, 316($sp)
sw $17, 300($sp)
jal __search
lw $11, 20($a3)
lw $12, 24($a3)
lw $13, 16($a3)
lw $14, 8($a3)
lw $15, 316($sp)
lw $17, 300($sp)
sub $29, $29, -320
lw $31, -316($29)
lw $16, 0($17)
mul $18, $16, 4
add $16, $13, $18
li $18, 0
mul $19, $18, 60
add $18, $12, $19
lw $19, 0($17)
lw $20, 0($15)
add $19, $19, $20
mul $20, $19, 4
add $18, $18, $20
li $19, 1
mul $20, $19, 60
add $19, $12, $20
lw $20, 0($17)
lw $21, 0($14)
add $20, $20, $21
sub $20, $20, 1
lw $21, 0($15)
sub $20, $20, $21
mul $21, $20, 4
add $19, $19, $21
li $20, 0
sw $20, 0($19)
lw $19, 0($19)
sw $19, 0($18)
lw $18, 0($18)
sw $18, 0($16)
l13:
l12:
move $16, $17
lw $18, 0($17)
add $19, $18, 1
sw $19, 0($16)
j l10
l11:
l9:
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
sw $t0, 24($a3)
la $t0, var4
sw $t0, 100($a3)
la $t0, var5
sw $t0, 116($a3)
la $t0, var6
sw $t0, 144($a3)
la $t0, var7
sw $t0, 172($a3)
li $8, 8
sw $8, 12($a3)
lw $8, 12($a3)
lw $9, 8($a3)
sw $8, 0($9)
li $11, 0
add $12, $29, -28
sw $11, 0($12)
add $29, $29, -28
jal __search
sub $29, $29, -28
li $11, 0
add $12, $29, 4
sw $11, 0($12)
j __main_end
j __main_end
__main_end:
li $v0, 10
syscall
