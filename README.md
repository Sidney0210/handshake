# handshake

verilog仿真小测试！原题描述如下：
总线握手场景描述：
a) 总线master发出data信号，同时master用valid信号拉高表示data有效；
b) 总线slave发出ready信号，ready信号拉高表示slave可以接收数据；
c) 当valid和slave同时为高时，表示data信号从master到slave发送接收成功。

总线详细描述见附件文档。
项目要求：
1) 实现上述总线同步握手场景，不考虑异步场景；
2) 假定master的valid信号不满足时序要求，要对valid信号用寄存器打一拍，实现该总线握手场景；
3) 假定slave的ready信号不满足时序要求，要对ready信号用寄存器打一拍，实现该总线握手场景；
4) 假定valid和ready信号都不满足时序要求，都需要用寄存器打一拍，实现该总线握手场景；
5) 仿真要求体现总线高性能传输无气泡、逐级反压、传输不丢数据。


每一个文件分别对应baseline，以及要求2，3，4以及对应的tb，具体对应可看文件名。
