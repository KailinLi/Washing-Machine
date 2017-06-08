`timescale 1ns / 1ps

module ShowView(
    input clk,
    input [5:0] uTot,
    input [5:0] uCur,
    input [5:0] uWat,
    output [7:0] ySEG_,
    output [7:0] yAN_
);
    wire [2:0] xPos;
    wire [3:0] xVal;
    wire [3:0] xMem[7:0];
    _disp_counter   vC8(clk, xPos);
    _disp_decimal   vDecTot(uTot, xMem[7], xMem[6]);
    _disp_decimal   vDecCur(uCur, xMem[4], xMem[3]);
    assign xMem[5] = 4'hf;
    assign xMem[2] = 4'hf;
    _disp_decimal   vDecWat(uWat, xMem[1], xMem[0]);
    _disp_pattern   vPat(xMem[xPos], ySEG_);
    _disp_position  vPos(xPos, yAN_);
endmodule

module _disp_counter(
    input clk,
    output reg [2:0] yVal = 3'b000
);
    always @(posedge clk)
        yVal <= yVal + 1;
endmodule

module _disp_decimal(
    input [5:0] uVal,
    output [3:0] yE1,
    output [3:0] yE2
);
    assign yE1 = (uVal == 55) ? 4'hf :
                 (uVal == 56) ? 8 : 
                 (uVal == 57) ? 10 : uVal / 10;
    assign yE2 = (uVal == 55) ? 4'hf :
                 (uVal == 56) ? 8 :
                 (uVal == 57) ? 11 : uVal % 10;
endmodule

module _disp_pattern(
    input [3:0] uVal,
    output reg [7:0] ySEG_
);
    always @(uVal)
        case (uVal)
            'b0000:  ySEG_ <= 'b11000000;
            'b0001:  ySEG_ <= 'b11111001;
            'b0010:  ySEG_ <= 'b10100100;
            'b0011:  ySEG_ <= 'b10110000;
            'b0100:  ySEG_ <= 'b10011001;
            'b0101:  ySEG_ <= 'b10010010;
            'b0110:  ySEG_ <= 'b10000010;
            'b0111:  ySEG_ <= 'b11111000;
            'b1000:  ySEG_ <= 'b10000000;
            'b1001:  ySEG_ <= 'b10010000;
            'b1010:  ySEG_ <= 'b10001100;
            'b1011:  ySEG_ <= 'b10001000;
            default: ySEG_ <= 'b11111111;
        endcase
endmodule

module _disp_position(
    input [2:0] uPos,
    output [7:0] yAN_
);
    assign yAN_ = ~(8'b1 << uPos);
endmodule // ShowView
