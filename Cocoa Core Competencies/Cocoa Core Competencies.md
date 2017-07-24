[Cocoa Core Competencies 原文链接](https://developer.apple.com/library/content/documentation/General/Conceptual/DevPedia-CocoaCore)

# Cocoa 核心能力（Cocoa Core Competencies）

## 辅助功能（Accessibility）

### 使用VoiceOver

## 存取器方法（Accessor method）

### 命名规范

## App ID

### 一个显式的App ID对应一款App

### 通配符App IDs对应多款App

## app代码签名（Application Code Signing）

## Block对象（Block object）

### 声明一个Block

### 创建一个Block

### Block变量

### 使用Block

### 比较操作

## 包（Bundle）

### 包的结构和内容

### 访问包资源

### 可加载的包

## 分类（Category）

### 声明

### 实现

## 类簇（Class cluster）

### 收益

### 注意事项

## 类定义（Class definition）

### 接口

### 实现

## 类方法（Class method）

### 子类

### 实例变量

### self

## Cocoa (Touch)

### 类库

### 语言本身

## 编码惯例（Coding conventions）

## 集合（Collection）

### 集合类

### 排序方案

## 控制器对象（Controller object）

### 协调控制

### 视图控制器

### 媒体控制（OS X）

## 声明属性（Declared property）

## 委托（Delegation）

### 委托和cocoa框架

### 委托和通知

### 数据源

## 动态绑定（Dynamic binding）

## 动态类型（Dynamic typing）

### isa指针

## 枚举（Enumeration）

### NSEnumerator

### 快速枚举

## 异常处理（Exception handling）

### 异常的类型

### 使用编译器指令处理异常

### error信号量

## 类库（Framework）

## 信息属性列表（Information property list）

## 初始化（Initialization）

### 初始化声明的方式

### 实现初始化函数

## 国际化（Internationalization）

## 内省机制（Introspection）
内省是指对象在运行时根据请求泄露其本质特征的内在能力。通过歌对象发送特定的逆袭，你可以询问对象有关它们作为对象本身的问题，OC运行时机制会给你提供答案。内省是编程时很重要的一个工具，因为它能够让你的程序更有效和健壮。以下是一些如何使用内省的示例：  

* 你可以调用内省方法作为运行时的检查机制来帮助你避免异常等情况，例如你给一个不能够接受某个消息的对象发送某个消息时就会发生异常。
* 你还可以使用内省来定位一个对象的继承关系，这将会为你提供对象的能力的基本信息。
![](https://developer.apple.com/library/content/documentation/General/Conceptual/DevPedia-CocoaCore/Art/introspection_2x.png)

### 内省信息的类型

## 键值编码（Key-value coding）

### 对象属性和KVC

### 让一个类能够顺利使用KVC

## 键值监听（Key-value observing）

### 实现KVO

### KVO是绑定中不可分割的一部分（OS X）

## 内存管理（Memory management）

### 内存管理规定

### 内存管理的各方面

## 消息（Message）

## 方法重写（Method overriding）

## 模型对象（Model object）

### 一个设计良好的模型类

## 模型-视图-控制器（Model-View-Controller）

### 模型类

### 视图类

### 控制器类

## 多种初始化（Multiple initializers）

### 特定的初始化

## nib文件（Nib file）

## 通知（Notification）

### 通知对象

### 监听通知

### 发送通知

## 对象归档（Object archiving）

### key和连续归档

### 创建和解码key归档

## 对象比较（Object comparison）

### 实现比较逻辑

## 对象拷贝（Object copying）

### 对象拷贝的前提条件

### 内存管理的启示

## 对象创建（Object creation）

### 对象创建的格式

### 内存管理的启示

### 工厂方法

## 对象编码（Object encoding）

### 如何编解码一个对象

### key的相对连续归档

## 对象关系（Object graph）

## 对象生命周期（Object life cycle）

## 对象建模（Object modeling）

## 对象的可变性（Object mutability）

### 接收可变对象

### 存储可变对象

## 对象所有权（Object ownership）

## Objective-C

## 属性列表 （Property list）

### 属性列表类型和对象

### 最佳属性列表

### 属性列表序列化

## 协议（Protocol）

### 形式与非形式的协议

### 符合和才用一个正式协议

### 创建你自己的协议

## 根类（Root class）

## 选择器（Selector）

### 获取选择器

### 使用选择器

## 单例（Singleton）

## 统一类型标识（Uniform Type Identifier）

### 统一类型标识使用了反向系统域名惯例

### 统一类型标识在一个一致性的层级当中被声明

### OS X应用通过定义添加了新的统一类型标识在app包当中

## 值对象（Value object）

### NSValue