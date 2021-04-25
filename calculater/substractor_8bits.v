//减法运算模块
module substractor_8bits(sub1,sub2,sub,borrow_out);

input [7:0] sub1;
input [7:0] sub2;
output reg [7:0] sub;
output reg borrow_out;


always @(*)
  begin
	 if(sub1>=sub2)
	  {borrow_out,sub}={1'b0,sub1-sub2};
	 else
	  {borrow_out,sub}={1'b1,sub2-sub1};
  end
 
endmodule
