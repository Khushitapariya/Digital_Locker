module users(Reset, User, InputPassword, Enter, Access, Count, Alarm);
input Reset, Enter;
input [1:0] User;
input [11:0] InputPassword;
output Access, Alarm;
output [1:0] Count;
reg [11:0] SetPass;
always @ (*)
begin
case(User)
	2'b00: SetPass=12'hf2a;
	2'b01: SetPass=12'h0aa;
	2'b10: SetPass=12'hece;
	2'b11: SetPass=12'h999;
endcase
end
access a(Reset, SetPass, InputPassword, Enter, Access, Count, Alarm);
endmodule

module access (Reset, SetPass, InputPassword, Enter, Access, Count, Alarm);
input Reset, Enter;
input [11:0] SetPass, InputPassword;
output Access, Alarm;
output [1:0] Count;
wire Check1,Check2,Check3,Check;
comparator_4bit c1(SetPass[3:0],InputPassword[3:0],Check1);
comparator_4bit c2(SetPass[7:4],InputPassword[7:4],Check2);
comparator_4bit c3(SetPass[11:8],InputPassword[11:8],Check3);
and a1(Check,Check1,Check2,Check3);
modN_ctr Counter (Enter, !Check, Reset, Count, Access, Alarm);
endmodule

module comparator_4bit(A, B, Equal);
input [3:0] A;
input [3:0] B;
output reg Equal;
always @(A or B)
begin
if(A == B)
Equal = 1;
else
Equal=0;
end
endmodule

module modN_ctr (clk, E, rstn, cnt, Access, Alarm);
parameter N=4;
input clk, rstn, E;
output reg Access, Alarm;
output reg [1:0]cnt;
initial cnt=0;
always @ (posedge clk, posedge rstn)
if (rstn) begin
Alarm <= 0;
cnt <= 0;
Access<=0;
end
else if (E & cnt==N-2) begin
Access<= 0;
Alarm <= 1;
cnt <= cnt + 1; end
else if (cnt == N-1) begin
Access <= 0;
Alarm <= 1; end
else if (E) begin
cnt <= cnt + 1;
Access <= 0;
Alarm <= 0; end
else begin
cnt <= 0;
Access <= 1;
Alarm <= 0;
end
endmodule
