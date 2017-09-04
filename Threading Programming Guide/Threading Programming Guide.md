[Threading Programming Guide 原文链接](https://developer.apple.com/library/content/documentation/Cocoa/Conceptual/Multithreading/Introduction/Introduction.html#//apple_ref/doc/uid/10000057i)

# 介绍
线程是能够在一款应用中并发的执行不同代码的技术之一。尽管更新的技术，比如操作对象和GCD提供了更为现代和有效的结构来实现并发，OS X和iOS也同样提供了接口来创建和管理线程。  
本文档提供了在OS X中可用的线程封装的相关介绍，并为你展示了如何使用它们。同样，本文档还介绍了相关的技术来支持线程操作以及如何在你的应用中进行多线程同步。  

	重要：如果你在开发一款全新的应用，我们推荐你调研一下OS X上的实现并发的替代技术。如果您还不熟悉实现线程化应用程序所需的设计技术, 则尤其如此。这些替代的技术大大简化了你在实现并发执行的时候所要编写的代码量，并且提供了比传统的线程更为优秀的性能。更多关于这些技术的相关信息，参见“并发编程指南”。

## 本文档的组织结构

## 另请参阅

# 关于线程编程

## 什么是线程？

## 线程相关术语

## 线程的替代选择

## 线程的支持

### 线程打包

### 运行循环

### 同步工具

### 线程之间的通信

## 设计指南

### 避免显式的创建线程

### 保持你的线程合理的负荷

### 避免共享数据结构

### 线程和你的用户界面

### 在退出的时候要意识到线程的行为

### 异常处理

### 干净利落的中止你的线程

### 库函数的线程安全

# 线程管理

## 线程的消耗

## 创建一个线程

### 使用NSThread

### 使用POSIX线程

### 使用NSObject产生线程

### 在Cocoa应用中使用POSIX线程

#### 保护Cocoa框架

#### 结合POSIX和Cocoa的锁

## 配置线程的属性

### 配置一个线程的栈的大小

### 配置本地线程的存储

### 设置线程的分离状态

### 设置线程的优先级

## 编写你的线程的入口程序

### 创建自动释放池

### 设置异常处理

### 设置运行循环

## 中止一个线程

# 运行循环

## 运行循环剖析

### 运行循环模式

### 输入资源

#### 基于端口的资源

#### 自定义输入资源

#### Cocoa执行Selector资源

### Timer资源

### 运行循环监听

### 运行循环作业顺序

## 什么时候你应该使用运行循环？

## 使用运行循环对象

### 获取一个运行循环对象

### 配置运行循环

### 开启运行循环

### 中止运行循环

### 线程安全和运行循环对象

## 配置运行循环资源

### 定义自定义输入源

#### 定义输入源

#### 在运行循环中安装输入源

#### 协调输入源的委托

#### 输入源的信号量

### 配置Timer资源

### 配置基于端口的输入资源

#### 配置NSMachPort对象

##### 实现主线程相关代码

##### 实现次级线程相关代码

#### 配置NSMessagePort对象

#### 在Core Foundation框架中配置基于端口的输入源

# 同步

## 同步工具

### 原子操作

### 内存阻碍和不稳定的变量

### 锁

### Conditions

### 执行Selector的惯例

## 同步的消耗和性能

## 线程安全和信号量

## 线程安全设计的一些贴士

### 避免整体同步

### 理解同步的有限性

### 了解代码正确性的风险

### 小心死锁和活锁

### 正确的使用不稳定的变量

## 使用原子操作

## 使用锁

### 使用POSIX互斥锁

### 使用NSLock类

### 直接使用@synchronized

### 使用其他的Cocoa锁

#### 使用NSRecursiveLock对象

#### 使用NSConditionLock对象

#### 使用NSDistributedLock对象

## 使用Conditions

### 使用NSCondition类

### 使用POSIX Conditions

# 附录A：线程安全总结

## Cocoa

### Foundation框架中的线程安全

#### 线程安全的类和函数

#### 非线程安全的类

#### 仅在主线程的类

#### 可变与不可变

#### 重入

#### 类的初始化

#### 自动释放池

#### 运行循环

### Application框架的线程安全

#### 非线程安全的类

#### 仅在主线程的类

#### Window限制条件

#### 事件处理的限制条件

#### 绘制的限制条件

##### NSView的限制条件

##### NSGraphicsContext的限制条件

##### NSImage的限制条件

# 术语表

application 一种特殊类型的程序，它展示图形界面给用户。
condition 
critical section 一份一次只能在一个线程中执行的代码
input source
joinable thread
main thread 一种特殊类型的线程，当进程创建的时候，它就被创建。当程序的主线程终止时，它就终止。
mutex
operation object  NSOperation 类的实例对象。Operation对象封装了和一个任务相关的代码和数据到一个可执行的集合当中。
operation queue  NSOperationQueue类的实例对象。Operation queues管理着operation对象的执行。
process
program 代码和资源的结合，它可以被用来执行某种任务。
recursive lock  
run loop 一个事件处理的循环，当接收到事件的时候以及调度适当的操作的时候。
run loop mode
run loop object  
run loop observer  
semaphore
task 一些要被执行的任务
thread
timer source  