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

你可以通过多种方式组合和提取字符串。最简单的方式是将一个字符串拼接在另一个后面。stringByAppendingString: 方法会返回一个从接受者和给定参数格式化后的字符串对象。  

	NSString *beginning = @"beginning";
	NSString *alphaAndOmega = [beginning stringByAppendingString:@" and end"];
	// alphaAndOmega is @"beginning and end"

你还可以根据模板来拼接多个字符串：initWithFormat:, stringWithFormat:, 和 stringByAppendingFormat: 方法；这些在《格式化字符串对象》中有更详细的描述。  
你可以使用 substringToIndex:, substringFromIndex:, 和 substringWithRange: 
等方法从字符串的开始或者结束位置来指定一个特定的索引，或者指定一个区间来提取字符串。你还可以使用 componentsSeparatedByString: 方法来分割一个字符串为子串（基于一个分割字符串）。这些方法在后续示例中展示——注意基于索引的方法的索引开始为0：  

	NSString *source = @"0123456789";
	NSString *firstFour = [source substringToIndex:4];
	// firstFour is @"0123"
	 
	NSString *allButFirstThree = [source substringFromIndex:3];
	// allButFirstThree is @"3456789"
	 
	NSRange twoToSixRange = NSMakeRange(2, 4);
	NSString *twoToSix = [source substringWithRange:twoToSixRange];
	// twoToSix is @"2345"
	 
	NSArray *split = [source componentsSeparatedByString:@"45"];
	// split contains { @"0123", @"6789" }

如果你需要使用模式匹配而非索引的方式来提取字符串的话，你应该使用一个检索器——参见《检索器》。

## 获取C字符串

要从一个字符串对象获取C字符串，推荐使用UTF8String方法。这会返回一个使用 UTF8字符串编码的 const char *。  

	const char *cString = [@"Hello, world" UTF8String];

你所接收到的C字符串是被一个临时对象所持有的，在自动释放时将会失效。如果要获取永久的C字符串，则必须创建一个缓冲区并将方法返回的 const char *的内容拷贝过去。  
类似的方法能够让你在Unicode编码或者一个任意的编码中，从字符创建字符串对象，并且能够从这些编码中提取数据。initWithData:encoding: 和 dataUsingEncoding:会在NSData对象之间执行这些转换。  

## 转换摘要

这个表格概括了大部分常见的创建和装换字符串对象的意义：  

来源  | 创建方法 | 提取方法
------------- | ------------- | -------------
在代码中  | @"..."编译器结构 | 无
UTF8编码  | stringWithUTF8String: | UTF8String
Unicode编码  | stringWithCharacters:length: | getCharacters:getCharacters:range:
其他编码  | initWithData:encoding: | dataUsingEncoding:
已经存在的字符串  | stringByAppendingString:stringByAppendingFormat: | 无
格式化字符串  | localizedStringWithFormat:initWithFormat:locale: | 使用NSScanner
本地化字符串  | NSLocalizedString和类似方法 | 无

# 格式化字符串对象

本文描述了如何使用一个格式化的字符串来创建字符串，如何在一个格式化字符串中使用非ASCII字符，以及开发者在使用NSLog或NSLogv时的常见错误。  

## 格式化的基础

使用格式化的字符串的NSString的语法与其他格式化对象类似。它支持ANSI C 中 printf() 函数定义的格式化字符，加上%@支持任意对象（参见“字符串格式化指定符”和“IEEE打印指定符”）。若对象响应descriptionWithLocale: 消息，NSString会发送这样一个消息来检索文本陈述。否则，将会发送一个description 消息。本地化字符串资源描述了在本地化字符串中如何工作以及如何重新排列变量参数。  
在格式化的字符串中，一个“%”符号为一个值声明了一个占位符，该符号能够判断是需要什么类型的值以及如何格式化。举个例子，"%d houses"格式化字符串需要一个整形值来描述格式化表达式'%d'。NSString支持ANSI C的printf()函数定义的格式化字符，加上 ‘@’ 支持任意对象。若对象响应descriptionWithLocale: 消息，NSString会发送这样一个消息来检索文本陈述。否则，将会发送一个description 消息。本地化字符串资源描述了在本地化字符串中如何工作以及如何重新排列变量参数。  
值得格式化受用户当前位置影响，这是一个NSDictionary对象，指定了数字，日期，以及其他类型的格式。NSString对于小数分隔符只使用现场定义（名为NSDecimalSeparator的key给定）。如果你使用一个没有指定现场的方法，字符串会忽略默认现场。  
你可以使用NSString的 stringWithFormat: 方法和其他相关想法来创建 printf-类型 的格式化指定以及参数列表的字符串，在“创建和转换字符串对象”中有相关描述。能够用不同的格式化指定服和参数创建字符串的这些例子在下述展示。  

	NSString *string1 = [NSString stringWithFormat:@"A string: %@, a float: %1.2f",
	                                               @"string", 31415.9265];
	// string1 is "A string: string, a float: 31415.93"
	 
	NSNumber *number = @1234;
	NSDictionary *dictionary = @{@"date": [NSDate date]};
	NSString *baseString = @"Base string.";
	NSString *string2 = [baseString stringByAppendingFormat:
	        @" A number: %@, a dictionary: %@", number, dictionary];
	// string2 is "Base string. A number: 1234, a dictionary: {date = 2005-10-17 09:02:01 -0700; }"

## 字符串和非ASCII字符

你可以在一个字符串中使用类似 stringWithFormat: 和 stringWithUTF8String: 的方法来包含非ASCII字符（包括Unicode）。  

	NSString *s = [NSString stringWithFormat:@"Long %C dash", 0x2014];

\xe2\x80\x94是0x2014一个3个自己的UTF-8字符串，你也可以写成：  

	NSString *s = [NSString stringWithUTF8String:"Long \xe2\x80\x94   dash"];

## NSLog 和 NSLogv

工具函数 NSLog() 和 NSLogv() 使用了 NSString 字符串格式化服务来打印错误信息。注意这是一个结论，你应该在指定这些函数的参数时注意一些。一个常见的错误是指定一个字符串包含了格式化的字符，见后续示例。  

	NSString *string = @"A contrived string %@";
	NSLog(string);	
	// The application will probably crash here due to signal 10 (SIGBUS)

一个比较好的（安全的）使用格式化字符来输出其他字符串的方式，见后续示例。  

	NSString *string = @"A contrived string %@";
	NSLog(@"%@", string);
	// Output: A contrived string %@

# 字符串格式化指定符

本文概括了字符串格式化方法和函数支持的格式化指定符。  

## 格式化指定符

格式化指定符由遵循 IEEE printf 指定符号的 NSString格式化方法和CFString格式化函数所支持；指定符在列表1中概括。注意你可以使用 “n$” 位置指定符来指定类似 %1$@ %2$s。更多信息，参见 “IEEE printf 指定符号”。在NSLog函数中你也可以使用这些格式化指定符号。  

列表1 格式化指定符由遵循 IEEE printf 指定符号的 NSString格式化方法和CFString格式化函数所支持

指定符  | 描述
------------- | -------------
%@ | OC对象，如支持descriptionWithLocale:，打印它返回的字符串，否则打印 description。同样对CFTypeRef对象适用，返回CFCopyDescription函数所返回的结果。
%% | '%' 字符。
%d, %D  | 有符号32位整形（int）。
%u, %U | 无符号32位整形（unsigned int）。
%x | 无符号32位整形（unsigned int），打印使用0-9的数字和小写的a-f组成的十六进制。
%X | 无符号32位整形（unsigned int），打印使用0-9的数字和大写的A-F组成的十六进制。
%o, %O | 无符号32位整形（unsigned int），打印八进制。
%f | 64位浮点型数字（double）。
%e | 64位浮点型数字（double），使用小写e来引入指数，打印科学计数法。
%E | 64位浮点型数字（double），使用大写E来引入指数，打印科学计数法。
%g | 64位浮点型数字（double），如果指数小于-4或大于等于精度，则以%e的样式打印，否则以%f的样式打印。
%G | 64位浮点型数字（double），如果指数小于-4或大于等于精度，则以%E的样式打印，否则以%f的样式打印。
%c | 8位无符号字符（unsigned char）。
%C | 16位UTF-16代码集（unichar）。
%s | 8比特无符号字符组成的空端数组。由于%s指示符在系统默认编码中会将字符解释，结果能够为变量，尤其对于从右到左的语言。举例来说，对于从右到左的语言，%s在字符方向不强的时候回插入方向标记。由于这个原因，最好避免%s并显式的指定字符编码。
%S | 由16位UTF-16代码单元组成的空端数组。
%p | 空指针（void *），打印开头为0x，0-9和小写a-f组成的十六进制。
%a | 64位浮点型数字（double），以科学计数法打印，0x开头，并且是一个十六进制数字，在小数点前使用一个小写p来引入指数。
%A | 64位浮点型数字（double），以科学计数法打印，0X开头，并且是一个十六进制数字，在小数点前使用一个大写P来引入指数。
%F | 64位浮点型数字（double），以小数计数打印。
  
列表2 NSString格式化方法和CFString格式化函数支持的长度修饰符

长度修饰  | 描述
------------- | -------------
h  | 长度修饰符指定跟随的d, o, u, x, 或 X 转换指定，应用于short 或 unsigned short 参数。
hh | 长度修饰符指定跟随的d, o, u, x, 或 X 转换指定，应用于signed char 或 unsigned char 参数。
l | 长度修饰符指定跟随的d, o, u, x, 或 X 转换指定，应用于long 或 unsigned long 参数。
ll, q | 长度修饰符指定跟随的d, o, u, x, 或 X 转换指定，应用于long long或 unsigned long  long 参数。
L | 长度修饰符指定跟随的a, A, e, E, f, F, g, 或 G 转换指定，应用于long double 参数。
z | 长度修饰符指定跟随的d, o, u, x, 或 X 转换指定，应用于size_t 参数。
t | 长度修饰符指定跟随的d, o, u, x, 或 X 转换指定，应用于ptrdiff_t 参数。
j | 长度修饰符指定跟随的d, o, u, x, 或 X 转换指定，应用于intmax_t 或 uintmax_t 参数。

## 平台依赖

OSX使用了几种数据类型——NSInteger, NSUInteger,CGFloat, 和 CFIndex——来在32位和64位环境中提供一种固定值。在32位环境中，NSInteger 和 NSUInteger 分别被定义为int 和 unsigned int。在64位环境中，NSInteger 和 NSUInteger 分别被定义为long 和 unsigned long。为了避免会根据不同平台来使用不同的打印类型指定符，你可以使用列表3中的指定符。注意在某些情况下你需要注意值的强制转换。

列表3 数据类型的格式化指定符

类型  | 格式化指定符 | 注意事项
------------- | ------------- | -------------
 NSInteger | 	%ld 或者 %lx| 强制转换成long值。
NSUInteger | %lu 或者 %lx 	| 强制转换成unsigned long 值。
CGFloat | %f or %g | %f 当格式化时代表浮点型；但注意下述用于扫描时的技术。
CFIndex | %ld or %lx | 与NSInteger相同
pointer | %p or %zx | %p 会添加0x 到输出的开始。如果你不想要的话，使用%zx并且无类型转换。

下例展示了使用%ld来格式化一个NSInteger，以及强制转换的使用。

	NSInteger i = 42;
	printf("%ld\n", (long)i);
	
为了考虑列表3中提到的内容，在扫描时有一个额外的强制转换：你必须区分float和double类型。对于float使用%f，对于double使用%lf。如果你需要对CGFloat使用scanf（或其变体），请切换到double，然后将double 复制给CGFloat。  

	CGFloat imageWidth;
	double tmp;
	sscanf (str, "%lf", &tmp);
	imageWidth = tmp;

注意无论是32位或者64位平台，%lf不能够正确表示CGFloat。这不像%ld，它在所有情况下都代表long。

# 从文件读取字符串以及写入字符串到URL中

如果你知道源文件使用的编码方式，那么直接使用NSString提供的方法读取文件或者URL是最简单的——如果你不知道编码方式的话，那读取源文件就有些挑战了。当你向一个文件或者URL写入时，你必须指定使用的编码。（无论何时，你都应该使用URL，因为这是最高效的方式。）

## 从文件和URL中读取

NSString 提供了大量的方法来从文件和URL中读取数据。通常来讲，如果你知道编码方式的话，读取数据会很简单。如果你只有纯文本，并且不知道编码方式的话，那这就有些困难了。你应该尽可能不让自己处于这种位置——任何需要使用纯文本的文件都应该指定编码（最好是UTF-8 或 UTF-16+BOM）。  

### 根据已知的编码读取数据

对于已知编码的文件或者URL，在读取时你可以使用stringWithContentsOfFile:encoding:error: 或者 stringWithContentsOfURL:encoding:error: 方法，或者类似于init...的方法，如下例所示。  

	NSURL *URL = ...;
	NSError *error;
	NSString *stringFromFileAtURL = [[NSString alloc]
	                                      initWithContentsOfURL:URL
	                                      encoding:NSUTF8StringEncoding
	                                      error:&error];
	if (stringFromFileAtURL == nil) {
	    // an error occurred
	    NSLog(@"Error reading file at %@\n%@",
	              URL, [error localizedFailureReason]);
	    // implementation continues ...

你还可以使用数据对象初始化一个字符串，如下例所示。同样的，你必须指定正确的编码。

	NSURL *URL = ...;
	NSData *data = [NSData dataWithContentsOfURL:URL];
	 
	// Assuming data is in UTF8.
	NSString *string = [NSString stringWithUTF8String:[data bytes]];
	 
	// if data is in another encoding, for example ISO-8859-1
	NSString *string = [[NSString alloc]
	            initWithData:data encoding: NSISOLatin1StringEncoding];

### 根据未知编码读取数据

如果你发现你的文字是未知编码的，你最好确保有一种机制能够纠正错误。比如，Apple的邮件和浏览器应用有编码菜单，编辑器引用允许用户使用指定的编码重新打开文件。  
如果你不得不需要猜测编码（注意缺失明确信息时这是一种猜测）：  

1.尝试 stringWithContentsOfFile:usedEncoding:error: 或者 initWithContentsOfFile:usedEncoding:error: （或者是基于URL的同等方法）。这些方法会试图判断源的编码，如果成功了会返回引用所使用的编码。
2.如果1失败，尝试使用指定 UTF-8 作为编码来阅读源。
3.如果2失败，尝试一个适当的遗留编码。“适当”在这里会根据情况；可能是默认的C字符串编码，可能是ISO或者Windows Latin 1，或者其他的，根据你的数据从何而来。
4.最后，你可以尝试NSAttributedString 的Application Kit的加载方法（类似initWithURL:options:documentAttributes:error:）。这些方法会尝试加载纯文本文件，然后返回使用的编码。它们可以用于或多或少的任意文本文档，如果你的应用程序在文本方面没有特殊指定的话，可以考虑这么做。它们可能不适合于基础级的工具或者非自然语言文本的文档。  

## 写入文件和URL

和从一个文件或URL读取数据相比，写操作更为直接——NSString提供了两个方便的方法，writeToFile:atomically:encoding:error: 和 writeToURL:atomically:encoding:error:。你必须指定应该使用的编码，并且选择是否自动写入源。如果你选择不自动写入的话，字符串会直接写入你指定的路径。如果你选择自动写入，它会首先写入一个辅助文件，然后辅助文件会重命名为路径。这种方式会确保文件即使在系统写入时崩溃了也不会损坏，并确保文件的存在。如果你写入一个URL，如果目标不是一种能够自动访问存取的类型的话，自动的选项将被忽略。

	NSURL *URL = ...;
	NSString *string = ...;
	NSError *error;
	BOOL ok = [string writeToURL:URL atomically:YES
	                  encoding:NSUnicodeStringEncoding error:&error];
	if (!ok) {
	    // an error occurred
	    NSLog(@"Error writing file at %@\n%@",
	              path, [error localizedFailureReason]);
	    // implementation continues ...

## 概括总结

下表总结了从文件和URL中读写字符串对象的常用方法：  

来源  | 创建方法 | 提取方法
------------- | ------------- | -------------
URL内容中  | stringWithContentsOfURL:encoding:error: stringWithContentsOfURL:usedEncoding:error: | writeToURL:atomically:encoding:error:
文件内容中  | stringWithContentsOfFile:encoding:error: stringWithContentsOfFile:usedEncoding:error: | writeToFile:atomically:encoding:error:

# 搜索，比较和排序字符串

字符串类为在字符串中查找字符和子串以及比较字符串提供了方法。这些方法时遵循Unicode标准的，可以用来判断两个字符序列是否相等。字符串类提供比较方法用于正确处理组合字符序列，尽管当效率更重要的情况下，你可以选择指定文本搜索，并且可以保证组合字符序列的一些规范形式。  

## 搜索和比较方法

搜索和比较方法每个都有不同的变体。最简单的版本是整体搜索或比较字符串。其他变体能够让你筛选组成字符序列所执行的比较的方式以便制定一个特定的区间来对字符串进行搜索和比较；你还能够在一个给定的区域内的上下文中搜索和比较字符串。  
这些是基本的搜索和比较方法：  

搜索方法  | 比较方法
------------- | -------------
rangeOfString:  | compare:
rangeOfString:options:  | compare:options:
rangeOfString:options:range:  | compare:options:range:
rangeOfString:options:range:locale:  | compare:options:range:locale:
rangeOfCharacterFromSet:  | 
rangeOfCharacterFromSet:options:  | 
rangeOfCharacterFromSet:options:range:  | 

### 搜索字符串

在接收者中使用 rangeOfString:... 方法来检索一个子串。rangeOfCharacterFromSet:... 方法是从提供的一个字符集合中检索单独的字符。  
子串只会在完全包含在指定范围内才会被发现。如果你指定了一个区间来搜索或比较，但并没要求 NSLiteralSearch（见下文）的话，则该范围不得中断任意一端的组成字符序列。如果是这样，你会得到一个错误的结果。（请参阅 rangeOfComposedCharacterSequenceAtIndex: 的方法描述，对于调整范围以位于字符串序列边界上的代码示例）  
你还可以使用 NSScanner 的实例对象扫描一个字符串对象的数字和字符串值。更多关于扫描器的信息，参见“扫描器”。NSString和NSScanner类簇都使用的是NSCharacterSet类簇来进行搜索操作。更多关于字符集，参见“字符集”。  
如果你只是想要判断一个字符串是否包含一个给定的模式，你可以使用一个谓词：  

	BOOL match = [myPredicate evaluateWithObject:myString];

更多关于谓词，参见“谓词编程指南”。

### 比较和排序字符串

compare:... 方法返回接收方和提供的字符串的词法顺序。其他的几个方法能够让你判断两个字符串是否相等或者一个字符串是否是另一个字符串的前缀或后缀，但是它们并没有其他的变体让你能够制定搜索选项或者区间。  
compare: 是你能够用来比较字符串的最简单的方法——这和调用 compare:options:range: 时不传选项参数和接收方的范围与范围相同。如果你想要指定比较选项（NSCaseInsensitiveSearch， NSLiteralSearch 或 NSNumericSearch）你可以使用 compare:options:；如果你想指定本地化，你可以使用compare:options:range:locale:。NSString 也提供了一些变体的比较方便的方法来让你执行常见的比较而不用直接指定区间或选项，比如 caseInsensitiveCompare: 和 localizedCompare:。  

```
重要：对于用户可见的排序列表，你应该始终使用本地化排序。通常不要使用 compare: 或者 caseInsensitiveCompare:，你应该使用localizedCompare: 或者 localizedCaseInsensitiveCompare:。
```

如果你想要像在 Finder 中比较字符串那样的方式来比较字符串的话，你应该使用compare:options:range:locale: 并且使用用户的本地化和以下选项：NSCaseInsensitiveSearch，NSNumericSearch，NSWidthInsensitiveSearch和 NSForcedOrderingSearch。举例来说，参见“像 Finder 那样排序字符串”。

## 搜索和比较选项

几个搜索和比较方法带了一个“选项”参数。这是一个位掩码，为操作增加了进一步的约束。通过组合以下选项(并非所有选项都可用于每种方法)你可以创建掩码。

搜索选项  | 效果
------------- | -------------
NSCaseInsensitiveSearch  | 忽略字符串之间的大小写区别
NSLiteralSearch  | 执行字节级别的比较。不同的文本序列（比如组合的字符序列）将被视为等效的，否则将被视为不匹配。使用此选项可以显著加快某些操作的速度。
NSBackwardsSearch  | 执行从后到前的搜索。
NSAnchoredSearch  | 只在字符在开始处进行检索或者如果指定了NSBackwardsSearch，只在结尾处进行检索。在开始或结尾没有匹配意味着没有发现，即使是一个匹配的字符序列在字符串中的其他位置出现了。
NSNumericSearch  | 当使用compare:options: 方法时，对于比较而言，数字组合会被看做数字值。举例来说，Filename9.txt < Filename20.txt < Filename100.txt

当前执行搜索和比较就像指定了NSLiteralSearch选项一样。

## 示例
### 不关心大小写检索前缀和后缀

对于严格匹配前缀或者后缀而言，NSString提供了 hasPrefix: 和 hasSuffix: 方法来让你使用。以下的例子展示了你可以使用rangeOfString:options:方法并结合选项来执行不关心大小写的检索。

	NSString *searchString = @"age";
 
	NSString *beginsTest = @"Agencies";
	NSRange prefixRange = [beginsTest rangeOfString:searchString
	    options:(NSAnchoredSearch | NSCaseInsensitiveSearch)];
	 
	// prefixRange = {0, 3}
	 
	NSString *endsTest = @"BRICOLAGE";
	NSRange suffixRange = [endsTest rangeOfString:searchString
	    options:(NSAnchoredSearch | NSCaseInsensitiveSearch | NSBackwardsSearch)];
	 
	// suffixRange = {6, 3}

### 比较字符串

下例展示了不同的字符串比较方法的使用以及相关选项。第一个展示的是最简单的比较方法。

	NSString *string1 = @"string1";
	NSString *string2 = @"string2";
	NSComparisonResult result;
	result = [string1 compare:string2];
	// result = -1 (NSOrderedAscending)
	
你还可以使用NSNumericSearch选项来比较字符串中的数字。
	
	NSString *string10 = @"string10";
	NSString *string2 = @"string2";
	NSComparisonResult result;
	 
	result = [string10 compare:string2];
	// result = -1 (NSOrderedAscending)
	 
	result = [string10 compare:string2 options:NSNumericSearch];
	// result = 1 (NSOrderedDescending)

还可以使用方便的方法（caseInsensitiveCompare: 和 localizedCaseInsensitiveCompare:）执行不区分大小写的比较：

	NSString *string_a = @"Aardvark";
	NSString *string_A = @"AARDVARK";
	 
	result = [string_a compare:string_A];
	// result = 1 (NSOrderedDescending)
	 
	result = [string_a caseInsensitiveCompare:string_A];
	// result = 0 (NSOrderedSame)
	// equivalent to [string_a compare:string_A options:NSCaseInsensitiveSearch]

### 像Finder一样排序字符串

如果想要以OSX v10.6和以后版本中的Finder的方式来排序字符串的话，使用localizedStandardCompare: 方法。当文件名或其他字符串在列表或表单中展示时都可以使用。改方法准确的行为在不同的语言环境中不同，所以客户端不应该依赖于字符串的确切排序顺序。  
下例展示了另一个类似函数的实现，像在Finder中展示那样比较字符串并对它们进行排序，并且展示如何排序字符串数组。首先，定义了一个排序函数，它包含了相关比较选项（为提高效率，将用户的当前上下文传递过去——这种方式只需要查询一次）

	int finderSortWithLocale(id string1, id string2, void *locale)
	{
	    static NSStringCompareOptions comparisonOptions =
	        NSCaseInsensitiveSearch | NSNumericSearch |
	        NSWidthInsensitiveSearch | NSForcedOrderingSearch;
	 
	    NSRange string1Range = NSMakeRange(0, [string1 length]);
	 
	    return [string1 compare:string2
	                    options:comparisonOptions
	                    range:string1Range
	                    locale:(NSLocale *)locale];
	}
	
你可以传递函数作为参数给 sortedArrayUsingFunction:context: 并结合用户的当前区域作为上下文：  
	
	NSArray *stringsArray = @[@"string 1",
                          @"String 21",
                          @"string 12",
                          @"String 11",
                          @"String 02"];
 
	NSArray *sortedArray = [stringsArray sortedArrayUsingFunction:finderSortWithLocale
	                                     context:[NSLocale currentLocale]];
	 
	// sortedArray contains { "string 1", "String 02", "String 11", "string 12", "String 21" }

# 词组，段落和换行

本文描述了词语和段落的边界是如何定义的，换行是如何表达的，以及你该如何通过段落来分割字符串。  

## 词语的边界

文本系统在一个特定语言方式中判断一个词语的边界是根据“ Unicode Standard Annex #29”和额外的该文档中描述的自定义信息来判断的。在OS X上，Cocoa提供了有关词组边界的Api，比如NSAttributedString 方法的 doubleClickAtIndex: 和 nextWordFromIndex:forward:，但是你不能够修改词语边界算法本身工作的方式。  

## 行和段落分隔符

可以通过多种方式来表示行或段落中断。在过去，使用\n, \r, 和 \r\n。Unicode定义了一个明确的段落分隔符U+2029（其中Cocoa提供了常量NSParagraphSeparatorCharacter），以及一个明确的行分隔符，U+2028（Cocoa提供了常量NSLineSeparatorCharacter）。  
在Cocoa文本系统中，NSParagraphSeparatorCharacter始终被当作段落中断来对待，NSLineSeparatorCharacter始终作为一行中断而非段落中断来对待——意思就是，一行中断在一个段落中。

## 通过段落分隔字符串

通常要达到分隔字符串的效果是使用分隔符，直接这么使用：  

	NSArray *arr = [myString componentsSeparatedByString:@"\n"];



	NSString *string = /* assume this exists */;
	NSRange range = NSMakeRange(0, string.length);
	[string enumerateSubstringsInRange:range
	                           options:NSStringEnumerationByParagraphs
	                        usingBlock:^(NSString * _Nullable paragraph, NSRange paragraphRange, NSRange enclosingRange, BOOL * _Nonnull stop) {             // ... }];

# 字符和字形群集

# 字符集合

NSCharacterSet 对象代表Unicode字符集合。NSString和NSScanner对象使用NSCharacterSet对象来组合字符并用来进行检索操作，以便在搜索过程中查找到任意特定字符集合。

## 字符集合基础

一个字符集合对象代表一个Unicode字符集合。字符集合由一个类簇的实例对象代表。类簇由两个公共类NSCharacterSet 和 NSMutableCharacterSet，分别声明的编程接口为不可变和可变字符集合。不可变字符集合当其被定义创建之后，随后就不能改变了。可变字符集合能够在其呗创建后改变。  
字符集对象不能执行任何任务；它只能直接持有一个字符值集合来限制对字符串的操作。NSString 和 NSScanner类定义的方法会将 NSCharacterSet 对象作为参数用来查找任意字符。例如，以下代码查找

	NSString *myString = @"some text in an NSString...";
	NSCharacterSet *characterSet = [NSCharacterSet uppercaseLetterCharacterSet];
	NSRange letterRange = [myString rangeOfCharacterFromSet:characterSet];

## 创建字符集

	NSMutableCharacterSet *workingSet = [[NSCharacterSet alphanumericCharacterSet] mutableCopy];
	[workingSet addCharactersInString:@";:,."];
	NSCharacterSet *finalCharacterSet = [workingSet copy];
	
	UniChar chars[] = {0x000C, 0x2028};
	NSString *string = [[NSString alloc] initWithCharacters:chars
	                            length:sizeof(chars) / sizeof(UniChar)];
	NSCharacterSet *characterSet = [NSCharacterSet characterSetWithCharactersInString:string];


## 性能考量

## 创建一个字符集文件

	NSData *charSetRep = [finalCharacterSet bitmapRepresentation];
	NSURL *dataURL = <#URL for character set#>;
	NSError *error;
	BOOL result = [charSetRep writeToURL:dataURL options:NSDataWritingAtomic error:&error];

## 标准字符集和Unicode定义

# 扫描器

NSScanner 对象可以扫描一个NSString对象的字符，通常解释字符并将其转换为数字和字符串值。在创建时分配扫描器的字符串，扫描程序在请求项目时从头到尾完成该字符串的字符扫描。

## 创建扫描器

NSScanner 是一个有着单一公共类的类簇，NSScanner。通常来讲，通过调用类方法scannerWithString: 或者 localizedScannerWithString:来初始化一个扫描器对象。每个方法都会返回一个用你传给它的字符串初始化的扫描器对象。新创建的扫描器会从字符串的开始进行扫描。你可以使用 scan... 方法，比如 scanInt:, scanDouble:, 和 scanString:intoString: 来扫描组件。如果你扫描多行的话，通常需要创建一个while循环来查找，直到扫描器到达字符串的尾部，如下列代码片段所示：  
	
	float aFloat;
	NSScanner *theScanner = [NSScanner scannerWithString:aString];
	while ([theScanner isAtEnd] == NO) {
	 
	    [theScanner scanFloat:&aFloat];
	    // implementation continues...
	}

你可以使用 setCaseSensitive: 方法来配置一个扫描器，考虑或者忽略大小写。默认的一个扫描器是狐女大小写的。

## 使用扫描器



	137 small cases of bananas


	NSString *bananas = @"137 small cases of bananas";
	NSString *separatorString = @" of";
	 
	NSScanner *aScanner = [NSScanner scannerWithString:bananas];
	 
	NSInteger anInteger;
	[aScanner scanInteger:&anInteger];
	NSString *container;
	[aScanner scanUpToString:separatorString intoString:&container];
	
	[aScanner scanString:separatorString intoString:NULL];
	NSString *product;
	product = [[aScanner string] substringFromIndex:[aScanner scanLocation]];
	// could also use:
	// product = [bananas substringFromIndex:[aScanner scanLocation]];

## 示例

假设你有一个字符串包含了几行例如：  

Product: Acme Potato Peeler; Cost: 0.98 73  
Product: Chef Pierre Pasta Fork; Cost: 0.75 19  
Product: Chef Pierre Colander; Cost: 1.27 2

下例使用了替代扫描操作

	NSString *string = @"Product: Acme Potato Peeler; Cost: 0.98 73\n\
	Product: Chef Pierre Pasta Fork; Cost: 0.75 19\n\
	Product: Chef Pierre Colander; Cost: 1.27 2\n";
	NSCharacterSet *semicolonSet;
	NSScanner *theScanner;
	 
	NSString *PRODUCT = @"Product:";
	NSString *COST = @"Cost:";
	
	NSString *productName;
	float productCost;
	NSInteger productSold;
	 
	semicolonSet = [NSCharacterSet characterSetWithCharactersInString:@";"];
	theScanner = [NSScanner scannerWithString:string];
	
	while ([theScanner isAtEnd] == NO)
	if ([theScanner scanString:PRODUCT intoString:NULL] &&
        [theScanner scanUpToCharactersFromSet:semicolonSet
            intoString:&productName] &&
        [theScanner scanString:@";" intoString:NULL] &&
        [theScanner scanString:COST intoString:NULL] &&
        [theScanner scanFloat:&productCost] &&
        [theScanner scanInteger:&productSold]) {
			NSLog(@"Sales of %@: %1.2f", productName, productCost * productSold);
        }
	}

## 本地化

一个扫描器会基于一个地理位置来进行扫描行为，地理位置指定了语言和值所代表的惯例。NSScanner 会只使用十进制分隔符（由名为NSDecimalSeparator的key给出）区域设置的定义。你可以使用用户的位置（通过使用localizedScannerWithString:）来创建一个扫描器，或者使用setLocale:来显式的设置位置。如果使用不指定位置的方法，扫描器将假定默认位置值为默认地址。

# 字符串代表的文件路径

## 代表一个路径

	NSString *path = @"/usr/bin/./grep";
	NSString *standardizedPath = [path stringByStandardizingPath];
	// standardizedPath: /usr/bin/grep
	 
	path = @"~me";
	standardizedPath = [path stringByStandardizingPath];
	// standardizedPath (assuming conventional naming scheme): /Users/Me
	 
	path = @"/usr/include/objc/..";
	standardizedPath = [path stringByStandardizingPath];
	// standardizedPath: /usr/include
	 
	path = @"/private/usr/include";
	standardizedPath = [path stringByStandardizingPath];
	// standardizedPath: /usr/include


## 用户目录

	// Assuming that users’ home directories are stored in /Users
 
	NSString *meHome = [@"~me" stringByExpandingTildeInPath];
	// meHome = @"/Users/me"
	 
	NSString *mePublic = [@"~me/Public" stringByExpandingTildeInPath];
	// mePublic = @"/Users/me/Public"


	NSString *currentUserHomeDirectory = NSHomeDirectory();
	NSString *meHomeDirectory = NSHomeDirectoryForUser(@"me");


	NSString *documentsDirectory =
                [NSHomeDirectory() stringByAppendingPathComponent:@"Documents"];

## 路径组件

## 文件名补全

	NSString *partialPath = @"~/Demo/r";
	NSString *longestCompletion;
	NSArray *outputArray;
	 
	unsigned allMatches = [partialPath completePathIntoString:&longestCompletion
	    caseSensitive:NO
	    matchesIntoArray:&outputArray
	    filterTypes:nil];
	 
	// allMatches = 3
	// longestCompletion = @"~/Demo/re"
	// outputArray = (@"~/Demo/readme.html", "~/Demo/readme.rtf", "~/Demo/recondite.txt")


	NSArray *filterTypes = @[@"txt", @"rtf"];
 
	unsigned textMatches = [partialPath completePathIntoString:&outputName
	    caseSensitive:NO
	    matchesIntoArray:&outputArray
	    filterTypes:filterTypes];
	// allMatches = 2
	// longestCompletion = @"~/Demo/re"
	// outputArray = (@"~/Demo/readme.rtf", @"~/Demo/recondite.txt")


# 绘制字符串

在一个NSView钟使用类似 drawAtPoint:withAttributes: 的方法，你可以直接绘制字符串对象（要绘制多种属性比如多行文本字体的字符串，你必须使用 NSAttributedString 对象）。这些方法在《Cocoa绘制指南》中的“文本”中有简单描述。