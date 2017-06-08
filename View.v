`timescale 1ns/1ps
module View(
  cp,
  click,
  state,
  data,
  shinning,
  inLeft, inMiddle, inRight,
  second,
  showLeft, showRight,
  w_inWaterLED,
  w_WLED,
  r_outWaterLED,
  r_spinWaterLED,
  r_inWaterLED,
  r_RLED,
  d_outwaterLED,
  d_spinWaterLED,
  beeLED,
  setLED,
  powerLED,
  colorLED
);
    input cp;
    input click;
    input [2:0] state;
    input [9:0] data;
    input [2:0] shinning;
    input [5:0] inLeft;
    input [5:0] inMiddle;
    input [5:0] inRight;
    input second;
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
    output beeLED;
    output setLED;
    output powerLED;
    output reg [2:0] colorLED = 0;

    wire [5:0] left;
    wire [5:0] middle;
    wire [5:0] right;

    localparam shutDownST = 0, beginST = 1, setST = 2, runST = 3;
    localparam errorST = 4, pauseST = 5, finishST = 6;

    localparam showEmpty = 55, showFull = 56, showPause = 57, showError = 58, showHE = 59, showLL = 60, showO = 61;

    always @(posedge second) begin
      if (state == runST) begin
        colorLED <= colorLED + 1;
      end
      else if (state == errorST) begin
        colorLED <= 3'b100;
      end
      else if (state == pauseST) begin
        colorLED <= colorLED;
      end
      else begin
        colorLED <= 0;
      end
    end
    
    assign left = (state == shutDownST) ? showEmpty :
                  (state == beginST) ? showHE :
                  (state == finishST) ? showFull : inLeft;
    assign right = (state == shutDownST) ? showEmpty :
                   (state == beginST) ? showO :
                   (state == finishST) ? showFull : inRight;
    assign middle = (state == shutDownST) ? showEmpty :
                    (state == beginST) ? showLL : 
                    (state == finishST) ? showFull :
                    (state == pauseST) ? showPause : 
                    (state == errorST) ? showError : inMiddle;
    assign w_inWaterLED = (state == shutDownST) ? 0 :
                          (state == beginST) ? 1 :
                          (state == finishST) ? 1 : 
                          (state == runST) ? ((shinning == 0) ? second : data[7]) : data[7];
    assign w_WLED = (state == shutDownST) ? 0 :
                    (state == beginST) ? 1 :
                    (state == finishST) ? 1 : 
                    (state == runST) ? ((shinning == 1) ? second : data[6]): data[6];
    assign r_outWaterLED = (state == shutDownST) ? 0 :
                           (state == beginST) ? 1 :
                           (state == finishST) ? 1 : 
                           (state == runST) ? ((shinning == 2) ? second : data[5]) : data[5];
    assign r_spinWaterLED = (state == shutDownST) ? 0 :
                            (state == beginST) ? 1 :
                            (state == finishST) ? 1 : 
                            (state == runST) ? ((shinning == 3) ? second : data[4]) : data[4];
    assign r_inWaterLED = (state == shutDownST) ? 0 :
                          (state == beginST) ? 1 :
                          (state == finishST) ? 1 : 
                          (state == runST) ? ((shinning == 4) ? second : data[3]) : data[3];
    assign r_RLED = (state == shutDownST) ? 0 :
                    (state == beginST) ? 1 :
                    (state == finishST) ? 1 : 
                    (state == runST) ? ((shinning == 5) ? second : data[2]) : data[2];
    assign d_outwaterLED = (state == shutDownST) ? 0 :
                           (state == beginST) ? 1 :
                           (state == finishST) ? 1 : 
                           (state == runST) ? ((shinning == 6) ? second : data[1]) : data[1];
    assign d_spinWaterLED = (state == shutDownST) ? 0 :
                            (state == beginST) ? 1 :
                            (state == finishST) ? 1 : 
                            (state == runST) ? ((shinning == 7) ? second : data[0]) : data[0];

    assign beeLED = (state == finishST) ? second : 
                    (click) ? 1 : 0;

    assign powerLED = data[8];
    assign setLED = (state == beginST) ? 1 : 
                    (state == finishST) ? 1 : 
                    (state == shutDownST) ? 0 : data[9];

    ShowView l (cp, left, middle, right, showLeft, showRight);

endmodule // View