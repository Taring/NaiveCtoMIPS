.data
temp: .space 272
var0: .asciiz "%c -> %c\n"
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

__hanoi:
add $8, $29, 0
sw $8, -4($sp)
add $8, $29, 4
sw $8, -8($sp)
add $8, $29, 8
sw $8, -12($sp)
add $8, $29, 12
sw $8, -16($sp)
lw $9, -16($sp)
lw $8, 0($9)
sw $8, -20($sp)
li $8, 1
sw $8, -24($sp)
lw $9, -20($sp)
lw $10, -24($sp)
sub $8, $9, $10
sw $8, -24($sp)
lw $8, -24($sp)
blez $8, label0
sw $31, -176($29)
lw $9, -16($sp)
lw $8, 0($9)
sw $8, -32($sp)
li $8, 1
sw $8, -36($sp)
lw $9, -32($sp)
lw $10, -36($sp)
sub $8, $9, $10
sw $8, -32($sp)
add $8, $29, -180
sw $8, -40($sp)
lw $8, -32($sp)
lw $9, -40($sp)
sw $8, 0($9)
add $8, $29, -184
sw $8, -48($sp)
lw $9, -8($sp)
lb $8, 0($9)
sw $8, -44($sp)
lw $8, -44($sp)
lw $9, -48($sp)
sb $8, 0($9)
add $8, $29, -188
sw $8, -56($sp)
lw $9, -12($sp)
lb $8, 0($9)
sw $8, -52($sp)
lw $8, -52($sp)
lw $9, -56($sp)
sb $8, 0($9)
add $8, $29, -192
sw $8, -64($sp)
lw $9, -4($sp)
lb $8, 0($9)
sw $8, -60($sp)
lw $8, -60($sp)
lw $9, -64($sp)
sb $8, 0($9)
add $29, $29, -192
jal __hanoi
sub $29, $29, -192
lw $31, -176($29)
add $8, $29, -172
sw $8, -68($sp)
lw $9, -68($sp)
move $8, $9
sw $8, -28($sp)
sw $31, -172($29)
add $8, $29, -176
sw $8, -80($sp)
lw $9, -12($sp)
lb $8, 0($9)
sw $8, -76($sp)
lw $8, -76($sp)
lw $9, -80($sp)
sb $8, 0($9)
add $8, $29, -180
sw $8, -88($sp)
lw $9, -4($sp)
lb $8, 0($9)
sw $8, -84($sp)
lw $8, -84($sp)
lw $9, -88($sp)
sb $8, 0($9)
lw $9, 100($a3)
move $8, $9
sw $8, -92($sp)
add $8, $29, -184
sw $8, -96($sp)
lw $8, -92($sp)
lw $9, -96($sp)
sw $8, 0($9)
add $29, $29, -184
jal __printf
sub $29, $29, -184
lw $31, -172($29)
sw $31, -176($29)
lw $9, -16($sp)
lw $8, 0($9)
sw $8, -104($sp)
li $8, 1
sw $8, -108($sp)
lw $9, -104($sp)
lw $10, -108($sp)
sub $8, $9, $10
sw $8, -104($sp)
add $8, $29, -180
sw $8, -112($sp)
lw $8, -104($sp)
lw $9, -112($sp)
sw $8, 0($9)
add $8, $29, -184
sw $8, -120($sp)
lw $9, -12($sp)
lb $8, 0($9)
sw $8, -116($sp)
lw $8, -116($sp)
lw $9, -120($sp)
sb $8, 0($9)
add $8, $29, -188
sw $8, -128($sp)
lw $9, -4($sp)
lb $8, 0($9)
sw $8, -124($sp)
lw $8, -124($sp)
lw $9, -128($sp)
sb $8, 0($9)
add $8, $29, -192
sw $8, -136($sp)
lw $9, -8($sp)
lb $8, 0($9)
sw $8, -132($sp)
lw $8, -132($sp)
lw $9, -136($sp)
sb $8, 0($9)
add $29, $29, -192
jal __hanoi
sub $29, $29, -192
lw $31, -176($29)
add $8, $29, -172
sw $8, -140($sp)
lw $9, -140($sp)
move $8, $9
sw $8, -100($sp)
j label1
label0:
sw $31, -172($29)
add $8, $29, -176
sw $8, -152($sp)
lw $9, -12($sp)
lb $8, 0($9)
sw $8, -148($sp)
lw $8, -148($sp)
lw $9, -152($sp)
sb $8, 0($9)
add $8, $29, -180
sw $8, -160($sp)
lw $9, -4($sp)
lb $8, 0($9)
sw $8, -156($sp)
lw $8, -156($sp)
lw $9, -160($sp)
sb $8, 0($9)
lw $9, 100($a3)
move $8, $9
sw $8, -164($sp)
add $8, $29, -184
sw $8, -168($sp)
lw $8, -164($sp)
lw $9, -168($sp)
sw $8, 0($9)
add $29, $29, -184
jal __printf
sub $29, $29, -184
lw $31, -172($29)
label1:
jr $ra
main:
la $a3, temp
la $t0, var0
sw $t0, 100($a3)
add $8, $29, -96
sw $8, -8($sp)
lw $9, -8($sp)
move $8, $9
sw $8, -4($sp)
li $8, 10
sw $8, -12($sp)
add $29, $29, -104
jal __getchar
sub $29, $29, -104
add $8, $29, -100
sw $8, -20($sp)
lw $9, -20($sp)
lw $8, 0($9)
sw $8, -16($sp)
li $8, 48
sw $8, -24($sp)
lw $9, -16($sp)
lw $10, -24($sp)
sub $8, $9, $10
sw $8, -16($sp)
lw $9, -12($sp)
lw $10, -16($sp)
mul $8, $9, $10
sw $8, -12($sp)
add $29, $29, -104
jal __getchar
sub $29, $29, -104
add $8, $29, -100
sw $8, -32($sp)
lw $9, -32($sp)
lw $8, 0($9)
sw $8, -28($sp)
lw $9, -12($sp)
lw $10, -28($sp)
add $8, $9, $10
sw $8, -12($sp)
li $8, 48
sw $8, -36($sp)
lw $9, -12($sp)
lw $10, -36($sp)
sub $8, $9, $10
sw $8, -12($sp)
lw $8, -12($sp)
lw $9, -4($sp)
sw $8, 0($9)
lw $9, -4($sp)
lw $8, 0($9)
sw $8, -40($sp)
li $8, 0
sw $8, -44($sp)
lw $9, -40($sp)
lw $10, -44($sp)
sub $8, $9, $10
sw $8, -44($sp)
lw $8, -44($sp)
blez $8, label2
add $8, $29, -108
sw $8, -56($sp)
lw $9, -4($sp)
lw $8, 0($9)
sw $8, -52($sp)
lw $8, -52($sp)
lw $9, -56($sp)
sw $8, 0($9)
li $8, 99
sw $8, -60($sp)
add $8, $29, -112
sw $8, -64($sp)
lw $8, -60($sp)
lw $9, -64($sp)
sb $8, 0($9)
li $8, 98
sw $8, -68($sp)
add $8, $29, -116
sw $8, -72($sp)
lw $8, -68($sp)
lw $9, -72($sp)
sb $8, 0($9)
li $8, 97
sw $8, -76($sp)
add $8, $29, -120
sw $8, -80($sp)
lw $8, -76($sp)
lw $9, -80($sp)
sb $8, 0($9)
add $29, $29, -120
jal __hanoi
sub $29, $29, -120
add $8, $29, -100
sw $8, -84($sp)
lw $9, -84($sp)
move $8, $9
sw $8, -48($sp)
label2:
li $8, 0
sw $8, -88($sp)
add $8, $29, 4
sw $8, -92($sp)
lw $8, -88($sp)
lw $9, -92($sp)
sw $8, 0($9)
j __main_end
j __main_end
__main_end:
li $v0, 10
syscall
#string $25 #%c -> %c\n
#----------------------------
#func #hanoi
#addi $2 $0 0
#addi $3 $0 4
#addi $4 $0 8
#addi $5 $0 12
####move $6 $5
#lw $6 $5 0
#li $7 1
#sub $7 $6 $7
#blez $7 l:0
#sw $1 $0 -176
####move $9 $5
#lw $9 $5 0
#li $10 1
#sub $9 $9 $10
#addi $11 $0 -180
#sw $9 $11 0
####move $12 $3
#addi $13 $0 -184
#lb $12 $3 0
#sb $12 $13 0
####move $14 $4
#addi $15 $0 -188
#lb $14 $4 0
#sb $14 $15 0
####move $16 $2
#addi $17 $0 -192
#lb $16 $2 0
#sb $16 $17 0
#addi $0 $0 -192
#call #hanoi
#subi $0 $0 -192
#lw $1 $0 -176
#addi $18 $0 -172
#move $8 $18
#sw $1 $0 -172
####move $20 $4
#addi $21 $0 -176
#lb $20 $4 0
#sb $20 $21 0
####move $22 $2
#addi $23 $0 -180
#lb $22 $2 0
#sb $22 $23 0
#move $24 $25
#addi $26 $0 -184
#sw $24 $26 0
#addi $0 $0 -184
#call #printf
#subi $0 $0 -184
#lw $1 $0 -172
#sw $1 $0 -176
####move $28 $5
#lw $28 $5 0
#li $29 1
#sub $28 $28 $29
#addi $30 $0 -180
#sw $28 $30 0
####move $31 $4
#addi $32 $0 -184
#lb $31 $4 0
#sb $31 $32 0
####move $33 $2
#addi $34 $0 -188
#lb $33 $2 0
#sb $33 $34 0
####move $35 $3
#addi $36 $0 -192
#lb $35 $3 0
#sb $35 $36 0
#addi $0 $0 -192
#call #hanoi
#subi $0 $0 -192
#lw $1 $0 -176
#addi $37 $0 -172
#move $27 $37
#goto l:1
#label l:0
#sw $1 $0 -172
####move $39 $4
#addi $40 $0 -176
#lb $39 $4 0
#sb $39 $40 0
####move $41 $2
#addi $42 $0 -180
#lb $41 $2 0
#sb $41 $42 0
#move $43 $25
#addi $44 $0 -184
#sw $43 $44 0
#addi $0 $0 -184
#call #printf
#subi $0 $0 -184
#lw $1 $0 -172
#label l:1
#return
#----------------------------
#func #main
#addi $46 $0 -96
#move $45 $46
#li $47 10
#addi $0 $0 -104
#call #getchar
#subi $0 $0 -104
#addi $49 $0 -100
####move $48 $49
#lw $48 $49 0
#li $50 48
#sub $48 $48 $50
#mul $47 $47 $48
#addi $0 $0 -104
#call #getchar
#subi $0 $0 -104
#addi $52 $0 -100
####move $51 $52
#lw $51 $52 0
#add $47 $47 $51
#li $53 48
#sub $47 $47 $53
#sw $47 $45 0
####move $54 $45
#lw $54 $45 0
#li $55 0
#sub $55 $54 $55
#blez $55 l:2
####move $57 $45
#addi $58 $0 -108
#lw $57 $45 0
#sw $57 $58 0
#li $59 99
#addi $60 $0 -112
#sb $59 $60 0
#li $61 98
#addi $62 $0 -116
#sb $61 $62 0
#li $63 97
#addi $64 $0 -120
#sb $63 $64 0
#addi $0 $0 -120
#call #hanoi
#subi $0 $0 -120
#addi $65 $0 -100
#move $56 $65
#label l:2
#li $66 0
#addi $67 $0 4
#sw $66 $67 0
#return
#return
