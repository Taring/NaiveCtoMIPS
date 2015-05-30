.data
temp: .space 280
var0: .space 4
var1: .space 15004
var2: .space 4
var3: .asciiz "%d %d\n"
.align 2
var4: .asciiz "Total: %d\n"
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
sw $t0, 16($a3)
la $t0, var2
sw $t0, 20($a3)
la $t0, var3
sw $t0, 184($a3)
la $t0, var4
sw $t0, 264($a3)
li $8, 15000
sw $8, 12($a3)
lw $8, 12($a3)
lw $9, 8($a3)
sw $8, 0($9)
li $8, 0
sw $8, 24($a3)
lw $8, 24($a3)
lw $9, 20($a3)
sw $8, 0($9)
add $8, $29, -248
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
label0:
lw $9, -4($sp)
lw $8, 0($9)
sw $8, -20($sp)
lw $9, 8($a3)
lw $8, 0($9)
sw $8, -24($sp)
lw $9, -20($sp)
lw $10, -24($sp)
sub $8, $9, $10
sw $8, -24($sp)
lw $8, -24($sp)
bgtz $8, label1
lw $9, -4($sp)
lw $8, 0($9)
sw $8, -32($sp)
lw $9, -32($sp)
mul $8, $9, 1
sw $8, -36($sp)
lw $9, 16($a3)
lw $10, -36($sp)
add $8, $9, $10
sw $8, -28($sp)
li $8, 1
sw $8, -40($sp)
lw $8, -40($sp)
lw $9, -28($sp)
sb $8, 0($9)
label2:
lw $9, -4($sp)
move $8, $9
sw $8, -48($sp)
lw $9, -4($sp)
lw $8, 0($9)
sw $8, -44($sp)
lw $9, -44($sp)
add $8, $9, 1
sw $8, -52($sp)
lw $8, -52($sp)
lw $9, -48($sp)
sw $8, 0($9)
j label0
label1:
lw $9, -4($sp)
move $8, $9
sw $8, -56($sp)
li $8, 2
sw $8, -60($sp)
lw $8, -60($sp)
lw $9, -56($sp)
sw $8, 0($9)
label3:
lw $9, -4($sp)
lw $8, 0($9)
sw $8, -64($sp)
lw $9, 8($a3)
lw $8, 0($9)
sw $8, -68($sp)
lw $9, -64($sp)
lw $10, -68($sp)
sub $8, $9, $10
sw $8, -68($sp)
lw $8, -68($sp)
bgtz $8, label4
lw $9, -4($sp)
lw $8, 0($9)
sw $8, -76($sp)
lw $9, -76($sp)
mul $8, $9, 1
sw $8, -80($sp)
lw $9, 16($a3)
lw $10, -80($sp)
add $8, $9, $10
sw $8, -72($sp)
lw $9, -72($sp)
lb $8, 0($9)
sw $8, -72($sp)
lw $8, -72($sp)
beqz $8, label6
add $8, $29, -252
sw $8, -88($sp)
lw $9, -88($sp)
move $8, $9
sw $8, -84($sp)
li $8, 2
sw $8, -92($sp)
lw $8, -92($sp)
lw $9, -84($sp)
sw $8, 0($9)
lw $9, -4($sp)
lw $8, 0($9)
sw $8, -96($sp)
li $8, 3
sw $8, -100($sp)
lw $9, -96($sp)
lw $10, -100($sp)
sub $8, $9, $10
sw $8, -100($sp)
lw $8, -100($sp)
blez $8, label7
lw $9, -4($sp)
lw $8, 0($9)
sw $8, -108($sp)
li $8, 2
sw $8, -116($sp)
lw $9, -108($sp)
lw $10, -116($sp)
sub $8, $9, $10
sw $8, -108($sp)
lw $9, -108($sp)
mul $8, $9, 1
sw $8, -112($sp)
lw $9, 16($a3)
lw $10, -112($sp)
add $8, $9, $10
sw $8, -104($sp)
lw $9, -104($sp)
lb $8, 0($9)
sw $8, -104($sp)
lw $8, -104($sp)
beqz $8, label7
lw $9, 20($a3)
move $8, $9
sw $8, -124($sp)
lw $9, 20($a3)
lw $8, 0($9)
sw $8, -120($sp)
lw $9, -120($sp)
add $8, $9, 1
sw $8, -128($sp)
lw $8, -128($sp)
lw $9, -124($sp)
sw $8, 0($9)
add $8, $29, -260
sw $8, -140($sp)
lw $9, -4($sp)
lw $8, 0($9)
sw $8, -136($sp)
lw $8, -136($sp)
lw $9, -140($sp)
sw $8, 0($9)
lw $9, -4($sp)
lw $8, 0($9)
sw $8, -144($sp)
li $8, 2
sw $8, -148($sp)
lw $9, -144($sp)
lw $10, -148($sp)
sub $8, $9, $10
sw $8, -144($sp)
add $8, $29, -264
sw $8, -152($sp)
lw $8, -144($sp)
lw $9, -152($sp)
sw $8, 0($9)
lw $9, 184($a3)
move $8, $9
sw $8, -156($sp)
add $8, $29, -268
sw $8, -160($sp)
lw $8, -156($sp)
lw $9, -160($sp)
sw $8, 0($9)
add $29, $29, -268
jal __printf
sub $29, $29, -268
label7:
label8:
lw $9, -4($sp)
lw $8, 0($9)
sw $8, -164($sp)
lw $9, -84($sp)
lw $8, 0($9)
sw $8, -168($sp)
lw $9, -164($sp)
lw $10, -168($sp)
mul $8, $9, $10
sw $8, -164($sp)
lw $9, 8($a3)
lw $8, 0($9)
sw $8, -172($sp)
lw $9, -164($sp)
lw $10, -172($sp)
sub $8, $9, $10
sw $8, -172($sp)
lw $8, -172($sp)
bgtz $8, label9
lw $9, -4($sp)
lw $8, 0($9)
sw $8, -180($sp)
lw $9, -84($sp)
lw $8, 0($9)
sw $8, -188($sp)
lw $9, -180($sp)
lw $10, -188($sp)
mul $8, $9, $10
sw $8, -180($sp)
lw $9, -180($sp)
mul $8, $9, 1
sw $8, -184($sp)
lw $9, 16($a3)
lw $10, -184($sp)
add $8, $9, $10
sw $8, -176($sp)
li $8, 0
sw $8, -192($sp)
lw $8, -192($sp)
lw $9, -176($sp)
sb $8, 0($9)
lw $9, -84($sp)
move $8, $9
sw $8, -200($sp)
lw $9, -84($sp)
lw $8, 0($9)
sw $8, -196($sp)
lw $9, -196($sp)
add $8, $9, 1
sw $8, -204($sp)
lw $8, -204($sp)
lw $9, -200($sp)
sw $8, 0($9)
j label8
label9:
label6:
label5:
lw $9, -4($sp)
move $8, $9
sw $8, -212($sp)
lw $9, -4($sp)
lw $8, 0($9)
sw $8, -208($sp)
lw $9, -208($sp)
add $8, $9, 1
sw $8, -216($sp)
lw $8, -216($sp)
lw $9, -212($sp)
sw $8, 0($9)
j label3
label4:
add $8, $29, -256
sw $8, -228($sp)
lw $9, 20($a3)
lw $8, 0($9)
sw $8, -224($sp)
lw $8, -224($sp)
lw $9, -228($sp)
sw $8, 0($9)
lw $9, 264($a3)
move $8, $9
sw $8, -232($sp)
add $8, $29, -260
sw $8, -236($sp)
lw $8, -232($sp)
lw $9, -236($sp)
sw $8, 0($9)
add $29, $29, -260
jal __printf
sub $29, $29, -260
li $8, 0
sw $8, -240($sp)
add $8, $29, 4
sw $8, -244($sp)
lw $8, -240($sp)
lw $9, -244($sp)
sw $8, 0($9)
j __main_end
j __main_end
__main_end:
li $v0, 10
syscall
#global $2 4
#global $4 15004
#global $5 4
#string $46 #%d %d\n
#string $66 #Total: %d\n
#li $3 15000
#sw $3 $2 0
#li $6 0
#sw $6 $5 0
#----------------------------
#func #main
#addi $8 $0 -248
#move $7 $8
#move $9 $8
#li $10 1
#sw $10 $9 0
#label l:0
####move $11 $7
#lw $11 $7 0
####move $12 $2
#lw $12 $2 0
#sub $12 $11 $12
#bgtz $12 l:1
####move $13 $4
####move $14 $7
#lw $14 $7 0
#muli $15 $14 1
#add $13 $4 $15
#li $16 1
#sb $16 $13 0
#label l:2
####move $17 $7
#move $18 $7
#lw $17 $7 0
#addi $19 $17 1
#sw $19 $18 0
#goto l:0
#label l:1
#move $20 $7
#li $21 2
#sw $21 $20 0
#label l:3
####move $22 $7
#lw $22 $7 0
####move $23 $2
#lw $23 $2 0
#sub $23 $22 $23
#bgtz $23 l:4
####move $24 $4
####move $25 $7
#lw $25 $7 0
#muli $26 $25 1
#add $24 $4 $26
#lb $24 $24 0
#beqz $24 l:6
#addi $28 $0 -252
#move $27 $28
#li $29 2
#sw $29 $27 0
####move $30 $7
#lw $30 $7 0
#li $31 3
#sub $31 $30 $31
#blez $31 l:7
####move $32 $4
####move $33 $7
#lw $33 $7 0
#li $35 2
#sub $33 $33 $35
#muli $34 $33 1
#add $32 $4 $34
#lb $32 $32 0
#beqz $32 l:7
####move $36 $5
#move $37 $5
#lw $36 $5 0
#addi $38 $36 1
#sw $38 $37 0
####move $40 $7
#addi $41 $0 -260
#lw $40 $7 0
#sw $40 $41 0
####move $42 $7
#lw $42 $7 0
#li $43 2
#sub $42 $42 $43
#addi $44 $0 -264
#sw $42 $44 0
#move $45 $46
#addi $47 $0 -268
#sw $45 $47 0
#addi $0 $0 -268
#call #printf
#subi $0 $0 -268
#label l:7
#label l:8
####move $48 $7
#lw $48 $7 0
####move $49 $27
#lw $49 $27 0
#mul $48 $48 $49
####move $50 $2
#lw $50 $2 0
#sub $50 $48 $50
#bgtz $50 l:9
####move $51 $4
####move $52 $7
#lw $52 $7 0
####move $54 $27
#lw $54 $27 0
#mul $52 $52 $54
#muli $53 $52 1
#add $51 $4 $53
#li $55 0
#sb $55 $51 0
####move $56 $27
#move $57 $27
#lw $56 $27 0
#addi $58 $56 1
#sw $58 $57 0
#goto l:8
#label l:9
#label l:6
#label l:5
####move $59 $7
#move $60 $7
#lw $59 $7 0
#addi $61 $59 1
#sw $61 $60 0
#goto l:3
#label l:4
####move $63 $5
#addi $64 $0 -256
#lw $63 $5 0
#sw $63 $64 0
#move $65 $66
#addi $67 $0 -260
#sw $65 $67 0
#addi $0 $0 -260
#call #printf
#subi $0 $0 -260
#li $68 0
#addi $69 $0 4
#sw $68 $69 0
#return
#return
