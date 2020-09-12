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

无论哪种情况，都适用的默认的比较器方法 compare:。当使用age（NSNumber的实例）排序时，compare: 方法

## 指定自定义的比较器

## 必须的集合对象