    .section .text
    .globl _start

_start:  


## VALUES TO CHECK for correctness (12 in total)
# x0 - not written to
# x1 0xf 
# x2 0xf0
# x3 0xfffff800
# x6 0xAD 
# x8 0xBE 
# x11 0x66 
# x13 0x88
# x20 0x66 
# x22 0x88
# x25 0x55 
# x28 0x99


# Phase 4 should still work
addi x1, x0, 15
addi x2, x0, 0xF0
addi x3, x0,  -2048 # 0x800 
nop
nop
nop
nop
add x0, x1, x2
add x4, x1, x2
nop
nop
nop
nop
# end Phase 4 should still work test
# Check x0, x1, x2, and x3 
# x0 - not written to
# x1 0xf, x2 0xf0, x3 0xfffff800


##### rs1 tests

# addi - rs1 1 cycle away (will fwd from ME stage (EXME signal))
addi x5, x0, 0x0AB
addi x6, x5, 0x02 # check x6 (should be 0xAD)

# addi - rs1 2 cycle away (will fwd from ME stage (EXME signal))
addi x7, x0, 0x0BC
nop
addi x8, x7, 0x02 # check x8 (should be 0xBE)

nop
nop
addi x9, x0, 0x11 # use as non-forwaded other input
nop 
nop 
nop 

# add - rs1 1 cycle away (will fwd from ME stage (EXME signal))
addi x10, x0, 0x055
add x11, x10, x9 # check x11 (should be 0x66)

# add - rs1 2 cycle away (will fwd from ME stage (EXME signal))
addi x12, x0, 0x077
nop
add x13, x12, x9 # check x13 (should be 0x88)

##### end rs1 tests

##### rs2 tests

nop
nop
addi x18, x0, 0x11 # use as non-forwaded other input
nop 
nop 
nop 

# add - rs2 1 cycle away (will fwd from ME stage (EXME signal))
addi x19, x0, 0x055
add x20, x18, x19 # check x20 (should be 0x66)

# add - rs2 2 cycle away (will fwd from ME stage (EXME signal))
addi x21, x0, 0x077
nop
add x22, x9, x21 # check x22 (should be 0x88)


##### end testing rs2

nop
nop


#### both rs1 and rs2 

# Test rs1 and rs2 forwarding at same time (rs2 1 cycle away, rs1 2 cycles away)
addi x23, x0, 0x022
addi x24, x0, 0x033
add x25, x23, x24 # check x25 (should be 0x55)

nop
nop

# Test rs1 and rs2 forwarding at same time, but reverse (rs1 1 cycle away, rs2 2 cycles away) 
addi x26, x0, 0x044
addi x27, x0, 0x055
add x28, x27, x26 # check x28 (should be 0x99)

nop
nop
nop
nop
