`timescale 1ns/1ps
module test(
);
    reg cp;
    reg [2:0] state;
    reg [25:0] msg;
    wire [5:0] showLeft;
    wire [5:0] showMiddle;
    wire [5:0] showRight;
    wire [9:0] LEDMsg;
    initial begin
      cp = 0;
      forever #5 cp = ~cp;
    end
    ViewController t (cp, state, msg, showLeft, showMiddle, showRight, LEDMsg);
    initial begin
      $dumpfile("test.vcd");
      $dumpvars;
      state = 0;
      msg = 26'b011_1010_100_101_011_1000_100_101;
      #20 state = 1;
      #20 state = 2;
      #50 msg = 26'b000_0000_100_101_011_1000_100_101;
      #50 msg = 26'b000_0000_000_000_000_0000_000_100;
    end
    initial #500 $finish;
endmodule // test