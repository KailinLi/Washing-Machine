`timescale 1ns / 1ps
module Washer(
  clk,
  powerLED, runLED, setLED, beeLED,
  inWaterLED, outWaterLED, spinLED,
  WLED, RLED, DLED,
  openLED,

  out_showL, out_showR,

  in_resetBtn,
  in_runBtn,
  in_WBtn, in_RBtn, in_DBtn, in_WaterBtn,
  in_openBtn,
  in_click
);
    input clk;
    output reg powerLED, runLED, setLED, beeLED;
    output reg inWaterLED, outWaterLED, spinLED;
    output reg WLED, RLED, DLED;
    output reg openLED;

    output wire [7:0] out_showL, out_showR;

    input in_resetBtn;
    input in_runBtn;
    input in_WBtn, in_RBtn, in_DBtn, in_WaterBtn;
    input in_openBtn;
    input in_click;

    wire resetBtn;
    wire runBtn;
    wire WBtn, RBtn, DBtn, WaterBtn;
    wire openBtn;
    wire click;

    wire cp;
    syncClock c (clk, cp);

    syncInput b1 (cp, in_resetBtn, resetBtn);
    syncInput b2 (cp, in_runBtn, runBtn);
    syncInput b3 (cp, in_WBtn, WBtn);
    syncInput b4 (cp, in_RBtn, RBtn);
    syncInput b5 (cp, in_DBtn, DBtn);
    syncInput b6 (cp, in_WaterBtn, WaterBtn);
    syncInput b7 (cp, in_openBtn, openBtn);
    syncInput b8 (cp, in_click, click);

    

endmodule // Washer