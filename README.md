# 2020 NTUEE Computer Architecture
2020 Fall

## HW1 

## Sort

### Salt-and-pepper noisedenoising with median filter

## HW2 Gaussian filter
Implement Gaussian filter on bitmap.

## HW3 RISC-V instruction decoder
Implement 23 RISC-V instructions
`JAL,JALR,BEQ,BNE,LD,SD,ADDI,SLTI,XORI,ORI,ANDI,SLLI,SRLI,SRAI,ADD,SUB,SLL,SLT,XOR,SRL,SRA,OR,AND`

```
Inst  func7    func3 opcode
JAL                  1101111
JALR                 1100111
BEQ            000   1100011
BNE            001   1100011
LD             011   0000011
SD             011   0100011
ADDI           000   0010011
SLTI           010   0010011
XORI           100   0010011
ORI            110   0010011
ANDI           111   0010011
SLLI  0000000  001   0010011
SRLI  0000000  101   0010011
SRAI  0100000  101   0010011
ADD   0000000  000   0110011
SUB   0100000  000   0110011
SLL   0000000  001   0110011
SLT   0000000  010   0110011
XOR   0000000  100   0110011
SRL   0000000  101   0110011
SRA   0100000  101   0110011
OR    0000000  100   0110011
AND   0000000  111   0110011
```