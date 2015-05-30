.data
temp: .space 200
var0: .asciiz "%d %d\n"
.align 2
var1: .asciiz "%d\n"
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
sw $t0, 160($a3)
la $t0, var1
sw $t0, 192($a3)
add $8, $29, -188
sw $8, -8($sp)
lw $9, -8($sp)
move $8, $9
sw $8, -4($sp)
add $29, $29, -196
jal __getchar
sub $29, $29, -196
add $8, $29, -192
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
add $8, $29, -272
sw $8, -28($sp)
add $8, $29, -356
sw $8, -36($sp)
add $8, $29, -440
sw $8, -44($sp)
lw $9, -28($sp)
add $8, $9, 0
sw $8, -48($sp)
lw $9, -4($sp)
move $8, $9
sw $8, -52($sp)
lw $8, -52($sp)
lw $9, -48($sp)
sw $8, 0($9)
lw $9, -28($sp)
add $8, $9, 4
sw $8, -56($sp)
li $8, 0
sw $8, -60($sp)
lw $9, -60($sp)
mul $8, $9, 4
sw $8, -64($sp)
lw $9, -56($sp)
lw $10, -64($sp)
add $8, $9, $10
sw $8, -56($sp)
li $8, 2
sw $8, -68($sp)
lw $8, -68($sp)
lw $9, -56($sp)
sw $8, 0($9)
lw $9, -36($sp)
move $8, $9
sw $8, -84($sp)
lw $9, -28($sp)
lw $8, 0($9)
sw $8, -92($sp)
lw $8, -92($sp)
lw $9, -84($sp)
sw $8, 0($9)
lw $9, -84($sp)
add $8, $9, 4
sw $8, -84($sp)
lw $9, -28($sp)
add $8, $9, 4
sw $8, -88($sp)
lw $9, -88($sp)
lw $8, 0($9)
sw $8, -92($sp)
lw $8, -92($sp)
lw $9, -84($sp)
sw $8, 0($9)
lw $9, -84($sp)
add $8, $9, 4
sw $8, -84($sp)
lw $9, -88($sp)
add $8, $9, 4
sw $8, -88($sp)
lw $9, -88($sp)
lw $8, 0($9)
sw $8, -92($sp)
lw $8, -92($sp)
lw $9, -84($sp)
sw $8, 0($9)
lw $9, -84($sp)
add $8, $9, 4
sw $8, -84($sp)
lw $9, -88($sp)
add $8, $9, 4
sw $8, -88($sp)
lw $9, -88($sp)
lw $8, 0($9)
sw $8, -92($sp)
lw $8, -92($sp)
lw $9, -84($sp)
sw $8, 0($9)
lw $9, -84($sp)
add $8, $9, 4
sw $8, -84($sp)
lw $9, -88($sp)
add $8, $9, 4
sw $8, -88($sp)
lw $9, -88($sp)
lw $8, 0($9)
sw $8, -92($sp)
lw $8, -92($sp)
lw $9, -84($sp)
sw $8, 0($9)
lw $9, -84($sp)
add $8, $9, 4
sw $8, -84($sp)
lw $9, -88($sp)
add $8, $9, 4
sw $8, -88($sp)
lw $9, -88($sp)
lw $8, 0($9)
sw $8, -92($sp)
lw $8, -92($sp)
lw $9, -84($sp)
sw $8, 0($9)
lw $9, -84($sp)
add $8, $9, 4
sw $8, -84($sp)
lw $9, -88($sp)
add $8, $9, 4
sw $8, -88($sp)
lw $9, -88($sp)
lw $8, 0($9)
sw $8, -92($sp)
lw $8, -92($sp)
lw $9, -84($sp)
sw $8, 0($9)
lw $9, -84($sp)
add $8, $9, 4
sw $8, -84($sp)
lw $9, -88($sp)
add $8, $9, 4
sw $8, -88($sp)
lw $9, -88($sp)
lw $8, 0($9)
sw $8, -92($sp)
lw $8, -92($sp)
lw $9, -84($sp)
sw $8, 0($9)
lw $9, -84($sp)
add $8, $9, 4
sw $8, -84($sp)
lw $9, -88($sp)
add $8, $9, 4
sw $8, -88($sp)
lw $9, -88($sp)
lw $8, 0($9)
sw $8, -92($sp)
lw $8, -92($sp)
lw $9, -84($sp)
sw $8, 0($9)
lw $9, -84($sp)
add $8, $9, 4
sw $8, -84($sp)
lw $9, -88($sp)
add $8, $9, 4
sw $8, -88($sp)
lw $9, -88($sp)
lw $8, 0($9)
sw $8, -92($sp)
lw $8, -92($sp)
lw $9, -84($sp)
sw $8, 0($9)
lw $9, -84($sp)
add $8, $9, 4
sw $8, -84($sp)
lw $9, -88($sp)
add $8, $9, 4
sw $8, -88($sp)
lw $9, -88($sp)
lw $8, 0($9)
sw $8, -92($sp)
lw $8, -92($sp)
lw $9, -84($sp)
sw $8, 0($9)
lw $9, -84($sp)
add $8, $9, 4
sw $8, -84($sp)
lw $9, -88($sp)
add $8, $9, 4
sw $8, -88($sp)
lw $9, -88($sp)
lw $8, 0($9)
sw $8, -92($sp)
lw $8, -92($sp)
lw $9, -84($sp)
sw $8, 0($9)
lw $9, -84($sp)
add $8, $9, 4
sw $8, -84($sp)
lw $9, -88($sp)
add $8, $9, 4
sw $8, -88($sp)
lw $9, -88($sp)
lw $8, 0($9)
sw $8, -92($sp)
lw $8, -92($sp)
lw $9, -84($sp)
sw $8, 0($9)
lw $9, -84($sp)
add $8, $9, 4
sw $8, -84($sp)
lw $9, -88($sp)
add $8, $9, 4
sw $8, -88($sp)
lw $9, -88($sp)
lw $8, 0($9)
sw $8, -92($sp)
lw $8, -92($sp)
lw $9, -84($sp)
sw $8, 0($9)
lw $9, -84($sp)
add $8, $9, 4
sw $8, -84($sp)
lw $9, -88($sp)
add $8, $9, 4
sw $8, -88($sp)
lw $9, -88($sp)
lw $8, 0($9)
sw $8, -92($sp)
lw $8, -92($sp)
lw $9, -84($sp)
sw $8, 0($9)
lw $9, -84($sp)
add $8, $9, 4
sw $8, -84($sp)
lw $9, -88($sp)
add $8, $9, 4
sw $8, -88($sp)
lw $9, -88($sp)
lw $8, 0($9)
sw $8, -92($sp)
lw $8, -92($sp)
lw $9, -84($sp)
sw $8, 0($9)
lw $9, -84($sp)
add $8, $9, 4
sw $8, -84($sp)
lw $9, -88($sp)
add $8, $9, 4
sw $8, -88($sp)
lw $9, -88($sp)
lw $8, 0($9)
sw $8, -92($sp)
lw $8, -92($sp)
lw $9, -84($sp)
sw $8, 0($9)
lw $9, -84($sp)
add $8, $9, 4
sw $8, -84($sp)
lw $9, -88($sp)
add $8, $9, 4
sw $8, -88($sp)
lw $9, -88($sp)
lw $8, 0($9)
sw $8, -92($sp)
lw $8, -92($sp)
lw $9, -84($sp)
sw $8, 0($9)
lw $9, -84($sp)
add $8, $9, 4
sw $8, -84($sp)
lw $9, -88($sp)
add $8, $9, 4
sw $8, -88($sp)
lw $9, -88($sp)
lw $8, 0($9)
sw $8, -92($sp)
lw $8, -92($sp)
lw $9, -84($sp)
sw $8, 0($9)
lw $9, -84($sp)
add $8, $9, 4
sw $8, -84($sp)
lw $9, -88($sp)
add $8, $9, 4
sw $8, -88($sp)
lw $9, -88($sp)
lw $8, 0($9)
sw $8, -92($sp)
lw $8, -92($sp)
lw $9, -84($sp)
sw $8, 0($9)
lw $9, -84($sp)
add $8, $9, 4
sw $8, -84($sp)
lw $9, -88($sp)
add $8, $9, 4
sw $8, -88($sp)
lw $9, -88($sp)
lw $8, 0($9)
sw $8, -92($sp)
lw $8, -92($sp)
lw $9, -84($sp)
sw $8, 0($9)
lw $9, -84($sp)
add $8, $9, 4
sw $8, -84($sp)
lw $9, -88($sp)
add $8, $9, 4
sw $8, -88($sp)
lw $9, -44($sp)
move $8, $9
sw $8, -96($sp)
lw $9, -36($sp)
lw $8, 0($9)
sw $8, -104($sp)
lw $8, -104($sp)
lw $9, -96($sp)
sw $8, 0($9)
lw $9, -96($sp)
add $8, $9, 4
sw $8, -96($sp)
lw $9, -36($sp)
add $8, $9, 4
sw $8, -100($sp)
lw $9, -100($sp)
lw $8, 0($9)
sw $8, -104($sp)
lw $8, -104($sp)
lw $9, -96($sp)
sw $8, 0($9)
lw $9, -96($sp)
add $8, $9, 4
sw $8, -96($sp)
lw $9, -100($sp)
add $8, $9, 4
sw $8, -100($sp)
lw $9, -100($sp)
lw $8, 0($9)
sw $8, -104($sp)
lw $8, -104($sp)
lw $9, -96($sp)
sw $8, 0($9)
lw $9, -96($sp)
add $8, $9, 4
sw $8, -96($sp)
lw $9, -100($sp)
add $8, $9, 4
sw $8, -100($sp)
lw $9, -100($sp)
lw $8, 0($9)
sw $8, -104($sp)
lw $8, -104($sp)
lw $9, -96($sp)
sw $8, 0($9)
lw $9, -96($sp)
add $8, $9, 4
sw $8, -96($sp)
lw $9, -100($sp)
add $8, $9, 4
sw $8, -100($sp)
lw $9, -100($sp)
lw $8, 0($9)
sw $8, -104($sp)
lw $8, -104($sp)
lw $9, -96($sp)
sw $8, 0($9)
lw $9, -96($sp)
add $8, $9, 4
sw $8, -96($sp)
lw $9, -100($sp)
add $8, $9, 4
sw $8, -100($sp)
lw $9, -100($sp)
lw $8, 0($9)
sw $8, -104($sp)
lw $8, -104($sp)
lw $9, -96($sp)
sw $8, 0($9)
lw $9, -96($sp)
add $8, $9, 4
sw $8, -96($sp)
lw $9, -100($sp)
add $8, $9, 4
sw $8, -100($sp)
lw $9, -100($sp)
lw $8, 0($9)
sw $8, -104($sp)
lw $8, -104($sp)
lw $9, -96($sp)
sw $8, 0($9)
lw $9, -96($sp)
add $8, $9, 4
sw $8, -96($sp)
lw $9, -100($sp)
add $8, $9, 4
sw $8, -100($sp)
lw $9, -100($sp)
lw $8, 0($9)
sw $8, -104($sp)
lw $8, -104($sp)
lw $9, -96($sp)
sw $8, 0($9)
lw $9, -96($sp)
add $8, $9, 4
sw $8, -96($sp)
lw $9, -100($sp)
add $8, $9, 4
sw $8, -100($sp)
lw $9, -100($sp)
lw $8, 0($9)
sw $8, -104($sp)
lw $8, -104($sp)
lw $9, -96($sp)
sw $8, 0($9)
lw $9, -96($sp)
add $8, $9, 4
sw $8, -96($sp)
lw $9, -100($sp)
add $8, $9, 4
sw $8, -100($sp)
lw $9, -100($sp)
lw $8, 0($9)
sw $8, -104($sp)
lw $8, -104($sp)
lw $9, -96($sp)
sw $8, 0($9)
lw $9, -96($sp)
add $8, $9, 4
sw $8, -96($sp)
lw $9, -100($sp)
add $8, $9, 4
sw $8, -100($sp)
lw $9, -100($sp)
lw $8, 0($9)
sw $8, -104($sp)
lw $8, -104($sp)
lw $9, -96($sp)
sw $8, 0($9)
lw $9, -96($sp)
add $8, $9, 4
sw $8, -96($sp)
lw $9, -100($sp)
add $8, $9, 4
sw $8, -100($sp)
lw $9, -100($sp)
lw $8, 0($9)
sw $8, -104($sp)
lw $8, -104($sp)
lw $9, -96($sp)
sw $8, 0($9)
lw $9, -96($sp)
add $8, $9, 4
sw $8, -96($sp)
lw $9, -100($sp)
add $8, $9, 4
sw $8, -100($sp)
lw $9, -100($sp)
lw $8, 0($9)
sw $8, -104($sp)
lw $8, -104($sp)
lw $9, -96($sp)
sw $8, 0($9)
lw $9, -96($sp)
add $8, $9, 4
sw $8, -96($sp)
lw $9, -100($sp)
add $8, $9, 4
sw $8, -100($sp)
lw $9, -100($sp)
lw $8, 0($9)
sw $8, -104($sp)
lw $8, -104($sp)
lw $9, -96($sp)
sw $8, 0($9)
lw $9, -96($sp)
add $8, $9, 4
sw $8, -96($sp)
lw $9, -100($sp)
add $8, $9, 4
sw $8, -100($sp)
lw $9, -100($sp)
lw $8, 0($9)
sw $8, -104($sp)
lw $8, -104($sp)
lw $9, -96($sp)
sw $8, 0($9)
lw $9, -96($sp)
add $8, $9, 4
sw $8, -96($sp)
lw $9, -100($sp)
add $8, $9, 4
sw $8, -100($sp)
lw $9, -100($sp)
lw $8, 0($9)
sw $8, -104($sp)
lw $8, -104($sp)
lw $9, -96($sp)
sw $8, 0($9)
lw $9, -96($sp)
add $8, $9, 4
sw $8, -96($sp)
lw $9, -100($sp)
add $8, $9, 4
sw $8, -100($sp)
lw $9, -100($sp)
lw $8, 0($9)
sw $8, -104($sp)
lw $8, -104($sp)
lw $9, -96($sp)
sw $8, 0($9)
lw $9, -96($sp)
add $8, $9, 4
sw $8, -96($sp)
lw $9, -100($sp)
add $8, $9, 4
sw $8, -100($sp)
lw $9, -100($sp)
lw $8, 0($9)
sw $8, -104($sp)
lw $8, -104($sp)
lw $9, -96($sp)
sw $8, 0($9)
lw $9, -96($sp)
add $8, $9, 4
sw $8, -96($sp)
lw $9, -100($sp)
add $8, $9, 4
sw $8, -100($sp)
lw $9, -100($sp)
lw $8, 0($9)
sw $8, -104($sp)
lw $8, -104($sp)
lw $9, -96($sp)
sw $8, 0($9)
lw $9, -96($sp)
add $8, $9, 4
sw $8, -96($sp)
lw $9, -100($sp)
add $8, $9, 4
sw $8, -100($sp)
lw $9, -100($sp)
lw $8, 0($9)
sw $8, -104($sp)
lw $8, -104($sp)
lw $9, -96($sp)
sw $8, 0($9)
lw $9, -96($sp)
add $8, $9, 4
sw $8, -96($sp)
lw $9, -100($sp)
add $8, $9, 4
sw $8, -100($sp)
lw $9, -100($sp)
lw $8, 0($9)
sw $8, -104($sp)
lw $8, -104($sp)
lw $9, -96($sp)
sw $8, 0($9)
lw $9, -96($sp)
add $8, $9, 4
sw $8, -96($sp)
lw $9, -100($sp)
add $8, $9, 4
sw $8, -100($sp)
lw $9, -44($sp)
add $8, $9, 4
sw $8, -108($sp)
li $8, 0
sw $8, -112($sp)
lw $9, -112($sp)
mul $8, $9, 4
sw $8, -116($sp)
lw $9, -108($sp)
lw $10, -116($sp)
add $8, $9, $10
sw $8, -108($sp)
li $8, 3
sw $8, -120($sp)
lw $8, -120($sp)
lw $9, -108($sp)
sw $8, 0($9)
lw $9, -44($sp)
add $8, $9, 0
sw $8, -128($sp)
lw $9, -128($sp)
lw $8, 0($9)
sw $8, -128($sp)
add $8, $29, -448
sw $8, -132($sp)
lw $9, -128($sp)
lw $8, 0($9)
sw $8, -128($sp)
lw $8, -128($sp)
lw $9, -132($sp)
sw $8, 0($9)
lw $9, -44($sp)
add $8, $9, 4
sw $8, -136($sp)
li $8, 0
sw $8, -140($sp)
lw $9, -140($sp)
mul $8, $9, 4
sw $8, -144($sp)
lw $9, -136($sp)
lw $10, -144($sp)
add $8, $9, $10
sw $8, -136($sp)
add $8, $29, -452
sw $8, -148($sp)
lw $9, -136($sp)
lw $8, 0($9)
sw $8, -136($sp)
lw $8, -136($sp)
lw $9, -148($sp)
sw $8, 0($9)
lw $9, 160($a3)
move $8, $9
sw $8, -152($sp)
add $8, $29, -456
sw $8, -156($sp)
lw $8, -152($sp)
lw $9, -156($sp)
sw $8, 0($9)
add $29, $29, -456
jal __printf
sub $29, $29, -456
lw $9, -28($sp)
add $8, $9, 4
sw $8, -164($sp)
li $8, 0
sw $8, -168($sp)
lw $9, -168($sp)
mul $8, $9, 4
sw $8, -172($sp)
lw $9, -164($sp)
lw $10, -172($sp)
add $8, $9, $10
sw $8, -164($sp)
add $8, $29, -448
sw $8, -176($sp)
lw $9, -164($sp)
lw $8, 0($9)
sw $8, -164($sp)
lw $8, -164($sp)
lw $9, -176($sp)
sw $8, 0($9)
lw $9, 192($a3)
move $8, $9
sw $8, -180($sp)
add $8, $29, -452
sw $8, -184($sp)
lw $8, -180($sp)
lw $9, -184($sp)
sw $8, 0($9)
add $29, $29, -452
jal __printf
sub $29, $29, -452
j __main_end
__main_end:
li $v0, 10
syscall
#string $40 #%d %d\n
#string $48 #%d\n
#----------------------------
#func #main
#addi $3 $0 -188
#move $2 $3
#addi $0 $0 -196
#call #getchar
#subi $0 $0 -196
#addi $5 $0 -192
####move $4 $5
#lw $4 $5 0
#li $6 48
#sub $4 $4 $6
#sw $4 $2 0
#addi $8 $0 -272
####move $7 $8
#addi $10 $0 -356
####move $9 $10
#addi $12 $0 -440
####move $11 $12
####move $13 $8
#addi $13 $8 0
#move $14 $2
#sw $14 $13 0
####move $15 $8
#addi $15 $8 4
#li $16 0
#muli $17 $16 4
#add $15 $15 $17
#li $18 2
#sw $18 $15 0
####move $19 $12
####move $20 $10
####move $21 $8
#move $22 $10
####move $23 $8
#lw $24 $8 0
#sw $24 $22 0
#addi $22 $22 4
#addi $23 $8 4
#lw $24 $23 0
#sw $24 $22 0
#addi $22 $22 4
#addi $23 $23 4
#lw $24 $23 0
#sw $24 $22 0
#addi $22 $22 4
#addi $23 $23 4
#lw $24 $23 0
#sw $24 $22 0
#addi $22 $22 4
#addi $23 $23 4
#lw $24 $23 0
#sw $24 $22 0
#addi $22 $22 4
#addi $23 $23 4
#lw $24 $23 0
#sw $24 $22 0
#addi $22 $22 4
#addi $23 $23 4
#lw $24 $23 0
#sw $24 $22 0
#addi $22 $22 4
#addi $23 $23 4
#lw $24 $23 0
#sw $24 $22 0
#addi $22 $22 4
#addi $23 $23 4
#lw $24 $23 0
#sw $24 $22 0
#addi $22 $22 4
#addi $23 $23 4
#lw $24 $23 0
#sw $24 $22 0
#addi $22 $22 4
#addi $23 $23 4
#lw $24 $23 0
#sw $24 $22 0
#addi $22 $22 4
#addi $23 $23 4
#lw $24 $23 0
#sw $24 $22 0
#addi $22 $22 4
#addi $23 $23 4
#lw $24 $23 0
#sw $24 $22 0
#addi $22 $22 4
#addi $23 $23 4
#lw $24 $23 0
#sw $24 $22 0
#addi $22 $22 4
#addi $23 $23 4
#lw $24 $23 0
#sw $24 $22 0
#addi $22 $22 4
#addi $23 $23 4
#lw $24 $23 0
#sw $24 $22 0
#addi $22 $22 4
#addi $23 $23 4
#lw $24 $23 0
#sw $24 $22 0
#addi $22 $22 4
#addi $23 $23 4
#lw $24 $23 0
#sw $24 $22 0
#addi $22 $22 4
#addi $23 $23 4
#lw $24 $23 0
#sw $24 $22 0
#addi $22 $22 4
#addi $23 $23 4
#lw $24 $23 0
#sw $24 $22 0
#addi $22 $22 4
#addi $23 $23 4
#lw $24 $23 0
#sw $24 $22 0
#addi $22 $22 4
#addi $23 $23 4
#move $25 $12
####move $26 $10
#lw $27 $10 0
#sw $27 $25 0
#addi $25 $25 4
#addi $26 $10 4
#lw $27 $26 0
#sw $27 $25 0
#addi $25 $25 4
#addi $26 $26 4
#lw $27 $26 0
#sw $27 $25 0
#addi $25 $25 4
#addi $26 $26 4
#lw $27 $26 0
#sw $27 $25 0
#addi $25 $25 4
#addi $26 $26 4
#lw $27 $26 0
#sw $27 $25 0
#addi $25 $25 4
#addi $26 $26 4
#lw $27 $26 0
#sw $27 $25 0
#addi $25 $25 4
#addi $26 $26 4
#lw $27 $26 0
#sw $27 $25 0
#addi $25 $25 4
#addi $26 $26 4
#lw $27 $26 0
#sw $27 $25 0
#addi $25 $25 4
#addi $26 $26 4
#lw $27 $26 0
#sw $27 $25 0
#addi $25 $25 4
#addi $26 $26 4
#lw $27 $26 0
#sw $27 $25 0
#addi $25 $25 4
#addi $26 $26 4
#lw $27 $26 0
#sw $27 $25 0
#addi $25 $25 4
#addi $26 $26 4
#lw $27 $26 0
#sw $27 $25 0
#addi $25 $25 4
#addi $26 $26 4
#lw $27 $26 0
#sw $27 $25 0
#addi $25 $25 4
#addi $26 $26 4
#lw $27 $26 0
#sw $27 $25 0
#addi $25 $25 4
#addi $26 $26 4
#lw $27 $26 0
#sw $27 $25 0
#addi $25 $25 4
#addi $26 $26 4
#lw $27 $26 0
#sw $27 $25 0
#addi $25 $25 4
#addi $26 $26 4
#lw $27 $26 0
#sw $27 $25 0
#addi $25 $25 4
#addi $26 $26 4
#lw $27 $26 0
#sw $27 $25 0
#addi $25 $25 4
#addi $26 $26 4
#lw $27 $26 0
#sw $27 $25 0
#addi $25 $25 4
#addi $26 $26 4
#lw $27 $26 0
#sw $27 $25 0
#addi $25 $25 4
#addi $26 $26 4
#lw $27 $26 0
#sw $27 $25 0
#addi $25 $25 4
#addi $26 $26 4
####move $28 $12
#addi $28 $12 4
#li $29 0
#muli $30 $29 4
#add $28 $28 $30
#li $31 3
#sw $31 $28 0
####move $33 $12
#addi $33 $12 0
#lw $33 $33 0
#addi $34 $0 -448
#lw $33 $33 0
#sw $33 $34 0
####move $35 $12
#addi $35 $12 4
#li $36 0
#muli $37 $36 4
#add $35 $35 $37
#addi $38 $0 -452
#lw $35 $35 0
#sw $35 $38 0
#move $39 $40
#addi $41 $0 -456
#sw $39 $41 0
#addi $0 $0 -456
#call #printf
#subi $0 $0 -456
####move $43 $8
#addi $43 $8 4
#li $44 0
#muli $45 $44 4
#add $43 $43 $45
#addi $46 $0 -448
#lw $43 $43 0
#sw $43 $46 0
#move $47 $48
#addi $49 $0 -452
#sw $47 $49 0
#addi $0 $0 -452
#call #printf
#subi $0 $0 -452
#return
