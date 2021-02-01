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
使用各种宏定义来判断一个条件——这些宏定义会用做 NSAssertionHandler 的前端。这些宏定义分为两类：在OC方法中使用的和在C函数中使用的。举例来说，NSAssert就是用在方法中，NSCAssert就是用在函数中的。每个宏定义都有两个参数：条件——一个表达式用来判断真假——以及一个字符串描述错误信息。如果printf需要一个或多个参数那么其他宏定义也可用。例如如果需要一个参数，则在方法中使用NSAssert1，如下：  

	NSAssert1((0 <= component) && (component <= 255),
        @"Value %i out of range!", component);

更多关于这些宏定义的细节参见“NSAssert”。  
只有在使用上述宏定义时才能创建断言——很少会需要直接调用NSAssertionHandler方法。宏定义为那些在方法和函数中的使用分别发送  handleFailureInMethod:object:file:lineNumber:description: 和 handleFailureInFunction:file:lineNumber:description: 消息给当前的断言句柄。当前线程的断言处理使用NSAssertionHandler currentHandler 类方法。
当预编译宏 NS_BLOCK_ASSERTIONS 定义了时，断言不会被编译到代码中。

# 日志消息

你可以使用NSLog和NSLogv函数来打印错误和信息相关的消息。这些消息都被写入stderr。  
消息由时间戳和进程ID组成，该进程ID已添加到你传入的字符串中。使用格式化字符串和要插入到字符串中的一个或多个参数组成此字符串。这些函数允许的格式规范是由NSString的格式设置功能解析的格式规范（这不一定是printf所解析的格式转义和标志集合）。举例来说，以下代码片段，输出一个从NSString和int参数构造的字符串。

	int recNum;
	NSString *recName;
	/* ... */
	NSLog( @"Record %d is %@", recNum, recName );

参见“格式化字符串对象”了解不同的格式化指定符号的详情。  
通常来讲，你应该使用NSLog函数替代NSLogv调用。如果你直接调用了NSLogv，你必须准备好所需的变量参数列表来被标准C的宏定义va_start所调用。在完成时，你必须直接为该列表调用标准C的宏定义va_end。

# 使用自定义断言句柄

在某些情况下，你可能要定义你自己的断言具柄来打印错误信息到不同的错误控制台或者抛出自定义异常，用来替代常见的NSInternalInconsistencyException。要实现这些功能，你必须定义一个NSAssertionHandler的子类并重写其handleFailureInMethod:object:file:lineNumber:description:和handleFailureInFunction:file:lineNumber:description:方法来分别处理方法和函数中的断言。  
若要将你的断言句柄添加到一个线程中，你必须将断言句柄Tina较大线程的属性字典中。使用当前线程的threadDictionary方法来接收字典。添加你的断言句柄对象到字典要使用NSAssertionHandler作为key。这项技术可以用在给任意线程指定一个自定义的断言句柄，包括主线程。你必须要在你想要修改的线程中执行这些步骤；一个线程不能修改另一个线程的属性字典。  
通常来讲，你应该在线程创建后就立刻添加你自己的断言句柄到线程字典中。不过，一个默认的断言句柄不会被创建直到遇到一个断言宏定义，并且你始终应该替换已经存在的在线程字典中的断言句柄。如果断言处理程序已存在于线程字典中，则使用该处理程序代替默认断言处理程序。