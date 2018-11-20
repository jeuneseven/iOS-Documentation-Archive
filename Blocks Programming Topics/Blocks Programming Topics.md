[Blocks Programming Topics 原文链接](https://developer.apple.com/library/content/documentation/Cocoa/Conceptual/Blocks/Articles/00_Introduction.html#//apple_ref/doc/uid/TP40007502)

# 介绍
Block对象是一种C语言级别的句法和运行时功能。它和标准C的函数很像，但除了执行代码之外，它还包含变量绑定自动（栈）或手动（堆）内存。那么block就能够持有一组状态（数据），它能够在执行时用来影响行为。  
你可以使用blocks来组成函数表达式并可以传递给API，随意存储以及多线程使用。Blocks尤其适合用来作为回调，因为block同时带有回调时要执行的代码以及要执行时所需要的数据。  
Blocks在OS X v10.6 Xcode开发工具中的GCC和Clang自带。你可以在OS X v10.6和iOS4.0以及之后的版本中使用blocks。blocks运行时是开源的，且在“LLVM的编译器子项目仓库”中可以找到。Blocks同样出现在C标准工作组的“N1370: 苹果对于C的扩展”中。因为OC和C++同样都是从C派生出来的，blocks被设计用来同时支持三种语言（OC++也同样）。语法本身也体现了这一点。  
若要了解block对象是什么以及你如何从C，C++或者OC中使用它们，你需要阅读本文档。  
## 本文档的组织结构
本文档包含以下章节：  

* “从Blocks开始”提供了一个快速，实用的blocks介绍。
* “概念概览”提供了一个blocks概念的介绍。
* “声明和创建Blocks”展示了你如何声明一个block变量并如何实现它。
* “Blocks和变量”描述了blocks和变量之间的交互，并定义了__block存储类型标识符。
* “使用Blocks”阐述了各种使用范式。

# 从Blocks开始
以下章节会帮助你从使用一些实际示例来开始了解blocks。
## 声明和使用Block
你可以使用^操作符来声明一个block变量，它表示一个block字面量的开始。block本身包含在{}中，如下示例所示（与C语言一样；分号表示语句的结尾）：  

	int multiplier = 7;
	int (^myBlock)(int) = ^(int num) {
   		 return num * multiplier;
	};

该例展示了如下图所示：  

![](https://developer.apple.com/library/archive/documentation/Cocoa/Conceptual/Blocks/Art/blocks.jpg)  

注意block能够使用当前上下文定义的变量。  
若你声明一个block作为变量，你可以像使用一个函数一样使用它：  

	int multiplier = 7;
	int (^myBlock)(int) = ^(int num) {
   		 return num * multiplier;
	};
	printf("%d", myBlock(3));
	// prints "21"

## 直接使用Block
在很多情况下，你都无需声明block变量；你只需简单的根据需要写一个block字面量内联函数作为参数。以下示例使用了qsort_b函数。qsort_b与标准的qsort_r函数类似，不过它以一个block作为参数的结尾。  

	char *myCharacters[3] = { "TomJohn", "George", "Charles Condomine" };
 
	qsort_b(myCharacters, 3, sizeof(char *), ^(const void *l, const void *r) {
   		 char *left = *(char **)l;
	    char *right = *(char **)r;
   		 return strncmp(left, right, 1);
	});
 
	// myCharacters is now { "Charles Condomine", "George", "TomJohn" }

## Blocks与Cocoa
在Cocoa系统框架中有一些方法以block作为参数，通常来讲，要么它是用来执行一系列集合对象的操作，或者用来作为操作结束的回调。以下示例展示NSArray使用block的方法sortedArrayUsingComparator:示例。该方法使用了一个参数——block。为说明起见，该例的block定义为一个NSComparator局部变量。  

	NSArray *stringsArray = @[ @"string 1",
                           @"String 21",
                           @"string 12",
                           @"String 11",
                           @"String 02" ];
 
	static NSStringCompareOptions comparisonOptions = NSCaseInsensitiveSearch | NSNumericSearch |
	        NSWidthInsensitiveSearch | NSForcedOrderingSearch;
	NSLocale *currentLocale = [NSLocale currentLocale];
	 
	NSComparator finderSortBlock = ^(id string1, id string2) {
	 
	    NSRange string1Range = NSMakeRange(0, [string1 length]);
	    return [string1 compare:string2 options:comparisonOptions range:string1Range locale:currentLocale];
	};
	 
	NSArray *finderSortArray = [stringsArray sortedArrayUsingComparator:finderSortBlock];
	NSLog(@"finderSortArray: %@", finderSortArray);
	 
	/*
	Output:
	finderSortArray: (
	    "string 1",
	    "String 02",
	    "String 11",
	    "string 12",
	    "String 21"
	)
	*/

## __block变量
一个block的强大功能就是它可以修改同一个词法范围内的变量。你可以使用__block存储类型修饰符来标识该变量可以被修改。适配的示例展示在“Blocks与cocoa”一节中，如下例所示，你可以使用一个block变量来记录有多少个字符串进行了比较运算。在本例当中，block被直接使用，currentLocale作为一个只读变量存在在block中：  

	NSArray *stringsArray = @[ @"string 1",
                          @"String 21", // <-
                          @"string 12",
                          @"String 11",
                          @"Strîng 21", // <-
                          @"Striñg 21", // <-
                          @"String 02" ];
 
NSLocale *currentLocale = [NSLocale currentLocale];
__block NSUInteger orderedSameCount = 0;
 
NSArray *diacriticInsensitiveSortArray = [stringsArray sortedArrayUsingComparator:^(id string1, id string2) {
 
    NSRange string1Range = NSMakeRange(0, [string1 length]);
    NSComparisonResult comparisonResult = [string1 compare:string2 options:NSDiacriticInsensitiveSearch range:string1Range locale:currentLocale];
 
    if (comparisonResult == NSOrderedSame) {
        orderedSameCount++;
    }
    return comparisonResult;
	}];
	 
	NSLog(@"diacriticInsensitiveSortArray: %@", diacriticInsensitiveSortArray);
	NSLog(@"orderedSameCount: %d", orderedSameCount);
	 
	/*
	Output:
	 
	diacriticInsensitiveSortArray: (
	    "String 02",
	    "string 1",
	    "String 11",
	    "string 12",
	    "String 21",
	    "Str\U00eeng 21",
	    "Stri\U00f1g 21"
	)
	orderedSameCount: 2
	*/

“blocks和变量”中的讨论比这更详细。
# 概念概览
Block对象为你提供一种创建ad hoc体作为表达式的方式，这在C以及C衍生出的语言，比如OC和C++中都存在。在其他语言及环境中，一个block对象有事被称作“闭包”。而我们这里通常称作“blocks”，除非有标准C的block代码在词法范围内有混淆。  
## Block功能
一个block就是一个匿名的内联代码集合，它：  

* 像函数一样拥有一种类型的参数列表
* 拥有一个引用或声明的返回值
* 可以在其定义的范围内获取词法范围内的状态
* 可以可选的修改词法范围内的状态
* 可以与在同一个词法范围内的其他定义block共享修改功能
* 在词法范围即使已经销毁（栈空间）后依旧能够共享和修改状态

即使是传递给其他线程用来延迟执行的block（或者是其本身的线程和runloop）你可以对其进行拷贝操作。编译器和运行时会将所有从block中引用的变量为拷贝的block保护起来。虽然blocks对于C和C++也可用，block是作为一个OC对象存在的。  
## 使用
Blocks通常代表一段小的，自包含的代码。对于封装一段要并行执行的工作，或遍历集合中的元素，或作为其他操作执行完毕的回调尤其有用。  
Blocks作为一个传统回调函数的替代品有两个原因：  

1. 它能够让你在调用的地方就能够写稍后执行的代码并在方法实现的范围内。Blocks还会作为系统框架方法的参数。
2. 它能够让你访问局部变量。与那种需要执行操作时体现所有上下文信息的回调数据结构不同，你只需直接传递局部变量即可。

# 声明和创建Blocks

## 声明一个Block的引用

## 创建一个Block

## 全局Blocks

# Blocks和变量

## 变量的类型

## __block存储类型

## 对象和Block变量

### OC对象

### C++对象

### Blocks

# 使用Blocks

## 调用一个Block

## 使用Block作为函数参数

## 使用Block作为方法参数

## 拷贝Blocks

## 要避免的模式

## 调试