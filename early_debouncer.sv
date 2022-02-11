`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 02/10/2022 11:56:21 AM
// Design Name: 
// Module Name: early_debouncer
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


module early_debouncer(
    input logic sw, reset, clk,
    output logic db
    );
    
    //10ms timer
    logic tick;
    mod_m_counter #(.M(1_000_000)) timer10ms (
        .clk(clk),
        .reset(reset),
        .max_tick(tick)
    );
    
    typedef enum {zero, one, wait0_1, wait0_2, wait0_3, wait1_1, wait1_2, wait1_3} state_type;
    
    state_type state_reg, state_next;
    
    always_ff@(posedge clk, posedge reset)
        if(reset)
            state_reg <= zero;
        else
            state_reg <= state_next;
            
    always_comb
    begin
        case(state_reg)
            zero:
                if(sw)
                    state_next = one;
                else
                    state_next = zero;
            one:
                if(tick)
                    state_next = wait0_1;
                else
                    state_next = one;
            wait0_1:
                if(tick)
                    state_next = wait0_2;
                else
                    state_next = wait0_1;
            wait0_2:
                if(tick)
                    state_next = wait0_3;
                else
                    state_next = wait0_2;
            wait0_3:
                if(~sw)
                    state_next = wait1_1;
                else
                    state_next = wait0_3;
            wait1_1:
                if(tick)
                    state_next = wait1_2;
                else
                    state_next = wait1_1;
            wait1_2:
                if(tick)
                    state_next = wait1_3;
                else
                    state_next = wait1_2;
            wait1_3:
                if(tick)
                    state_next = zero;
                else
                    state_next = wait1_3;
            default: state_next = zero;
        endcase   
    end
    
    //Moore output
    assign db = (   (state_reg == one) ||
                    (state_reg == wait0_1) ||
                    (state_reg == wait0_2) ||
                    (state_reg == wait0_3));
endmodule
