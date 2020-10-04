[String Programming Guide](https://developer.apple.com/library/archive/documentation/Cocoa/Conceptual/Strings/introStrings.html#//apple_ref/doc/uid/10000035i)  

# 简介

## 字符串编程指南简介

字符串编程指南描述了如何创建，检索，组合和绘制字符串。它还描述了字符集合，这能够让你在一组字符串中检索字符，以及扫描并转换数字到字符串或者反过来。  

### 谁应该读本文档

如果你需要直接操作字符串或字符集合的话，你就应该阅读本文档。

### 本文档组织结构

本文档包含以下文章：  

* 字符串：描述了Cocoa和Cocoa Touch中的字符串对象的特性。
* 创建和转换字符串对象：阐释了NSString 和其子类NSMutableString 创建和转换内容到不同的它们所支持的编码的方式。
* 格式化字符串对象：描述了如何格式化 NSString 对象。
* 字符串格式化指定符：描述了NSString 支持的 printf-类型的格式化符。
* 从文件读取字符串以及写入字符串到URL中：描述了如何从文件和URLs中读写字符串。
* 搜索，比较和排序字符串：描述了查找字符和字符串中的子串以及比较字符串的方法。
* 词组，段落和换行：描述了词组，段落和换行是如何判断的。
* 字符和字形群集：描述了你该如何将字符串分解为用户可识别的字符。
* 字符集合：解释了如何使用字符集合对象，以及如何使用 NSCharacterSet 方法来创建标准和自定义字符串集合。
* 扫描：描述了NSScanner对象，它能够解释并转换一个 NSString 对象中的字符为数字和字符值。
* 字符串代表的文件路径：描述了 NSString 方法将字符串操作作为文件系统路径。
* 绘制字符串：讨论了在 NSView 对象中，NSString 类的方法支持直接绘制。

### 另请参阅

更多信息，参考以下文档：  

* 属性字符串编程指南：与字符串编程指南密切相关。它提供了有关 NSAttributedString 对象的相关信息，它管理着属性的集合，比如字体、字距调整以及和字符串或单个字符相关的内容。
* 数据格式化指南：描述了如何使用对象来创建、解释和验证文本来格式化数据。
* 国际化和本地化指南：提供了你的项目中的有关本地化字符串的信息，包括如何格式化参数才能够排序等信息。
* Core Foundation 字符串编程指南：在Core Foundation中，讨论 Core Foundation 不公开类型 CFString，它是能够和NSString类直接桥接的。

# 字符串

字符串代表的是Cocoa和Cocoa Touch框架中的字符串。将字符串展示为对象能够让你在使用其他对象时使用字符串。它还提供了封装的好处，这样字符串对象就能够直接以字符数组的形式展现，并根据需要高效存储和编码来使用。  
一个字符串对象是作为一个Unicode字符数组来实现的（换句话说，是一个文本字符串）。一个不可变的字符串是一个在其创建随后就不能够改变的文本字符串。要创建并管理一个不可变字符串，使用 NSString 类。要构建并管理一个创建后能够改变的字符串，使用 NSMutableString。  
使用NSString和NSMutableString创建的对象称为字符串对象（或者，当不会造成混淆时，仅仅称作字符串）。术语C字符串是指标准C char * 类型。  
一个字符串对象是作为一个Unicode字符数组展示其本身的。你可以使用length方法来判断它包含多少个字符，使用characterAtIndex: 方法来检索一个特定的字符。这两个“原始”方法提供了一个字符串对象访问的基本功能。不过，大部分字符串的使用是在一个更高层次上的，字符串被看做一个单独的整体：一个字符串与另一个相比较，检索子串，串接它们为一个新的字符串等等。如果你需要一个字符一个字符的访问字符串对象，你必须理解Unicode字符编码——特别是与组合字符序列相关的问题。有关详细信息，请参阅：  

* Unicode标准，4.0联合版本。 Boston: Addison-Wesley, 2003. ISBN 0-321-18578-1.
* Unicode集合网址：http://www.unicode.org/.

# 创建和转换字符串对象

NSString和其子类NSMutableString提供了几种方法来创建字符串对象，大部分基于其支持的不同的字符编码。虽然字符串对象总是将其内容展示为Unicode字符，不过它也可以将其内容转换为或者从其他编码进行转换，比如7-bit ASCII, ISO Latin 1, EUC, 和 Shift-JIS。availableStringEncodings 类方法会返回支持的编码。在从一个C字符串转换或者从一个字符串对象转换的时候，你可以明确指定一种编码，或者使用默认的C字符串编码，这在平台间可能会有不同，它是由defaultCStringEncoding 类方法返回的。

## 创建字符串

最简单也最直接的在源代码中创建一个字符串对象等方式是使用OC的@"..."结构：  

	NSString *temp = @"Contrafibularity";

注意，当以这种方式创建一个字符串常量的时候，你应该使用的是UTF-8字符。你可以将实际的Unicode数据放在本地化文本的字符串中，如在NSString *hello = @"こんにちは"，你还可以在字符串中为非图形字符插入 \u 或者 \U。  
OC字符串常量是在编译时创建的，并且贯穿你的程序执行期间都会存在。编译器会根据每个模块使此类对象常量唯一，并且它们永远不会被释放。还可以像使用任何其他字符串一样将消息直接发送给一个常量字符串。  

	BOOL same = [@"comparison" isEqualToString:myString];

### 从C字符和数据转换NSString

要从一个C字符串来创建一个NSString对象的话，你可以使用类似 initWithCString:encoding: 的方法。你必须正确的指定C字符串的字符编码。类似的方法能够让你在不同的编码字符中创建字符串对象。initWithData:encoding: 方法能够让你从存储在NSData对象中的数据转换成NSString对象。  

	char *utf8String = /* Assume this exists. */ ;
	NSString *stringFromUTFString = [[NSString alloc] initWithUTF8String:utf8String];
 
	char *macOSRomanEncodedString = /* assume this exists */ ;
	NSString *stringFromMORString =
	            [[NSString alloc] initWithCString:macOSRomanEncodedString
	                              encoding:NSMacOSRomanStringEncoding];
	 
	NSData *shiftJISData =  /* assume this exists */ ;
	NSString *stringFromShiftJISData =
	            [[NSString alloc] initWithData:shiftJISData
	                              encoding:NSShiftJISStringEncoding];
	                              
下列示例是从一个包含UTF-8字符的NSString对象转换为ASCII数据，然后转换为一个NSString对象。
	unichar ellipsis = 0x2026;
	NSString *theString = [NSString stringWithFormat:@"To be continued%C", ellipsis];
	 
	NSData *asciiData = [theString dataUsingEncoding:NSASCIIStringEncoding allowLossyConversion:YES];
	 
	NSString *asciiString = [[NSString alloc] initWithData:asciiData encoding:NSASCIIStringEncoding];
	 
	NSLog(@"Original: %@ (length %d)", theString, [theString length]);
	NSLog(@"Converted: %@ (length %d)", asciiString, [asciiString length]);
	 
	// output:
	// Original: To be continued… (length 16)
	// Converted: To be continued... (length 18)

```
注意：NSString不用做任意字节序列的数据存储容器。有关这种类型的功能，请参阅NSData。
```

### 变量字符串

要创建一个变量字符串，通常使用 stringWithFormat: 或者 initWithFormat: 方法（对于本地化字符串，使用 localizedStringWithFormat: 方法）。这些方法以及它们类似的方法使用了一个格式化字符串作为模板来规范你提供的数据（字符串和其他对象，字符值等等）进行插入。支持的格式化指定符号在《格式化字符串对象》中有相关描述。  
你还可以从一个已经存在的字符串对象构建一个字符串，使用 stringByAppendingString: 和 stringByAppendingFormat: 方法通过添加一个字符串到另一个后面来创建一个新的字符串，后一个方法使用的是一个格式化的字符串。  

	NSString *hString = @"Hello";
	NSString *hwString = [hString stringByAppendingString:@", world!"];

### 展示给用户的字符串

当创建展示给用户的字符串时，你应该考虑你的应用程序的本地化的重要性。通常来讲，你应该避免直接通过代码创建用户可见的字符串。而是在你的代码中使用字符串作为本地字典的key，这就能支持用户偏好的语言的可见字符串了。通常来讲，这包含使用 NSLocalizedString 和其他类似的宏命令，见下述示例展示。  

	NSString *greeting = NSLocalizedStringFromTable
    (@"Hello", @"greeting to present in first launch panel", @"greetings");
    
更多关于你的应用程序的国际化信息，参见《国际化和本地化指南》。本地化字符串资源描述了如何在本地化字符串中工作以及重新排列变量参数。

## 组合和提取字符串

## 获取C字符串

## 转换摘要

# 格式化字符串对象

# 字符串格式化指定符

# 从文件读取字符串以及写入字符串到URL中

# 搜索，比较和排序字符串

# 词组，段落和换行

# 字符和字形群集

# 字符集合

# 扫描

# 字符串代表的文件路径

# 绘制字符串