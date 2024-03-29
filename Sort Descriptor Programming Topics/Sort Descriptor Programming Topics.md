[Sort Descriptor Programming Topics 原文链接](https://developer.apple.com/library/content/documentation/Cocoa/Conceptual/SortDescriptors/SortDescriptors.html#//apple_ref/doc/uid/10000174i)

# 介绍排序描述符

排序描述符指定了一个集合该如何对其元素对象进行排序。

## 概览

本编程话题包含以下文章：  

* 创建并使用排序描述符：描述了如何创建并使用排序描述符。  

# 创建并使用排序描述符  

排序描述符描述一个比较器用在排序一个集合对象的过程。你可以创建一个 NSSortDescriptor 的实例来指定属性的key来进行排序，而不管比较器应该是倒序还是正序。比较器还可以指定一个方法来在比较属性key值时使用，而不用使用默认的 compare: 方法。  
记住 NSSortDescriptor 并不对对象进行排序。它只是描述应该如何对对象进行排序。实际的排序还是被其他类做的，通常是NSArray 或 NSMutableArray。  

## 使用 NSSortDescriptor 指定排序

举例来说，我们假设我们有个数组（NSArray 的实例）包含一个自定义类的实例，Employee（满足集合对象要求中设置的要求）。Employee 类有一个雇员的姓名属性（都是NSString的实例），被雇的日期（NSDate 的实例）以及年龄（NSNumber 的实例）。  
我们第一个任务是返回一个使用年龄排序过的 NSArray 对象。清单 1 展示了如何创建一个 使用 age 来进行升序排列一个数组内容的 NSSortDescriptor 。  

清单1 使用 age 来对数组进行排序  

	NSSortDescriptor *ageDescriptor = [[NSSortDescriptor alloc] initWithKey:@"age" ascending:YES];
	NSArray *sortDescriptors = @[ageDescriptor];
	NSArray *sortedArray = [employeesArray sortedArrayUsingDescriptors:sortDescriptors];

要注意当对数组进行排序时要提供一个 NSSortDescriptor 的实例的数组。每个排序描述符都会按顺序进行应用，提供数组的意义是按照不同的属性key进行排序。  
如果我们还想要根据受雇的日期进行排序，我们可以添加另一个描述符给 sortedArrayUsingDescriptors: 调用。清单2列出了使用多个排序描述符进行排序，首先是根据年龄，然后年龄相同的话根据受雇日期进行排序。    

清单 2 使用 age和受雇日期key来对数组进行排序  

	NSSortDescriptor *ageDescriptor = [[NSSortDescriptor alloc] initWithKey:@"age" ascending:YES];
	NSSortDescriptor *hireDateDescriptor = [[NSSortDescriptor alloc] initWithKey:@"hireDate" ascending:YES];
	NSArray *sortDescriptors = @[ageDescriptor, hireDateDescriptor];
	NSArray *sortedArray = [employeesArray sortedArrayUsingDescriptors:sortDescriptors];

无论哪种情况，都适用的默认的比较器方法 compare:。当使用age（NSNumber的实例）排序时，使用NSNumber 实现的 compare: 方法。当使用受雇日期（值是NSDate的实例）进行排序时，使用的是 NSDate 的  compare: 方法。  
不过，如果我们要使用名字对于雇员进行排序的话，那么姓名是字符串类型的，结果应该根据字母进行排序，并且应该根据用户的本地信息，并且很可能不需要关心大小写。NSString 默认的 compare: 方法并没有做这些，所以我们应该指定一个自定义方法来实现比较。

## 指定自定义的比较器

之前的例子都是依赖于默认的 compare: 方法来根据年龄和雇佣日期进行排序。姓名是字符串类型，当你排序字符串并展示给用户时，你应该使用本地化比较方法（参见“字符串编程指南”中的搜索，比较和排序字符串部分）。通常你也可能要执行一种大小写不敏感的比较。清单3中的例子展示了如何指定一个合适的比较方法（localizedStandardCompare:）来通过姓名进行数组排序。

清单3 使用本地化标准比较方法来排序数组

	NSSortDescriptor *lastNameDescriptor = [[NSSortDescriptor alloc]
              initWithKey:@"lastName" ascending:YES selector:@selector(localizedStandardCompare:)];
	NSSortDescriptor * firstNameDescriptor = [[NSSortDescriptor alloc]
	              initWithKey:@"firstName" ascending:YES selector:@selector(localizedStandardCompare:)];
	NSArray *sortDescriptors = @[lastNameDescriptor, firstNameDescriptor];
	NSArray *sortedArray = [peopleArray sortedArrayUsingDescriptors:sortDescriptors];

Foundation 类有一些方法能够用来排序，参见表单1.

表单 1 常用Foundation类和比较方法

比较方法  | 支持的类
------------- | -------------
compare:  | NSString, NSMutableString, NSDate, NSCalendarDate, NSValue(仅支持标准类型和无符号chat型), NSNumber
caseInsensitiveCompare:  | NSString, NSMutableString
localizedCompare:  | NSString, NSMutableString
localizedCaseInsensitiveCompare:  | NSString, NSMutableString
localizedStandardCompare:  | NSString, NSMutableString

你可以添加一个复合比较方法（比如集合对象中所述）来提供对其类提供支持。

## 集合对象必备条件

为了能让集合能够使用 NSSortDescriptor 来对其内容进行排序，对象必须遵循以下内容：  

* 集合中的每个对象的属性都必须遵循KVC协议，这用来创建排序描述符（更多关于KVC的内容，参见“KVC编程指南”）。
* 制定属性key的对象，与集合中的每个对象有关，必须实现比较器方法来创建排序描述符。如果没有制定自定义的比较器，对象必须实现 compare:。
* 比较器必须传递一个参数，对象与自我进行比较，并且必须返回相应的 NSComparisonResult。

任何包含元素的排序的集合不遵循任意一条将会产生异常。