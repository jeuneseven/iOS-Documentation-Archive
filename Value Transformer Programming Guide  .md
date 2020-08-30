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

# 值转换器的可用

## NSNegateBooleanTransformerName

## NSIsNilTransformerName

## NSIsNotNilTransformerName

## NSUnarchiveFromDataTransformerName

## NSKeyedUnarchiveFromDataTransformerName

# 注册一个值转换器

## 注册一个自定义值转换器

## 在界面编辑器中可用

# 编写一个自定义的值转换器

## 声明一个返回值的类

## 允许反向转换

## 转换值

## 反向转换值