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

## 如何适配

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


# 枚举指令

# 对象初始化

# 自动引用计数(ARC)

# 使用Xcode重构你的代码