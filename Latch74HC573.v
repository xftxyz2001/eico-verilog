module Latch74HC573 (
    LE,nOE,D,Q573
);
    input   LE,     nOE;        //LE        控制数据是否读入
                                //nOE       （低电平有效）控制数据是否输出
    input   [7:0]   D;          //D         输入端口
    output  [7:0]   Q573;       //Q573      输出端口
    reg     [7:0]   Q573;
    reg     [7:0]   q_latch;    //q_latch   锁存器
    always @(*) begin           //当端口信号发生变化时
        if (LE)     q_latch <=  D;          //如果LE为高电平时将数据读入
        if (nOE)    Q573    <=  8'bz;       //如果nOE为高电平时输出为高阻
        else        Q573    <=  q_latch;    //如果nOE为低电平时输出为锁存器q_latch中的值
    end
endmodule
