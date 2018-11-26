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
block变量会持有一个对于blocks的引用。你可以使用一个类似声明一个指针函数的语法来声明它。只不过是使用^替代*。block类型会完全能够与其他的C类型系统进行交互操作。以下的block声明都是有效的变量声明：  

	void (^blockReturningVoidWithVoidArgument)(void);
	int (^blockReturningIntWithIntAndCharArguments)(int, char);
	void (^arrayOfTenBlocksReturningVoidWithIntArgument[10])(int);

blocks同样支持可变参数(...)。一个无参数的block必须指定void在参数列表当中。  
Blocks通过给予编译器全部的元数据集合来验证blocks的使用，传递给blocks的参数和返回值来达到完全类型安全的目的。你可以将block引用强制转换为任意类型的指针，反之亦然。不过，你不可以通过指针解引用操作符（*）来解引用一个block的引用——因为一个block的大小是无法在编译期间被计算的。  
你还能够创建blocks的类型——当你使用block作为一个签名在多处使用时，通常这么做是比较好的方法：  

	typedef float (^MyBlockType)(float, float);
 
	MyBlockType myFirstBlock = // ... ;
	MyBlockType mySecondBlock = // ... ;

## 创建一个Block
使用^操作符来标识一个block字面量表达式的开始。它可能跟随一个参数列表，被（）包含。block的函数体被{}所包含。以下例子定义了一个简单的block，并将其赋值给了一个之前定义的变量（oneFrom）——在这，block后面跟随一个正常的；，它代表一个C语句的结束。  

	float (^oneFrom)(float);
 
	oneFrom = ^(float aFloat) {
	    float result = aFloat - 1.0;
	    return result;
	};

若你不想显式的声明一个block表达式的返回值，它也能够自动的从block的内容进行推断。若返回值已经被推定，并且参数列表为void的话，那么你就可以省略（void）参数列表了。若当多个返回语句出现时，你必须将其完全匹配（如有必要，请使用强制转换）。
## 全局Blocks
在文件级别，你可以使用一个block作为全局字面量：  

	#import <stdio.h>
 
	int GlobalInt = 0;
	int (^getGlobalInt)(void) = ^{ return GlobalInt; };

# Blocks和变量
本文描述了blocks和变量之间的交互，包括内存管理。
## 变量的类型
在block对象的代码体当中，变量被以五种不同的方式对待。  
就像你从一个函数中获取一样，你可以引用三种标准类型的变量：  

* 全局变量，包括静态局部
* 全局函数（技术上来讲不算变量）
* 从闭包中获取的局部变量和参数

Blocks还同样支持两个其他类型的变量：  

1. 在函数级别的是__block变量。它在block当中（以及闭包当中）是可变的，并且如果有任何其他的block被拷贝到堆上，是受到保护的。 
2. const导入。

最终，在一个方法的实现中，blocks可能会引用一个OC实例变量——参见“对象和Block变量”。  
以下规则作用于block当中的变量的使用：  

1. 全局变量是可以访问的，包括存在在闭包词法范围内的静态变量。
2. 传递给block的参数也是可以访问的（就像传递给一个函数的参数一样）。
3. 存在在闭包词法范围内的栈变量（非静态）被当做const变量。当block表达式存在在程序中时，它们的值被获取到。在嵌套的blocks中，可以从最近的一层嵌套中获取值。
4. 存在在闭包词法范围内，并以__block存储修饰符来声明的变量能够提供引用和修改。任意修改都会反映在闭包词法范围中，包括其他blocks定义在相同的闭包词法范围内。在“__block存储类型”中有详细 讨论。
5. 在block词法范围中声明的局部变量，就跟在一个函数中的局部变量表现相同。每次调用block都会提供一份该变量的拷贝。这些变量既可以被用作const，也可以作为引用变量。

以下例子展示了局部非静态变量的使用：  

	int x = 123;
 
	void (^printXAndY)(int) = ^(int y) {
	 
	    printf("%d %d\n", x, y);
	};
	 
	printXAndY(456); // prints: 123 456

提示，若试图给block当中的x赋值一个新值会引发error：  

	int x = 123;
 
	void (^printXAndY)(int) = ^(int y) {
	 
	    x = x + y; // error
	    printf("%d %d\n", x, y);
	};

若要允许一个变量在block中被改变，你需要使用__block存储类型修饰符——参见“__block存储类型”。
## __block存储类型

你可以指定一个输入的变量为可变类型——意思就是可读写——通过设定__block存储类型标识符。__block标识符与register, auto, 和 static等存储类型符对于局部变量来说都类似，但又互相独立。  
__block 变量存在于存储中, 该存储在变量的词法范围与在变量的词法范围内声明或创建的所有block和block副本之间共享。因此, 如果在堆栈框架内声明的block的任何副本在框架结束后仍然存在, 那么储存将在堆栈框架的销毁中幸存下来（比如，通过加入队列来在以后执行）。在一个给定的词法范围内的多个blocks能够同时使用一个共享的变量。  
作为一种优化，block存储从堆栈开始——就像block本身一样。若block被使用Block_copy所拷贝（或者在OC当中当block被发送copy消息），变量将被拷贝到堆当中。因此，一个__block修饰的变量的地址可以随着时间的推移而更改。  
此外对于__block变量还有两个额外的限制：它不能是可变长度的数组，也不能是包含C99可变长度数组的结构。  
下例展示了__block变量的使用：  

	__block int x = 123; //  x lives in block storage
 
	void (^printXAndY)(int) = ^(int y) {
	 
	    x = x + y;
	    printf("%d %d\n", x, y);
	};
	printXAndY(456); // prints: 579 456
	// x is now 579

下例展示了blocks与集中类型的变量的交互：  

	extern NSInteger CounterGlobal;
	static NSInteger CounterStatic;
	 
	{
	    NSInteger localCounter = 42;
	    __block char localCharacter;
	 
	    void (^aBlock)(void) = ^(void) {
	        ++CounterGlobal;
	        ++CounterStatic;
	        CounterGlobal = localCounter; // localCounter fixed at block creation
	        localCharacter = 'a'; // sets localCharacter in enclosing scope
	    };
	 
	    ++localCounter; // unseen by the block
	    localCharacter = 'b';
	 
	    aBlock(); // execute the block
	    // localCharacter now 'a'
	}

## 对象和Block变量
Blocks为OC和C++的对象和其他blocks提供作为变量的支持。
### OC对象
当一个block被拷贝，对于block中使用的对象变量，block对其对创建一个强引用。若你在实现一个方法时使用到了block：  

* 若你通过引用访问一个实例变量，那么强引用作用于self；
* 若你通过值访问一个实例变量，强引用作用于变量本身。

下例展示了两种不同的情况：  

	dispatch_async(queue, ^{
	    // instanceVariable is used by reference, a strong reference is made to self
	    doSomethingWithObject(instanceVariable);
	});
	 
	 
	id localVariable = instanceVariable;
	dispatch_async(queue, ^{
	    /*
	      localVariable is used by value, a strong reference is made to localVariable
	      (and not to self).
	    */
	    doSomethingWithObject(localVariable);
	});

若要为特定的对象变量重写这一功能，你可以通过使用__block存储类型修饰符来达到。
### C++对象
通常你可以在一个block当中使用C++对象。在成员函数中，对于成员变量和函数的引用是通过隐式的引入this指针来进行的，因此显示为可变。若一个block被拷贝了，有两种情况将会发生：  

* 若你对于那些有基于栈的C++对象使用了__block存储类，那么通常在构造函数中使用copy。
* 若你在一个block中使用任何其他的基于栈的C++对象，那么必须有一个const copy构造函数。C++对象之后会使用该构造函数来进行拷贝。

### Blocks
当你拷贝一个block时，从该block当中引用的任何其他block如有必要都会被拷贝——整个树结构都可鞥呗拷贝（从顶部）。若你有一个block变量并且你对于block当中的block有引用，那么该block也会被拷贝。
# 使用Blocks
## 调用一个Block
若你将一个block声明为一个变量，你可以像使用函数一样使用它，如以下两个例子所示：  

	int (^oneFrom)(int) = ^(int anInt) {
	    return anInt - 1;
	};
	 
	printf("1 from 10 is %d", oneFrom(10));
	// Prints "1 from 10 is 9"
	 
	float (^distanceTraveled)(float, float, float) =
	                         ^(float startingSpeed, float acceleration, float time) {
	 
	    float distance = (startingSpeed * time) + (0.5 * acceleration * time * time);
	    return distance;
	};
	 
	float howFar = distanceTraveled(0.0, 9.8, 1.0);
	// howFar = 4.9

不过，你会经常将一个block作为一个参数传递给一个函数或方法。在这种情况下，你通常需要创建以block“内联”。
## 使用Block作为函数参数
你可以将一个block作为一个函数的参数进行传递，就跟你使用其他参数一样。不过，在大多数情况下，你无须声明block；你只需在需要它作为参数的地方直接以内联的方式实现即可。下例使用了qsort_b函数。qsort_b与标准的qsort_r函数类似，但带有一个block作为最后的参数。  

	char *myCharacters[3] = { "TomJohn", "George", "Charles Condomine" };
 
	qsort_b(myCharacters, 3, sizeof(char *), ^(const void *l, const void *r) {
	    char *left = *(char **)l;
	    char *right = *(char **)r;
	    return strncmp(left, right, 1);
	});
	// Block implementation ends at "}"
	 
	// myCharacters is now { "Charles Condomine", "George", "TomJohn" }

注意该block是包含在函数的参数列表中的。  
接下来的这个例子展示了如何使用dispatch_apply函数的block。dispatch_apply的声明如下：  

	void dispatch_apply(size_t iterations, dispatch_queue_t queue, void (^block)(size_t));

函数将一个block添加到一个分发队列中以供多次调用。它带有三个参数；第一个指定了要执行的迭代数量；第二个为block指定了要加入的一个队列；第三个就是block本身，它也带有一个参数——当前迭代的索引。  
你可以只使用dispatch_apply简单的打印迭代索引，如下：
	
	#include <dispatch/dispatch.h>
	size_t count = 10;
	dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
	 
	dispatch_apply(count, queue, ^(size_t i) {
	    printf("%u\n", i);
	});

## 使用Block作为方法参数

## 拷贝Blocks

## 要避免的模式

## 调试