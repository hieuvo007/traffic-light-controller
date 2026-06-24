module traffic_light_controller (
    // STEP 1: I/O INTERFACE DECLARATION
    input clk,  
    input rst,  
    
    // Vertical traffic lights 
    output reg red_v, 
    output reg yellow_v, 
    output reg green_v, 
    
    // Horizontal traffic lights 
    output reg red_h, 
    output reg yellow_h, 
    output reg green_h  
);

    // STEP 2: STATE ENCODING & MEMORY ALLOCATION
    parameter S0 = 2'b00; // Vert: Green, Horiz: Red
    parameter S1 = 2'b01; // Vert: Yellow, Horiz: Red
    parameter S2 = 2'b10; // Vert: Red, Horiz: Green
    parameter S3 = 2'b11; // Vert: Red, Horiz: Yellow

    reg [1:0] state;   // 2-bit register to hold the current state
    reg [4:0] counter; // 5-bit register for the countdown timer (max value 31)

    // STEP 3: SEQUENTIAL LOGIC (State Transition & Timer Decrement)
    always @(posedge clk or posedge rst) begin
        if (rst) begin
            // Asynchronous reset: Initialize to default safe state
            state <= S0;
            counter <= 10; 
        end else begin
            if (counter > 0) begin
                // Decrement the timer at each clock cycle
                counter <= counter - 1; 
            end else begin
                // Next-state logic and counter preset values
                case (state)
                    S0: begin state <= S1; counter <= 3;  end 
                    S1: begin state <= S2; counter <= 10; end 
                    S2: begin state <= S3; counter <= 3;  end 
                    S3: begin state <= S0; counter <= 10; end 
                    // Fault tolerance: Deadlock recovery mechanism
                    default: begin state <= S0; counter <= 10; end 
                endcase
            end
        end
    end

    // STEP 4:
    always @(*) begin
        red_v = 0; yellow_v = 0; green_v = 0;
        red_h = 0; yellow_h = 0; green_h = 0;   

        case (state) 
            S0: begin
                green_v = 1; red_h = 1;
            end
            S1: begin
                yellow_v = 1; red_h = 1;
            end
            S2: begin
                red_v = 1; green_h = 1;
            end
            S3: begin
                red_v = 1; yellow_h = 1;
            end
            default: begin
                red_v = 1; red_h = 1;
            end
        endcase
    end
    
endmodule

