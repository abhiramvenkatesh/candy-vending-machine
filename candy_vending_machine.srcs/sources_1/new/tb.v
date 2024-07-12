`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 12.11.2023 17:55:26
// Design Name: 
// Module Name: tb
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module tb;
    reg q,clk;
    reg [2:0]candy;
    reg [3:0]qty;
    reg [7:0]money;
    wire [7:0]bal;
    wire [3:0]num;
    wire [7:0]change;
    reg mode;
    Q question(q,clk,candy,qty,money,mode,bal,num,change);
    initial begin
        clk=1'b0;
        forever #1 clk=~clk;
        end
        initial #1000 $finish;
    initial begin
        q=1'b1;
        #2 candy=3'b001;qty=4'b0100;
        #2 mode=1'b0;
        #2 candy=3'b100;qty=4'b0011;
        #2 mode=1'b1;money=8'b01000000;
        #15 $finish;
    end
endmodule
