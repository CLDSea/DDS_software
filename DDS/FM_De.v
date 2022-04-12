module FM_De
       (
           input clk_100M,
           input rst_n,
			  input [2:0]mode,
			  
           input [15: 0]FM_sig,   //FM信号
           input [23: 0]fc,   //载波频率

           output [15: 0]FM_De_sig
       );

wire[15: 0]SIN;
wire[15: 0]COS;

SINCOS SINCOS_inst
       (
           .clk_100M(clk_100M) ,    	// input  clk_100M_sig
           .rst_n(rst_n) ,    	// input  rst_n_sig
           .fre(fc) ,    	// input [23:0] fre_sig
           .SIN_sig(SIN) ,    	// output [15:0] SIN_sig_sig
           .COS_sig(COS) 	// output [15:0] COS_sig_sig
       );

//无符号转为有符号
wire[15: 0]FM_sig_s = {~FM_sig[15], FM_sig[14: 0]};
wire[15: 0]SIN_s = {~SIN[15], SIN[14: 0]};
wire[15: 0]COS_s = {~COS[15], COS[14: 0]};

wire [31: 0]result;
wire [31: 0]result2;

MULT_s	MULT_s_inst
       (
           .dataa (FM_sig_s),
           .datab (SIN_s),
           .result (result)
       );
MULT_s	MULT_s_inst2
       (
           .dataa (FM_sig_s),
           .datab (COS_s),
           .result (result2)
       );

wire[15: 0]I;
wire[15: 0]Q;

filter filter_inst
       (
           .clk(clk_100M) ,  	// input  clk_sig
           .clk_enable(mode == 3'b100) ,  	// input  clk_enable_sig
           .reset(rst_n) ,  	// input  reset_sig
           .filter_in(result) ,  	// input [31:0] filter_in_sig
           .filter_out(I) 	// output [15:0] filter_out_sig
       );
filter filter_inst2
       (
           .clk(clk_100M) ,  	// input  clk_sig
           .clk_enable(mode == 3'b100) ,  	// input  clk_enable_sig
           .reset(rst_n) ,  	// input  reset_sig
           .filter_in(result2) ,  	// input [31:0] filter_in_sig
           .filter_out(Q) 	// output [15:0] filter_out_sig
       );

reg [15: 0]I_reg;
reg [15: 0]Q_reg;

always @(posedge clk_100M or negedge rst_n)
begin
    if (!rst_n)
    begin
        I_reg <= 0;
        Q_reg <= 0;
    end
    else
    begin
        I_reg <= I;
        Q_reg <= Q;
    end
end

wire [31: 0]result3;
wire [31: 0]result4;

MULT_s	MULT_s_inst3
       (
           .dataa (I_reg),
           .datab (Q),
           .result (result3)
       );
MULT_s	MULT_s_inst4
       (
           .dataa (I),
           .datab (Q_reg),
           .result (result4)
       );

wire [31: 0]FM_De_d = result3 - result4;

reg [31: 0]FM_De_sig_reg;
reg [6: 0]count;

always@(posedge clk_100M or negedge rst_n)
begin
    if (!rst_n)
    begin
        FM_De_sig_reg <= 0;
		  count <= 0;
    end
    else
    begin
	     count <= (count==100)?count:(count + 1);
        if(count==100)
		      begin
				    FM_De_sig_reg <= FM_De_sig_reg + FM_De_d;
			   end
    end
end

assign FM_De_sig = FM_De_sig_reg[31:16];

endmodule