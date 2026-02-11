// TestBench
`timescale 1ns/1ps

module users_tb;

  reg clk;
  reg reset;
  reg Enter;
  reg SET_MODE;
  reg [1:0]  User;
  reg [11:0] InputPassword;

  wire Access;
  wire Alarm;
  wire [1:0] Count;

  users dut (
    .clk(clk),
    .reset(reset),
    .Enter(Enter),
    .SET_MODE(SET_MODE),
    .User(User),
    .InputPassword(InputPassword),
    .Access(Access),
    .Alarm(Alarm),
    .Count(Count)
  );

  // Clock generation (10 ns period)
  initial begin
    clk = 0;
    forever #5 clk = ~clk;
  end

  // Test sequence
   initial begin
    reset = 1;
    Enter = 0;
    SET_MODE = 0;
    User = 2'b01;              // User 01 (default pass = 0AA)
    InputPassword = 12'h000;

    #20 reset = 0;

    // Wrong password attempt 1
    #10 InputPassword = 12'h123;
    #10 Enter = 1;
    #10 Enter = 0;

     // Wrong password attempt 2
    #20 InputPassword = 12'h456;
    #10 Enter = 1;
    #10 Enter = 0;

    // Wrong password attempt 3
    // Alarm should go HIGH
    #20 InputPassword = 12'h789;
    #10 Enter = 1;
    #10 Enter = 0;

    // Correct password attempt
    // Access should go HIGH
    #20 InputPassword = 12'h0AA;
    #10 Enter = 1;
    #10 Enter = 0;

    // Program new password (SET_MODE)
     #20 SET_MODE = 1;
        InputPassword = 12'h555;
    #10 Enter = 1;
    #10 Enter = 0;
    #10 SET_MODE = 0;

    // Try old password (should fail)
    #20 InputPassword = 12'h0AA;
    #10 Enter = 1;
    #10 Enter = 0;

    // Try new password (should pass)
     #20 InputPassword = 12'h555;
    #10 Enter = 1;
    #10 Enter = 0;

    #50 $finish;
  end

  // Waveform dump
  initial begin
    $dumpfile("users.vcd");
    $dumpvars(0, users_tb);
  end

endmodule

 
