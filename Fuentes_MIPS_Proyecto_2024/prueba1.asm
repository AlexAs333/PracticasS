jal r0, 2
nop
beq r3, r3, -1
lw r1, 5(r7)
add r1, r1, r1
sw r1, 0(r7)
ret r0
