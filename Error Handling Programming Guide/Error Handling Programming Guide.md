[Error Handling Programming Guide 原文链接](https://developer.apple.com/library/content/documentation/Cocoa/Conceptual/ErrorHandlingCocoa/ErrorHandling/ErrorHandling.html#//apple_ref/doc/uid/TP40001806)

# 介绍
任何程序在运行时发生error的话，都需要对其进行处理。举例来说，程序可能无法打开一个文件，或者可能无法解析一个XML文档。通常发生这类error的情况下，程序应当告知使用者。并且程序应当试图避免引起问题的error。
# error对象，域名，代码

## 为什么会有Error对象？

## error域名

## error codes

## 用户信息字典

### 本地化的error信息

### 恢复的可能性

### 潜在的error

### 特殊域名的key

# 使用和生成error对象

## 处理从方法返回的error

### OS X中的error处理的替代选择

## 显示从error对象返回的信息

### 通过Application对象传递显示error（OS X）

## 创建和返回NSError对象

### error和异常的提示

# error的响应和error的恢复

## error响应链

## 自定义error

## error的恢复

# 处理收到的error

## 通过error响应链向上传递error

## 自定义error对象

# 从error恢复