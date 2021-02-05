[Event Handling Starting Point](https://developer.apple.com/library/archive/referencelibrary/GettingStarted/EventHandlingStartingPoint/index.html#//apple_ref/doc/uid/TP40010755)

事件是一种发送给应用程序来通知它用户的行为的对象。只要用户与用户界面交互，或者与加速计进行交互或者使用了耳机或者其他的附加设备都会产生事件。当设备的位置改变时也会产生事件。  

![](https://developer.apple.com/library/archive/referencelibrary/GettingStarted/EventHandlingStartingPoint/Art/event-handling-sp.jpg)

# 快速建立和运行

阅读《iOS应用程序编程指南》中的“事件处理系统”部分来了解事件处理的概览，阅读《iOS事件处理指南》来了解指定任务。《iOS事件处理指南》描述了如何处理用户事件，包括多点触摸，移动事件——从设备的加速器获得——以及控制多媒体事件。最低限度，每个应用程序都应该响应方向改变。  

# 成为专家

从《UIKit框架参考》开始了解UIKit框架中的事件处理类。框架包含了处理数据的类，比如加速计，设备，屏幕，事件，响应者和触摸数据。  

# 访问加速计事件

加速计评估了一个给定线性路径上的速度改变。iOS设备包含三个加速计，每个加速计都沿着设备的每个主轴。阅读《iOS事件处理指南》中的“运动事件”来了解，并参考《核心运动框架参考》来了解加速计和陀螺仪类的详情。  
参考BubbleLevel示例代码工程，它使用了加速计数据来创建一个可见的气泡层级和斜度计。该项目提供了一个如何检测设备方向的例子。

# 判断设备的位置

iOS设备包含了能够判断设备当前位置的硬件，从可见的信号信息转化为三角位置。要了解如何判断当前设备的经纬度，从阅读《定位和地图编程指南》开始，并参考《核心定位框架参考》来了解定位类的详情。  
