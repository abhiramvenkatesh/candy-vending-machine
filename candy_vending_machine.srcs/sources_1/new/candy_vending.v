`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 13.11.2023 19:07:21
// Design Name: 
// Module Name: candy_vending
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

module CandyVendingMachine (
    input wire clk,
    input wire reset,
    input wire start,
    input wire [3:0] candySelection,
    input wire [3:0] quantity,
    input wire [7:0] money,
    output reg [7:0] change,
    output reg [7:0] totalCost,
    output reg dispensing
);
    
    reg [7:0] candyPrices [0:7];
    reg [7:0] candyName [0:7];
    
    reg [3:0] state;
    reg [3:0] nextState;
    reg [7:0] selectedCandyPrice;
    
    reg [7:0] totalAmount;
    
    // Read candy prices and names from text files during initialization
    initial begin
        $readmemh("candy.txt", candyName);
        $readmemh("price.txt", candyPrices);
    end

    always @(posedge clk or posedge reset) begin
        if (reset) begin
            state <= 4'b0000;
            totalAmount <= 8'b0;
        end
        else begin
            state <= nextState;
            totalAmount <= totalAmount + money;
        end
    end

    always @* begin
        nextState = state;

        case (state)
            4'b0000: begin // Idle state
                if (start) nextState = 4'b0001; // Transition to candy selection
            end
            4'b0001: begin // Candy selection state
                selectedCandyPrice = candyPrices[candySelection];
                $display(selectedCandyPrice);
                nextState = 4'b0010; // Transition to quantity selection
            end
            4'b0010: begin // Quantity selection state
                totalCost = selectedCandyPrice * quantity;
                $display(totalCost);
                nextState = 4'b0011; // Transition to money input
            end
            4'b0011: begin // Money input state
                if (totalAmount >= totalCost) begin
                    change = totalAmount - totalCost;
                    dispensing = 1;
                    nextState = 4'b0000; // Transition back to idle state
                end
                else begin
                    change = 8'b0;
                    dispensing = 0;
                    nextState = 4'b0011; // Stay in money input state
                end
            end
        endcase
    end

endmodule

module CandyVendingMachine_tb;

    reg clk;
    reg reset;
    reg start;
    reg [3:0] candySelection;
    reg [3:0] quantity;
    reg [7:0] money;

    wire [7:0] change;
    wire [7:0] totalCost;
    wire dispensing;

    CandyVendingMachine uut (
        .clk(clk),
        .reset(reset),
        .start(start),
        .candySelection(candySelection),
        .quantity(quantity),
        .money(money),
        .change(change),
        .totalCost(totalCost),
        .dispensing(dispensing)
    );

    initial begin
        // Initialize signals
        clk = 0;
        reset = 1;
        start = 0;
        candySelection = 4'b0000;
        quantity = 4'b0000;
        money = 8'b0;

        // Apply reset
        #10 reset = 0;

        // Test case 1: Buy candy with exact money
        #10 start = 1;
        #10 candySelection = 4'b0001;
        #10 quantity = 4'b0010;
        #10 money = 20;
        #100;

        // Test case 2: Buy candy with insufficient money
        #10 start = 1;
        #10 candySelection = 4'b0010;
        #10 quantity = 4'b0010;
        #10 money = 15;
        #100;

        // Add more test cases as needed

        $stop;
    end

    // Clock generation
    always #5 clk = ~clk;

endmodule
