.data
temp: .space 376
var0: .space 40000
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
sw $t0, 8($a3)
la $t0, var1
sw $t0, 352($a3)
add $8, $29, -364
sw $8, -8($sp)
lw $9, -8($sp)
move $8, $9
sw $8, -4($sp)
add $8, $29, -368
sw $8, -16($sp)
lw $9, -16($sp)
move $8, $9
sw $8, -12($sp)
add $8, $29, -372
sw $8, -24($sp)
lw $9, -24($sp)
move $8, $9
sw $8, -20($sp)
add $8, $29, -376
sw $8, -32($sp)
lw $9, -32($sp)
move $8, $9
sw $8, -28($sp)
add $8, $29, -380
sw $8, -40($sp)
lw $9, -40($sp)
move $8, $9
sw $8, -36($sp)
add $8, $29, -384
sw $8, -48($sp)
lw $9, -48($sp)
move $8, $9
sw $8, -44($sp)
add $8, $29, -388
sw $8, -56($sp)
lw $9, -56($sp)
move $8, $9
sw $8, -52($sp)
lw $9, -8($sp)
move $8, $9
sw $8, -60($sp)
li $8, 0
sw $8, -64($sp)
lw $8, -64($sp)
lw $9, -60($sp)
sw $8, 0($9)
label0:
lw $9, -4($sp)
lw $8, 0($9)
sw $8, -68($sp)
li $8, 10
sw $8, -72($sp)
lw $9, -68($sp)
lw $10, -72($sp)
sub $8, $9, $10
sw $8, -72($sp)
lw $8, -72($sp)
bgez $8, label1
lw $9, -36($sp)
move $8, $9
sw $8, -76($sp)
lw $9, -4($sp)
lw $8, 0($9)
sw $8, -84($sp)
lw $9, -84($sp)
mul $8, $9, 4000
sw $8, -88($sp)
lw $9, 8($a3)
lw $10, -88($sp)
add $8, $9, $10
sw $8, -80($sp)
lw $8, -80($sp)
lw $9, -76($sp)
sw $8, 0($9)
lw $9, -12($sp)
move $8, $9
sw $8, -92($sp)
li $8, 0
sw $8, -96($sp)
lw $8, -96($sp)
lw $9, -92($sp)
sw $8, 0($9)
label3:
lw $9, -12($sp)
lw $8, 0($9)
sw $8, -100($sp)
li $8, 10
sw $8, -104($sp)
lw $9, -100($sp)
lw $10, -104($sp)
sub $8, $9, $10
sw $8, -104($sp)
lw $8, -104($sp)
bgez $8, label4
lw $9, -44($sp)
move $8, $9
sw $8, -108($sp)
lw $9, -4($sp)
lw $8, 0($9)
sw $8, -116($sp)
lw $9, -116($sp)
mul $8, $9, 4000
sw $8, -120($sp)
lw $9, 8($a3)
lw $10, -120($sp)
add $8, $9, $10
sw $8, -112($sp)
lw $9, -12($sp)
lw $8, 0($9)
sw $8, -124($sp)
lw $9, -124($sp)
mul $8, $9, 400
sw $8, -128($sp)
lw $9, -112($sp)
lw $10, -128($sp)
add $8, $9, $10
sw $8, -112($sp)
lw $8, -112($sp)
lw $9, -108($sp)
sw $8, 0($9)
lw $9, -20($sp)
move $8, $9
sw $8, -132($sp)
li $8, 0
sw $8, -136($sp)
lw $8, -136($sp)
lw $9, -132($sp)
sw $8, 0($9)
label6:
lw $9, -20($sp)
lw $8, 0($9)
sw $8, -140($sp)
li $8, 10
sw $8, -144($sp)
lw $9, -140($sp)
lw $10, -144($sp)
sub $8, $9, $10
sw $8, -144($sp)
lw $8, -144($sp)
bgez $8, label7
lw $9, -52($sp)
move $8, $9
sw $8, -148($sp)
lw $9, -4($sp)
lw $8, 0($9)
sw $8, -156($sp)
lw $9, -156($sp)
mul $8, $9, 4000
sw $8, -160($sp)
lw $9, 8($a3)
lw $10, -160($sp)
add $8, $9, $10
sw $8, -152($sp)
lw $9, -12($sp)
lw $8, 0($9)
sw $8, -164($sp)
lw $9, -164($sp)
mul $8, $9, 400
sw $8, -168($sp)
lw $9, -152($sp)
lw $10, -168($sp)
add $8, $9, $10
sw $8, -152($sp)
lw $9, -20($sp)
lw $8, 0($9)
sw $8, -172($sp)
lw $9, -172($sp)
mul $8, $9, 40
sw $8, -176($sp)
lw $9, -152($sp)
lw $10, -176($sp)
add $8, $9, $10
sw $8, -152($sp)
lw $8, -152($sp)
lw $9, -148($sp)
sw $8, 0($9)
lw $9, -28($sp)
move $8, $9
sw $8, -180($sp)
li $8, 0
sw $8, -184($sp)
lw $8, -184($sp)
lw $9, -180($sp)
sw $8, 0($9)
label9:
lw $9, -28($sp)
lw $8, 0($9)
sw $8, -188($sp)
li $8, 10
sw $8, -192($sp)
lw $9, -188($sp)
lw $10, -192($sp)
sub $8, $9, $10
sw $8, -192($sp)
lw $8, -192($sp)
bgez $8, label10
lw $9, -4($sp)
lw $8, 0($9)
sw $8, -200($sp)
lw $9, -200($sp)
mul $8, $9, 4000
sw $8, -204($sp)
lw $9, 8($a3)
lw $10, -204($sp)
add $8, $9, $10
sw $8, -196($sp)
lw $9, -12($sp)
lw $8, 0($9)
sw $8, -208($sp)
lw $9, -208($sp)
mul $8, $9, 400
sw $8, -212($sp)
lw $9, -196($sp)
lw $10, -212($sp)
add $8, $9, $10
sw $8, -196($sp)
lw $9, -20($sp)
lw $8, 0($9)
sw $8, -216($sp)
lw $9, -216($sp)
mul $8, $9, 40
sw $8, -220($sp)
lw $9, -196($sp)
lw $10, -220($sp)
add $8, $9, $10
sw $8, -196($sp)
lw $9, -28($sp)
lw $8, 0($9)
sw $8, -224($sp)
lw $9, -224($sp)
mul $8, $9, 4
sw $8, -228($sp)
lw $9, -196($sp)
lw $10, -228($sp)
add $8, $9, $10
sw $8, -196($sp)
lw $9, -4($sp)
lw $8, 0($9)
sw $8, -232($sp)
lw $9, -12($sp)
lw $8, 0($9)
sw $8, -236($sp)
lw $9, -232($sp)
lw $10, -236($sp)
add $8, $9, $10
sw $8, -232($sp)
lw $9, -20($sp)
lw $8, 0($9)
sw $8, -240($sp)
lw $9, -232($sp)
lw $10, -240($sp)
add $8, $9, $10
sw $8, -232($sp)
lw $9, -28($sp)
lw $8, 0($9)
sw $8, -244($sp)
lw $9, -232($sp)
lw $10, -244($sp)
add $8, $9, $10
sw $8, -232($sp)
lw $8, -232($sp)
lw $9, -196($sp)
sw $8, 0($9)
label11:
lw $9, -28($sp)
move $8, $9
sw $8, -252($sp)
lw $9, -28($sp)
lw $8, 0($9)
sw $8, -248($sp)
lw $9, -248($sp)
add $8, $9, 1
sw $8, -256($sp)
lw $8, -256($sp)
lw $9, -252($sp)
sw $8, 0($9)
j label9
label10:
label8:
lw $9, -20($sp)
move $8, $9
sw $8, -264($sp)
lw $9, -20($sp)
lw $8, 0($9)
sw $8, -260($sp)
lw $9, -260($sp)
add $8, $9, 1
sw $8, -268($sp)
lw $8, -268($sp)
lw $9, -264($sp)
sw $8, 0($9)
j label6
label7:
label5:
lw $9, -12($sp)
move $8, $9
sw $8, -276($sp)
lw $9, -12($sp)
lw $8, 0($9)
sw $8, -272($sp)
lw $9, -272($sp)
add $8, $9, 1
sw $8, -280($sp)
lw $8, -280($sp)
lw $9, -276($sp)
sw $8, 0($9)
j label3
label4:
label2:
lw $9, -4($sp)
move $8, $9
sw $8, -288($sp)
lw $9, -4($sp)
lw $8, 0($9)
sw $8, -284($sp)
lw $9, -284($sp)
add $8, $9, 1
sw $8, -292($sp)
lw $8, -292($sp)
lw $9, -288($sp)
sw $8, 0($9)
j label0
label1:
li $8, 5
sw $8, -304($sp)
lw $9, -304($sp)
mul $8, $9, 4000
sw $8, -308($sp)
lw $9, 8($a3)
lw $10, -308($sp)
add $8, $9, $10
sw $8, -300($sp)
li $8, 5
sw $8, -312($sp)
lw $9, -312($sp)
mul $8, $9, 400
sw $8, -316($sp)
lw $9, -300($sp)
lw $10, -316($sp)
add $8, $9, $10
sw $8, -300($sp)
li $8, 5
sw $8, -320($sp)
lw $9, -320($sp)
mul $8, $9, 40
sw $8, -324($sp)
lw $9, -300($sp)
lw $10, -324($sp)
add $8, $9, $10
sw $8, -300($sp)
li $8, 5
sw $8, -328($sp)
lw $9, -328($sp)
mul $8, $9, 4
sw $8, -332($sp)
lw $9, -300($sp)
lw $10, -332($sp)
add $8, $9, $10
sw $8, -300($sp)
add $8, $29, -396
sw $8, -336($sp)
lw $9, -300($sp)
lw $8, 0($9)
sw $8, -300($sp)
lw $8, -300($sp)
lw $9, -336($sp)
sw $8, 0($9)
lw $9, 352($a3)
move $8, $9
sw $8, -340($sp)
add $8, $29, -400
sw $8, -344($sp)
lw $8, -340($sp)
lw $9, -344($sp)
sw $8, 0($9)
add $29, $29, -400
jal __printf
sub $29, $29, -400
li $8, 0
sw $8, -348($sp)
add $8, $29, 4
sw $8, -352($sp)
lw $8, -348($sp)
lw $9, -352($sp)
sw $8, 0($9)
j __main_end
li $8, 0
sw $8, -356($sp)
add $8, $29, 4
sw $8, -360($sp)
lw $8, -356($sp)
lw $9, -360($sp)
sw $8, 0($9)
j __main_end
j __main_end
__main_end:
li $v0, 10
syscall
#global $2 40000
#string $88 #%d\n
#----------------------------
#func #main
#addi $4 $0 -364
#move $3 $4
#addi $6 $0 -368
#move $5 $6
#addi $8 $0 -372
#move $7 $8
#addi $10 $0 -376
#move $9 $10
#addi $12 $0 -380
#move $11 $12
#addi $14 $0 -384
#move $13 $14
#addi $16 $0 -388
#move $15 $16
#move $17 $4
#li $18 0
#sw $18 $17 0
#label l:0
####move $19 $3
#lw $19 $3 0
#li $20 10
#sub $20 $19 $20
#bgez $20 l:1
#move $21 $11
####move $22 $2
####move $23 $3
#lw $23 $3 0
#muli $24 $23 4000
#add $22 $2 $24
#sw $22 $21 0
#move $25 $5
#li $26 0
#sw $26 $25 0
#label l:3
####move $27 $5
#lw $27 $5 0
#li $28 10
#sub $28 $27 $28
#bgez $28 l:4
#move $29 $13
####move $30 $2
####move $31 $3
#lw $31 $3 0
#muli $32 $31 4000
#add $30 $2 $32
####move $33 $5
#lw $33 $5 0
#muli $34 $33 400
#add $30 $30 $34
#sw $30 $29 0
#move $35 $7
#li $36 0
#sw $36 $35 0
#label l:6
####move $37 $7
#lw $37 $7 0
#li $38 10
#sub $38 $37 $38
#bgez $38 l:7
#move $39 $15
####move $40 $2
####move $41 $3
#lw $41 $3 0
#muli $42 $41 4000
#add $40 $2 $42
####move $43 $5
#lw $43 $5 0
#muli $44 $43 400
#add $40 $40 $44
####move $45 $7
#lw $45 $7 0
#muli $46 $45 40
#add $40 $40 $46
#sw $40 $39 0
#move $47 $9
#li $48 0
#sw $48 $47 0
#label l:9
####move $49 $9
#lw $49 $9 0
#li $50 10
#sub $50 $49 $50
#bgez $50 l:10
####move $51 $2
####move $52 $3
#lw $52 $3 0
#muli $53 $52 4000
#add $51 $2 $53
####move $54 $5
#lw $54 $5 0
#muli $55 $54 400
#add $51 $51 $55
####move $56 $7
#lw $56 $7 0
#muli $57 $56 40
#add $51 $51 $57
####move $58 $9
#lw $58 $9 0
#muli $59 $58 4
#add $51 $51 $59
####move $60 $3
#lw $60 $3 0
####move $61 $5
#lw $61 $5 0
#add $60 $60 $61
####move $62 $7
#lw $62 $7 0
#add $60 $60 $62
####move $63 $9
#lw $63 $9 0
#add $60 $60 $63
#sw $60 $51 0
#label l:11
####move $64 $9
#move $65 $9
#lw $64 $9 0
#addi $66 $64 1
#sw $66 $65 0
#goto l:9
#label l:10
#label l:8
####move $67 $7
#move $68 $7
#lw $67 $7 0
#addi $69 $67 1
#sw $69 $68 0
#goto l:6
#label l:7
#label l:5
####move $70 $5
#move $71 $5
#lw $70 $5 0
#addi $72 $70 1
#sw $72 $71 0
#goto l:3
#label l:4
#label l:2
####move $73 $3
#move $74 $3
#lw $73 $3 0
#addi $75 $73 1
#sw $75 $74 0
#goto l:0
#label l:1
####move $77 $2
#li $78 5
#muli $79 $78 4000
#add $77 $2 $79
#li $80 5
#muli $81 $80 400
#add $77 $77 $81
#li $82 5
#muli $83 $82 40
#add $77 $77 $83
#li $84 5
#muli $85 $84 4
#add $77 $77 $85
#addi $86 $0 -396
#lw $77 $77 0
#sw $77 $86 0
#move $87 $88
#addi $89 $0 -400
#sw $87 $89 0
#addi $0 $0 -400
#call #printf
#subi $0 $0 -400
#li $90 0
#addi $91 $0 4
#sw $90 $91 0
#return
#li $92 0
#addi $93 $0 4
#sw $92 $93 0
#return
#return
