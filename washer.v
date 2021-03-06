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
  beeLED,
  colorLED,

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
    output beeLED;
    output [2:0] colorLED;

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


    Pretreatment pr (clk, cp, in_resetBtn, resetBtn, in_runBtn, runBtn, in_WaterBtn, WaterBtn, in_openBtn, openBtn, in_click, click);

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
    wire [25:0] sourceData;
    wire second;
    wire [2:0] shinning;
    wire [2:0] waterTime;
    wire [1:0] sleepTime;

    STController stc (cp, resetBtn, runBtn, openBtn, click, hadFinish, initTime, finishTime, sleepTime, shinning, state);
    Model m (cp, click, WaterBtn, state, setData, data, sourceData, waterTime);
    RunController rc (cp, state, data, hadFinish, initTime, finishTime, sleepTime, msg, second);
    ViewController vc (cp, state, data, msg, sourceData, waterTime, showLeft, showMiddle, showRight, LEDMsg, shinning);
    View v (cp, click, state, LEDMsg, shinning, showLeft, showMiddle, showRight, initTime, second, out_showL, out_showR, w_inWaterLED, w_WLED, r_outWaterLED, r_spinWaterLED, r_inWaterLED, r_RLED, d_outwaterLED, d_spinWaterLED, beeLED, setLED, powerLED, colorLED);

endmodule // Washer