`timescale 1ns/1ps
module RunController(
  clk,
  state,
  data,
  hadFinish,
  initTime,
  finishTime,
  msg,
  getSecond
);
    input clk;
    input [2:0] state;
    input [25:0] data;
    output reg hadFinish = 0;
    output reg [2:0] initTime = 5;
    output reg [2:0] finishTime = 5;
    output reg [25:0] msg = 0;
    output getSecond;
    parameter shutDownST = 0, beginST = 1, setST = 2, runST = 3;
    parameter errorST = 4, pauseST = 5, finishST = 6;

    second s (clk, getSecond);

    always @(posedge getSecond) begin
     if (state == runST) begin
       if (initTime == 3) begin
         msg <= data;
       end
       else if (msg[25:23] != 0)
        msg[25:23] <= msg[25:23] - 1;
       else if (msg[22:19] != 0) 
        msg[22:19] <= msg[22:19] - 1;
       else if (msg[18:16] != 0)
        msg[18:16] <= msg[18:16] - 1;
       else if (msg[15:13] != 0)
        msg[15:13] <= msg[15:13] - 1;
       else if (msg[12:10] != 0)
        msg[12:10] <= msg[12:10] - 1;
       else if (msg[9:6] != 0) 
        msg[9:6] <= msg[9:6] - 1;
       else if (msg[5:3] != 0)
        msg[5:3] <= msg[5:3] - 1;
       else if (msg[2:0] != 0)
        msg[2:0] <= msg[2:0] - 1;
       else 
        hadFinish <= 1;
       finishTime <= 5;
       initTime <= 5;
     end
     else if (state == beginST) begin
       initTime <= initTime - 1;
       finishTime <= 5;
       msg <= data;
       hadFinish <= 0;
     end
     else if (state == finishST) begin
       finishTime <= finishTime - 1;
       initTime <= 5;
       msg <= data;
       hadFinish <= 0;
     end
     else if (state == pauseST) begin
       finishTime <= 5;
       initTime <= 5;
       msg <= msg;
       hadFinish <= 0;
     end
     else if (state == setST) begin
       finishTime <= 5;
       initTime <= 3;
       msg <= data;
       hadFinish <= 0;
     end
     else begin
       finishTime <= 5;
       initTime <= 5;
       msg <= data;
       hadFinish <= 0;
     end
    end
endmodule // RunController

module second(
  input clk,
  output reg cp
);
    parameter delay = 5000;
    integer count = 0;
    initial begin
      cp = 1;
    end
    always @(posedge clk) begin
      count = count + 1;
      if (count == delay) begin
        cp = ~cp;
        count = 0;
      end
    end
endmodule // second