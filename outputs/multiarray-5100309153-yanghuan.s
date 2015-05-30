.data
temp: .space 572
var0: .space 160
var1: .space 4
var2: .space 4
var3: .space 40
var4: .asciiz "%d"
.align 2
var5: .asciiz "\n"
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

__printNum:
add $8, $29, 0
sw $8, -4($sp)
sw $31, -40($29)
add $8, $29, -44
sw $8, -16($sp)
lw $9, -4($sp)
lw $8, 0($9)
sw $8, -12($sp)
lw $8, -12($sp)
lw $9, -16($sp)
sw $8, 0($9)
lw $9, 44($a3)
move $8, $9
sw $8, -20($sp)
add $8, $29, -48
sw $8, -24($sp)
lw $8, -20($sp)
lw $9, -24($sp)
sw $8, 0($9)
add $29, $29, -48
jal __printf
sub $29, $29, -48
lw $31, -40($29)
sw $31, -40($29)
lw $9, 60($a3)
move $8, $9
sw $8, -32($sp)
add $8, $29, -44
sw $8, -36($sp)
lw $8, -32($sp)
lw $9, -36($sp)
sw $8, 0($9)
add $29, $29, -44
jal __printf_single
sub $29, $29, -44
lw $31, -40($29)
jr $ra
main:
la $a3, temp
la $t0, var0
sw $t0, 8($a3)
la $t0, var1
sw $t0, 12($a3)
la $t0, var2
sw $t0, 16($a3)
la $t0, var3
sw $t0, 20($a3)
la $t0, var4
sw $t0, 44($a3)
la $t0, var5
sw $t0, 60($a3)
lw $9, 12($a3)
move $8, $9
sw $8, -4($sp)
li $8, 0
sw $8, -8($sp)
lw $8, -8($sp)
lw $9, -4($sp)
sw $8, 0($9)
label0:
lw $9, 12($a3)
lw $8, 0($9)
sw $8, -12($sp)
li $8, 4
sw $8, -16($sp)
lw $9, -12($sp)
lw $10, -16($sp)
sub $8, $9, $10
sw $8, -16($sp)
lw $8, -16($sp)
bgez $8, label1
lw $9, 16($a3)
move $8, $9
sw $8, -20($sp)
li $8, 0
sw $8, -24($sp)
lw $8, -24($sp)
lw $9, -20($sp)
sw $8, 0($9)
label3:
lw $9, 16($a3)
lw $8, 0($9)
sw $8, -28($sp)
li $8, 10
sw $8, -32($sp)
lw $9, -28($sp)
lw $10, -32($sp)
sub $8, $9, $10
sw $8, -32($sp)
lw $8, -32($sp)
bgez $8, label4
lw $9, 12($a3)
lw $8, 0($9)
sw $8, -40($sp)
lw $9, -40($sp)
mul $8, $9, 40
sw $8, -44($sp)
lw $9, 8($a3)
lw $10, -44($sp)
add $8, $9, $10
sw $8, -36($sp)
lw $9, 16($a3)
lw $8, 0($9)
sw $8, -48($sp)
lw $9, -48($sp)
mul $8, $9, 4
sw $8, -52($sp)
lw $9, -36($sp)
lw $10, -52($sp)
add $8, $9, $10
sw $8, -36($sp)
li $8, 888
sw $8, -56($sp)
lw $8, -56($sp)
lw $9, -36($sp)
sw $8, 0($9)
label5:
lw $9, 16($a3)
move $8, $9
sw $8, -64($sp)
lw $9, 16($a3)
lw $8, 0($9)
sw $8, -60($sp)
lw $9, -60($sp)
add $8, $9, 1
sw $8, -68($sp)
lw $8, -68($sp)
lw $9, -64($sp)
sw $8, 0($9)
j label3
label4:
label2:
lw $9, 12($a3)
move $8, $9
sw $8, -76($sp)
lw $9, 12($a3)
lw $8, 0($9)
sw $8, -72($sp)
lw $9, -72($sp)
add $8, $9, 1
sw $8, -80($sp)
lw $8, -80($sp)
lw $9, -76($sp)
sw $8, 0($9)
j label0
label1:
lw $9, 12($a3)
move $8, $9
sw $8, -84($sp)
li $8, 0
sw $8, -88($sp)
lw $8, -88($sp)
lw $9, -84($sp)
sw $8, 0($9)
label6:
lw $9, 12($a3)
lw $8, 0($9)
sw $8, -92($sp)
li $8, 5
sw $8, -96($sp)
lw $9, -92($sp)
lw $10, -96($sp)
sub $8, $9, $10
sw $8, -96($sp)
lw $8, -96($sp)
bgez $8, label7
lw $9, 12($a3)
lw $8, 0($9)
sw $8, -104($sp)
lw $9, -104($sp)
mul $8, $9, 8
sw $8, -108($sp)
lw $9, 20($a3)
lw $10, -108($sp)
add $8, $9, $10
sw $8, -100($sp)
lw $9, -100($sp)
add $8, $9, 0
sw $8, -100($sp)
li $8, -1
sw $8, -112($sp)
lw $8, -112($sp)
lw $9, -100($sp)
sw $8, 0($9)
label8:
lw $9, 12($a3)
move $8, $9
sw $8, -120($sp)
lw $9, 12($a3)
lw $8, 0($9)
sw $8, -116($sp)
lw $9, -116($sp)
add $8, $9, 1
sw $8, -124($sp)
lw $8, -124($sp)
lw $9, -120($sp)
sw $8, 0($9)
j label6
label7:
li $8, 3
sw $8, -136($sp)
lw $9, -136($sp)
mul $8, $9, 40
sw $8, -140($sp)
lw $9, 8($a3)
lw $10, -140($sp)
add $8, $9, $10
sw $8, -132($sp)
li $8, 9
sw $8, -144($sp)
lw $9, -144($sp)
mul $8, $9, 4
sw $8, -148($sp)
lw $9, -132($sp)
lw $10, -148($sp)
add $8, $9, $10
sw $8, -132($sp)
add $8, $29, -516
sw $8, -152($sp)
lw $9, -132($sp)
lw $8, 0($9)
sw $8, -132($sp)
lw $8, -132($sp)
lw $9, -152($sp)
sw $8, 0($9)
add $29, $29, -516
jal __printNum
sub $29, $29, -516
add $8, $29, -508
sw $8, -156($sp)
lw $9, -156($sp)
move $8, $9
sw $8, -128($sp)
lw $9, 12($a3)
move $8, $9
sw $8, -160($sp)
li $8, 0
sw $8, -164($sp)
lw $8, -164($sp)
lw $9, -160($sp)
sw $8, 0($9)
label9:
lw $9, 12($a3)
lw $8, 0($9)
sw $8, -168($sp)
li $8, 3
sw $8, -172($sp)
lw $9, -168($sp)
lw $10, -172($sp)
sub $8, $9, $10
sw $8, -172($sp)
lw $8, -172($sp)
bgtz $8, label10
lw $9, 16($a3)
move $8, $9
sw $8, -176($sp)
li $8, 0
sw $8, -180($sp)
lw $8, -180($sp)
lw $9, -176($sp)
sw $8, 0($9)
label12:
lw $9, 16($a3)
lw $8, 0($9)
sw $8, -184($sp)
li $8, 9
sw $8, -188($sp)
lw $9, -184($sp)
lw $10, -188($sp)
sub $8, $9, $10
sw $8, -188($sp)
lw $8, -188($sp)
bgtz $8, label13
lw $9, 12($a3)
lw $8, 0($9)
sw $8, -196($sp)
lw $9, -196($sp)
mul $8, $9, 40
sw $8, -200($sp)
lw $9, 8($a3)
lw $10, -200($sp)
add $8, $9, $10
sw $8, -192($sp)
lw $9, 16($a3)
lw $8, 0($9)
sw $8, -204($sp)
lw $9, -204($sp)
mul $8, $9, 4
sw $8, -208($sp)
lw $9, -192($sp)
lw $10, -208($sp)
add $8, $9, $10
sw $8, -192($sp)
lw $9, 12($a3)
lw $8, 0($9)
sw $8, -212($sp)
li $8, 10
sw $8, -216($sp)
lw $9, -212($sp)
lw $10, -216($sp)
mul $8, $9, $10
sw $8, -212($sp)
lw $9, 16($a3)
lw $8, 0($9)
sw $8, -220($sp)
lw $9, -212($sp)
lw $10, -220($sp)
add $8, $9, $10
sw $8, -212($sp)
lw $8, -212($sp)
lw $9, -192($sp)
sw $8, 0($9)
label14:
lw $9, 16($a3)
move $8, $9
sw $8, -228($sp)
lw $9, 16($a3)
lw $8, 0($9)
sw $8, -224($sp)
lw $9, -224($sp)
add $8, $9, 1
sw $8, -232($sp)
lw $8, -232($sp)
lw $9, -228($sp)
sw $8, 0($9)
j label12
label13:
label11:
lw $9, 12($a3)
move $8, $9
sw $8, -240($sp)
lw $9, 12($a3)
lw $8, 0($9)
sw $8, -236($sp)
lw $9, -236($sp)
add $8, $9, 1
sw $8, -244($sp)
lw $8, -244($sp)
lw $9, -240($sp)
sw $8, 0($9)
j label9
label10:
lw $9, 12($a3)
move $8, $9
sw $8, -248($sp)
li $8, 0
sw $8, -252($sp)
lw $8, -252($sp)
lw $9, -248($sp)
sw $8, 0($9)
label15:
lw $9, 12($a3)
lw $8, 0($9)
sw $8, -256($sp)
li $8, 3
sw $8, -260($sp)
lw $9, -256($sp)
lw $10, -260($sp)
sub $8, $9, $10
sw $8, -260($sp)
lw $8, -260($sp)
bgtz $8, label16
lw $9, 16($a3)
move $8, $9
sw $8, -264($sp)
li $8, 0
sw $8, -268($sp)
lw $8, -268($sp)
lw $9, -264($sp)
sw $8, 0($9)
label18:
lw $9, 16($a3)
lw $8, 0($9)
sw $8, -272($sp)
li $8, 9
sw $8, -276($sp)
lw $9, -272($sp)
lw $10, -276($sp)
sub $8, $9, $10
sw $8, -276($sp)
lw $8, -276($sp)
bgtz $8, label19
lw $9, 12($a3)
lw $8, 0($9)
sw $8, -288($sp)
lw $9, -288($sp)
mul $8, $9, 40
sw $8, -292($sp)
lw $9, 8($a3)
lw $10, -292($sp)
add $8, $9, $10
sw $8, -284($sp)
lw $9, 16($a3)
lw $8, 0($9)
sw $8, -296($sp)
lw $9, -296($sp)
mul $8, $9, 4
sw $8, -300($sp)
lw $9, -284($sp)
lw $10, -300($sp)
add $8, $9, $10
sw $8, -284($sp)
add $8, $29, -516
sw $8, -304($sp)
lw $9, -284($sp)
lw $8, 0($9)
sw $8, -284($sp)
lw $8, -284($sp)
lw $9, -304($sp)
sw $8, 0($9)
add $29, $29, -516
jal __printNum
sub $29, $29, -516
add $8, $29, -508
sw $8, -308($sp)
lw $9, -308($sp)
move $8, $9
sw $8, -280($sp)
label20:
lw $9, 16($a3)
move $8, $9
sw $8, -316($sp)
lw $9, 16($a3)
lw $8, 0($9)
sw $8, -312($sp)
lw $9, -312($sp)
add $8, $9, 1
sw $8, -320($sp)
lw $8, -320($sp)
lw $9, -316($sp)
sw $8, 0($9)
j label18
label19:
label17:
lw $9, 12($a3)
move $8, $9
sw $8, -328($sp)
lw $9, 12($a3)
lw $8, 0($9)
sw $8, -324($sp)
lw $9, -324($sp)
add $8, $9, 1
sw $8, -332($sp)
lw $8, -332($sp)
lw $9, -328($sp)
sw $8, 0($9)
j label15
label16:
li $8, 2
sw $8, -340($sp)
lw $9, -340($sp)
mul $8, $9, 40
sw $8, -344($sp)
lw $9, 8($a3)
lw $10, -344($sp)
add $8, $9, $10
sw $8, -336($sp)
li $8, 10
sw $8, -348($sp)
lw $9, -348($sp)
mul $8, $9, 4
sw $8, -352($sp)
lw $9, -336($sp)
lw $10, -352($sp)
add $8, $9, $10
sw $8, -336($sp)
li $8, 0
sw $8, -356($sp)
lw $8, -356($sp)
lw $9, -336($sp)
sw $8, 0($9)
li $8, 2
sw $8, -368($sp)
lw $9, -368($sp)
mul $8, $9, 40
sw $8, -372($sp)
lw $9, 8($a3)
lw $10, -372($sp)
add $8, $9, $10
sw $8, -364($sp)
li $8, 10
sw $8, -376($sp)
lw $9, -376($sp)
mul $8, $9, 4
sw $8, -380($sp)
lw $9, -364($sp)
lw $10, -380($sp)
add $8, $9, $10
sw $8, -364($sp)
add $8, $29, -516
sw $8, -384($sp)
lw $9, -364($sp)
lw $8, 0($9)
sw $8, -364($sp)
lw $8, -364($sp)
lw $9, -384($sp)
sw $8, 0($9)
add $29, $29, -516
jal __printNum
sub $29, $29, -516
add $8, $29, -508
sw $8, -388($sp)
lw $9, 60($a3)
move $8, $9
sw $8, -396($sp)
add $8, $29, -512
sw $8, -400($sp)
lw $8, -396($sp)
lw $9, -400($sp)
sw $8, 0($9)
add $29, $29, -512
jal __printf_single
sub $29, $29, -512
li $8, 0
sw $8, -408($sp)
lw $9, -408($sp)
mul $8, $9, 8
sw $8, -412($sp)
lw $9, 20($a3)
lw $10, -412($sp)
add $8, $9, $10
sw $8, -404($sp)
lw $9, -404($sp)
add $8, $9, 0
sw $8, -404($sp)
li $8, -2
sw $8, -416($sp)
lw $8, -416($sp)
lw $9, -404($sp)
sw $8, 0($9)
li $8, 2
sw $8, -432($sp)
lw $9, -432($sp)
mul $8, $9, 40
sw $8, -436($sp)
lw $9, 8($a3)
lw $10, -436($sp)
add $8, $9, $10
sw $8, -424($sp)
li $8, 10
sw $8, -440($sp)
lw $9, -440($sp)
mul $8, $9, 4
sw $8, -444($sp)
lw $9, -424($sp)
lw $10, -444($sp)
add $8, $9, $10
sw $8, -424($sp)
lw $9, -424($sp)
lw $8, 0($9)
sw $8, -424($sp)
lw $9, -424($sp)
mul $8, $9, 8
sw $8, -428($sp)
lw $9, 20($a3)
lw $10, -428($sp)
add $8, $9, $10
sw $8, -420($sp)
lw $9, -420($sp)
add $8, $9, 0
sw $8, -420($sp)
li $8, -10
sw $8, -448($sp)
lw $8, -448($sp)
lw $9, -420($sp)
sw $8, 0($9)
li $8, 0
sw $8, -460($sp)
lw $9, -460($sp)
mul $8, $9, 8
sw $8, -464($sp)
lw $9, 20($a3)
lw $10, -464($sp)
add $8, $9, $10
sw $8, -456($sp)
lw $9, -456($sp)
add $8, $9, 0
sw $8, -456($sp)
add $8, $29, -516
sw $8, -468($sp)
lw $9, -456($sp)
lw $8, 0($9)
sw $8, -456($sp)
lw $8, -456($sp)
lw $9, -468($sp)
sw $8, 0($9)
add $29, $29, -516
jal __printNum
sub $29, $29, -516
add $8, $29, -508
sw $8, -472($sp)
li $8, 1
sw $8, -484($sp)
lw $9, -484($sp)
mul $8, $9, 8
sw $8, -488($sp)
lw $9, 20($a3)
lw $10, -488($sp)
add $8, $9, $10
sw $8, -480($sp)
lw $9, -480($sp)
add $8, $9, 0
sw $8, -480($sp)
add $8, $29, -516
sw $8, -492($sp)
lw $9, -480($sp)
lw $8, 0($9)
sw $8, -480($sp)
lw $8, -480($sp)
lw $9, -492($sp)
sw $8, 0($9)
add $29, $29, -516
jal __printNum
sub $29, $29, -516
add $8, $29, -508
sw $8, -496($sp)
li $8, 0
sw $8, -500($sp)
add $8, $29, 4
sw $8, -504($sp)
lw $8, -500($sp)
lw $9, -504($sp)
sw $8, 0($9)
j __main_end
j __main_end
__main_end:
li $v0, 10
syscall
#global $2 160
#global $3 4
#global $4 4
#global $5 40
#string $11 #%d
#string $15 #\n
#----------------------------
#func #printNum
#addi $6 $0 0
#sw $1 $0 -40
####move $8 $6
#addi $9 $0 -44
#lw $8 $6 0
#sw $8 $9 0
#move $10 $11
#addi $12 $0 -48
#sw $10 $12 0
#addi $0 $0 -48
#call #printf
#subi $0 $0 -48
#lw $1 $0 -40
#sw $1 $0 -40
#move $14 $15
#addi $16 $0 -44
#sw $14 $16 0
#addi $0 $0 -44
#call #printf_single
#subi $0 $0 -44
#lw $1 $0 -40
#return
#----------------------------
#func #main
#move $17 $3
#li $18 0
#sw $18 $17 0
#label l:0
####move $19 $3
#lw $19 $3 0
#li $20 4
#sub $20 $19 $20
#bgez $20 l:1
#move $21 $4
#li $22 0
#sw $22 $21 0
#label l:3
####move $23 $4
#lw $23 $4 0
#li $24 10
#sub $24 $23 $24
#bgez $24 l:4
####move $25 $2
####move $26 $3
#lw $26 $3 0
#muli $27 $26 40
#add $25 $2 $27
####move $28 $4
#lw $28 $4 0
#muli $29 $28 4
#add $25 $25 $29
#li $30 888
#sw $30 $25 0
#label l:5
####move $31 $4
#move $32 $4
#lw $31 $4 0
#addi $33 $31 1
#sw $33 $32 0
#goto l:3
#label l:4
#label l:2
####move $34 $3
#move $35 $3
#lw $34 $3 0
#addi $36 $34 1
#sw $36 $35 0
#goto l:0
#label l:1
#move $37 $3
#li $38 0
#sw $38 $37 0
#label l:6
####move $39 $3
#lw $39 $3 0
#li $40 5
#sub $40 $39 $40
#bgez $40 l:7
####move $41 $5
####move $42 $3
#lw $42 $3 0
#muli $43 $42 8
#add $41 $5 $43
#addi $41 $41 0
#li $44 -1
#sw $44 $41 0
#label l:8
####move $45 $3
#move $46 $3
#lw $45 $3 0
#addi $47 $45 1
#sw $47 $46 0
#goto l:6
#label l:7
####move $49 $2
#li $50 3
#muli $51 $50 40
#add $49 $2 $51
#li $52 9
#muli $53 $52 4
#add $49 $49 $53
#addi $54 $0 -516
#lw $49 $49 0
#sw $49 $54 0
#addi $0 $0 -516
#call #printNum
#subi $0 $0 -516
#addi $55 $0 -508
#move $48 $55
#move $56 $3
#li $57 0
#sw $57 $56 0
#label l:9
####move $58 $3
#lw $58 $3 0
#li $59 3
#sub $59 $58 $59
#bgtz $59 l:10
#move $60 $4
#li $61 0
#sw $61 $60 0
#label l:12
####move $62 $4
#lw $62 $4 0
#li $63 9
#sub $63 $62 $63
#bgtz $63 l:13
####move $64 $2
####move $65 $3
#lw $65 $3 0
#muli $66 $65 40
#add $64 $2 $66
####move $67 $4
#lw $67 $4 0
#muli $68 $67 4
#add $64 $64 $68
####move $69 $3
#lw $69 $3 0
#li $70 10
#mul $69 $69 $70
####move $71 $4
#lw $71 $4 0
#add $69 $69 $71
#sw $69 $64 0
#label l:14
####move $72 $4
#move $73 $4
#lw $72 $4 0
#addi $74 $72 1
#sw $74 $73 0
#goto l:12
#label l:13
#label l:11
####move $75 $3
#move $76 $3
#lw $75 $3 0
#addi $77 $75 1
#sw $77 $76 0
#goto l:9
#label l:10
#move $78 $3
#li $79 0
#sw $79 $78 0
#label l:15
####move $80 $3
#lw $80 $3 0
#li $81 3
#sub $81 $80 $81
#bgtz $81 l:16
#move $82 $4
#li $83 0
#sw $83 $82 0
#label l:18
####move $84 $4
#lw $84 $4 0
#li $85 9
#sub $85 $84 $85
#bgtz $85 l:19
####move $87 $2
####move $88 $3
#lw $88 $3 0
#muli $89 $88 40
#add $87 $2 $89
####move $90 $4
#lw $90 $4 0
#muli $91 $90 4
#add $87 $87 $91
#addi $92 $0 -516
#lw $87 $87 0
#sw $87 $92 0
#addi $0 $0 -516
#call #printNum
#subi $0 $0 -516
#addi $93 $0 -508
#move $86 $93
#label l:20
####move $94 $4
#move $95 $4
#lw $94 $4 0
#addi $96 $94 1
#sw $96 $95 0
#goto l:18
#label l:19
#label l:17
####move $97 $3
#move $98 $3
#lw $97 $3 0
#addi $99 $97 1
#sw $99 $98 0
#goto l:15
#label l:16
####move $100 $2
#li $101 2
#muli $102 $101 40
#add $100 $2 $102
#li $103 10
#muli $104 $103 4
#add $100 $100 $104
#li $105 0
#sw $105 $100 0
####move $107 $2
#li $108 2
#muli $109 $108 40
#add $107 $2 $109
#li $110 10
#muli $111 $110 4
#add $107 $107 $111
#addi $112 $0 -516
#lw $107 $107 0
#sw $107 $112 0
#addi $0 $0 -516
#call #printNum
#subi $0 $0 -516
#addi $113 $0 -508
####move $106 $113
#move $115 $15
#addi $116 $0 -512
#sw $115 $116 0
#addi $0 $0 -512
#call #printf_single
#subi $0 $0 -512
####move $117 $5
#li $118 0
#muli $119 $118 8
#add $117 $5 $119
#addi $117 $117 0
#li $120 -2
#sw $120 $117 0
####move $121 $5
####move $122 $2
#li $124 2
#muli $125 $124 40
#add $122 $2 $125
#li $126 10
#muli $127 $126 4
#add $122 $122 $127
#lw $122 $122 0
#muli $123 $122 8
#add $121 $5 $123
#addi $121 $121 0
#li $128 -10
#sw $128 $121 0
####move $130 $5
#li $131 0
#muli $132 $131 8
#add $130 $5 $132
#addi $130 $130 0
#addi $133 $0 -516
#lw $130 $130 0
#sw $130 $133 0
#addi $0 $0 -516
#call #printNum
#subi $0 $0 -516
#addi $134 $0 -508
####move $129 $134
####move $136 $5
#li $137 1
#muli $138 $137 8
#add $136 $5 $138
#addi $136 $136 0
#addi $139 $0 -516
#lw $136 $136 0
#sw $136 $139 0
#addi $0 $0 -516
#call #printNum
#subi $0 $0 -516
#addi $140 $0 -508
####move $135 $140
#li $141 0
#addi $142 $0 4
#sw $141 $142 0
#return
#return
