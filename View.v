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

    wire left;
    wire middle;
    wire right;

    parameter shutDownST = 0, beginST = 1, setST = 2, runST = 3;
    parameter errorST = 4, pauseST = 5, finishST = 6;

    parameter showEmpty = 55, showFull = 56, showPause = 57;
    
    assign left = (state == shutDownST) ? showEmpty :
                  (state == beginST) ? showFull :
                  (state == finishST) ? showFull : inLeft;
    assign right = (state == shutDownST) ? showEmpty :
                   (state == beginST) ? showFull :
                   (state == finishST) ? showFull : inRight;
    assign middle = (state == shutDownST) ? showEmpty :
                    (state == beginST) ? showFull : 
                    (state == finishST) ? showFull :
                    (state == pauseST) ? showPause : inMiddle;
    assign w_inWaterLED = (state == shutDownST) ? 1 :
                          (state == beginST) ? 0 :
                          (state == finishST) ? 1 : data[7];
    assign w_WLED = (state == shutDownST) ? 1 :
                    (state == beginST) ? 0 :
                    (state == finishST) ? 1 : data[6];
    assign r_outWaterLED = (state == shutDownST) ? 1 :
                           (state == beginST) ? 0 :
                           (state == finishST) ? 1 : data[5];
    assign r_spinWaterLED = (state == shutDownST) ? 1 :
                            (state == beginST) ? 0 :
                            (state == finishST) ? 1 : data[4];
    assign r_inWaterLED = (state == shutDownST) ? 1 :
                          (state == beginST) ? 0 :
                          (state == finishST) ? 1 : data[3];
    assign r_RLED = (state == shutDownST) ? 1 :
                    (state == beginST) ? 0 :
                    (state == finishST) ? 1 : data[2];
    assign d_outwaterLED = (state == shutDownST) ? 1 :
                           (state == beginST) ? 0 :
                           (state == finishST) ? 1 : data[1];
    assign d_spinWaterLED = (state == shutDownST) ? 1 :
                            (state == beginST) ? 0 :
                            (state == finishST) ? 1 : data[0];

    assign powerLED = data[8];
    assign setLED = data[9];

    ShowView l (cp, left, middle, right, showLeft, showRight);

endmodule // View