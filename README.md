# 2020 NTUEE Computer Architecture
2020 Fall

## HW1 

## Sort

### Salt-and-pepper noisedenoising with median filter

## HW2 Gaussian filter
Implement Gaussian filter on bitmap.

## HW3 RISC-V instruction decoder
Implement decodeing of 23 RISC-V instructions
`JAL,JALR,BEQ,BNE,LD,SD,ADDI,SLTI,XORI,ORI,ANDI,SLLI,SRLI,SRAI,ADD,SUB,SLL,SLT,XOR,SRL,SRA,OR,AND`

```
No.  Inst  func7    func3 opcode
1    JAL                  1101111
2    JALR                 1100111
3    BEQ            000   1100011
4    BNE            001   1100011
5    LD             011   0000011
6    SD             011   0100011
7    ADDI           000   0010011
8    SLTI           010   0010011
9    XORI           100   0010011
10   ORI            110   0010011
11   ANDI           111   0010011
12   SLLI  0000000  001   0010011
13   SRLI  0000000  101   0010011
14   SRAI  0100000  101   0010011
15   ADD   0000000  000   0110011
16   SUB   0100000  000   0110011
17   SLL   0000000  001   0110011
18   SLT   0000000  010   0110011
19   XOR   0000000  100   0110011
20   SRL   0000000  101   0110011
21   SRA   0100000  101   0110011
22   OR    0000000  100   0110011
23   AND   0000000  111   0110011
```

## HW4 Verilog RISC-V controller
