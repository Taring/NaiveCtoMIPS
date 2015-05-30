.data
temp: .space 320
var0: .asciiz "%04d"
.align 2
var1: .asciiz "\n"
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
sw $t0, 280($a3)
la $t0, var1
sw $t0, 304($a3)
add $8, $29, -308
sw $8, -8($sp)
lw $9, -8($sp)
move $8, $9
sw $8, -4($sp)
li $8, 10000
sw $8, -12($sp)
lw $8, -12($sp)
lw $9, -4($sp)
sw $8, 0($9)
add $8, $29, -312
sw $8, -20($sp)
lw $9, -20($sp)
move $8, $9
sw $8, -16($sp)
li $8, 0
sw $8, -24($sp)
lw $8, -24($sp)
lw $9, -16($sp)
sw $8, 0($9)
add $8, $29, -316
sw $8, -32($sp)
lw $9, -32($sp)
move $8, $9
sw $8, -28($sp)
li $8, 2800
sw $8, -36($sp)
lw $8, -36($sp)
lw $9, -28($sp)
sw $8, 0($9)
add $8, $29, -320
sw $8, -44($sp)
lw $9, -44($sp)
move $8, $9
sw $8, -40($sp)
li $8, 0
sw $8, -48($sp)
lw $8, -48($sp)
lw $9, -40($sp)
sw $8, 0($9)
add $8, $29, -324
sw $8, -56($sp)
lw $9, -56($sp)
move $8, $9
sw $8, -52($sp)
li $8, 0
sw $8, -60($sp)
lw $8, -60($sp)
lw $9, -52($sp)
sw $8, 0($9)
add $8, $29, -11528
sw $8, -68($sp)
lw $9, -68($sp)
move $8, $9
sw $8, -64($sp)
add $8, $29, -11532
sw $8, -76($sp)
lw $9, -76($sp)
move $8, $9
sw $8, -72($sp)
li $8, 0
sw $8, -80($sp)
lw $8, -80($sp)
lw $9, -72($sp)
sw $8, 0($9)
label0:
lw $9, -16($sp)
lw $8, 0($9)
sw $8, -84($sp)
lw $9, -28($sp)
lw $8, 0($9)
sw $8, -88($sp)
lw $9, -84($sp)
lw $10, -88($sp)
sub $8, $9, $10
sw $8, -84($sp)
lw $8, -84($sp)
beqz $8, label1
lw $9, -16($sp)
move $8, $9
sw $8, -104($sp)
lw $9, -16($sp)
lw $8, 0($9)
sw $8, -96($sp)
lw $9, -96($sp)
add $8, $9, 1
sw $8, -108($sp)
lw $8, -108($sp)
lw $9, -104($sp)
sw $8, 0($9)
lw $9, -96($sp)
mul $8, $9, 4
sw $8, -100($sp)
lw $9, -64($sp)
lw $10, -100($sp)
add $8, $9, $10
sw $8, -92($sp)
lw $9, -4($sp)
lw $8, 0($9)
sw $8, -112($sp)
li $8, 5
sw $8, -116($sp)
lw $9, -112($sp)
lw $10, -116($sp)
div $8, $9, $10
sw $8, -112($sp)
lw $8, -112($sp)
lw $9, -92($sp)
sw $8, 0($9)
j label0
label1:
label2:
lw $9, -40($sp)
move $8, $9
sw $8, -120($sp)
li $8, 0
sw $8, -124($sp)
lw $8, -124($sp)
lw $9, -120($sp)
sw $8, 0($9)
lw $9, -72($sp)
move $8, $9
sw $8, -128($sp)
lw $9, -28($sp)
lw $8, 0($9)
sw $8, -132($sp)
li $8, 2
sw $8, -136($sp)
lw $9, -132($sp)
lw $10, -136($sp)
mul $8, $9, $10
sw $8, -132($sp)
lw $8, -132($sp)
lw $9, -128($sp)
sw $8, 0($9)
lw $9, -128($sp)
lw $8, 0($9)
sw $8, -128($sp)
lw $8, -128($sp)
beqz $8, label3
lw $9, -16($sp)
move $8, $9
sw $8, -140($sp)
lw $9, -28($sp)
lw $8, 0($9)
sw $8, -144($sp)
lw $8, -144($sp)
lw $9, -140($sp)
sw $8, 0($9)
label5:
lw $9, -40($sp)
move $8, $9
sw $8, -148($sp)
lw $9, -16($sp)
lw $8, 0($9)
sw $8, -156($sp)
lw $9, -156($sp)
mul $8, $9, 4
sw $8, -160($sp)
lw $9, -64($sp)
lw $10, -160($sp)
add $8, $9, $10
sw $8, -152($sp)
lw $9, -152($sp)
lw $8, 0($9)
sw $8, -152($sp)
lw $9, -4($sp)
lw $8, 0($9)
sw $8, -164($sp)
lw $9, -152($sp)
lw $10, -164($sp)
mul $8, $9, $10
sw $8, -152($sp)
lw $9, -40($sp)
lw $8, 0($9)
sw $8, -168($sp)
lw $9, -168($sp)
lw $10, -152($sp)
add $8, $9, $10
sw $8, -168($sp)
lw $8, -168($sp)
lw $9, -148($sp)
sw $8, 0($9)
lw $9, -16($sp)
lw $8, 0($9)
sw $8, -176($sp)
lw $9, -176($sp)
mul $8, $9, 4
sw $8, -180($sp)
lw $9, -64($sp)
lw $10, -180($sp)
add $8, $9, $10
sw $8, -172($sp)
lw $9, -40($sp)
lw $8, 0($9)
sw $8, -184($sp)
lw $9, -72($sp)
move $8, $9
sw $8, -192($sp)
lw $9, -72($sp)
lw $8, 0($9)
sw $8, -188($sp)
lw $9, -188($sp)
sub $8, $9, 1
sw $8, -188($sp)
lw $8, -188($sp)
lw $9, -192($sp)
sw $8, 0($9)
lw $9, -184($sp)
lw $10, -188($sp)
rem $8, $9, $10
sw $8, -184($sp)
lw $8, -184($sp)
lw $9, -172($sp)
sw $8, 0($9)
lw $9, -40($sp)
move $8, $9
sw $8, -196($sp)
lw $9, -72($sp)
move $8, $9
sw $8, -204($sp)
lw $9, -72($sp)
lw $8, 0($9)
sw $8, -200($sp)
lw $9, -200($sp)
sub $8, $9, 1
sw $8, -208($sp)
lw $8, -208($sp)
lw $9, -204($sp)
sw $8, 0($9)
lw $9, -40($sp)
lw $8, 0($9)
sw $8, -212($sp)
lw $9, -212($sp)
lw $10, -200($sp)
div $8, $9, $10
sw $8, -212($sp)
lw $8, -212($sp)
lw $9, -196($sp)
sw $8, 0($9)
lw $9, -16($sp)
move $8, $9
sw $8, -220($sp)
lw $9, -16($sp)
lw $8, 0($9)
sw $8, -216($sp)
lw $9, -216($sp)
sub $8, $9, 1
sw $8, -216($sp)
lw $8, -216($sp)
lw $9, -220($sp)
sw $8, 0($9)
lw $8, -216($sp)
beqz $8, label6
label7:
lw $9, -40($sp)
move $8, $9
sw $8, -224($sp)
lw $9, -40($sp)
lw $8, 0($9)
sw $8, -232($sp)
lw $9, -16($sp)
lw $8, 0($9)
sw $8, -228($sp)
lw $9, -232($sp)
lw $10, -228($sp)
mul $8, $9, $10
sw $8, -232($sp)
lw $8, -232($sp)
lw $9, -224($sp)
sw $8, 0($9)
j label5
label6:
label4:
lw $9, -28($sp)
move $8, $9
sw $8, -240($sp)
li $8, 14
sw $8, -244($sp)
lw $9, -28($sp)
lw $8, 0($9)
sw $8, -248($sp)
lw $9, -248($sp)
lw $10, -244($sp)
sub $8, $9, $10
sw $8, -248($sp)
lw $8, -248($sp)
lw $9, -240($sp)
sw $8, 0($9)
lw $9, -52($sp)
lw $8, 0($9)
sw $8, -256($sp)
lw $9, -40($sp)
lw $8, 0($9)
sw $8, -260($sp)
lw $9, -4($sp)
lw $8, 0($9)
sw $8, -264($sp)
lw $9, -260($sp)
lw $10, -264($sp)
div $8, $9, $10
sw $8, -260($sp)
lw $9, -256($sp)
lw $10, -260($sp)
add $8, $9, $10
sw $8, -256($sp)
add $8, $29, -11540
sw $8, -268($sp)
lw $8, -256($sp)
lw $9, -268($sp)
sw $8, 0($9)
lw $9, 280($a3)
move $8, $9
sw $8, -272($sp)
add $8, $29, -11544
sw $8, -276($sp)
lw $8, -272($sp)
lw $9, -276($sp)
sw $8, 0($9)
add $29, $29, -11544
jal __printf
sub $29, $29, -11544
lw $9, -52($sp)
move $8, $9
sw $8, -236($sp)
lw $9, -40($sp)
lw $8, 0($9)
sw $8, -280($sp)
lw $9, -4($sp)
lw $8, 0($9)
sw $8, -284($sp)
lw $9, -280($sp)
lw $10, -284($sp)
rem $8, $9, $10
sw $8, -280($sp)
lw $8, -280($sp)
lw $9, -236($sp)
sw $8, 0($9)
j label2
label3:
lw $9, 304($a3)
move $8, $9
sw $8, -292($sp)
add $8, $29, -11540
sw $8, -296($sp)
lw $8, -292($sp)
lw $9, -296($sp)
sw $8, 0($9)
add $29, $29, -11540
jal __printf_single
sub $29, $29, -11540
li $8, 0
sw $8, -300($sp)
add $8, $29, 4
sw $8, -304($sp)
lw $8, -300($sp)
lw $9, -304($sp)
sw $8, 0($9)
j __main_end
j __main_end
__main_end:
li $v0, 10
syscall
#string $70 #%04d
#string $76 #\n
#----------------------------
#func #main
#addi $3 $0 -308
#move $2 $3
#li $4 10000
#sw $4 $2 0
#addi $6 $0 -312
#move $5 $6
#li $7 0
#sw $7 $5 0
#addi $9 $0 -316
#move $8 $9
#li $10 2800
#sw $10 $8 0
#addi $12 $0 -320
#move $11 $12
#li $13 0
#sw $13 $11 0
#addi $15 $0 -324
#move $14 $15
#li $16 0
#sw $16 $14 0
#addi $18 $0 -11528
#move $17 $18
#addi $20 $0 -11532
#move $19 $20
#li $21 0
#sw $21 $19 0
#label l:0
####move $22 $5
#lw $22 $5 0
####move $23 $8
#lw $23 $8 0
#sub $22 $22 $23
#beqz $22 l:1
####move $24 $17
####move $25 $5
#move $27 $5
#lw $25 $5 0
#addi $28 $25 1
#sw $28 $27 0
#muli $26 $25 4
#add $24 $17 $26
####move $29 $2
#lw $29 $2 0
#li $30 5
#div $29 $29 $30
#sw $29 $24 0
#goto l:0
#label l:1
#label l:2
#move $31 $11
#li $32 0
#sw $32 $31 0
#move $33 $19
####move $34 $8
#lw $34 $8 0
#li $35 2
#mul $34 $34 $35
#sw $34 $33 0
#lw $33 $33 0
#beqz $33 l:3
#move $36 $5
####move $37 $8
#lw $37 $8 0
#sw $37 $36 0
#label l:5
#move $38 $11
####move $39 $17
####move $40 $5
#lw $40 $5 0
#muli $41 $40 4
#add $39 $17 $41
#lw $39 $39 0
####move $42 $2
#lw $42 $2 0
#mul $39 $39 $42
#lw $43 $11 0
#add $43 $43 $39
#sw $43 $38 0
####move $44 $17
####move $45 $5
#lw $45 $5 0
#muli $46 $45 4
#add $44 $17 $46
####move $47 $11
#lw $47 $11 0
####move $48 $19
#move $49 $19
#lw $48 $19 0
#subi $48 $48 1
#sw $48 $49 0
#mod $47 $47 $48
#sw $47 $44 0
#move $50 $11
####move $51 $19
#move $52 $19
#lw $51 $19 0
#subi $53 $51 1
#sw $53 $52 0
#lw $54 $11 0
#div $54 $54 $51
#sw $54 $50 0
####move $55 $5
#move $56 $5
#lw $55 $5 0
#subi $55 $55 1
#sw $55 $56 0
#beqz $55 l:6
#label l:7
#move $57 $11
####move $58 $5
#lw $59 $11 0
#lw $58 $5 0
#mul $59 $59 $58
#sw $59 $57 0
#goto l:5
#label l:6
#label l:4
#move $61 $8
#li $62 14
#lw $63 $8 0
#sub $63 $63 $62
#sw $63 $61 0
####move $65 $14
#lw $65 $14 0
####move $66 $11
#lw $66 $11 0
####move $67 $2
#lw $67 $2 0
#div $66 $66 $67
#add $65 $65 $66
#addi $68 $0 -11540
#sw $65 $68 0
#move $69 $70
#addi $71 $0 -11544
#sw $69 $71 0
#addi $0 $0 -11544
#call #printf
#subi $0 $0 -11544
#move $60 $14
####move $72 $11
#lw $72 $11 0
####move $73 $2
#lw $73 $2 0
#mod $72 $72 $73
#sw $72 $60 0
#goto l:2
#label l:3
#move $75 $76
#addi $77 $0 -11540
#sw $75 $77 0
#addi $0 $0 -11540
#call #printf_single
#subi $0 $0 -11540
#li $78 0
#addi $79 $0 4
#sw $78 $79 0
#return
#return
