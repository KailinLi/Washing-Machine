`timescale 1ns / 1ps
module test(
);
  reg clk;
  wire w_inWaterLED;
  wire w_WLED;
  wire r_outWaterLED;
  wire r_spinWaterLED;
  wire r_inWaterLED;
  wire r_RLED;
  wire d_outwaterLED;
  wire d_spinWaterLED;
  wire setLED;
  wire powerLED;
  wire beeLED;
  wire [2:0] colorLED;

  wire [7:0] out_showL, out_showR;

  reg in_resetBtn;
  reg in_runBtn;
  reg in_WBtn, in_RBtn, in_DBtn, in_WaterBtn;
  reg in_openBtn;
  reg in_click;

  initial begin
    clk = 1;
    forever #0.05 clk = ~clk;
  end
  Washer t (clk, w_inWaterLED, w_WLED, r_outWaterLED, r_spinWaterLED, r_inWaterLED, r_RLED, d_outwaterLED, d_spinWaterLED, setLED, powerLED, out_showL, out_showR, beeLED, colorLED, in_resetBtn, in_runBtn, in_WaterBtn, in_openBtn, in_click);
  initial begin
      $dumpfile("test.vcd");
      $dumpvars;
      in_resetBtn = 0;
      in_runBtn = 0;
      in_WaterBtn = 0;
      in_openBtn = 0;
      in_click = 0;

      #50 in_resetBtn = 1;
      #50 in_click = 1;
      #1.5 in_click = 0;
      #10 in_runBtn = 1;
      #2000 in_openBtn = 1;
      #30 in_openBtn = 0;
  end
  initial #8800 $finish;
endmodule // test