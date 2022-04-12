module SINCOS
       (
           input clk_100M,
           input rst_n,
			  
           input [23:0]fre,//1~16_777_215Hz

           output[15:0]SIN_sig,
           output[15:0]COS_sig
       );

wire [47:0]temp = fre * 24'd11258999;
wire [31:0]K_12_20 = temp[47:18];

reg [31:0]phase;

always@(posedge clk_100M or negedge rst_n)
begin
    if(!rst_n)
        phase <= 0;
    else
        phase <= phase + K_12_20;
end

ROM_sin	ROM_sin_inst//SIN
        (
            .address ( phase[31:20] ),
            .clock ( clk_100M),
            .q ( SIN_sig )
        );

ROM_sin	ROM_sin_inst2//COS
        (
            .address ( phase[31:20]+12'd1024),
            .clock ( clk_100M),
            .q ( COS_sig )
        );

endmodule