`timescale 1ns/1ps
module ViewController(
  cp,
  state,
  msg,
  showLeft,
  showMiddle,
  showRight,
  LEDMsg
);
    input cp;
    input [2:0] state;
    input [25:0] msg;
    output wire [5:0] showLeft;
    output wire [5:0] showMiddle;
    output wire [5:0] showRight;
    output wire [9:0] LEDMsg;

    localparam shutDownST = 0, beginST = 1, setST = 2, runST = 3;
    localparam errorST = 4, pauseST = 5, finishST = 6;

    assign showLeft = msg[25:23]+msg[22:19]+msg[18:16]+msg[15:13]+msg[12:10]+msg[9:6]+msg[5:3]+msg[2:0];
    assign showMiddle = (msg[25:23] != 0)? msg[25:23] :
                        (msg[22:19] != 0)? msg[22:19] :
                        (msg[18:16] != 0)? msg[18:16] :
                        (msg[15:13] != 0)? msg[15:13] :
                        (msg[12:10] != 0)? msg[12:10] :
                        (msg[9:6] != 0)? msg[9:6] :
                        (msg[5:3] != 0)? msg[5:3] :
                        (msg[2:0] != 0)? msg[2:0] : 0;
    assign showRight = msg[25:23];

    assign LEDMsg[0] = (msg[2:0] == 0) ? 0 : 1;
    assign LEDMsg[1] = (msg[5:3] == 0) ? 0 : 1;
    assign LEDMsg[2] = (msg[9:6] == 0) ? 0 : 1;
    assign LEDMsg[3] = (msg[12:10] == 0) ? 0 : 1;
    assign LEDMsg[4] = (msg[15:13] == 0) ? 0 : 1;
    assign LEDMsg[5] = (msg[18:16] == 0) ? 0 : 1;
    assign LEDMsg[6] = (msg[22:19] == 0) ? 0 : 1;
    assign LEDMsg[7] = (msg[25:23] == 0) ? 0 : 1;
    assign LEDMsg[8] = (state == shutDownST) ? 0 : 1;
    assign LEDMsg[9] = (state == setST) ? 1 : 0;


endmodule // ViewController