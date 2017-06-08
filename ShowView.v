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
    wire [4:0] xMem[7:0];
    _disp_counter   vC8(clk, xPos);
    _disp_decimal   vDecTot(uTot, xMem[7], xMem[6]);
    _disp_decimal   vDecCur(uCur, xMem[4], xMem[3]);
    assign xMem[5] = 5'h1f;
    assign xMem[2] = 5'h1f;
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
    output [4:0] yE1,
    output [4:0] yE2
);
    assign yE1 = (uVal == 55) ? 5'h1f :
                 (uVal == 56) ? 8 : 
                 (uVal == 57) ? 10 : 
                 (uVal == 58) ? 12 : 
                 (uVal == 59) ? 14 : 
                 (uVal == 60) ? 15 : 
                 (uVal == 61) ? 0 : uVal / 10;
    assign yE2 = (uVal == 55) ? 5'h1f :
                 (uVal == 56) ? 8 :
                 (uVal == 57) ? 11 : 
                 (uVal == 58) ? 13 : 
                 (uVal == 59) ? 12 :
                 (uVal == 60) ? 15 :
                 (uVal == 61) ? 5'h1f : uVal % 10;
endmodule

module _disp_pattern(
    input [4:0] uVal,
    output reg [7:0] ySEG_
);
    always @(uVal)
        case (uVal)
            'b00000:  ySEG_ <= 'b11000000;
            'b00001:  ySEG_ <= 'b11111001;
            'b00010:  ySEG_ <= 'b10100100;
            'b00011:  ySEG_ <= 'b10110000;
            'b00100:  ySEG_ <= 'b10011001;
            'b00101:  ySEG_ <= 'b10010010;
            'b00110:  ySEG_ <= 'b10000010;
            'b00111:  ySEG_ <= 'b11111000;
            'b01000:  ySEG_ <= 'b10000000;
            'b01001:  ySEG_ <= 'b10010000;
            'b01010:  ySEG_ <= 'b10001100;
            'b01011:  ySEG_ <= 'b10001000;
            'b01100:  ySEG_ <= 'b10000110;
            'b01101:  ySEG_ <= 'b10101111;
            'b01110:  ySEG_ <= 'b10001001;
            'b01111:  ySEG_ <= 'b11000111;
            default: ySEG_ <= 'b11111111;
        endcase
endmodule

module _disp_position(
    input [2:0] uPos,
    output [7:0] yAN_
);
    assign yAN_ = ~(8'b1 << uPos);
endmodule // ShowView
