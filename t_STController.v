`timescale 1ns/1ps
module test(
);
    reg cp;
    initial begin
      cp <= 0;
      forever #5 cp <= ~cp;
    end
    reg resetBtn, runBtn, openBtn;
    reg hadFinish;
    reg [2:0] initTime;
    reg [2:0] finishTime;

    wire [2:0] state;
    STController t (cp, resetBtn, runBtn, openBtn, hadFinish, initTime, finishTime, state);
    initial begin
      $dumpfile("test.vcd");
      $dumpvars;
      resetBtn = 0;
      runBtn = 0;
      openBtn = 0;
      hadFinish = 0;
      initTime = 5;
      finishTime = 5;

      #5 resetBtn = 1;
      #20 initTime = initTime - 1;
      #10 initTime = initTime - 1;
      #10 initTime = initTime - 1;
      #10 initTime = initTime - 1;
      #10 initTime = initTime - 1;
      #10 initTime = initTime - 1;

      #40 runBtn = 1;

      #30 runBtn = 0;

      #10 runBtn = 1;

      #50 openBtn = 1;
      #30 openBtn = 0;

      #60 hadFinish = 1;

      #30 finishTime = finishTime - 1;
      #10 finishTime = finishTime - 1;
      #10 finishTime = finishTime - 1;
      #10 finishTime = finishTime - 1;
      #10 finishTime = finishTime - 1;
      #10 finishTime = finishTime - 1;
      #10 finishTime = finishTime - 1;
      #10 finishTime = finishTime - 1;
      
    end
    initial #1000 $finish;
endmodule // test