`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 02/11/2022 11:06:21 AM
// Design Name: 
// Module Name: early_debouncer_test
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


module early_debouncer_test(
    input logic sw, reset, clk,
    output logic [6:0] SEG,
    output logic [7:0] AN
    );
    
    //debounced singal
    logic db;
    early_debouncer debounced(.*);
    
    //edge detectors
    logic sw_tick,db_tick;
    
    rising_edge_detect_mealy swEdge (
        .level(sw),
        .tick(sw_tick),
        .*
    );
    
    rising_edge_detect_mealy dbEdge (
        .level(db),
        .tick(db_tick),
        .*
    );
    
    //binary counters
    logic [7:0] sw_count, db_count;
    
    binary_counter swCounter (
        .q(sw_count),
        .en(sw_tick),
        .max_tick(),
        .*
    );
    
    binary_counter db_counter (
        .q(db_count),
        .en(db_tick),
        .max_tick(),
        .*
    );
    
    time_mux_disp Display (
        .in0({1'b1 ,sw_count[3:0], 1'b1}),
        .in1({1'b1 ,sw_count[7:4], 1'b1}),
        .in2(),
        .in3(),
        .in4({1'b1 ,db_count[3:0], 1'b1}),
        .in5({1'b1 ,db_count[7:4], 1'b1}),
        .in6(),
        .in7(),
        .dp(),
        .sseg(SEG),
        .an(AN),
        .* 
    );  
endmodule
