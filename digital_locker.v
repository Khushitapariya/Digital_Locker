module users (
    input clk, reset,    
    input Enter,          // submit button
    input SET_MODE,       // 1 = set password, 0 = check password
    input  [1:0] User,           // user select
    input  [11:0] InputPassword, // password input

    output reg   Access,         // access granted
    output reg   Alarm,          // alarm signal
    output reg [1:0] Count       // failed attempt count
);

    // password memory for 4 users
    reg [11:0] PassMem [0:3];

    // password match signal
    wire match;
    assign match = (InputPassword == PassMem[User]);

    // Password programming logic
    always @(posedge clk or posedge reset) begin
        if (reset) begin
            // default passwords
            PassMem[0] <= 12'hF2A;
            PassMem[1] <= 12'h0AA;
            PassMem[2] <= 12'hECE;
            PassMem[3] <= 12'h999;
        end
        else if (SET_MODE && Enter) begin
            PassMem[User] <= InputPassword; // program new password
        end
    end

    // Access control + alarm logic
    always @(posedge clk or posedge reset) begin
        if (reset) begin
            Count  <= 0;
            Access <= 0;
            Alarm  <= 0;
        end
        else if (Enter && !SET_MODE) begin
            if (match) begin
                Access <= 1;
                Count  <= 0;
                Alarm  <= 0;
            end
            else begin
                Access <= 0;
                Count  <= Count + 1;
                if (Count == 2)   // alarm on 3rd failed attempt
                    Alarm <= 1;
            end
        end
    end

endmodule

