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
    syncInput b8 (clk, in_click, click);

    shine s (click, beeLED);

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


    STController stc (cp, resetBtn, runBtn, openBtn, hadFinish, initTime, finishTime, state);
    Model m (cp, click, WaterBtn, state, setData, data, sourceData);
    RunController rc (cp, state, data, hadFinish, initTime, finishTime, msg, second);
    ViewController vc (cp, state, data, msg, sourceData, showLeft, showMiddle, showRight, LEDMsg, shinning);
    View v (cp, state, LEDMsg, shinning, showLeft, showMiddle, showRight, second, out_showL, out_showR, w_inWaterLED, w_WLED, r_outWaterLED, r_spinWaterLED, r_inWaterLED, r_RLED, d_outwaterLED, d_spinWaterLED, setLED, powerLED);

endmodule // Washer

module shine(
  click,
  shine
);
  input click;
  output shine;
  assign shine = click;
endmodule // shine