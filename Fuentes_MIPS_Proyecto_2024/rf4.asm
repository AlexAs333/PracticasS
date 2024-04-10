@3: 2
@4: 3


lw r1, 3(r7)
lw r2, 4(r7)
jal r1, 1
jal r2, 2
nop
ret r1
beq r1, r3, 12
nop 
ret r2
beq r2, r3, 12
