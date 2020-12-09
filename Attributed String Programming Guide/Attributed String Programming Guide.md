[Attributed String Programming Guide](https://developer.apple.com/library/archive/documentation/Cocoa/Conceptual/AttributedStrings/AttributedStrings.html#//apple_ref/doc/uid/10000036i)

# 简介

## 属性字符串编程指南简介

属性字符串编程指南描述了属性字符串对象，实例化的 NSAttributedString 类或者 CFAttributedString 的 Core Foundation 不公开类型，它管理着文字属性集合，比如字符间距，字体以及字符串相关或者单个字符。

### 谁应该阅读本文档

如果你直接操作属性字符串对象的话，你就应该阅读本文档。

### 本文档组织结构

本编程话题包含以下文章：  

* 属性字符串：描述了 NSAttributedString，NSMutableAttributedString，CFAttributedString和CFMutableAttributedString 的属性字符串实例对象。
* 在Cocoa中创建属性字符串：描述了如何通过你提供的数据创建属性字符串。
* 访问属性：描述了如何访问文本属性。
* 改变一个属性字符串：描述了如何改变一个属性字符串中的字符和属性。
* 绘制属性字符串：描述了如何在一个视图中绘制一个属性字符串。
* 富文本文件和属性字符串：阐释了如何从RTF数据中读写属性字符串，以及描述了Apple扩展RTF语言。
* 属性字符串中文字和行的计算：描述了如何在编辑器中与属性字符串协作。
* 标准属性：描述了全局 NSString 常量所包含的属性名。

### 另请参阅

更多信息，请参考以下文档：  

* 字符串编程指南：描述了在属性字符串中字符串对象处理Unicode字符的信息。
* 文字属性编程话题：阐释了文字系统处理不同类型的字符并应用到文本中的字符串中。

# 属性字符串

属性字符串对象管理着字符串和相关属性集合（例如字体和字符间距），用来调整每个字符或者在字符串范围内的字符。NSAttributedString 和 NSMutableAttributedString 类为只读属性字符串和可变属性字符串分别声明了编程接口。Foundation 框架定义了基本的功能，其他的OC方法定义在Application框架当中。Application框架还使用了一个NSMutableAttributedString的子类，叫做NSTextStorage，用来为扩展文本处理系统提供存储（参见“文本系统存储层概览”）。  
NSAttributedString 和 NSMutableAttributedString 在 Core Foundation 中分别有对应的桥接，CFAttributedString 和 CFMutableAttributedString。这意味着一个Foundation属性字符串是

# 在Cocoa中创建属性字符串

	NSFont *font = [NSFont fontWithName:@"Palatino-Roman" size:14.0];
	NSDictionary *attrsDictionary =
	        [NSDictionary dictionaryWithObject:font
	                                    forKey:NSFontAttributeName];
	NSAttributedString *attrString =
	    [[NSAttributedString alloc] initWithString:@"strigil"
	            attributes:attrsDictionary];

# 访问属性

## 检索属性值



## 有效和最大区间

	NSAttributedString *attrStr;
	unsigned int length;
	NSRange effectiveRange;
	id attributeValue;
	 
	length = [attrStr length];
	effectiveRange = NSMakeRange(0, 0);
	 
	while (NSMaxRange(effectiveRange) < length) {
	    attributeValue = [attrStr attribute:NSFontAttributeName
	        atIndex:NSMaxRange(effectiveRange) effectiveRange:&effectiveRange];
	    [analyzer tallyCharacterRange:effectiveRange font:attributeValue];
	}
	
	NSAttributedString *attrStr;
	NSRange limitRange;
	NSRange effectiveRange;
	id attributeValue;
	 
	limitRange = NSMakeRange(0, [attrStr length]);
	 
	while (limitRange.length > 0) {
	    attributeValue = [attrStr attribute:NSFontAttributeName
	        atIndex:limitRange.location longestEffectiveRange:&effectiveRange
	        inRange:limitRange];
	    [analyzer recordFontChange:attributeValue];
	    limitRange = NSMakeRange(NSMaxRange(effectiveRange),
	        NSMaxRange(limitRange) - NSMaxRange(effectiveRange));
	}

# 改变一个属性字符串

## 修改属性

## 修复不一致



# 绘制属性字符串

# 富文本文件和属性字符串

## 读写富文本数据

## 苹果的富文本扩展

# 格式化文档和属性字符串

## 读取格式化文档

## 处理文档属性

## 写格式化文档

## 处理附件

# 属性字符串中的词语和行计算

# 标准属性

列表1中所列的标识是全局 NSString 常量所包含的属性名称。值的类是该值相关属性的类。

列表1 标准属性列表

属性标识  | 值所属类  | 默认值
------------- | -------------------------- | -------------
NSAttachmentAttributeName  | NSTextAttachment  | none (no attachment)
NSBackgroundColorAttributeName  | NSColor  | none (no attachment)
NSBaselineOffsetAttributeName  | NSNumber，作为浮点型  | 0.0
NSFontAttributeName  | NSFont  | 黑体 12号
NSForegroundColorAttributeName  | NSColor  | black
NSKernAttributeName  | NSNumber，作为浮点型   | 0.0
NSLigatureAttributeName  | NSNumber，作为整形  | 1 (standard ligatures)
NSLinkAttributeName  | id  | none (no link)
NSParagraphStyleAttributeName  | NSParagraphStyle  | 返回 NSParagraphStyle 的 defaultParagraphStyle 方法
NSSuperscriptAttributeName  | NSNumber，作为整形  | 0
NSUnderlineStyleAttributeName  | NSNumber，作为整形  | none (no underline)

几个属性的性质从名称中看并不明显：  

* 