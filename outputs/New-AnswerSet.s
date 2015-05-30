.data
temp: .space 284
var0: .space 4
var1: .asciiz "%d %d\n"
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

__addSmall:
add $8, $29, 0
sw $8, -4($sp)
lw $9, -4($sp)
lw $8, 0($9)
sw $8, -8($sp)
lw $9, -4($sp)
lw $8, 0($9)
sw $8, -12($sp)
lw $9, -12($sp)
lw $8, 0($9)
sw $8, -12($sp)
li $8, 1
sw $8, -16($sp)
lw $9, -12($sp)
lw $10, -16($sp)
add $8, $9, $10
sw $8, -12($sp)
lw $8, -12($sp)
lw $9, -8($sp)
sw $8, 0($9)
jr $ra
__addMiddle:
add $8, $29, 0
sw $8, -4($sp)
add $8, $29, -92
sw $8, -12($sp)
lw $9, -12($sp)
move $8, $9
sw $8, -8($sp)
li $8, 0
sw $8, -16($sp)
lw $8, -16($sp)
lw $9, -8($sp)
sw $8, 0($9)
add $8, $29, -96
sw $8, -24($sp)
lw $9, -24($sp)
move $8, $9
sw $8, -20($sp)
lw $9, -24($sp)
move $8, $9
sw $8, -28($sp)
li $8, 1
sw $8, -32($sp)
lw $8, -32($sp)
lw $9, -28($sp)
sw $8, 0($9)
label0:
lw $9, -20($sp)
lw $8, 0($9)
sw $8, -36($sp)
li $8, 10
sw $8, -40($sp)
lw $9, -36($sp)
lw $10, -40($sp)
sub $8, $9, $10
sw $8, -40($sp)
lw $8, -40($sp)
bgtz $8, label1
sw $31, -100($29)
lw $9, -8($sp)
move $8, $9
sw $8, -48($sp)
add $8, $29, -104
sw $8, -52($sp)
lw $8, -48($sp)
lw $9, -52($sp)
sw $8, 0($9)
add $29, $29, -104
jal __addSmall
sub $29, $29, -104
lw $31, -100($29)
lw $9, -8($sp)
move $8, $9
sw $8, -56($sp)
lw $9, -8($sp)
lw $8, 0($9)
sw $8, -60($sp)
li $8, 1
sw $8, -64($sp)
lw $9, -60($sp)
lw $10, -64($sp)
add $8, $9, $10
sw $8, -60($sp)
lw $8, -60($sp)
lw $9, -56($sp)
sw $8, 0($9)
label2:
lw $9, -20($sp)
move $8, $9
sw $8, -72($sp)
lw $9, -20($sp)
lw $8, 0($9)
sw $8, -68($sp)
lw $9, -68($sp)
add $8, $9, 1
sw $8, -76($sp)
lw $8, -76($sp)
lw $9, -72($sp)
sw $8, 0($9)
j label0
label1:
lw $9, -4($sp)
lw $8, 0($9)
sw $8, -80($sp)
lw $9, -4($sp)
lw $8, 0($9)
sw $8, -84($sp)
lw $9, -84($sp)
lw $8, 0($9)
sw $8, -84($sp)
lw $9, -8($sp)
lw $8, 0($9)
sw $8, -88($sp)
lw $9, -84($sp)
lw $10, -88($sp)
add $8, $9, $10
sw $8, -84($sp)
lw $8, -84($sp)
lw $9, -80($sp)
sw $8, 0($9)
jr $ra
main:
la $a3, temp
la $t0, var0
sw $t0, 8($a3)
la $t0, var1
sw $t0, 264($a3)
li $8, 0
sw $8, 12($a3)
lw $8, 12($a3)
lw $9, 8($a3)
sw $8, 0($9)
add $8, $29, -164
sw $8, -8($sp)
lw $9, -8($sp)
move $8, $9
sw $8, -4($sp)
add $8, $29, -168
sw $8, -16($sp)
lw $9, -16($sp)
move $8, $9
sw $8, -12($sp)
lw $9, 8($a3)
move $8, $9
sw $8, -20($sp)
lw $8, -20($sp)
lw $9, -12($sp)
sw $8, 0($9)
add $8, $29, -172
sw $8, -28($sp)
lw $9, -28($sp)
move $8, $9
sw $8, -24($sp)
li $8, 10
sw $8, -32($sp)
add $29, $29, -180
jal __getchar
sub $29, $29, -180
add $8, $29, -176
sw $8, -40($sp)
lw $9, -40($sp)
lw $8, 0($9)
sw $8, -36($sp)
li $8, 48
sw $8, -44($sp)
lw $9, -36($sp)
lw $10, -44($sp)
sub $8, $9, $10
sw $8, -36($sp)
lw $9, -32($sp)
lw $10, -36($sp)
mul $8, $9, $10
sw $8, -32($sp)
add $29, $29, -180
jal __getchar
sub $29, $29, -180
add $8, $29, -176
sw $8, -52($sp)
lw $9, -52($sp)
lw $8, 0($9)
sw $8, -48($sp)
lw $9, -32($sp)
lw $10, -48($sp)
add $8, $9, $10
sw $8, -32($sp)
li $8, 48
sw $8, -56($sp)
lw $9, -32($sp)
lw $10, -56($sp)
sub $8, $9, $10
sw $8, -32($sp)
lw $8, -32($sp)
lw $9, -24($sp)
sw $8, 0($9)
lw $9, -8($sp)
move $8, $9
sw $8, -60($sp)
li $8, 1
sw $8, -64($sp)
lw $8, -64($sp)
lw $9, -60($sp)
sw $8, 0($9)
label3:
lw $9, -4($sp)
lw $8, 0($9)
sw $8, -68($sp)
lw $9, -24($sp)
lw $8, 0($9)
sw $8, -72($sp)
lw $9, -68($sp)
lw $10, -72($sp)
sub $8, $9, $10
sw $8, -72($sp)
lw $8, -72($sp)
bgtz $8, label4
add $8, $29, -176
sw $8, -80($sp)
lw $9, -80($sp)
move $8, $9
sw $8, -76($sp)
li $8, 0
sw $8, -84($sp)
lw $8, -84($sp)
lw $9, -76($sp)
sw $8, 0($9)
lw $9, -76($sp)
move $8, $9
sw $8, -92($sp)
add $8, $29, -184
sw $8, -96($sp)
lw $8, -92($sp)
lw $9, -96($sp)
sw $8, 0($9)
add $29, $29, -184
jal __addMiddle
sub $29, $29, -184
lw $9, -12($sp)
lw $8, 0($9)
sw $8, -100($sp)
lw $9, -12($sp)
lw $8, 0($9)
sw $8, -104($sp)
lw $9, -104($sp)
lw $8, 0($9)
sw $8, -104($sp)
lw $9, -76($sp)
lw $8, 0($9)
sw $8, -108($sp)
lw $9, -104($sp)
lw $10, -108($sp)
add $8, $9, $10
sw $8, -104($sp)
lw $8, -104($sp)
lw $9, -100($sp)
sw $8, 0($9)
lw $9, 8($a3)
move $8, $9
sw $8, -112($sp)
lw $9, 8($a3)
lw $8, 0($9)
sw $8, -116($sp)
li $8, 1
sw $8, -120($sp)
lw $9, -116($sp)
lw $10, -120($sp)
add $8, $9, $10
sw $8, -116($sp)
lw $8, -116($sp)
lw $9, -112($sp)
sw $8, 0($9)
add $8, $29, -184
sw $8, -132($sp)
lw $9, 8($a3)
lw $8, 0($9)
sw $8, -128($sp)
lw $8, -128($sp)
lw $9, -132($sp)
sw $8, 0($9)
add $8, $29, -188
sw $8, -140($sp)
lw $9, -4($sp)
lw $8, 0($9)
sw $8, -136($sp)
lw $8, -136($sp)
lw $9, -140($sp)
sw $8, 0($9)
lw $9, 264($a3)
move $8, $9
sw $8, -144($sp)
add $8, $29, -192
sw $8, -148($sp)
lw $8, -144($sp)
lw $9, -148($sp)
sw $8, 0($9)
add $29, $29, -192
jal __printf
sub $29, $29, -192
label5:
lw $9, -4($sp)
move $8, $9
sw $8, -156($sp)
lw $9, -4($sp)
lw $8, 0($9)
sw $8, -152($sp)
lw $9, -152($sp)
add $8, $9, 1
sw $8, -160($sp)
lw $8, -160($sp)
lw $9, -156($sp)
sw $8, 0($9)
j label3
label4:
j __main_end
__main_end:
li $v0, 10
syscall
#global $2 4
#string $66 #%d %d\n
#li $3 0
#sw $3 $2 0
#----------------------------
#func #addSmall
#addi $4 $0 0
####move $5 $4
#lw $5 $4 0
####move $6 $4
#lw $6 $4 0
#lw $6 $6 0
#li $7 1
#add $6 $6 $7
#sw $6 $5 0
#return
#----------------------------
#func #addMiddle
#addi $8 $0 0
#addi $10 $0 -92
#move $9 $10
#li $11 0
#sw $11 $9 0
#addi $13 $0 -96
#move $12 $13
#move $14 $13
#li $15 1
#sw $15 $14 0
#label l:0
####move $16 $12
#lw $16 $12 0
#li $17 10
#sub $17 $16 $17
#bgtz $17 l:1
#sw $1 $0 -100
#move $19 $9
#addi $20 $0 -104
#sw $19 $20 0
#addi $0 $0 -104
#call #addSmall
#subi $0 $0 -104
#lw $1 $0 -100
#move $21 $9
####move $22 $9
#lw $22 $9 0
#li $23 1
#add $22 $22 $23
#sw $22 $21 0
#label l:2
####move $24 $12
#move $25 $12
#lw $24 $12 0
#addi $26 $24 1
#sw $26 $25 0
#goto l:0
#label l:1
####move $27 $8
#lw $27 $8 0
####move $28 $8
#lw $28 $8 0
#lw $28 $28 0
####move $29 $9
#lw $29 $9 0
#add $28 $28 $29
#sw $28 $27 0
#return
#----------------------------
#func #main
#addi $31 $0 -164
#move $30 $31
#addi $33 $0 -168
#move $32 $33
#move $34 $2
#sw $34 $32 0
#addi $36 $0 -172
#move $35 $36
#li $37 10
#addi $0 $0 -180
#call #getchar
#subi $0 $0 -180
#addi $39 $0 -176
####move $38 $39
#lw $38 $39 0
#li $40 48
#sub $38 $38 $40
#mul $37 $37 $38
#addi $0 $0 -180
#call #getchar
#subi $0 $0 -180
#addi $42 $0 -176
####move $41 $42
#lw $41 $42 0
#add $37 $37 $41
#li $43 48
#sub $37 $37 $43
#sw $37 $35 0
#move $44 $31
#li $45 1
#sw $45 $44 0
#label l:3
####move $46 $30
#lw $46 $30 0
####move $47 $35
#lw $47 $35 0
#sub $47 $46 $47
#bgtz $47 l:4
#addi $49 $0 -176
#move $48 $49
#li $50 0
#sw $50 $48 0
#move $52 $48
#addi $53 $0 -184
#sw $52 $53 0
#addi $0 $0 -184
#call #addMiddle
#subi $0 $0 -184
####move $54 $32
#lw $54 $32 0
####move $55 $32
#lw $55 $32 0
#lw $55 $55 0
####move $56 $48
#lw $56 $48 0
#add $55 $55 $56
#sw $55 $54 0
#move $57 $2
####move $58 $2
#lw $58 $2 0
#li $59 1
#add $58 $58 $59
#sw $58 $57 0
####move $61 $2
#addi $62 $0 -184
#lw $61 $2 0
#sw $61 $62 0
####move $63 $30
#addi $64 $0 -188
#lw $63 $30 0
#sw $63 $64 0
#move $65 $66
#addi $67 $0 -192
#sw $65 $67 0
#addi $0 $0 -192
#call #printf
#subi $0 $0 -192
#label l:5
####move $68 $30
#move $69 $30
#lw $68 $30 0
#addi $70 $68 1
#sw $70 $69 0
#goto l:3
#label l:4
#return
