//顶层模块
module calculater(
   CLOCK_50, 
	SW, 
	KEY,
   LEDR,
   LEDG,	
	HEX0,
	HEX1,
	HEX2,
	HEX3,
	HEX4,
	HEX5,
	HEX6,
	HEX7,
   en,
   rw,
   rs,
   data,	
);


input 		          		CLOCK_50;
input 		    [17:0]		SW;
input            [3:0]     KEY;
output		  reg[6:0]		HEX0;
output		  reg[6:0]		HEX1;
output		  reg[6:0]		HEX2;
output		  reg[6:0]		HEX3;
output		  reg[6:0]		HEX4;
output		  reg[6:0]		HEX5;
output		  reg[6:0]		HEX6;
output		  reg[6:0]		HEX7;
output reg[8:0] LEDG;
output reg[17:0]LEDR;
output       en ;
output       rw ;
output       rs ;
output [7:0] data;

wire [15:0] p3, p2, p1;
wire [7:0] p0,y0;
wire [3:0] one0, ten0, count0, one1, ten1, count1;
wire [1:0] hun0, hun1;
wire [19:0] q;
wire [6:0] cb7, cb6, cb5, cb4, cb3, cb2, cb1, cb0;
reg [6:0] ca7, ca6, ca5, ca4, ca3, ca2, ca1, ca0;

wire [6:0] cm7, cm6, cm5, cm4, cm3, cm2, cm1, cm0;

reg [7:0] a3, b3, a2, b2, a1, b1, a0, b0;
reg [15:0] p;
wire cout;
wire [7:0] s;
wire borrow_out;
wire [7:0] yshang,yyushu;


parameter _0 = 7'b100_0000, 
          _1 = 7'b111_1001, 
			 _2 = 7'b010_0100,
			 _3 = 7'b011_0000,
			 _4 = 7'b001_1001,
			 _5 = 7'b001_0010,
			 _6 = 7'b000_0010,
			 _7 = 7'b111_1000,
			 _8 = 7'b000_0000,
			 _9 = 7'b001_0000,
			 _none = 7'b111_1111;


Adder1 #(8)	A0 (a3, b3, 1'b0, cout, s);
assign p3 = {7'b0, cout, s};		 
substractor_8bits sub0 (b2,a2,p2,borrow_out);
multiply m0 (a1, b1, p1);
div8 v0 (b0,a0,yshang,yyushu);
assign p0 = {8'b0,yshang};

bin_dec bd0 (CLOCK_50,SW[7:0],SW[17],one0,ten0,hun0,count0);
bin_dec bd1 (CLOCK_50,SW[15:8],SW[17],one1,ten1,hun1,count1);

bin2bcd bb0 (CLOCK_50,SW[17],p,q);
display d0 (hun0,ten0,one0,cb3, cb2, cb1, cb0);
display d1 (hun1,ten1,one1,cb7, cb6, cb5, cb4);
display_5 d5(q, cm7, cm6, cm5, cm4, cm3, cm2, cm1, cm0);

//除法
wire [3:0] one_is,ten_is,hun_is;
wire [3:0] one_yu,ten_yu,hun_yu;
wire [6:0] one_is_play,ten_is_play,hun_is_play;
wire [6:0] one_yu_play,ten_yu_play,hun_yu_play;
//除法结果二进制转十进制及其十进制数码管显示
bin_dec_8bits   bd_is1(yshang[7:0],hun_is,ten_is,one_is);
display_div  dd_is(hun_is[3:0],ten_is[3:0],one_is[3:0],hun_is_play,ten_is_play,one_is_play);
//除法余数二进制转十进制及其十进制数码管显示
bin_dec_8bits   bd_yu1(yyushu[7:0],hun_yu,ten_yu,one_yu);
display_div  dd_yu(hun_yu[3:0],ten_yu[3:0],one_yu[3:0],hun_yu_play,ten_yu_play,one_yu_play);

LCD L0 (SW[17],KEY,CLOCK_50,ten0,one0,ten1,one1,hun0,hun1,q,rw,rs,en,data);

//运算方式选择
always @(posedge CLOCK_50)
begin
  case(KEY)
    4'b1110:
	    begin
	     a0 <= SW[7:0];
        b0 <= SW[15:8];
		  p  <= p0;
		  ca7<=_none;
		  ca6<=one_is_play;
		  ca5<=ten_is_play;
		  ca4<=hun_is_play;
		  ca3<=_none;
		  ca2<=one_yu_play;
		  ca1<=ten_yu_play;
		  ca0<=hun_yu_play;
	   end
	 4'b1101:
	   begin
	     a1 <= SW[7:0];
        b1 <= SW[15:8];
		  p  <= p1;
		  ca7<=cm7;
		  ca6<=cm6;
		  ca5<=cm5;
		  ca4<=cm4;
		  ca3<=cm3;
		  ca2<=cm2;
		  ca1<=cm1;
		  ca0<=cm0;
	   end
	 4'b1011:
	   begin
	     a2 <= SW[7:0];
        b2 <= SW[15:8];
	  	  p  <= p2;
		  ca7<=cm7;
		  ca6<=cm6;
		  ca5<=cm5;
		  ca4<=cm4;
		  ca3<=cm3;
		  ca2<=cm2;
		  ca1<=cm1;
		  ca0<=cm0;
	   end
	 4'b0111:
	   begin
	     a3 <= SW[7:0];
        b3 <= SW[15:8];
		  p  <= p3;
		  ca7<=cm7;
		  ca6<=cm6;
		  ca5<=cm5;
		  ca4<=cm4;
		  ca3<=cm3;
		  ca2<=cm2;
		  ca1<=cm1;
		  ca0<=cm0;
	   end
	 default:
	   begin
		  a0<=0;a1<=0;a2<=0;a3<=0;
		  b0<=0;b1<=0;b2<=0;b3<=0;
	   end
  endcase
end


//数码管显示
always @( posedge CLOCK_50 )
begin
  if(SW[17])
    begin
      HEX7 <= _none;
	   HEX6 <= _none;
	   HEX5 <= _none;
	   HEX4 <= _none;
	   HEX3 <= _none;
	   HEX2 <= _none;
	   HEX1 <= _none;
	   HEX0 <= _none;
	 end
  else if (SW[16])
    begin
	   HEX7 <= ca7;
	   HEX6 <= ca6;
	   HEX5 <= ca5;
	   HEX4 <= ca4;
	   HEX3 <= ca3;
	   HEX2 <= ca2;
	   HEX1 <= ca1;
	   HEX0 <= ca0;
	 end
  else
    begin
	   HEX7 <= cb7;
	   HEX6 <= cb6;
	   HEX5 <= cb5;
	   HEX4 <= cb4;
	   HEX3 <= cb3;
	   HEX2 <= cb2;
	   HEX1 <= cb1;
	   HEX0 <= cb0;
	 end
end


//LED灯显示模块
always @(posedge CLOCK_50 or posedge SW[17])begin
  if(SW[17])
    begin
	   LEDR[17:0] = 0;
		LEDG[8] = 0;
	 end
  else
    begin
      LEDR[17:0] = SW[17:0];
      LEDG[8] = borrow_out;
	 end
end



endmodule
