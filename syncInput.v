module syncInput(
  input clk,
  input btn,
  output reg syncBtn = 0
);
    reg b1;
    reg b2;
    always @(posedge clk) begin
      b1 <= btn;
      b2 <= b1;
      if (b1 && !b2) begin
        syncBtn <= 1;
      end
      if (!b1 && b2) begin
        syncBtn <= 0;
      end
    end
endmodule // syncInput