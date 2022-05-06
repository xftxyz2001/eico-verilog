module TestRam(bclk, in244, ABus, DBus, bnRD, bnWR);
	//端口声明
	input 			bclk;
	input		[7:0]	ABus;
	inout		[7:0]	DBus;
	//output	[7:0]	DBus;
	
	input		bnRD;
	input		bnWR;
	input		[7:0]	in244;
	
	reg		[7:0]	DBus;
	wire		[7:0]	q;
	
	always@(*) begin
		DBus <= 8'bzzzzzzzz;
		/*
		if(!bnRD && bnWR) begin
			DBus <= q;
		end
		if(!bnWR && bnRD) begin
			DBus <= in244;
		end
		*/
		if(!bnRD) begin
			DBus <= q;
		end
		else if(!bnWR) begin
			DBus <= in244;
		end
		
	end
	
	//Ram模块例化
	//RAM u_RAM(.clock(bclk), .data(DBus), .address(ABus), .rden(~bnRD), .wren(~bnWR), .q(q));
	RAM u_RAM(.address(ABus), .clock(bclk), .data(DBus), .rden(~bnRD), .wren(~bnWR), .q(q));
endmodule
