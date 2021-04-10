[Key-Value Coding Programming Guide](https://developer.apple.com/library/archive/documentation/Cocoa/Conceptual/KeyValueCoding/index.html#//apple_ref/doc/uid/10000107-SW1)

# 开始
## 关于KVC

KVC是一种通过NSKeyValueCoding非正式协议启动的机制，遵循该协议的对象会提供它属性的间接访问。当一个对象符合KVC时，它的属性是可以通过字符串参数以一个精确、唯一的消息接口进行寻址的。这种间接的访问机制对于通过实例变量和它的关联存取方法是一种补充。  
通常使用存取方法来访问一个对象的属性。取方法（即getter）返回一个属性的值。存方法（即setter）设置一个属性的值。在OC当中你还可以直接访问一个属性的底层的实例变量。以任何方式访问一个对象的属性都是直接的，但是需要调用一个属性特定的方法或者变量名。随着属性的增加或变更，这些存取这些属性的方法的代码也要变更。作为对比，一个符合KVC的对象提供了一种简单的消息接口，它可以贯穿所有这些属性。  
KVC是一个很多其他Cocoa技术的底层原理，比如KVO，cocoa绑定，Core Data和AppleScript功能。KVC还可以在某些情况下帮助你简化代码。  

### 使用符合KVC的对象

当对象继承自NSObject（直接或间接）时就会采用了KVC，同时遵守了NSKeyValueCoding协议并为基本方法提供了一个默认的实现。这样的一个对象能够让其他的对象通过一个简洁的消息接口做如下事情：  

* 访问对象属性。协议列举的方法，类似通用的取方法 valueForKey: 和通用的存方法 setValue:forKey:，通过对象的属性名或key，将其参数化为字符串来访问。这些方法的默认实现和相关方法使用了key来定位和与底层数据交互，这在《访问对象属性》中有相关描述。
* 操作集合属性。访问方法对于对象的集合属性（比如NSArray对象）所做的工作的默认实现就像其他的属性一样。此外，如果一个对象给一个属性定义了一个集合存取方法，它就开启了键值对访问集合内容的能力。这通常比直接访问并让你通过标准接口与自定义集合对象进行交互更加高效，如《访问集合属性》中描述的方法。
* 对于集合对象调用集合操作。
* 访问非对象的属性。
* 通过key路径访问属性。

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