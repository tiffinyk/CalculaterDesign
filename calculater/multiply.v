//8-bit multiplier
module multiply(a,b,p);
  input [7:0] a,b;
  output [15:0] p;
  
  //form partial products
  wire [7:0] pp0 = a & {8{b[0]}}; //x1
  wire [7:0] pp1 = a & {8{b[1]}}; //x2
  wire [7:0] pp2 = a & {8{b[2]}}; //x4
  wire [7:0] pp3 = a & {8{b[3]}}; //x8
  wire [7:0] pp4 = a & {8{b[4]}}; //x16
  wire [7:0] pp5 = a & {8{b[5]}}; //x32
  wire [7:0] pp6 = a & {8{b[6]}}; //x64
  wire [7:0] pp7 = a & {8{b[7]}}; //x128
  
  //sum up partial products
  wire cout1, cout2, cout3, cout4, cout5, cout6, cout7 ;
  wire [7:0] s1, s2, s3, s4, s5, s6, s7;
  Adder1 #(8) a1(pp1, {1'b0, pp0[7:1]},1'b0,cout1, s1);
  Adder1 #(8) a2(pp2, {cout1, s1[7:1]},1'b0,cout2, s2);
  Adder1 #(8) a3(pp3, {cout2, s2[7:1]},1'b0,cout3, s3);
  Adder1 #(8) a4(pp4, {cout3, s3[7:1]},1'b0,cout4, s4);
  Adder1 #(8) a5(pp5, {cout4, s4[7:1]},1'b0,cout5, s5);
  Adder1 #(8) a6(pp6, {cout5, s5[7:1]},1'b0,cout6, s6);
  Adder1 #(8) a7(pp7, {cout6, s6[7:1]},1'b0,cout7, s7);
  
  //collect the result
  assign p = {cout7, s7, s6[0], s5[0], s4[0], s3[0], s2[0], s1[0], pp0[0]};
endmodule
