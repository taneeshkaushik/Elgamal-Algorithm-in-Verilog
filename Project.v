`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 22.11.2019 15:58:46
// Design Name: 
// Module Name: elgamal
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module elgamal( clk,encrypt,decrypt);
wire[31:0] a,g,q,k;
wire [31:0] message;
input clk;
output [15:0] encrypt;
output [15:0] decrypt;
assign message = 6;
//selectmessage sm(s1,s2,s3,s4,message);
assign a = 5;
assign g = 3;
assign k = 4;
assign q = 7;

reg [31:0] reg_gpowa;
reg [31:0] reg_gpowak;
reg [31:0] reg_gpowk;
wire[ 31:0] gpowa, gpowak,gpowk;
wire [31:0]count1,count2,counter1;
modulopower  m (clk,g,a,q, gpowa,count1);
modulopower  z(clk,g, k,q, gpowk,counter1);
reg help;
initial begin
help=0;
end

wire newclock;


always @ (posedge clk)
begin
if(count1==a)
#0.1
 help=1;
end

assign newclock =clk&help;

modulopower v(newclock, gpowa, k, q, gpowak,count2);
bob   b (newclock,gpowak, message, q,encrypt);

alice o (clk,encrypt,a, gpowak, q,decrypt);
endmodule

/*module selectmessage(s1,s2,s3,s4,mess);
input s1,s2,s3,s4;
output [31:0]mess;
reg [31:0]mess1;

initial begin
if(s4 == 1)
mess1 = 456;
else if(s3 ==1)
mess1 = 547;
else if(s2 == 1)
mess1 = 638;
else if(s1 == 1)
mess1 = 89;
end
assign mess= mess1;
endmodule
*/
module bob(newclk,gpowak, message,q, encrypt);

input newclk;
input [31:0] gpowak, message,q;
output [15:0] encrypt;
reg [127:0] final;
always@(posedge newclk)
begin
    final=  (gpowak*message)% q;
end
assign encrypt=final;
endmodule


module modulopower(clk, g, a,q, gpow,count);
input clk;
input [31:0] g,a;
input [31:0] q;
output [31:0] count;
output [31:0] gpow;
reg [127:0]  counter;
reg [127:0] power;
initial begin 
counter=0;
end

always @( posedge clk)
begin
if(counter==0)
begin
    power=1; 
    counter=1;
    
end

else if(counter<=a)
    begin 
    counter=counter+1;
    power = (power*g)%q;
    end

end
     assign gpow= power;
    assign count=counter;

endmodule


module alice(clk,encrypt, a, gpowk, q, decrypt);
input clk;
input [31:0]a;
input [15:0]encrypt;
input [31:0] gpowk;
input [31:0] q;
output [15:0] decrypt;
reg [31:0] inv;
wire [31:0] inver=4;
/*wire [31:0] gpowak;


reg [31:0]  A2, A3;
reg [31:0]  B2, B3;
reg [31:0] temp, temp1, temp2, temp3;
reg [31:0] count, quo,rem;

initial begin
A2 <= 0;
A3 <= q;

B2 <= 1;
B3 <= gpowak;
end

always @(posedge clk) begin

if (B3)
inv <= B2;
else
begin
temp <= A3;
if (temp >= B3)
begin
temp <= temp - B3;
count <= count +1;
end
else
begin
rem <= temp;
quo <= count;
end
temp2 <= A2;
temp3 <= A3;
A2 <= B2;
A3 <= B3;
B2 <= temp2 - (quo * B2);
B3 <= temp3 - (quo * B3);
end
end */
assign decrypt=(inver*encrypt)%q;           
endmodule













test bench


`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 21.11.2019 12:47:41
// Design Name: 
// Module Name: testbench
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module testbench;

wire [15:0]decrypt,encrypt;
wire [31:0] gpowa,gpowak;

reg [31:0] message;
reg clk;




elgamal elg (clk,  encrypt,decrypt);
reg help;
initial begin 
help=0;
end



//selectmessage sm(s1,s2,s3,s4,message);
reg[31:0] a,g,q,k;

initial begin
assign a = 5;
assign g = 3;
assign k = 4;
assign q = 7;
assign message=6;
end

wire newclk;
assign newclk=clk& help;
wire [31:0] count,count1, counter1,gpowk,counter2;
modulopower z(clk,g, a,q, gpowa,count);
modulopower x (clk, g, k, q,gpowk ,counter2);
modulopower y(newclk,gpowa, k, q ,gpowak,counter1);


 //bob b (newclk,gpowak, message,q, encrypt);

initial begin

clk=1;
/*
#20 clk = 0;#20
clk=1;#20
clk = 0;#20
clk=1;#20
clk = 0;#20
clk=1;#20
clk = 0;#20
clk=1;#20
clk = 0;#20
clk=1;#20
clk = 0;#20
clk=1;#20
clk = 0;#20
clk=1;#20
clk = 0;#20
clk=1;#20
clk = 0;*/
#1000000000
$finish;
end

always
begin
#1 clk = ~clk;
if(count>=a)
help=1;

//message = message + 36;

end
    
endmodule


