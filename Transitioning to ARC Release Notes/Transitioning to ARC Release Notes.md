[Transitioning to ARC Release Notes 原文链接](https://developer.apple.com/library/archive/releasenotes/ObjectiveC/RN-TransitioningToARC/Introduction/Introduction.html#//apple_ref/doc/uid/TP40011226)

自动引用技术（ARC）是一个编译器的功能，它为OC对象提供了自动内存管理。你无须再考虑retain和release操作，ARC能够让你将精力集中在有趣的代码上，对象图表以及在你的应用程序中的对象之间的关系。  

![](https://developer.apple.com/library/archive/releasenotes/ObjectiveC/RN-TransitioningToARC/Art/ARC_Illustration.jpg)

# 摘要
ARC是通过在编译期间添加代码来确保对象能够根据需要来存活或销毁的。从概念上讲，它和手动引用计数一样，遵循的同样的内存管理规则（在“高级内存管理编程指南”中有相关描述），它是通过为你添加适当的内存管理调用。  
为了让编译器能够生成正确的代码，ARC限制了你能够使用的方法以及如何使用免费的桥接（参见“免费桥接类型”一节）。ARC同样也为对象引用和声明属性引入了新的生命周期修饰符。  
ARC在OSX v10.6和v10.7的Xcode 4.2和iOS 4以及iOS 5之后可以引用。弱引用在OSX v10.6和iOS 4中不再支持。  
Xcode提供了一个工具来自动的操作ARC转换（比如移除retain和release调用）并帮助你修复在迁移时无法自动处理的问题（选择Edit > Refactor > Convert to Objective-C ARC）。迁移工具会转换所有项目中的文件来使用ARC。你也可以选择使用在每个文件的基础上使用ARC，如果你想要在某个文件上使用手动引用计数的话。

另请参见：  

* 高级内存管理编程指南
* Core Foundation内存管理编程指南

# ARC概览
你无需记住何时得使用retain, release, 和 autorelease，ARC会对你的对象的生命周期的要求进行评估，并在编译时自动的插入适当的内存管理调用。编译器也会生成适当的dealloc方法。通常来讲，如果你需要与使用手动引用计数的代码进行交互时，使用ARC的传统Cocoa命名惯例才会显得重要。  
一份完整并正确的 Person 类的实现会类似这样：  

	@interface Person : NSObject
	@property NSString *firstName;
	@property NSString *lastName;
	@property NSNumber *yearOfBirth;
	@property Person *spouse;
	@end
 
	@implementation Person
	@end

（对象属性默认是strong类型的；strong属性在“ARC引入了新的生命周期的限定符”一节中有相关描述。）  
使用ARC，你可以实现一个人为的方法，类似这样：  

	- (void)contrived {
	    Person *aPerson = [[Person alloc] init];
	    [aPerson setFirstName:@"William"];
	    [aPerson setLastName:@"Dudney"];
	    [aPerson setYearOfBirth:[[NSNumber alloc] initWithInteger:2011]];
	    NSLog(@"aPerson: %@", aPerson);
	}

ARC会关心内存管理，所以不论是Person还是NSNumber对象都不会泄漏。  
你也可以安全的实现Person 类的 takeLastNameFrom:方法类似这样：  

	- (void)takeLastNameFrom:(Person *)person {
 	   NSString *oldLastname = [self lastName];
	    [self setLastName:[person lastName]];
	    NSLog(@"Lastname changed from %@ to %@", oldLastname, [self lastName]);
	}

ARC会确保 oldLastName 不会在NSLog语句之前就被释放。  
## ARC强制新规定
为了起到作用，当使用其他编译器模式时，ARC会强加一些新的规则在未展示的情况。规则本身试图提供一个完整的可依赖的内存管理模型；在某些情况下，它会直接强制最佳体验，在一些其他的情况下，它会简化你的代码或  

* 你不能够显式的调用 dealloc，或实现或调用retain, release, retainCount, 或 autorelease。以此延伸到使用@selector(retain), @selector(release)等等。

## ARC引入了新的生命周期的限定符

## ARC使用了新的语句来管理自动释放池

## 跨平台管理连接的模式变得一致

## 栈变量被初始化为nil

## 使用编译器标识来开启或禁用ARC

# 管理免费的桥接

## 编译器会负责处理从cocoa方法返回的CF对象

## 使用所有权关键字的转换函数参数

# 当转换一个项目时的常见问题

# 常见问题  

**我该如何考虑ARC？该在什么位置放置各种retain/release？**  
无需考虑在什么位置放置retain/release，你只需考虑你的应用程序算法即可。对于对象而言，只需要考虑"strong 和 weak"指针，对于对象关系，需要考虑循环引用的可能性。  
**我还需要为我的对象编写dealloc么？**  
可能需要。  
由于ARC并不会自动实现malloc/free，管理Core Foundation对象的生命周期，文件描述符等等，你依旧需要通过编写dealloc方法来释放相关资源。  

**循环引用在ARC中还是有可能么？**  

**block在ARC中是如何工作的？**  

**我可以使用Snow Leopard为OSX开发ARC程序么？**  
