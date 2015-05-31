.data
temp: .space 900
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
var13: .space 32
var14: .space 36
var15: .space 44944
var16: .space 4
var17: .space 4
var18: .asciiz "%d\n"
.align 2
var19: .asciiz "no solution!\n"
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
add $12, $29, 0
lw $13, 0($12)
lw $11, 8($a3)
lw $14, 0($11)
sub $14, $13, $14
li $13, 1
bltz $14, l0
li $13, 0
l0:
beqz $13, l1
lw $13, 0($12)
li $11, 0
sub $11, $13, $11
li $13, 1
bgez $11, l2
li $13, 0
l2:
l1:
andi $13, $13, 1
add $11, $29, 8
sw $13, 0($11)
jr $ra
jr $ra
__addList:
add $16, $29, 0
add $20, $29, 4
sw $31, -176($29)
add $21, $29, -180
lw $22, 0($16)
sw $22, 0($21)
add $29, $29, -180
sw $16, 176($sp)
sw $20, 172($sp)
jal __check
lw $16, 176($sp)
lw $20, 172($sp)
sub $29, $29, -180
lw $31, -176($29)
add $21, $29, -172
lw $22, 0($21)
li $21, 1
sub $21, $22, $21
bnez $21, l3
sw $31, -176($29)
add $21, $29, -180
lw $22, 0($20)
sw $22, 0($21)
add $29, $29, -180
sw $16, 176($sp)
sw $20, 172($sp)
jal __check
lw $16, 176($sp)
lw $20, 172($sp)
sub $29, $29, -180
lw $31, -176($29)
add $21, $29, -172
lw $22, 0($21)
li $21, 1
sub $21, $22, $21
bnez $21, l3
lw $21, 0($16)
mul $22, $21, 424
lw $14, 68($a3)
add $21, $14, $22
lw $22, 0($20)
mul $23, $22, 4
add $21, $21, $23
lw $21, 0($21)
li $22, -1
sub $22, $21, $22
bnez $22, l3
lw $12, 48($a3)
move $21, $12
lw $22, 0($12)
add $23, $22, 1
sw $23, 0($21)
lw $21, 0($12)
mul $22, $21, 4
lw $11, 40($a3)
add $21, $11, $22
lw $11, 0($16)
sw $11, 0($21)
lw $11, 0($12)
mul $12, $11, 4
lw $13, 44($a3)
add $11, $13, $12
lw $12, 0($20)
sw $12, 0($11)
lw $11, 0($16)
mul $12, $11, 424
add $11, $14, $12
lw $12, 0($20)
mul $13, $12, 4
add $11, $11, $13
lw $15, 56($a3)
lw $12, 0($15)
add $12, $12, 1
sw $12, 0($11)
lw $11, 0($16)
lw $17, 24($a3)
lw $12, 0($17)
sub $12, $11, $12
li $11, 1
beqz $12, l5
li $11, 0
l5:
beqz $11, l4
lw $11, 0($20)
lw $18, 28($a3)
lw $12, 0($18)
sub $12, $11, $12
li $11, 1
beqz $12, l6
li $11, 0
l6:
beqz $11, l4
lw $19, 52($a3)
move $11, $19
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
sw $t0, 72($a3)
la $t0, var17
sw $t0, 76($a3)
la $t0, var18
sw $t0, 868($a3)
la $t0, var19
sw $t0, 884($a3)
lw $13, 8($a3)
move $11, $13
li $25, 100
add $29, $29, -632
sw $11, 628($sp)
sw $13, 8($a3)
sw $25, 624($sp)
jal __getchar
lw $11, 628($sp)
lw $13, 8($a3)
lw $25, 624($sp)
sub $29, $29, -632
add $24, $29, -628
lw $14, 0($24)
sub $14, $14, 48
mul $25, $25, $14
li $14, 10
add $29, $29, -632
sw $11, 628($sp)
sw $13, 8($a3)
sw $14, 608($sp)
sw $25, 624($sp)
jal __getchar
lw $11, 628($sp)
lw $13, 8($a3)
lw $14, 608($sp)
lw $25, 624($sp)
sub $29, $29, -632
add $24, $29, -628
lw $15, 0($24)
sub $15, $15, 48
mul $14, $14, $15
add $25, $25, $14
add $29, $29, -632
sw $11, 628($sp)
sw $13, 8($a3)
sw $25, 624($sp)
jal __getchar
lw $11, 628($sp)
lw $13, 8($a3)
lw $25, 624($sp)
sub $29, $29, -632
add $14, $29, -628
lw $15, 0($14)
add $25, $25, $15
sub $25, $25, 48
sw $25, 0($11)
lw $9, 24($a3)
move $11, $9
lw $9, 28($a3)
move $14, $9
lw $15, 0($13)
sub $15, $15, 1
sw $15, 0($14)
lw $14, 0($14)
sw $14, 0($11)
lw $12, 72($a3)
move $11, $12
li $14, 0
sw $14, 0($11)
l7:
lw $11, 0($12)
lw $14, 0($13)
sub $14, $11, $14
bgez $14, l8
lw $23, 76($a3)
move $11, $23
li $14, 0
sw $14, 0($11)
l10:
lw $11, 0($23)
lw $14, 0($13)
sub $14, $11, $14
bgez $14, l11
lw $11, 0($12)
mul $14, $11, 424
lw $9, 68($a3)
add $11, $9, $14
lw $14, 0($23)
mul $15, $14, 4
add $11, $11, $15
li $14, -1
sw $14, 0($11)
l12:
move $11, $23
lw $14, 0($23)
add $15, $14, 1
sw $15, 0($11)
j l10
l11:
l9:
move $11, $12
lw $14, 0($12)
add $15, $14, 1
sw $15, 0($11)
j l7
l8:
li $11, 0
mul $12, $11, 4
lw $22, 60($a3)
add $11, $22, $12
li $12, -2
sw $12, 0($11)
li $11, 0
mul $12, $11, 4
lw $21, 64($a3)
add $11, $21, $12
li $12, -1
sw $12, 0($11)
li $11, 1
mul $12, $11, 4
add $11, $22, $12
li $12, -2
sw $12, 0($11)
li $11, 1
mul $12, $11, 4
add $11, $21, $12
li $12, 1
sw $12, 0($11)
li $11, 2
mul $12, $11, 4
add $11, $22, $12
li $12, 2
sw $12, 0($11)
li $11, 2
mul $12, $11, 4
add $11, $21, $12
li $12, -1
sw $12, 0($11)
li $11, 3
mul $12, $11, 4
add $11, $22, $12
li $12, 2
sw $12, 0($11)
li $11, 3
mul $12, $11, 4
add $11, $21, $12
li $12, 1
sw $12, 0($11)
li $11, 4
mul $12, $11, 4
add $11, $22, $12
li $12, -1
sw $12, 0($11)
li $11, 4
mul $12, $11, 4
add $11, $21, $12
li $12, -2
sw $12, 0($11)
li $11, 5
mul $12, $11, 4
add $11, $22, $12
li $12, -1
sw $12, 0($11)
li $11, 5
mul $12, $11, 4
add $11, $21, $12
li $12, 2
sw $12, 0($11)
li $11, 6
mul $12, $11, 4
add $11, $22, $12
li $12, 1
sw $12, 0($11)
li $11, 6
mul $12, $11, 4
add $11, $21, $12
li $12, -2
sw $12, 0($11)
li $11, 7
mul $12, $11, 4
add $11, $22, $12
li $12, 1
sw $12, 0($11)
li $11, 7
mul $12, $11, 4
add $11, $21, $12
li $12, 2
sw $12, 0($11)
l13:
lw $20, 12($a3)
lw $11, 0($20)
lw $19, 48($a3)
lw $12, 0($19)
sub $12, $11, $12
bgtz $12, l14
lw $18, 32($a3)
move $11, $18
lw $12, 0($20)
mul $13, $12, 4
lw $17, 40($a3)
add $12, $17, $13
lw $12, 0($12)
sw $12, 0($11)
lw $16, 36($a3)
move $11, $16
lw $12, 0($20)
mul $13, $12, 4
lw $9, 44($a3)
add $12, $9, $13
lw $12, 0($12)
sw $12, 0($11)
lw $9, 56($a3)
move $11, $9
lw $12, 0($18)
mul $13, $12, 424
lw $9, 68($a3)
add $12, $9, $13
lw $13, 0($16)
mul $14, $13, 4
add $12, $12, $14
lw $12, 0($12)
sw $12, 0($11)
move $11, $23
li $12, 0
sw $12, 0($11)
l15:
lw $11, 0($23)
li $12, 8
sub $12, $11, $12
bgez $12, l16
lw $11, 0($16)
lw $12, 0($23)
mul $13, $12, 4
add $12, $21, $13
lw $12, 0($12)
add $11, $11, $12
add $12, $29, -636
sw $11, 0($12)
lw $11, 0($18)
lw $12, 0($23)
mul $13, $12, 4
add $12, $22, $13
lw $12, 0($12)
add $11, $11, $12
add $12, $29, -640
sw $11, 0($12)
add $29, $29, -640
sw $16, 36($a3)
sw $17, 40($a3)
sw $18, 32($a3)
sw $19, 48($a3)
sw $20, 12($a3)
sw $21, 64($a3)
sw $22, 60($a3)
sw $23, 76($a3)
jal __addList
lw $16, 36($a3)
lw $17, 40($a3)
lw $18, 32($a3)
lw $19, 48($a3)
lw $20, 12($a3)
lw $21, 64($a3)
lw $22, 60($a3)
lw $23, 76($a3)
sub $29, $29, -640
add $11, $29, -628
move $12, $11
l17:
move $11, $23
lw $12, 0($23)
add $13, $12, 1
sw $13, 0($11)
j l15
l16:
lw $9, 52($a3)
lw $11, 0($9)
li $12, 1
sub $12, $11, $12
bnez $12, l18
j l14
l18:
move $11, $20
lw $12, 0($20)
add $13, $12, 1
sw $13, 0($11)
j l13
l14:
lw $9, 52($a3)
lw $11, 0($9)
li $12, 1
sub $12, $11, $12
bnez $12, l19
lw $9, 24($a3)
lw $11, 0($9)
mul $12, $11, 424
lw $9, 68($a3)
add $11, $9, $12
lw $9, 28($a3)
lw $12, 0($9)
mul $13, $12, 4
add $11, $11, $13
add $12, $29, -632
lw $11, 0($11)
sw $11, 0($12)
lw $9, 868($a3)
move $11, $9
add $12, $29, -636
sw $11, 0($12)
add $29, $29, -636
jal __printf
sub $29, $29, -636
j l20
l19:
lw $9, 884($a3)
move $11, $9
add $12, $29, -632
sw $11, 0($12)
add $29, $29, -632
jal __printf_single
sub $29, $29, -632
l20:
li $11, 0
add $12, $29, 4
sw $11, 0($12)
j __main_end
j __main_end
__main_end:
li $v0, 10
syscall
