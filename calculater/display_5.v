//加法、减法、乘法运算结果在数码管上显示
module display_5(
q,
letter7,
letter6,
letter5,
letter4,
letter3,
letter2,
letter1,
letter0
);
input  [19:0] q;
output reg [6:0] letter4,letter3,letter2,letter1,letter0;
output [6:0] letter7,letter6,letter5;

wire [3:0] f4, f3, f2, f1, f0;

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
			 

assign  f4 = q[19:16];
assign  f3 = q[15:12]; 
assign  f2 = q[11:8]; 
assign  f1 = q[7:4]; 
assign  f0 = q[3:0];

always@(*)begin
  case(f4)
    4'd0: letter4 = _0;
    4'd1: letter4 = _1;
    4'd2: letter4 = _2;
    4'd3: letter4 = _3;
    4'd4: letter4 = _4;
    4'd5: letter4 = _5;
    4'd6: letter4 = _6;
    4'd7: letter4 = _7;
    4'd8: letter4 = _8;
    4'd9: letter4 = _9;
    default: letter4 = _none;
  endcase
end

always@(*)begin
  case(f3)
    4'd0: letter3 = _0;
    4'd1: letter3 = _1;
    4'd2: letter3 = _2;
    4'd3: letter3 = _3;
    4'd4: letter3 = _4;
    4'd5: letter3 = _5;
    4'd6: letter3 = _6;
    4'd7: letter3 = _7;
    4'd8: letter3 = _8;
    4'd9: letter3 = _9;
    default: letter3 = _none;
  endcase
end

always@(*)begin
  case(f2)
    4'd0: letter2 = _0;
    4'd1: letter2 = _1;
    4'd2: letter2 = _2;
    4'd3: letter2 = _3;
    4'd4: letter2 = _4;
    4'd5: letter2 = _5;
    4'd6: letter2 = _6;
    4'd7: letter2 = _7;
    4'd8: letter2 = _8;
    4'd9: letter2 = _9;
    default: letter2 = _none;
  endcase
end

always@(*)begin
  case(f1)
    4'd0: letter1 = _0;
    4'd1: letter1 = _1;
    4'd2: letter1 = _2;
    4'd3: letter1 = _3;
    4'd4: letter1 = _4;
    4'd5: letter1 = _5;
    4'd6: letter1 = _6;
    4'd7: letter1 = _7;
    4'd8: letter1 = _8;
    4'd9: letter1 = _9;
    default: letter1 = _none;
  endcase
end

always@(*)begin
  case(f0)
    4'd0: letter0 = _0;
    4'd1: letter0 = _1;
    4'd2: letter0 = _2;
    4'd3: letter0 = _3;
    4'd4: letter0 = _4;
    4'd5: letter0 = _5;
    4'd6: letter0 = _6;
    4'd7: letter0 = _7;
    4'd8: letter0 = _8;
    4'd9: letter0 = _9;
    default: letter0 = _none;
  endcase
end

assign letter7 = _none;
assign letter6 = _none;
assign letter5 = _none;

endmodule
