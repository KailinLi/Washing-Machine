`timescale 1ns/1ps
module Model(
  cp, 
  click,
  waterBtn,
  state,
  data
);
    input cp;
    input click;
    input waterBtn;
    input [2:0] state;
    output reg [25:0] data;

    parameter shutDownST = 0, beginST = 1, setST = 2, runST = 3;
    parameter errorST = 4, pauseST = 5, finishST = 6;

    parameter set_WRD_ST = 0, set_W_ST = 1, set_WR_ST = 2;
    parameter set_R_ST = 3, set_RD_ST = 4, set_D_ST = 5, set_USE_ST = 6;

    reg [2:0] setting;
    reg [2:0] inWaterTime;

    getTime t (setting, inWaterTime, data);

    always @(posedge cp) begin
      if (state == setST && click && !waterBtn) begin
        setting <= (setting == 6) ? set_WRD_ST : setting + 1;
      end
      else (state == setST && click && waterBtn) begin
        inWaterTime <= (inWaterTime == 6) ? 6 : inWaterTime + 1;
      end
    end
endmodule // Model

module getTime(
  setting,
  inWaterTime,
  data
);
    input setting;
    input [2:0] inWaterTime;
    output reg [25:0] data;

    parameter set_WRD_ST = 0, set_W_ST = 1, set_WR_ST = 2;
    parameter set_R_ST = 3, set_RD_ST = 4, set_D_ST = 5, set_USE_ST = 6;

    always @(*) begin
      case (setting)
        set_WRD_ST: begin
          data <= 26'b011_1010_100_101_011_1000_100_101;
        end
        set_W_ST: begin
          data <= 26'b011_1010_000_000_000_0000_000_000;
        end 
        set_WR_ST: begin
          data <= 26'b011_1010_100_101_011_1000_000_000;
        end
        set_R_ST: begin
          data <= 26'b000_0000_100_101_011_1000_000_000;
        end
        set_RD_ST: begin
          data <= 26'b000_0000_100_101_011_1000_100_101;
        end
        set_D_ST: begin
          data <= 26'b000_0000_000_000_000_0000_100_101;
        end
        set_USE_ST: begin
          data <= {inWaterTime, 4'b1010, 3'b100, 3'b101, inWaterTime, 4'b1000, 3'b100, 3'b101};
        end
      endcase
    end
endmodule // getTime