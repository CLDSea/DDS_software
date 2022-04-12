module MODE
       (
           input clk_100M,
           input rst_n,
           input[2: 0]mode,
           input[15: 0]sin_sig,
           input[15: 0]AM_sig,
           input[15: 0]FM_sig,

           input[15: 0]AM_De_sig,
           input[15: 0]FM_De_sig,

           output reg[15: 0]sig_out
       );

always@(posedge clk_100M or negedge rst_n)
begin
    if (!rst_n)
    begin
        sig_out <= 0;
    end
    else
    begin
        case (mode)
            3'b000:
                sig_out <= sin_sig;
            3'b001:
                sig_out <= AM_sig;
            3'b010:
                sig_out <= FM_sig;
            3'b011:
                sig_out <= AM_De_sig;
			   3'b100:
			       sig_out <= FM_De_sig;
            default:
                sig_out <= 0;
        endcase
    end
end

endmodule