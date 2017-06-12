# Washer Machine

使用Verilog语言在Nexys 4 DDR开发板上，模拟一个洗衣机程序

## MVC

借鉴MVC的设计思路，模块化程序功能

<center>

<img src="http://oklhb00qa.bkt.clouddn.com/washer/detail.png" width="85%" align=center />

</center>

## 顶层模块

可见最左边为输入处理模块，中间四个核心模块分别为ViewController、STController、Model、RunController，最后的计算结果统一从View模块输出

<center>

<img src="http://oklhb00qa.bkt.clouddn.com/washer/sync.PNG" align=center />

</center>

## 实现效果

除基础洗衣要求，改善部分功能

* 新增reset键防误触功能
* 优化洗衣机开机自检并显示"HELLO"欢迎界面
* 新增波轮洗衣机开盖功能
* 新增"Error"模式
* 改善彩色LED灯显示

（后续有时间继续更新......）

<center>

<img src="http://oklhb00qa.bkt.clouddn.com/washer/IMG_1386-min.PNG" width="85%" align=center />

</center>

<center>

<img src="http://oklhb00qa.bkt.clouddn.com/washer/IMG_1390-min.PNG" width="85%" align=center />

</center>

<center>

<img src="http://oklhb00qa.bkt.clouddn.com/washer/IMG_1392-min.PNG" width="85%" align=center />

</center>