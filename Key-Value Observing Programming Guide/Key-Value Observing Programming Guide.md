[Key-Value Observing Programming Guide](https://developer.apple.com/library/archive/documentation/Cocoa/Conceptual/KeyValueObserving/KeyValueObserving.html#//apple_ref/doc/uid/10000177i)

# KVO编程指南简介

KVO 是一种让对象在其他的对象的指定属性改变的时候被通知的机制。  

```
重要：为了能够理解 KVO，你必须先理解 KVC。
```

## 概览

KVO 提供了一种让对象在其他的对象的指定属性改变的时候被通知的机制。在一个应用当中的模型和控制器层进行交互的时候，这种方式尤其有用。（在 OS X 当中，控制器层绑定技术严重依赖于 KVO。） 控制器对象通常会监听模型对象的属性，视图对象通过控制器监听模型对象的属性。不过，此外，模型对象可能会监听其他模型对象（通常在一个依赖值变更的时候进行判断）或者甚至于监听它本身（同样也是依赖值变更的时候进行判断）。  
你可以监听的属性包括单一的属性，一对一的关系，一对多的关系。一对多的关系的观察者会被通知所作出的更改类型，以及哪些对象参与了更改。  
我们举一个简单的例子来展示 KVO 在你的应用中是如何发挥作用的。假设有一个 Person 对象与一个 Account 对象进行交互，表示该人在一家银行有一个储蓄账户。Person 的实例可能需要知晓 Account 实例的某个方面的变更，比如平衡性或者感兴趣的利率。  

![](https://developer.apple.com/library/archive/documentation/Cocoa/Conceptual/KeyValueObserving/Art/kvo_objects_properties.png)  

如果这些属性是 Account 的公开属性，Person 可以定期获取 Account 来察觉变更，当然这并不高效，并且也不现实。一个更好的方案是使用 KVO，这就类似于 Person 在有变化发生的时候接收到中断。  
要使用 KVO，首先你必须确保被监听的对象（本例中是 Account），是符合 KVO 的。通常来讲，如果你的对象继承自 NSObject，并且你在创建属性的时候是常用的方式，你的对象及其属性就会自动的遵从 KVO。也可以手动的实现遵循。“KVO 的遵守”描述了自动和手动之间的区别，以及如何实现两者。  
下一步，你必须注册你的监听实例，即 Person，给被监听实例，即 Account。Person 会发送一个addObserver:forKeyPath:options:context: 消息给 Account，每当监听到 key path，它就会命名自己为监听者。  

![](https://developer.apple.com/library/archive/documentation/Cocoa/Conceptual/KeyValueObserving/Art/kvo_objects_add.png)  

为了能够从 Account 接收到变更通知，Person 需要实现 observeValueForKeyPath:ofObject:change:context: 方法，所有的监听者都如此。Account 将会在注册的 key path 变更的任意时机发送这条消息给 Person。Person 随后就能够基于上述变更通知来作出适当的动作。  

![](https://developer.apple.com/library/archive/documentation/Cocoa/Conceptual/KeyValueObserving/Art/kvo_objects_observe.png)  

最后，在不再需要通知的时候，至少在其销毁之前，Person 实例必须通过发送 removeObserver:forKeyPath: 消息给 Account 解除注册。  

![](https://developer.apple.com/library/archive/documentation/Cocoa/Conceptual/KeyValueObserving/Art/kvo_objects_remove.png)  

"为 KVO 进行注册"描述了注册、接收、解除注册 KVO 通知的完整生命周期。  
KVO 首要目的是你无需实现每当一个属性变更时就要发送通知。它将基础结构在框架层就进行了支持，并且很容易遵循——通常你无需添加任何代码到你的工程当中。此外，基础架构已经是功能完备的，因此很容易为单个属性和相关值支持多个观察者，当然所依赖的值也是。  
“注册依赖的 Keys”解释了如何指定一个 key 的值是依赖于另一个 key 的值的。  
与使用 NSNotificationCenter 的通知不同，没有一个中心的对象给所有的监听者提供变更通知。取而代之的是，当变更发生的时候，通知直接发送给正在监听的对象。NSObject 提供了这种 KVO 的基本实现，你只需要重写这些方法。  
"KVO 实现细节"描述了 KVO 是如何实现的。

# 注册 KVO

你必须执行以下步骤来让一个对象能够接收符合 KVO 的属性的 KVO 通知：  

* 使用 addObserver:forKeyPath:options:context: 方法注册监听对象。
* 在监听对象接收变更通知消息的地方实现  observeValueForKeyPath:ofObject:change:context: 。
* 当不再需要接收消息使用 removeObserver:forKeyPath: 方法来移除监听。这样至少在调用这个方法的之前就从内存中移除了该监听器。

```
重要：不是所有的类都是符合 KVO 的。你可以让你的类按照《遵守 KVO》中描述的步骤来确保它遵守了 KVO。通常 Apple 提供的框架中的属性只有在记录在此类框架中时才符合 KVO 标准。
```

## 注册为监听器

监听对象首先通过发送 addObserver:forKeyPath:options:context: 消息来让其本身注册为监听器，传递其本身作为监听器，属性的 key path 被监听。监听器还会额外指定一个选项参数和一个上下文的指针来管理通知方面的内容。

### 选项

选项参数，对于选项的常量指定了按位OR运算，在通知中受提供的变更字典的内容以及通知是被哪个管理者所生成的所影响。  
你可以通过选项 NSKeyValueObservingOptionOld 来监听接收更改前观察到的属性的值。设置 NSKeyValueObservingOptionNew 可以请求到改变后的新值。使用按位OR运算将两者结合，就可以接收新值和旧值了。  
通过设置选项 NSKeyValueObservingOptionInitial 来让监听对象立刻发送通知（在 addObserver:forKeyPath:options:context: 返回前)。你可以使用这种附加来在监听者的一开始就一次性确定属性的初始值。  
通过指定包含选项 NSKeyValueObservingOptionPrior 来设定监听对象在一个属性刚发生变更的时候优先发送一个通知(与常见的在发生变更之后才通知对比)。变更的字典通过包含 NSKeyValueChangeNotificationIsPriorKey 和 NSNumber包裹的YES的这组字典来展示一个预变化通知。该key不会在另一方面进行展示。当监听者拥有KVO编译需求，调用一个 -willChange... 方法来给其依赖于监听属性之一的时候，你可以使用预变更通知。调用 willChange… 的时机比常用的发送通知变更而言要提前。

### 上下文

addObserver:forKeyPath:options:context: 方法中的 context 指针包含了在相关变更通知中将要传递给监听者的原始数据。你可以将其设置为 NULL，并整体依赖于 key path 字符串来判断变更通知的原因，但这种处理方式对于父类出于不同原因也是监听同样的 key path 的对象可能会引发问题。  
一种更加安全和扩展性更好的方案是使用 context 来确保你接收到的通知是以你的监听器为目标而非父类的。  
在你的类中的唯一的静态变量名可的地址可以构造一个完美的 context。context 选择以一种类似父类或子类而非层叠的方式出现。你可以给整个类选择一个 context，并依赖于通知消息中的 key path 字符串来判断改变的内容。或者，你可以给每个监听 key path 创建一个不同的 context，从而完全绕过字符串比较的需要，并产生更有效的通知分析。清单 1 展示了余额和利息属性选择这种方式的 context。

清单 1 创建 context 指针  

	static void *PersonAccountBalanceContext = &PersonAccountBalanceContext;
	static void *PersonAccountInterestRateContext = &PersonAccountInterestRateContext;

清单2 中的示例展示了一个 Person 实例使用给定的 context 指针将其本身注册为一个 Account 实例的 balance 和 interestRate 属性的监听者。

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

```
注意：KVO 的 addObserver:forKeyPath:options:context: 方法对于监听对象、被监听的对象或者 context不会维持强引用。你应该根据需要对于监听对象、被监听的对象或者 context 维持强引用。
```

## 接收变更通知

当一个被监听的对象的属性值变更的时候，监听器会接收到 observeValueForKeyPath:ofObject:change:context: 消息。所有的监听器必须实现该方法。  
监听对象提供触发通知的 key path，它本身作为关联对象，一个字典会包含关于变更的详情，context 指针会在通知注册该 key path 的时候提供上下文。  
变更字典的入口 NSKeyValueChangeKindKey 提供发生变更的类型信息。如果是被监听的对象值已经变更，NSKeyValueChangeKindKey 实体会返回 NSKeyValueChangeSetting。根据监听器注册时候指定的选项不同，NSKeyValueChangeOldKey 和 NSKeyValueChangeNewKey 在变更字典中的实体包含之前、之后以及变更的属性值。如果属性是一个对象，直接提供值。如果属性是一个标量或者 C 结构体，值会被封装在一个 NSValue 对象中（就像 KVC）。  
如果被监听的属性是一个对多的关系，NSKeyValueChangeKindKey 条目也会分别通过返回 NSKeyValueChangeInsertion, NSKeyValueChangeRemoval, 或 NSKeyValueChangeReplacement 表示插入、删除、替换操作。  
入口 NSKeyValueChangeIndexesKey 的变更词典是一个 NSIndexSet 对象，指定关系中的变更索引。如果在监听器注册的时候 NSKeyValueObservingOptionNew 或 NSKeyValueObservingOptionOld 被指定作为选项，变更字典中的 NSKeyValueChangeOldKey 和 NSKeyValueChangeNewKey 即表示包含之前的、之后的以及变更的相关值的数组。  
清单 3 的例子展示了 observeValueForKeyPath:ofObject:change:context: 的实现，监听器 Person 打印了旧的和新的 balance 和 interestRate 属性值，如清单 2中注册的。

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

通过给被监听的对象发送 removeObserver:forKeyPath:context: 消息来移除 KVO，指定监听对象，key path，以及 context。清单 4中的示例展示了 Person 移除它自身作为 balance 和 interestRate 的监听者。  

清单4 移除 balance 和 interestRate 的监听指示器  

	- (void)unregisterAsObserverForAccount:(Account*)account {
	    [account removeObserver:self
	                 forKeyPath:@"balance"
	                    context:PersonAccountBalanceContext];
	 
	    [account removeObserver:self
	                 forKeyPath:@"interestRate"
	                    context:PersonAccountInterestRateContext];
	}

在接收到 removeObserver:forKeyPath:context: 消息之后，监听对象将不再接收任何指定 key path 和对象的 observeValueForKeyPath:ofObject:change:context: 消息。  
当移除一个监听器的时候，记住以下几点：  

- 如果没有准备注册一个将要导致 NSRangeException 的结果的话，要求作为监听器被移除的时候需要注意。要么调用 removeObserver:forKeyPath:context: 正好一次用于呼应 addObserver:forKeyPath:options:context:，要么如果该方法在你的应用中不可行，将其替换为 try/catch 块来处理潜在的异常。
- 在被释放的时候，一个监听器是不会将其本身自动移除的。被监听的对象会持续发送通知，不会察觉到监听者的状态。不过，一个变更通知不像其他消息一样，发送给一个已经释放的对象，触发一个内存访问异常。所以你应该确保监听器在其本身从内存中消失之前移除它本身。
- 如果是一个监听器或者被监听的对象的话，协议不提供方式来查询该对象。结构化你的代码来避免释放相关的错误。一种比较典型的模式是在监听的初始化的时候注册为一个监听器（比如在 init 或者 viewDidLoad 中），并且在释放的时候（通常在 dealloc 中）解除注册，确保正确的配对并排序好添加和移除消息，在监听器从内存中被释放之前要解除注册。

# 遵守 KVO

对于一个特定属性，为了能够遵守 KVO，一个类必须确保以下：  

* 该类的属性必须遵守 KVC，如“确保遵守 KVC”中所描述的。  
KVO 和 KVC 所支持的数据类型相同，包含 OC 对象以及在“标量和结构体支持”中所列出的标量和结构体类型。
* 类会发出属性的 KVO 变更通知。
* 根据 keys 注册（参见“注册依赖 keys”）。

有两种技术能够确保变更通知被发出。由 NSObject 所提供的自动支持，以及对于一个类的所有属性默认可用的 KVO 遵循。通常来讲，如果你遵循了标准的 Cocoa 编码和命名规范，你就能够自动的接收改变通知了——你无需编写任何额外代码。  
当通知发出的时候，手动变更通知可以提供额外的控制权，并需要额外的代码。通过实现类方法 automaticallyNotifiesObserversForKey: 你就能够给你的子类的所有属性自动控制通知了。

## 自动变更通知

NSObject 提供了一种自动的键值对变更通知的基本实现。自动的键值变更通知会使用符合键值的存取器和KVC方法来通知变更。自动的通知同样支持返回的集合代理对象，比如，mutableArrayValueForKey:。  
清单1 中展示了属性 name 在变更时通知监听器的结果。  

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

在某些情況下，你可能需要控制通知的过程，比如，出于应用特定原因或者将一组变更变更融合进一个通知等情况，要最小化触发不必要的通知。手动改变通知提供了一种方式来做这件事。  
手动和自动通知并不互斥。你可以自由的在已经有自动通知的地方分发手动通知来加强。更常见的，你可能想要对某个特定属性完全控制通知。在这种情况下，你可以重写 NSObject 的 automaticallyNotifiesObserversForKey: 实现。对于你想要排除的自动通知的属性，子类在实现 automaticallyNotifiesObserversForKey: 的时候应该返回 NO。子类在实现的时候应该调用 super 给任何不可识别的 keys。清单 2 中的示例给 balance 属性开启了手动通知，让父类能判断所有其他 keys 的通知。

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

要实现手动的监听通知，你需要在值改变之前调用 willChangeValueForKey:，并且在值变更后调用 didChangeValueForKey:。清单 3 中的示例实现了 balance 属性的手动通知。

清单 3 存取方法实现手动通知的示例

	- (void)setBalance:(double)theBalance {
	    [self willChangeValueForKey:@"balance"];
	    _balance = theBalance;
	    [self didChangeValueForKey:@"balance"];
	}

要最小化发送不必要的通知，你可以首先检查值是否发生了变更。清单 4 中的示例检测了 balance 的值并只在它改变的时候提供了通知。

清单 4 在提供通知之前检测值变更

	- (void)setBalance:(double)theBalance {
	    if (theBalance != _balance) {
	        [self willChangeValueForKey:@"balance"];
	        _balance = theBalance;
	        [self didChangeValueForKey:@"balance"];
	    }
	}

如果一个单一的操作会触发多个 keys 的变更，你必须嵌套变更通知，如 清单 5 中展示的。

清单 5 为多个 keys 嵌套变更通知

	- (void)setBalance:(double)theBalance {
	    [self willChangeValueForKey:@"balance"];
	    [self willChangeValueForKey:@"itemChanged"];
	    _balance = theBalance;
	    _itemChanged = _itemChanged+1;
	    [self didChangeValueForKey:@"itemChanged"];
	    [self didChangeValueForKey:@"balance"];
	}

在一个有序的对多关系中，你必须不仅要指定改变的 key，还要指定改变的类型以及所包含的对象的索引集合。改变的类型是一个NSKeyValueChange 类型，它指定了 NSKeyValueChangeInsertion，NSKeyValueChangeRemoval，或 NSKeyValueChangeReplacement。影响的对象的索引集合是以 NSIndexSet 对象传递的。  
清单 6 中的代码块演示了对多关系 transactions 是如何封装一个删除对象的操作的。

清单 6 在对多关系中实现手动监听通知

	- (void)removeTransactionsAtIndexes:(NSIndexSet *)indexes {
	    [self willChange:NSKeyValueChangeRemoval
	        valuesAtIndexes:indexes forKey:@"transactions"];
	 
	    // Remove the transaction objects at the specified indexes.
	 
	    [self didChange:NSKeyValueChangeRemoval
	        valuesAtIndexes:indexes forKey:@"transactions"];
	}
	
# 注册依赖Keys

在许多情况下，一个属性的价值取决于另一个对象中的一个或多个其他属性。如果其中一个属性的值改变了，那么源自属性的值应该被标注为已经变更。你该如何确保 KVO 通知被发送给这些相关属性取决于关系的基数。

## 对一关系

要触发自动通知给一对一关系，你应该实现 keyPathsForValuesAffectingValueForKey: 和遵循注册依赖 keys 定义的适当的方法之一。  
比如，一个人的全名是根据其姓和名组成的。返回全名的方法应该被写为这样：  

	- (NSString *)fullName {
	    return [NSString stringWithFormat:@"%@ %@",firstName, lastName];
	}
	
一个监听 fullName 属性的应用	必须在 firstName 或 lastName 属性发生变更的时候收到监听，因为它们都影响属性的值。  
一种解决方案是重写 keyPathsForValuesAffectingValueForKey: 来指定人的 fullName 属性是依赖于 lastName 和 firstName 属性。清单 1 展示了一个这种依赖实现的示例：  
	
清单1 keyPathsForValuesAffectingValueForKey: 的实现示例	

	+ (NSSet *)keyPathsForValuesAffectingValueForKey:(NSString *)key {
 
	    NSSet *keyPaths = [super keyPathsForValuesAffectingValueForKey:key];
	 
	    if ([key isEqualToString:@"fullName"]) {
	        NSArray *affectingKeys = @[@"lastName", @"firstName"];
	        keyPaths = [keyPaths setByAddingObjectsFromArray:affectingKeys];
	    }
	    return keyPaths;
	}

在重写的时候通常要调用 super 并返回一个包含能够做某些结果的成员的集合（）。
	
清单2 `keyPathsForValuesAffecting<Key>` 名称转换的实现示例

	+ (NSSet *)keyPathsForValuesAffectingFullName {
	    return [NSSet setWithObjects:@"lastName", @"firstName", nil];
	}

## 对多关系

keyPathsForValuesAffectingValueForKey: 方法不会支持包含一个对多关系的 key-paths。比如，假设你有一个 Department 对象，有一个对多关系（employees）代表 Employee，Employee 有一个 salary  属性。你可能想要让 Department 对象，有一个 totalSalary 属性，它在关系中依赖于所有 Employees 的 salaries。你不能够这么做，比如，keyPathsForValuesAffectingTotalSalary 并且返回 employees.salary 作为一个 key。

有两种可能的方案在同时两种情形下：  

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

自动 KVO 的实现是使用的一种叫做 **isa交换** 的技术。  
isa 指针，如其名，是指向维护调度表的对象的类的。这种调度表基本上包含了只想类实现的方法的指针，也包含其他数据。  
当一个监听者注册了一个对象的一个属性，监听者对象的 isa 指针就被修改了，指向了一个中间类，而非真实的一个类。因此，isa 指针的值并不一定真实反应实例的实际类别。  
你不应该依赖于 isa 指针判断类的从属关系。而是应该使用 class 方法来判断一个对象实例的类。  