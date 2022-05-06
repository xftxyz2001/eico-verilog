//8选1选择器模块
module mux8_1(in0,in1,in2,in3,in4,in5,in6,in7,sel,out);
	input in0,in1,in2,in3,in4,in5,in6,in7;	//备选信号8个
	input [2:0] sel;								//选择输入
	output 	out;									//输出
	reg 		out;
	always@(*)
		case(sel)
			3'b000:out = in0;
			3'b001:out = in1;
			3'b010:out = in2;
			3'b011:out = in3;
			3'b100:out = in4;
			3'b101:out = in5;
			3'b110:out = in6;
			3'b111:out = in7;
			default:out = 1'bx;
		endcase
endmodule

//主模块
module ComLogic(a,b,c,d,e,f,g,h,		//备选信号8个
						select,muxout,		//选择输入，输出
						logic1,logic2,
						andLogic,orLogic,notLogic,nandLogic,norLogic,xnorLogic,xorLogic);
	input 	a,b,c,d,e,f,g,h,logic1,logic2;
	input 	[2:0] select;
	output 	andLogic,orLogic,notLogic,nandLogic,norLogic,xnorLogic,xorLogic;
	output 	muxout;
	//逻辑门电路部分，门原语
	and 		ANDL(andLogic,logic1,logic2);
	or 		ORL(orLogic,logic1,logic2);
	not 		NOTL(notLogic,logic1);
	nand 		NANDL(nandLogic,logic1,logic2);
	nor 		NORL(norLogic,logic1,logic2);
	xnor 		XNORL(xnorLogic,logic1,logic2);
	xor 		XORL(xorLogic,logic1,logic2);
	//8选1选择器模块例化
	mux8_1 u_mux81(.in0(a),.in1(b),.in2(c),.in3(d),.in4(e),.in5(f),.in6(g),.in7(h),.sel(select),.out(muxout));
endmodule
