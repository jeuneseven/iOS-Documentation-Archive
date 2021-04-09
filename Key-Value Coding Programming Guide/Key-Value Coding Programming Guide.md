[Key-Value Coding Programming Guide](https://developer.apple.com/library/archive/documentation/Cocoa/Conceptual/KeyValueCoding/index.html#//apple_ref/doc/uid/10000107-SW1)

# 开始
## 关于KVC

KVC是一种通过NSKeyValueCoding非正式协议启动的机制，遵循该协议的对象会提供它属性的间接访问。当一个对象符合KVC时，它的属性是可以通过字符串参数以一个精确、唯一的消息接口进行寻址的。这种间接的访问机制对于通过实例变量和它的关联存取方法是一种补充。  
通常使用存取方法来访问一个对象的属性。取方法（即getter）返回一个属性的值。存方法（即setter）设置一个属性的值。在OC当中你还可以直接访问一个属性的底层的实例变量。以任何方式访问一个对象的属性都是直接的，但是需要调用一个属性特定的方法或者变量名。随着属性的增加或变更，这些存取这些属性的方法的代码也要变更。作为对比，一个符合KVC的对象提供了一种简单的消息接口，它可以贯穿所有这些属性。  
KVC是一个很多其他Cocoa技术的底层原理，比如KVO，cocoa绑定，Core Data和AppleScript功能。KVC还可以在某些情况下帮助你简化代码。  

### 使用符合KVC的对象

### 为一个对象采用KVC

### Swift中的KVC

### 其他的依赖KVC的Cocoa的技术

# KVC基本原理
## 访问对象的属性

## 访问集合属性

## 使用集合操作符

## 表示非对象值

## 校验属性

## 存取器搜索模式

# 采用KVC
## 获取基本的KVC合规

## 定义集合方法

## 处理非对象值

## 增加校验

## 描述属性关系

## 性能设计

## 合规检查表