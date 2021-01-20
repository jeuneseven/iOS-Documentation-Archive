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

已交付的LLDB包括许多命令别名，这些别名被设计为与GDB命令相同。如果你已经体验过了GDB命令，你可以使用提供的表单来查找GDB中和LLDB命令等价的命令，包括规范和速记表格。

```
相关章节：GDB和LLDB命令示例
```

#### 独立的LLDB工作流

通常会使用Xcode调试功能来体验LLDB，使用Xcode控制台面板使用LLDB命令。不过，对于开源的开发和其他基于非图形界面的应用调试，你可以从终端窗口作为常用命令行调试来使用LLDB。  
知晓LLDB如何作为一个命令行调试器是如何工作的，有利于帮助你理解和使用Xcode控制台面板中的LLDB的全部功能。  

```
相关章节：使用LLDB作为独立调试
```

### 另请参见

如要详细了解如何使用Xcode的调试功能，所有由LLDB调试引擎所提供的能力的话，参见WWDC 2013的“Tools #407 WWDC 2013: Debugging with Xcode”视频片段。  
要了解最近的高级功能来帮助你高效的使用LLDB跟踪bug，参见WWDC 2013的“Tools #413 WWDC 2013: Advanced Debugging with LLDB”视频片段。  
更多关于使用LLDB Python脚本和其他高级功能的信息，参见“The LLDB Debugger”。

# 从使用LLDB开始

LLDB是一个和GDB功能相似的命令行调试环境。LLDB为Xcode提供了基础调试环境，包含在调试区域中的控制台来直接在Xcode IDE环境中能够访问LLDB命令。  
本章节简单的解释了LLDB的语法和命令功能，为你介绍命令行别名功能的使用，并为你介绍LLDB的帮助系统。

## LLDB命令结构

所有的用户开始使用LLDB都应该意识到LLDB命令结构和语法是为了触及LLDB的潜在功能和理解如何更多的对其进行使用。在很多情况下，LLDB命令行提供——比如list和b——都和GDB命令类似，并且有经验的GDB用户学习LLDB更简单。  

### 理解命令语法

LLDB命令语法是结构和规律贯穿始终的。LLDB命令都是如下格式：  

	<command> [<subcommand> [<subcommand>...]] <action> [-options [option-value]] [argument [argument...]]

命令和子命令都是LLDB调试对象的名称。命令和子命令是按照等级排列的：一个特定的命令对象会创建它之后的一个子命令对象的上下文，并且同样会提供给后续子命令上下文，以此类推。“动作”是你想要执行在结合调试对象（）中的操作

### 使用命令选项

	breakpoint set
       -M <method> ( --method <method> )
       -S <selector> ( --selector <selector> )
       -b <function-name> ( --basename <function-name> )
       -f <filename> ( --file <filename> )
       -l <linenum> ( --line <linenum> )
       -n <function-name> ( --name <function-name> )
	…

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