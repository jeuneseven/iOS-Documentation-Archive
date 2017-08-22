[Threading Programming Guide 原文链接](https://developer.apple.com/library/content/documentation/Cocoa/Conceptual/Multithreading/Introduction/Introduction.html#//apple_ref/doc/uid/10000057i)

# 介绍

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
operation object
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