[Scroll View Programming Guide for iOS 原文链接](https://developer.apple.com/library/content/documentation/WindowsViews/Conceptual/UIScrollView_pg/Introduction/Introduction.html#//apple_ref/doc/uid/TP40008179)

# 介绍

## 关于滚动视图编程

### 概览

#### 基本的视图滚动是很容易实现的

#### 使用代理来支持捏合缩放手势

#### 要支持捏合和触摸手势的缩放，需要在内容视图中实现代码

#### 要支持分页模式，你需要三个子视图

### 预备知识

### 如何使用本文档

### 另请参见

# 创建和配置滚动视图

## 创建滚动视图

### 在界面编辑器中创建滚动视图

### 以编码方式创建滚动视图

## 添加子视图

## 配置滚动视图的内容大小，内容内边距以及滚动指示

# 滚动滚动视图的内容

## 以编码方式滚动

### 滚动到一个特定的位置

### 将一个矩形可视化区域滚动到顶部

## 滚动时会发送代理消息

### 简单的方式：跟踪一个滚动事件的开始和结束

### 完整的代理消息发送顺序

# 基于放大效果使用捏合手势

## 支持捏合缩放手势

## 编码方式的缩放

## 通知代理缩放已经结束

## 当缩放时确保缩放内容sharp

# 通过触摸缩放

## 实现触摸事件代码

### 初始化

### 实现touchesBegan:withEvent:

### 实现touchesEnded:withEvent:

### 实现touchesCancelled:withEvent:

## ScrollViewSuite示例工程

# 使用分页模式滚动

## 配置分页模式

## 配置一个分页滚动视图的子视图

# 嵌套滚动视图

## 相同方向的滚动

## 交叉方向的滚动