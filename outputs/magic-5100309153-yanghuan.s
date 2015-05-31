.data
temp: .space 1532
var0: .space 36
var1: .space 40
var2: .space 4
var3: .space 4
var4: .space 4
var5: .asciiz "%d"
.align 2
var6: .asciiz "%c"
.align 2
var7: .asciiz "%c"
.align 2
var8: .asciiz "%c"
.align 2
var9: .asciiz "%d\n"
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

__search:
add $8, $29, 0
sw $8, -4($sp)
add $19, $29, 4
add $20, $29, 8
add $21, $29, -1420
move $22, $21
add $21, $29, -1424
move $23, $21
add $21, $29, -1428
move $24, $21
lw $21, 0($19)
li $25, 0
sub $25, $21, $25
li $21, 1
bgtz $25, l2
li $21, 0
l2:
bnez $21, l3
lw $21, 0($19)
li $25, 0
sub $25, $21, $25
li $21, 1
bltz $25, l4
li $21, 0
l4:
l3:
andi $21, $21, 1
bnez $21, l1
lw $9, -4($sp)
lw $21, 0($9)
li $25, 0
sub $25, $21, $25
beqz $25, l1
lw $9, -4($sp)
lw $21, 0($9)
sub $21, $21, 1
mul $25, $21, 12
lw $9, 8($a3)
add $21, $9, $25
li $25, 0
mul $16, $25, 4
add $21, $21, $16
lw $21, 0($21)
lw $9, -4($sp)
lw $16, 0($9)
sub $16, $16, 1
mul $25, $16, 12
lw $9, 8($a3)
add $16, $9, $25
li $25, 1
mul $17, $25, 4
add $16, $16, $17
lw $16, 0($16)
add $21, $21, $16
lw $9, -4($sp)
lw $16, 0($9)
sub $16, $16, 1
mul $17, $16, 12
lw $9, 8($a3)
add $16, $9, $17
li $17, 2
mul $25, $17, 4
add $16, $16, $25
lw $16, 0($16)
add $21, $21, $16
li $16, 15
sub $16, $21, $16
bnez $16, l0
l1:
lw $9, -4($sp)
lw $16, 0($9)
li $17, 2
sub $17, $16, $17
bnez $17, l5
lw $16, 0($19)
li $17, 2
sub $17, $16, $17
bnez $17, l5
li $16, 2
mul $17, $16, 12
lw $9, 8($a3)
add $16, $9, $17
li $17, 2
mul $21, $17, 4
add $16, $16, $21
li $17, 45
lw $21, 0($20)
sub $17, $17, $21
sw $17, 0($16)
move $16, $22
li $17, 0
mul $21, $17, 12
lw $9, 8($a3)
add $17, $9, $21
li $21, 0
mul $25, $21, 4
add $17, $17, $25
lw $17, 0($17)
li $21, 0
mul $25, $21, 12
lw $9, 8($a3)
add $21, $9, $25
li $25, 1
mul $18, $25, 4
add $21, $21, $18
lw $21, 0($21)
add $17, $17, $21
li $18, 0
mul $21, $18, 12
lw $9, 8($a3)
add $18, $9, $21
li $21, 2
mul $25, $21, 4
add $18, $18, $25
lw $18, 0($18)
add $17, $17, $18
sw $17, 0($16)
li $16, 1
mul $17, $16, 12
lw $9, 8($a3)
add $16, $9, $17
li $17, 0
mul $18, $17, 4
add $16, $16, $18
lw $16, 0($16)
li $17, 1
mul $18, $17, 12
lw $9, 8($a3)
add $17, $9, $18
li $18, 1
mul $21, $18, 4
add $17, $17, $21
lw $17, 0($17)
add $16, $16, $17
li $17, 1
mul $18, $17, 12
lw $9, 8($a3)
add $17, $9, $18
li $18, 2
mul $21, $18, 4
add $17, $17, $21
lw $17, 0($17)
add $16, $16, $17
lw $17, 0($22)
sub $17, $16, $17
bnez $17, l7
li $16, 2
mul $17, $16, 12
lw $9, 8($a3)
add $16, $9, $17
li $17, 0
mul $18, $17, 4
add $16, $16, $18
lw $16, 0($16)
li $17, 2
mul $18, $17, 12
lw $9, 8($a3)
add $17, $9, $18
li $18, 1
mul $21, $18, 4
add $17, $17, $21
lw $17, 0($17)
add $16, $16, $17
li $17, 2
mul $18, $17, 12
lw $9, 8($a3)
add $17, $9, $18
li $18, 2
mul $21, $18, 4
add $17, $17, $21
lw $17, 0($17)
add $16, $16, $17
lw $17, 0($22)
sub $17, $16, $17
bnez $17, l7
li $16, 0
mul $17, $16, 12
lw $9, 8($a3)
add $16, $9, $17
li $17, 0
mul $18, $17, 4
add $16, $16, $18
lw $16, 0($16)
li $17, 1
mul $18, $17, 12
lw $9, 8($a3)
add $17, $9, $18
li $18, 0
mul $21, $18, 4
add $17, $17, $21
lw $17, 0($17)
add $16, $16, $17
li $17, 2
mul $18, $17, 12
lw $9, 8($a3)
add $17, $9, $18
li $18, 0
mul $21, $18, 4
add $17, $17, $21
lw $17, 0($17)
add $16, $16, $17
lw $17, 0($22)
sub $17, $16, $17
bnez $17, l7
li $16, 0
mul $17, $16, 12
lw $9, 8($a3)
add $16, $9, $17
li $17, 1
mul $18, $17, 4
add $16, $16, $18
lw $16, 0($16)
li $17, 1
mul $18, $17, 12
lw $9, 8($a3)
add $17, $9, $18
li $18, 1
mul $21, $18, 4
add $17, $17, $21
lw $17, 0($17)
add $16, $16, $17
li $17, 2
mul $18, $17, 12
lw $9, 8($a3)
add $17, $9, $18
li $18, 1
mul $21, $18, 4
add $17, $17, $21
lw $17, 0($17)
add $16, $16, $17
lw $17, 0($22)
sub $17, $16, $17
bnez $17, l7
li $16, 0
mul $17, $16, 12
lw $9, 8($a3)
add $16, $9, $17
li $17, 2
mul $18, $17, 4
add $16, $16, $18
lw $16, 0($16)
li $17, 1
mul $18, $17, 12
lw $9, 8($a3)
add $17, $9, $18
li $18, 2
mul $21, $18, 4
add $17, $17, $21
lw $17, 0($17)
add $16, $16, $17
li $17, 2
mul $18, $17, 12
lw $9, 8($a3)
add $17, $9, $18
li $18, 2
mul $21, $18, 4
add $17, $17, $21
lw $17, 0($17)
add $16, $16, $17
lw $17, 0($22)
sub $17, $16, $17
bnez $17, l7
li $16, 0
mul $17, $16, 12
lw $9, 8($a3)
add $16, $9, $17
li $17, 0
mul $18, $17, 4
add $16, $16, $18
lw $16, 0($16)
li $17, 1
mul $18, $17, 12
lw $9, 8($a3)
add $17, $9, $18
li $18, 1
mul $21, $18, 4
add $17, $17, $21
lw $17, 0($17)
add $16, $16, $17
li $17, 2
mul $18, $17, 12
lw $9, 8($a3)
add $17, $9, $18
li $18, 2
mul $21, $18, 4
add $17, $17, $21
lw $17, 0($17)
add $16, $16, $17
lw $17, 0($22)
sub $17, $16, $17
bnez $17, l7
li $16, 2
mul $17, $16, 12
lw $9, 8($a3)
add $16, $9, $17
li $17, 0
mul $18, $17, 4
add $16, $16, $18
lw $16, 0($16)
li $17, 1
mul $18, $17, 12
lw $9, 8($a3)
add $17, $9, $18
li $18, 1
mul $21, $18, 4
add $17, $17, $21
lw $17, 0($17)
add $16, $16, $17
li $17, 0
mul $18, $17, 12
lw $9, 8($a3)
add $17, $9, $18
li $18, 2
mul $21, $18, 4
add $17, $17, $21
lw $17, 0($17)
add $16, $16, $17
lw $17, 0($22)
sub $17, $16, $17
bnez $17, l7
li $16, 0
mul $17, $16, 4
lw $11, 16($a3)
add $16, $11, $17
li $17, 0
mul $18, $17, 4
add $17, $11, $18
lw $17, 0($17)
add $17, $17, 1
sw $17, 0($16)
move $11, $23
li $16, 0
sw $16, 0($11)
l8:
lw $11, 0($23)
li $16, 2
sub $16, $11, $16
bgtz $16, l9
move $11, $24
li $16, 0
sw $16, 0($11)
l11:
lw $11, 0($24)
li $16, 2
sub $16, $11, $16
bgtz $16, l12
sw $31, -1432($29)
lw $11, 0($23)
mul $16, $11, 12
lw $9, 8($a3)
add $11, $9, $16
lw $16, 0($24)
mul $17, $16, 4
add $11, $11, $17
add $16, $29, -1436
lw $11, 0($11)
sw $11, 0($16)
lw $14, 808($a3)
move $11, $14
add $16, $29, -1440
sw $11, 0($16)
add $29, $29, -1440
jal __printf
sub $29, $29, -1440
lw $31, -1432($29)
sw $31, -1432($29)
li $11, 32
add $16, $29, -1436
sw $11, 0($16)
lw $13, 832($a3)
move $11, $13
add $16, $29, -1440
sw $11, 0($16)
add $29, $29, -1440
jal __printf
sub $29, $29, -1440
lw $31, -1432($29)
l13:
move $11, $24
lw $16, 0($24)
add $17, $16, 1
sw $17, 0($11)
j l11
l12:
sw $31, -1432($29)
li $11, 10
add $16, $29, -1436
sw $11, 0($16)
lw $12, 868($a3)
move $11, $12
add $16, $29, -1440
sw $11, 0($16)
add $29, $29, -1440
jal __printf
sub $29, $29, -1440
lw $31, -1432($29)
l10:
move $11, $23
lw $16, 0($23)
add $17, $16, 1
sw $17, 0($11)
j l8
l9:
sw $31, -1432($29)
li $11, 10
add $12, $29, -1436
sw $11, 0($12)
lw $15, 904($a3)
move $11, $15
add $12, $29, -1440
sw $11, 0($12)
add $29, $29, -1440
jal __printf
sub $29, $29, -1440
lw $31, -1432($29)
l7:
j l6
l5:
lw $11, 0($19)
li $12, 2
sub $12, $11, $12
bnez $12, l14
lw $9, -4($sp)
lw $11, 0($9)
mul $12, $11, 12
lw $9, 8($a3)
add $11, $9, $12
lw $12, 0($19)
mul $13, $12, 4
add $11, $11, $13
li $12, 15
lw $9, -4($sp)
lw $13, 0($9)
mul $14, $13, 12
lw $9, 8($a3)
add $13, $9, $14
li $14, 0
mul $15, $14, 4
add $13, $13, $15
lw $13, 0($13)
sub $12, $12, $13
lw $9, -4($sp)
lw $13, 0($9)
mul $14, $13, 12
lw $9, 8($a3)
add $13, $9, $14
li $14, 1
mul $15, $14, 4
add $13, $13, $15
lw $13, 0($13)
sub $12, $12, $13
sw $12, 0($11)
lw $9, -4($sp)
lw $11, 0($9)
mul $12, $11, 12
lw $9, 8($a3)
add $11, $9, $12
lw $12, 0($19)
mul $13, $12, 4
add $11, $11, $13
lw $11, 0($11)
li $12, 0
sub $12, $11, $12
blez $12, l16
lw $9, -4($sp)
lw $11, 0($9)
mul $12, $11, 12
lw $9, 8($a3)
add $11, $9, $12
lw $12, 0($19)
mul $13, $12, 4
add $11, $11, $13
lw $11, 0($11)
li $12, 10
sub $12, $11, $12
bgez $12, l16
lw $9, -4($sp)
lw $11, 0($9)
mul $12, $11, 12
lw $9, 8($a3)
add $11, $9, $12
lw $12, 0($19)
mul $13, $12, 4
add $11, $11, $13
lw $11, 0($11)
mul $12, $11, 4
lw $9, 12($a3)
add $11, $9, $12
lw $11, 0($11)
li $12, 0
sub $12, $11, $12
bnez $12, l16
lw $9, -4($sp)
lw $11, 0($9)
mul $12, $11, 12
lw $9, 8($a3)
add $11, $9, $12
lw $12, 0($19)
mul $13, $12, 4
add $11, $11, $13
lw $11, 0($11)
mul $12, $11, 4
lw $9, 12($a3)
add $11, $9, $12
li $12, 1
sw $12, 0($11)
lw $11, 0($19)
li $12, 2
sub $12, $11, $12
bnez $12, l17
sw $31, -1436($29)
lw $11, 0($20)
lw $9, -4($sp)
lw $12, 0($9)
mul $13, $12, 12
lw $9, 8($a3)
add $12, $9, $13
lw $13, 0($19)
mul $14, $13, 4
add $12, $12, $14
lw $12, 0($12)
add $11, $11, $12
add $12, $29, -1440
sw $11, 0($12)
li $11, 0
add $12, $29, -1444
sw $11, 0($12)
lw $9, -4($sp)
lw $11, 0($9)
add $11, $11, 1
add $12, $29, -1448
sw $11, 0($12)
add $29, $29, -1448
sw $19, 1440($sp)
sw $20, 1436($sp)
sw $23, 1424($sp)
sw $24, 1416($sp)
jal __search
lw $19, 1440($sp)
lw $20, 1436($sp)
lw $23, 1424($sp)
lw $24, 1416($sp)
sub $29, $29, -1448
lw $31, -1436($29)
add $11, $29, -1432
move $12, $11
j l18
l17:
sw $31, -1436($29)
lw $11, 0($20)
lw $9, -4($sp)
lw $12, 0($9)
mul $13, $12, 12
lw $9, 8($a3)
add $12, $9, $13
lw $13, 0($19)
mul $14, $13, 4
add $12, $12, $14
lw $12, 0($12)
add $11, $11, $12
add $12, $29, -1440
sw $11, 0($12)
lw $11, 0($19)
add $11, $11, 1
add $12, $29, -1444
sw $11, 0($12)
add $11, $29, -1448
lw $9, -4($sp)
lw $12, 0($9)
sw $12, 0($11)
add $29, $29, -1448
sw $19, 1440($sp)
sw $20, 1436($sp)
sw $23, 1424($sp)
sw $24, 1416($sp)
jal __search
lw $19, 1440($sp)
lw $20, 1436($sp)
lw $23, 1424($sp)
lw $24, 1416($sp)
sub $29, $29, -1448
lw $31, -1436($29)
add $11, $29, -1432
move $12, $11
l18:
lw $9, -4($sp)
lw $11, 0($9)
mul $12, $11, 12
lw $9, 8($a3)
add $11, $9, $12
lw $12, 0($19)
mul $13, $12, 4
add $11, $11, $13
lw $11, 0($11)
mul $12, $11, 4
lw $9, 12($a3)
add $11, $9, $12
li $12, 0
sw $12, 0($11)
l16:
j l15
l14:
move $11, $23
li $12, 1
sw $12, 0($11)
l19:
lw $11, 0($23)
li $12, 9
sub $12, $11, $12
bgtz $12, l20
lw $11, 0($23)
mul $12, $11, 4
lw $9, 12($a3)
add $11, $9, $12
lw $11, 0($11)
li $12, 0
sub $12, $11, $12
bnez $12, l22
lw $11, 0($23)
mul $12, $11, 4
lw $9, 12($a3)
add $11, $9, $12
li $12, 1
sw $12, 0($11)
lw $9, -4($sp)
lw $11, 0($9)
mul $12, $11, 12
lw $9, 8($a3)
add $11, $9, $12
lw $12, 0($19)
mul $13, $12, 4
add $11, $11, $13
lw $12, 0($23)
sw $12, 0($11)
lw $11, 0($19)
li $12, 2
sub $12, $11, $12
bnez $12, l23
sw $31, -1436($29)
lw $11, 0($20)
lw $12, 0($23)
add $11, $11, $12
add $12, $29, -1440
sw $11, 0($12)
li $11, 0
add $12, $29, -1444
sw $11, 0($12)
lw $9, -4($sp)
lw $11, 0($9)
add $11, $11, 1
add $12, $29, -1448
sw $11, 0($12)
add $29, $29, -1448
sw $19, 1440($sp)
sw $20, 1436($sp)
sw $23, 1424($sp)
sw $24, 1416($sp)
jal __search
lw $19, 1440($sp)
lw $20, 1436($sp)
lw $23, 1424($sp)
lw $24, 1416($sp)
sub $29, $29, -1448
lw $31, -1436($29)
add $11, $29, -1432
move $12, $11
j l24
l23:
sw $31, -1436($29)
lw $11, 0($20)
lw $12, 0($23)
add $11, $11, $12
add $12, $29, -1440
sw $11, 0($12)
lw $11, 0($19)
add $11, $11, 1
add $12, $29, -1444
sw $11, 0($12)
add $11, $29, -1448
lw $9, -4($sp)
lw $12, 0($9)
sw $12, 0($11)
add $29, $29, -1448
sw $19, 1440($sp)
sw $20, 1436($sp)
sw $23, 1424($sp)
sw $24, 1416($sp)
jal __search
lw $19, 1440($sp)
lw $20, 1436($sp)
lw $23, 1424($sp)
lw $24, 1416($sp)
sub $29, $29, -1448
lw $31, -1436($29)
add $11, $29, -1432
move $12, $11
l24:
lw $9, -4($sp)
lw $11, 0($9)
mul $12, $11, 12
lw $9, 8($a3)
add $11, $9, $12
lw $12, 0($19)
mul $13, $12, 4
add $11, $11, $13
li $12, 0
sw $12, 0($11)
lw $11, 0($23)
mul $12, $11, 4
lw $9, 12($a3)
add $11, $9, $12
li $12, 0
sw $12, 0($11)
l22:
l21:
move $11, $23
lw $12, 0($23)
add $13, $12, 1
sw $13, 0($11)
j l19
l20:
l15:
l6:
l0:
jr $ra
main:
la $a3, temp
la $t0, var0
sw $t0, 8($a3)
la $t0, var1
sw $t0, 12($a3)
la $t0, var2
sw $t0, 16($a3)
la $t0, var3
sw $t0, 20($a3)
la $t0, var4
sw $t0, 24($a3)
la $t0, var5
sw $t0, 808($a3)
la $t0, var6
sw $t0, 832($a3)
la $t0, var7
sw $t0, 868($a3)
la $t0, var8
sw $t0, 904($a3)
la $t0, var9
sw $t0, 1516($a3)
li $11, 0
add $14, $29, -80
sw $11, 0($14)
li $11, 0
add $14, $29, -84
sw $11, 0($14)
li $11, 0
add $14, $29, -88
sw $11, 0($14)
add $29, $29, -88
jal __search
sub $29, $29, -88
add $11, $29, -72
li $11, 0
mul $14, $11, 4
lw $12, 16($a3)
add $11, $12, $14
add $12, $29, -76
lw $11, 0($11)
sw $11, 0($12)
lw $13, 1516($a3)
move $11, $13
add $12, $29, -80
sw $11, 0($12)
add $29, $29, -80
jal __printf
sub $29, $29, -80
li $11, 0
add $12, $29, 4
sw $11, 0($12)
j __main_end
j __main_end
__main_end:
li $v0, 10
syscall
