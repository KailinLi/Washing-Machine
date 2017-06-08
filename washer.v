`timescale 1ns / 1ps
module Washer(
  clk,
  w_inWaterLED,
  w_WLED,
  r_outWaterLED,
  r_spinWaterLED,
  r_inWaterLED,
  r_RLED,
  d_outwaterLED,
  d_spinWaterLED,
  setLED,
  powerLED,

  out_showL, out_showR,

  in_resetBtn,
  in_runBtn,
  in_WaterBtn,
  in_openBtn,
  in_click
);
    input clk;
    output w_inWaterLED;
    output w_WLED;
    output r_outWaterLED;
    output r_spinWaterLED;
    output r_inWaterLED;
    output r_RLED;
    output d_outwaterLED;
    output d_spinWaterLED;
    output setLED;
    output powerLED;

    output wire [7:0] out_showL, out_showR;

    input in_resetBtn;
    input in_runBtn;
    input in_WaterBtn;
    input in_openBtn;
    input in_click;

    wire resetBtn;
    wire runBtn;
    wire WaterBtn;
    wire openBtn;
    wire click;

    wire cp;
    syncClock c (clk, cp);

    syncInput b1 (cp, in_resetBtn, resetBtn);
    syncInput b2 (cp, in_runBtn, runBtn);
    syncInput b6 (cp, in_WaterBtn, WaterBtn);
    syncInput b7 (cp, in_openBtn, openBtn);
    syncInput b8 (cp, in_click, click);


    wire [2:0] state;
    wire hadFinish;
    wire [2:0] initTime;
    wire [2:0] finishTime;
    wire [2:0] setData;
    wire [25:0] data;
    wire [25:0] msg;
    wire [5:0] showLeft;
    wire [5:0] showMiddle;
    wire [5:0] showRight;
    wire [9:0] LEDMsg;


    STController stc (cp, resetBtn, runBtn, openBtn, hadFinish, initTime, finishTime, state);
    Model m (cp, click, WaterBtn, state, setData, data);
    RunController rc (cp, state, data, hadFinish, initTime, finishTime, msg);
    ViewController vc (cp, state, msg, showLeft, showMiddle, showRight, LEDMsg);
    View v (cp, state, LEDMsg, showLeft, showMiddle, showRight, out_showL, out_showR, w_inWaterLED, w_WLED, r_outWaterLED, r_spinWaterLED, r_inWaterLED, r_RLED, d_outwaterLED, d_spinWaterLED, setLED, powerLED);

endmodule // Washer