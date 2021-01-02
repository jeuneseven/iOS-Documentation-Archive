[LLDB Quick Start Guide 原文链接](https://developer.apple.com/library/content/documentation/IDEs/Conceptual/gdb_to_lldb_transition_guide/document/Introduction.html#//apple_ref/doc/uid/TP40012917)

# 介绍
## 关于LLDB和Xcode

随着Xcode 5的发布，LLDB 调试器变成了在OSX上调试的基础。  

![](https://developer.apple.com/library/archive/documentation/IDEs/Conceptual/gdb_to_lldb_transition_guide/art/lldb_in_xc5_command_window_2x.png)  

LLDB 是苹果“从0开始”中对于GDB的替代品，与LLVM编译器紧密协作开发，为你带来最先进的调试，在流程控制和数据监测方面具有广泛的功能。从Xcode 5开始，所有新的和已经存在的开发项目都会自动重新配置为使用LLDB。  
标准LLDB的安装为你提供了大量与GDB命令类似并兼容的命令集合。再加上使用标准配置，你能够很容易的定制LLDB为你所需。

### 概览

LLDB被完全整合到了Xcode 5来进行源代码开发以及提供构建-运行的调试体验。你可以使用由Xcode UI所提供的控制功能来访问这种能力，或者从Xcode调试命令行访问命令。  

#### 理解LLDB是基于未解锁的高级功能

使用LLDB命令行语言，你可以使用LLDB的高级功能。命令的语法很常见并容易学习。很多命令的表达包括快捷键，节省你的时间和输入次数。并且你能够使用LLDB的帮助系统来快速检测和学习已经存在的命令和快捷键以及命令选项的详细情况。  
你可以使用命令的别名功能来自定义LLDB。还可以通过使用Python脚本和Python-LLDB对象库来扩展LLDB。

```
相关章节：从LLDB开始
```

#### 使用LLDB等同于通用的GDB命令


```
相关章节：GDB和LLDB命令示例
```

#### 独立的LLDB工作流



```
相关章节：使用LLDB作为独立调试
```

### 另请参见

# 从使用LLDB开始

## LLDB命令结构

### 理解命令语法

### 使用命令选项

### 使用原始命令

### 在LLDB中使用command completion

### 对比LLDB和GDB

### 使用Python脚本

## 命令别名以及帮助

### 理解命令别名

### 使用LLDB帮助

# GDB和LLDB命令示例

## 执行类命令

## 断点类命令

## 监测点类命令

## 检测变量

## 评估表达式

## 检测线程状态

## 执行和共享库查询命令

## 其他参数

# 使用LLDB作为独立的调试器

## 指定程序debug

## 设置断点

## 设置观察点

## 使用LLDB加载程序

## 控制你的程序

## 检测线程状态

## 检测堆栈结构状态

## 执行替换代码