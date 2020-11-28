/////////////////////////////////////////////////////////////
// Created by: Synopsys DC Expert(TM) in wire load mode
// Version   : N-2017.09-SP2
// Date      : Sat Nov 28 23:04:05 2020
/////////////////////////////////////////////////////////////


module CHIP_DW01_inc_0 ( A, SUM );
  input [29:0] A;
  output [29:0] SUM;

  wire   [29:2] carry;

  ADDHX2 U1_1_27 ( .A(A[27]), .B(carry[27]), .CO(carry[28]), .S(SUM[27]) );
  ADDHX2 U1_1_28 ( .A(A[28]), .B(carry[28]), .CO(carry[29]), .S(SUM[28]) );
  ADDHX2 U1_1_13 ( .A(A[13]), .B(carry[13]), .CO(carry[14]), .S(SUM[13]) );
  CMPR22X2 U1_1_26 ( .A(A[26]), .B(carry[26]), .CO(carry[27]), .S(SUM[26]) );
  ADDHXL U1_1_23 ( .A(A[23]), .B(carry[23]), .CO(carry[24]), .S(SUM[23]) );
  ADDHXL U1_1_22 ( .A(A[22]), .B(carry[22]), .CO(carry[23]), .S(SUM[22]) );
  ADDHXL U1_1_21 ( .A(A[21]), .B(carry[21]), .CO(carry[22]), .S(SUM[21]) );
  ADDHXL U1_1_20 ( .A(A[20]), .B(carry[20]), .CO(carry[21]), .S(SUM[20]) );
  ADDHXL U1_1_19 ( .A(A[19]), .B(carry[19]), .CO(carry[20]), .S(SUM[19]) );
  ADDHXL U1_1_18 ( .A(A[18]), .B(carry[18]), .CO(carry[19]), .S(SUM[18]) );
  ADDHXL U1_1_17 ( .A(A[17]), .B(carry[17]), .CO(carry[18]), .S(SUM[17]) );
  ADDHXL U1_1_16 ( .A(A[16]), .B(carry[16]), .CO(carry[17]), .S(SUM[16]) );
  ADDHXL U1_1_15 ( .A(A[15]), .B(carry[15]), .CO(carry[16]), .S(SUM[15]) );
  ADDHXL U1_1_14 ( .A(A[14]), .B(carry[14]), .CO(carry[15]), .S(SUM[14]) );
  ADDHX2 U1_1_11 ( .A(A[11]), .B(carry[11]), .CO(carry[12]), .S(SUM[11]) );
  ADDHX4 U1_1_12 ( .A(A[12]), .B(carry[12]), .CO(carry[13]), .S(SUM[12]) );
  ADDHX2 U1_1_9 ( .A(A[9]), .B(carry[9]), .CO(carry[10]), .S(SUM[9]) );
  ADDHX4 U1_1_10 ( .A(A[10]), .B(carry[10]), .CO(carry[11]), .S(SUM[10]) );
  ADDHX2 U1_1_7 ( .A(A[7]), .B(carry[7]), .CO(carry[8]), .S(SUM[7]) );
  ADDHX4 U1_1_8 ( .A(A[8]), .B(carry[8]), .CO(carry[9]), .S(SUM[8]) );
  ADDHX2 U1_1_5 ( .A(A[5]), .B(carry[5]), .CO(carry[6]), .S(SUM[5]) );
  ADDHX4 U1_1_6 ( .A(A[6]), .B(carry[6]), .CO(carry[7]), .S(SUM[6]) );
  ADDHX2 U1_1_3 ( .A(A[3]), .B(carry[3]), .CO(carry[4]), .S(SUM[3]) );
  ADDHX4 U1_1_4 ( .A(A[4]), .B(carry[4]), .CO(carry[5]), .S(SUM[4]) );
  ADDHX1 U1_1_1 ( .A(A[1]), .B(A[0]), .CO(carry[2]), .S(SUM[1]) );
  ADDHX2 U1_1_2 ( .A(A[2]), .B(carry[2]), .CO(carry[3]), .S(SUM[2]) );
  ADDHX1 U1_1_24 ( .A(A[24]), .B(carry[24]), .CO(carry[25]), .S(SUM[24]) );
  CMPR22X2 U1_1_25 ( .A(A[25]), .B(carry[25]), .CO(carry[26]), .S(SUM[25]) );
  XOR2X2 U1 ( .A(carry[29]), .B(A[29]), .Y(SUM[29]) );
  INVXL U2 ( .A(A[0]), .Y(SUM[0]) );
endmodule


module CHIP ( clk, rst_n, mem_addr_I, mem_rdata_I, instruction_type, 
        instruction_format, Port7 );
  output [31:2] mem_addr_I;
  input [31:0] mem_rdata_I;
  output [22:0] instruction_type;
  output [4:0] instruction_format;
  input clk, rst_n, Port7;
  wire   n165, n166, n167, n168, n169, n170, n171, n172, n173, n174, n175,
         n176, n177, n178, n179, n180, n181, n182, n183, n184, n185, n186,
         n187, n188, n189, n190, n191, n192, n193, n194, N63, N67, N68, N69,
         N70, N71, N72, N73, N74, N75, N76, N77, N78, N79, N80, N81, N82, N83,
         N84, N85, N86, N87, N88, n8, n9, n10, n11, n12, n13, n14, n15, n16,
         n18, n20, n22, n24, n26, n28, n30, n32, n34, n36, n38, n40, n42, n44,
         n46, n48, n50, n52, n54, n56, n58, n60, n62, n64, n66, n680, n700,
         n720, n730, n750, n760, n770, n780, n790, n800, n810, n820, n830,
         n840, n850, n860, n870, n880, n89, n90, n91, n92, n93, n94, n95, n96,
         n97, n98, n99, n100, n101, n102, n104, n106, n108, n110, n112, n114,
         n116, n118, n120, n122, n124, n126, n128, n130, n132, n134, n136,
         n138, n146, n148, n151, n153, n154, n155, n156, n157, n158, n159,
         n160, n161, n162, n163, n164;
  wire   [31:2] mem_addr_reg;

  DFFRX4 mem_addr_I_reg_2_ ( .D(mem_addr_reg[2]), .CK(clk), .RN(n154), .Q(n194), .QN(n151) );
  CHIP_DW01_inc_0 add_28 ( .A({n165, n166, n167, n168, n169, n170, n171, n172, 
        n173, n174, n175, n176, n177, n178, n179, n180, n181, n182, n183, n184, 
        n185, n186, n187, n188, n189, n190, n191, n192, n193, n194}), .SUM(
        mem_addr_reg) );
  DFFRX2 mem_addr_I_reg_31_ ( .D(mem_addr_reg[31]), .CK(clk), .RN(n155), .Q(
        n165), .QN(n148) );
  DFFRX1 mem_addr_I_reg_6_ ( .D(mem_addr_reg[6]), .CK(clk), .RN(rst_n), .Q(
        n190) );
  DFFRX1 mem_addr_I_reg_7_ ( .D(mem_addr_reg[7]), .CK(clk), .RN(n157), .Q(n189) );
  DFFRX1 mem_addr_I_reg_8_ ( .D(mem_addr_reg[8]), .CK(clk), .RN(n157), .Q(n188) );
  DFFRX1 mem_addr_I_reg_9_ ( .D(mem_addr_reg[9]), .CK(clk), .RN(n157), .Q(n187) );
  DFFRX1 mem_addr_I_reg_10_ ( .D(mem_addr_reg[10]), .CK(clk), .RN(n157), .Q(
        n186) );
  DFFRX1 mem_addr_I_reg_11_ ( .D(mem_addr_reg[11]), .CK(clk), .RN(n157), .Q(
        n185) );
  DFFRX1 mem_addr_I_reg_12_ ( .D(mem_addr_reg[12]), .CK(clk), .RN(n157), .Q(
        n184), .QN(n138) );
  DFFRX1 mem_addr_I_reg_13_ ( .D(mem_addr_reg[13]), .CK(clk), .RN(n157), .Q(
        n183), .QN(n136) );
  DFFRX1 mem_addr_I_reg_14_ ( .D(mem_addr_reg[14]), .CK(clk), .RN(n157), .Q(
        n182), .QN(n134) );
  DFFRX1 mem_addr_I_reg_15_ ( .D(mem_addr_reg[15]), .CK(clk), .RN(n157), .Q(
        n181), .QN(n132) );
  DFFRX1 mem_addr_I_reg_17_ ( .D(mem_addr_reg[17]), .CK(clk), .RN(n157), .Q(
        n179), .QN(n104) );
  DFFRX1 mem_addr_I_reg_16_ ( .D(mem_addr_reg[16]), .CK(clk), .RN(n157), .Q(
        n180), .QN(n102) );
  DFFRHQX1 instruction_type_reg_22_ ( .D(mem_rdata_I[3]), .CK(clk), .RN(n155), 
        .Q(n790) );
  DFFRHQX1 instruction_format_reg_0_ ( .D(mem_rdata_I[3]), .CK(clk), .RN(n156), 
        .Q(n780) );
  DFFRHQX1 instruction_type_reg_21_ ( .D(N88), .CK(clk), .RN(n155), .Q(n800)
         );
  DFFRHQX1 instruction_type_reg_18_ ( .D(N85), .CK(clk), .RN(n155), .Q(n830)
         );
  DFFRHQX1 instruction_format_reg_1_ ( .D(N63), .CK(clk), .RN(n156), .Q(n770)
         );
  DFFRHQX1 instruction_type_reg_6_ ( .D(N73), .CK(clk), .RN(n154), .Q(n95) );
  DFFRHQX1 instruction_format_reg_4_ ( .D(n164), .CK(clk), .RN(n156), .Q(n750)
         );
  DFFRHQX1 instruction_type_reg_17_ ( .D(N84), .CK(clk), .RN(n155), .Q(n840)
         );
  DFFRHQX1 instruction_format_reg_2_ ( .D(N84), .CK(clk), .RN(n156), .Q(n720)
         );
  DFFRHQX1 instruction_type_reg_11_ ( .D(N78), .CK(clk), .RN(n154), .Q(n90) );
  DFFRHQX1 instruction_type_reg_20_ ( .D(N87), .CK(clk), .RN(n155), .Q(n810)
         );
  DFFRHQX1 instruction_type_reg_19_ ( .D(N86), .CK(clk), .RN(n155), .Q(n820)
         );
  DFFRHQX1 instruction_type_reg_14_ ( .D(N81), .CK(clk), .RN(n155), .Q(n870)
         );
  DFFRHQX1 instruction_type_reg_16_ ( .D(N83), .CK(clk), .RN(n155), .Q(n850)
         );
  DFFRHQX1 instruction_type_reg_4_ ( .D(N71), .CK(clk), .RN(n154), .Q(n97) );
  DFFRHQX1 instruction_type_reg_10_ ( .D(N77), .CK(clk), .RN(n154), .Q(n91) );
  DFFRHQX1 instruction_type_reg_2_ ( .D(N69), .CK(clk), .RN(n154), .Q(n99) );
  DFFRHQX1 instruction_type_reg_9_ ( .D(N76), .CK(clk), .RN(n154), .Q(n92) );
  DFFRHQX1 instruction_type_reg_3_ ( .D(N70), .CK(clk), .RN(n154), .Q(n98) );
  DFFRHQX1 instruction_type_reg_8_ ( .D(N75), .CK(clk), .RN(n154), .Q(n93) );
  DFFRHQX1 instruction_type_reg_7_ ( .D(N74), .CK(clk), .RN(n154), .Q(n94) );
  DFFRHQX1 instruction_type_reg_13_ ( .D(N80), .CK(clk), .RN(n155), .Q(n880)
         );
  DFFRHQX1 instruction_type_reg_15_ ( .D(N82), .CK(clk), .RN(n155), .Q(n860)
         );
  DFFRHQX1 instruction_type_reg_12_ ( .D(N79), .CK(clk), .RN(n155), .Q(n89) );
  DFFRHQX1 instruction_type_reg_5_ ( .D(N72), .CK(clk), .RN(n154), .Q(n96) );
  DFFRHQX1 instruction_type_reg_0_ ( .D(N67), .CK(clk), .RN(n154), .Q(n101) );
  DFFRHQX1 instruction_type_reg_1_ ( .D(N68), .CK(clk), .RN(n154), .Q(n100) );
  DFFRHQX1 instruction_format_reg_3_ ( .D(n162), .CK(clk), .RN(n156), .Q(n760)
         );
  DFFRX2 mem_addr_I_reg_3_ ( .D(mem_addr_reg[3]), .CK(clk), .RN(n155), .Q(n193), .QN(n730) );
  DFFRX1 mem_addr_I_reg_5_ ( .D(mem_addr_reg[5]), .CK(clk), .RN(n157), .Q(n191), .QN(n146) );
  DFFRX1 mem_addr_I_reg_30_ ( .D(mem_addr_reg[30]), .CK(clk), .RN(n156), .Q(
        n166), .QN(n130) );
  DFFRX1 mem_addr_I_reg_29_ ( .D(mem_addr_reg[29]), .CK(clk), .RN(n156), .Q(
        n167), .QN(n128) );
  DFFRX1 mem_addr_I_reg_28_ ( .D(mem_addr_reg[28]), .CK(clk), .RN(n156), .Q(
        n168), .QN(n126) );
  DFFRX1 mem_addr_I_reg_27_ ( .D(mem_addr_reg[27]), .CK(clk), .RN(n156), .Q(
        n169), .QN(n124) );
  DFFRX1 mem_addr_I_reg_26_ ( .D(mem_addr_reg[26]), .CK(clk), .RN(n156), .Q(
        n170), .QN(n122) );
  DFFRX1 mem_addr_I_reg_25_ ( .D(mem_addr_reg[25]), .CK(clk), .RN(n156), .Q(
        n171), .QN(n120) );
  DFFRX1 mem_addr_I_reg_24_ ( .D(mem_addr_reg[24]), .CK(clk), .RN(n156), .Q(
        n172), .QN(n118) );
  DFFRX1 mem_addr_I_reg_23_ ( .D(mem_addr_reg[23]), .CK(clk), .RN(n156), .Q(
        n173), .QN(n116) );
  DFFRX1 mem_addr_I_reg_22_ ( .D(mem_addr_reg[22]), .CK(clk), .RN(n156), .Q(
        n174), .QN(n114) );
  DFFRX1 mem_addr_I_reg_21_ ( .D(mem_addr_reg[21]), .CK(clk), .RN(n156), .Q(
        n175), .QN(n112) );
  DFFRX1 mem_addr_I_reg_20_ ( .D(mem_addr_reg[20]), .CK(clk), .RN(n156), .Q(
        n176), .QN(n110) );
  DFFRX1 mem_addr_I_reg_19_ ( .D(mem_addr_reg[19]), .CK(clk), .RN(n156), .Q(
        n177), .QN(n108) );
  DFFRX1 mem_addr_I_reg_18_ ( .D(mem_addr_reg[18]), .CK(clk), .RN(n157), .Q(
        n178), .QN(n106) );
  DFFRX2 mem_addr_I_reg_4_ ( .D(mem_addr_reg[4]), .CK(clk), .RN(rst_n), .Q(
        n192) );
  INVXL U41 ( .A(n760), .Y(n16) );
  INVX12 U42 ( .A(n16), .Y(instruction_format[3]) );
  INVXL U43 ( .A(n100), .Y(n18) );
  INVX12 U44 ( .A(n18), .Y(instruction_type[1]) );
  INVXL U45 ( .A(n101), .Y(n20) );
  INVX12 U46 ( .A(n20), .Y(instruction_type[0]) );
  INVXL U47 ( .A(n96), .Y(n22) );
  INVX12 U48 ( .A(n22), .Y(instruction_type[5]) );
  INVXL U49 ( .A(n89), .Y(n24) );
  INVX12 U50 ( .A(n24), .Y(instruction_type[12]) );
  INVXL U51 ( .A(n860), .Y(n26) );
  INVX12 U52 ( .A(n26), .Y(instruction_type[15]) );
  INVXL U53 ( .A(n880), .Y(n28) );
  INVX12 U54 ( .A(n28), .Y(instruction_type[13]) );
  INVXL U55 ( .A(n94), .Y(n30) );
  INVX12 U56 ( .A(n30), .Y(instruction_type[7]) );
  INVXL U57 ( .A(n93), .Y(n32) );
  INVX12 U58 ( .A(n32), .Y(instruction_type[8]) );
  INVXL U59 ( .A(n98), .Y(n34) );
  INVX12 U60 ( .A(n34), .Y(instruction_type[3]) );
  INVXL U61 ( .A(n92), .Y(n36) );
  INVX12 U62 ( .A(n36), .Y(instruction_type[9]) );
  INVXL U63 ( .A(n99), .Y(n38) );
  INVX12 U64 ( .A(n38), .Y(instruction_type[2]) );
  INVXL U65 ( .A(n91), .Y(n40) );
  INVX12 U66 ( .A(n40), .Y(instruction_type[10]) );
  INVXL U67 ( .A(n97), .Y(n42) );
  INVX12 U68 ( .A(n42), .Y(instruction_type[4]) );
  INVXL U69 ( .A(n850), .Y(n44) );
  INVX12 U70 ( .A(n44), .Y(instruction_type[16]) );
  INVXL U71 ( .A(n870), .Y(n46) );
  INVX12 U72 ( .A(n46), .Y(instruction_type[14]) );
  INVXL U73 ( .A(n820), .Y(n48) );
  INVX12 U74 ( .A(n48), .Y(instruction_type[19]) );
  INVXL U75 ( .A(n810), .Y(n50) );
  INVX12 U76 ( .A(n50), .Y(instruction_type[20]) );
  INVXL U77 ( .A(n90), .Y(n52) );
  INVX12 U78 ( .A(n52), .Y(instruction_type[11]) );
  INVXL U79 ( .A(n720), .Y(n54) );
  INVX12 U80 ( .A(n54), .Y(instruction_format[2]) );
  INVXL U81 ( .A(n840), .Y(n56) );
  INVX12 U82 ( .A(n56), .Y(instruction_type[17]) );
  INVXL U83 ( .A(n750), .Y(n58) );
  INVX12 U84 ( .A(n58), .Y(instruction_format[4]) );
  INVXL U85 ( .A(n95), .Y(n60) );
  INVX12 U86 ( .A(n60), .Y(instruction_type[6]) );
  INVXL U87 ( .A(n770), .Y(n62) );
  INVX12 U88 ( .A(n62), .Y(instruction_format[1]) );
  INVXL U89 ( .A(n830), .Y(n64) );
  INVX12 U90 ( .A(n64), .Y(instruction_type[18]) );
  INVXL U91 ( .A(n800), .Y(n66) );
  INVX12 U92 ( .A(n66), .Y(instruction_type[21]) );
  INVXL U93 ( .A(n780), .Y(n680) );
  INVX12 U94 ( .A(n680), .Y(instruction_format[0]) );
  INVXL U95 ( .A(n790), .Y(n700) );
  INVX12 U96 ( .A(n700), .Y(instruction_type[22]) );
  INVX12 U97 ( .A(n730), .Y(mem_addr_I[3]) );
  INVX12 U98 ( .A(n102), .Y(mem_addr_I[16]) );
  INVX12 U99 ( .A(n104), .Y(mem_addr_I[17]) );
  INVX12 U100 ( .A(n106), .Y(mem_addr_I[18]) );
  INVX12 U101 ( .A(n108), .Y(mem_addr_I[19]) );
  INVX12 U102 ( .A(n110), .Y(mem_addr_I[20]) );
  INVX12 U103 ( .A(n112), .Y(mem_addr_I[21]) );
  INVX12 U104 ( .A(n114), .Y(mem_addr_I[22]) );
  INVX12 U105 ( .A(n116), .Y(mem_addr_I[23]) );
  INVX12 U106 ( .A(n118), .Y(mem_addr_I[24]) );
  INVX12 U107 ( .A(n120), .Y(mem_addr_I[25]) );
  INVX12 U108 ( .A(n122), .Y(mem_addr_I[26]) );
  INVX12 U109 ( .A(n124), .Y(mem_addr_I[27]) );
  INVX12 U110 ( .A(n126), .Y(mem_addr_I[28]) );
  INVX12 U111 ( .A(n128), .Y(mem_addr_I[29]) );
  INVX12 U112 ( .A(n130), .Y(mem_addr_I[30]) );
  INVX12 U113 ( .A(n132), .Y(mem_addr_I[15]) );
  INVX12 U114 ( .A(n134), .Y(mem_addr_I[14]) );
  INVX12 U115 ( .A(n136), .Y(mem_addr_I[13]) );
  INVX12 U116 ( .A(n138), .Y(mem_addr_I[12]) );
  BUFX12 U117 ( .A(n185), .Y(mem_addr_I[11]) );
  BUFX12 U118 ( .A(n186), .Y(mem_addr_I[10]) );
  BUFX12 U119 ( .A(n187), .Y(mem_addr_I[9]) );
  BUFX12 U120 ( .A(n188), .Y(mem_addr_I[8]) );
  BUFX12 U121 ( .A(n189), .Y(mem_addr_I[7]) );
  BUFX12 U122 ( .A(n190), .Y(mem_addr_I[6]) );
  INVX12 U123 ( .A(n146), .Y(mem_addr_I[5]) );
  INVX12 U124 ( .A(n148), .Y(mem_addr_I[31]) );
  BUFX12 U125 ( .A(n192), .Y(mem_addr_I[4]) );
  INVX12 U126 ( .A(n151), .Y(mem_addr_I[2]) );
  NOR2X1 U127 ( .A(n10), .B(n11), .Y(N80) );
  NAND2X1 U128 ( .A(n153), .B(n160), .Y(n11) );
  NAND3BX1 U129 ( .AN(n153), .B(n159), .C(n160), .Y(n8) );
  NOR3X1 U130 ( .A(n13), .B(n12), .C(n158), .Y(N69) );
  NOR3X1 U131 ( .A(n13), .B(n153), .C(n160), .Y(N73) );
  NOR3X1 U132 ( .A(n13), .B(n8), .C(n158), .Y(N74) );
  NOR3X1 U133 ( .A(n158), .B(n9), .C(n12), .Y(N76) );
  NOR3X1 U134 ( .A(n9), .B(n153), .C(n160), .Y(N78) );
  CLKINVX1 U135 ( .A(n13), .Y(n164) );
  OR2X1 U136 ( .A(n9), .B(n159), .Y(n10) );
  CLKINVX1 U137 ( .A(N63), .Y(n161) );
  NOR2X1 U138 ( .A(n160), .B(n14), .Y(N67) );
  NOR2X1 U139 ( .A(n160), .B(n10), .Y(N79) );
  NOR2X1 U140 ( .A(n8), .B(n9), .Y(N83) );
  NOR2X1 U141 ( .A(n161), .B(n160), .Y(N86) );
  NOR2X1 U142 ( .A(n11), .B(n14), .Y(N68) );
  NOR2X1 U143 ( .A(n153), .B(n14), .Y(N72) );
  NOR2X1 U144 ( .A(n153), .B(n10), .Y(N82) );
  CLKINVX1 U145 ( .A(n15), .Y(n162) );
  NOR3BXL U146 ( .AN(n9), .B(N85), .C(N88), .Y(n15) );
  CLKBUFX3 U147 ( .A(rst_n), .Y(n154) );
  CLKBUFX3 U148 ( .A(rst_n), .Y(n155) );
  CLKBUFX3 U149 ( .A(rst_n), .Y(n156) );
  CLKBUFX3 U150 ( .A(rst_n), .Y(n157) );
  NAND2X2 U151 ( .A(mem_rdata_I[4]), .B(mem_rdata_I[5]), .Y(n13) );
  NAND2X2 U152 ( .A(mem_rdata_I[4]), .B(n163), .Y(n9) );
  INVX3 U153 ( .A(mem_rdata_I[12]), .Y(n160) );
  NAND2X1 U154 ( .A(n164), .B(mem_rdata_I[13]), .Y(n14) );
  NAND3X1 U155 ( .A(mem_rdata_I[12]), .B(n159), .C(n153), .Y(n12) );
  NOR2BX1 U156 ( .AN(mem_rdata_I[2]), .B(mem_rdata_I[3]), .Y(N88) );
  NOR3X1 U157 ( .A(mem_rdata_I[4]), .B(mem_rdata_I[6]), .C(n163), .Y(N84) );
  NOR2BX1 U158 ( .AN(mem_rdata_I[6]), .B(mem_rdata_I[2]), .Y(N63) );
  NOR3X1 U159 ( .A(n13), .B(mem_rdata_I[30]), .C(n12), .Y(N70) );
  NOR3X1 U160 ( .A(n13), .B(mem_rdata_I[13]), .C(n11), .Y(N71) );
  NOR3X1 U161 ( .A(n13), .B(mem_rdata_I[30]), .C(n8), .Y(N75) );
  NOR2X1 U162 ( .A(mem_rdata_I[4]), .B(mem_rdata_I[5]), .Y(N85) );
  NOR3X1 U163 ( .A(n12), .B(mem_rdata_I[30]), .C(n9), .Y(N77) );
  NOR3X1 U164 ( .A(n11), .B(mem_rdata_I[13]), .C(n9), .Y(N81) );
  CLKINVX1 U165 ( .A(mem_rdata_I[30]), .Y(n158) );
  CLKINVX1 U166 ( .A(mem_rdata_I[13]), .Y(n159) );
  CLKINVX1 U167 ( .A(mem_rdata_I[5]), .Y(n163) );
  NOR2X1 U168 ( .A(mem_rdata_I[12]), .B(n161), .Y(N87) );
  CLKBUFX3 U169 ( .A(mem_rdata_I[14]), .Y(n153) );
endmodule

