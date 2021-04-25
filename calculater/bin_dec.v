//8位二进制转化为BCD码
module bin_dec(clk,bin,rst_n,one,ten,hun,count);
  input [7:0] bin;
  input clk, rst_n;
  output [3:0] one, ten;
  output [3:0] count;
  output [1:0] hun;

  reg [3:0] one, ten, count;
  reg [1:0] hun;
  reg [17:0]shift_reg;

  
//计数部分
always @(posedge clk)
begin
  if (rst_n)
    count<=0;
  else if (count==9)
    count<=0;
  else
    count<=count+1;
end


//二进制转换为十进制
always @(posedge clk)
begin
  if(rst_n)
    shift_reg=0;
  else if(count==0)
    shift_reg={10'b0000000000,bin};
  else if(count<=8)
    begin
	   if(shift_reg[11:8]>=5)
		  begin
		    if(shift_reg[15:12]>=5)
			   begin
				  shift_reg[15:12]=shift_reg[15:12]+2'b11;
				  shift_reg[11:8]=shift_reg[11:8]+2'b11;
				  shift_reg=shift_reg<<1;
				end
			 else
			   begin
				  shift_reg[15:12]=shift_reg[15:12];
              shift_reg[11:8]=shift_reg[11:8]+2'b11;
              shift_reg=shift_reg<<1;
				end
		  end
      else
        begin
	       if(shift_reg[15:12]>=5)
		      begin
		        shift_reg[15:12]=shift_reg[15:12]+2'b11;
			     shift_reg[11:8]=shift_reg[11:8];
			     shift_reg=shift_reg<<1;
		      end
		  else
		    begin
		      shift_reg[15:12]=shift_reg[15:12];
			   shift_reg[11:8]=shift_reg[11:8];
			   shift_reg=shift_reg<<1;
		    end
        end
    end
end


//输出赋值
always @(posedge clk)
begin
  if(rst_n)
    begin
      one<=0;
      ten<=0;
      hun<=0;
    end
  else if(count==9)
    begin
      one<=shift_reg[11:8];
      ten<=shift_reg[15:12];
      hun<=shift_reg[17:16];
    end
end
endmodule
