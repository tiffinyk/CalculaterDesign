//加法运算模块
module Adder1(a,b,cin,cout,s);
  parameter n = 8 ;
  input [n-1:0] a,b;
  input cin;
  output [n-1:0] s;
  output cout;
  
  assign {cout, s} = a + b + cin ;
endmodule
