// TestBench
module users_tb();
reg Reset, Enter;
reg [11:0] PassIn;
reg [1:0] User;
wire Access, Alarm;
wire [1:0] Count;
users uut(Reset, User, PassIn, Enter, Access, Count, Alarm);
initial begin
Enter=0;
Reset=0;
User=2'b01;
PassIn=12'hf2a;
#1 Enter=1;
#1 Enter=0;
#98 PassIn=12'h0aa;
#1 Enter=1;
#1 Enter=0;
#98 PassIn=12'h999;
#1 Enter=1;
#1 Enter=0;
#98 PassIn=12'h123;
#1 Enter=1;
#1 Enter=0;
#98 PassIn=12'h007;
#1 Enter=1;
#1 Enter=0;
#98 PassIn=12'hf2a;
#1 Enter=1;
#1 Enter=0;
#48 Reset=1;
#1 Reset=0;
#49 PassIn=12'h567;
#1 Enter=1;
#1 Enter=0;
#98 PassIn=12'hf2a;
#1 Enter=1;
#1 Enter=0;
#98$finish;
end
initial begin
  $dumpfile("dump.vcd");
  $dumpvars(0,User,PassIn,Enter,Access,Reset,Count,Alarm);
end
endmodule
