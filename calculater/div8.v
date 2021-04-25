//除法运算模块
module div8  
(  
input[7:0] a,   
input[7:0] b,  
output reg [7:0] yshang,  
output reg [7:0] yyushu
);  
  
reg[7:0] tempa;  
reg[7:0] tempb;  
reg[15:0] temp_a;  
reg[15:0] temp_b;  
  
integer i;  
  
always @(*)  
begin  
    tempa <= a;  
    tempb <= b;  
end  
  

always @(*)    
begin  

    temp_a = {8'h00,tempa};  
    temp_b = {tempb,8'h00};  

    for(i = 0;i < 8;i = i + 1)  
        begin  
            temp_a = {temp_a[14:0],1'b0};  
            if(temp_a[15:8] >= tempb)  
                temp_a = temp_a - temp_b + 1'b1;  
            else  
                temp_a = temp_a;  
        end  
  
    yshang = temp_a[7:0];  
    yyushu = temp_a[15:8]; 

end  
  
endmodule
