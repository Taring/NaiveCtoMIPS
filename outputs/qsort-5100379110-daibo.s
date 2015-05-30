.data
temp: .space 476
var0: .space 40400
var1: .space 4
var2: .asciiz "%d "
.align 2
var3: .asciiz "\n"
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

__qsrt:
add $8, $29, 0
sw $8, -4($sp)
add $8, $29, 4
sw $8, -8($sp)
add $8, $29, -292
sw $8, -16($sp)
lw $9, -16($sp)
move $8, $9
sw $8, -12($sp)
lw $9, -4($sp)
lw $8, 0($9)
sw $8, -20($sp)
lw $8, -20($sp)
lw $9, -12($sp)
sw $8, 0($9)
add $8, $29, -296
sw $8, -28($sp)
lw $9, -28($sp)
move $8, $9
sw $8, -24($sp)
lw $9, -8($sp)
lw $8, 0($9)
sw $8, -32($sp)
lw $8, -32($sp)
lw $9, -24($sp)
sw $8, 0($9)
add $8, $29, -300
sw $8, -40($sp)
lw $9, -40($sp)
move $8, $9
sw $8, -36($sp)
lw $9, -4($sp)
lw $8, 0($9)
sw $8, -48($sp)
lw $9, -8($sp)
lw $8, 0($9)
sw $8, -56($sp)
lw $9, -48($sp)
lw $10, -56($sp)
add $8, $9, $10
sw $8, -48($sp)
li $8, 2
sw $8, -60($sp)
lw $9, -48($sp)
lw $10, -60($sp)
div $8, $9, $10
sw $8, -48($sp)
lw $9, -48($sp)
mul $8, $9, 4
sw $8, -52($sp)
lw $9, 8($a3)
lw $10, -52($sp)
add $8, $9, $10
sw $8, -44($sp)
lw $9, -44($sp)
lw $8, 0($9)
sw $8, -44($sp)
lw $8, -44($sp)
lw $9, -36($sp)
sw $8, 0($9)
label0:
lw $9, -12($sp)
lw $8, 0($9)
sw $8, -64($sp)
lw $9, -24($sp)
lw $8, 0($9)
sw $8, -68($sp)
lw $9, -64($sp)
lw $10, -68($sp)
sub $8, $9, $10
sw $8, -68($sp)
lw $8, -68($sp)
bgtz $8, label1
label2:
lw $9, -12($sp)
lw $8, 0($9)
sw $8, -76($sp)
lw $9, -76($sp)
mul $8, $9, 4
sw $8, -80($sp)
lw $9, 8($a3)
lw $10, -80($sp)
add $8, $9, $10
sw $8, -72($sp)
lw $9, -72($sp)
lw $8, 0($9)
sw $8, -72($sp)
lw $9, -36($sp)
lw $8, 0($9)
sw $8, -84($sp)
lw $9, -72($sp)
lw $10, -84($sp)
sub $8, $9, $10
sw $8, -84($sp)
lw $8, -84($sp)
bgez $8, label3
lw $9, -12($sp)
move $8, $9
sw $8, -92($sp)
lw $9, -12($sp)
lw $8, 0($9)
sw $8, -88($sp)
lw $9, -88($sp)
add $8, $9, 1
sw $8, -96($sp)
lw $8, -96($sp)
lw $9, -92($sp)
sw $8, 0($9)
j label2
label3:
label4:
lw $9, -24($sp)
lw $8, 0($9)
sw $8, -104($sp)
lw $9, -104($sp)
mul $8, $9, 4
sw $8, -108($sp)
lw $9, 8($a3)
lw $10, -108($sp)
add $8, $9, $10
sw $8, -100($sp)
lw $9, -100($sp)
lw $8, 0($9)
sw $8, -100($sp)
lw $9, -36($sp)
lw $8, 0($9)
sw $8, -112($sp)
lw $9, -100($sp)
lw $10, -112($sp)
sub $8, $9, $10
sw $8, -112($sp)
lw $8, -112($sp)
blez $8, label5
lw $9, -24($sp)
move $8, $9
sw $8, -120($sp)
lw $9, -24($sp)
lw $8, 0($9)
sw $8, -116($sp)
lw $9, -116($sp)
sub $8, $9, 1
sw $8, -124($sp)
lw $8, -124($sp)
lw $9, -120($sp)
sw $8, 0($9)
j label4
label5:
lw $9, -12($sp)
lw $8, 0($9)
sw $8, -128($sp)
lw $9, -24($sp)
lw $8, 0($9)
sw $8, -132($sp)
lw $9, -128($sp)
lw $10, -132($sp)
sub $8, $9, $10
sw $8, -132($sp)
lw $8, -132($sp)
bgtz $8, label6
add $8, $29, -304
sw $8, -140($sp)
lw $9, -140($sp)
move $8, $9
sw $8, -136($sp)
lw $9, -12($sp)
lw $8, 0($9)
sw $8, -148($sp)
lw $9, -148($sp)
mul $8, $9, 4
sw $8, -152($sp)
lw $9, 8($a3)
lw $10, -152($sp)
add $8, $9, $10
sw $8, -144($sp)
lw $9, -144($sp)
lw $8, 0($9)
sw $8, -144($sp)
lw $8, -144($sp)
lw $9, -136($sp)
sw $8, 0($9)
lw $9, -12($sp)
lw $8, 0($9)
sw $8, -160($sp)
lw $9, -160($sp)
mul $8, $9, 4
sw $8, -164($sp)
lw $9, 8($a3)
lw $10, -164($sp)
add $8, $9, $10
sw $8, -156($sp)
lw $9, -24($sp)
lw $8, 0($9)
sw $8, -172($sp)
lw $9, -172($sp)
mul $8, $9, 4
sw $8, -176($sp)
lw $9, 8($a3)
lw $10, -176($sp)
add $8, $9, $10
sw $8, -168($sp)
lw $9, -168($sp)
lw $8, 0($9)
sw $8, -168($sp)
lw $8, -168($sp)
lw $9, -156($sp)
sw $8, 0($9)
lw $9, -24($sp)
lw $8, 0($9)
sw $8, -184($sp)
lw $9, -184($sp)
mul $8, $9, 4
sw $8, -188($sp)
lw $9, 8($a3)
lw $10, -188($sp)
add $8, $9, $10
sw $8, -180($sp)
lw $9, -136($sp)
lw $8, 0($9)
sw $8, -192($sp)
lw $8, -192($sp)
lw $9, -180($sp)
sw $8, 0($9)
lw $9, -12($sp)
move $8, $9
sw $8, -200($sp)
lw $9, -12($sp)
lw $8, 0($9)
sw $8, -196($sp)
lw $9, -196($sp)
add $8, $9, 1
sw $8, -204($sp)
lw $8, -204($sp)
lw $9, -200($sp)
sw $8, 0($9)
lw $9, -24($sp)
move $8, $9
sw $8, -212($sp)
lw $9, -24($sp)
lw $8, 0($9)
sw $8, -208($sp)
lw $9, -208($sp)
sub $8, $9, 1
sw $8, -216($sp)
lw $8, -216($sp)
lw $9, -212($sp)
sw $8, 0($9)
label6:
j label0
label1:
lw $9, -4($sp)
lw $8, 0($9)
sw $8, -220($sp)
lw $9, -24($sp)
lw $8, 0($9)
sw $8, -224($sp)
lw $9, -220($sp)
lw $10, -224($sp)
sub $8, $9, $10
sw $8, -224($sp)
lw $8, -224($sp)
bgez $8, label7
sw $31, -308($29)
add $8, $29, -312
sw $8, -236($sp)
lw $9, -24($sp)
lw $8, 0($9)
sw $8, -232($sp)
lw $8, -232($sp)
lw $9, -236($sp)
sw $8, 0($9)
add $8, $29, -316
sw $8, -244($sp)
lw $9, -4($sp)
lw $8, 0($9)
sw $8, -240($sp)
lw $8, -240($sp)
lw $9, -244($sp)
sw $8, 0($9)
add $29, $29, -316
jal __qsrt
sub $29, $29, -316
lw $31, -308($29)
add $8, $29, -304
sw $8, -248($sp)
lw $9, -248($sp)
move $8, $9
sw $8, -228($sp)
label7:
lw $9, -12($sp)
lw $8, 0($9)
sw $8, -252($sp)
lw $9, -8($sp)
lw $8, 0($9)
sw $8, -256($sp)
lw $9, -252($sp)
lw $10, -256($sp)
sub $8, $9, $10
sw $8, -256($sp)
lw $8, -256($sp)
bgez $8, label8
sw $31, -308($29)
add $8, $29, -312
sw $8, -268($sp)
lw $9, -8($sp)
lw $8, 0($9)
sw $8, -264($sp)
lw $8, -264($sp)
lw $9, -268($sp)
sw $8, 0($9)
add $8, $29, -316
sw $8, -276($sp)
lw $9, -12($sp)
lw $8, 0($9)
sw $8, -272($sp)
lw $8, -272($sp)
lw $9, -276($sp)
sw $8, 0($9)
add $29, $29, -316
jal __qsrt
sub $29, $29, -316
lw $31, -308($29)
add $8, $29, -304
sw $8, -280($sp)
lw $9, -280($sp)
move $8, $9
sw $8, -260($sp)
label8:
li $8, 0
sw $8, -284($sp)
add $8, $29, 12
sw $8, -288($sp)
lw $8, -284($sp)
lw $9, -288($sp)
sw $8, 0($9)
jr $ra
jr $ra
main:
la $a3, temp
la $t0, var0
sw $t0, 8($a3)
la $t0, var1
sw $t0, 12($a3)
la $t0, var2
sw $t0, 432($a3)
la $t0, var3
sw $t0, 460($a3)
li $8, 10000
sw $8, 16($a3)
lw $8, 16($a3)
lw $9, 12($a3)
sw $8, 0($9)
add $8, $29, -164
sw $8, -8($sp)
lw $9, -8($sp)
move $8, $9
sw $8, -4($sp)
lw $9, -8($sp)
move $8, $9
sw $8, -12($sp)
li $8, 1
sw $8, -16($sp)
lw $8, -16($sp)
lw $9, -12($sp)
sw $8, 0($9)
label9:
lw $9, -4($sp)
lw $8, 0($9)
sw $8, -20($sp)
lw $9, 12($a3)
lw $8, 0($9)
sw $8, -24($sp)
lw $9, -20($sp)
lw $10, -24($sp)
sub $8, $9, $10
sw $8, -24($sp)
lw $8, -24($sp)
bgtz $8, label10
lw $9, -4($sp)
lw $8, 0($9)
sw $8, -32($sp)
lw $9, -32($sp)
mul $8, $9, 4
sw $8, -36($sp)
lw $9, 8($a3)
lw $10, -36($sp)
add $8, $9, $10
sw $8, -28($sp)
lw $9, 12($a3)
lw $8, 0($9)
sw $8, -40($sp)
li $8, 1
sw $8, -44($sp)
lw $9, -40($sp)
lw $10, -44($sp)
add $8, $9, $10
sw $8, -40($sp)
lw $9, -4($sp)
lw $8, 0($9)
sw $8, -48($sp)
lw $9, -40($sp)
lw $10, -48($sp)
sub $8, $9, $10
sw $8, -40($sp)
lw $8, -40($sp)
lw $9, -28($sp)
sw $8, 0($9)
label11:
lw $9, -4($sp)
move $8, $9
sw $8, -56($sp)
lw $9, -4($sp)
lw $8, 0($9)
sw $8, -52($sp)
lw $9, -52($sp)
add $8, $9, 1
sw $8, -60($sp)
lw $8, -60($sp)
lw $9, -56($sp)
sw $8, 0($9)
j label9
label10:
add $8, $29, -176
sw $8, -72($sp)
lw $9, 12($a3)
lw $8, 0($9)
sw $8, -68($sp)
lw $8, -68($sp)
lw $9, -72($sp)
sw $8, 0($9)
li $8, 1
sw $8, -76($sp)
add $8, $29, -180
sw $8, -80($sp)
lw $8, -76($sp)
lw $9, -80($sp)
sw $8, 0($9)
add $29, $29, -180
jal __qsrt
sub $29, $29, -180
add $8, $29, -168
sw $8, -84($sp)
lw $9, -84($sp)
move $8, $9
sw $8, -64($sp)
lw $9, -4($sp)
move $8, $9
sw $8, -88($sp)
li $8, 1
sw $8, -92($sp)
lw $8, -92($sp)
lw $9, -88($sp)
sw $8, 0($9)
label12:
lw $9, -4($sp)
lw $8, 0($9)
sw $8, -96($sp)
lw $9, 12($a3)
lw $8, 0($9)
sw $8, -100($sp)
lw $9, -96($sp)
lw $10, -100($sp)
sub $8, $9, $10
sw $8, -100($sp)
lw $8, -100($sp)
bgtz $8, label13
lw $9, -4($sp)
lw $8, 0($9)
sw $8, -112($sp)
lw $9, -112($sp)
mul $8, $9, 4
sw $8, -116($sp)
lw $9, 8($a3)
lw $10, -116($sp)
add $8, $9, $10
sw $8, -108($sp)
add $8, $29, -172
sw $8, -120($sp)
lw $9, -108($sp)
lw $8, 0($9)
sw $8, -108($sp)
lw $8, -108($sp)
lw $9, -120($sp)
sw $8, 0($9)
lw $9, 432($a3)
move $8, $9
sw $8, -124($sp)
add $8, $29, -176
sw $8, -128($sp)
lw $8, -124($sp)
lw $9, -128($sp)
sw $8, 0($9)
add $29, $29, -176
jal __printf
sub $29, $29, -176
label14:
lw $9, -4($sp)
move $8, $9
sw $8, -136($sp)
lw $9, -4($sp)
lw $8, 0($9)
sw $8, -132($sp)
lw $9, -132($sp)
add $8, $9, 1
sw $8, -140($sp)
lw $8, -140($sp)
lw $9, -136($sp)
sw $8, 0($9)
j label12
label13:
lw $9, 460($a3)
move $8, $9
sw $8, -148($sp)
add $8, $29, -172
sw $8, -152($sp)
lw $8, -148($sp)
lw $9, -152($sp)
sw $8, 0($9)
add $29, $29, -172
jal __printf_single
sub $29, $29, -172
li $8, 0
sw $8, -156($sp)
add $8, $29, 4
sw $8, -160($sp)
lw $8, -156($sp)
lw $9, -160($sp)
sw $8, 0($9)
j __main_end
j __main_end
__main_end:
li $v0, 10
syscall
#global $2 40400
#global $3 4
#string $108 #%d 
#string $115 #\n
#li $4 10000
#sw $4 $3 0
#----------------------------
#func #qsrt
#addi $5 $0 0
#addi $6 $0 4
#addi $8 $0 -292
#move $7 $8
####move $9 $5
#lw $9 $5 0
#sw $9 $7 0
#addi $11 $0 -296
#move $10 $11
####move $12 $6
#lw $12 $6 0
#sw $12 $10 0
#addi $14 $0 -300
#move $13 $14
####move $15 $2
####move $16 $5
#lw $16 $5 0
####move $18 $6
#lw $18 $6 0
#add $16 $16 $18
#li $19 2
#div $16 $16 $19
#muli $17 $16 4
#add $15 $2 $17
#lw $15 $15 0
#sw $15 $13 0
#label l:0
####move $20 $7
#lw $20 $7 0
####move $21 $10
#lw $21 $10 0
#sub $21 $20 $21
#bgtz $21 l:1
#label l:2
####move $22 $2
####move $23 $7
#lw $23 $7 0
#muli $24 $23 4
#add $22 $2 $24
#lw $22 $22 0
####move $25 $13
#lw $25 $13 0
#sub $25 $22 $25
#bgez $25 l:3
####move $26 $7
#move $27 $7
#lw $26 $7 0
#addi $28 $26 1
#sw $28 $27 0
#goto l:2
#label l:3
#label l:4
####move $29 $2
####move $30 $10
#lw $30 $10 0
#muli $31 $30 4
#add $29 $2 $31
#lw $29 $29 0
####move $32 $13
#lw $32 $13 0
#sub $32 $29 $32
#blez $32 l:5
####move $33 $10
#move $34 $10
#lw $33 $10 0
#subi $35 $33 1
#sw $35 $34 0
#goto l:4
#label l:5
####move $36 $7
#lw $36 $7 0
####move $37 $10
#lw $37 $10 0
#sub $37 $36 $37
#bgtz $37 l:6
#addi $39 $0 -304
#move $38 $39
####move $40 $2
####move $41 $7
#lw $41 $7 0
#muli $42 $41 4
#add $40 $2 $42
#lw $40 $40 0
#sw $40 $38 0
####move $43 $2
####move $44 $7
#lw $44 $7 0
#muli $45 $44 4
#add $43 $2 $45
####move $46 $2
####move $47 $10
#lw $47 $10 0
#muli $48 $47 4
#add $46 $2 $48
#lw $46 $46 0
#sw $46 $43 0
####move $49 $2
####move $50 $10
#lw $50 $10 0
#muli $51 $50 4
#add $49 $2 $51
####move $52 $38
#lw $52 $38 0
#sw $52 $49 0
####move $53 $7
#move $54 $7
#lw $53 $7 0
#addi $55 $53 1
#sw $55 $54 0
####move $56 $10
#move $57 $10
#lw $56 $10 0
#subi $58 $56 1
#sw $58 $57 0
#label l:6
#goto l:0
#label l:1
####move $59 $5
#lw $59 $5 0
####move $60 $10
#lw $60 $10 0
#sub $60 $59 $60
#bgez $60 l:7
#sw $1 $0 -308
####move $62 $10
#addi $63 $0 -312
#lw $62 $10 0
#sw $62 $63 0
####move $64 $5
#addi $65 $0 -316
#lw $64 $5 0
#sw $64 $65 0
#addi $0 $0 -316
#call #qsrt
#subi $0 $0 -316
#lw $1 $0 -308
#addi $66 $0 -304
#move $61 $66
#label l:7
####move $67 $7
#lw $67 $7 0
####move $68 $6
#lw $68 $6 0
#sub $68 $67 $68
#bgez $68 l:8
#sw $1 $0 -308
####move $70 $6
#addi $71 $0 -312
#lw $70 $6 0
#sw $70 $71 0
####move $72 $7
#addi $73 $0 -316
#lw $72 $7 0
#sw $72 $73 0
#addi $0 $0 -316
#call #qsrt
#subi $0 $0 -316
#lw $1 $0 -308
#addi $74 $0 -304
#move $69 $74
#label l:8
#li $75 0
#addi $76 $0 12
#sw $75 $76 0
#return
#return
#----------------------------
#func #main
#addi $78 $0 -164
#move $77 $78
#move $79 $78
#li $80 1
#sw $80 $79 0
#label l:9
####move $81 $77
#lw $81 $77 0
####move $82 $3
#lw $82 $3 0
#sub $82 $81 $82
#bgtz $82 l:10
####move $83 $2
####move $84 $77
#lw $84 $77 0
#muli $85 $84 4
#add $83 $2 $85
####move $86 $3
#lw $86 $3 0
#li $87 1
#add $86 $86 $87
####move $88 $77
#lw $88 $77 0
#sub $86 $86 $88
#sw $86 $83 0
#label l:11
####move $89 $77
#move $90 $77
#lw $89 $77 0
#addi $91 $89 1
#sw $91 $90 0
#goto l:9
#label l:10
####move $93 $3
#addi $94 $0 -176
#lw $93 $3 0
#sw $93 $94 0
#li $95 1
#addi $96 $0 -180
#sw $95 $96 0
#addi $0 $0 -180
#call #qsrt
#subi $0 $0 -180
#addi $97 $0 -168
#move $92 $97
#move $98 $77
#li $99 1
#sw $99 $98 0
#label l:12
####move $100 $77
#lw $100 $77 0
####move $101 $3
#lw $101 $3 0
#sub $101 $100 $101
#bgtz $101 l:13
####move $103 $2
####move $104 $77
#lw $104 $77 0
#muli $105 $104 4
#add $103 $2 $105
#addi $106 $0 -172
#lw $103 $103 0
#sw $103 $106 0
#move $107 $108
#addi $109 $0 -176
#sw $107 $109 0
#addi $0 $0 -176
#call #printf
#subi $0 $0 -176
#label l:14
####move $110 $77
#move $111 $77
#lw $110 $77 0
#addi $112 $110 1
#sw $112 $111 0
#goto l:12
#label l:13
#move $114 $115
#addi $116 $0 -172
#sw $114 $116 0
#addi $0 $0 -172
#call #printf_single
#subi $0 $0 -172
#li $117 0
#addi $118 $0 4
#sw $117 $118 0
#return
#return
