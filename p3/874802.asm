@3: 800000
@4: 70000
@5: 4000
@6: 800
@7: 0
@8: 2


jal r0, 17
lw r1, 3(r7)
lw r2, 4(r7)
lw r3, 5(r7)
lw r4, 6(r7)
lw r5, 7(r7)
lw r6, 8(r7)
add r1, r1, r2
add r3, r3, r4
add r5, r5, r6
nop
add r1, r1, r3
nop
nop
add r1, r1, r5
nop
nop
sw r1, 0(r7)
ret r0
