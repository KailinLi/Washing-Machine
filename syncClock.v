module syncClock(
  input clk,
  output reg cp
);
    localparam delay = 5000; //5000
    integer counter = 0;
    initial begin
      cp = 0;
    end
    always @(posedge clk) begin
      counter = counter + 1;
      if (counter == delay) begin
        cp = ~cp;
        counter = 0;
      end
    end
endmodule // syncClock