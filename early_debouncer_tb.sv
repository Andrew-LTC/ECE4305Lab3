`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 02/10/2022 12:20:14 PM
// Design Name: 
// Module Name: early_debouncer_tb
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


module early_debouncer_tb();

    localparam T = 10;//10 ns
    localparam M = 1000000; //1ms

    logic sw,reset,clk,db;

    early_debouncer uut0 (.*);

    always
    begin
        clk = 1'b1;
        #(T / 2);
        clk = 1'b0;
        #(T / 2);
    end
    
    initial
    begin
        reset = 1'b1;
        #(T / 2);
        reset = 1'b0;
    end
    
    initial
    begin        
        sw = 0;
        
        #(3*M);
        
        #(5*M)
        sw = 1;
        
        #(M/2)
        sw = 0;
        
        #(M/4)
        sw = 1;
        
        #(M/8)
        sw = 0;
        
        #(M/4)
        sw = 1;
        
        #(30*M)
        sw = 0;
        
         #(M/4)
        sw = 0;
        
        #(M/4)
        sw = 1;
        
        #(M/8)
        sw = 0;
        
        #(M/4)
        sw = 1;
        
        #(M/8)
        sw = 0;
        
        #(7*M)
        sw = 1;
        
        #(M/8)
        sw = 0;
        
        #(20*M)
        sw = 1;
        
        #(M/4)
        sw = 0;
        
        #(25*M)
        $finish;
    end
endmodule
