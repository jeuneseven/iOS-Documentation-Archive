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

# 同步

# 附录A：线程安全总结

# 术语表