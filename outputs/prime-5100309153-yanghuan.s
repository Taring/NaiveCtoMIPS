.data
temp: .space 1384
var0: .space 4
var1: .space 4
var2: .space 4
var3: .space 4
var4: .space 4
var5: .space 4
var6: .space 4004
var7: .space 680
var8: .space 4004
var9: .space 4
var10: .space 115600
var11: .asciiz "%d"
.align 2
var12: .asciiz "%c"
.align 2
var13: .asciiz "%d"
.align 2
var14: .asciiz "%c"
.align 2
var15: .asciiz "Total: %d\n"
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

__getPrime:
add $11, $29, 0
add $12, $29, 4
add $13, $29, 8
add $14, $29, 12
add $15, $29, 16
add $16, $29, -220
move $17, $16
add $18, $29, -224
move $19, $18
move $20, $16
li $16, 2
sw $16, 0($20)
move $16, $18
li $18, 2
sw $18, 0($16)
l0:
lw $16, 0($19)
lw $18, 0($11)
sub $18, $16, $18
bgtz $18, l1
lw $16, 0($13)
lw $18, 0($19)
mul $20, $18, 4
add $16, $16, $20
lw $16, 0($16)
li $18, 1
sub $18, $16, $18
bnez $18, l3
lw $16, 0($12)
li $18, 0
mul $20, $18, 4
add $16, $16, $20
lw $18, 0($12)
li $20, 0
mul $21, $20, 4
add $18, $18, $21
lw $18, 0($18)
add $18, $18, 1
sw $18, 0($16)
lw $16, 0($15)
lw $18, 0($12)
li $20, 0
mul $21, $20, 4
add $18, $18, $21
lw $18, 0($18)
mul $20, $18, 4
add $16, $16, $20
lw $18, 0($19)
sw $18, 0($16)
lw $16, 0($14)
lw $18, 0($19)
mul $20, $18, 4
add $16, $16, $20
lw $18, 0($12)
li $20, 0
mul $21, $20, 4
add $18, $18, $21
lw $18, 0($18)
sw $18, 0($16)
l3:
l4:
lw $16, 0($19)
lw $18, 0($17)
mul $16, $16, $18
lw $18, 0($11)
sub $18, $16, $18
bgtz $18, l5
lw $16, 0($13)
lw $18, 0($19)
lw $20, 0($17)
mul $18, $18, $20
mul $20, $18, 4
add $16, $16, $20
li $18, 0
sw $18, 0($16)
move $16, $17
lw $18, 0($17)
add $18, $18, 1
sw $18, 0($16)
j l4
l5:
move $16, $17
li $18, 2
sw $18, 0($16)
l2:
move $16, $19
lw $18, 0($19)
add $18, $18, 1
sw $18, 0($16)
j l0
l1:
jr $ra
__getResult:
add $11, $29, 0
add $12, $29, 4
add $13, $29, 8
add $14, $29, 12
add $15, $29, 16
add $16, $29, 20
add $17, $29, 24
lw $18, 0($17)
lw $19, 0($12)
mul $20, $19, 680
add $18, $18, $20
lw $19, 0($13)
mul $20, $19, 4
add $18, $18, $20
lw $18, 0($18)
li $19, -1
sub $19, $18, $19
bnez $19, l6
lw $18, 0($16)
lw $19, 0($13)
mul $20, $19, 4
add $18, $18, $20
lw $18, 0($18)
mul $18, $18, 2
lw $19, 0($16)
lw $20, 0($12)
mul $21, $20, 4
add $19, $19, $21
lw $19, 0($19)
sub $18, $18, $19
lw $19, 0($11)
sub $19, $18, $19
bgtz $19, l7
lw $18, 0($14)
lw $19, 0($16)
lw $20, 0($13)
mul $21, $20, 4
add $19, $19, $21
lw $19, 0($19)
mul $19, $19, 2
lw $20, 0($16)
lw $21, 0($12)
mul $22, $21, 4
add $20, $20, $22
lw $20, 0($20)
sub $19, $19, $20
mul $20, $19, 4
add $18, $18, $20
lw $18, 0($18)
beqz $18, l8
lw $18, 0($17)
lw $19, 0($12)
mul $20, $19, 680
add $18, $18, $20
lw $19, 0($13)
mul $20, $19, 4
add $18, $18, $20
sw $31, -320($29)
lw $19, 0($17)
add $20, $29, -324
sw $19, 0($20)
add $19, $29, -328
lw $20, 0($16)
sw $20, 0($19)
add $19, $29, -332
lw $20, 0($15)
sw $20, 0($19)
add $19, $29, -336
lw $20, 0($14)
sw $20, 0($19)
lw $14, 0($15)
lw $15, 0($16)
lw $19, 0($13)
mul $20, $19, 4
add $15, $15, $20
lw $15, 0($15)
mul $15, $15, 2
lw $19, 0($16)
lw $16, 0($12)
mul $20, $16, 4
add $19, $19, $20
lw $19, 0($19)
sub $15, $15, $19
mul $16, $15, 4
add $14, $14, $16
add $15, $29, -340
lw $14, 0($14)
sw $14, 0($15)
add $14, $29, -344
lw $15, 0($13)
sw $15, 0($14)
add $14, $29, -348
lw $15, 0($11)
sw $15, 0($14)
add $29, $29, -348
sw $12, 340($sp)
sw $13, 336($sp)
sw $17, 320($sp)
sw $18, 224($sp)
jal __getResult
lw $12, 340($sp)
lw $13, 336($sp)
lw $17, 320($sp)
lw $18, 224($sp)
sub $29, $29, -348
lw $31, -320($29)
add $11, $29, -316
lw $14, 0($11)
add $14, $14, 1
sw $14, 0($18)
l8:
l7:
l6:
lw $11, 0($17)
lw $14, 0($12)
mul $15, $14, 680
add $11, $11, $15
lw $14, 0($13)
mul $15, $14, 4
add $11, $11, $15
lw $11, 0($11)
li $14, -1
sub $14, $11, $14
bnez $14, l9
lw $11, 0($17)
lw $14, 0($12)
mul $15, $14, 680
add $11, $11, $15
lw $14, 0($13)
mul $15, $14, 4
add $11, $11, $15
li $14, 1
sw $14, 0($11)
l9:
lw $11, 0($17)
lw $14, 0($12)
mul $12, $14, 680
add $11, $11, $12
lw $12, 0($13)
mul $13, $12, 4
add $11, $11, $13
add $12, $29, 32
lw $11, 0($11)
sw $11, 0($12)
jr $ra
jr $ra
__printF:
add $14, $29, 0
add $16, $29, 4
add $17, $29, 8
sw $31, -148($29)
add $18, $29, -152
lw $19, 0($14)
sw $19, 0($18)
lw $11, 608($a3)
move $18, $11
add $11, $29, -156
sw $18, 0($11)
add $29, $29, -156
jal __printf
sub $29, $29, -156
lw $31, -148($29)
l10:
lw $11, 0($17)
li $18, 0
sub $18, $11, $18
blez $18, l11
sw $31, -148($29)
li $11, 32
add $18, $29, -152
sw $11, 0($18)
lw $13, 640($a3)
move $11, $13
add $18, $29, -156
sw $11, 0($18)
add $29, $29, -156
jal __printf
sub $29, $29, -156
lw $31, -148($29)
sw $31, -148($29)
add $11, $29, -152
lw $18, 0($16)
sw $18, 0($11)
lw $12, 664($a3)
move $11, $12
add $18, $29, -156
sw $11, 0($18)
add $29, $29, -156
jal __printf
sub $29, $29, -156
lw $31, -148($29)
move $11, $16
lw $18, 0($16)
mul $18, $18, 2
lw $19, 0($14)
sub $18, $18, $19
sw $18, 0($11)
move $11, $14
lw $18, 0($14)
lw $19, 0($16)
add $18, $18, $19
div $18, $18, 2
sw $18, 0($11)
move $11, $17
lw $18, 0($17)
sub $18, $18, 1
sw $18, 0($11)
j l10
l11:
sw $31, -148($29)
li $11, 10
add $12, $29, -152
sw $11, 0($12)
lw $15, 732($a3)
move $11, $15
add $12, $29, -156
sw $11, 0($12)
add $29, $29, -156
jal __printf
sub $29, $29, -156
lw $31, -148($29)
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
sw $t0, 608($a3)
la $t0, var12
sw $t0, 640($a3)
la $t0, var13
sw $t0, 664($a3)
la $t0, var14
sw $t0, 732($a3)
la $t0, var15
sw $t0, 1368($a3)
lw $21, 8($a3)
move $11, $21
li $24, 1000
sw $24, 0($11)
lw $12, 12($a3)
move $11, $12
li $24, 100
add $29, $29, -648
sw $11, 636($sp)
sw $12, 12($a3)
sw $21, 8($a3)
sw $24, 632($sp)
jal __getchar
lw $11, 636($sp)
lw $12, 12($a3)
lw $21, 8($a3)
lw $24, 632($sp)
sub $29, $29, -648
add $25, $29, -644
lw $23, 0($25)
sub $23, $23, 48
mul $24, $24, $23
li $23, 10
add $29, $29, -648
sw $11, 636($sp)
sw $12, 12($a3)
sw $21, 8($a3)
sw $23, 616($sp)
sw $24, 632($sp)
jal __getchar
lw $11, 636($sp)
lw $12, 12($a3)
lw $21, 8($a3)
lw $23, 616($sp)
lw $24, 632($sp)
sub $29, $29, -648
add $25, $29, -644
lw $22, 0($25)
sub $22, $22, 48
mul $23, $23, $22
add $24, $24, $23
add $29, $29, -648
sw $11, 636($sp)
sw $12, 12($a3)
sw $21, 8($a3)
sw $24, 632($sp)
jal __getchar
lw $11, 636($sp)
lw $12, 12($a3)
lw $21, 8($a3)
lw $24, 632($sp)
sub $29, $29, -648
add $22, $29, -644
lw $23, 0($22)
add $24, $24, $23
sub $24, $24, 48
sw $24, 0($11)
lw $20, 24($a3)
move $11, $20
li $22, 0
sw $22, 0($11)
lw $9, 28($a3)
move $11, $9
li $22, 0
sw $22, 0($11)
li $11, 0
mul $22, $11, 4
lw $13, 44($a3)
add $11, $13, $22
li $22, 0
sw $22, 0($11)
lw $19, 16($a3)
move $11, $19
li $22, 0
sw $22, 0($11)
l12:
lw $11, 0($19)
lw $22, 0($21)
add $22, $22, 1
sub $22, $11, $22
bgez $22, l13
lw $11, 0($19)
mul $22, $11, 4
lw $18, 32($a3)
add $11, $18, $22
li $22, 1
sw $22, 0($11)
lw $11, 0($19)
mul $22, $11, 4
lw $17, 40($a3)
add $11, $17, $22
li $22, 0
sw $22, 0($11)
l14:
move $11, $19
lw $22, 0($19)
add $22, $22, 1
sw $22, 0($11)
j l12
l13:
move $11, $19
li $22, 0
sw $22, 0($11)
l15:
lw $11, 0($19)
lw $22, 0($12)
add $22, $22, 1
sub $22, $11, $22
bgez $22, l16
lw $11, 0($19)
mul $22, $11, 4
lw $16, 36($a3)
add $11, $16, $22
li $22, 0
sw $22, 0($11)
l17:
move $11, $19
lw $22, 0($19)
add $22, $22, 1
sw $22, 0($11)
j l15
l16:
move $11, $19
li $22, 0
sw $22, 0($11)
l18:
lw $11, 0($19)
lw $22, 0($12)
sub $22, $11, $22
bgtz $22, l19
lw $15, 20($a3)
move $11, $15
li $22, 0
sw $22, 0($11)
l21:
lw $11, 0($15)
lw $22, 0($12)
sub $22, $11, $22
bgtz $22, l22
lw $11, 0($19)
mul $22, $11, 680
lw $14, 48($a3)
add $11, $14, $22
lw $22, 0($15)
mul $23, $22, 4
add $11, $11, $23
li $22, -1
sw $22, 0($11)
l23:
move $11, $15
lw $22, 0($15)
add $22, $22, 1
sw $22, 0($11)
j l21
l22:
l20:
move $11, $19
lw $22, 0($19)
add $22, $22, 1
sw $22, 0($11)
j l18
l19:
move $11, $16
add $12, $29, -652
sw $11, 0($12)
move $11, $17
add $12, $29, -656
sw $11, 0($12)
move $11, $18
add $12, $29, -660
sw $11, 0($12)
move $11, $13
add $12, $29, -664
sw $11, 0($12)
add $11, $29, -668
lw $12, 0($21)
sw $12, 0($11)
add $29, $29, -668
sw $13, 44($a3)
sw $14, 48($a3)
sw $15, 20($a3)
sw $16, 36($a3)
sw $17, 40($a3)
sw $18, 32($a3)
sw $19, 16($a3)
sw $20, 24($a3)
sw $21, 8($a3)
jal __getPrime
lw $13, 44($a3)
lw $14, 48($a3)
lw $15, 20($a3)
lw $16, 36($a3)
lw $17, 40($a3)
lw $18, 32($a3)
lw $19, 16($a3)
lw $20, 24($a3)
lw $21, 8($a3)
sub $29, $29, -668
add $11, $29, -644
move $12, $11
move $11, $20
li $12, 0
mul $22, $12, 4
add $12, $13, $22
lw $12, 0($12)
sw $12, 0($11)
move $11, $19
li $12, 1
sw $12, 0($11)
l24:
lw $11, 0($19)
lw $12, 0($20)
sub $12, $11, $12
bgez $12, l25
move $11, $15
lw $12, 0($19)
add $12, $12, 1
sw $12, 0($11)
l27:
lw $11, 0($15)
lw $12, 0($20)
sub $12, $11, $12
bgtz $12, l28
lw $11, 0($19)
mul $12, $11, 680
add $11, $14, $12
lw $12, 0($15)
mul $13, $12, 4
add $11, $11, $13
lw $11, 0($11)
li $12, -1
sub $12, $11, $12
bnez $12, l30
lw $11, 0($19)
mul $12, $11, 680
add $11, $14, $12
lw $12, 0($15)
mul $13, $12, 4
add $11, $11, $13
move $12, $14
add $13, $29, -652
sw $12, 0($13)
move $12, $16
add $13, $29, -656
sw $12, 0($13)
move $12, $17
add $13, $29, -660
sw $12, 0($13)
move $12, $18
add $13, $29, -664
sw $12, 0($13)
add $12, $29, -668
lw $13, 0($15)
sw $13, 0($12)
add $12, $29, -672
lw $13, 0($19)
sw $13, 0($12)
add $12, $29, -676
lw $13, 0($21)
sw $13, 0($12)
add $29, $29, -676
sw $11, 268($sp)
sw $14, 48($a3)
sw $15, 20($a3)
sw $16, 36($a3)
sw $17, 40($a3)
sw $18, 32($a3)
sw $19, 16($a3)
sw $20, 24($a3)
sw $21, 8($a3)
jal __getResult
lw $11, 268($sp)
lw $14, 48($a3)
lw $15, 20($a3)
lw $16, 36($a3)
lw $17, 40($a3)
lw $18, 32($a3)
lw $19, 16($a3)
lw $20, 24($a3)
lw $21, 8($a3)
sub $29, $29, -676
add $12, $29, -644
lw $13, 0($12)
sw $13, 0($11)
lw $11, 0($19)
mul $12, $11, 680
add $11, $14, $12
lw $12, 0($15)
mul $13, $12, 4
add $11, $11, $13
lw $11, 0($11)
li $12, 1
sub $12, $11, $12
blez $12, l31
lw $11, 0($19)
mul $12, $11, 680
add $11, $14, $12
lw $12, 0($15)
mul $13, $12, 4
add $11, $11, $13
add $12, $29, -652
lw $11, 0($11)
sw $11, 0($12)
lw $11, 0($15)
mul $12, $11, 4
add $11, $16, $12
add $12, $29, -656
lw $11, 0($11)
sw $11, 0($12)
lw $11, 0($19)
mul $12, $11, 4
add $11, $16, $12
add $12, $29, -660
lw $11, 0($11)
sw $11, 0($12)
add $29, $29, -660
sw $14, 48($a3)
sw $15, 20($a3)
sw $16, 36($a3)
sw $17, 40($a3)
sw $18, 32($a3)
sw $19, 16($a3)
sw $20, 24($a3)
sw $21, 8($a3)
jal __printF
lw $14, 48($a3)
lw $15, 20($a3)
lw $16, 36($a3)
lw $17, 40($a3)
lw $18, 32($a3)
lw $19, 16($a3)
lw $20, 24($a3)
lw $21, 8($a3)
sub $29, $29, -660
add $11, $29, -644
move $12, $11
lw $9, 28($a3)
move $11, $9
lw $9, 28($a3)
lw $12, 0($9)
add $12, $12, 1
sw $12, 0($11)
l31:
l30:
l29:
move $11, $15
lw $12, 0($15)
add $12, $12, 1
sw $12, 0($11)
j l27
l28:
l26:
move $11, $19
lw $12, 0($19)
add $12, $12, 1
sw $12, 0($11)
j l24
l25:
add $11, $29, -648
lw $9, 28($a3)
lw $12, 0($9)
sw $12, 0($11)
lw $9, 1368($a3)
move $11, $9
add $12, $29, -652
sw $11, 0($12)
add $29, $29, -652
jal __printf
sub $29, $29, -652
li $11, 0
add $12, $29, 4
sw $11, 0($12)
j __main_end
j __main_end
__main_end:
li $v0, 10
syscall
