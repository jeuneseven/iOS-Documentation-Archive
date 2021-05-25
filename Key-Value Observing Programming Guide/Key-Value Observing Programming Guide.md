[Key-Value Observing Programming Guide](https://developer.apple.com/library/archive/documentation/Cocoa/Conceptual/KeyValueObserving/KeyValueObserving.html#//apple_ref/doc/uid/10000177i)

# KVO编程指南简介

KVO是一种让对象在其他的对象的指定属性改变的时候被通知的机制。  

```
重要：为了能够理解KVO，你必须先理解KVC。
```

## 概览

KVO提供了一种让对象在其他的对象的指定属性改变的时候被通知的机制。 在一个应用当中的模型和控制器层进行交互的时候，这种方式尤其有用。（在OS X当中，控制器层绑定技术严重依赖于KVO。） 控制器对象通常会监听模型对象的属性，视图对象通过控制器监听模型对象的属性。不过，此外，模型对象可能会监听其他模型对象（通常在一个依赖值变更的时候进行判断）或者甚至于监听它本身（同样也是依赖值变更的时候进行判断）。  
你可以监听的属性包括单一的属性，一对一的关系，一对多的关系。一对多的关系的观察者会被通知所作出的更改类型，以及哪些对象参与了更改。  
我们举一个简单的例子来展示KVO在你的应用中是如何发挥作用的。假设有一个 Person 对象与一个 Account 对象进行交互，表示该人在一家银行有一个储蓄账户。Person 的实例可能需要知晓 Account 实例的某个方面的变更，比如平衡性活着感兴趣的利率。  

![](https://developer.apple.com/library/archive/documentation/Cocoa/Conceptual/KeyValueObserving/Art/kvo_objects_properties.png)  

如果这些属性是Account的公开属性，Person 可以定期获取 Account 来察觉变更，当然这并不高效，并且也不现实。一个更好的方案是使用KVO，这就类似于Person在有变化发生的时候接收到中断。  
要使用KVO，首先你必须确保被监听的对象（本例中是Account），是符合KVO的。通常来讲，如果你的对象继承自 NSObject，并且你在创建属性的时候是常用的方式，你的对象及其属性就会自动的遵从KVO。也可以手动的实现遵循。“KVO的遵守”描述了自动和手动之间的区别，以及如何实现两者。  
下一步，你必须注册你的监听实例，即Person，给被监听实例，即Account。Person 会发送一个addObserver:forKeyPath:options:context: 消息给 Account，每当监听到key path，它就会命名自己为监听者。  

![](https://developer.apple.com/library/archive/documentation/Cocoa/Conceptual/KeyValueObserving/Art/kvo_objects_add.png)  

为了能够从 Account 接收到变更通知，Person 需要实现 observeValueForKeyPath:ofObject:change:context: 方法，所有的监听者都如此。Account 将会在注册的key path变更的任意时机发送这条消息给 Person。Person 随后就能够基于上述变更通知来作出适当的动作。  

![](https://developer.apple.com/library/archive/documentation/Cocoa/Conceptual/KeyValueObserving/Art/kvo_objects_observe.png)  

最后，在不再需要通知的时候，至少在其销毁之前，Person 实例必须通过发送 removeObserver:forKeyPath: 消息给 Account 解除注册。  

![](https://developer.apple.com/library/archive/documentation/Cocoa/Conceptual/KeyValueObserving/Art/kvo_objects_remove.png)  

# 注册KVO

## 注册为监听器

### 选项

### 上下文

## 接收变更通知

## 移除作为监听器的对象

# KVO遵循

## 自动变更通知

## 手动变更通知

# 注册依赖Keys

## 对一关系

## 对多关系

# KVO实现细节

