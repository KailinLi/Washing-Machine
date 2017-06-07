`timescale 1ns/1ps
module test(
);
  reg cp;
  reg click;
  reg waterBtn;
  reg [2:0] state;
  wire [2:0] setData;
  wire [25:0] data;
  initial begin
    cp = 0;
    forever #5 cp = ~cp;
  end
  Model t (cp, click, waterBtn, state, setData, data);
  initial begin
    $dumpfile("test.vcd");
    $dumpvars;
    click = 0;
    waterBtn = 0;
    state = 0;
    #30 state = 1;
    #25 state = 2;
    #20 click = 1;
    #5 click = 0;
    #15 click = 1;
    #5 click = 0;
    #20 waterBtn = 1;
    #5 click = 1;
    #5 click = 0;
    #5 click = 1;
    #5 click = 0;
    #5 click = 1;
    #5 click = 0;
    #5 click = 1;
    #5 click = 0;
    #20 waterBtn = 0; 
    #15 click = 1;
    #5 click = 0;
    #5 click = 1;
    #5 click = 0;
  end
  initial #500 $finish;
endmodule // test