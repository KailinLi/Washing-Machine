 `timescale 1ns/1ps
module TimeController(
  cp, 
  state,
  setData,
  data, 
  msg,
  showLeft,
  showMiddle,
  showRight,
  initTime,
  finishTime,
  hadFinish,
  running
);
    input cp;
    input [2:0] state;
    input [2:0] setData;
    input [25:0] data;
    output [8:0] msg;
    output [5:0] showLeft;
    output [5:0] showMiddle;
    output [5:0] showRight;
    output [3:0] initTime;
    output [3:0] finishTime;
    output hadFinish;
    output [2:0] running;
    reg w_inWater;
    reg w_W;
    reg r_outWater;
    reg r_spinWater;
    reg r_inWater;
    reg r_R;
    reg d_outwater;
    reg d_spinWater;

    reg count = 0;

    parameter shutDownST = 0, beginST = 1, setST = 2, runST = 3;
    parameter errorST = 4, pauseST = 5, finishST = 6;

    parameter set_WRD_ST = 0, set_W_ST = 1, set_WR_ST = 2;
    parameter set_R_ST = 3, set_RD_ST = 4, set_D_ST = 5, set_USE_ST = 6;

    initial begin
      
    end

    always @(posedge cp) begin
     case (state)
       shutDownST: begin
         initTime <= 5;
       end
       beginST: begin
         if (count < 1000) begin
           count <= count + 1;
           initTime <= initTime;
         end
         else begin
           count <= 0;
           initTime <= initTime - 1;
         end
       end 
       setST: begin
         case (setData)
           set_WRD_ST: msg <= 9'b000000111;
           set_W_ST: msg <= 9'b000000100;
           set_WR_ST: msg <= 9'b000000110;
           set_R_ST: msg <= 9'b000000010;
           set_RD_ST: msg <= 9'b000000011;
           set_D_ST: msg <= 9'b000000001;
           set_USE_ST: msg <= 9'b000000111; 
         endcase
         w_inWater <= data[25:23];
         w_W <= [22:19];
         r_outWater <= [18:16];
         r_spinWater <= [15:13];
         r_inWater <= [12:10];
         r_R <= [9:6];
         d_outwater <= [5:3];
         d_spinWater <= [2:0];
         count <= 0;
       end
       runST: begin
         if (d_spinWater == 0) begin
           hadFinish <= 1;
         end
         if (count < 1000) begin
           count <= count + 1;
         end
         else begin
           count <= 0;
           if (d_outwater == 0) begin
             showMiddle <= d_spinWater;
             d_spinWater <= d_spinWater - 1;
             running <= 7;
           end
           else if (r_R == 0) begin
             showMiddle <= d_outwater;
             d_outwater <= d_outwater - 1;
             running <= 6;
           end
           else if (r_inWater == 0) begin
             showMiddle <= r_R;
             r_R <= r_R - 1;
             running <= 5;
           end
           else if (r_spinWater == 0) begin
             showMiddle <= r_inWater;
             r_inWater <= r_inWater - 1;
             running <= 4;
           end
           else if (r_outWater == 0) begin
             showMiddle <= r_spinWater;
             r_spinWater <= r_spinWater - 1;
             running <= 3;
           end
           else if (w_W == 0) begin
             showMiddle <= r_outWater;
             r_outWater <= r_outWater - 1;
             running <= 2;
           end
           else if (w_inWater == 0) begin
             showMiddle <= w_W;
             w_W <= w_W - 1;
             running <= 1;
           end
           else begin
             showMiddle <= w_inWater;
             w_inWater <= w_inWater - 1;
             running <= 0;
           end
         end
       end
       default: 
     endcase 
    end
endmodule // TimeController