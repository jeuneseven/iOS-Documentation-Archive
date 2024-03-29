[Dynamic Library Programming Topics 原文链接](https://developer.apple.com/library/archive/documentation/DeveloperTools/Conceptual/DynamicLibraries/000-Introduction/Introduction.html#//apple_ref/doc/uid/TP40001869)

# 介绍

## 本文档的组织结构

## 另请参见

# 动态库概览

## 什么时候动态库？

## 动态库是怎么使用的

# 动态库设计指南

## 设计一个理想的动态库

## 通过依赖库管理客户端依赖

### 定义客户端兼容性

### 指定版本信息

## 指定你的库的接口

### 判断什么样的符号表适合导出

### 命名导出的符号表

### 符号表导出策略

## 定位外部资源

## 库的依赖

## 模块的初始化和终止

## 基于C++的库

### 导出C++符号表

### 定义C++类接口

### 创建和销毁C++对象

## 基于OC的库

### 定义类和分类接口

### 初始化OC类

### 创建类的别名

## 设计指南清单

# 动态库使用指南

## 打开动态库

### 动态库检索过程

### 指定导出的符号表的范围和绑定行为

## 使用符号表

## 使用弱连接符号表

## 使用C++类

## 使用OC类

## 对于给定的特殊地质获取符号表信息

# 创建动态库

## 创建动态库

### 定义库的目的

### 定义库的接口

### 实现库

### 设置库的版本信息

### 测试库

## 更新库

### 做出兼容性的变更

### 更新库的版本信息

### 测试新版本的库

# 使用动态库

## 安装依赖库

## 使用依赖库

## 使用运行时加载库

## 依赖库中的干预函数

# 运行路径依赖库

## 创建运行路径依赖库

## 使用运行路径依赖库

# 记录动态加载事件