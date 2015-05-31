.data
temp: .space 836
var0: .space 4
var1: .space 4
var2: .space 4
var3: .space 4
var4: .space 4
var5: .space 4
var6: .space 4
var7: .space 4
var8: .space 48000
var9: .space 48000
var10: .space 4
var11: .space 4
var12: .space 4
var13: .space 44944
var14: .space 4
var15: .space 4
var16: .asciiz "%d\n"
.align 2
var17: .asciiz "no solution!\n"
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

__check:
add $11, $29, 0
add $12, $29, 4
lw $13, 0($11)
lw $14, 0($12)
sub $14, $13, $14
li $13, 1
bltz $14, l0
li $13, 0
l0:
beqz $13, l1
lw $13, 0($11)
li $11, 0
sub $11, $13, $11
li $13, 1
bgez $11, l2
li $13, 0
l2:
l1:
andi $13, $13, 1
add $11, $29, 12
sw $13, 0($11)
jr $ra
jr $ra
__addList:
add $17, $29, 0
add $21, $29, 4
sw $31, -192($29)
add $22, $29, -196
lw $11, 8($a3)
lw $23, 0($11)
sw $23, 0($22)
add $22, $29, -200
lw $23, 0($17)
sw $23, 0($22)
add $29, $29, -200
sw $11, 8($a3)
sw $17, 196($sp)
sw $21, 192($sp)
jal __check
lw $11, 8($a3)
lw $17, 196($sp)
lw $21, 192($sp)
sub $29, $29, -200
lw $31, -192($29)
add $22, $29, -188
lw $23, 0($22)
li $22, 1
sub $22, $23, $22
bnez $22, l3
sw $31, -192($29)
add $22, $29, -196
lw $23, 0($11)
sw $23, 0($22)
add $11, $29, -200
lw $22, 0($21)
sw $22, 0($11)
add $29, $29, -200
sw $17, 196($sp)
sw $21, 192($sp)
jal __check
lw $17, 196($sp)
lw $21, 192($sp)
sub $29, $29, -200
lw $31, -192($29)
add $11, $29, -188
lw $22, 0($11)
li $11, 1
sub $11, $22, $11
bnez $11, l3
lw $11, 0($17)
mul $22, $11, 424
lw $15, 60($a3)
add $11, $15, $22
lw $22, 0($21)
mul $23, $22, 4
add $11, $11, $23
lw $11, 0($11)
li $22, -1
sub $22, $11, $22
bnez $22, l3
lw $13, 48($a3)
move $11, $13
lw $22, 0($13)
add $22, $22, 1
sw $22, 0($11)
lw $11, 0($13)
mul $22, $11, 4
lw $12, 40($a3)
add $11, $12, $22
lw $12, 0($17)
sw $12, 0($11)
lw $11, 0($13)
mul $12, $11, 4
lw $14, 44($a3)
add $11, $14, $12
lw $12, 0($21)
sw $12, 0($11)
lw $11, 0($17)
mul $12, $11, 424
add $11, $15, $12
lw $12, 0($21)
mul $13, $12, 4
add $11, $11, $13
lw $16, 56($a3)
lw $12, 0($16)
add $12, $12, 1
sw $12, 0($11)
lw $11, 0($17)
lw $18, 24($a3)
lw $12, 0($18)
sub $12, $11, $12
li $11, 1
beqz $12, l5
li $11, 0
l5:
beqz $11, l4
lw $11, 0($21)
lw $19, 28($a3)
lw $12, 0($19)
sub $12, $11, $12
li $11, 1
beqz $12, l6
li $11, 0
l6:
beqz $11, l4
lw $20, 52($a3)
move $11, $20
li $12, 1
sw $12, 0($11)
l4:
l3:
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
sw $t0, 28($a3)
la $t0, var6
sw $t0, 32($a3)
la $t0, var7
sw $t0, 36($a3)
la $t0, var8
sw $t0, 40($a3)
la $t0, var9
sw $t0, 44($a3)
la $t0, var10
sw $t0, 48($a3)
la $t0, var11
sw $t0, 52($a3)
la $t0, var12
sw $t0, 56($a3)
la $t0, var13
sw $t0, 60($a3)
la $t0, var14
sw $t0, 64($a3)
la $t0, var15
sw $t0, 68($a3)
la $t0, var16
sw $t0, 804($a3)
la $t0, var17
sw $t0, 820($a3)
lw $14, 8($a3)
move $11, $14
li $25, 100
add $29, $29, -556
sw $11, 552($sp)
sw $14, 8($a3)
sw $25, 548($sp)
jal __getchar
lw $11, 552($sp)
lw $14, 8($a3)
lw $25, 548($sp)
sub $29, $29, -556
add $24, $29, -552
lw $23, 0($24)
sub $23, $23, 48
mul $25, $25, $23
li $23, 10
add $29, $29, -556
sw $11, 552($sp)
sw $14, 8($a3)
sw $23, 532($sp)
sw $25, 548($sp)
jal __getchar
lw $11, 552($sp)
lw $14, 8($a3)
lw $23, 532($sp)
lw $25, 548($sp)
sub $29, $29, -556
add $24, $29, -552
lw $22, 0($24)
sub $22, $22, 48
mul $23, $23, $22
add $25, $25, $23
add $29, $29, -556
sw $11, 552($sp)
sw $14, 8($a3)
sw $25, 548($sp)
jal __getchar
lw $11, 552($sp)
lw $14, 8($a3)
lw $25, 548($sp)
sub $29, $29, -556
add $22, $29, -552
lw $23, 0($22)
add $25, $25, $23
sub $25, $25, 48
sw $25, 0($11)
lw $9, 24($a3)
move $11, $9
lw $9, 28($a3)
move $22, $9
lw $23, 0($14)
sub $23, $23, 1
sw $23, 0($22)
lw $22, 0($22)
sw $22, 0($11)
lw $13, 64($a3)
move $11, $13
li $22, 0
sw $22, 0($11)
l7:
lw $11, 0($13)
lw $22, 0($14)
sub $22, $11, $22
bgez $22, l8
lw $12, 68($a3)
move $11, $12
li $22, 0
sw $22, 0($11)
l10:
lw $11, 0($12)
lw $22, 0($14)
sub $22, $11, $22
bgez $22, l11
lw $11, 0($13)
mul $22, $11, 424
lw $9, 60($a3)
add $11, $9, $22
lw $22, 0($12)
mul $23, $22, 4
add $11, $11, $23
li $22, -1
sw $22, 0($11)
l12:
move $11, $12
lw $22, 0($12)
add $23, $22, 1
sw $23, 0($11)
j l10
l11:
l9:
move $11, $13
lw $22, 0($13)
add $23, $22, 1
sw $23, 0($11)
j l7
l8:
l13:
lw $21, 12($a3)
lw $11, 0($21)
lw $20, 48($a3)
lw $12, 0($20)
sub $12, $11, $12
bgtz $12, l14
lw $19, 32($a3)
move $11, $19
lw $12, 0($21)
mul $13, $12, 4
lw $18, 40($a3)
add $12, $18, $13
lw $12, 0($12)
sw $12, 0($11)
lw $17, 36($a3)
move $11, $17
lw $12, 0($21)
mul $13, $12, 4
lw $16, 44($a3)
add $12, $16, $13
lw $12, 0($12)
sw $12, 0($11)
lw $15, 56($a3)
move $11, $15
lw $12, 0($19)
mul $13, $12, 424
lw $9, 60($a3)
add $12, $9, $13
lw $13, 0($17)
mul $14, $13, 4
add $12, $12, $14
lw $12, 0($12)
sw $12, 0($11)
lw $11, 0($17)
sub $11, $11, 2
add $12, $29, -560
sw $11, 0($12)
lw $11, 0($19)
sub $11, $11, 1
add $12, $29, -564
sw $11, 0($12)
add $29, $29, -564
sw $15, 56($a3)
sw $16, 44($a3)
sw $17, 36($a3)
sw $18, 40($a3)
sw $19, 32($a3)
sw $20, 48($a3)
sw $21, 12($a3)
jal __addList
lw $15, 56($a3)
lw $16, 44($a3)
lw $17, 36($a3)
lw $18, 40($a3)
lw $19, 32($a3)
lw $20, 48($a3)
lw $21, 12($a3)
sub $29, $29, -564
add $11, $29, -552
move $12, $11
lw $11, 0($17)
add $11, $11, 2
add $12, $29, -560
sw $11, 0($12)
lw $11, 0($19)
sub $11, $11, 1
add $12, $29, -564
sw $11, 0($12)
add $29, $29, -564
sw $15, 56($a3)
sw $16, 44($a3)
sw $17, 36($a3)
sw $18, 40($a3)
sw $19, 32($a3)
sw $20, 48($a3)
sw $21, 12($a3)
jal __addList
lw $15, 56($a3)
lw $16, 44($a3)
lw $17, 36($a3)
lw $18, 40($a3)
lw $19, 32($a3)
lw $20, 48($a3)
lw $21, 12($a3)
sub $29, $29, -564
add $11, $29, -552
move $12, $11
lw $11, 0($17)
sub $11, $11, 2
add $12, $29, -560
sw $11, 0($12)
lw $11, 0($19)
add $11, $11, 1
add $12, $29, -564
sw $11, 0($12)
add $29, $29, -564
sw $15, 56($a3)
sw $16, 44($a3)
sw $17, 36($a3)
sw $18, 40($a3)
sw $19, 32($a3)
sw $20, 48($a3)
sw $21, 12($a3)
jal __addList
lw $15, 56($a3)
lw $16, 44($a3)
lw $17, 36($a3)
lw $18, 40($a3)
lw $19, 32($a3)
lw $20, 48($a3)
lw $21, 12($a3)
sub $29, $29, -564
add $11, $29, -552
move $12, $11
lw $11, 0($17)
add $11, $11, 2
add $12, $29, -560
sw $11, 0($12)
lw $11, 0($19)
add $11, $11, 1
add $12, $29, -564
sw $11, 0($12)
add $29, $29, -564
sw $15, 56($a3)
sw $16, 44($a3)
sw $17, 36($a3)
sw $18, 40($a3)
sw $19, 32($a3)
sw $20, 48($a3)
sw $21, 12($a3)
jal __addList
lw $15, 56($a3)
lw $16, 44($a3)
lw $17, 36($a3)
lw $18, 40($a3)
lw $19, 32($a3)
lw $20, 48($a3)
lw $21, 12($a3)
sub $29, $29, -564
add $11, $29, -552
move $12, $11
lw $11, 0($17)
sub $11, $11, 1
add $12, $29, -560
sw $11, 0($12)
lw $11, 0($19)
sub $11, $11, 2
add $12, $29, -564
sw $11, 0($12)
add $29, $29, -564
sw $15, 56($a3)
sw $16, 44($a3)
sw $17, 36($a3)
sw $18, 40($a3)
sw $19, 32($a3)
sw $20, 48($a3)
sw $21, 12($a3)
jal __addList
lw $15, 56($a3)
lw $16, 44($a3)
lw $17, 36($a3)
lw $18, 40($a3)
lw $19, 32($a3)
lw $20, 48($a3)
lw $21, 12($a3)
sub $29, $29, -564
add $11, $29, -552
move $12, $11
lw $11, 0($17)
add $11, $11, 1
add $12, $29, -560
sw $11, 0($12)
lw $11, 0($19)
sub $11, $11, 2
add $12, $29, -564
sw $11, 0($12)
add $29, $29, -564
sw $15, 56($a3)
sw $16, 44($a3)
sw $17, 36($a3)
sw $18, 40($a3)
sw $19, 32($a3)
sw $20, 48($a3)
sw $21, 12($a3)
jal __addList
lw $15, 56($a3)
lw $16, 44($a3)
lw $17, 36($a3)
lw $18, 40($a3)
lw $19, 32($a3)
lw $20, 48($a3)
lw $21, 12($a3)
sub $29, $29, -564
add $11, $29, -552
move $12, $11
lw $11, 0($17)
sub $11, $11, 1
add $12, $29, -560
sw $11, 0($12)
lw $11, 0($19)
add $11, $11, 2
add $12, $29, -564
sw $11, 0($12)
add $29, $29, -564
sw $15, 56($a3)
sw $16, 44($a3)
sw $17, 36($a3)
sw $18, 40($a3)
sw $19, 32($a3)
sw $20, 48($a3)
sw $21, 12($a3)
jal __addList
lw $15, 56($a3)
lw $16, 44($a3)
lw $17, 36($a3)
lw $18, 40($a3)
lw $19, 32($a3)
lw $20, 48($a3)
lw $21, 12($a3)
sub $29, $29, -564
add $11, $29, -552
move $12, $11
lw $11, 0($17)
add $11, $11, 1
add $12, $29, -560
sw $11, 0($12)
lw $11, 0($19)
add $11, $11, 2
add $12, $29, -564
sw $11, 0($12)
add $29, $29, -564
sw $15, 56($a3)
sw $16, 44($a3)
sw $17, 36($a3)
sw $18, 40($a3)
sw $19, 32($a3)
sw $20, 48($a3)
sw $21, 12($a3)
jal __addList
lw $15, 56($a3)
lw $16, 44($a3)
lw $17, 36($a3)
lw $18, 40($a3)
lw $19, 32($a3)
lw $20, 48($a3)
lw $21, 12($a3)
sub $29, $29, -564
add $11, $29, -552
move $12, $11
lw $9, 52($a3)
lw $11, 0($9)
li $12, 1
sub $12, $11, $12
bnez $12, l15
j l14
l15:
move $11, $21
lw $12, 0($21)
add $12, $12, 1
sw $12, 0($11)
j l13
l14:
lw $9, 52($a3)
lw $11, 0($9)
li $12, 1
sub $12, $11, $12
bnez $12, l16
lw $9, 24($a3)
lw $11, 0($9)
mul $12, $11, 424
lw $9, 60($a3)
add $11, $9, $12
lw $9, 28($a3)
lw $12, 0($9)
mul $13, $12, 4
add $11, $11, $13
add $12, $29, -556
lw $11, 0($11)
sw $11, 0($12)
lw $9, 804($a3)
move $11, $9
add $12, $29, -560
sw $11, 0($12)
add $29, $29, -560
jal __printf
sub $29, $29, -560
j l17
l16:
lw $9, 820($a3)
move $11, $9
add $12, $29, -556
sw $11, 0($12)
add $29, $29, -556
jal __printf_single
sub $29, $29, -556
l17:
li $11, 0
add $12, $29, 4
sw $11, 0($12)
j __main_end
j __main_end
__main_end:
li $v0, 10
syscall
