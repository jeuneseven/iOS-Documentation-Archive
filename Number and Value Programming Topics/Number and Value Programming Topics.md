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

NSNumber是NSValue的子类，它提供

	NSInteger nine = 9;
	float ten = 10.0;
	 
	NSNumber *nineFromInteger = [NSNumber alloc] initWithInteger:nine];
	NSNumber *tenFromFloat = [NSNumber numberWithFloat:ten];



	NSNumber *nineFromInteger = @9;
	NSNumber *tenFromFloat = @10.0;
	NSNumber *nineteenFromExpression = @(nine + ten);

	NSComparisonResult comparison = [nineFromInteger compare:tenFromFloat];
	// comparison = NSOrderedAscending
	 
	float aFloat = [nineFromInteger floatValue];
	// aFloat = 9.0
	BOOL ok = [tenFromFloat boolValue];
	// ok = YES

	NSNumber *bigNumber = @(FLT_MAX);
	NSInteger badInteger = [bigNumber integerValue];
	NSLog(@"bigNumber: %@; badInteger: %d", bigNumber, badInteger);
	// output: "bigNumber: 3.402823e+38; badInteger: 0"

# 使用小数

## 小数的C语言接口

# 使用NSNull