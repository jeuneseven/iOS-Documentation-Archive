[Number and Value Programming Topics](https://developer.apple.com/library/archive/documentation/Cocoa/Conceptual/NumbersandValues/NumbersandValues.html#//apple_ref/doc/uid/10000038i)

# 介绍数字和其他值

本话题描述了封装原始C语言数据类型的对象，它由NSValue实现，以及它的子类NSNumber和NSDecimalNumber实例对象，和NSNull的实例用来表示一个空值。  

## 本文档的组织结构

本文档包含以下文章：  

* 使用值 描述了常见值类型。
* 使用数字 描述了标量。
* 使用小数 描述了用在十进制运算的对象。
* 使用NSNull 描述了NSNull实例的使用。

# 使用值

NSValue对象是一个C语言或者OC数据元素简单的容器。它能够包含人意标准类型，比如int, float, 和 char，也包含指针，结构体和对象id等。该类的目的是让类似数据类型的元素能够呗添加到类似 NSArray 或 NSSet的集合对象中，集合需要元素必须是对象。NSValue 对象始终是不可变的。  
要使用一个特定的数据元素来创建NSValue 对象，你需要提供一个指向该元素的指针并在OC类型编码中结合一个C字符串描述元素的类型。获取该字符串要使用@encode()编译指令，它会返回特定平台的编码的给定类型（参见“类型编码”了解更多@encode()详情以及类型编码的列表）。举例来说，创建theValue的代码引用中包含NSRange：  

	NSRange myRange = {4, 10};
	NSValue *theValue = [NSValue valueWithBytes:&myRange objCType:@encode(NSRange)];

以下示例代码展示了编码一个自定义C结构体。  

	// assume ImaginaryNumber defined:
	typedef struct {
	    float real;
	    float imaginary;
	} ImaginaryNumber;
	 
	 
	ImaginaryNumber miNumber;
	miNumber.real = 1.1;
	miNumber.imaginary = 1.41;
	 
	NSValue *miValue = [NSValue valueWithBytes: &miNumber
	                            withObjCType:@encode(ImaginaryNumber)];
	 
	ImaginaryNumber miNumber2;
	[miValue getValue:&miNumber2];

你所指定的类型必须是恒定长度的。不能够存储C字符串，可变长度数组和结构体，以及其他的不能在NSValue中判断长度的数据类型——必须使用NSString 或者 NSData 对象来对这些类型进行封装。可以存储指针指向NSValue 对象中可变长度的元素。下列代码展示了错误的方式，要取代一个NSValue 对象中的C字符串：  

	/* INCORRECT! */
	char *myCString = "This is a string.";
	NSValue *theValue = [NSValue valueWithBytes:myCString withObjCType:@encode(char *)];

在这个代码引用中，myCString的内容可以理解为指向一个char的指针，所以字符串的头四个字节会被视为一个指针（实际使用的字节数量可能会在不同的硬件架构上不同）。也就是说，序列“this”被解释为指针值，它不太可能是一个合法的地址。存储此类数据元素的正确方式是用一个NSString对象（如果你需要一个包含字符的对象的话），或者传递地址给其指针，而非指针本身：  

	/* Correct. */
	char *myCString = "This is a string.";
	NSValue *theValue = [NSValue valueWithBytes:&myCString withObjCType:@encode(char **)];

这就是 myCString 的地址传递（&myCString），所以字符串第一个字符的地址存储在 theValue 中。  

```
重要：NSValue 对象不能够拷贝字符串的内容，但能够拷贝指针本身。如果你用一个分配了的数据元素创建了一个NSValue 对象，不要在NSValue 对象还存在的时候释放数据的内存。  
```

# 使用数字

NSNumber是NSValue的子类，它能够提供任何C标量类型的值。它为创建数字对象和访问这些值（signed 或 unsigned char, short int, int, NSInteger, long int, long long int, float, 或 double, 或 BOOL）定义了一系列的方法。  

	NSInteger nine = 9;
	float ten = 10.0;
	 
	NSNumber *nineFromInteger = [NSNumber alloc] initWithInteger:nine];
	NSNumber *tenFromFloat = [NSNumber numberWithFloat:ten];

你可以使用字面量@来直接创建一个数字对象：

	NSNumber *nineFromInteger = @9;
	NSNumber *tenFromFloat = @10.0;
	NSNumber *nineteenFromExpression = @(nine + ten);

NSNumber定义了一个 compare: 方法来判断两个NSNumber对象的大小：  

	NSComparisonResult comparison = [nineFromInteger compare:tenFromFloat];
	// comparison = NSOrderedAscending
	 
	float aFloat = [nineFromInteger floatValue];
	// aFloat = 9.0
	BOOL ok = [tenFromFloat boolValue];
	// ok = YES

一个NSNumber对象会记录它所创建的数字类型，并在比较NSNumber对象的不同数字类型以及返回值是C数字类型时使用C语言规则。参见标准C参考了解类型转换的详情。（不过，如果你请求一个数字的objCType，返回值类型不一定会与创建接收方的方法匹配。）  
如果你使用一个不能够保留值的类型请求一个NSNumber对象，你会得到一个错误的结果——举例来说，如果你请求一个创建时是double，并比FLT_MAX大的float值的话，或者请求一个创建时是float，比NSInteger的最大值要大的integer值。

	NSNumber *bigNumber = @(FLT_MAX);
	NSInteger badInteger = [bigNumber integerValue];
	NSLog(@"bigNumber: %@; badInteger: %d", bigNumber, badInteger);
	// output: "bigNumber: 3.402823e+38; badInteger: 0"

# 使用小数

NSDecimalNumber 是一个 NSNumber 类的不可变子类，它提供了基于十进制的运算的面向对象封装。一个实例可以表现为mantissa x 10 exponent的表达式，可以表示任何数字，尾数部分是一个最长38位的小数，指数是一个-128到127之间的整数。  
由于是做算术运算，方法可能会产生计算错误，比如除以0。也可能会遇到需要选择取整的情况。方法在此处表现的行为被称作“behavior”。  
行为是在NSDecimalNumberBehaviors协议的方法设置的。每个NSDecimalNumber参数被称作behavior，需要一个遵循这个协议的对象。更多行为，参见NSDecimalNumberBehaviors 协议和NSDecimalNumberHandler 类的规范。另外查看defaultBehavior 方法的描述。  

## 小数的C语言接口

你可以通过NSDecimalNumber的一组C函数访问算数和取整方法：  

NSDecimalAdd	
NSDecimalCompact	
NSDecimalCompare	
NSDecimalCopy	
NSDecimalDivide	  
NSDecimalIsNotANumber	
NSDecimalMultiply	
NSDecimalMultiplyByPowerOf10	
NSDecimalNormalize	
NSDecimalPower	
NSDecimalRound	
NSDecimalString	  
NSDecimalSubtract  

如果你不需要将小数看作对象，你可能需要参考C语言接口——意思是，如果你不需要将它们存储到一个类似NSArray 或者 NSDictionary的实例的面向对象的集合中的话。如果你需要最大限度的发挥作用的话，你可能也要考虑C语言接口。C语言接口更快，并且相比较NSDecimalNumber 类使用更少的内存。  
如果你需要可变性，就要将两个接口结合。使用C语言接口的函数并将其结果转换为NSDecimalNumber的实例。  

# 使用NSNull

NSNull类定义了一个单例对象，你可以用它在禁止使用nil作为一个值的地方来表示一个null值（通常是在一个数组或者字典的集合对象中）。

	NSNull *nullValue = [NSNull null];
	NSArray *arrayWithNull = @[nullValue];
	NSLog(@"arrayWithNull: %@", arrayWithNull);
	// Output: "arrayWithNull: (<null>)"

理解NSNull实例从字面上与NO 或 false不同很重要——都是代表一个逻辑值；NSNull实例代表没有值。NSNull实例从字面量与nil相等，不过要理解它与nil也不相等。要测试一个null对象的值，你必须做一个对象的比较。  

	id aValue = [arrayWithNull objectAtIndex:0];
	if (aValue == nil) {
	    NSLog(@"equals nil");
	}
	else if (aValue == [NSNull null]) {
	    NSLog(@"equals NSNull instance");
	    if ([aValue isEqual:nil]) {
	        NSLog(@"isEqual:nil");
	    }
	}
	// Output: "equals NSNull instance"
