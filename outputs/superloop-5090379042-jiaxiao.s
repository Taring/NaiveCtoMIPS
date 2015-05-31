.data
temp: .space 656
var0: .space 4
var1: .space 4
var2: .space 4
var3: .space 4
var4: .space 4
var5: .space 4
var6: .asciiz "%d\n"
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

main:
la $a3, temp
la $t0, var0
sw $t0, 8($a3)
la $t0, var1
sw $t0, 12($a3)
la $t0, var2
sw $t0, 20($a3)
la $t0, var3
sw $t0, 28($a3)
la $t0, var4
sw $t0, 36($a3)
la $t0, var5
sw $t0, 44($a3)
la $t0, var6
sw $t0, 640($a3)
li $8, 99
sw $8, 16($a3)
lw $8, 16($a3)
lw $9, 12($a3)
sw $8, 0($9)
li $8, 100
sw $8, 24($a3)
lw $8, 24($a3)
lw $9, 20($a3)
sw $8, 0($9)
li $8, 101
sw $8, 32($a3)
lw $8, 32($a3)
lw $9, 28($a3)
sw $8, 0($9)
li $8, 102
sw $8, 40($a3)
lw $8, 40($a3)
lw $9, 36($a3)
sw $8, 0($9)
li $8, 0
sw $8, 48($a3)
lw $8, 48($a3)
lw $9, 44($a3)
sw $8, 0($9)
add $11, $29, -604
move $19, $11
add $20, $29, -608
move $21, $20
add $20, $29, -612
move $22, $20
add $20, $29, -616
move $23, $20
add $20, $29, -620
move $24, $20
add $20, $29, -624
move $25, $20
lw $16, 8($a3)
move $20, $16
add $29, $29, -632
sw $11, 624($sp)
sw $16, 8($a3)
sw $19, 628($sp)
sw $20, 580($sp)
sw $21, 620($sp)
sw $22, 612($sp)
sw $23, 604($sp)
sw $24, 596($sp)
sw $25, 588($sp)
jal __getchar
lw $11, 624($sp)
lw $16, 8($a3)
lw $19, 628($sp)
lw $20, 580($sp)
lw $21, 620($sp)
lw $22, 612($sp)
lw $23, 604($sp)
lw $24, 596($sp)
lw $25, 588($sp)
sub $29, $29, -632
add $18, $29, -628
lw $17, 0($18)
sub $17, $17, 48
sw $17, 0($20)
move $17, $11
li $11, 1
sw $11, 0($17)
l0:
lw $11, 0($19)
lw $17, 0($16)
sub $17, $11, $17
bgtz $17, l1
move $11, $21
li $17, 1
sw $17, 0($11)
l3:
lw $11, 0($21)
lw $17, 0($16)
sub $17, $11, $17
bgtz $17, l4
move $11, $22
li $17, 1
sw $17, 0($11)
l6:
lw $11, 0($22)
lw $17, 0($16)
sub $17, $11, $17
bgtz $17, l7
move $11, $23
li $17, 1
sw $17, 0($11)
l9:
lw $11, 0($23)
lw $17, 0($16)
sub $17, $11, $17
bgtz $17, l10
move $11, $24
li $17, 1
sw $17, 0($11)
l12:
lw $11, 0($24)
lw $17, 0($16)
sub $17, $11, $17
bgtz $17, l13
move $11, $25
li $17, 1
sw $17, 0($11)
l15:
lw $11, 0($25)
lw $17, 0($16)
sub $17, $11, $17
bgtz $17, l16
lw $11, 0($19)
lw $17, 0($21)
sub $17, $11, $17
beqz $17, l18
lw $11, 0($19)
lw $17, 0($22)
sub $17, $11, $17
beqz $17, l18
lw $11, 0($19)
lw $17, 0($23)
sub $17, $11, $17
beqz $17, l18
lw $11, 0($19)
lw $17, 0($24)
sub $17, $11, $17
beqz $17, l18
lw $11, 0($19)
lw $17, 0($25)
sub $17, $11, $17
beqz $17, l18
lw $11, 0($19)
lw $15, 12($a3)
lw $17, 0($15)
sub $17, $11, $17
beqz $17, l18
lw $11, 0($19)
lw $14, 20($a3)
lw $17, 0($14)
sub $17, $11, $17
beqz $17, l18
lw $11, 0($19)
lw $13, 28($a3)
lw $17, 0($13)
sub $17, $11, $17
beqz $17, l18
lw $11, 0($19)
lw $12, 36($a3)
lw $17, 0($12)
sub $17, $11, $17
beqz $17, l18
lw $11, 0($21)
lw $17, 0($22)
sub $17, $11, $17
beqz $17, l18
lw $11, 0($21)
lw $17, 0($23)
sub $17, $11, $17
beqz $17, l18
lw $11, 0($21)
lw $17, 0($24)
sub $17, $11, $17
beqz $17, l18
lw $11, 0($21)
lw $17, 0($25)
sub $17, $11, $17
beqz $17, l18
lw $11, 0($21)
lw $17, 0($15)
sub $17, $11, $17
beqz $17, l18
lw $11, 0($21)
lw $17, 0($14)
sub $17, $11, $17
beqz $17, l18
lw $11, 0($21)
lw $17, 0($13)
sub $17, $11, $17
beqz $17, l18
lw $11, 0($21)
lw $17, 0($12)
sub $17, $11, $17
beqz $17, l18
lw $11, 0($22)
lw $17, 0($23)
sub $17, $11, $17
beqz $17, l18
lw $11, 0($22)
lw $17, 0($24)
sub $17, $11, $17
beqz $17, l18
lw $11, 0($22)
lw $17, 0($25)
sub $17, $11, $17
beqz $17, l18
lw $11, 0($22)
lw $17, 0($15)
sub $17, $11, $17
beqz $17, l18
lw $11, 0($22)
lw $17, 0($14)
sub $17, $11, $17
beqz $17, l18
lw $11, 0($22)
lw $17, 0($13)
sub $17, $11, $17
beqz $17, l18
lw $11, 0($22)
lw $17, 0($12)
sub $17, $11, $17
beqz $17, l18
lw $11, 0($23)
lw $17, 0($24)
sub $17, $11, $17
beqz $17, l18
lw $11, 0($23)
lw $17, 0($25)
sub $17, $11, $17
beqz $17, l18
lw $11, 0($23)
lw $17, 0($15)
sub $17, $11, $17
beqz $17, l18
lw $11, 0($23)
lw $17, 0($14)
sub $17, $11, $17
beqz $17, l18
lw $11, 0($23)
lw $17, 0($13)
sub $17, $11, $17
beqz $17, l18
lw $11, 0($23)
lw $17, 0($12)
sub $17, $11, $17
beqz $17, l18
lw $11, 0($24)
lw $17, 0($25)
sub $17, $11, $17
beqz $17, l18
lw $11, 0($24)
lw $17, 0($15)
sub $17, $11, $17
beqz $17, l18
lw $11, 0($24)
lw $17, 0($14)
sub $17, $11, $17
beqz $17, l18
lw $11, 0($24)
lw $17, 0($13)
sub $17, $11, $17
beqz $17, l18
lw $11, 0($24)
lw $17, 0($12)
sub $17, $11, $17
beqz $17, l18
lw $11, 0($25)
lw $17, 0($15)
sub $17, $11, $17
beqz $17, l18
lw $11, 0($25)
lw $17, 0($14)
sub $17, $11, $17
beqz $17, l18
lw $11, 0($25)
lw $17, 0($13)
sub $17, $11, $17
beqz $17, l18
lw $11, 0($25)
lw $17, 0($12)
sub $17, $11, $17
beqz $17, l18
lw $11, 0($14)
lw $17, 0($13)
sub $17, $11, $17
beqz $17, l18
lw $11, 0($15)
lw $17, 0($12)
sub $17, $11, $17
beqz $17, l18
lw $9, 44($a3)
move $11, $9
lw $9, 44($a3)
lw $17, 0($9)
add $18, $17, 1
sw $18, 0($11)
l18:
l17:
move $11, $25
lw $17, 0($25)
add $18, $17, 1
sw $18, 0($11)
j l15
l16:
l14:
move $11, $24
lw $17, 0($24)
add $18, $17, 1
sw $18, 0($11)
j l12
l13:
l11:
move $11, $23
lw $17, 0($23)
add $18, $17, 1
sw $18, 0($11)
j l9
l10:
l8:
move $11, $22
lw $17, 0($22)
add $18, $17, 1
sw $18, 0($11)
j l6
l7:
l5:
move $11, $21
lw $17, 0($21)
add $18, $17, 1
sw $18, 0($11)
j l3
l4:
l2:
move $11, $19
lw $17, 0($19)
add $18, $17, 1
sw $18, 0($11)
j l0
l1:
add $11, $29, -632
lw $9, 44($a3)
lw $12, 0($9)
sw $12, 0($11)
lw $9, 640($a3)
move $11, $9
add $12, $29, -636
sw $11, 0($12)
add $29, $29, -636
jal __printf
sub $29, $29, -636
li $11, 0
add $12, $29, 4
sw $11, 0($12)
j __main_end
j __main_end
__main_end:
li $v0, 10
syscall
