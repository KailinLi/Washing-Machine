`timescale 1ns / 1ps
module Pretreatment(
  clk,
  cp,
  in_resetBtn,
  resetBtn,
  in_runBtn,
  runBtn,
  in_WaterBtn,
  WaterBtn,
  in_openBtn,
  openBtn,
  in_click,
  click
);
  input clk;
  output cp;
  input in_resetBtn;
  output resetBtn;
  input in_runBtn;
  output runBtn;
  input in_WaterBtn;
  output WaterBtn;
  input in_openBtn;
  output openBtn;
  input in_click;
  output click;
  
  syncClock c (clk, cp);

  syncInput b1 (cp, in_resetBtn, resetBtn);
  syncInput b2 (cp, in_runBtn, runBtn);
  syncInput b6 (cp, in_WaterBtn, WaterBtn);
  syncInput b7 (cp, in_openBtn, openBtn);
  syncInput sc (cp, in_click, click);
endmodule // Pretreatment