[Value Transformer Programming Guide](https://developer.apple.com/library/archive/documentation/Cocoa/Conceptual/ValueTransformers/ValueTransformers.html#//apple_ref/doc/uid/10000175i)

# 介绍

值转换器描述了 NSValueTransformer 类，它内置了值转换器并且告诉你如何编写你自己的子类。值转换器主要用于控制层绑定。  

## 谁应该阅读本文档 

如果你在应用中使用Cocoa绑定，你应该阅读本文档来获取并理解值转换器的使用。如果你希望熟悉Cocoa开发的基本原理，包含OC语言和内存管理的话，也应该阅读本文档。

## 本文档的组成

本编程话题包含以下文章：  

* 值转换器的作用 提供了值转换器的概览。
* 值转换器的可用 描述了由Foundation框架提供的值转换器。
* 编写一个自定义的值转换器 描述了如何实现一个值转换器的子类。
* 注册一个值转换器 描述了如何注册你自己的值转换器。

# 值转换器的作用

值转换器类时用来在某些情况下将一个对象的值进行转换的。这在使用Cocoa绑定和创建一个控制器模型属性和用户界面元素（或者其他控制器对象）之间的绑定关系时非常有用。通过使用内置的值转换器，或者创建自定义的值转换器，可以大大减少你的应用中的胶水代码。  
举例来说，如果一个模型对象的属性为nil时，通常需要禁止一个用户界面元素的交互。与其写一个方法判断属性为nil返回yes，你还不如说明使用一个"非空"转换器的绑定。转换器扮演的是中间人的角色，如果属性为nil的话，提供Yes值给那个用户界面元素。  
值转换器在一个值传给一个界面元素的 setObjectValue: 方法时会被立即执行。同样的，反向转换器在值通过用户界面设置模型时也会被应用。参见《Cocoa绑定编程主题》中的“绑定消息流”一节的详细信息来了解何时值转换器会应用在Cocoa绑定上下文当中。  
所有的值转换器都是 NSValueTransformer 的子类。为了给子类提供抽象方法，NSValueTransformer类维护了一个值转换器名和相对应的值转换器对象的字典。这个名称用在界面编辑器中来指定用来绑定的值转换器。你可以注册你自己的自定义值转换器的实例来暴露它们，允许它们被界面编辑器中的Cocoa绑定来使用。  
一个值转换器是可以被撤销的，允许从一个值转换成一个新值，并可以反向操作。一个可撤销的值转换器可以被看做是“可读写”的，它会转换原始的属性值，但是也会返回任何导致转换值的改变。一个不可撤销的转换器是“只读”的，只能够反应原始属性的改变。

# 值转换器的可用

为了提供一种机制来注册你自己的值转换器，NSValueTransformer 提供了几种内置的转换器。  
内置的转换器提供用于否定布尔值、测试零值或非零值以及将值存档和取消存档到NSData实例中的设施。

## NSNegateBooleanTransformerName

NSNegateBooleanTransformerName 值转换器会返回一个包含布尔值的 NSNumber 的实例对象。返回值是一个原值的反向布尔值，并且可逆。  
这个值转换器在开启或禁用用户界面元素时很有用，以及在设置选项按钮或单选按钮时也有用。

## NSIsNilTransformerName

NSIsNilTransformerName 值转换器会返回一个包含布尔值的 NSNumber 的实例对象。如果原值为 nil的话，那么返回值就是YES，否则返回值为NO。这个值转换器不可逆。  
这个值转换器通常用在开启或禁用用户界面元素上。  

## NSIsNotNilTransformerName

NSIsNotNilTransformerName 值转换器会返回一个包含布尔值的 NSNumber 的实例对象。如果原值不为nil，那么返回YES，否则返回NO。这个值转换器不可逆。  
这个值转换器通常用在开启或禁用用户界面元素上。  

## NSUnarchiveFromDataTransformerName

NSUnarchiveFromDataTransformerName 转换器会返回一个从 NSData 对象解档数据并当做值传递的对象。反向的转换器会返回一个被归档数据创建的 NSData 实例。  
一个对象必须实现 NSCoding 协议，使用序列化归档以便使用这个转换器来归解档。  
这个转换器主要与 NSUserDefaultsController实例一起使用。这个转换器允许你的应用存储对象在用户默认设置中，并且是本身不默认支持的类型，比如NSColor对象。

## NSKeyedUnarchiveFromDataTransformerName

NSKeyedUnarchiveFromDataTransformerName 转换器会返回一个从 NSData 对象解档数据并当做值传递的对象。反向的转换器会返回一个被归档数据创建的 NSData 实例。 
该转换器与 NSUnarchiveFromDataTransformerName 转换器不同在于对象必须使用键值归档而非序列归档来实现 NSCoding 协议。  
这个转换器主要与 NSUserDefaultsController实例一起使用。这个转换器允许你的应用存储对象在用户默认设置中，并且是本身不默认支持的类型，比如NSColor对象。

# 注册一个值转换器

当在界面编辑器上创建一个绑定时，你可以指定一个值转换器作为一个“中间人”。为了你自定义的值转换器对象能够以这种方式使用，它们必须首先以名字注册。

## 注册一个自定义值转换器

## 在界面编辑器中可用

# 编写一个自定义的值转换器

## 声明一个返回值的类

## 允许反向转换

## 转换值

## 反向转换值