module FM
       (
           input clk_100M,
           input rst_n,
			  
           input [23: 0]fc,   //载波频率
           input [15: 0]modulated,   //调制波
           input [15: 0]fd,   //最大频偏

           output[15: 0]FM_sig
       );

//无符号转为有符号
wire[15: 0]modulated_s = {!modulated[15], modulated[14: 0]};

wire[31: 0]result;

MULT_s	MULT_s_inst
       (
           .dataa ( fd ),
           .datab ( modulated_s ),
           .result ( result )
       );

wire[24: 0]temp = {{8{result[31]}}, result[31: 15]}; //除以32767,化为有符号数

wire [24: 0]freFM_s = {1'b0, fc} + temp; //频率(有符号)

wire[23: 0]freFM = freFM_s[23: 0];

SINCOS SINCOS_inst //FM波
       (
           .clk_100M(clk_100M) , 	// input  clk_100M_sig
           .rst_n(rst_n) , 	// input  rst_n_sig
           .fre(freFM) , 	// input [23:0] fre_sig
           .SIN_sig(FM_sig) , 	// output [15:0] SIN_sig_sig
           .COS_sig() 	// output [15:0] COS_sig_sig
       );

endmodule