`timescale 1ns/1ps

module tb_traffic_light_controller;
    reg clk, rst;
    wire red_v, yellow_v, green_v;
    wire red_h, yellow_h, green_h;

    traffic_light_controller uut (
        .clk(clk),
        .rst(rst),
        .red_v(red_v),
        .yellow_v(yellow_v),
        .green_v(green_v),
        .red_h(red_h),
        .yellow_h(yellow_h),
        .green_h(green_h)
    );

    initial begin
        $dumpfile("tb_traffic_light_controller.vcd");
        $dumpvars(0, tb_traffic_light_controller);
        clk = 0;
        rst = 1;
        #20 rst = 0;
        #200 $finish;
    end

    always #5 clk = ~clk;

endmodule