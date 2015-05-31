.data
temp: .space 1280
var0: .space 4
var1: .space 4
var2: .space 4
var3: .space 400
var4: .space 4
var5: .space 4
var6: .space 4
var7: .space 4
var8: .space 4
var9: .asciiz "%d "
.align 2
var10: .asciiz "%c"
.align 2
var11: .asciiz "Sorry, the number n must be a number s.t. there exists i satisfying n=1+2+...+i\n"
.align 2
var12: .asciiz "Let's start!\n"
.align 2
var13: .asciiz "%d\n"
.align 2
var14: .asciiz "step %d:\n"
.align 2
var15: .asciiz "Total: %d step(s)\n"
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

__random:
add $11, $29, -72
move $17, $11
lw $12, 28($a3)
lw $11, 0($12)
lw $16, 52($a3)
lw $12, 0($16)
lw $14, 44($a3)
lw $18, 0($14)
rem $12, $12, $18
mul $11, $11, $12
lw $13, 48($a3)
lw $12, 0($13)
lw $13, 0($16)
lw $18, 0($14)
div $13, $13, $18
mul $12, $12, $13
sub $11, $11, $12
sw $11, 0($17)
lw $11, 0($17)
li $12, 0
sub $12, $11, $12
bltz $12, l0
move $11, $16
lw $12, 0($17)
sw $12, 0($11)
j l1
l0:
move $11, $16
lw $12, 0($17)
lw $15, 36($a3)
lw $13, 0($15)
add $12, $12, $13
sw $12, 0($11)
l1:
add $11, $29, 4
lw $12, 0($16)
sw $12, 0($11)
jr $ra
jr $ra
__initialize:
add $12, $29, 0
lw $11, 52($a3)
move $13, $11
lw $11, 0($12)
sw $11, 0($13)
jr $ra
__swap:
add $11, $29, 0
add $13, $29, 4
add $14, $29, -72
move $15, $14
lw $14, 0($11)
mul $16, $14, 4
lw $12, 24($a3)
add $14, $12, $16
lw $14, 0($14)
sw $14, 0($15)
lw $14, 0($11)
mul $11, $14, 4
add $14, $12, $11
lw $11, 0($13)
mul $16, $11, 4
add $11, $12, $16
lw $11, 0($11)
sw $11, 0($14)
lw $11, 0($13)
mul $13, $11, 4
add $11, $12, $13
lw $12, 0($15)
sw $12, 0($11)
jr $ra
__pd:
add $12, $29, 0
l2:
lw $11, 16($a3)
lw $13, 0($11)
lw $14, 0($12)
sub $14, $13, $14
bgtz $14, l3
lw $13, 0($12)
lw $14, 0($11)
lw $15, 0($11)
add $15, $15, 1
mul $14, $14, $15
div $14, $14, 2
sub $14, $13, $14
bnez $14, l5
li $13, 1
add $14, $29, 8
sw $13, 0($14)
jr $ra
l5:
l4:
move $13, $11
lw $14, 0($11)
add $14, $14, 1
sw $14, 0($13)
j l2
l3:
li $11, 0
add $12, $29, 8
sw $11, 0($12)
jr $ra
jr $ra
__show:
add $11, $29, -84
move $16, $11
move $17, $11
li $11, 0
sw $11, 0($17)
l6:
lw $11, 0($16)
lw $14, 20($a3)
lw $17, 0($14)
sub $17, $11, $17
bgez $17, l7
sw $31, -88($29)
lw $11, 0($16)
mul $17, $11, 4
lw $13, 24($a3)
add $11, $13, $17
add $17, $29, -92
lw $11, 0($11)
sw $11, 0($17)
lw $12, 312($a3)
move $11, $12
add $17, $29, -96
sw $11, 0($17)
add $29, $29, -96
jal __printf
sub $29, $29, -96
lw $31, -88($29)
l8:
move $11, $16
lw $17, 0($16)
add $17, $17, 1
sw $17, 0($11)
j l6
l7:
sw $31, -88($29)
li $11, 10
add $12, $29, -92
sw $11, 0($12)
lw $15, 344($a3)
move $11, $15
add $12, $29, -96
sw $11, 0($12)
add $29, $29, -96
jal __printf
sub $29, $29, -96
lw $31, -88($29)
jr $ra
__win:
add $11, $29, -296
move $15, $11
add $11, $29, -300
move $16, $11
li $11, 0
sw $11, 0($16)
add $11, $29, -700
move $17, $11
add $11, $29, -704
move $18, $11
lw $14, 20($a3)
lw $11, 0($14)
lw $12, 16($a3)
lw $19, 0($12)
sub $19, $11, $19
beqz $19, l9
li $11, 0
add $12, $29, 4
sw $11, 0($12)
jr $ra
l9:
move $11, $16
l10:
lw $11, 0($16)
lw $12, 0($14)
sub $12, $11, $12
bgez $12, l11
lw $11, 0($16)
mul $12, $11, 4
add $11, $17, $12
lw $12, 0($16)
mul $19, $12, 4
lw $13, 24($a3)
add $12, $13, $19
lw $12, 0($12)
sw $12, 0($11)
l12:
move $11, $16
lw $12, 0($16)
add $12, $12, 1
sw $12, 0($11)
j l10
l11:
move $11, $15
li $12, 0
sw $12, 0($11)
l13:
lw $11, 0($15)
lw $12, 0($14)
sub $12, $12, 1
sub $12, $11, $12
bgez $12, l14
move $11, $16
lw $12, 0($15)
add $12, $12, 1
sw $12, 0($11)
l16:
lw $11, 0($16)
lw $12, 0($14)
sub $12, $11, $12
bgez $12, l17
lw $11, 0($15)
mul $12, $11, 4
add $11, $17, $12
lw $11, 0($11)
lw $12, 0($16)
mul $13, $12, 4
add $12, $17, $13
lw $12, 0($12)
sub $12, $11, $12
blez $12, l19
move $11, $18
lw $12, 0($15)
mul $13, $12, 4
add $12, $17, $13
lw $12, 0($12)
sw $12, 0($11)
lw $11, 0($15)
mul $12, $11, 4
add $11, $17, $12
lw $12, 0($16)
mul $13, $12, 4
add $12, $17, $13
lw $12, 0($12)
sw $12, 0($11)
lw $11, 0($16)
mul $12, $11, 4
add $11, $17, $12
lw $12, 0($18)
sw $12, 0($11)
l19:
l18:
move $11, $16
lw $12, 0($16)
add $12, $12, 1
sw $12, 0($11)
j l16
l17:
l15:
move $11, $15
lw $12, 0($15)
add $12, $12, 1
sw $12, 0($11)
j l13
l14:
move $11, $15
li $12, 0
sw $12, 0($11)
l20:
lw $11, 0($15)
lw $12, 0($14)
sub $12, $11, $12
bgez $12, l21
lw $11, 0($15)
mul $12, $11, 4
add $11, $17, $12
lw $11, 0($11)
lw $12, 0($15)
add $12, $12, 1
sub $12, $11, $12
beqz $12, l23
li $11, 0
add $12, $29, 4
sw $11, 0($12)
jr $ra
l23:
l22:
move $11, $15
lw $12, 0($15)
add $12, $12, 1
sw $12, 0($11)
j l20
l21:
li $11, 1
add $12, $29, 4
sw $11, 0($12)
jr $ra
jr $ra
__merge:
add $11, $29, -164
move $14, $11
li $11, 0
sw $11, 0($14)
move $11, $14
l24:
lw $11, 0($14)
lw $13, 20($a3)
lw $15, 0($13)
sub $15, $11, $15
bgez $15, l25
lw $11, 0($14)
mul $15, $11, 4
lw $12, 24($a3)
add $11, $12, $15
lw $11, 0($11)
move $a1, $11
li $11, 1
beqz $a1, lnot0
li $11, 0
lnot0:
beqz $11, l27
add $11, $29, -168
move $15, $11
move $16, $11
lw $11, 0($14)
add $11, $11, 1
sw $11, 0($16)
l28:
lw $11, 0($15)
lw $16, 0($13)
sub $16, $11, $16
bgez $16, l29
lw $11, 0($15)
mul $16, $11, 4
add $11, $12, $16
lw $11, 0($11)
li $16, 0
sub $16, $11, $16
beqz $16, l31
sw $31, -172($29)
add $11, $29, -176
lw $16, 0($15)
sw $16, 0($11)
add $11, $29, -180
lw $16, 0($14)
sw $16, 0($11)
add $29, $29, -180
sw $12, 24($a3)
sw $13, 20($a3)
sw $14, 176($sp)
sw $15, 140($sp)
jal __swap
lw $12, 24($a3)
lw $13, 20($a3)
lw $14, 176($sp)
lw $15, 140($sp)
sub $29, $29, -180
lw $31, -172($29)
j l29
l31:
l30:
move $11, $15
lw $16, 0($15)
add $16, $16, 1
sw $16, 0($11)
j l28
l29:
l27:
l26:
move $11, $14
lw $15, 0($14)
add $15, $15, 1
sw $15, 0($11)
j l24
l25:
move $11, $14
li $15, 0
sw $15, 0($11)
l32:
lw $11, 0($14)
lw $15, 0($13)
sub $15, $11, $15
bgez $15, l33
lw $11, 0($14)
mul $15, $11, 4
add $11, $12, $15
lw $11, 0($11)
move $a1, $11
li $11, 1
beqz $a1, lnot1
li $11, 0
lnot1:
beqz $11, l35
move $11, $13
lw $15, 0($14)
sw $15, 0($11)
j l33
l35:
l34:
move $11, $14
lw $15, 0($14)
add $15, $15, 1
sw $15, 0($11)
j l32
l33:
jr $ra
__move:
add $11, $29, -80
move $14, $11
li $11, 0
sw $11, 0($14)
l36:
lw $11, 0($14)
lw $13, 20($a3)
lw $15, 0($13)
sub $15, $11, $15
bgez $15, l37
l38:
lw $11, 0($14)
mul $15, $11, 4
lw $12, 24($a3)
add $11, $12, $15
move $15, $11
lw $11, 0($11)
sub $11, $11, 1
sw $11, 0($15)
move $11, $14
lw $15, 0($14)
add $15, $15, 1
sw $15, 0($11)
j l36
l37:
lw $11, 0($13)
mul $14, $11, 4
add $11, $12, $14
lw $12, 0($13)
sw $12, 0($11)
move $11, $13
lw $12, 0($13)
add $13, $12, 1
sw $13, 0($11)
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
sw $t0, 28($a3)
la $t0, var5
sw $t0, 36($a3)
la $t0, var6
sw $t0, 44($a3)
la $t0, var7
sw $t0, 48($a3)
la $t0, var8
sw $t0, 52($a3)
la $t0, var9
sw $t0, 312($a3)
la $t0, var10
sw $t0, 344($a3)
la $t0, var11
sw $t0, 964($a3)
la $t0, var12
sw $t0, 988($a3)
la $t0, var13
sw $t0, 1044($a3)
la $t0, var14
sw $t0, 1228($a3)
la $t0, var15
sw $t0, 1264($a3)
li $8, 210
sw $8, 12($a3)
lw $8, 12($a3)
lw $9, 8($a3)
sw $8, 0($9)
li $8, 48271
sw $8, 32($a3)
lw $8, 32($a3)
lw $9, 28($a3)
sw $8, 0($9)
li $8, 2147483647
sw $8, 40($a3)
lw $8, 40($a3)
lw $9, 36($a3)
sw $8, 0($9)
li $8, 1
sw $8, 56($a3)
lw $8, 56($a3)
lw $9, 52($a3)
sw $8, 0($9)
add $11, $29, -384
move $24, $11
li $11, 0
sw $11, 0($24)
add $11, $29, -388
move $25, $11
li $11, 0
sw $11, 0($25)
add $11, $29, -392
move $8, $11
sw $8, -28($sp)
li $11, 0
lw $9, -28($sp)
sw $11, 0($9)
lw $12, 44($a3)
move $11, $12
lw $14, 36($a3)
lw $12, 0($14)
lw $15, 28($a3)
lw $23, 0($15)
div $12, $12, $23
sw $12, 0($11)
lw $13, 48($a3)
move $11, $13
lw $12, 0($14)
lw $13, 0($15)
rem $12, $12, $13
sw $12, 0($11)
add $11, $29, -404
lw $21, 8($a3)
lw $12, 0($21)
sw $12, 0($11)
add $29, $29, -404
sw $21, 8($a3)
sw $24, 400($sp)
sw $25, 388($sp)
jal __pd
lw $21, 8($a3)
lw $24, 400($sp)
lw $25, 388($sp)
sub $29, $29, -404
add $11, $29, -396
lw $12, 0($11)
move $a1, $12
li $12, 1
beqz $a1, lnot2
li $12, 0
lnot2:
beqz $12, l39
lw $16, 964($a3)
move $11, $16
add $12, $29, -400
sw $11, 0($12)
add $29, $29, -400
jal __printf_single
sub $29, $29, -400
li $11, 1
add $12, $29, 4
sw $11, 0($12)
j __main_end
l39:
lw $17, 988($a3)
move $11, $17
add $12, $29, -400
sw $11, 0($12)
add $29, $29, -400
jal __printf_single
sub $29, $29, -400
li $11, 3654898
add $12, $29, -400
sw $11, 0($12)
add $29, $29, -400
sw $21, 8($a3)
sw $24, 396($sp)
sw $25, 384($sp)
jal __initialize
lw $21, 8($a3)
lw $24, 396($sp)
lw $25, 384($sp)
sub $29, $29, -400
lw $19, 20($a3)
move $11, $19
add $29, $29, -400
sw $11, 276($sp)
sw $19, 20($a3)
sw $21, 8($a3)
sw $24, 396($sp)
sw $25, 384($sp)
jal __random
lw $11, 276($sp)
lw $19, 20($a3)
lw $21, 8($a3)
lw $24, 396($sp)
lw $25, 384($sp)
sub $29, $29, -400
add $12, $29, -396
lw $13, 0($12)
rem $13, $13, 10
add $13, $13, 1
sw $13, 0($11)
add $11, $29, -400
lw $12, 0($19)
sw $12, 0($11)
lw $18, 1044($a3)
move $11, $18
add $12, $29, -404
sw $11, 0($12)
add $29, $29, -404
jal __printf
sub $29, $29, -404
l40:
lw $11, 0($24)
lw $12, 0($19)
sub $12, $12, 1
sub $12, $11, $12
bgez $12, l41
lw $11, 0($24)
mul $12, $11, 4
lw $20, 24($a3)
add $11, $20, $12
add $29, $29, -400
sw $11, 224($sp)
sw $19, 20($a3)
sw $20, 24($a3)
sw $21, 8($a3)
sw $24, 396($sp)
sw $25, 384($sp)
jal __random
lw $11, 224($sp)
lw $19, 20($a3)
lw $20, 24($a3)
lw $21, 8($a3)
lw $24, 396($sp)
lw $25, 384($sp)
sub $29, $29, -400
add $12, $29, -396
lw $13, 0($12)
rem $13, $13, 10
add $13, $13, 1
sw $13, 0($11)
l43:
lw $11, 0($24)
mul $12, $11, 4
add $11, $20, $12
lw $11, 0($11)
lw $12, 0($25)
add $11, $11, $12
lw $12, 0($21)
sub $12, $11, $12
blez $12, l44
lw $11, 0($24)
mul $12, $11, 4
add $11, $20, $12
add $29, $29, -400
sw $11, 176($sp)
sw $19, 20($a3)
sw $20, 24($a3)
sw $21, 8($a3)
sw $24, 396($sp)
sw $25, 384($sp)
jal __random
lw $11, 176($sp)
lw $19, 20($a3)
lw $20, 24($a3)
lw $21, 8($a3)
lw $24, 396($sp)
lw $25, 384($sp)
sub $29, $29, -400
add $12, $29, -396
lw $13, 0($12)
rem $13, $13, 10
add $13, $13, 1
sw $13, 0($11)
j l43
l44:
move $11, $25
lw $12, 0($24)
mul $13, $12, 4
add $12, $20, $13
lw $13, 0($25)
lw $12, 0($12)
add $13, $13, $12
sw $13, 0($11)
l42:
move $11, $24
lw $12, 0($24)
add $12, $12, 1
sw $12, 0($11)
j l40
l41:
lw $11, 0($19)
sub $11, $11, 1
mul $12, $11, 4
add $11, $20, $12
lw $12, 0($21)
lw $13, 0($25)
sub $12, $12, $13
sw $12, 0($11)
add $29, $29, -396
sw $24, 392($sp)
jal __show
lw $24, 392($sp)
sub $29, $29, -396
add $29, $29, -396
sw $24, 392($sp)
jal __merge
lw $24, 392($sp)
sub $29, $29, -396
l45:
add $29, $29, -400
sw $24, 396($sp)
jal __win
lw $24, 396($sp)
sub $29, $29, -400
add $11, $29, -396
lw $12, 0($11)
move $a1, $12
li $12, 1
beqz $a1, lnot3
li $12, 0
lnot3:
beqz $12, l46
lw $9, -28($sp)
move $11, $9
lw $9, -28($sp)
lw $12, 0($9)
add $12, $12, 1
sw $12, 0($11)
add $11, $29, -400
sw $12, 0($11)
lw $22, 1228($a3)
move $11, $22
add $12, $29, -404
sw $11, 0($12)
add $29, $29, -404
jal __printf
sub $29, $29, -404
add $29, $29, -396
sw $22, 1228($a3)
sw $24, 392($sp)
jal __move
lw $22, 1228($a3)
lw $24, 392($sp)
sub $29, $29, -396
add $29, $29, -396
sw $22, 1228($a3)
sw $24, 392($sp)
jal __merge
lw $22, 1228($a3)
lw $24, 392($sp)
sub $29, $29, -396
add $29, $29, -396
sw $22, 1228($a3)
sw $24, 392($sp)
jal __show
lw $22, 1228($a3)
lw $24, 392($sp)
sub $29, $29, -396
j l45
l46:
add $11, $29, -400
lw $9, -28($sp)
lw $12, 0($9)
sw $12, 0($11)
lw $9, 1264($a3)
move $11, $9
add $12, $29, -404
sw $11, 0($12)
add $29, $29, -404
jal __printf
sub $29, $29, -404
li $11, 0
add $12, $29, 4
sw $11, 0($12)
j __main_end
j __main_end
__main_end:
li $v0, 10
syscall
