//子模块1：时钟分频模块，将50Hz时钟分频为1Hz时钟，便于下载到FPGA观察计数现象
//时钟分频：FPGA自带时钟为50Hz，将其分频为1Hz，即一个时间周期为1s
module mod1HzClock(clk, nrst, clk_out);
	input				clk;		//时钟脉冲输入信号,clk应为50Hz时钟脉冲
	input				nrst;		//清零端,用于将计数器清空
	output			clk_out;	//输出变量，应该为1Hz的时钟脉冲	
	
	reg				clk_out;
	reg	[25:0]	counter;	//26位十进制计数器
	
	always@(posedge clk or negedge nrst) begin
		//当nrst为0时，计数器与时钟输出清零
		if(!nrst) begin
		counter <= 0;
		clk_out <= 0;
		end
		//counter计数满25兆时，clk_out翻转一次，同时counter置为0
		else if(counter == 24999999) begin
			counter <= 0;
			clk_out <= ~clk_out;
		end
		//上述条件均不满足的情况counter计数加一
		else
			counter <= counter + 1;
	end
endmodule


//主模块，可装载移位寄存器模块（左位移）
module shiftLed(clk, nload, inData, outData);
	input				clk;
	input				nload;	//装载信号,高电平有效
	input		[7:0]	inData;
	
	output	[7:0]	outData;
	reg		[7:0]	outData;
	
	always@(posedge clk or negedge nload) begin
	//always@(posedge clk_out or negedge nload) begin
		if(!nload) begin
			outData = inData;
		end
		else begin
			//outData <= {outData[6:0], outData[7]};
			outData = {outData[6:0], outData[7]};
		end
	end
	
	//例化模块1，产生1Hz脉冲时钟clk_out
	mod1HzClock u_mod1HzClock(.clk(clk), .nrst(nload), .clk_out(clk_out));
endmodule
