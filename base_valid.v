`timescale 1 ns/10 ps
module handshake_valid(
		input clk,
		input rst_n,
		
		//source
		input		s_ready_i,  //module downstream is ready to accept data
		output	s_valid_o,  //module has valid data at its output
		output	s_data_o,
		
		//des
		input		d_valid_i,  //module upstream has valid data to transfer
		input		d_data_i,
		output	d_ready_o //module ready to accept data
		
);
reg          valid_d1;
reg  s_valid_o_r;
reg  s_data_o_r;

always @(posedge clk or negedge rst_n)begin
		if(~rst_n) //复位时，归零
			s_valid_o_r <= 1'b0;
		else if(valid_d1)  //此时des有有效数据，不需要再传数据
			s_valid_o_r <= 1'b0;
		else if(s_ready_i)  //一旦ready，但des没有valid，
			s_valid_o_r <= 1'b0;
end		

always @(posedge clk or negedge rst_n) begin
		if(~rst_n)
			s_data_o_r <= 1'b0;
		else if(valid_d1 && d_ready_o)  //当des的valid ready有效，像source发送数据
			s_data_o_r <= d_data_i;
			
end

always @(posedge clk or negedge rst_n) begin
		if (rst_n == 1'd0)
        valid_d1 <= 1'd0;
    else
        valid_d1 <= d_valid_i;
end

assign s_valid_o = s_valid_o_r;
assign s_data_o = s_data_o_r;
assign d_ready_o = (s_valid_o) | s_ready_i;
endmodule


//test
`timescale 1ns/1ps

module handshake_valid_tb;

		reg 				clk;
		reg 				rst_n;
				
		reg					s_ready_i;  
		wire				s_valid_o;  
		wire				s_data_o;
				
		
		reg					d_valid_i;  
		reg					d_data_i;
		wire				d_ready_o; 


initial begin
				 clk <= 1'b0;
				 rst_n <= 1'b1;
				 s_ready_i <= 0;d_valid_i <= 0;d_data_i <= 0;rst_n <= 1'b1;
		#10  s_ready_i <= 1;d_valid_i <= 0;d_data_i <= 1;rst_n <= 1'b0;
		#10  s_ready_i <= 0;d_valid_i <= 1;d_data_i <= 1;rst_n <= 1'b1;
		#10  s_ready_i <= 1;d_valid_i <= 0;d_data_i <= 0;rst_n <= 1'b1;
		#10  s_ready_i <= 1;d_valid_i <= 0;d_data_i <= 1;rst_n <= 1'b1;
		#10  s_ready_i <= 0;d_valid_i <= 1;d_data_i <= 0;rst_n <= 1'b0;
		#10  s_ready_i <= 1;d_valid_i <= 0;d_data_i <= 1;rst_n <= 1'b1;
		#10  s_ready_i <= 0;d_valid_i <= 1;d_data_i <= 0;rst_n <= 1'b0;
		#10  $stop;

end

always@(*) 
begin
		#10  clk <= ~clk;
end


endmodule

