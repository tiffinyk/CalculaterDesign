//LCD屏显示模块，运算数和运算结果在LCD屏上显示
module LCD(
	rst,
	key,
	clk,
	ten0,one0,ten1,one1,
	hun0,hun1,
	q,
	rw,
	rs,
	en,
	data
	
	);
	input clk,rst;
	input[3:0] key;
	input [3:0]ten0,one0,ten1,one1;
	input [1:0]hun0,hun1;
	input [19:0]q;
	output rs,en,rw;
	output [7:0] data;
	
	reg rs,en_sel;
	reg [7:0] data;
	wire [3:0] ten0,one0,ten1,one1;
	wire [1:0] hun0,hun1;
	wire [19:0]q;
	reg [3:0] ten0_0,one0_0,ten1_1,one1_1;
	reg [1:0] hun0_0,hun1_1;
	reg [19:0]q_0;
	reg [31:0]count,count1;//LCD CLK 分频计数器
	reg lcd_clk;
	reg [7:0] one_1,one_2,one_3,one_4,one_5,one_6,one_7,one_8,one_9,one_10,one_11,one_12,one_13,one_14,one_15,one_16;
	reg [7:0] two_1,two_2,two_3,two_4,two_5,two_6,two_7,two_8,two_9,two_10,two_11,two_12,two_13,two_14,two_15,two_16;
	reg [7:0] next,xianshi,two;
	parameter state0=8'h00,//设置8位格式,2行,5*7    8'h38;
	state1=8'h01,//整体显示,关光标,不闪烁  8'h0C    闪烁 8'h0e
	state2=8'h02,//设定输入方式,增量不移位 8'h06
	state3=8'h03,//清除显示     8'h01
	state4=8'h04,//显示第一行的指令  80H
	state5=8'h05,//显示第二行的指令  80H+40H

	scan=8'h06,
	nul=8'h07;

	parameter 
	   data0=8'h10,//2行，共32个数据
		data1=8'h11,
		data2=8'h12,
		data3=8'h13,
		data4=8'h14,
		data5=8'h15,
		data6=8'h16,
		data7=8'h17,
		data8=8'h18,
		data9=8'h19,
		data10=8'h20,
		data11=8'h21,
		data12=8'h22,
		data13=8'h23,
		data14=8'h24,
		data15=8'h25,
		data16=8'h26,
		data17=8'h27,
		data18=8'h28,
		data19=8'h29,
		data20=8'h30,
		data21=8'h31,
		data22=8'h32,
		data23=8'h33,
		data24=8'h34,
		data25=8'h35,
		data26=8'h36,
		data27=8'h37,
		data28=8'h38,
		data29=8'h39,
		data30=8'h40,
		data31=8'h41;
initial//初始值
begin

	//第一行显示 calculater
	one_1<=" "; one_2<=" "; one_3<=" "; one_4<="c"; one_5<="a"; one_6<="l"; one_7<="c"; one_8<="u";
	one_9<="l";one_10<="a";one_11<="t";one_12<="e";one_13<="r";one_14<=" ";one_15<=" ";one_16<=" ";
	//第二行显示 
	two_1<=" "; two_2<=" "; two_3<=" "; two_4<=" "; two_5<=" "; two_6<=" "; two_7<=" "; two_8<=" ";
	two_9<=" ";two_10<=" ";two_11<="=";two_12<=" ";two_13<=" ";two_14<=" ";two_15<=" ";two_16<=" ";

	hun0_0<=0;ten0_0<=0;one0_0<=0;
	hun1_1<=0;ten1_1<=0;one1_1<=0;
	q_0<=0;
end

	always @(posedge clk )//获得LCD时钟
	begin
	count<=count+1;
	if(count==100_000)
	begin
		count<=0;
		lcd_clk<=~lcd_clk;
	end
	end

	always @(posedge clk or posedge rst )//数字显示
	begin
		if(rst)
		begin
			hun0_0<=0;ten0_0<=0;one0_0<=0;
	      hun1_1<=0;ten1_1<=0;one1_1<=0;
	      q_0<=0;
		end
		else
		begin
	    en_sel<=1;
		 hun0_0<=hun0;ten0_0<=ten0;one0_0<=one0;
	    hun1_1<=hun1;ten1_1<=ten1;one1_1<=one1;
	    q_0<=q;
	    two_1<=(hun1_1)+8'b00110000;
	    two_2<=(ten1_1)+8'b00110000;
	    two_3<=(one1_1)+8'b00110000;
	    two_7<=(hun0_0)+8'b00110000;
	    two_8<=(ten0_0)+8'b00110000;
	    two_9<=(one0_0)+8'b00110000;
	    two_12<=(q_0[19:16])+8'b00110000;
	    two_13<=(q_0[15:12])+8'b00110000;
	    two_14<=(q_0[11:8])+8'b00110000;
	    two_15<=(q_0[7:4])+8'b00110000;
	    two_16<=(q_0[3:0])+8'b00110000;
		end
	end
	
	

//运算符显示
always @(posedge clk)
begin
  case(key)
    4'b1110: two_5<=8'b00101111;
	 4'b1101: two_5<=8'b00101010;
	 4'b1011: two_5<=8'b00101101;
	 4'b0111: two_5<=8'b00101011;
	 default: two_5<=two_5;
  endcase
end
//扫描LCD屏
	always @(posedge lcd_clk)
	begin
		case(next)
			state0:
			begin rs<=0; data<=8'h38; next<=state1;	end//配置液晶
			state1:
			begin rs<=0; data<=8'h0e; next<=state2;	end
			state2:
			begin	rs<=0; data<=8'h06; next<=state3; end
			state3:
			begin	rs<=0; data<=8'h01; next<=state4;	end
			state4:
			begin rs<=0; data<=8'h80; next<=data0; end //显示第一行
			data0:
			begin rs<=1; data<=one_1; next<=data1 ; end
			data1:
			begin rs<=1; data<=one_2; next<=data2 ; end
			data2:
			begin rs<=1; data<=one_3; next<=data3 ; end
			data3:
			begin rs<=1; data<=one_4; next<=data4 ; end
			data4:
			begin rs<=1; data<=one_5; next<=data5 ; end
			data5:
			begin rs<=1; data<=one_6; next<=data6 ; end
			data6:
			begin rs<=1; data<=one_7; next<=data7 ; end
			data7:
			begin rs<=1; data<=one_8; next<=data8 ; end
			data8:
			begin rs<=1; data<=one_9; next<=data9 ; end
			data9:
			begin rs<=1; data<=one_10; next<=data10 ; end
			data10:
			begin rs<=1; data<=one_11; next<=data11 ; end
			data11:
			begin rs<=1; data<=one_12; next<=data12 ; end
			data12:
			begin rs<=1; data<=one_13; next<=data13 ; end
			data13:
			begin rs<=1; data<=one_14; next<=data14 ; end
			data14:
			begin rs<=1; data<=one_15; next<=data15 ; end
			data15:
			begin rs<=1; data<=one_16; next<=state5 ; end

			state5:
			begin rs<=0; data<=8'hC0; next<=data16; end //显示第二行
			data16 :
			begin rs<=1; data<=two_1; next<=data17 ; end
			data17:
			begin rs<=1; data<=two_2; next<=data18 ; end
			data18:
			begin rs<=1; data<=two_3; next<=data19 ; end
			data19:
			begin rs<=1; data<=two_4; next<=data20 ; end
			data20:
			begin rs<=1; data<=two_5; next<=data21 ; end
			data21:
			begin rs<=1; data<=two_6; next<=data22 ; end
			data22:
			begin rs<=1; data<=two_7; next<=data23 ; end
			data23:
			begin rs<=1; data<=two_8; next<=data24 ; end
			data24:
			begin rs<=1; data<=two_9; next<=data25 ; end
			data25 :
			begin rs<=1; data<=two_10; next<=data26 ; end
			data26:
			begin rs<=1; data<=two_11; next<=data27 ; end
			data27 :
			begin rs<=1; data<=two_12; next<=data28 ; end
			data28:
			begin rs<=1; data<=two_13; next<=data29 ; end
			data29:
			begin rs<=1; data<=two_14; next<=data30 ; end
			data30:
			begin rs<=1; data<=two_15; next<=data31 ; end
			data31:
			begin rs<=1; data<=two_16; next<=scan ; end

	scan: //交替更新第一行和第二行数据      
	begin
		next<=state4;
		end
	default:next<=state0;
	endcase
 end
 assign en=lcd_clk && en_sel;
 assign rw=0;
endmodule