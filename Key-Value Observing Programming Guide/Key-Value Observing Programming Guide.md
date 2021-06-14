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

"为KVO进行注册"描述了注册、接收、解除注册KVO通知的完整生命周期。  
KVO 首要目的是你无需实现每当一个属性变更时就要发送通知。它将基础结构在框架层就进行了支持，并且很容易遵循——通常你无需添加任何代码到你的工程当中。此外，基础架构已经是功能完备的，因此很容易为单个属性和相关值支持多个观察者。  
与使用NSNotificationCenter的通知不同，没有一个中心的对象给所有的监听者提供变更通知。取而代之的是，当变更发生的时候，通知直接发送给正在监听的对象。NSObject 提供了这种KVO的基本实现，你只需要重写这些方法。  
"KVO实现细节"描述了KVO是如何实现的。

# 注册KVO

你必须执行以下步骤来让一个对象能够接收KVO通知的符合KVO的属性：  

* 使用 addObserver:forKeyPath:options:context: 方法注册监听对象。
* 在监听对象接收变更通知消息的地方实现  observeValueForKeyPath:ofObject:change:context: 。
* 当不再需要接收消息使用 removeObserver:forKeyPath: 方法来移除监听。这样至少在调用这个方法的之前就从内存中移除了该监听器。

```
重要：不是所有的类都是符合KVO的。你可以让你的类按照《遵守KVO》中描述的步骤来确保它遵守了KVO。通常Apple提供的框架中的属性只有在记录在此类框架中时才符合KVO标准。
```

## 注册为监听器

监听对象首先通过发送addObserver:forKeyPath:options:context: 消息来让其本身注册为监听器，传递其本身作为监听器，属性的 key path 被监听。监听器还会额外指定一个选项参数和一个上下文的指针来管理通知方面的内容。

### 选项

选项参数，对于选项的常量指定了按位OR运算，在通知中受提供的变更字典的内容以及通知是被哪个管理者所生成的所影响。  
你可以通过选项 NSKeyValueObservingOptionOld 来监听接收更改前观察到的属性的值。设置 NSKeyValueObservingOptionNew 可以请求到改变后的新值。使用按位OR运算将两者结合，就可以接收新值和旧值了。  
通过设置选项 NSKeyValueObservingOptionInitial 来让监听对象立刻发送通知（在 addObserver:forKeyPath:options:context: 返回前)。你可以使用这种附加来在监听者的一开始就一次性确定属性的初始值。  
通过指定包含选项 NSKeyValueObservingOptionPrior 来设定监听对象在一个属性刚发生变更的时候优先发送一个通知(与常见的在发生变更之后才通知对比)。变更的字典通过包含 NSKeyValueChangeNotificationIsPriorKey 和 NSNumber包裹的YES的这组字典来展示一个预变化通知。该key不会在另一方面进行展示。当监听者拥有KVO编译需求，调用一个 -willChange... 方法来给其依赖于监听属性之一的时候，你可以使用预变更通知。调用 willChange… 的时机比常用的发送通知变更而言要提前。

### 上下文

addObserver:forKeyPath:options:context: 方法中的 context 指针包含了在相关变更通知中将要传递给监听者的原始数据。  

清单 1 创建 context 指针  

	static void *PersonAccountBalanceContext = &PersonAccountBalanceContext;
	static void *PersonAccountInterestRateContext = &PersonAccountInterestRateContext;

清单 2 为balance 和 interestRate 属性注册监听器  

	- (void)registerAsObserverForAccount:(Account*)account {
	    [account addObserver:self
	              forKeyPath:@"balance"
	                 options:(NSKeyValueObservingOptionNew |
	                          NSKeyValueObservingOptionOld)
	                 context:PersonAccountBalanceContext];
	 
	    [account addObserver:self
	              forKeyPath:@"interestRate"
	                 options:(NSKeyValueObservingOptionNew |
	                          NSKeyValueObservingOptionOld)
	                  context:PersonAccountInterestRateContext];
	}

## 接收变更通知


清单 3 实现observeValueForKeyPath:ofObject:change:context:  

	- (void)observeValueForKeyPath:(NSString *)keyPath
                      ofObject:(id)object
                        change:(NSDictionary *)change
                       context:(void *)context {
 
	    if (context == PersonAccountBalanceContext) {
	        // Do something with the balance…
	 
	    } else if (context == PersonAccountInterestRateContext) {
	        // Do something with the interest rate…
	 
	    } else {
	        // Any unrecognized context must belong to super
	        [super observeValueForKeyPath:keyPath
	                             ofObject:object
	                               change:change
	                               context:context];
	    }
	}


## 移除作为监听器的对象

清单4 移除balance和interestRate的监听指示器  

	- (void)unregisterAsObserverForAccount:(Account*)account {
	    [account removeObserver:self
	                 forKeyPath:@"balance"
	                    context:PersonAccountBalanceContext];
	 
	    [account removeObserver:self
	                 forKeyPath:@"interestRate"
	                    context:PersonAccountInterestRateContext];
	}

# 遵守KVO

对于一个特定属性，为了能够遵守KVO，一个类必须确保以下：  

* 该类的属性必须遵守KVC，如“确保遵守KVC”中所描述的。  
KVO和KVC所支持的数据类型相同，包含OC对象以及在“标量和结构体支持”中所列出的标量和结构体类型。
* 类会发出属性的KVO变更通知。
* 根据keys 注册（参见注册依赖keys）。

有两种技术能够确保变更通知被发出。由NSObject所提供的自动支持，以及对于一个累的所有属性默认可用的KVO遵循。通常来讲，如果你遵循了标准的Cocoa编码和命名规范，你就能够自动的改变通知了——你无需编写任何额外代码。  
当通知发出的时候，手动变更通知可以提供额外的控制权，并需要额外的代码。通过实现类方法 automaticallyNotifiesObserversForKey: 你就能够给你的子类的所有属性自动控制通知了。

## 自动变更通知

NSObject 提供了一种自动的键值对变更通知的基本实现。自动的键值变更通知会使用符合键值的存取器和KVC方法来通知变更。自动的通知同样支持返回的集合代理对象，比如，mutableArrayValueForKey:。  
清单1中展示了属性 name 在变更时通知监听器的结果。  

清单 1 调用方法会触发KVO变更通知发出  

	// Call the accessor method.
	[account setName:@"Savings"];
	 
	// Use setValue:forKey:.
	[account setValue:@"Savings" forKey:@"name"];
	 
	// Use a key path, where 'account' is a kvc-compliant property of 'document'.
	[document setValue:@"Savings" forKeyPath:@"account.name"];
	 
	// Use mutableArrayValueForKey: to retrieve a relationship proxy object.
	Transaction *newTransaction = <#Create a new transaction for the account#>;
	NSMutableArray *transactions = [account mutableArrayValueForKey:@"transactions"];
	[transactions addObject:newTransaction];

## 手动变更通知

清单2 automaticallyNotifiesObserversForKey: 的实现示例

	+ (BOOL)automaticallyNotifiesObserversForKey:(NSString *)theKey {
	 
	    BOOL automatic = NO;
	    if ([theKey isEqualToString:@"balance"]) {
	        automatic = NO;
	    }
	    else {
	        automatic = [super automaticallyNotifiesObserversForKey:theKey];
	    }
	    return automatic;
	}

# 注册依赖Keys

## 对一关系

	- (NSString *)fullName {
	    return [NSString stringWithFormat:@"%@ %@",firstName, lastName];
	}
	
清单1 keyPathsForValuesAffectingValueForKey: 的实现示例	

	+ (NSSet *)keyPathsForValuesAffectingValueForKey:(NSString *)key {
 
	    NSSet *keyPaths = [super keyPathsForValuesAffectingValueForKey:key];
	 
	    if ([key isEqualToString:@"fullName"]) {
	        NSArray *affectingKeys = @[@"lastName", @"firstName"];
	        keyPaths = [keyPaths setByAddingObjectsFromArray:affectingKeys];
	    }
	    return keyPaths;
	}
	
清单2 keyPathsForValuesAffecting<Key>名称转换的实现示例

	+ (NSSet *)keyPathsForValuesAffectingFullName {
	    return [NSSet setWithObjects:@"lastName", @"firstName", nil];
	}

## 对多关系

	- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context {
	 
	    if (context == totalSalaryContext) {
	        [self updateTotalSalary];
	    }
	    else
	    // deal with other observations and/or invoke super...
	}
	 
	- (void)updateTotalSalary {
	    [self setTotalSalary:[self valueForKeyPath:@"employees.@sum.salary"]];
	}
	 
	- (void)setTotalSalary:(NSNumber *)newTotalSalary {
	 
	    if (totalSalary != newTotalSalary) {
	        [self willChangeValueForKey:@"totalSalary"];
	        _totalSalary = newTotalSalary;
	        [self didChangeValueForKey:@"totalSalary"];
	    }
	}
	 
	- (NSNumber *)totalSalary {
	    return _totalSalary;
	}

# KVO实现细节

自动KVO的实现是使用的一种叫做 **isa交换** 的技术。  
isa指针，如其名，是指向维护调度表的对象的类的。这种调度表基本上包含了只想类实现的方法的指针，也包含其他数据。  
当一个监听者注册了一个对象的一个属性，监听者对象的isa指针就被修改了，指向了一个中间类，而非真实的一个类。因此，isa指针的值并不一定真实反应实例的实际类别。  
你不应该依赖于isa指针判断类的从属关系。而是应该使用class方法来判断一个对象实例的类。  