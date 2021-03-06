// -------------------------------------------------------------
//
// Module: filter
// Generated by MATLAB(R) 9.11 and Filter Design HDL Coder 3.1.10.
// Generated on: 2022-04-08 18:28:07
// -------------------------------------------------------------

// -------------------------------------------------------------
// HDL Code Generation Options:
//
// ResetAssertedLevel: Active-low
// TargetLanguage: Verilog
// TestBenchStimulus: impulse step ramp chirp noise 
// GenerateHDLTestBench: off

// -------------------------------------------------------------
// HDL Implementation    : Fully parallel
// Folding Factor        : 1
// -------------------------------------------------------------




`timescale 1 ns / 1 ns

module filter
               (
                clk,
                clk_enable,
                reset,
                filter_in,
                filter_out
                );

  input   clk; 
  input   clk_enable; 
  input   reset; 
  input   signed [31:0] filter_in; //sfix32_En31
  output  signed [15:0] filter_out; //sfix16_En15

////////////////////////////////////////////////////////////////
//Module Architecture: filter
////////////////////////////////////////////////////////////////
  // Local Functions
  // Type Definitions
  // Constants
  parameter signed [15:0] coeff1 = 16'b0000011011000100; //sfix16_En18
  parameter signed [15:0] coeff2 = 16'b0001011011100000; //sfix16_En18
  parameter signed [15:0] coeff3 = 16'b0011000010101000; //sfix16_En18
  parameter signed [15:0] coeff4 = 16'b0100110010011011; //sfix16_En18
  parameter signed [15:0] coeff5 = 16'b0101111100000101; //sfix16_En18
  parameter signed [15:0] coeff6 = 16'b0101111100000101; //sfix16_En18
  parameter signed [15:0] coeff7 = 16'b0100110010011011; //sfix16_En18
  parameter signed [15:0] coeff8 = 16'b0011000010101000; //sfix16_En18
  parameter signed [15:0] coeff9 = 16'b0001011011100000; //sfix16_En18
  parameter signed [15:0] coeff10 = 16'b0000011011000100; //sfix16_En18

  // Signals
  reg  signed [31:0] delay_pipeline [0:9] ; // sfix32_En31
  wire signed [30:0] product10; // sfix31_En33
  wire signed [47:0] mul_temp; // sfix48_En49
  wire signed [30:0] product9; // sfix31_En33
  wire signed [47:0] mul_temp_1; // sfix48_En49
  wire signed [30:0] product8; // sfix31_En33
  wire signed [47:0] mul_temp_2; // sfix48_En49
  wire signed [30:0] product7; // sfix31_En33
  wire signed [47:0] mul_temp_3; // sfix48_En49
  wire signed [30:0] product6; // sfix31_En33
  wire signed [47:0] mul_temp_4; // sfix48_En49
  wire signed [30:0] product5; // sfix31_En33
  wire signed [47:0] mul_temp_5; // sfix48_En49
  wire signed [30:0] product4; // sfix31_En33
  wire signed [47:0] mul_temp_6; // sfix48_En49
  wire signed [30:0] product3; // sfix31_En33
  wire signed [47:0] mul_temp_7; // sfix48_En49
  wire signed [30:0] product2; // sfix31_En33
  wire signed [47:0] mul_temp_8; // sfix48_En49
  wire signed [33:0] product1_cast; // sfix34_En33
  wire signed [30:0] product1; // sfix31_En33
  wire signed [47:0] mul_temp_9; // sfix48_En49
  wire signed [33:0] sum1; // sfix34_En33
  wire signed [33:0] add_signext; // sfix34_En33
  wire signed [33:0] add_signext_1; // sfix34_En33
  wire signed [34:0] add_temp; // sfix35_En33
  wire signed [33:0] sum2; // sfix34_En33
  wire signed [33:0] add_signext_2; // sfix34_En33
  wire signed [33:0] add_signext_3; // sfix34_En33
  wire signed [34:0] add_temp_1; // sfix35_En33
  wire signed [33:0] sum3; // sfix34_En33
  wire signed [33:0] add_signext_4; // sfix34_En33
  wire signed [33:0] add_signext_5; // sfix34_En33
  wire signed [34:0] add_temp_2; // sfix35_En33
  wire signed [33:0] sum4; // sfix34_En33
  wire signed [33:0] add_signext_6; // sfix34_En33
  wire signed [33:0] add_signext_7; // sfix34_En33
  wire signed [34:0] add_temp_3; // sfix35_En33
  wire signed [33:0] sum5; // sfix34_En33
  wire signed [33:0] add_signext_8; // sfix34_En33
  wire signed [33:0] add_signext_9; // sfix34_En33
  wire signed [34:0] add_temp_4; // sfix35_En33
  wire signed [33:0] sum6; // sfix34_En33
  wire signed [33:0] add_signext_10; // sfix34_En33
  wire signed [33:0] add_signext_11; // sfix34_En33
  wire signed [34:0] add_temp_5; // sfix35_En33
  wire signed [33:0] sum7; // sfix34_En33
  wire signed [33:0] add_signext_12; // sfix34_En33
  wire signed [33:0] add_signext_13; // sfix34_En33
  wire signed [34:0] add_temp_6; // sfix35_En33
  wire signed [33:0] sum8; // sfix34_En33
  wire signed [33:0] add_signext_14; // sfix34_En33
  wire signed [33:0] add_signext_15; // sfix34_En33
  wire signed [34:0] add_temp_7; // sfix35_En33
  wire signed [33:0] sum9; // sfix34_En33
  wire signed [33:0] add_signext_16; // sfix34_En33
  wire signed [33:0] add_signext_17; // sfix34_En33
  wire signed [34:0] add_temp_8; // sfix35_En33
  wire signed [15:0] output_typeconvert; // sfix16_En15
  reg  signed [15:0] output_register; // sfix16_En15

  // Block Statements
  always @( posedge clk or negedge reset)
    begin: Delay_Pipeline_process
      if (reset == 1'b0) begin
        delay_pipeline[0] <= 0;
        delay_pipeline[1] <= 0;
        delay_pipeline[2] <= 0;
        delay_pipeline[3] <= 0;
        delay_pipeline[4] <= 0;
        delay_pipeline[5] <= 0;
        delay_pipeline[6] <= 0;
        delay_pipeline[7] <= 0;
        delay_pipeline[8] <= 0;
        delay_pipeline[9] <= 0;
      end
      else begin
        if (clk_enable == 1'b1) begin
          delay_pipeline[0] <= filter_in;
          delay_pipeline[1] <= delay_pipeline[0];
          delay_pipeline[2] <= delay_pipeline[1];
          delay_pipeline[3] <= delay_pipeline[2];
          delay_pipeline[4] <= delay_pipeline[3];
          delay_pipeline[5] <= delay_pipeline[4];
          delay_pipeline[6] <= delay_pipeline[5];
          delay_pipeline[7] <= delay_pipeline[6];
          delay_pipeline[8] <= delay_pipeline[7];
          delay_pipeline[9] <= delay_pipeline[8];
        end
      end
    end // Delay_Pipeline_process


  assign mul_temp = delay_pipeline[9] * coeff10;
  assign product10 = (mul_temp[46:0] + {mul_temp[16], {15{~mul_temp[16]}}})>>>16;

  assign mul_temp_1 = delay_pipeline[8] * coeff9;
  assign product9 = (mul_temp_1[46:0] + {mul_temp_1[16], {15{~mul_temp_1[16]}}})>>>16;

  assign mul_temp_2 = delay_pipeline[7] * coeff8;
  assign product8 = (mul_temp_2[46:0] + {mul_temp_2[16], {15{~mul_temp_2[16]}}})>>>16;

  assign mul_temp_3 = delay_pipeline[6] * coeff7;
  assign product7 = (mul_temp_3[46:0] + {mul_temp_3[16], {15{~mul_temp_3[16]}}})>>>16;

  assign mul_temp_4 = delay_pipeline[5] * coeff6;
  assign product6 = (mul_temp_4[46:0] + {mul_temp_4[16], {15{~mul_temp_4[16]}}})>>>16;

  assign mul_temp_5 = delay_pipeline[4] * coeff5;
  assign product5 = (mul_temp_5[46:0] + {mul_temp_5[16], {15{~mul_temp_5[16]}}})>>>16;

  assign mul_temp_6 = delay_pipeline[3] * coeff4;
  assign product4 = (mul_temp_6[46:0] + {mul_temp_6[16], {15{~mul_temp_6[16]}}})>>>16;

  assign mul_temp_7 = delay_pipeline[2] * coeff3;
  assign product3 = (mul_temp_7[46:0] + {mul_temp_7[16], {15{~mul_temp_7[16]}}})>>>16;

  assign mul_temp_8 = delay_pipeline[1] * coeff2;
  assign product2 = (mul_temp_8[46:0] + {mul_temp_8[16], {15{~mul_temp_8[16]}}})>>>16;

  assign product1_cast = $signed({{3{product1[30]}}, product1});

  assign mul_temp_9 = delay_pipeline[0] * coeff1;
  assign product1 = (mul_temp_9[46:0] + {mul_temp_9[16], {15{~mul_temp_9[16]}}})>>>16;

  assign add_signext = product1_cast;
  assign add_signext_1 = $signed({{3{product2[30]}}, product2});
  assign add_temp = add_signext + add_signext_1;
  assign sum1 = add_temp[33:0];

  assign add_signext_2 = sum1;
  assign add_signext_3 = $signed({{3{product3[30]}}, product3});
  assign add_temp_1 = add_signext_2 + add_signext_3;
  assign sum2 = add_temp_1[33:0];

  assign add_signext_4 = sum2;
  assign add_signext_5 = $signed({{3{product4[30]}}, product4});
  assign add_temp_2 = add_signext_4 + add_signext_5;
  assign sum3 = add_temp_2[33:0];

  assign add_signext_6 = sum3;
  assign add_signext_7 = $signed({{3{product5[30]}}, product5});
  assign add_temp_3 = add_signext_6 + add_signext_7;
  assign sum4 = add_temp_3[33:0];

  assign add_signext_8 = sum4;
  assign add_signext_9 = $signed({{3{product6[30]}}, product6});
  assign add_temp_4 = add_signext_8 + add_signext_9;
  assign sum5 = add_temp_4[33:0];

  assign add_signext_10 = sum5;
  assign add_signext_11 = $signed({{3{product7[30]}}, product7});
  assign add_temp_5 = add_signext_10 + add_signext_11;
  assign sum6 = add_temp_5[33:0];

  assign add_signext_12 = sum6;
  assign add_signext_13 = $signed({{3{product8[30]}}, product8});
  assign add_temp_6 = add_signext_12 + add_signext_13;
  assign sum7 = add_temp_6[33:0];

  assign add_signext_14 = sum7;
  assign add_signext_15 = $signed({{3{product9[30]}}, product9});
  assign add_temp_7 = add_signext_14 + add_signext_15;
  assign sum8 = add_temp_7[33:0];

  assign add_signext_16 = sum8;
  assign add_signext_17 = $signed({{3{product10[30]}}, product10});
  assign add_temp_8 = add_signext_16 + add_signext_17;
  assign sum9 = add_temp_8[33:0];

  assign output_typeconvert = (sum9[33:0] + {sum9[18], {17{~sum9[18]}}})>>>18;

  always @ (posedge clk or negedge reset)
    begin: Output_Register_process
      if (reset == 1'b0) begin
        output_register <= 0;
      end
      else begin
        if (clk_enable == 1'b1) begin
          output_register <= output_typeconvert;
        end
      end
    end // Output_Register_process

  // Assignment Statements
  assign filter_out = output_register;
endmodule  // filter
