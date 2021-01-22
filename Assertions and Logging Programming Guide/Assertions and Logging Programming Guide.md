[Assertions and Logging Programming Guide](https://developer.apple.com/library/archive/documentation/Cocoa/Conceptual/Assertions/Assertions.html#//apple_ref/doc/uid/10000014i)

# 断言和日志

断言是一种当代码中给定条件为false时打印错误信息并生成异常的机制。日志会打印错误火信息的消息，通常打印到标准错误设备。

## 本文档的组织结构

本编程话题覆盖了异常处理，因为它与给定条件的评估和消息日志记录有关。有关更复杂的异常处理，  即涉及引发（或引发）和处理异常对象的技术，请参阅异常编程话题。  

本文覆盖的编程话题是：  

*  如何让断言生效
* 使用断言宏定义
* 日志消息
* 使用自定义断言句柄

# 如何让断言生效

在你的代码当中你可以使用断言宏定义来生成一个断言。这些宏定义会判断一个条件并且如果条件判断为false，它会传递一个字符串（以及核能会添加printf-格式的参数格式化字符串）用于描述错误信息给它的NSAssertionHandler。每个线程有其自己的NSAssertionHandler对象创建。当调用一个断言时，NSAssertionHandler会打印错误信息，这包含方法和类（或者函数）然后会抛出NSInternalInconsistencyException异常。  

# 使用断言宏定义

本文档描述了如何使用Assert（以及相关）宏定义来判断一个条件并创建一个断言。  


# 日志消息

# 使用自定义断言句柄