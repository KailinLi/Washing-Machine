`timescale 1ns/1ps
module Model(
  cp, 
  click,
  waterBtn,
  state,
  setData,
  outData
);
    input cp;
    input click;
    input waterBtn;
    input [2:0] state;
    output reg [2:0] setData;
    output [25:0] outData;

    localparam shutDownST = 0, beginST = 1, setST = 2, runST = 3;
    localparam errorST = 4, pauseST = 5, finishST = 6;

    localparam set_WRD_ST = 0, set_W_ST = 1, set_WR_ST = 2;
    localparam set_R_ST = 3, set_RD_ST = 4, set_D_ST = 5, set_USE_ST = 6;

    reg [2:0] inWaterTime;
    wire [2:0] setting;
    wire [25:0] data;

    assign setting = setData;

    getTime t (setting, inWaterTime, data);

    select s (state, setting, data, outData);

    always @(posedge cp) begin
      if (state == setST && click && !waterBtn) begin
        setData <= (setData == set_USE_ST) ? set_WRD_ST : setData + 1;
        inWaterTime <= 3;
      end
      else if (state == setST && click && waterBtn) begin
        setData <= set_USE_ST;
        inWaterTime <= (inWaterTime == 7) ? 7 : inWaterTime + 1;
      end
      else if (state == beginST) begin
        setData <= 0;
        inWaterTime <= 3;
      end
      else begin
        setData <= setData;
        inWaterTime <= inWaterTime;
      end
    end
endmodule // Model

module getTime(
  setData,
  inWaterTime,
  getData
);
    input [2:0] setData;
    input [2:0] inWaterTime;
    output reg [25:0] getData;

    localparam set_WRD_ST = 0, set_W_ST = 1, set_WR_ST = 2;
    localparam set_R_ST = 3, set_RD_ST = 4, set_D_ST = 5, set_USE_ST = 6;

    always @(*) begin
      case (setData)
        set_WRD_ST: begin
          getData <= 26'b011_1010_100_101_011_1000_100_101;
        end
        set_W_ST: begin
          getData <= 26'b011_1010_000_000_000_0000_000_000;
        end 
        set_WR_ST: begin
          getData <= 26'b011_1010_100_101_011_1000_000_000;
        end
        set_R_ST: begin
          getData <= 26'b000_0000_100_101_011_1000_000_000;
        end
        set_RD_ST: begin
          getData <= 26'b000_0000_100_101_011_1000_100_101;
        end
        set_D_ST: begin
          getData <= 26'b000_0000_000_000_000_0000_100_101;
        end
        set_USE_ST: begin
          getData <= {inWaterTime, 4'b1010, 3'b100, 3'b101, inWaterTime, 4'b1000, 3'b100, 3'b101};
        end
      endcase
    end
endmodule // getTime

module select(
  state,
  setData,
  data,
  res
);
  input [2:0] state;
  input [2:0] setData;
  input [25:0] data;
  output wire [25:0] res;

  localparam shutDownST = 0, beginST = 1, setST = 2, runST = 3;
  localparam errorST = 4, pauseST = 5, finishST = 6;

  localparam set_WRD_ST = 0, set_W_ST = 1, set_WR_ST = 2;
  localparam set_R_ST = 3, set_RD_ST = 4, set_D_ST = 5, set_USE_ST = 6;
  assign res = (state != setST) ? data :
               (state == beginST) ? 0 :
               (setData == set_WRD_ST) ? 26'b000_0000_000_000_000_0001_001_001 :
               (setData == set_W_ST) ?   26'b000_0000_000_000_000_0001_000_000 : 
               (setData == set_WR_ST) ?  26'b000_0000_000_000_000_0001_001_000 :
               (setData == set_R_ST) ?   26'b000_0000_000_000_000_0000_001_000 :
               (setData == set_RD_ST) ?  26'b000_0000_000_000_000_0000_001_001 :
               (setData == set_D_ST) ?   26'b000_0000_000_000_000_0000_000_001 :
               (setData == set_USE_ST) ? 26'b000_0000_000_000_000_0001_001_001 : data;
endmodule // select