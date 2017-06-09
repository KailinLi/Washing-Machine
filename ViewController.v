`timescale 1ns/1ps
module ViewController(
  cp,
  state,
  source,
  msg,
  sourceData,
  waterTime,
  showLeft,
  showMiddle,
  showRight,
  LEDMsg, 
  shinning
);
    input cp;
    input [2:0] state;
    input [25:0] source;
    input [25:0] msg;
    input [25:0] sourceData;
    input [2:0] waterTime;
    output wire [5:0] showLeft;
    output wire [5:0] showMiddle;
    output wire [5:0] showRight;
    output wire [9:0] LEDMsg;
    output wire [2:0] shinning;

    localparam shutDownST = 0, beginST = 1, setST = 2, runST = 3;
    localparam errorST = 4, pauseST = 5, finishST = 6, sleepST = 7;

    assign shinning =   (msg[25:23] != 0)? 0 :
                        (msg[22:19] != 0)? 1 :
                        (msg[18:16] != 0)? 2 :
                        (msg[15:13] != 0)? 3 :
                        (msg[12:10] != 0)? 4 :
                        (msg[9:6] != 0)? 5 :
                        (msg[5:3] != 0)? 6 : 7;

    assign showLeft = (state == setST) ? sourceData[25:23]+sourceData[22:19]+sourceData[18:16]+sourceData[15:13]+sourceData[12:10]+sourceData[9:6]+sourceData[5:3]+sourceData[2:0] :
                                         msg[25:23]+msg[22:19]+msg[18:16]+msg[15:13]+msg[12:10]+msg[9:6]+msg[5:3]+msg[2:0];
    assign showMiddle = (state == setST) ? (
                        (sourceData[25:23] != 0)? sourceData[25:23] :
                        (sourceData[22:19] != 0)? sourceData[22:19] :
                        (sourceData[18:16] != 0)? sourceData[18:16] :
                        (sourceData[15:13] != 0)? sourceData[15:13] :
                        (sourceData[12:10] != 0)? sourceData[12:10] :
                        (sourceData[9:6] != 0)? sourceData[9:6] :
                        (sourceData[5:3] != 0)? sourceData[5:3] :
                        (sourceData[2:0] != 0)? sourceData[2:0] : 0 ) :

                        (msg[25:23] != 0)? msg[25:23] :
                        (msg[22:19] != 0)? msg[22:19] :
                        (msg[18:16] != 0)? msg[18:16] :
                        (msg[15:13] != 0)? msg[15:13] :
                        (msg[12:10] != 0)? msg[12:10] :
                        (msg[9:6] != 0)? msg[9:6] :
                        (msg[5:3] != 0)? msg[5:3] :
                        (msg[2:0] != 0)? msg[2:0] : 0;
    assign showRight = {3'b000, waterTime}; //(state == setST) ? sourceData[25:23] : msg[25:23];

    assign LEDMsg[0] = (state == setST) ? ((source[2:0] == 0) ? 0 : 1) : (msg[2:0] == 0) ? 0 : 1;
    assign LEDMsg[1] = (state == setST) ? ((source[5:3] == 0) ? 0 : 1) : (msg[5:3] == 0) ? 0 : 1;
    assign LEDMsg[2] = (state == setST) ? ((source[9:6] == 0) ? 0 : 1) : (msg[9:6] == 0) ? 0 : 1;
    assign LEDMsg[3] = (state == setST) ? ((source[12:10] == 0) ? 0 : 1) : (msg[12:10] == 0) ? 0 : 1;
    assign LEDMsg[4] = (state == setST) ? ((source[15:13] == 0) ? 0 : 1) : (msg[15:13] == 0) ? 0 : 1;
    assign LEDMsg[5] = (state == setST) ? ((source[18:16] == 0) ? 0 : 1) : (msg[18:16] == 0) ? 0 : 1;
    assign LEDMsg[6] = (state == setST) ? ((source[22:19] == 0) ? 0 : 1) : (msg[22:19] == 0) ? 0 : 1;
    assign LEDMsg[7] = (state == setST) ? ((source[25:23] == 0) ? 0 : 1) : (msg[25:23] == 0) ? 0 : 1;
    assign LEDMsg[8] = (state == shutDownST || state == sleepST) ? 0 : 1;
    assign LEDMsg[9] = (state == setST) ? 1 : 0;


endmodule // ViewController