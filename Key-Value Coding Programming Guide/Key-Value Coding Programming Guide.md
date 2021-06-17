[Key-Value Coding Programming Guide](https://developer.apple.com/library/archive/documentation/Cocoa/Conceptual/KeyValueCoding/index.html#//apple_ref/doc/uid/10000107-SW1)

# 开始
## 关于KVC

KVC是一种通过 NSKeyValueCoding 非正式协议启动的机制，遵循该协议的对象会提供它属性的间接访问。当一个对象符合KVC时，它的属性是可以通过字符串参数以一个精确、唯一的消息接口进行寻址的。这种间接的访问机制对于通过实例变量和它的关联存取方法是一种补充。  
通常使用存取方法来访问一个对象的属性。取方法（即getter）返回一个属性的值。存方法（即setter）设置一个属性的值。在OC当中你还可以直接访问一个属性的底层的实例变量。以任何方式访问一个对象的属性都是直接的，但是需要调用一个属性特定的方法或者变量名。随着属性的增加或变更，这些存取这些属性的方法的代码也要变更。作为对比，一个符合KVC的对象提供了一种简单的消息接口，它可以贯穿所有这些属性。  
KVC是一个很多其他Cocoa技术的底层基础，比如KVO，Cocoa绑定，Core Data 和 AppleScript 功能。KVC还可以在某些情况下帮助你简化代码。  

### 使用符合KVC的对象

当对象继承自 NSObject（直接或间接）时就会采用了KVC，同时遵守了 NSKeyValueCoding 协议并为基本方法提供了一个默认的实现。这样的一个对象能够让其他的对象通过一个简洁的消息接口做如下事情：  

* 访问对象属性。协议列举的方法，类似通用的取方法 valueForKey: 和通用的存方法 setValue:forKey:，通过对象的属性名或key，将其参数化为字符串来访问。这些方法的默认实现和相关方法使用了key来定位和与底层数据交互，这在《访问对象属性》中有相关描述。
* 操作集合属性。访问方法对于对象的集合属性（比如NSArray对象）所做的工作的默认实现就像其他的属性一样。此外，如果一个对象给一个属性定义了一个集合存取方法，它就开启了键值对访问集合内容的能力。这通常比直接访问并让你通过标准接口与自定义集合对象进行交互更加高效，如《访问集合属性》中描述的方法。
* 对于集合对象调用集合操作符。当访问一个复合KVC的对象的集合属性时，你可以在key字符串中插入一个集合操作符，在《使用集合操作符》中有相关描述。集合操作符会通知默认的 NSKeyValueCoding 的 getter 方法在集合上实现一个动作，并返回一个新的或者筛选过的集合的版本，或者一个单一的值来表示某些集合的特征。
* 访问非对象的属性。协议的默认实现会检测非对象属性，包括标准量和结构体，并自动的对其进行封包和解包，作为对象用在协议的接口中，这在《展示非对象值》中有相关描述。此外，协议声明了一个方法允许遵循的对象为nil，通过KVC接口设置给一个非对象的属性提供一个合适的行为。
* 通过key路径访问属性。当你拥有一个层级的符合KVC的对象时，你可以使用基于方法的key路径层层调用，使用一个调用就能获取或设置在层级中的深层的值。

### 为一个对象采用KVC

为了让你自定义的对象能够遵循KVC，你需要确保它们采用了 NSKeyValueCoding 非正式协议，并实现了相应的方法，类似valueForKey: 作为通用的 getter 以及 setValue:forKey: 作为通用的 setter 方法。幸运的是，如上文所述，NSObject 遵循了该协议，并为这些方法提供了默认实现和基本方法。所以，如果你的对象是从NSObject（或者它的众多子类）获得的，那么很多工作已经为你做好了。  
为了让默认的方法能够执行其工作，你要确保你的的对象的存取方法和实例变量遵守一个特定的定义好的模式。这会让默认实现能够查找到你的对象的属性以便响应键值编码信息。随后你就可以选择扩展和自定义键值编码，通过提供方法来验证和处理某个特定的例子。

### Swift中的KVC

继承自NSObject的 Swift 对象或者它的子类之一的属性默认是符合键值编码的。鉴于在OC当中一个属性的存取方法和实例变量必须遵循某个特定模式，一个在 Swift 中声明的标准的属性自动的会确保这一点。另一方面，很多协议的功能要么不相关，要么使用在OC中不存在的原生 Swift 构造或技术处理的更好。比如，由于所有的 Swift 的属性都是对象，你始终不用使用默认的实现来制定处理非对象的属性。  
所以，当KVC协议方法直接转移到 Swift 时，本指南主要聚焦在OC上，在你需要做的更多来确保稳定性以及KVC更常用的地方。在整个指南中都注意到了在 Swift 中要求采用明显不同方法的情况。  
更多关于使用 Cocoa 技术的 Swift，阅读《使用Cocoa和OC（Swift3）》。有关 Swift 的详细介绍，阅读《Swift编程语言》（Swift3)。

### 其他的依赖KVC的Cocoa的技术

遵守KVC的对象能够广泛的参与Cocoa技术，这些技术依赖于这种访问，包括：  

* KVO。这种机制让对象能够通过在其他对象的属性的改变中注册异步通知驱动，如《KVO编程指南》中所描述的那样。
* Cocoa绑定。这个技术的集合完整实现了MVC范式，模型封装应用数据，视图展示和编辑数据，控制器协调两者。阅读《Cocoa 绑定编程话题》了解更多关于Cocoa绑定。
* Core Data。这个框架为和对象生命周期和对象图表管理相关的常见任务场景提供了一个通用的、自动的解决方案，包括持久化。你可以在《Core Data编程指南》中了解更多关于Core Data。
* AppleScript。这个脚本语言能够直接控制可脚本控制的应用以及 macOS 的很多部分。Cocoa 的脚本化支持利用KVC来获取或设置可脚本化对象的信息。NSScriptKeyValueCoding 非正式协议中的方法提供了额外的功能与KVC结合使用，包括通过在多个键值中的索引获取和设置键值，以及强制转换一个键值给一个恰当的数据类型。《AppleScript概览》提供了一个关于 AppleScript 的高层的概览以及它相关的技术。

# KVC基本原理
## 访问对象的属性

一个对象通常会在其接口声明中指定属性，这些属性属于以下几种分类之一：  

* 特性。这些简单的值，比如一些标量，字符串，或者布尔值。类似 NSNumber 的值对象和其他的类似 NSColor 的不可变类型也可以考虑作为特性。
* 一对一的关系。这些可变对象有其自身的属性。一个对象的属性能够在对象本身不改变的情况下改变。比如，一个银行账户对象可能有个它自己的属性是 Person 对象的实例，该对象也有个地址属性。地址的持有者可能需要持有银行账户，在不改变拥有者的引用的情况下改变本身。银行账户的拥有者不会变更。只改变地址。
* 一对多的关系。这些是集合对象。通常使用 NSArray 或 NSSet 的实例来持有类似一个集合的内容，虽然自定义集合类也可以。

BankAccount 对象声明在清单2-1中，展示了属性的每种类型。  

清单2-1 BankAccount对象的属性  

	@interface BankAccount : NSObject
 
	@property (nonatomic) NSNumber* currentBalance;              // An attribute
	@property (nonatomic) Person* owner;                         // A to-one relation
	@property (nonatomic) NSArray< Transaction* >* transactions; // A to-many relation
	 
	@end

为了维持封装性，一个对象通常在其接口中为属性提供存取方法。对象的作者可能会显式的编写这些方法，或者依赖编译器自动合成它们。不论哪种方法，使用这些存取方法的代码的作者都必须在编译之前将属性名写到代码中。存取器方法的名称会变为代码的静态部分然后使用。比如，给定清单2-1中声明的银行账户对象，编译器会合成一个 setter 方法，让你给 myAccount 实例对象调用：  

	[myAccount setCurrentBalance:@(100.0)];

这很直接，但缺乏灵活性。一个符合KVC的对象，换句话说，会使用字符串标识符来提供一个更通用的机制访问对象的属性。  

### 使用key和key路径来定位一个对象的属性

key是一个字符串，它会定位一个特定的属性。通常，按照惯例，key代表的属性就是出现在代码中的属性名本身。key都必须使用ASCII编码，可能不包含空格，通常开始是小写字母（虽然有例外，比如在很多类中都会看到的URL属性）。  
由于在清单2-1中的 BankAccount 类是符合KVC的，它会识别key owner，currentBalance, 和 transactions，这些都是属性名。除了调用 setCurrentBalance: 方法，你可以使用key设置它的值：  

	[myAccount setValue:@(100.0) forKey:@"currentBalance"];

实际上，你可以使用同样的方法设置所有的 myAccount 对象的属性，使用不同的key参数即可。由于参数是一个字符串，它可以在运行时变为可操作的变量。  
key path是一个用点分隔符制定一系列来回的对象属性的字符串。这个串中的第一个key是关于接收者的，并且随后的每个key都和前一个属性的值相关。key path在使用一个方法调用深入一组层级对象中很有用。  
比如，key path owner.address.street 用在一个银行账户实例时指的是存储在银行账户拥有者的地址中的街道名称，假设 Person和Address类也是符合KVC的。  

```
注意  
在Swift中，你可以使用 #keyPath 表达式来代替使用字符串来表达一个 key 或 key path。这也提供了编译时的检查，这在《结合Cocoa和OC（Swift 3）使用Swift指南》中的 Keys 和 Key Paths 段落有相关描述。
```

### 使用keys获取属性值

当一个对象遵守 NSKeyValueCoding 协议的时候，该对象就是符合 KVC 的。一个继承自 NSObject 的对象，它会提供协议根本方法的默认实现，自动的以某种默认行为遵循该协议。这样的一个对象至少实现了以下几种基本的基于Key的获取方法：  

* valueForKey:-通过key参数返回属性名的值。如果通过key不能够根据《存取器检索模式》中描述的规则找到属性名的话，对象会给其本身发送 valueForUndefinedKey: 消息。valueForUndefinedKey: 的默认实现是产生一个 NSUndefinedKeyException 异常，但其子类可以重写这个行为并更好的处理这种情况。
* valueForKeyPath:-给相关接收者返回指定 key path 的值。任何在 key path 序列中不符合 KVC 的特定 key——意思是valueForKey: 的默认实现不能够找到存取器方法——会收到一条 valueForUndefinedKey: 消息。
* dictionaryWithValuesForKeys:-给接收者返回相关的keys的数组值。该方法会调用每个在数组中的key的 valueForKey: 。返回的NSDictionary包含所有在数组中的key的值。

>	注意  
	集合类的对象，比如NSArray, NSSet, 和 NSDictionary，不能包含nil作为值。你可以使用NSNull对象代表nil值。NSNull会提供一个单独的实例给对象的属性表示nil值。dictionaryWithValuesForKeys: 的默认实现一机相关的 setValuesForKeysWithDictionary: 会在NSNull（在字典的参数中） 和 nil（在存储的属性中）之间自动转换。

当你使用 key path 来定位一个属性时，如果 key path 中的最终 key 是多对多关系（即它引用了集合），返回值会是一个根据 key到对多 key 的右侧的包含了所有值的集合。比如，请求 key path transactions.payee 的值会返回一个包含所有交易的所有payee 对象的数组，这在 key path 中对于可变数组也有效。accounts.transactions.payee 这个 key path 会返回所有账户中所有交易的所有 payee 对象。

### 使用Keys设置属性值

和getters方法一样，符合 KVC 的对象也会根据 NSObject 的 NSKeyValueCoding 协议基于默认行为的实现提供一组小的通用的setters：  

* setValue:forKey: -以给定值给相关对象的接受者根据特定key设置值。setValue:forKey: 的默认实现会自动的解包NSNumber 和 NSValue 对象为标量和结构体，然后将其赋值给属性。参见《表示非对对象值》了解封包和解包语法的细节。  
如果指定的key相关的属性，即接收 setter 的对象调用没有该属性的话，对象会发送一条 setValue:forUndefinedKey: 消息给其本身。setValue:forUndefinedKey: 的默认实现是生成一个 NSUndefinedKeyException 异常。不过子类可以重载该方法来处理自定义管理中的请求。
* setValue:forKeyPath: -根据指定key path相关的接收者设定给定值。任何在key path序列中的对象只要不符合给定key的KVC协议，就会收到一条 setValue:forUndefinedKey: 消息。
* setValuesForKeysWithDictionary: -使用指定字典中的值设置接受者的属性，使用字典的key来匹配属性。默认的 setValue:forKey: 调用的实现是每个键值对，根据需要用 nil 代替 NSNull 对象。

在默认实现中，当你试图用一个 nil 设置一个非对象的属性时，符合KVC的对象会给其自身发送一条 setNilValueForKey: 消息。 setNilValueForKey: 的默认实现是会生成一个 NSInvalidArgumentException 异常，但是对象可以重载该方法用一个默认值代替或者标记值代替，这在《处理非对象值》中有相关描述。

### 使用Keys来简化对象的访问

想要看下基于key的 getters 和 setters 是如何简化你的代码的，请参考如下示例。在 macOS 中，NSTableView 和 NSOutlineView 对象会结合一个标识符字符串给每行。如果在列表后的模型对象不符合KVC，列表的数据源方法会强制检查每行的标识符，目的为了查找到正确的属性返回，如清单2-2所示。更甚者，在未来，当你添加另一个属性给你的模型对象时，本例中是Person对象，你必须再重新过一遍数据源方法，添加其他的条件来为新的属性和返回相关值来进行测试。

清单2-2  不使用KVC实现数据源方法  

	- (id)tableView:(NSTableView *)tableview objectValueForTableColumn:(id)column row:(NSInteger)row
	{
	    id result = nil;
	    Person *person = [self.people objectAtIndex:row];
	 
	    if ([[column identifier] isEqualToString:@"name"]) {
	        result = [person name];
	    } else if ([[column identifier] isEqualToString:@"age"]) {
	        result = @([person age]);  // Wrap age, a scalar, as an NSNumber
	    } else if ([[column identifier] isEqualToString:@"favoriteColor"]) {
	        result = [person favoriteColor];
	    } // And so on...
	 
	    return result;
	}

另一方面，清单2-3 展示了一个更加简洁的同样的数据源方法的实现，它利用了符合KVC的 Person 对象。仅使用了 valueForKey: 获取，数据源方法使用列的标识符作为key返回了恰当的值。为了更加简短，也更加通用，由于需要在随后添加新行时能够持续作用，只要行的标识符始终符合模型对象的属性名即可。

清单2-3  使用KVC实现数据源方法 

	- (id)tableView:(NSTableView *)tableview objectValueForTableColumn:(id)column row:(NSInteger)row
	{
	    return [[self.people objectAtIndex:row] valueForKey:[column identifier]];
	}

## 访问集合属性

和暴露其他属性一样，符合KVC的对象会以同样的方式暴露它们的一对多的属性。你可以使用 get 或 set 一个集合对象，就像你对其他的对象那样使用 valueForKey: 和 setValue:forKey:（或者同样的使用key path）。不过，当你想要操作这些集合的内容的时候，通常使用协议定义的可变的代理方法更为高效。  
协议定义了三个不同的代理方法用于集合对象的访问，每个都有一个 key 和 key path 变体：  

* mutableArrayValueForKey: 和 mutableArrayValueForKeyPath: 这些会返回一个代理对象，它的行为就像一个NSMutableArray对象。
* mutableSetValueForKey: 和 mutableSetValueForKeyPath: 这些会返回一个代理对象，它的行为就像一个NSMutableSet对象。
* mutableOrderedSetValueForKey: 和 mutableOrderedSetValueForKeyPath: 这些会返回一个代理对象，它的行为就像一个 NSMutableOrderedSet 对象。

当你操作协议对象的时候，给它添加对象，移除对象，或者替换它当中的对象，协议的默认实现会修改相应的底层属性。这比用valueForKey: 持有一个不可变的集合对象，创建一个修改内容的方法，然后用 setValue:forKey: 消息将其存储回对象更加高效。在很多情况下，它也比直接操作一个可变属性更加高效。这些方法对于集合对象中持有的对象符合 KVO 提供了额外的收益（参见KVO编程指南了解细节）。

## 使用集合操作符

当你给一个符合KVC的对象发送 valueForKeyPath: 消息时，你可以在key path中嵌入一个集合操作符。集合操作符是一小组由符号@开头的关键字，它指定了一个操作来执行某种方式操作数据在其返回之前。valueForKeyPath: 的默认实现由 NSObject 实现这种行为。  
当一个key path包含一个集合操作符时，任何在操作符之前的key path部分被称作左key path，表明操作相关的集合与消息接收者关联。如果你直接给一个集合对象发送消息，比如 NSArray 实例，左key path可能被省略。  
操作符之后的key path部分被称作右key path，指定集合中操作符作用的属性。所有的集合操作符（除了 @count） 都需要一个有一个右key path。如图 4-1 所示操作符key path格式。

图4-1 操作符key path格式  

![](https://developer.apple.com/library/archive/documentation/Cocoa/Conceptual/KeyValueCoding/art/keypath.jpg)

集合操作符展示了三种基本行为类型：  

* 聚合操作 以某种方式合并一个集合的对象，并返回一个对象，该对象通常会匹配右key path中命名的属性的数据类型。@count操作符是一个例外——它没有右key path，并始终返回一个NSNumber实例。
* 数组操作 返回一个NSArray实例，它包含某些集合中持有的对象的子集。
* 嵌套操作 作用于包含其他集合的集合中，根据操作符不同返回一个NSArray 或 NSSet 实例，它会以某种方式将嵌套集合的对象结合起来。

### 示例数据

下述包含的代码块描述了你该如何调用每个操作符，以及结果是什么。这依赖于 BankAccount 类，展示在清单2-1中，它持有一个 Transaction 对象的数组。如清单4-1所示，每个都代表一个单一的支票簿实体。  

清单4-1 Transaction对象的接口声明  

	@interface Transaction : NSObject
	 
	@property (nonatomic) NSString* payee;   // To whom
	@property (nonatomic) NSNumber* amount;  // How much
	@property (nonatomic) NSDate* date;      // When
	 
	@end

处于讨论的目的，假设你的 BankAccount 实例有一个由列表4-1中所示数据组成的事物数据，并且由内部的 BankAccount 对象所调用。  

列表 4-1 Transactions对象的示例数据  

payee 值  | amount值格式化为货币 | date 值格式化为月日年
------------- | ------------- | -------------
Green Power  | $120.00 | Dec 1, 2015
Green Power  | $150.00 | Jan 1, 2016
Green Power  | $170.00 | Feb 1, 2016
Car Loan  | $250.00 | Jan 15, 2016
Car Loan  | $250.00 | Feb 15, 2016
Car Loan  | $250.00 | Mar 15, 2016
General Cable  | $120.00 | Dec 1, 2015
General Cable  | $155.00 | Jan 1, 2016
General Cable  | $120.00 | Feb 1, 2016
Mortgage  | $1,250.00 | Jan 15, 2016
Mortgage  | $1,250.00 | Feb 15, 2016
Mortgage  | $1,250.00 | Mar 15, 2016
Animal Hospital  | $600.00 | Jul 15, 2016

### 聚合操作符

聚合操作符无论是在数组还是一组属性中都可用，它会产出一个反应集合的某些方面的值。

#### @avg

当你指定 @avg 操作符时，valueForKeyPath：会读取集合中每个元素右key path指定的属性。转换为一个double类型（代替0或者nil值），并计算它们的算术平均值。然后会返回一个存储在NSNumber实例中的结果。  
要获取列表4-1中的示例代码的平均值事物数量：                                                               
	NSNumber *transactionAverage = [self.transactions valueForKeyPath:@"@avg.amount"];

格式化后transactionAverage的结果是¥456.54。

#### @count

当你指定 @count 操作符的时候，valueForKeyPath：会返回一个NSNumber实例，它是集合中的元素个数。如果有右侧key path会被省略。  
要获得 transactions 中 Transaction 的数量：  

	NSNumber *numberOfTransactions = [self.transactions valueForKeyPath:@"@count"];
	
numberOfTransactions 的值是13。

#### @max

当你指定 @max 操作符的时候，valueForKeyPath：方法会沿着集合名称通过右侧key path和返回的最大值来进行寻找。检索行为的比较是使用的compare：方法，这在很多 Foundation 类中都有定义，比如NSNumber类。所以，通过右侧key path表示的属性必须持有一个对象，并能够有意义的响应这个消息。检索时会忽略集合条目的nil值。  
要获得日期值的最大值，即最近的交易日期，通过列表4-1中的交易列表：  

	NSDate *latestDate = [self.transactions valueForKeyPath:@"@max.date"];

格式化的latestDate值是Jul 15, 2016。

#### @min

当你指定 @min 操作符的时候，valueForKeyPath：方法会沿着集合名称通过右侧key path和返回的最小值来进行寻找。检索行为的比较是使用的compare：方法，这在很多 Foundation 类中都有定义，比如NSNumber类。所以，通过右侧key path表示的属性必须持有一个对象，并能够有意义的响应这个消息。检索时会忽略集合条目的nil值。  
要获得日期值的最小值，即最早的交易日期，通过列表4-1中的交易列表：  

	NSDate *earliestDate = [self.transactions valueForKeyPath:@"@min.date"];

格式化的earliestDate值是Dec 1, 2015。

#### @sum

当你指定 @ sum 操作符时，valueForKeyPath：会读取集合中每个元素右key path指定的属性。转换为一个double类型（代替0或者nil值），并计算它们的和。然后会返回一个存储在NSNumber实例中的结果。  
要获取列表4-1中的示例代码的事物数量和：           

	NSNumber *amountSum = [self.transactions valueForKeyPath:@"@sum.amount"];

格式化的amountSum结果是$5,935.00。

### 数组操作符

数组操作符会触发 valueForKeyPath: 方法，返回一个由右侧keypath表示的相应地特定集合的对象的一组数组对象。  

>	重要：  
	valueForKeyPath: 方法在使用数组操作符时，遇到任何子节点对象是nil的时候会产生异常。

#### @distinctUnionOfObjects

当你指定 @distinctUnionOfObjects 操作符的时候，valueForKeyPath：会创建并返回一个通过右侧keypath指定的集合中相应属性的不同对象。  
要获取一个payee属性值的集合，省略重复值的transactions中的事物：  

	NSArray *distinctPayees = [self.transactions valueForKeyPath:@"@distinctUnionOfObjects.payee"];

结果 distinctPayees 数组会包含一个实例，即下述字符串： Car Loan, General Cable, Animal Hospital, Green Power, Mortgage。

>	注意  
	@unionOfObjects 操作符提供类似行为，但不会移除重复对象。

#### @unionOfObjects

当你指定 @unionOfObjects 操作符的时候，valueForKeyPath：会创建并返回一个通过右侧keypath指定的集合中相应属性的所有对象。与@distinctUnionOfObjects不同，重复的对象不会被移除。  
要获取一个payee属性值的集合，取到transactions中的事物：  

	NSArray *payees = [self.transactions valueForKeyPath:@"@unionOfObjects.payee"];

结果 payees 数组会下述字符串：Green Power, Green Power, Green Power, Car Loan, Car Loan, Car Loan, General Cable, General Cable, General Cable, Mortgage, Mortgage, Mortgage, Animal Hospital。注意重复。

>	注意  
	@distinctUnionOfArrays 操作符提供类似行为，但会移除重复对象。

### 嵌套操作符

嵌套操作符是作用于嵌套集合的，即每个集合本身还包含了一个集合。  

>	重要  
	valueForKeyPath: 方法在使用前套操作符时，遇到任何子节点对象是nil的时候会产生异常。

为后续介绍，假设有第二个数据数组叫做moreTransactions，构成列表4-2中的数据，它是集合了原始的transactions 数组（引自“示例数据”一节）为一个嵌套数组：  

	NSArray* moreTransactions = @[<# transaction data #>];
	NSArray* arrayOfArrays = @[self.transactions, moreTransactions];

列表4-2 假设 moreTransactions 数组中的 Transaction 数据  

payee 值  | amount值格式化为货币 | date 值格式化为月日年
------------- | ------------- | -------------
General Cable - Cottage  | $120.00 | Dec 18, 2015

#### @distinctUnionOfArrays

当你指定@distinctUnionOfArrays 操作符时，valueForKeyPath：会创建并返回一个数组，该数组包含通过右侧keypath所指定的结合所有集合相应的属性的不同对象。  
要在所有的arrayOfArrays：中的数组中获取不同的payee 值：  
	
	NSArray *collectedDistinctPayees = [arrayOfArrays valueForKeyPath:@"@distinctUnionOfArrays.payee"];

结果 collectedDistinctPayees 数组包含以下值：Hobby Shop, Mortgage, Animal Hospital, Second Mortgage, Car Loan, General Cable - Cottage, General Cable, Green Power。

>	注意  
	@unionOfArrays 操作符类似，但不移除重复对象。

#### @unionOfArrays

当你指定@unionOfArrays 操作符时，valueForKeyPath：会创建并返回一个数组，该数组包含通过右侧keypath所指定的结合所有集合相应的属性的不同对象，而不移除重复项。  
要在所有的arrayOfArrays：中的数组中获取不同的payee 值：  

	NSArray *collectedPayees = [arrayOfArrays valueForKeyPath:@"@unionOfArrays.payee"];

结果 collectedDistinctPayees 数组包含以下值：Green Power, Green Power, Green Power, Car Loan, Car Loan, Car Loan, General Cable, General Cable, General Cable, Mortgage, Mortgage, Mortgage, Animal Hospital, General Cable - Cottage, General Cable - Cottage, General Cable - Cottage, Second Mortgage, Second Mortgage, Second Mortgage, Hobby Shop。

>	注意  
	@distinctUnionOfArrays 操作符类似，但移除重复对象。

#### @distinctUnionOfSets

当你指定@distinctUnionOfSets 操作符时，valueForKeyPath：会创建并返回一个NSSet 对象，该对象包含通过右侧keypath所指定的结合所有集合相应的属性的不同对象，而不移除重复项。  
这个操作符的行为类似@distinctUnionOfArrays，只不过它要的是一个NSSet实例，包含NSSet对象的实例，而非一个NSArray实例包含NSArray实例。同样的，它会返回一个NSSet实例。假设示例数据已经被存在一个集合而非数组中，示例调用和结果也会和@distinctUnionOfArrays 展示的一样。

## 表示非对象值

KVC协议方法的默认实现由NSObject提供，同时作用于对象和非对象属性。默认实现会自动的从对象参数或返回值到非对象属性之间进行转换。这让基于key签名的getter和setter能够保持不变，即使存储的属性是一个标量或者结构体。  

>	注意  
	由于所有Swift中的属性都是对象，本段落只用于OC属性。

当你调用协议中的一个getter方法时，类似valueForKey：，默认的实现会判断特定的访问方法或者实例变量（根据“存取搜索模式”中描述的规则支持的特定key和值）。若返回值不是一个对象，getter会使用该值初始化一个NSNumber对象（对于标量而言），或一个NSValue对象（对于结构体而言）然后将其返回。  
类似的，默认的，类似 setValue:forKey: 的 setter方法会根据存取属性或实例变量判断数据类型，给定一个特定的key。若数据类型不是一个对象，setter首先会发送一个适当的<type>Value消息给到来的值对象来提取底层数据，然后将其存储。  

>	注意  
	当你调用一个KVC协议的setter方法，设置一个nil值给非对象属性时，setter并不会察觉，照常触发动作来应用。然后，它会发送一条setNilValueForKey：消息给对象接收者的setter调用。该方法的默认实现会产生NSInvalidArgumentException异常，但子类可以重写这个方法的行为，在“处理非对象值”中有相关描述，所以请设置标记值，或提供一个有意义的默认值。

### 封包和解包标量类型

列表5-1 列出了默认KVC使用NSNumber实例实现封装的标量类型。对于每种数据类型，列表都展示了用来从底层属性值创建一个NSNumber实例的方法到支持一个getter返回值。随后展示了在set操作中用来从setter输入参数扩展值的存取方法。  
列表5-1 NSNumber对象中的封装标量

数据类型  | 创建方法 | 存取方法
------------- | ------------- | -------------
BOOL| numberWithBool:| boolValue(iOS中) charValue(macOS中)
char | numberWithChar:| charValue
double | numberWithDouble:| doubleValue
float | numberWithFloat:| floatValue
int | numberWithInt:| intValue
long | numberWithLong:| longValue
long long | numberWithLongLong:| longLongValue
short | numberWithShort:| shortValue
unsigned char| numberWithUnsignedChar:| unsignedChar
unsigned int| numberWithUnsignedInt:| unsignedInt
unsigned long| numberWithUnsignedLong:| unsignedLong
unsigned long long| numberWithUnsignedLongLong:| unsignedLongLong
unsigned short| numberWithUnsignedShort:| unsignedShort

> 注意 
> 在macOS中，由于历史原因，BOOL被定义成signed char类型，KVC并不能区分两者。因此，当key是BOOL类型时，你不应该传递一个类似 @“true” 或 @“YES” 的字符串值给setValue:forKey:方法。KVC会试图调用charValue（由于BOOL本质上就是一个char），但NSString没有实现该方法，这会引起运行时错误。取而代之的，当key是BOOL类型时，传递NSNumber对象，类似@(1) 或 @(YES)，作为参数传递给setValue:forKey:。这种限制不应该应用在iOS中，在iOS中BOOL类型被定义为一个本地化的布尔类型bool，KVC会调用boolValue，这在 NSNumber对象或者一个格式为NSString的对象中都能够起作用。

### 封包和解包结构体

列表5-2 展示了默认存取方法用来封包和解包常见 NSPoint, NSRange, NSRect, 和 NSSize 等结构体的创建和存取方法。

列表5-2 使用NSValue封装常用结构体类型  

数据类型  | 创建方法 | 存取方法
------------- | ------------- | -------------
NSPoint | valueWithPoint:| pointValue
NSRange | valueWithRange:| rangeValue
NSRect | valueWithRect:(macOS有效)| rectValue
NSSize | valueWithSize:| sizeValue

自动的封包解包并不限于 NSPoint, NSRange, NSRect, 和 NSSize。结构体类型（意思是在OC字符串编码中以{开头的类型）都能被以一个 NSValue 对象封包。比如，看下清单5-1中声明的结构体和类接口。  

列表5-1 一个使用自定义结构体的示例类  

	typedef struct {
	    float x, y, z;
	} ThreeFloats;
	 
	@interface MyClass
	@property (nonatomic) ThreeFloats threeFloats;
	@end

使用这个叫做 myClass 的类的实例，你就能使用KVC获取 threeFloats 的值：  
	
	NSValue* result = [myClass valueForKey:@"threeFloats"];

valueForKey: 的默认实现调用了threeFloats的getter方法，然后返回以 NSValue 对象封装的结果。  
同样的，你可以使用KVC设置 threeFloats 的值：  

	ThreeFloats floats = {1., 2., 3.};
	NSValue* value = [NSValue valueWithBytes:&floats objCType:@encode(ThreeFloats)];
	[myClass setValue:value forKey:@"threeFloats"];

解包的默认实现是使用 getValue: 消息，然后用结果的结构体调用 setThreeFloats:。

## 校验属性

KVC 协议还定义了方法来支持校验属性。就像你使用基于key的存取方法来读写一个符合KVC的对象的属性一样，你也可以通过key(或key path)校验属性。当你调用validateValue:forKey:error:（或validateValue:forKeyPath:error:）方法时，协议的默认实现会搜索接收验证消息的对象（或在key path末尾的对象） 以寻找名字符合模式 validate<Key>:error: 的方法。如果对象没有这个方法，默认校验成功，默认的实现返回YES。如果一个指定属性的校验方法存在，默认实现返回该方法的调用。  

> 注意  
> 通常只在OC中使用这里描述的校验。在Swift中，属性的校验通常由依赖的编译器所处理，支持可选和强类型检查，当使用内置的willSet 和 didSet 属性检测任何运行时API联系，如《Swift编程语言(Swift 3)》中所描述的“属性检测”一节。  

由于指定属性的校验方法接收的值和error参数是引用方式的，校验有三个可能的结果：  

1. 校验方法视值对象为有效，并返回YES，并且不用改变值或者error。
2. 校验方法视值对象无效，但选择不修改它。在这种情况下，方法会返回NO，并设置error引用（如果调用者提供的话）为一个NSError对象，并解释失败的原因。
3. 校验方法视值对象无效，但创建一个新的、有效的作为替代。在这种情况下，方法会返回YES，并且error对象不动。在返回前，方法会修改值的引用，将其指向一个新的值对象。当作出一个改变的时候，方法始终会创建一个新的对象，而非修改旧的，即使是值对象是可变的。

清单  6-1 展示了一个如何调用名称字符串校验的例子。  
清单 6-1 校验名称属性  

	Person* person = [[Person alloc] init];
	NSError* error;
	NSString* name = @"John";
	if (![person validateValue:&name forKey:@"name" error:&error]) {
	    NSLog(@"%@",error);
	}

### 自动校验

通常来讲，无论是KVC协议，还是其默认实现定义的任何机制都不会自动执行校验。而你应该确保在你的应用中的适当位置使用校验方法。  
某些其他的Cocoa技术会在某些情况下自动执行校验。比如，Core Data 会在管理对象上下文被保存的时候自动的执行校验（参见《Core Data 编程指南》）。同样的，在macOS中，Cocoa 绑定能够让你指定校验应该自动的发生（参见《Cocoa绑定编程话题》了解更多信息）。

## 存取器搜索模式

由NSObject 提供的 NSKeyValueCoding 协议的默认实现使用了一组明确定义规则调用对象的底层属性来映射基于key的存取器。这些协议方法使用了一个key参数来检索它们自身的实例对象的存取方法、实例变量以及相关的遵循某个命名规范的方法。虽然你很少修改这些默认检索，但是了解它是如何工作的还是很有帮助的，既可以跟踪KVC对象的行为，也有助于是你自己的对象符合要求。

> 注意
> 本段使用的 `<key>` 或者 `<Key>` 是作为key字符串的占位符出现在KVC协议函数的一个参数当中的，随后该参数将会被作为一个二次调用的方法或者变量名所检索。映射的属性名遵从占位符的情况。比如，对于getter的 `<key>` 或者 `<Key>` ，属性名会隐藏映射到hidden 和 isHidden。

### 基本的getter的检索模式

valueForKey: 的默认实现会将一个key作为输入参数，承载着以下程序，在类的实例接收到valueForKey:调用的时候进行操作：  

1. 从名称类似 get`<Key>`, `<key>`, `is<Key>`, 或 `_<key>`的实例的存取方法中以这种顺序首先进行检索。如果找到，调用它，然后跳转到第五步作为结果。否则执行下一步。  
2. 如果没有直接查找到存取方法，沿着名称匹配模式 `countOf<Key>` 和 `objectIn<Key>AtIndex:` (相关方法由NSArray 类最初定义) 以及 `<key>AtIndexes:`(对应NSArray的 objectsAtIndexes: 方法) 的实例进行查找。  
如果这些当中的第一个，或者至少在另外两个当中的一个被找到了，创建一个集合代理对象，该对象会响应所有的 NSArray 方法并将其返回。否则，执行步骤3。  
代理对象随后会转换任何它所接收的 NSArray 消息给一些 `countOf<Key>`, `objectIn<Key>AtIndex:`, 和 `<key>AtIndexes:` 消息的组合给它创建的复合KVC协议的对象发消息。如果原对象也实现了名称类似 `get<Key>:range:` 的可选方法，代理对象也会在适当的时机使用它。实际上，代理对象会和符合KVC的对象共同协作，让底层属性表现的像一个NSArray，即使它没有这个对象。
3. 如果没有找到简单的存取方法或者一组数组存取方法，会查找三个名为 `countOf<Key>`, `enumeratorOf<Key>`, 和 `memberOf<Key>:` 的方法（相关的原始方法被NSSet类定义）。  
如果三个方法都被找到，会创建一个集合代理对象，该对象会响应所有的NSSet方法并将其返回。否则，跳转到步骤4。  
这个代理对象随后会转换所有它所接收到的NSSet的消息，结合 `countOf<Key>`, `enumeratorOf<Key>`, 和 `memberOf<Key>:` 消息给到它所创建的对象。实际上，代理对象会和符合KVC的对象共同协作，让底层属性的表象像一个NSSet，即使它没有这个对象。
4. 如果没有找到简单的存取方法或者一组集合存取方法，并且接受者的类方法 accessInstanceVariablesDirectly 返回的YES，这时会按顺序检索名为 `_<key>`, `_is<Key>`, `<key>`, 或 `is<Key>` 的实例变量。如果找到，直接获取该实例变量的值，然后执行步骤5。否则，跳转到步骤6。
5. 如果接收到的属性值是一个对象指针，直接返回结果。  
如果值是一个NSNumber所支持的标量，将其存储为一个NSNumber实例，并将其返回。  
如果值是一个NSNumber不支持的标量，将其转换为NSValue对象，并将其返回。
6. 如果所有的else都失败了，调用 valueForUndefinedKey:。这默认会产生一个异常，但NSObject的子类可以提供指定key的行为。

### 基本的setter的检索模式

默认的 setValue:forKey: 实现，给定key和value作为输入参数，会尝试使用一个名为key的属性设置value（对于非对象属性，会使用解包value的版本，如“展示非对象值”一节）内部对象会接收调用，使用步骤如下：  

1. 首先按顺序查找名为`set<Key>:` 或 `_set<Key>`的存取方法。如果找到了，调用它，传入输入值（或根据需要的解包值）并结束。
2. 如果没有直接查找到存取方法，若类方法 accessInstanceVariablesDirectly 返回 YES，按顺序查找名为 `_<key>`, `_is<Key>`, `<key>`, 或 `is<Key>` 的实例变量。如果找到，直接以输入值（或解包值）设置该实例变量并结束。
3. 上述存取器或实例变量都没找到，调用 setValue:forUndefinedKey:。这会默认生成一个异常，但NSObject的子类可以提供指定key的行为。

### 可变数组的检索模式

mutableArrayValueForKey: 的默认实现，给定一个key作为输入参数，返回一个可变代理数组给名为key的属性，让内部的对象接收存取器调用，使用如下步骤：  

1. 查找成对的名为 insertObject:in<Key>AtIndex: 和 removeObjectFrom<Key>AtIndex: 的方法（分别对应 NSMutableArray 的  insertObject:atIndex: 和 removeObjectAtIndex: 方法），或者是名为insert<Key>:atIndexes: 和 remove<Key>AtIndexes: （分别对应NSMutableArray 的 insertObjects:atIndexes: 和 removeObjectsAtIndexes: 方法）的方法。  
若对象至少有一个插入和移除方法，返回一个通过发送某些 insertObject:in<Key>AtIndex:, removeObjectFrom<Key>AtIndex:, insert<Key>:atIndexes:, 和 remove<Key>AtIndexes: 消息来响应NSMutableArray消息代理对象，消息发送给原 mutableArrayValueForKey: 的接收者。  
当对象接收到 mutableArrayValueForKey: 消息，并且实现了一个名为 replaceObjectIn<Key>AtIndex:withObject: o或 replace<Key>AtIndexes:with<Key>: 的可选的替代对象方法，代理对象会在适当的时机利用这些方法达到最佳性能。  

### 可变有序集合的检索模式

### 可变集合的检索模式

# 采用KVC
## 获取基本的KVC合规

当给一个对象采用了KVC，你就可以通过让你的对象继承自NSObject（或其众多的子类之一）来获得NSKeyValueCoding协议的默认实现了。反过来说，默认的实现依赖于你定义你的对象的实例变量（或者ivars）以及遵循特定的定义好的模式的存取方法了，这样，它就能够在接收到键值编码方法(比如valueForKey: 和 setValue:forKey:)时通过字符串key关联属性。  
通常遵守OC中的标准模式，只需要使用@property语句，然后编译器自动合成ivar和存取器方法。编译器默认遵循预期模式。  

> 注意  
> 在Swift中

### 基本的getters

	- (NSString*)title
	{
	   // Extra getter logic…
	 
	   return _title;
	}

	
	- (BOOL)isHidden
	{
	   // Extra getter logic…
	 
	   return _hidden;
	}

### 基本的setters

	- (void)setHidden:(BOOL)hidden
	{
	    // Extra setter logic…
	 
	   _hidden = hidden;
	}

	- (void)setNilValueForKey:(NSString *)key
	{
	    if ([key isEqualToString:@"hidden"]) {
	        [self setValue:@(NO) forKey:@”hidden”];
	    } else {
	        [super setNilValueForKey:key];
	    }
	}

### 实例变量

	@synthesize title = _title;
	
	@interface MyObject : NSObject {
	    NSString* _title;
	}
	 
	@property (nonatomic) NSString* title;
	 
	@end

## 定义集合方法

### 访问索引集合

#### 索引集合的getter

#### 索引集合的改变

### 访问无序的集合

## 处理非对象值



## 增加校验

### 校验标量

## 描述属性关系

### 类描述



## 性能设计

### 重写KVC方法

### 优化一对多关系

## 合规检查表

### 属性和一对一关系匹配

### 索引一对多关系匹配

### 无序一对多关系匹配

### 校验