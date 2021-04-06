[Adopting Modern Objective-C 原文链接](https://developer.apple.com/library/content/releasenotes/ObjectiveC/ModernizationObjC/AdoptingModernObjective-C/AdoptingModernObjective-C.html#//apple_ref/doc/uid/TP40014150)

多年以来，OC语言一直在发展和进化。尽管核心的概念和做法保持不变，但部分语言经历了重大变革和改进。这些现代化的改进提高了安全性，内存管理，性能和OC的其他方方面面，让你在使用它时更容易写出正确的代码。在现有和未来的代码中使用这些特性非常重要，它能够使你的代码变得更一致，可读性和弹性变得更好。  
Xcode提供了一组工具来帮助你进行这些结构上的变更。但在你使用这些工具之前，你应该了解这些变更给你的代码都提供了什么，以及为什么有这些变更。本文档强调了代码库中要采用的一些最重要的、最有用的现代化变更。

# instancetype

使用 instancetype 关键字作为方法的返回值类型会返回一个它所调用的类的实例（或者该类的子类）。这些方法包括alloc, init和类的工厂方法。  
使用 instancetype 代替 id 是一个很好的替代，它提供了你的OC代码中的安全性。比如，考虑以下代码：  

	@interface MyObject : NSObject
	+ (instancetype)factoryMethodA;
	+ (id)factoryMethodB;
	@end
	 
	@implementation MyObject
	+ (instancetype)factoryMethodA { return [[[self class] alloc] init]; }
	+ (id)factoryMethodB { return [[[self class] alloc] init]; }
	@end
	 
	void doSomething() {
	    NSUInteger x, y;
	 
	    x = [[MyObject factoryMethodA] count]; // Return type of +factoryMethodA is taken to be "MyObject *"
	    y = [[MyObject factoryMethodB] count]; // Return type of +factoryMethodB is "id"
	}

由于 +factoryMethodA 方法的返回类型是 instancetype，该条消息表达式的类型是 MyObject *。MyObject 没有-count 方法，下列编译指令会给x 这一行出一条警告：  

	main.m: ’MyObject’ may not respond to ‘count’

而由于+factoryMethodB 的返回类型是 id，编译器不会给y这一行以警告。因为一个id类型的对象可以是任何类，而一个叫做-count的方法是可能存在于某个类的某个地方的，对编译器来说+factoryMethodB的返回值类型是可能实现了该方法的。  
要确定instancetype 工厂方法有正确的子类型为，在分配类而非直接饮用类名的时候确保使用 [self class] 。遵照这种管理确保编译器会正确推断出子类类型。比如，从前例中的MyObject的子类中考虑尝试这么做：  

	@interface MyObjectSubclass : MyObject
	@end
	 
	void doSomethingElse() {
	        NSString *aString = [MyObjectSubclass factoryMethodA];
	}

编译器会对这段代码给出如下警告：  

	main.m: Incompatible pointer types initializing ’NSString *’ with an expression of type ’MyObjectSubclass *’

在例子当中，+factoryMethodA 消息发出的返回MyObjectSubclass类型的对象，也就是接收者的类型。编译器会适当的判断 +factoryMethodA 的返回类型应该为MyObjectSubclass的子类，而非工厂方法致歉声明的子类。  

## 如何采用

在你的代码中只要出现返回值类型是id的都可以替换为 instancetype。这通常是 init 方法这种案例以及类工厂方法。虽然编译器自动的转换开头为 “alloc,” “init,” or “new” 的方法并将返回id的转换为返回 instancetype 的，但它不会转换其他方法。OC的惯例是为所有方法显式的写上 instancetype。  
注意你应该只在返回值中将id替换为 instancetype，不是你的代码中的所有地方。instancetype关键字和id不同，它只能被用做方法声明的返回值类型。  
比如：  

	@interface MyObject
	- (id)myFactoryMethod;
	@end
	
应该变为：
	
	@interface MyObject
	- (instancetype)myFactoryMethod;
	@end
	
作为一种选择，你可以使用在Xcode中的现代OC转换器来自动的在你的代码中做出这一变更。更多信息，参见《使用Xcode重构你的代码》。

# Properties属性

一个OC的属性是一个公开或私有的方法声明，使用@property语法声明。  

	@property (readonly, getter=isBlue) BOOL blue;

属性捕获了一个对象的状态。它们反应了对象的固有属性以及和其他对象之间的关系。属性提供了一个安全，便捷的方式来与这些特性交互而无需编写一组自定义的存取方法（虽然属性确实允许自定义的getters和setters，如果需要的话）。  
使用属性代替实例变量在尽可能多的地方会提供很多的好处：  

* 自动生成存取方法。当你声明一个属性的时候，默认的就为你生成了存取方法。
* 更好的声明一组方法的意图。由于存取方法命名的规范，会清晰准去的直到存取方法是做什么的。
* 属性关键字能够表达额外的关于行为的信息。属性提供了潜在的属性声明，比如assign (对比 copy), weak, atomic (对比 nonatomic)，等等。

属性方法遵循一个简单的命名规范。getter 方法的名称就是属性名（比如，date），setter方法的名称是以set作为前缀的属性名，以驼峰命名编写（比如，setDate）。布尔型属性的命名规范是可以以以单词“is”开头的属性名：  

	@property (readonly, getter=isBlue) BOOL blue;

最后，所有的下列都可以运行：  

	if (color.blue) { }
	if (color.isBlue) { }
	if ([color isBlue]) { }

当判断什么可以成为一个属性时，记住下列无法成为属性：  

* init方法
* copy、mutableCopy方法
* 类工厂方法
* 以动作开始并返回一个BOOL结果的方法
* 显式的改变内部的状态作为getter方法的副作用的方法

此外，在你的代码中当判断潜在的属性时考虑如下一组规则：  

* 一个读、写的属性有两个存取方法。setter带一个参数并不返回任何内容，getter不带参数并返回一个值。如果你将这组方法转换为一个属性，标记为关键字 readwrite。 
* 一个只读的方法只有一个存取方法，即getter，不带参数返回一个值。如果你转换这个方法为一个属性，标记以readonly关键字。
* getter应该是幂等的（若一个getter被调用两次，第二次调用的结果应该和第一次一样）。不过，可以接受一个getter方法每次被调用的时候计算其结果。

## 如何采用

判断一组方法是否有资格能够被转换为一个属性，类似这些：  

	- (NSColor *)backgroundColor;
	- (void)setBackgroundColor:(NSColor *)color;

并使用@property语法配合恰当的关键字进行声明：  

	@property (copy) NSColor *backgroundColor;

更多关于属性关键字和其注意事项，参见《封装数据》。  
作为一种选择，你可以使用Xcode中的现代OC转换器来对你的代码自动的做出这一改变。更多信息，参见《使用Xcode在你的代码中进行重构》。

# 枚举指令

NS_ENUM和NS_OPTIONS宏定义提供了一种简洁的方式来在基于C的语言中定义枚举和选项。这些宏定义提升了Xcode中的代码完成度并显式的指定你的枚举和选项的类型和大小。此外，这些句法声明的枚举被旧的编译器判断为正确的方式，并被新的编译器表达底层的类型信息。  
使用NS_ENUM宏定义来定义枚举，一组互相独有的值：  

	typedef NS_ENUM(NSInteger, UITableViewCellStyle) {
	        UITableViewCellStyleDefault,
	        UITableViewCellStyleValue1,
	        UITableViewCellStyleValue2,
	        UITableViewCellStyleSubtitle
	};

NS_ENUM 宏定义帮助定义名称和枚举的类型，在这个例子中名称为UITableViewCellStyle，类型为NSInteger。枚举的类型应该为NSInteger。  
使用NS_OPTIONS宏定义来定义选项，一组可能会互相结合的位掩码的值：  

	typedef NS_OPTIONS(NSUInteger, UIViewAutoresizing) {
	        UIViewAutoresizingNone                 = 0,
	        UIViewAutoresizingFlexibleLeftMargin   = 1 << 0,
	        UIViewAutoresizingFlexibleWidth        = 1 << 1,
	        UIViewAutoresizingFlexibleRightMargin  = 1 << 2,
	        UIViewAutoresizingFlexibleTopMargin    = 1 << 3,
	        UIViewAutoresizingFlexibleHeight       = 1 << 4,
	        UIViewAutoresizingFlexibleBottomMargin = 1 << 5
	};

就像枚举一样，NS_OPTIONS宏定义定义了名字和联系。不过，选项的类型应该通常是NSUInteger的。  

## 如何采用

替换你的enum声明，类似这种：  

	enum {
	        UITableViewCellStyleDefault,
	        UITableViewCellStyleValue1,
	        UITableViewCellStyleValue2,
	        UITableViewCellStyleSubtitle
	};
	typedef NSInteger UITableViewCellStyle;

加上NS_ENUM语法：  

	typedef NS_ENUM(NSInteger, UITableViewCellStyle) {
	        UITableViewCellStyleDefault,
	        UITableViewCellStyleValue1,
	        UITableViewCellStyleValue2,
	        UITableViewCellStyleSubtitle
	};
	
不过当你使用enum定义位掩码的时候，类似这个：  

	enum {
	        UIViewAutoresizingNone                 = 0,
	        UIViewAutoresizingFlexibleLeftMargin   = 1 << 0,
	        UIViewAutoresizingFlexibleWidth        = 1 << 1,
	        UIViewAutoresizingFlexibleRightMargin  = 1 << 2,
	        UIViewAutoresizingFlexibleTopMargin    = 1 << 3,
	        UIViewAutoresizingFlexibleHeight       = 1 << 4,
	        UIViewAutoresizingFlexibleBottomMargin = 1 << 5
	};
	typedef NSUInteger UIViewAutoresizing;
	
使用 NS_OPTIONS 宏定义：  

	typedef NS_OPTIONS(NSUInteger, UIViewAutoresizing) {
	        UIViewAutoresizingNone                 = 0,
	        UIViewAutoresizingFlexibleLeftMargin   = 1 << 0,
	        UIViewAutoresizingFlexibleWidth        = 1 << 1,
	        UIViewAutoresizingFlexibleRightMargin  = 1 << 2,
	        UIViewAutoresizingFlexibleTopMargin    = 1 << 3,
	        UIViewAutoresizingFlexibleHeight       = 1 << 4,
	        UIViewAutoresizingFlexibleBottomMargin = 1 << 5
	};

作为选项，你可以使用Xcode中的现代OC转换器来自动的对你的代码作出变更。更多信息，参见《使用Xcode重构你的代码》。

# 对象初始化

在OC中，对象的初始化是基于一种“设定初始化器”的概念，一个初始化方法需要负责首先调用其父类的初始化方法然后初始化其自己的实例变量。非设定初始化器的方法被称作“便捷初始化器”。便捷初始化器通常代理其他的初始化器——最终的链条会在设定初始化器——而非自己执行初始化。  
设定初始化模式帮助确保继承的初始化方法都能够适当的初始化所有的实例变量。子类需要执行所有重要的初始化方法，应该重写所有父类的设定初始化方法，不过不用重写便捷初始化器。更多关于初始化器的信息，参见《对象的初始化》。  
为清晰的阐明初始化器和设定初始化器之间的区分，你可以添加NS_DESIGNATED_INITIALIZER宏定义给init家族中的任何方法，表示它是一个设定初始化器。使用该宏定义引入了一些限制条件：  

* 设定初始化器的实现必须链接到一个父类的init方法（使用[super init...]）它是一个父类的设定初始化器。
* 一个便捷初始化器（一个没有被标记为设定初始化器的初始化器，它所在类中至少有一个初始化器被标记为设定初始化器）的实现必须代理到另一个初始化器（使用[self init...]）。
* 如果一个类提供了一个或更多的设定初始化器，它必须实现所有的弗雷中的设定初始化器。

任何一条被违反了，你都会收到编译器警告。  
若你在你的类中使用NS_DESIGNATED_INITIALIZER宏定义，你需要用此标记你所有的设定初始化器。所有其他的初始化器都会被试做便捷初始化器。  

## 如何采用

在你的类中判断出设定初始化器，使用NS_DESIGNATED_INITIALIZER宏定义对其进行标记。比如：  

	- (instancetype)init NS_DESIGNATED_INITIALIZER;

# 自动引用计数(ARC)

自动引用计数（ARC）是个编译器的功能，它提供了OC对象的自动内存管理。不用你必须记录何时该使用retain, release, 和 autorelease，ARC会在运行时评估对象的生命周期所需，并自动的在适当的地方插入内存管理的调用。编译器也会为你生成适当的dealloc方法。

## 如何采用

Xcode提供了一个工具能够自动化的将ARC的机械转换部分（比如移除retain 和 release 调用）并帮助你自动化的修复迁移时无法处理的问题。要使用ARC迁移工具，选择编辑>重构>转换为OC ARC。迁移工具会转换所有工程中的文件为使用ARC的。  
更多信息，参见《转换为ARC发布指南》。  

# 使用Xcode重构你的代码

Xcode提供了一个现代OC转换器在现代化过程中帮助你。虽然转换器能够在机械的判断和应用潜在的现代化中提供帮助，但它并不能解释你的代码的语义。比如，它不能检测你的 -toggle 方法是一个动作，然后影响你的对象的状态，它会错误的为此动作提供现代化方法为一个属性。确保手动的检阅并确认转换器提供给你的代码的任何变更。  
前端所描述的现代化工具，转换器提供了：  

* 在适当的位置改变id为instancetype
* 改变enum为NS_ENUM 或 NS_OPTIONS
* 更新为@property句法

除了这些现代化，转换器推荐给你的代码额外的变化，包括：  

* 转化字面量，一个像[NSNumber numberWithInt:3]这样的表达式，变为@3。
* 使用下标，一个像[dictionary setObject:@3 forKey:key]这样的表达式，变为dictionary[key] = @3。

要使用现代OC转换器，选择编辑>重构>转换为现代化OC句法。