//除法运算结果在数码管上显示
module display_div(
  hun,
  ten,
  one,
  num2,
  num1,
  num0
);

input [3:0] hun;
input [3:0] ten, one;
output reg [6:0] num2, num1, num0;

wire [3:0] h;
wire [3:0] t, o;

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
			 

assign h = hun;
assign t = ten;
assign o = one;

always@(*)begin
  case(h)
    4'd0: num2 = _0;
    4'd1: num2 = _1;
    4'd2: num2 = _2;
    4'd3: num2 = _3;
	 4'd4: num2 = _4;
    4'd5: num2 = _5;
    4'd6: num2 = _6;
    4'd7: num2 = _7;
    4'd8: num2 = _8;
    4'd9: num2 = _9;
    default: num2 = _none;
  endcase
end

always@(*)begin
  case(t)
    4'd0: num1 = _0;
    4'd1: num1 = _1;
    4'd2: num1 = _2;
    4'd3: num1 = _3;
    4'd4: num1 = _4;
    4'd5: num1 = _5;
    4'd6: num1 = _6;
    4'd7: num1 = _7;
    4'd8: num1 = _8;
    4'd9: num1 = _9;
    default: num1 = _none;
  endcase
end

always@(*)begin
  case(o)
    4'd0: num0 = _0;
    4'd1: num0 = _1;
    4'd2: num0 = _2;
    4'd3: num0 = _3;
    4'd4: num0 = _4;
    4'd5: num0 = _5;
    4'd6: num0 = _6;
    4'd7: num0 = _7;
    4'd8: num0 = _8;
    4'd9: num0 = _9;
    default: num0 = _none;
  endcase
end



endmodule