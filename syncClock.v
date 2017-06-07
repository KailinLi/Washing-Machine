module syncClock(
  input clk,
  output reg cp
);
    parameter delay = 5_000;
    integer counter = 0;
    initial begin
      cp <= 0;
    end
    always @(posedge clk) begin
      counter <= counter + 1;
      if (counter == delay) begin
        cp <= ~cp;
        counter <= 0;
      end
    end
endmodule // syncClock