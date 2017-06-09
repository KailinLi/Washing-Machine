`timescale 1ns/1ps
module STController(
  cp, 
  resetBtn, runBtn, openBtn,
  hadFinish, 
  initTime, finishTime,
  shinning,
  state
);
    input cp;
    input resetBtn, runBtn, openBtn;
    input hadFinish;
    input [2:0] initTime;
    input [2:0] finishTime;
    input [2:0] shinning;

    output reg [2:0] state = shutDownST;

    localparam shutDownST = 0, beginST = 1, setST = 2, runST = 3;
    localparam errorST = 4, pauseST = 5, finishST = 6;

    reg sleep;

    reg [2:0] nextState;
    always @(posedge cp) begin
      if (resetBtn == 0) begin
        state <= shutDownST;
        sleep <= 1;
      end
      else begin
        state <= nextState;
        sleep <= 0;
      end
    end
    always @(*) begin
      case (state)
        shutDownST: begin
          if (sleep && resetBtn) begin
            nextState = beginST;
          end
          else begin
            nextState = shutDownST;
          end
        end
        beginST: begin
          if (initTime > 0) begin
            nextState = beginST;
          end
          else begin
            nextState = setST;
          end
        end
        setST: begin
          if (runBtn) begin
            nextState = runST;
          end
          else begin
            nextState = setST;
          end
        end
        runST: begin
          if (!runBtn) begin
            nextState = pauseST;
          end
          else if (openBtn && (shinning == 3 || shinning == 7)) begin
            nextState = errorST;
          end
          else if (openBtn) begin
            nextState = pauseST;
          end
          else if (hadFinish) begin
            nextState = finishST;
          end
          else begin
            nextState = runST;
          end
        end
        errorST: begin
          if (openBtn) begin
            nextState = errorST;
          end
          else begin
            nextState = runST;
          end
        end
        pauseST: begin
          if (runBtn && !openBtn) begin
            nextState = runST;
          end
          else if (openBtn) begin
            nextState = pauseST;
          end
          else begin
            nextState = pauseST;
          end
        end
        finishST: begin
          if (runBtn == 0) begin
            nextState = setST;
          end
          else if (finishTime > 0) begin
            nextState = finishST;
          end
          else begin
            nextState = shutDownST;
          end
        end
      endcase
    end
endmodule // STController