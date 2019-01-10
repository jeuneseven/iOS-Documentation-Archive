[Framework Programming Guide 原文链接](https://developer.apple.com/library/archive/documentation/MacOSX/Conceptual/BPFrameworks/Frameworks.html#//apple_ref/doc/uid/10000183i)

# 介绍

# 什么是frameworks？

# framework bundles剖析

## framework bundle的结构

### framework版本

### 额外的目录

### framework配置

## 保护式framework bundle的结构

### 保护式framework的目的

### 保护式framework bundle

# framework的版本

## 主版本

### 主版本号组合

### 何时使用主版本

### 避免主版本改变

### 创建一个framework的主版本

## 次版本

### 次版本号组合

### 何时使用次版本

### 运行时兼容版本号

### 创建一个framework的次版本

## 版本指南

# frameworks和绑定

## 动态共享库

### 符号绑定

### 组织你的framework代码

### 库依赖

### 独立动态共享库

## frameworks和预绑定

### 预绑定你的framework

### 预绑定的警告

### 查找framework的优先地址

### Apple framework和预绑定

# frameworks和弱链接

## 弱连接和Apple framework

## 为弱连接标记符号

## 使用弱连接符号

## 弱连接整个frameworks

# 创建frameworks指南

## API命名指南

## frameworks的性能影响

## 什么应该包含进你的frameworks中

## 在frameworks代码中使用C++

## 不要创建受保护的frameworks

## 在什么位置初始化你的frameworks

# 创建一个frameworks

## 创建你的frameworks

### 配置你的framework工程

### 在适当的位置测试你的framework

## 在你的应用程序包中嵌入一个私有frameworks

### 为targets使用一个单独的Xcode项目

### 为不同的targets使用不同的Xcode项目

## 构建一个frameworks的多个版本

### 更新次版本

### 更新主版本

# 运行时初始化一个frameworks

## 初始化惯例以及性能

## 定义模块的初始化和终止

## 应用初始化惯例

# 导出你的frameworks的接口

## 创建你的导出文件

## 指定你的导出文件

# 加载你的frameworks

## 公开frameworks的定位

## 私有frameworks的定位

## 初始化frameworks

# 包含frameworks

## 在你的项目中包含frameworks

## 在不标准的目录下定位frameworks

## 头文件和性能

## 子frameworks链接时的限制