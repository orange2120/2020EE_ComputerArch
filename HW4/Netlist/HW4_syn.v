/////////////////////////////////////////////////////////////
// Created by: Synopsys DC Expert(TM) in wire load mode
// Version   : N-2017.09-SP2
// Date      : Mon Dec 14 02:07:32 2020
/////////////////////////////////////////////////////////////


module HW3 ( instruction_type, instruction_format, mem_rdata_I_30_, 
        mem_rdata_I_14_, mem_rdata_I_13_, mem_rdata_I_12_, mem_rdata_I_6_, 
        mem_rdata_I_5_, mem_rdata_I_4_, mem_rdata_I_3_, mem_rdata_I_2_ );
  output [22:0] instruction_type;
  output [4:0] instruction_format;
  input mem_rdata_I_30_, mem_rdata_I_14_, mem_rdata_I_13_, mem_rdata_I_12_,
         mem_rdata_I_6_, mem_rdata_I_5_, mem_rdata_I_4_, mem_rdata_I_3_,
         mem_rdata_I_2_;
  wire   n9, n10, n11, n12, n13, n14, n15, n16, n2, n5, n6, n7, n8, n17;

  NAND3X1 U3 ( .A(mem_rdata_I_12_), .B(n6), .C(mem_rdata_I_14_), .Y(n13) );
  NOR2BX1 U4 ( .AN(mem_rdata_I_6_), .B(mem_rdata_I_2_), .Y(
        instruction_format[1]) );
  NOR3X1 U5 ( .A(n13), .B(mem_rdata_I_30_), .C(n10), .Y(instruction_type[10])
         );
  NOR2X1 U6 ( .A(n11), .B(n12), .Y(instruction_type[13]) );
  NOR3X1 U7 ( .A(n5), .B(n10), .C(n13), .Y(instruction_type[9]) );
  NAND2X1 U8 ( .A(mem_rdata_I_14_), .B(n7), .Y(n12) );
  NOR3X1 U9 ( .A(n14), .B(mem_rdata_I_14_), .C(n7), .Y(instruction_type[6]) );
  NAND3BX1 U10 ( .AN(mem_rdata_I_14_), .B(n6), .C(n7), .Y(n9) );
  INVX3 U11 ( .A(n16), .Y(instruction_format[3]) );
  NOR3BXL U12 ( .AN(n10), .B(instruction_type[18]), .C(instruction_type[21]), 
        .Y(n16) );
  NOR3X1 U13 ( .A(n14), .B(n9), .C(n5), .Y(instruction_type[7]) );
  NOR2X1 U14 ( .A(mem_rdata_I_14_), .B(n15), .Y(instruction_type[5]) );
  NOR2X1 U15 ( .A(mem_rdata_I_14_), .B(n11), .Y(instruction_type[15]) );
  NOR3X1 U16 ( .A(n14), .B(n13), .C(n5), .Y(instruction_type[2]) );
  CLKINVX1 U17 ( .A(n14), .Y(instruction_format[4]) );
  NOR2X1 U18 ( .A(n9), .B(n10), .Y(instruction_type[16]) );
  NOR2X1 U19 ( .A(n7), .B(n15), .Y(instruction_type[0]) );
  NOR2X1 U20 ( .A(n7), .B(n11), .Y(instruction_type[12]) );
  NOR2X1 U21 ( .A(n12), .B(n15), .Y(instruction_type[1]) );
  CLKINVX1 U22 ( .A(instruction_format[1]), .Y(n8) );
  OR2X1 U23 ( .A(n10), .B(n6), .Y(n11) );
  NOR2X1 U24 ( .A(n8), .B(n7), .Y(instruction_type[19]) );
  NOR3X1 U25 ( .A(n10), .B(mem_rdata_I_14_), .C(n7), .Y(instruction_type[11])
         );
  NAND2X2 U26 ( .A(mem_rdata_I_4_), .B(mem_rdata_I_5_), .Y(n14) );
  NOR3X2 U27 ( .A(mem_rdata_I_4_), .B(mem_rdata_I_6_), .C(n17), .Y(
        instruction_format[2]) );
  NAND2X2 U28 ( .A(mem_rdata_I_4_), .B(n17), .Y(n10) );
  NOR2BX1 U29 ( .AN(mem_rdata_I_2_), .B(mem_rdata_I_3_), .Y(
        instruction_type[21]) );
  INVX3 U30 ( .A(mem_rdata_I_12_), .Y(n7) );
  NOR3X1 U31 ( .A(n12), .B(mem_rdata_I_13_), .C(n10), .Y(instruction_type[14])
         );
  NOR3X1 U32 ( .A(n14), .B(mem_rdata_I_13_), .C(n12), .Y(instruction_type[4])
         );
  NOR3X1 U33 ( .A(n14), .B(mem_rdata_I_30_), .C(n13), .Y(instruction_type[3])
         );
  NAND2BX1 U34 ( .AN(n14), .B(mem_rdata_I_13_), .Y(n15) );
  NOR3X1 U35 ( .A(n14), .B(mem_rdata_I_30_), .C(n9), .Y(instruction_type[8])
         );
  NOR2X1 U36 ( .A(mem_rdata_I_4_), .B(mem_rdata_I_5_), .Y(instruction_type[18]) );
  CLKINVX1 U37 ( .A(mem_rdata_I_30_), .Y(n5) );
  CLKINVX1 U38 ( .A(mem_rdata_I_13_), .Y(n6) );
  NOR2X1 U39 ( .A(mem_rdata_I_12_), .B(n8), .Y(instruction_type[20]) );
  CLKINVX1 U40 ( .A(mem_rdata_I_3_), .Y(n2) );
  CLKINVX1 U41 ( .A(mem_rdata_I_5_), .Y(n17) );
  CLKINVX1 U42 ( .A(n2), .Y(instruction_type[22]) );
  CLKINVX1 U43 ( .A(n2), .Y(instruction_format[0]) );
  CLKBUFX3 U44 ( .A(instruction_format[2]), .Y(instruction_type[17]) );
endmodule


module HW4_DW01_inc_0 ( A, SUM );
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


module HW4 ( clk, rst_n, mem_addr_I, mem_rdata_I, ctrl_signal, immediate, 
        Port7 );
  output [31:2] mem_addr_I;
  input [31:0] mem_rdata_I;
  output [11:0] ctrl_signal;
  output [31:0] immediate;
  input clk, rst_n, Port7;
  wire   n236, n237, n238, n239, n240, n241, n242, n243, n244, n245, n246,
         n247, n248, n249, n250, n251, n252, n253, n254, n255, n256, n257,
         n258, n259, n260, n261, n262, n263, n264, n265, n10, n11, n12, n13,
         n14, n15, n16, n17, n18, n19, n20, n21, n22, n23, n24, n25, n26, n27,
         n28, n29, n30, n31, n32, n33, n34, n35, n37, n39, n41, n43, n45, n47,
         n49, n51, n53, n55, n57, n59, n61, n63, n65, n67, n69, n71, n73, n75,
         n77, n79, n81, n83, n85, n87, n89, n91, n93, n95, n97, n99, n101,
         n103, n105, n107, n109, n111, n113, n115, n117, n119, n121, n123,
         n124, n125, n126, n127, n128, n129, n130, n131, n132, n133, n134,
         n135, n137, n138, n139, n140, n141, n142, n143, n144, n145, n146,
         n147, n148, n149, n150, n151, n152, n153, n154, n155, n156, n157,
         n158, n159, n160, n161, n162, n163, n164, n165, n166, n167, n168,
         n169, n171, n173, n175, n177, n179, n181, n183, n185, n187, n189,
         n191, n193, n195, n197, n199, n201, n203, n205, n213, n215, n218,
         n220, n221, n222, n223, n224, n225, n226, n227, n228, n229, n230,
         n231, n232, n233, n234, n235;
  wire   [22:0] instruction_type;
  wire   [4:3] instruction_format;
  wire   [31:2] mem_addr_next;
  wire   [31:0] immediate_next;
  wire   [11:0] ctrl_sig_next;

  DFFRX4 mem_addr_I_reg_2_ ( .D(mem_addr_next[2]), .CK(clk), .RN(n223), .Q(
        n265), .QN(n218) );
  HW3 decoder ( .instruction_type(instruction_type), .instruction_format({
        instruction_format, ctrl_sig_next[7], ctrl_sig_next[9], 
        ctrl_sig_next[11]}), .mem_rdata_I_30_(mem_rdata_I[30]), 
        .mem_rdata_I_14_(n220), .mem_rdata_I_13_(mem_rdata_I[13]), 
        .mem_rdata_I_12_(mem_rdata_I[12]), .mem_rdata_I_6_(mem_rdata_I[6]), 
        .mem_rdata_I_5_(mem_rdata_I[5]), .mem_rdata_I_4_(mem_rdata_I[4]), 
        .mem_rdata_I_3_(mem_rdata_I[3]), .mem_rdata_I_2_(mem_rdata_I[2]) );
  HW4_DW01_inc_0 add_46 ( .A({n236, n237, n238, n239, n240, n241, n242, n243, 
        n244, n245, n246, n247, n248, n249, n250, n251, n252, n253, n254, n255, 
        n256, n257, n258, n259, n260, n261, n262, n263, n264, n265}), .SUM(
        mem_addr_next) );
  DFFRX2 mem_addr_I_reg_31_ ( .D(mem_addr_next[31]), .CK(clk), .RN(rst_n), .Q(
        n236), .QN(n215) );
  DFFRX1 mem_addr_I_reg_6_ ( .D(mem_addr_next[6]), .CK(clk), .RN(n224), .Q(
        n261) );
  DFFRX1 mem_addr_I_reg_7_ ( .D(mem_addr_next[7]), .CK(clk), .RN(n224), .Q(
        n260) );
  DFFRX1 mem_addr_I_reg_8_ ( .D(mem_addr_next[8]), .CK(clk), .RN(n224), .Q(
        n259) );
  DFFRX1 mem_addr_I_reg_9_ ( .D(mem_addr_next[9]), .CK(clk), .RN(n224), .Q(
        n258) );
  DFFRX1 mem_addr_I_reg_10_ ( .D(mem_addr_next[10]), .CK(clk), .RN(n224), .Q(
        n257) );
  DFFRX1 mem_addr_I_reg_11_ ( .D(mem_addr_next[11]), .CK(clk), .RN(n224), .Q(
        n256) );
  DFFRX1 mem_addr_I_reg_12_ ( .D(mem_addr_next[12]), .CK(clk), .RN(n224), .Q(
        n255), .QN(n205) );
  DFFRX1 mem_addr_I_reg_13_ ( .D(mem_addr_next[13]), .CK(clk), .RN(n224), .Q(
        n254), .QN(n203) );
  DFFRX1 mem_addr_I_reg_14_ ( .D(mem_addr_next[14]), .CK(clk), .RN(n224), .Q(
        n253), .QN(n201) );
  DFFRX1 mem_addr_I_reg_15_ ( .D(mem_addr_next[15]), .CK(clk), .RN(n224), .Q(
        n252), .QN(n199) );
  DFFRX1 mem_addr_I_reg_17_ ( .D(mem_addr_next[17]), .CK(clk), .RN(n224), .Q(
        n250), .QN(n171) );
  DFFRX1 mem_addr_I_reg_16_ ( .D(mem_addr_next[16]), .CK(clk), .RN(n224), .Q(
        n251), .QN(n169) );
  DFFRHQX1 ctrl_signal_reg_9_ ( .D(ctrl_sig_next[9]), .CK(clk), .RN(n221), .Q(
        n161) );
  DFFRHQX1 ctrl_signal_reg_11_ ( .D(ctrl_sig_next[11]), .CK(clk), .RN(n226), 
        .Q(n159) );
  DFFRHQX1 ctrl_signal_reg_7_ ( .D(ctrl_sig_next[7]), .CK(clk), .RN(n226), .Q(
        n162) );
  DFFRHQX1 immediate_reg_0_ ( .D(immediate_next[0]), .CK(clk), .RN(n223), .Q(
        n158) );
  DFFRHQX1 ctrl_signal_reg_5_ ( .D(ctrl_sig_next[5]), .CK(clk), .RN(n226), .Q(
        n164) );
  DFFRHQX1 ctrl_signal_reg_3_ ( .D(ctrl_sig_next[3]), .CK(clk), .RN(n226), .Q(
        n166) );
  DFFRHQX1 ctrl_signal_reg_1_ ( .D(ctrl_sig_next[1]), .CK(clk), .RN(n226), .Q(
        n134) );
  DFFRHQX1 ctrl_signal_reg_2_ ( .D(ctrl_sig_next[2]), .CK(clk), .RN(n226), .Q(
        n167) );
  DFFRHQX1 ctrl_signal_reg_0_ ( .D(ctrl_sig_next[0]), .CK(clk), .RN(n226), .Q(
        n168) );
  DFFRHQX1 immediate_reg_11_ ( .D(n227), .CK(clk), .RN(n222), .Q(n147) );
  DFFRHQX1 ctrl_signal_reg_8_ ( .D(ctrl_sig_next[8]), .CK(clk), .RN(n226), .Q(
        n133) );
  DFFRHQX1 ctrl_signal_reg_6_ ( .D(ctrl_sig_next[8]), .CK(clk), .RN(n226), .Q(
        n163) );
  DFFRHQX1 immediate_reg_4_ ( .D(immediate_next[4]), .CK(clk), .RN(n223), .Q(
        n154) );
  DFFRHQX1 immediate_reg_3_ ( .D(immediate_next[3]), .CK(clk), .RN(n223), .Q(
        n155) );
  DFFRHQX1 immediate_reg_2_ ( .D(immediate_next[2]), .CK(clk), .RN(n223), .Q(
        n156) );
  DFFRHQX1 immediate_reg_1_ ( .D(immediate_next[1]), .CK(clk), .RN(n223), .Q(
        n157) );
  DFFRHQX1 immediate_reg_19_ ( .D(immediate_next[19]), .CK(clk), .RN(n222), 
        .Q(n139) );
  DFFRHQX1 immediate_reg_18_ ( .D(immediate_next[18]), .CK(clk), .RN(n222), 
        .Q(n140) );
  DFFRHQX1 immediate_reg_17_ ( .D(immediate_next[17]), .CK(clk), .RN(n222), 
        .Q(n141) );
  DFFRHQX1 immediate_reg_16_ ( .D(immediate_next[16]), .CK(clk), .RN(n222), 
        .Q(n142) );
  DFFRHQX1 immediate_reg_15_ ( .D(immediate_next[15]), .CK(clk), .RN(n222), 
        .Q(n143) );
  DFFRHQX1 immediate_reg_14_ ( .D(immediate_next[14]), .CK(clk), .RN(n222), 
        .Q(n144) );
  DFFRHQX1 immediate_reg_13_ ( .D(immediate_next[13]), .CK(clk), .RN(n222), 
        .Q(n145) );
  DFFRHQX1 immediate_reg_12_ ( .D(immediate_next[12]), .CK(clk), .RN(n222), 
        .Q(n146) );
  DFFRHQX1 immediate_reg_10_ ( .D(immediate_next[10]), .CK(clk), .RN(n222), 
        .Q(n148) );
  DFFRHQX1 immediate_reg_9_ ( .D(immediate_next[9]), .CK(clk), .RN(n222), .Q(
        n149) );
  DFFRHQX1 immediate_reg_8_ ( .D(immediate_next[8]), .CK(clk), .RN(n222), .Q(
        n150) );
  DFFRHQX1 immediate_reg_7_ ( .D(immediate_next[7]), .CK(clk), .RN(n223), .Q(
        n151) );
  DFFRHQX1 immediate_reg_6_ ( .D(immediate_next[6]), .CK(clk), .RN(n223), .Q(
        n152) );
  DFFRHQX1 immediate_reg_5_ ( .D(immediate_next[5]), .CK(clk), .RN(n223), .Q(
        n153) );
  DFFRHQX1 ctrl_signal_reg_10_ ( .D(ctrl_sig_next[10]), .CK(clk), .RN(n226), 
        .Q(n160) );
  DFFRHQX1 ctrl_signal_reg_4_ ( .D(ctrl_sig_next[4]), .CK(clk), .RN(n226), .Q(
        n165) );
  DFFRHQX1 immediate_reg_31_ ( .D(immediate_next[31]), .CK(clk), .RN(n221), 
        .Q(n123) );
  DFFRHQX1 immediate_reg_30_ ( .D(immediate_next[31]), .CK(clk), .RN(n221), 
        .Q(n124) );
  DFFRHQX1 immediate_reg_29_ ( .D(immediate_next[31]), .CK(clk), .RN(n221), 
        .Q(n125) );
  DFFRHQX1 immediate_reg_28_ ( .D(immediate_next[31]), .CK(clk), .RN(n221), 
        .Q(n126) );
  DFFRHQX1 immediate_reg_27_ ( .D(immediate_next[31]), .CK(clk), .RN(n221), 
        .Q(n127) );
  DFFRHQX1 immediate_reg_26_ ( .D(immediate_next[31]), .CK(clk), .RN(n221), 
        .Q(n129) );
  DFFRHQX1 immediate_reg_25_ ( .D(immediate_next[31]), .CK(clk), .RN(n221), 
        .Q(n131) );
  DFFRHQX1 immediate_reg_24_ ( .D(immediate_next[31]), .CK(clk), .RN(n221), 
        .Q(n137) );
  DFFRHQX1 immediate_reg_23_ ( .D(immediate_next[23]), .CK(clk), .RN(n221), 
        .Q(n128) );
  DFFRHQX1 immediate_reg_22_ ( .D(immediate_next[23]), .CK(clk), .RN(n221), 
        .Q(n130) );
  DFFRHQX1 immediate_reg_21_ ( .D(immediate_next[23]), .CK(clk), .RN(n221), 
        .Q(n132) );
  DFFRHQX1 immediate_reg_20_ ( .D(immediate_next[23]), .CK(clk), .RN(n221), 
        .Q(n138) );
  DFFRX2 mem_addr_I_reg_3_ ( .D(mem_addr_next[3]), .CK(clk), .RN(n223), .Q(
        n264), .QN(n135) );
  DFFRX1 mem_addr_I_reg_5_ ( .D(mem_addr_next[5]), .CK(clk), .RN(n223), .Q(
        n262), .QN(n213) );
  DFFRX1 mem_addr_I_reg_30_ ( .D(mem_addr_next[30]), .CK(clk), .RN(rst_n), .Q(
        n237), .QN(n197) );
  DFFRX1 mem_addr_I_reg_29_ ( .D(mem_addr_next[29]), .CK(clk), .RN(n225), .Q(
        n238), .QN(n195) );
  DFFRX1 mem_addr_I_reg_28_ ( .D(mem_addr_next[28]), .CK(clk), .RN(n225), .Q(
        n239), .QN(n193) );
  DFFRX1 mem_addr_I_reg_27_ ( .D(mem_addr_next[27]), .CK(clk), .RN(n225), .Q(
        n240), .QN(n191) );
  DFFRX1 mem_addr_I_reg_26_ ( .D(mem_addr_next[26]), .CK(clk), .RN(n225), .Q(
        n241), .QN(n189) );
  DFFRX1 mem_addr_I_reg_25_ ( .D(mem_addr_next[25]), .CK(clk), .RN(n225), .Q(
        n242), .QN(n187) );
  DFFRX1 mem_addr_I_reg_24_ ( .D(mem_addr_next[24]), .CK(clk), .RN(n225), .Q(
        n243), .QN(n185) );
  DFFRX1 mem_addr_I_reg_23_ ( .D(mem_addr_next[23]), .CK(clk), .RN(n225), .Q(
        n244), .QN(n183) );
  DFFRX1 mem_addr_I_reg_22_ ( .D(mem_addr_next[22]), .CK(clk), .RN(n225), .Q(
        n245), .QN(n181) );
  DFFRX1 mem_addr_I_reg_21_ ( .D(mem_addr_next[21]), .CK(clk), .RN(n225), .Q(
        n246), .QN(n179) );
  DFFRX1 mem_addr_I_reg_20_ ( .D(mem_addr_next[20]), .CK(clk), .RN(n225), .Q(
        n247), .QN(n177) );
  DFFRX1 mem_addr_I_reg_19_ ( .D(mem_addr_next[19]), .CK(clk), .RN(n225), .Q(
        n248), .QN(n175) );
  DFFRX1 mem_addr_I_reg_18_ ( .D(mem_addr_next[18]), .CK(clk), .RN(n225), .Q(
        n249), .QN(n173) );
  DFFRX2 mem_addr_I_reg_4_ ( .D(mem_addr_next[4]), .CK(clk), .RN(n223), .Q(
        n263) );
  OA21X2 U66 ( .A0(ctrl_sig_next[9]), .A1(n234), .B0(mem_rdata_I[31]), .Y(
        immediate_next[31]) );
  INVXL U67 ( .A(n138), .Y(n35) );
  INVX12 U68 ( .A(n35), .Y(immediate[20]) );
  INVXL U69 ( .A(n132), .Y(n37) );
  INVX12 U70 ( .A(n37), .Y(immediate[21]) );
  INVXL U71 ( .A(n130), .Y(n39) );
  INVX12 U72 ( .A(n39), .Y(immediate[22]) );
  INVXL U73 ( .A(n128), .Y(n41) );
  INVX12 U74 ( .A(n41), .Y(immediate[23]) );
  INVXL U75 ( .A(n137), .Y(n43) );
  INVX12 U76 ( .A(n43), .Y(immediate[24]) );
  INVXL U77 ( .A(n131), .Y(n45) );
  INVX12 U78 ( .A(n45), .Y(immediate[25]) );
  INVXL U79 ( .A(n129), .Y(n47) );
  INVX12 U80 ( .A(n47), .Y(immediate[26]) );
  INVXL U81 ( .A(n127), .Y(n49) );
  INVX12 U82 ( .A(n49), .Y(immediate[27]) );
  INVXL U83 ( .A(n126), .Y(n51) );
  INVX12 U84 ( .A(n51), .Y(immediate[28]) );
  INVXL U85 ( .A(n125), .Y(n53) );
  INVX12 U86 ( .A(n53), .Y(immediate[29]) );
  INVXL U87 ( .A(n124), .Y(n55) );
  INVX12 U88 ( .A(n55), .Y(immediate[30]) );
  INVXL U89 ( .A(n123), .Y(n57) );
  INVX12 U90 ( .A(n57), .Y(immediate[31]) );
  INVXL U91 ( .A(n165), .Y(n59) );
  INVX12 U92 ( .A(n59), .Y(ctrl_signal[4]) );
  INVXL U93 ( .A(n160), .Y(n61) );
  INVX12 U94 ( .A(n61), .Y(ctrl_signal[10]) );
  INVXL U95 ( .A(n153), .Y(n63) );
  INVX12 U96 ( .A(n63), .Y(immediate[5]) );
  INVXL U97 ( .A(n152), .Y(n65) );
  INVX12 U98 ( .A(n65), .Y(immediate[6]) );
  INVXL U99 ( .A(n151), .Y(n67) );
  INVX12 U100 ( .A(n67), .Y(immediate[7]) );
  INVXL U101 ( .A(n150), .Y(n69) );
  INVX12 U102 ( .A(n69), .Y(immediate[8]) );
  INVXL U103 ( .A(n149), .Y(n71) );
  INVX12 U104 ( .A(n71), .Y(immediate[9]) );
  INVXL U105 ( .A(n148), .Y(n73) );
  INVX12 U106 ( .A(n73), .Y(immediate[10]) );
  INVXL U107 ( .A(n146), .Y(n75) );
  INVX12 U108 ( .A(n75), .Y(immediate[12]) );
  INVXL U109 ( .A(n145), .Y(n77) );
  INVX12 U110 ( .A(n77), .Y(immediate[13]) );
  INVXL U111 ( .A(n144), .Y(n79) );
  INVX12 U112 ( .A(n79), .Y(immediate[14]) );
  INVXL U113 ( .A(n143), .Y(n81) );
  INVX12 U114 ( .A(n81), .Y(immediate[15]) );
  INVXL U115 ( .A(n142), .Y(n83) );
  INVX12 U116 ( .A(n83), .Y(immediate[16]) );
  INVXL U117 ( .A(n141), .Y(n85) );
  INVX12 U118 ( .A(n85), .Y(immediate[17]) );
  INVXL U119 ( .A(n140), .Y(n87) );
  INVX12 U120 ( .A(n87), .Y(immediate[18]) );
  INVXL U121 ( .A(n139), .Y(n89) );
  INVX12 U122 ( .A(n89), .Y(immediate[19]) );
  INVXL U123 ( .A(n157), .Y(n91) );
  INVX12 U124 ( .A(n91), .Y(immediate[1]) );
  INVXL U125 ( .A(n156), .Y(n93) );
  INVX12 U126 ( .A(n93), .Y(immediate[2]) );
  INVXL U127 ( .A(n155), .Y(n95) );
  INVX12 U128 ( .A(n95), .Y(immediate[3]) );
  INVXL U129 ( .A(n154), .Y(n97) );
  INVX12 U130 ( .A(n97), .Y(immediate[4]) );
  INVXL U131 ( .A(n163), .Y(n99) );
  INVX12 U132 ( .A(n99), .Y(ctrl_signal[6]) );
  INVXL U133 ( .A(n133), .Y(n101) );
  INVX12 U134 ( .A(n101), .Y(ctrl_signal[8]) );
  INVXL U135 ( .A(n147), .Y(n103) );
  INVX12 U136 ( .A(n103), .Y(immediate[11]) );
  INVXL U137 ( .A(n168), .Y(n105) );
  INVX12 U138 ( .A(n105), .Y(ctrl_signal[0]) );
  INVXL U139 ( .A(n167), .Y(n107) );
  INVX12 U140 ( .A(n107), .Y(ctrl_signal[2]) );
  INVXL U141 ( .A(n134), .Y(n109) );
  INVX12 U142 ( .A(n109), .Y(ctrl_signal[1]) );
  INVXL U143 ( .A(n166), .Y(n111) );
  INVX12 U144 ( .A(n111), .Y(ctrl_signal[3]) );
  INVXL U145 ( .A(n164), .Y(n113) );
  INVX12 U146 ( .A(n113), .Y(ctrl_signal[5]) );
  INVXL U147 ( .A(n158), .Y(n115) );
  INVX12 U148 ( .A(n115), .Y(immediate[0]) );
  INVXL U149 ( .A(n162), .Y(n117) );
  INVX12 U150 ( .A(n117), .Y(ctrl_signal[7]) );
  INVXL U151 ( .A(n159), .Y(n119) );
  INVX12 U152 ( .A(n119), .Y(ctrl_signal[11]) );
  INVXL U153 ( .A(n161), .Y(n121) );
  INVX12 U154 ( .A(n121), .Y(ctrl_signal[9]) );
  INVX12 U155 ( .A(n135), .Y(mem_addr_I[3]) );
  INVX12 U156 ( .A(n169), .Y(mem_addr_I[16]) );
  INVX12 U157 ( .A(n171), .Y(mem_addr_I[17]) );
  INVX12 U158 ( .A(n173), .Y(mem_addr_I[18]) );
  INVX12 U159 ( .A(n175), .Y(mem_addr_I[19]) );
  INVX12 U160 ( .A(n177), .Y(mem_addr_I[20]) );
  INVX12 U161 ( .A(n179), .Y(mem_addr_I[21]) );
  INVX12 U162 ( .A(n181), .Y(mem_addr_I[22]) );
  INVX12 U163 ( .A(n183), .Y(mem_addr_I[23]) );
  INVX12 U164 ( .A(n185), .Y(mem_addr_I[24]) );
  INVX12 U165 ( .A(n187), .Y(mem_addr_I[25]) );
  INVX12 U166 ( .A(n189), .Y(mem_addr_I[26]) );
  INVX12 U167 ( .A(n191), .Y(mem_addr_I[27]) );
  INVX12 U168 ( .A(n193), .Y(mem_addr_I[28]) );
  INVX12 U169 ( .A(n195), .Y(mem_addr_I[29]) );
  INVX12 U170 ( .A(n197), .Y(mem_addr_I[30]) );
  INVX12 U171 ( .A(n199), .Y(mem_addr_I[15]) );
  INVX12 U172 ( .A(n201), .Y(mem_addr_I[14]) );
  INVX12 U173 ( .A(n203), .Y(mem_addr_I[13]) );
  INVX12 U174 ( .A(n205), .Y(mem_addr_I[12]) );
  BUFX12 U175 ( .A(n256), .Y(mem_addr_I[11]) );
  BUFX12 U176 ( .A(n257), .Y(mem_addr_I[10]) );
  BUFX12 U177 ( .A(n258), .Y(mem_addr_I[9]) );
  BUFX12 U178 ( .A(n259), .Y(mem_addr_I[8]) );
  BUFX12 U179 ( .A(n260), .Y(mem_addr_I[7]) );
  BUFX12 U180 ( .A(n261), .Y(mem_addr_I[6]) );
  INVX12 U181 ( .A(n213), .Y(mem_addr_I[5]) );
  INVX12 U182 ( .A(n215), .Y(mem_addr_I[31]) );
  BUFX12 U183 ( .A(n263), .Y(mem_addr_I[4]) );
  INVX12 U184 ( .A(n218), .Y(mem_addr_I[2]) );
  CLKINVX1 U185 ( .A(n12), .Y(n234) );
  NAND2X1 U186 ( .A(n12), .B(n235), .Y(ctrl_sig_next[5]) );
  NOR2X2 U187 ( .A(n14), .B(instruction_type[22]), .Y(n10) );
  OAI221XL U188 ( .A0(n233), .A1(n232), .B0(n235), .B1(n231), .C0(n25), .Y(
        ctrl_sig_next[0]) );
  CLKINVX1 U189 ( .A(instruction_type[6]), .Y(n231) );
  AOI22X1 U190 ( .A0(instruction_format[4]), .A1(instruction_type[2]), .B0(
        instruction_format[3]), .B1(instruction_type[9]), .Y(n22) );
  CLKINVX1 U191 ( .A(instruction_format[3]), .Y(n233) );
  OAI22XL U192 ( .A0(n26), .A1(n233), .B0(n27), .B1(n235), .Y(ctrl_sig_next[1]) );
  NOR2X1 U193 ( .A(instruction_format[3]), .B(ctrl_sig_next[11]), .Y(n12) );
  NAND2BX1 U194 ( .AN(n11), .B(n233), .Y(n14) );
  CLKINVX1 U195 ( .A(instruction_format[4]), .Y(n235) );
  NAND2X1 U196 ( .A(n232), .B(n230), .Y(n19) );
  CLKINVX1 U197 ( .A(n26), .Y(n229) );
  NOR2X1 U198 ( .A(n233), .B(n21), .Y(ctrl_sig_next[10]) );
  OAI2BB1X1 U199 ( .A0N(instruction_format[4]), .A1N(instruction_type[7]), 
        .B0(n22), .Y(ctrl_sig_next[3]) );
  NOR3X1 U200 ( .A(instruction_type[5]), .B(instruction_type[1]), .C(
        instruction_type[0]), .Y(n27) );
  NOR3X1 U201 ( .A(instruction_type[15]), .B(instruction_type[13]), .C(
        instruction_type[12]), .Y(n26) );
  NAND4BX1 U202 ( .AN(instruction_type[17]), .B(n27), .C(n30), .D(n31), .Y(n20) );
  NOR3X1 U203 ( .A(instruction_type[19]), .B(instruction_type[22]), .C(
        instruction_type[20]), .Y(n30) );
  NOR4X1 U204 ( .A(n32), .B(instruction_type[6]), .C(instruction_type[8]), .D(
        instruction_type[7]), .Y(n31) );
  NAND4X1 U205 ( .A(n232), .B(n230), .C(n28), .D(n29), .Y(n21) );
  NOR3X1 U206 ( .A(instruction_type[16]), .B(instruction_type[9]), .C(
        instruction_type[18]), .Y(n28) );
  NOR4BX1 U207 ( .AN(instruction_type[21]), .B(instruction_type[10]), .C(n229), 
        .D(n20), .Y(n29) );
  AND3X2 U208 ( .A(n33), .B(n34), .C(n22), .Y(n25) );
  OAI21XL U209 ( .A0(instruction_type[0]), .A1(instruction_type[3]), .B0(
        instruction_format[4]), .Y(n33) );
  OAI21XL U210 ( .A0(instruction_type[10]), .A1(instruction_type[12]), .B0(
        instruction_format[3]), .Y(n34) );
  OR2X1 U211 ( .A(ctrl_sig_next[7]), .B(ctrl_sig_next[9]), .Y(n11) );
  CLKINVX1 U212 ( .A(instruction_type[11]), .Y(n232) );
  CLKINVX1 U213 ( .A(instruction_type[14]), .Y(n230) );
  OAI2BB1X1 U214 ( .A0N(n220), .A1N(instruction_type[22]), .B0(n13), .Y(
        immediate_next[14]) );
  AND4X1 U215 ( .A(n228), .B(instruction_type[18]), .C(n17), .D(n18), .Y(
        ctrl_sig_next[8]) );
  NOR4X1 U216 ( .A(n19), .B(instruction_type[16]), .C(instruction_type[9]), 
        .D(instruction_type[21]), .Y(n18) );
  NOR3X1 U217 ( .A(n229), .B(instruction_type[10]), .C(n233), .Y(n17) );
  CLKINVX1 U218 ( .A(n20), .Y(n228) );
  OR3X2 U219 ( .A(instruction_type[3]), .B(instruction_type[4]), .C(
        instruction_type[2]), .Y(n32) );
  NAND3X1 U220 ( .A(n23), .B(n24), .C(n25), .Y(ctrl_sig_next[2]) );
  OAI21XL U221 ( .A0(instruction_type[1]), .A1(instruction_type[4]), .B0(
        instruction_format[4]), .Y(n23) );
  OAI21XL U222 ( .A0(instruction_type[13]), .A1(instruction_type[14]), .B0(
        instruction_format[3]), .Y(n24) );
  AO21X1 U223 ( .A0(n21), .A1(instruction_format[3]), .B0(ctrl_sig_next[7]), 
        .Y(ctrl_sig_next[4]) );
  CLKBUFX3 U224 ( .A(n226), .Y(n225) );
  CLKBUFX3 U225 ( .A(rst_n), .Y(n224) );
  CLKBUFX3 U226 ( .A(rst_n), .Y(n223) );
  CLKBUFX3 U227 ( .A(n226), .Y(n222) );
  CLKBUFX3 U228 ( .A(rst_n), .Y(n226) );
  NAND2X2 U229 ( .A(mem_rdata_I[31]), .B(n14), .Y(n13) );
  AO21X1 U230 ( .A0(mem_rdata_I[31]), .A1(ctrl_sig_next[7]), .B0(
        immediate_next[31]), .Y(immediate_next[23]) );
  OAI2BB1X1 U231 ( .A0N(mem_rdata_I[12]), .A1N(instruction_type[22]), .B0(n13), 
        .Y(immediate_next[12]) );
  OAI2BB1X1 U232 ( .A0N(mem_rdata_I[13]), .A1N(instruction_type[22]), .B0(n13), 
        .Y(immediate_next[13]) );
  OAI2BB1X1 U233 ( .A0N(mem_rdata_I[15]), .A1N(ctrl_sig_next[11]), .B0(n13), 
        .Y(immediate_next[15]) );
  OAI2BB1X1 U234 ( .A0N(mem_rdata_I[16]), .A1N(ctrl_sig_next[11]), .B0(n13), 
        .Y(immediate_next[16]) );
  OAI2BB1X1 U235 ( .A0N(mem_rdata_I[17]), .A1N(ctrl_sig_next[11]), .B0(n13), 
        .Y(immediate_next[17]) );
  OAI2BB1X1 U236 ( .A0N(mem_rdata_I[18]), .A1N(ctrl_sig_next[11]), .B0(n13), 
        .Y(immediate_next[18]) );
  OAI2BB1X1 U237 ( .A0N(mem_rdata_I[19]), .A1N(ctrl_sig_next[11]), .B0(n13), 
        .Y(immediate_next[19]) );
  NOR2BX1 U238 ( .AN(mem_rdata_I[25]), .B(n10), .Y(immediate_next[5]) );
  NOR2BX1 U239 ( .AN(mem_rdata_I[26]), .B(n10), .Y(immediate_next[6]) );
  NOR2BX1 U240 ( .AN(mem_rdata_I[27]), .B(n10), .Y(immediate_next[7]) );
  NOR2BX1 U241 ( .AN(mem_rdata_I[28]), .B(n10), .Y(immediate_next[8]) );
  NOR2BX1 U242 ( .AN(mem_rdata_I[29]), .B(n10), .Y(immediate_next[9]) );
  NOR2BX1 U243 ( .AN(mem_rdata_I[30]), .B(n10), .Y(immediate_next[10]) );
  CLKINVX1 U244 ( .A(n15), .Y(n227) );
  AOI221XL U245 ( .A0(instruction_type[22]), .A1(mem_rdata_I[20]), .B0(
        ctrl_sig_next[9]), .B1(mem_rdata_I[7]), .C0(n16), .Y(n15) );
  OA21XL U246 ( .A0(ctrl_sig_next[7]), .A1(instruction_format[3]), .B0(
        mem_rdata_I[31]), .Y(n16) );
  AO22X1 U247 ( .A0(mem_rdata_I[20]), .A1(instruction_format[3]), .B0(
        ctrl_sig_next[7]), .B1(mem_rdata_I[7]), .Y(immediate_next[0]) );
  CLKBUFX3 U248 ( .A(mem_rdata_I[14]), .Y(n220) );
  AO22X1 U249 ( .A0(mem_rdata_I[21]), .A1(n234), .B0(mem_rdata_I[8]), .B1(n11), 
        .Y(immediate_next[1]) );
  AO22X1 U250 ( .A0(mem_rdata_I[22]), .A1(n234), .B0(mem_rdata_I[9]), .B1(n11), 
        .Y(immediate_next[2]) );
  AO22X1 U251 ( .A0(mem_rdata_I[23]), .A1(n234), .B0(mem_rdata_I[10]), .B1(n11), .Y(immediate_next[3]) );
  AO22X1 U252 ( .A0(mem_rdata_I[24]), .A1(n234), .B0(mem_rdata_I[11]), .B1(n11), .Y(immediate_next[4]) );
  CLKBUFX3 U253 ( .A(rst_n), .Y(n221) );
endmodule

