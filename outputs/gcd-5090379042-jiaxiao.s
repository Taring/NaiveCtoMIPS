.data
temp: .space 300
var0: .asciiz "%d\n%d\n%d\n%d\n"
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

__gcd:
add $8, $29, 0
sw $8, -4($sp)
add $8, $29, 4
sw $8, -8($sp)
lw $9, -4($sp)
lw $8, 0($9)
sw $8, -12($sp)
lw $9, -8($sp)
lw $8, 0($9)
sw $8, -16($sp)
lw $9, -12($sp)
lw $10, -16($sp)
rem $8, $9, $10
sw $8, -12($sp)
li $8, 0
sw $8, -20($sp)
lw $9, -12($sp)
lw $10, -20($sp)
sub $8, $9, $10
sw $8, -20($sp)
lw $8, -20($sp)
bnez $8, label0
add $8, $29, 12
sw $8, -28($sp)
lw $9, -8($sp)
lw $8, 0($9)
sw $8, -24($sp)
lw $8, -24($sp)
lw $9, -28($sp)
sw $8, 0($9)
jr $ra
j label1
label0:
sw $31, -68($29)
lw $9, -4($sp)
lw $8, 0($9)
sw $8, -36($sp)
lw $9, -8($sp)
lw $8, 0($9)
sw $8, -40($sp)
lw $9, -36($sp)
lw $10, -40($sp)
rem $8, $9, $10
sw $8, -36($sp)
add $8, $29, -72
sw $8, -44($sp)
lw $8, -36($sp)
lw $9, -44($sp)
sw $8, 0($9)
add $8, $29, -76
sw $8, -52($sp)
lw $9, -8($sp)
lw $8, 0($9)
sw $8, -48($sp)
lw $8, -48($sp)
lw $9, -52($sp)
sw $8, 0($9)
add $29, $29, -76
jal __gcd
sub $29, $29, -76
lw $31, -68($29)
add $8, $29, -64
sw $8, -56($sp)
add $8, $29, 12
sw $8, -60($sp)
lw $9, -56($sp)
lw $8, 0($9)
sw $8, -32($sp)
lw $8, -32($sp)
lw $9, -60($sp)
sw $8, 0($9)
jr $ra
label1:
jr $ra
main:
la $a3, temp
la $t0, var0
sw $t0, 284($a3)
add $8, $29, -232
sw $8, -8($sp)
add $8, $29, -236
sw $8, -16($sp)
lw $9, -8($sp)
move $8, $9
sw $8, -20($sp)
li $8, 10
sw $8, -24($sp)
add $29, $29, -244
jal __getchar
sub $29, $29, -244
add $8, $29, -240
sw $8, -32($sp)
lw $9, -32($sp)
lw $8, 0($9)
sw $8, -28($sp)
li $8, 48
sw $8, -36($sp)
lw $9, -28($sp)
lw $10, -36($sp)
sub $8, $9, $10
sw $8, -28($sp)
lw $9, -24($sp)
lw $10, -28($sp)
mul $8, $9, $10
sw $8, -24($sp)
add $29, $29, -244
jal __getchar
sub $29, $29, -244
add $8, $29, -240
sw $8, -44($sp)
lw $9, -44($sp)
lw $8, 0($9)
sw $8, -40($sp)
lw $9, -24($sp)
lw $10, -40($sp)
add $8, $9, $10
sw $8, -24($sp)
li $8, 48
sw $8, -48($sp)
lw $9, -24($sp)
lw $10, -48($sp)
sub $8, $9, $10
sw $8, -24($sp)
lw $8, -24($sp)
lw $9, -20($sp)
sw $8, 0($9)
add $29, $29, -244
jal __getchar
sub $29, $29, -244
add $8, $29, -240
sw $8, -56($sp)
lw $9, -16($sp)
move $8, $9
sw $8, -60($sp)
li $8, 10
sw $8, -64($sp)
add $29, $29, -244
jal __getchar
sub $29, $29, -244
add $8, $29, -240
sw $8, -72($sp)
lw $9, -72($sp)
lw $8, 0($9)
sw $8, -68($sp)
li $8, 48
sw $8, -76($sp)
lw $9, -68($sp)
lw $10, -76($sp)
sub $8, $9, $10
sw $8, -68($sp)
lw $9, -64($sp)
lw $10, -68($sp)
mul $8, $9, $10
sw $8, -64($sp)
add $29, $29, -244
jal __getchar
sub $29, $29, -244
add $8, $29, -240
sw $8, -84($sp)
lw $9, -84($sp)
lw $8, 0($9)
sw $8, -80($sp)
lw $9, -64($sp)
lw $10, -80($sp)
add $8, $9, $10
sw $8, -64($sp)
li $8, 48
sw $8, -88($sp)
lw $9, -64($sp)
lw $10, -88($sp)
sub $8, $9, $10
sw $8, -64($sp)
lw $8, -64($sp)
lw $9, -60($sp)
sw $8, 0($9)
add $29, $29, -244
jal __getchar
sub $29, $29, -244
add $8, $29, -240
sw $8, -96($sp)
li $8, 1539
sw $8, -108($sp)
add $8, $29, -256
sw $8, -112($sp)
lw $8, -108($sp)
lw $9, -112($sp)
sw $8, 0($9)
li $8, 2907
sw $8, -116($sp)
add $8, $29, -260
sw $8, -120($sp)
lw $8, -116($sp)
lw $9, -120($sp)
sw $8, 0($9)
add $29, $29, -260
jal __gcd
sub $29, $29, -260
add $8, $29, -248
sw $8, -124($sp)
add $8, $29, -244
sw $8, -128($sp)
lw $9, -124($sp)
lw $8, 0($9)
sw $8, -104($sp)
lw $8, -104($sp)
lw $9, -128($sp)
sw $8, 0($9)
li $8, 3087
sw $8, -136($sp)
add $8, $29, -260
sw $8, -140($sp)
lw $8, -136($sp)
lw $9, -140($sp)
sw $8, 0($9)
li $8, 34986
sw $8, -144($sp)
add $8, $29, -264
sw $8, -148($sp)
lw $8, -144($sp)
lw $9, -148($sp)
sw $8, 0($9)
add $29, $29, -264
jal __gcd
sub $29, $29, -264
add $8, $29, -252
sw $8, -152($sp)
add $8, $29, -248
sw $8, -156($sp)
lw $9, -152($sp)
lw $8, 0($9)
sw $8, -132($sp)
lw $8, -132($sp)
lw $9, -156($sp)
sw $8, 0($9)
add $8, $29, -264
sw $8, -168($sp)
lw $9, -16($sp)
lw $8, 0($9)
sw $8, -164($sp)
lw $8, -164($sp)
lw $9, -168($sp)
sw $8, 0($9)
add $8, $29, -268
sw $8, -176($sp)
lw $9, -8($sp)
lw $8, 0($9)
sw $8, -172($sp)
lw $8, -172($sp)
lw $9, -176($sp)
sw $8, 0($9)
add $29, $29, -268
jal __gcd
sub $29, $29, -268
add $8, $29, -256
sw $8, -180($sp)
add $8, $29, -252
sw $8, -184($sp)
lw $9, -180($sp)
lw $8, 0($9)
sw $8, -160($sp)
lw $8, -160($sp)
lw $9, -184($sp)
sw $8, 0($9)
li $8, 1
sw $8, -192($sp)
add $8, $29, -268
sw $8, -196($sp)
lw $8, -192($sp)
lw $9, -196($sp)
sw $8, 0($9)
li $8, 10
sw $8, -200($sp)
add $8, $29, -272
sw $8, -204($sp)
lw $8, -200($sp)
lw $9, -204($sp)
sw $8, 0($9)
add $29, $29, -272
jal __gcd
sub $29, $29, -272
add $8, $29, -260
sw $8, -208($sp)
add $8, $29, -256
sw $8, -212($sp)
lw $9, -208($sp)
lw $8, 0($9)
sw $8, -188($sp)
lw $8, -188($sp)
lw $9, -212($sp)
sw $8, 0($9)
lw $9, 284($a3)
move $8, $9
sw $8, -216($sp)
add $8, $29, -260
sw $8, -220($sp)
lw $8, -216($sp)
lw $9, -220($sp)
sw $8, 0($9)
add $29, $29, -260
jal __printf
sub $29, $29, -260
li $8, 0
sw $8, -224($sp)
add $8, $29, 4
sw $8, -228($sp)
lw $8, -224($sp)
lw $9, -228($sp)
sw $8, 0($9)
j __main_end
j __main_end
__main_end:
li $v0, 10
syscall
#string $71 #%d\n%d\n%d\n%d\n
#----------------------------
#func #gcd
#addi $2 $0 0
#addi $3 $0 4
####move $4 $2
#lw $4 $2 0
####move $5 $3
#lw $5 $3 0
#mod $4 $4 $5
#li $6 0
#sub $6 $4 $6
#bnez $6 l:0
####move $7 $3
#addi $8 $0 12
#lw $7 $3 0
#sw $7 $8 0
#return
#goto l:1
#label l:0
#sw $1 $0 -68
####move $10 $2
#lw $10 $2 0
####move $11 $3
#lw $11 $3 0
#mod $10 $10 $11
#addi $12 $0 -72
#sw $10 $12 0
####move $13 $3
#addi $14 $0 -76
#lw $13 $3 0
#sw $13 $14 0
#addi $0 $0 -76
#call #gcd
#subi $0 $0 -76
#lw $1 $0 -68
#addi $15 $0 -64
####move $9 $15
#addi $16 $0 12
#lw $9 $15 0
#sw $9 $16 0
#return
#label l:1
#return
#----------------------------
#func #main
#addi $18 $0 -232
####move $17 $18
#addi $20 $0 -236
####move $19 $20
#move $21 $18
#li $22 10
#addi $0 $0 -244
#call #getchar
#subi $0 $0 -244
#addi $24 $0 -240
####move $23 $24
#lw $23 $24 0
#li $25 48
#sub $23 $23 $25
#mul $22 $22 $23
#addi $0 $0 -244
#call #getchar
#subi $0 $0 -244
#addi $27 $0 -240
####move $26 $27
#lw $26 $27 0
#add $22 $22 $26
#li $28 48
#sub $22 $22 $28
#sw $22 $21 0
#addi $0 $0 -244
#call #getchar
#subi $0 $0 -244
#addi $30 $0 -240
####move $29 $30
#move $31 $20
#li $32 10
#addi $0 $0 -244
#call #getchar
#subi $0 $0 -244
#addi $34 $0 -240
####move $33 $34
#lw $33 $34 0
#li $35 48
#sub $33 $33 $35
#mul $32 $32 $33
#addi $0 $0 -244
#call #getchar
#subi $0 $0 -244
#addi $37 $0 -240
####move $36 $37
#lw $36 $37 0
#add $32 $32 $36
#li $38 48
#sub $32 $32 $38
#sw $32 $31 0
#addi $0 $0 -244
#call #getchar
#subi $0 $0 -244
#addi $40 $0 -240
####move $39 $40
#li $43 1539
#addi $44 $0 -256
#sw $43 $44 0
#li $45 2907
#addi $46 $0 -260
#sw $45 $46 0
#addi $0 $0 -260
#call #gcd
#subi $0 $0 -260
#addi $47 $0 -248
####move $42 $47
#addi $48 $0 -244
#lw $42 $47 0
#sw $42 $48 0
#li $50 3087
#addi $51 $0 -260
#sw $50 $51 0
#li $52 34986
#addi $53 $0 -264
#sw $52 $53 0
#addi $0 $0 -264
#call #gcd
#subi $0 $0 -264
#addi $54 $0 -252
####move $49 $54
#addi $55 $0 -248
#lw $49 $54 0
#sw $49 $55 0
####move $57 $20
#addi $58 $0 -264
#lw $57 $20 0
#sw $57 $58 0
####move $59 $18
#addi $60 $0 -268
#lw $59 $18 0
#sw $59 $60 0
#addi $0 $0 -268
#call #gcd
#subi $0 $0 -268
#addi $61 $0 -256
####move $56 $61
#addi $62 $0 -252
#lw $56 $61 0
#sw $56 $62 0
#li $64 1
#addi $65 $0 -268
#sw $64 $65 0
#li $66 10
#addi $67 $0 -272
#sw $66 $67 0
#addi $0 $0 -272
#call #gcd
#subi $0 $0 -272
#addi $68 $0 -260
####move $63 $68
#addi $69 $0 -256
#lw $63 $68 0
#sw $63 $69 0
#move $70 $71
#addi $72 $0 -260
#sw $70 $72 0
#addi $0 $0 -260
#call #printf
#subi $0 $0 -260
#li $73 0
#addi $74 $0 4
#sw $73 $74 0
#return
#return
