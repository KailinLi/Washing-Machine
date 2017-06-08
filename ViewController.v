`timescale 1ns/1ps
module ViewController(
  cp,
  state,
  source,
  msg,
  showLeft,
  showMiddle,
  showRight,
  LEDMsg
);
    input cp;
    input [2:0] state;
    input [25:0] source;
    input [25:0] msg;
    output wire [5:0] showLeft;
    output wire [5:0] showMiddle;
    output wire [5:0] showRight;
    output wire [9:0] LEDMsg;

    localparam shutDownST = 0, beginST = 1, setST = 2, runST = 3;
    localparam errorST = 4, pauseST = 5, finishST = 6;

    assign showLeft = (state == setST) ? source[25:23]+source[22:19]+source[18:16]+source[15:13]+source[12:10]+source[9:6]+source[5:3]+source[2:0] :
                                         msg[25:23]+msg[22:19]+msg[18:16]+msg[15:13]+msg[12:10]+msg[9:6]+msg[5:3]+msg[2:0];
    assign showMiddle = (state == setST) ? (
                        (source[25:23] != 0)? source[25:23] :
                        (source[22:19] != 0)? source[22:19] :
                        (source[18:16] != 0)? source[18:16] :
                        (source[15:13] != 0)? source[15:13] :
                        (source[12:10] != 0)? source[12:10] :
                        (source[9:6] != 0)? source[9:6] :
                        (source[5:3] != 0)? source[5:3] :
                        (source[2:0] != 0)? source[2:0] : 0 ) :

                        (msg[25:23] != 0)? msg[25:23] :
                        (msg[22:19] != 0)? msg[22:19] :
                        (msg[18:16] != 0)? msg[18:16] :
                        (msg[15:13] != 0)? msg[15:13] :
                        (msg[12:10] != 0)? msg[12:10] :
                        (msg[9:6] != 0)? msg[9:6] :
                        (msg[5:3] != 0)? msg[5:3] :
                        (msg[2:0] != 0)? msg[2:0] : 0;
    assign showRight = (state == setST) ? source[25:23] : msg[25:23];

    assign LEDMsg[0] = (state == setST) ? ((source[2:0] == 0) ? 0 : 1) : (msg[2:0] == 0) ? 0 : 1;
    assign LEDMsg[1] = (state == setST) ? ((source[5:3] == 0) ? 0 : 1) : (msg[5:3] == 0) ? 0 : 1;
    assign LEDMsg[2] = (state == setST) ? ((source[9:6] == 0) ? 0 : 1) : (msg[9:6] == 0) ? 0 : 1;
    assign LEDMsg[3] = (state == setST) ? ((source[12:10] == 0) ? 0 : 1) : (msg[12:10] == 0) ? 0 : 1;
    assign LEDMsg[4] = (state == setST) ? ((source[15:13] == 0) ? 0 : 1) : (msg[15:13] == 0) ? 0 : 1;
    assign LEDMsg[5] = (state == setST) ? ((source[18:16] == 0) ? 0 : 1) : (msg[18:16] == 0) ? 0 : 1;
    assign LEDMsg[6] = (state == setST) ? ((source[22:19] == 0) ? 0 : 1) : (msg[22:19] == 0) ? 0 : 1;
    assign LEDMsg[7] = (state == setST) ? ((source[25:23] == 0) ? 0 : 1) : (msg[25:23] == 0) ? 0 : 1;
    assign LEDMsg[8] = (state == shutDownST) ? 0 : 1;
    assign LEDMsg[9] = (state == setST) ? 1 : 0;


endmodule // ViewController