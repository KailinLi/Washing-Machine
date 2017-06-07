`timescale 1ns/1ps
module View(
  cp,
  state,
  data,
  inLeft, inMiddle, inRight,
  showLeft, showRight,

  w_inWaterLED,
  w_WLED,
  r_outWaterLED,
  r_spinWaterLED,
  r_inWaterLED,
  r_RLED,
  d_outwaterLED,
  d_spinWaterLED,

  setLED,
  powerLED
);
    input cp;
    input [2:0] state;
    input [8:0] data;
    input [5:0] inLeft;
    input [5:0] inMiddle;
    input [5:0] inRight;

    output [7:0] showLeft;
    output [7:0] showRight;

endmodule // View