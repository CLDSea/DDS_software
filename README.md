# DDS_software  
**Quartus ii实现DDS(信号发生器)(软件)**  
调制波频率、载波频率、AM调制度、FM最大频偏由Quartus ii输入  
Sin信号、AM信号、FM信号、AM解调信号、FM解调信号由Quartus ii输出，用modelsim显示波形  
所示阶梯波经过低通滤波器滤除100M时钟信号分量即可得到平滑的波形  
## 模块设计  
- 顶层模块TaskDDS:  
MODE_inst  
SINCOS_inst1、2(产生载波carrier、调制波modulated)  
AM_inst  
FM_inst  
AM_De_inst  
FM_De_inst
- MODE切换模块MODE:  
5选1多位信号选择器  
- SIN波输出模块SINCOS  
相位累加器  
正弦查找表  
ROM ip核  
- AM波输出模块AM  
无符号转为有符号  
乘法器  
除法器  
有符号加法  
- FM波输出模块FM  
无符号转为有符号  
乘法器  
有符号加法  
SINCOS_inst(产生FM波)  
- AM解调模块AM_De(IQ解调)  
SINCOS_inst(产生同频的Sin、Cos波)  
无符号转为有符号  
乘法器  
fiter_inst(Matlab filterDesigner生成Verilog文件)  
得到I信号和Q信号  
解调信号为I^2+Q^2  
- FM解调模块FM_De(IQ解调)  
SINCOS_inst(产生同频的Sin、Cos波)  
无符号转为有符号  
乘法器  
fiter_inst(Matlab filterDesigner生成Verilog文件)  
得到I信号和Q信号  
解调信号为arctan(Q/I)，为了避免使用arctan运算，使用微分积分的算法
最终解调信号为Σ(I(n-1) * Q(n) - I(n) * Q(n-1))  
# 注:  
*只需进行Analysis&Synthesis，使用Compile Design会提示超资源  
*在TaskDDS.vt中取消注释响应部分即可使用Quartus ii与modelsim联合仿真进行测试  
*使用的filter阶数较小，因此AM解调和FM解调不能适用所有情况  
*若要改善效果，可以自行替换filter.v文件，但使用高阶的滤波器，会使modelsim仿真十分缓慢，谨慎选择！
