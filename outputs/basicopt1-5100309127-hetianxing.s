.data
temp: .space 360
var0: .asciiz "%d\n"
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
sw $t0, 352($a3)
add $8, $29, -40348
sw $8, -8($sp)
lw $9, -8($sp)
move $8, $9
sw $8, -4($sp)
add $8, $29, -40352
sw $8, -16($sp)
lw $9, -16($sp)
move $8, $9
sw $8, -12($sp)
add $8, $29, -40356
sw $8, -24($sp)
lw $9, -24($sp)
move $8, $9
sw $8, -20($sp)
add $8, $29, -40360
sw $8, -32($sp)
lw $9, -32($sp)
move $8, $9
sw $8, -28($sp)
li $8, 0
sw $8, -36($sp)
lw $8, -36($sp)
lw $9, -28($sp)
sw $8, 0($9)
lw $9, -16($sp)
move $8, $9
sw $8, -40($sp)
li $8, 0
sw $8, -44($sp)
lw $8, -44($sp)
lw $9, -40($sp)
sw $8, 0($9)
label0:
lw $9, -12($sp)
lw $8, 0($9)
sw $8, -48($sp)
li $8, 100
sw $8, -52($sp)
lw $9, -48($sp)
lw $10, -52($sp)
sub $8, $9, $10
sw $8, -52($sp)
lw $8, -52($sp)
bgez $8, label1
lw $9, -20($sp)
move $8, $9
sw $8, -56($sp)
li $8, 0
sw $8, -60($sp)
lw $8, -60($sp)
lw $9, -56($sp)
sw $8, 0($9)
label3:
lw $9, -20($sp)
lw $8, 0($9)
sw $8, -64($sp)
li $8, 100
sw $8, -68($sp)
lw $9, -64($sp)
lw $10, -68($sp)
sub $8, $9, $10
sw $8, -68($sp)
lw $8, -68($sp)
bgez $8, label4
lw $9, -12($sp)
lw $8, 0($9)
sw $8, -76($sp)
lw $9, -76($sp)
mul $8, $9, 400
sw $8, -80($sp)
lw $9, -4($sp)
lw $10, -80($sp)
add $8, $9, $10
sw $8, -72($sp)
lw $9, -20($sp)
lw $8, 0($9)
sw $8, -84($sp)
lw $9, -84($sp)
mul $8, $9, 4
sw $8, -88($sp)
lw $9, -72($sp)
lw $10, -88($sp)
add $8, $9, $10
sw $8, -72($sp)
li $8, 0
sw $8, -92($sp)
lw $8, -92($sp)
lw $9, -72($sp)
sw $8, 0($9)
label5:
lw $9, -20($sp)
move $8, $9
sw $8, -100($sp)
lw $9, -20($sp)
lw $8, 0($9)
sw $8, -96($sp)
lw $9, -96($sp)
add $8, $9, 1
sw $8, -104($sp)
lw $8, -104($sp)
lw $9, -100($sp)
sw $8, 0($9)
j label3
label4:
label2:
lw $9, -12($sp)
move $8, $9
sw $8, -112($sp)
lw $9, -12($sp)
lw $8, 0($9)
sw $8, -108($sp)
lw $9, -108($sp)
add $8, $9, 1
sw $8, -116($sp)
lw $8, -116($sp)
lw $9, -112($sp)
sw $8, 0($9)
j label0
label1:
lw $9, -12($sp)
move $8, $9
sw $8, -120($sp)
li $8, 0
sw $8, -124($sp)
lw $8, -124($sp)
lw $9, -120($sp)
sw $8, 0($9)
label6:
lw $9, -12($sp)
lw $8, 0($9)
sw $8, -128($sp)
li $8, 100
sw $8, -132($sp)
lw $9, -128($sp)
lw $10, -132($sp)
sub $8, $9, $10
sw $8, -132($sp)
lw $8, -132($sp)
bgez $8, label7
lw $9, -12($sp)
lw $8, 0($9)
sw $8, -136($sp)
li $8, 20
sw $8, -140($sp)
lw $9, -136($sp)
lw $10, -140($sp)
sub $8, $9, $10
sw $8, -140($sp)
lw $8, -140($sp)
blez $8, label9
lw $9, -12($sp)
lw $8, 0($9)
sw $8, -144($sp)
li $8, 80
sw $8, -148($sp)
lw $9, -144($sp)
lw $10, -148($sp)
sub $8, $9, $10
sw $8, -148($sp)
lw $8, -148($sp)
bgez $8, label9
add $8, $29, -40364
sw $8, -156($sp)
lw $9, -156($sp)
move $8, $9
sw $8, -152($sp)
lw $9, -12($sp)
lw $8, 0($9)
sw $8, -164($sp)
lw $9, -164($sp)
mul $8, $9, 400
sw $8, -168($sp)
lw $9, -4($sp)
lw $10, -168($sp)
add $8, $9, $10
sw $8, -160($sp)
lw $8, -160($sp)
lw $9, -152($sp)
sw $8, 0($9)
lw $9, -20($sp)
move $8, $9
sw $8, -172($sp)
li $8, 0
sw $8, -176($sp)
lw $8, -176($sp)
lw $9, -172($sp)
sw $8, 0($9)
label10:
lw $9, -20($sp)
lw $8, 0($9)
sw $8, -180($sp)
li $8, 100
sw $8, -184($sp)
lw $9, -180($sp)
lw $10, -184($sp)
sub $8, $9, $10
sw $8, -184($sp)
lw $8, -184($sp)
bgez $8, label11
lw $9, -20($sp)
lw $8, 0($9)
sw $8, -188($sp)
li $8, 5
sw $8, -192($sp)
lw $9, -188($sp)
lw $10, -192($sp)
sub $8, $9, $10
sw $8, -192($sp)
lw $8, -192($sp)
bgtz $8, label14
lw $9, -12($sp)
lw $8, 0($9)
sw $8, -196($sp)
li $8, 90
sw $8, -200($sp)
lw $9, -196($sp)
lw $10, -200($sp)
sub $8, $9, $10
sw $8, -200($sp)
lw $8, -200($sp)
bgez $8, label13
label14:
lw $9, -152($sp)
lw $8, 0($9)
sw $8, -204($sp)
lw $9, -20($sp)
lw $8, 0($9)
sw $8, -208($sp)
li $8, 4
sw $8, -212($sp)
lw $9, -208($sp)
lw $10, -212($sp)
mul $8, $9, $10
sw $8, -208($sp)
lw $9, -208($sp)
mul $8, $9, 4
sw $8, -208($sp)
lw $9, -204($sp)
lw $10, -208($sp)
add $8, $9, $10
sw $8, -204($sp)
lw $9, -20($sp)
lw $8, 0($9)
sw $8, -216($sp)
li $8, 50
sw $8, -220($sp)
lw $9, -216($sp)
lw $10, -220($sp)
add $8, $9, $10
sw $8, -216($sp)
lw $8, -216($sp)
lw $9, -204($sp)
sw $8, 0($9)
label13:
label12:
lw $9, -20($sp)
move $8, $9
sw $8, -228($sp)
lw $9, -20($sp)
lw $8, 0($9)
sw $8, -224($sp)
lw $9, -224($sp)
add $8, $9, 1
sw $8, -232($sp)
lw $8, -232($sp)
lw $9, -228($sp)
sw $8, 0($9)
j label10
label11:
label9:
label8:
lw $9, -12($sp)
move $8, $9
sw $8, -240($sp)
lw $9, -12($sp)
lw $8, 0($9)
sw $8, -236($sp)
lw $9, -236($sp)
add $8, $9, 1
sw $8, -244($sp)
lw $8, -244($sp)
lw $9, -240($sp)
sw $8, 0($9)
j label6
label7:
lw $9, -12($sp)
move $8, $9
sw $8, -248($sp)
li $8, 0
sw $8, -252($sp)
lw $8, -252($sp)
lw $9, -248($sp)
sw $8, 0($9)
label15:
lw $9, -12($sp)
lw $8, 0($9)
sw $8, -256($sp)
li $8, 100
sw $8, -260($sp)
lw $9, -256($sp)
lw $10, -260($sp)
sub $8, $9, $10
sw $8, -260($sp)
lw $8, -260($sp)
bgez $8, label16
lw $9, -20($sp)
move $8, $9
sw $8, -264($sp)
li $8, 0
sw $8, -268($sp)
lw $8, -268($sp)
lw $9, -264($sp)
sw $8, 0($9)
label18:
lw $9, -20($sp)
lw $8, 0($9)
sw $8, -272($sp)
li $8, 100
sw $8, -276($sp)
lw $9, -272($sp)
lw $10, -276($sp)
sub $8, $9, $10
sw $8, -276($sp)
lw $8, -276($sp)
bgez $8, label19
lw $9, -28($sp)
move $8, $9
sw $8, -280($sp)
lw $9, -12($sp)
lw $8, 0($9)
sw $8, -288($sp)
lw $9, -288($sp)
mul $8, $9, 400
sw $8, -292($sp)
lw $9, -4($sp)
lw $10, -292($sp)
add $8, $9, $10
sw $8, -284($sp)
lw $9, -20($sp)
lw $8, 0($9)
sw $8, -296($sp)
lw $9, -296($sp)
mul $8, $9, 4
sw $8, -300($sp)
lw $9, -284($sp)
lw $10, -300($sp)
add $8, $9, $10
sw $8, -284($sp)
lw $9, -28($sp)
lw $8, 0($9)
sw $8, -304($sp)
lw $9, -284($sp)
lw $8, 0($9)
sw $8, -284($sp)
lw $9, -304($sp)
lw $10, -284($sp)
add $8, $9, $10
sw $8, -304($sp)
lw $8, -304($sp)
lw $9, -280($sp)
sw $8, 0($9)
label20:
lw $9, -20($sp)
move $8, $9
sw $8, -312($sp)
lw $9, -20($sp)
lw $8, 0($9)
sw $8, -308($sp)
lw $9, -308($sp)
add $8, $9, 1
sw $8, -316($sp)
lw $8, -316($sp)
lw $9, -312($sp)
sw $8, 0($9)
j label18
label19:
label17:
lw $9, -12($sp)
move $8, $9
sw $8, -324($sp)
lw $9, -12($sp)
lw $8, 0($9)
sw $8, -320($sp)
lw $9, -320($sp)
add $8, $9, 1
sw $8, -328($sp)
lw $8, -328($sp)
lw $9, -324($sp)
sw $8, 0($9)
j label15
label16:
add $8, $29, -40368
sw $8, -340($sp)
lw $9, -28($sp)
lw $8, 0($9)
sw $8, -336($sp)
lw $8, -336($sp)
lw $9, -340($sp)
sw $8, 0($9)
lw $9, 352($a3)
move $8, $9
sw $8, -344($sp)
add $8, $29, -40372
sw $8, -348($sp)
lw $8, -344($sp)
lw $9, -348($sp)
sw $8, 0($9)
add $29, $29, -40372
jal __printf
sub $29, $29, -40372
j __main_end
__main_end:
li $v0, 10
syscall
#string $88 #%d\n
#----------------------------
#func #main
#addi $3 $0 -40348
#move $2 $3
#addi $5 $0 -40352
#move $4 $5
#addi $7 $0 -40356
#move $6 $7
#addi $9 $0 -40360
#move $8 $9
#li $10 0
#sw $10 $8 0
#move $11 $5
#li $12 0
#sw $12 $11 0
#label l:0
####move $13 $4
#lw $13 $4 0
#li $14 100
#sub $14 $13 $14
#bgez $14 l:1
#move $15 $6
#li $16 0
#sw $16 $15 0
#label l:3
####move $17 $6
#lw $17 $6 0
#li $18 100
#sub $18 $17 $18
#bgez $18 l:4
####move $19 $2
####move $20 $4
#lw $20 $4 0
#muli $21 $20 400
#add $19 $2 $21
####move $22 $6
#lw $22 $6 0
#muli $23 $22 4
#add $19 $19 $23
#li $24 0
#sw $24 $19 0
#label l:5
####move $25 $6
#move $26 $6
#lw $25 $6 0
#addi $27 $25 1
#sw $27 $26 0
#goto l:3
#label l:4
#label l:2
####move $28 $4
#move $29 $4
#lw $28 $4 0
#addi $30 $28 1
#sw $30 $29 0
#goto l:0
#label l:1
#move $31 $4
#li $32 0
#sw $32 $31 0
#label l:6
####move $33 $4
#lw $33 $4 0
#li $34 100
#sub $34 $33 $34
#bgez $34 l:7
####move $35 $4
#lw $35 $4 0
#li $36 20
#sub $36 $35 $36
#blez $36 l:9
####move $37 $4
#lw $37 $4 0
#li $38 80
#sub $38 $37 $38
#bgez $38 l:9
#addi $40 $0 -40364
#move $39 $40
####move $41 $2
####move $42 $4
#lw $42 $4 0
#muli $43 $42 400
#add $41 $2 $43
#sw $41 $39 0
#move $44 $6
#li $45 0
#sw $45 $44 0
#label l:10
####move $46 $6
#lw $46 $6 0
#li $47 100
#sub $47 $46 $47
#bgez $47 l:11
####move $48 $6
#lw $48 $6 0
#li $49 5
#sub $49 $48 $49
#bgtz $49 l:14
####move $50 $4
#lw $50 $4 0
#li $51 90
#sub $51 $50 $51
#bgez $51 l:13
#label l:14
####move $52 $39
#lw $52 $39 0
####move $53 $6
#lw $53 $6 0
#li $54 4
#mul $53 $53 $54
#muli $53 $53 4
#add $52 $52 $53
####move $55 $6
#lw $55 $6 0
#li $56 50
#add $55 $55 $56
#sw $55 $52 0
#label l:13
#label l:12
####move $57 $6
#move $58 $6
#lw $57 $6 0
#addi $59 $57 1
#sw $59 $58 0
#goto l:10
#label l:11
#label l:9
#label l:8
####move $60 $4
#move $61 $4
#lw $60 $4 0
#addi $62 $60 1
#sw $62 $61 0
#goto l:6
#label l:7
#move $63 $4
#li $64 0
#sw $64 $63 0
#label l:15
####move $65 $4
#lw $65 $4 0
#li $66 100
#sub $66 $65 $66
#bgez $66 l:16
#move $67 $6
#li $68 0
#sw $68 $67 0
#label l:18
####move $69 $6
#lw $69 $6 0
#li $70 100
#sub $70 $69 $70
#bgez $70 l:19
#move $71 $8
####move $72 $2
####move $73 $4
#lw $73 $4 0
#muli $74 $73 400
#add $72 $2 $74
####move $75 $6
#lw $75 $6 0
#muli $76 $75 4
#add $72 $72 $76
#lw $77 $8 0
#lw $72 $72 0
#add $77 $77 $72
#sw $77 $71 0
#label l:20
####move $78 $6
#move $79 $6
#lw $78 $6 0
#addi $80 $78 1
#sw $80 $79 0
#goto l:18
#label l:19
#label l:17
####move $81 $4
#move $82 $4
#lw $81 $4 0
#addi $83 $81 1
#sw $83 $82 0
#goto l:15
#label l:16
####move $85 $8
#addi $86 $0 -40368
#lw $85 $8 0
#sw $85 $86 0
#move $87 $88
#addi $89 $0 -40372
#sw $87 $89 0
#addi $0 $0 -40372
#call #printf
#subi $0 $0 -40372
#return
