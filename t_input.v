`timescale 1ns/1ps
module test(
);
    reg clk;
    reg btn;
    wire syncBtn;
    initial begin
      clk = 0;
      forever #0.8 clk = ~clk;
    end
    syncInput t (clk, btn, syncBtn);
    initial begin
      $dumpfile("test.vcd");
      $dumpvars;
      btn = 0;
      #2 btn = 1;
      #4 btn = 0;
      #5 btn = 1;
      #2 btn = 0;
      #5 btn = 1;
      #4 btn = 0;
      #6 btn = 1;
      #2 btn = 0;
    end
    initial #500 $finish;
endmodule // test