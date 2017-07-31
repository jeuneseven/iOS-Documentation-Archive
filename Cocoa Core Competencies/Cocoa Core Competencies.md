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
一组私有的、实体子类封装在一个公有、抽象的父类下的结构被称作类簇。以这种方式组成的类为用户提供了简单的接口，用户只看得到公共的接口结构。而在其下，抽象类会调用私有的子类，这些私有的子类大部分都会执行特定的任务。举个例子，一些比较通用的cocoa类是由类簇实现的，包括NSArray, NSString, 以及 NSDictionary。有很多种方式可以让它们用来表现它们内部的数据存储。对于任何特定实例，抽象类会根据实例正在初始化的数据选择最有效的类来使用。  
您可以像使用任何其他类一样的对类簇的实例进行创建和交互。而在幕后，当你创建一个公开类的实例的时候，该类会根据你的调用返回一个适当的基于子类创建方法的实例对象。（你不会、也不能够选择实例的实际类。）  
拿Foundation框架的NSString类作为示例，你可以创建三种不同的字符串对象：  

	NSString *string1 = @"UTF32.txt";
	NSString *string2 = [NSHomeDirectory() stringByAppendingPathComponent:string1];
	NSTextStorage *storage = [[NSTextStorage alloc] initWithString:string2];
	NSString *string3 = [storage string];

每个字符串都可能是一个不同的私有子类的实例（事实上，在OS X v10.5中，每一个都是）。虽然每个对象都是 NSString 的私有子类, 但将每个对象都视为 NSString 类的实例很方便。你使用的NSString类声明的实例方法就像NSString本身的一样。
### 收益
类簇的收益主要体现在效率上。实例管理的数据的内部表示可以根据创建或使用的方式进行调整。此外，即使底层实现改变了，你的代码依旧有效。
### 注意事项
类簇结构提供了一种介于简单和扩展之间的平衡：拥有少量的公共接口代替大量的私有接口，这使得在框架当中很容易上手和使用，但在任何类簇当中都很难创建子类。    
你创建的包涵类簇的类必须：  

* 是类簇抽象父类的子类
* 声明它本身的存储
* 重写子类的原始方法

很少会遇到需要创建子类的情况——比如在Foundation框架中的类簇——类簇的结构很明显是很有益的。你也可以使用组合来避免使用子类；通过在你自己的设计的对象中植入私有的类簇对象，你就能够创建一个组合对象。这种组合对象能够依赖类簇对象的基本函数属性，它只会以某种特定的方式拦截它所需要的信息。使用这种方法来减少你必须编写的代码量，并且让你能够利用Foundation框架提供的检测代码。
### 预读文章
无
### 相关文章
无
### 详细讨论
类簇（Class Clusters）
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
动态绑定决定了方法是在运行时而不是编译时被调用。动态绑定也被称作延迟绑定。在OC当中，所有的方法都是在运行时决定的。最终被决定要执行的代码是被方法名（选择器）和接收对象共同决定的。  
动态绑定允许多态。举例来说，假设一个集合对象包含了Dog, Athlete, 和 ComputerSimulation等。每个对象都有她自己的run方法的实现。在以下代码段当中，[anObject run]语句在运行时将会调用实际执行的代码。运行时系统使用选择器来判断run方法是由哪个类的anObject对象来最终调用的。  

	NSArray *anArray = [NSArray arrayWithObjects:aDog, anAthlete, aComputerSimulation, nil];
	id anObject = [anArray objectAtIndex:(random()/pow(2, 31)*3)];
	[anObject run];

本例阐述了OC的动态特性——这种功能在Cocoa当中到处都有。
### 预读文章
键值监听（Key-value observing）
选择器（Selector）
### 相关文章
无
### 详细讨论
使用对象（Working with Objects）
## 动态类型（Dynamic typing）

### isa指针

### 预读文章
无
### 相关文章
动态绑定（Dynamic binding）
异常处理（Exception handling）
### 详细讨论
使用对象（Working with Objects）
## 枚举（Enumeration）

### NSEnumerator

### 快速枚举

## 异常处理（Exception handling）

### 异常的类型

### 使用编译器指令处理异常

### error信号量

### 预读文章
无
### 相关文章
无
### 详细讨论
异常编程话题讨论（Exception Programming Topics）
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
NSObject类采用的NSObject协议定义了内省方法，产生了以下类型的对象信息：  

* 类的关系。如果想检查一个对象是直接还是间接的从一个特定的类继承的，你可以发送 isKindOfClass: 消息来判断结果。该方法会告诉你该对象是否是给定类的直接子类。你还可以使用class和superClass方法来获取对象的类或父类，然后在判断语句当中使用该结果。
* 消息响应。如果想检查一个对象的类或者父类是否实现了某方法，可以发送给该对象 respondsToSelector: 消息。参数是从使用 @selector 指令的方法签名构造的 SEL 类型值。举个例子：  
		
		BOOL doesRespond = [anObject respondsToSelector:@selector(writeToFile:atomically:)];
* 协议的一致性。如果一个类遵守一项正式协议，你可以预期它已经实现了协议定义的必须实现的方法，并且可以给它发送相应的信息。使用 conformsToProtocol: 方法来获取这一信息。你可以使用@protocol指令来指定此方法的参数。

### 预读文章
消息（Message）
### 相关文章
对象比较（Object comparison）
协议（Protocol）
选择器（Selector）
### 详细讨论
NSObject协议参考（NSObject Protocol Reference）
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
一个selector代表一个对象用来执行的方法名，或者是党源代码被编译时替换的唯一标识。一个selector本身并不做任何事。它仅仅标识了一个方法。
### 获取选择器
编译的selector是SEL类型的。通常有两种方式来获取一个selector：

* 在编译时，你可以使用编译程序指令@selector。
	
		SEL aSelector = @selector(methodName);
* 在运行时，你可以使用NSSelectorFromString函数，字符串为方法名：

		SEL aSelector = NSSelectorFromString(@"methodName");
当你希望代码在运行时发送可能不知道其名称的消息时, 可以使用从字符串创建的选择器。
### 使用选择器

### 预读文章
消息（Message）
### 相关文章
动态绑定（Dynamic binding）
### 详细讨论
使用Objects（Working with Objects）
## 单例（Singleton）

## 统一类型标识（Uniform Type Identifier）

### 统一类型标识使用了反向系统域名惯例

### 统一类型标识在一个一致性的层级当中被声明

### OS X应用通过定义添加了新的统一类型标识在app包当中

## 值对象（Value object）

### NSValue