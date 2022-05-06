module Time(nRst, CLK, nSTART, nSTOP, t1, t2, t3);
	//端口声明部分
	input		nSTART, nSTOP;
	input		CLK;
	input		nRst;
	output	t1, t2, t3;
	reg		t1, t2, t3;
	
	always@(posedge CLK or negedge nRst) begin
		if(!nRst) begin
			t1 <= 0;
			t2 <= 0;
			t3 <= 0;
		end
		else if(!nSTART && nSTOP && !t1 && !t2 && !t3) begin
			t1 <= 1;
			t2 <= 0;
			t3 <= 0;
			/*if(nSTOP and !t1 and !t2 and !t3) begin
				t1 <= 1;
				t2 <= 0;
				t3 <= 0;
			end
			else if(!nSTOP and t3) begin
				t1 <= 0;
				t2 <= 0;
				t3 <= 0;
			end*/
		end
		else if(!nSTART && !nSTOP && t3) begin
			t1 <= 0;
			t2 <= 0;
			t3 <= 0;
		end
		else begin
			//t1,t2,t3输出环形脉冲
			{t3, t2, t1} <= {t2, t1, t3};
		end
	end
	
	//模块例化:时钟分频模块
	mod1Hzclock u_mod1Hzclock(.clk(CLK), .nrst(nRst), .clk_out(clk_out));
endmodule
