.data
temp: .space 472
var0: .asciiz "abcabcfeabc"
.align 2
var1: .asciiz "ab"
.align 2
var2: .asciiz "%d\n"
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
sw $t0, 20($a3)
la $t0, var1
sw $t0, 36($a3)
la $t0, var2
sw $t0, 456($a3)
add $8, $29, -464
sw $8, -8($sp)
lw $9, 20($a3)
move $8, $9
sw $8, -12($sp)
lw $9, 20($a3)
move $8, $9
sw $8, -4($sp)
add $8, $29, -468
sw $8, -20($sp)
lw $9, 36($a3)
move $8, $9
sw $8, -24($sp)
lw $9, 36($a3)
move $8, $9
sw $8, -16($sp)
add $8, $29, -472
sw $8, -32($sp)
lw $9, -32($sp)
move $8, $9
sw $8, -28($sp)
add $8, $29, -476
sw $8, -40($sp)
lw $9, -40($sp)
move $8, $9
sw $8, -36($sp)
add $8, $29, -480
sw $8, -48($sp)
lw $9, -48($sp)
move $8, $9
sw $8, -44($sp)
add $8, $29, -484
sw $8, -56($sp)
lw $9, -56($sp)
move $8, $9
sw $8, -52($sp)
add $8, $29, -488
sw $8, -64($sp)
lw $9, -64($sp)
move $8, $9
sw $8, -60($sp)
add $8, $29, -536
sw $8, -72($sp)
lw $9, -72($sp)
move $8, $9
sw $8, -68($sp)
lw $9, -64($sp)
move $8, $9
sw $8, -76($sp)
li $8, 0
sw $8, -80($sp)
lw $8, -80($sp)
lw $9, -76($sp)
sw $8, 0($9)
li $8, 0
sw $8, -88($sp)
lw $9, -88($sp)
mul $8, $9, 4
sw $8, -92($sp)
lw $9, -72($sp)
lw $10, -92($sp)
add $8, $9, $10
sw $8, -84($sp)
li $8, -1
sw $8, -96($sp)
lw $8, -96($sp)
lw $9, -84($sp)
sw $8, 0($9)
lw $9, -40($sp)
move $8, $9
sw $8, -100($sp)
li $8, -1
sw $8, -104($sp)
lw $8, -104($sp)
lw $9, -100($sp)
sw $8, 0($9)
lw $9, -48($sp)
move $8, $9
sw $8, -108($sp)
li $8, 2
sw $8, -112($sp)
lw $8, -112($sp)
lw $9, -108($sp)
sw $8, 0($9)
lw $9, -56($sp)
move $8, $9
sw $8, -116($sp)
li $8, 11
sw $8, -120($sp)
lw $8, -120($sp)
lw $9, -116($sp)
sw $8, 0($9)
lw $9, -32($sp)
move $8, $9
sw $8, -124($sp)
li $8, 1
sw $8, -128($sp)
lw $8, -128($sp)
lw $9, -124($sp)
sw $8, 0($9)
label0:
lw $9, -28($sp)
lw $8, 0($9)
sw $8, -132($sp)
lw $9, -44($sp)
lw $8, 0($9)
sw $8, -136($sp)
lw $9, -132($sp)
lw $10, -136($sp)
sub $8, $9, $10
sw $8, -136($sp)
lw $8, -136($sp)
bgez $8, label1
label3:
lw $9, -36($sp)
lw $8, 0($9)
sw $8, -140($sp)
li $8, -1
sw $8, -144($sp)
lw $9, -140($sp)
lw $10, -144($sp)
sub $8, $9, $10
sw $8, -144($sp)
lw $8, -144($sp)
beqz $8, label4
lw $9, -36($sp)
lw $8, 0($9)
sw $8, -152($sp)
li $8, 1
sw $8, -160($sp)
lw $9, -152($sp)
lw $10, -160($sp)
add $8, $9, $10
sw $8, -152($sp)
lw $9, -152($sp)
mul $8, $9, 1
sw $8, -156($sp)
lw $9, -16($sp)
lw $10, -156($sp)
add $8, $9, $10
sw $8, -148($sp)
lw $9, -148($sp)
lb $8, 0($9)
sw $8, -148($sp)
lw $9, -28($sp)
lw $8, 0($9)
sw $8, -168($sp)
lw $9, -168($sp)
mul $8, $9, 1
sw $8, -172($sp)
lw $9, -16($sp)
lw $10, -172($sp)
add $8, $9, $10
sw $8, -164($sp)
lw $9, -164($sp)
lb $8, 0($9)
sw $8, -164($sp)
lw $9, -148($sp)
lw $10, -164($sp)
sub $8, $9, $10
sw $8, -164($sp)
lw $8, -164($sp)
beqz $8, label4
lw $9, -36($sp)
move $8, $9
sw $8, -176($sp)
lw $9, -36($sp)
lw $8, 0($9)
sw $8, -184($sp)
lw $9, -184($sp)
mul $8, $9, 4
sw $8, -188($sp)
lw $9, -68($sp)
lw $10, -188($sp)
add $8, $9, $10
sw $8, -180($sp)
lw $9, -180($sp)
lw $8, 0($9)
sw $8, -180($sp)
lw $8, -180($sp)
lw $9, -176($sp)
sw $8, 0($9)
j label3
label4:
lw $9, -36($sp)
lw $8, 0($9)
sw $8, -196($sp)
li $8, 1
sw $8, -204($sp)
lw $9, -196($sp)
lw $10, -204($sp)
add $8, $9, $10
sw $8, -196($sp)
lw $9, -196($sp)
mul $8, $9, 1
sw $8, -200($sp)
lw $9, -16($sp)
lw $10, -200($sp)
add $8, $9, $10
sw $8, -192($sp)
lw $9, -192($sp)
lb $8, 0($9)
sw $8, -192($sp)
lw $9, -28($sp)
lw $8, 0($9)
sw $8, -212($sp)
lw $9, -212($sp)
mul $8, $9, 1
sw $8, -216($sp)
lw $9, -16($sp)
lw $10, -216($sp)
add $8, $9, $10
sw $8, -208($sp)
lw $9, -208($sp)
lb $8, 0($9)
sw $8, -208($sp)
lw $9, -192($sp)
lw $10, -208($sp)
sub $8, $9, $10
sw $8, -208($sp)
lw $8, -208($sp)
bnez $8, label5
lw $9, -36($sp)
move $8, $9
sw $8, -224($sp)
lw $9, -36($sp)
lw $8, 0($9)
sw $8, -220($sp)
lw $9, -220($sp)
add $8, $9, 1
sw $8, -228($sp)
lw $8, -228($sp)
lw $9, -224($sp)
sw $8, 0($9)
label5:
lw $9, -28($sp)
lw $8, 0($9)
sw $8, -236($sp)
lw $9, -236($sp)
mul $8, $9, 4
sw $8, -240($sp)
lw $9, -68($sp)
lw $10, -240($sp)
add $8, $9, $10
sw $8, -232($sp)
lw $9, -36($sp)
lw $8, 0($9)
sw $8, -244($sp)
lw $8, -244($sp)
lw $9, -232($sp)
sw $8, 0($9)
label2:
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
j label0
label1:
lw $9, -36($sp)
move $8, $9
sw $8, -260($sp)
li $8, -1
sw $8, -264($sp)
lw $8, -264($sp)
lw $9, -260($sp)
sw $8, 0($9)
lw $9, -28($sp)
move $8, $9
sw $8, -268($sp)
li $8, 0
sw $8, -272($sp)
lw $8, -272($sp)
lw $9, -268($sp)
sw $8, 0($9)
label6:
lw $9, -28($sp)
lw $8, 0($9)
sw $8, -276($sp)
lw $9, -52($sp)
lw $8, 0($9)
sw $8, -280($sp)
lw $9, -276($sp)
lw $10, -280($sp)
sub $8, $9, $10
sw $8, -280($sp)
lw $8, -280($sp)
bgez $8, label7
label9:
lw $9, -36($sp)
lw $8, 0($9)
sw $8, -284($sp)
li $8, -1
sw $8, -288($sp)
lw $9, -284($sp)
lw $10, -288($sp)
sub $8, $9, $10
sw $8, -288($sp)
lw $8, -288($sp)
beqz $8, label10
lw $9, -36($sp)
lw $8, 0($9)
sw $8, -296($sp)
li $8, 1
sw $8, -304($sp)
lw $9, -296($sp)
lw $10, -304($sp)
add $8, $9, $10
sw $8, -296($sp)
lw $9, -296($sp)
mul $8, $9, 1
sw $8, -300($sp)
lw $9, -16($sp)
lw $10, -300($sp)
add $8, $9, $10
sw $8, -292($sp)
lw $9, -292($sp)
lb $8, 0($9)
sw $8, -292($sp)
lw $9, -28($sp)
lw $8, 0($9)
sw $8, -312($sp)
lw $9, -312($sp)
mul $8, $9, 1
sw $8, -316($sp)
lw $9, -4($sp)
lw $10, -316($sp)
add $8, $9, $10
sw $8, -308($sp)
lw $9, -308($sp)
lb $8, 0($9)
sw $8, -308($sp)
lw $9, -292($sp)
lw $10, -308($sp)
sub $8, $9, $10
sw $8, -308($sp)
lw $8, -308($sp)
beqz $8, label10
lw $9, -36($sp)
move $8, $9
sw $8, -320($sp)
lw $9, -36($sp)
lw $8, 0($9)
sw $8, -328($sp)
lw $9, -328($sp)
mul $8, $9, 4
sw $8, -332($sp)
lw $9, -68($sp)
lw $10, -332($sp)
add $8, $9, $10
sw $8, -324($sp)
lw $9, -324($sp)
lw $8, 0($9)
sw $8, -324($sp)
lw $8, -324($sp)
lw $9, -320($sp)
sw $8, 0($9)
j label9
label10:
lw $9, -36($sp)
lw $8, 0($9)
sw $8, -340($sp)
li $8, 1
sw $8, -348($sp)
lw $9, -340($sp)
lw $10, -348($sp)
add $8, $9, $10
sw $8, -340($sp)
lw $9, -340($sp)
mul $8, $9, 1
sw $8, -344($sp)
lw $9, -16($sp)
lw $10, -344($sp)
add $8, $9, $10
sw $8, -336($sp)
lw $9, -336($sp)
lb $8, 0($9)
sw $8, -336($sp)
lw $9, -28($sp)
lw $8, 0($9)
sw $8, -356($sp)
lw $9, -356($sp)
mul $8, $9, 1
sw $8, -360($sp)
lw $9, -4($sp)
lw $10, -360($sp)
add $8, $9, $10
sw $8, -352($sp)
lw $9, -352($sp)
lb $8, 0($9)
sw $8, -352($sp)
lw $9, -336($sp)
lw $10, -352($sp)
sub $8, $9, $10
sw $8, -352($sp)
lw $8, -352($sp)
bnez $8, label11
lw $9, -36($sp)
move $8, $9
sw $8, -368($sp)
lw $9, -36($sp)
lw $8, 0($9)
sw $8, -364($sp)
lw $9, -364($sp)
add $8, $9, 1
sw $8, -372($sp)
lw $8, -372($sp)
lw $9, -368($sp)
sw $8, 0($9)
label11:
lw $9, -36($sp)
lw $8, 0($9)
sw $8, -376($sp)
lw $9, -44($sp)
lw $8, 0($9)
sw $8, -380($sp)
li $8, 1
sw $8, -384($sp)
lw $9, -380($sp)
lw $10, -384($sp)
sub $8, $9, $10
sw $8, -380($sp)
lw $9, -376($sp)
lw $10, -380($sp)
sub $8, $9, $10
sw $8, -380($sp)
lw $8, -380($sp)
bnez $8, label12
lw $9, -60($sp)
move $8, $9
sw $8, -392($sp)
lw $9, -60($sp)
lw $8, 0($9)
sw $8, -388($sp)
lw $9, -388($sp)
add $8, $9, 1
sw $8, -396($sp)
lw $8, -396($sp)
lw $9, -392($sp)
sw $8, 0($9)
lw $9, -36($sp)
move $8, $9
sw $8, -400($sp)
lw $9, -36($sp)
lw $8, 0($9)
sw $8, -408($sp)
lw $9, -408($sp)
mul $8, $9, 4
sw $8, -412($sp)
lw $9, -68($sp)
lw $10, -412($sp)
add $8, $9, $10
sw $8, -404($sp)
lw $9, -404($sp)
lw $8, 0($9)
sw $8, -404($sp)
lw $8, -404($sp)
lw $9, -400($sp)
sw $8, 0($9)
label12:
label8:
lw $9, -28($sp)
move $8, $9
sw $8, -420($sp)
lw $9, -28($sp)
lw $8, 0($9)
sw $8, -416($sp)
lw $9, -416($sp)
add $8, $9, 1
sw $8, -424($sp)
lw $8, -424($sp)
lw $9, -420($sp)
sw $8, 0($9)
j label6
label7:
add $8, $29, -544
sw $8, -436($sp)
lw $9, -60($sp)
lw $8, 0($9)
sw $8, -432($sp)
lw $8, -432($sp)
lw $9, -436($sp)
sw $8, 0($9)
lw $9, 456($a3)
move $8, $9
sw $8, -440($sp)
add $8, $29, -548
sw $8, -444($sp)
lw $8, -440($sp)
lw $9, -444($sp)
sw $8, 0($9)
add $29, $29, -548
jal __printf
sub $29, $29, -548
li $8, 0
sw $8, -448($sp)
add $8, $29, 4
sw $8, -452($sp)
lw $8, -448($sp)
lw $9, -452($sp)
sw $8, 0($9)
j __main_end
j __main_end
__main_end:
li $v0, 10
syscall
#string $5 #abcabcfeabc
#string $9 #ab
#string $114 #%d\n
#----------------------------
#func #main
#addi $3 $0 -464
####move $2 $3
#move $4 $5
#move $2 $5
#addi $7 $0 -468
####move $6 $7
#move $8 $9
#move $6 $9
#addi $11 $0 -472
#move $10 $11
#addi $13 $0 -476
#move $12 $13
#addi $15 $0 -480
#move $14 $15
#addi $17 $0 -484
#move $16 $17
#addi $19 $0 -488
#move $18 $19
#addi $21 $0 -536
#move $20 $21
#move $22 $19
#li $23 0
#sw $23 $22 0
####move $24 $21
#li $25 0
#muli $26 $25 4
#add $24 $21 $26
#li $27 -1
#sw $27 $24 0
#move $28 $13
#li $29 -1
#sw $29 $28 0
#move $30 $15
#li $31 2
#sw $31 $30 0
#move $32 $17
#li $33 11
#sw $33 $32 0
#move $34 $11
#li $35 1
#sw $35 $34 0
#label l:0
####move $36 $10
#lw $36 $10 0
####move $37 $14
#lw $37 $14 0
#sub $37 $36 $37
#bgez $37 l:1
#label l:3
####move $38 $12
#lw $38 $12 0
#li $39 -1
#sub $39 $38 $39
#beqz $39 l:4
####move $40 $6
####move $41 $12
#lw $41 $12 0
#li $43 1
#add $41 $41 $43
#muli $42 $41 1
#add $40 $6 $42
#lb $40 $40 0
####move $44 $6
####move $45 $10
#lw $45 $10 0
#muli $46 $45 1
#add $44 $6 $46
#lb $44 $44 0
#sub $44 $40 $44
#beqz $44 l:4
#move $47 $12
####move $48 $20
####move $49 $12
#lw $49 $12 0
#muli $50 $49 4
#add $48 $20 $50
#lw $48 $48 0
#sw $48 $47 0
#goto l:3
#label l:4
####move $51 $6
####move $52 $12
#lw $52 $12 0
#li $54 1
#add $52 $52 $54
#muli $53 $52 1
#add $51 $6 $53
#lb $51 $51 0
####move $55 $6
####move $56 $10
#lw $56 $10 0
#muli $57 $56 1
#add $55 $6 $57
#lb $55 $55 0
#sub $55 $51 $55
#bnez $55 l:5
####move $58 $12
#move $59 $12
#lw $58 $12 0
#addi $60 $58 1
#sw $60 $59 0
#label l:5
####move $61 $20
####move $62 $10
#lw $62 $10 0
#muli $63 $62 4
#add $61 $20 $63
####move $64 $12
#lw $64 $12 0
#sw $64 $61 0
#label l:2
####move $65 $10
#move $66 $10
#lw $65 $10 0
#addi $67 $65 1
#sw $67 $66 0
#goto l:0
#label l:1
#move $68 $12
#li $69 -1
#sw $69 $68 0
#move $70 $10
#li $71 0
#sw $71 $70 0
#label l:6
####move $72 $10
#lw $72 $10 0
####move $73 $16
#lw $73 $16 0
#sub $73 $72 $73
#bgez $73 l:7
#label l:9
####move $74 $12
#lw $74 $12 0
#li $75 -1
#sub $75 $74 $75
#beqz $75 l:10
####move $76 $6
####move $77 $12
#lw $77 $12 0
#li $79 1
#add $77 $77 $79
#muli $78 $77 1
#add $76 $6 $78
#lb $76 $76 0
####move $80 $2
####move $81 $10
#lw $81 $10 0
#muli $82 $81 1
#add $80 $2 $82
#lb $80 $80 0
#sub $80 $76 $80
#beqz $80 l:10
#move $83 $12
####move $84 $20
####move $85 $12
#lw $85 $12 0
#muli $86 $85 4
#add $84 $20 $86
#lw $84 $84 0
#sw $84 $83 0
#goto l:9
#label l:10
####move $87 $6
####move $88 $12
#lw $88 $12 0
#li $90 1
#add $88 $88 $90
#muli $89 $88 1
#add $87 $6 $89
#lb $87 $87 0
####move $91 $2
####move $92 $10
#lw $92 $10 0
#muli $93 $92 1
#add $91 $2 $93
#lb $91 $91 0
#sub $91 $87 $91
#bnez $91 l:11
####move $94 $12
#move $95 $12
#lw $94 $12 0
#addi $96 $94 1
#sw $96 $95 0
#label l:11
####move $97 $12
#lw $97 $12 0
####move $98 $14
#lw $98 $14 0
#li $99 1
#sub $98 $98 $99
#sub $98 $97 $98
#bnez $98 l:12
####move $100 $18
#move $101 $18
#lw $100 $18 0
#addi $102 $100 1
#sw $102 $101 0
#move $103 $12
####move $104 $20
####move $105 $12
#lw $105 $12 0
#muli $106 $105 4
#add $104 $20 $106
#lw $104 $104 0
#sw $104 $103 0
#label l:12
#label l:8
####move $107 $10
#move $108 $10
#lw $107 $10 0
#addi $109 $107 1
#sw $109 $108 0
#goto l:6
#label l:7
####move $111 $18
#addi $112 $0 -544
#lw $111 $18 0
#sw $111 $112 0
#move $113 $114
#addi $115 $0 -548
#sw $113 $115 0
#addi $0 $0 -548
#call #printf
#subi $0 $0 -548
#li $116 0
#addi $117 $0 4
#sw $116 $117 0
#return
#return
