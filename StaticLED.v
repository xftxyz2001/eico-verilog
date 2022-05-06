//子模块：16进制译码
module encoder(inData, segData);
	input		[3:0]	inData;
	output	[7:0]	segData;
	reg		[7:0]	segData;
	
	always@(inData) begin
		//一位十六进制数转换为数码管的段码（使用case语句）
		case(inData)
									//  .gfedcba
			4'b0000: segData = 8'b00111111; //0
			4'b0001: segData = 8'b00000110; //1
			4'b0010: segData = 8'b01011011; //2
			4'b0011: segData = 8'b01001111; //3
									//  .gfedcba
			4'b0100: segData = 8'b01100110; //4
			4'b0101: segData = 8'b01101101; //5
			4'b0110: segData = 8'b01111101; //6
			4'b0111: segData = 8'b00000111; //7
									//  .gfedcba
			4'b1000: segData = 8'b01111111; //8
			4'b1001: segData = 8'b01101111; //9
			4'b1010: segData = 8'b01110111; //a
			4'b1011: segData = 8'b01111100; //b
									//  .gfedcba
			4'b1100: segData = 8'b00111001; //c
			4'b1101: segData = 8'b01011110; //d
			4'b1110: segData = 8'b01111001; //e
			4'b1111: segData = 8'b01110001; //f
									//  .gfedcba
			default: segData = 8'b10000000; //.
		endcase
	end
endmodule


//子模块：时钟分频
module mod1Hzclock(clk, nrst, clk_out);
	input		clk, nrst;
	output	clk_out;
	reg		clk_out;
	reg	[25:0]	counter;
	
	always@(posedge clk or negedge nrst) begin
		if(!nrst) begin
			counter <= 0;
			clk_out <= 0;
		end
		else if(counter == 24999999) begin
			counter <= 0;
			clk_out <= ~clk_out;
		end
		else
			counter <= counter + 1;
	end
endmodule


//主模块：静态数码管显示
module StaticLED(clk, nRst, segOut, digOut);
	input					clk, nRst; //时钟信号 复位信号
	output	[7:0]		segOut;  //数值输出
	output	[7:0]		digOut;  //片选输出

	wire		[7:0]		segOut;
	wire		[7:0]		digOut;
	wire					clk_out;
	
	reg		[3:0]		counter;  //计数器
	
	//0号数码管显示
	assign	digOut = 8'b11111110;
	
	//计数器设计
	//always@(posedge clk_out or negedge nRst) begin
	always@(posedge clk or negedge nRst) begin
		if(!nRst)
			counter = 0;
		else
			counter = (counter + 1) % 16;
			//counter = counter + 1;
	end

	//模块例化
	encoder u_encoder(.inData(counter), .segData(segOut));
	mod1Hzclock u_mod1Hzclock(.clk(clk), .nrst(nRst), .clk_out(clk_out));
endmodule
