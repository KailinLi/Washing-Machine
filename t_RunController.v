`timescale 1ns/1ps
module test(
);
    reg clk;
    reg [2:0] state;
    reg [25:0] data;
    wire hadFinish;
    wire [2:0] initTime;
    wire [2:0] finishTime;
    wire [25:0] msg;
    RunController t (clk, state, data, hadFinish, initTime, finishTime, msg);
    initial begin
      clk <= 0;
      forever #1 clk <= ~clk;
    end

    initial begin
        $dumpfile("test.vcd");
        $dumpvars;
        state = 0;
        data = 0;
        #30 state = state + 1;
        #10 data = 26'b011_1010_100_101_011_1000_100_101;
        #100 state = state + 1;
        #20 state = state + 1;
        #60 state = 5;
        #40 state = 3;
        #850 state = 6;
    end
    initial #1800 $finish;
endmodule // test