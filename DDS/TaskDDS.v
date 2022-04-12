module TaskDDS
       (
           input wire clk,     //100MHz
           input wire rst_n,

           input wire[2: 0]mode,     // 0Sin / 1AM / 2FM / 3输出AM解调 / 4输出FM解调
           input wire[23: 0]fc,     // 频率 / 载波频率 / 载波频率
           input wire[23: 0]fs,     // 无 / 调制频率 / 调制频率
           input wire[3: 0]ma,     // 无 / 调制度 / 无
           input wire[15: 0]fd,     // 无 / 无 / 最大频偏
           output wire[15: 0]sig_out // 输出 / 输出 / 输出
       );

wire [15: 0]carrier;
wire [15: 0]modulated;

wire [15: 0]AM_sig;
wire [15: 0]FM_sig;
wire [15: 0]AM_De_sig;
wire [15: 0]FM_De_sig;

//MODE切换模块
MODE MODE_inst
     (
         .clk_100M(clk) ,   	// input  clk_100M_sig
         .rst_n(rst_n) ,   	// input  rst_n_sig
         .mode(mode) ,   	// input [2:0] mode_sig
         .sin_sig(carrier) ,   	// input [15:0] sin_sig_sig
         .AM_sig(AM_sig) ,   	// input [15:0] AM_sig_sig
         .FM_sig(FM_sig) ,   	// input [15:0] FM_sig_sig
         .AM_De_sig(AM_De_sig) ,   	// input [15:0] AM_De_sig_sig
         .FM_De_sig(FM_De_sig) ,       // input [15:0] FM_De_sig_sig
         .sig_out(sig_out) 	// output [15:0] sig_out_sig
     );

//SIN波输出模块
SINCOS SINCOS_inst1 //载波
       (
           .clk_100M(clk) ,   	// input  clk_100M_sig
           .rst_n(rst_n) ,   	// input  rst_n_sig
           .fre(fc) ,   	// input [23:0] fre_sig
           .SIN_sig(carrier) ,   	// output [15:0] SIN_sig_sig
           .COS_sig() 	// output [15:0] COS_sig_sig
       );
SINCOS SINCOS_inst2 //调制波
       (
           .clk_100M(clk) ,   	// input  clk_100M_sig
           .rst_n(rst_n) ,   	// input  rst_n_sig
           .fre(fs) ,   	// input [23:0] fre_sig
           .SIN_sig(modulated) ,   	// output [15:0] SIN_sig_sig
           .COS_sig() 	// output [15:0] COS_sig_sig
       );

//AM波输出模块
AM AM_inst
   (
       .carrier(carrier) ,     	// input [15:0] carrier_sig
       .modulated(modulated) ,     	// input [15:0] modulated_sig
       .ma(ma),
       .AM_sig(AM_sig)	// output [15:0] AM_sig_sig
   );

//FM波输出模块
FM FM_inst
   (
       .clk_100M(clk) ,   	// input  clk_100M_sig
       .rst_n(rst_n) ,   	// input  rst_n_sig
       .fc(fc) ,   	// input [23:0] fc_sig
       .modulated(modulated) ,   	// input [15:0] modulated_sig
       .fd(fd) ,   	// input [15:0] fd_sig
       .FM_sig(FM_sig) 	// output [15:0] FM_sig_sig
   );

//AM解调模块
AM_De AM_De_inst
      (
          .clk_100M(clk) ,   	// input  clk_100M_sig
          .rst_n(rst_n) ,   	// input  rst_n_sig
          .mode(mode) ,   // input [2:0] mode_sig
          .AM_sig(AM_sig) ,   	// input [15:0] AM_sig_sig
          .fc(fc) ,   	// input [23:0] fc_sig
          .AM_De_sig(AM_De_sig) 	// output [15:0] AM_De_sig_sig
      );

//FM解调模块
FM_De FM_De_inst
      (
          .clk_100M(clk) ,  	// input  clk_100M_sig
          .rst_n(rst_n) ,  	// input  rst_n_sig
          .mode(mode) ,   // input [2:0] mode_sig
          .FM_sig(FM_sig) ,  	// input [15:0] FM_sig_sig
          .fc(fc) ,  	// input [23:0] fc_sig
          .FM_De_sig(FM_De_sig) 	// output [15:0] FM_De_sig_sig
      );

endmodule