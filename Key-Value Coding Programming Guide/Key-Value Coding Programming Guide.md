[Key-Value Coding Programming Guide](https://developer.apple.com/library/archive/documentation/Cocoa/Conceptual/KeyValueCoding/index.html#//apple_ref/doc/uid/10000107-SW1)

# 开始
## 关于KVC

KVC 是一种通过 NSKeyValueCoding 非正式协议启动的机制，遵循该协议的对象会提供对它属性的间接访问。当一个对象符合 KVC 时，它的属性是可以通过字符串参数以一个精确、唯一的消息接口进行寻址的。这种间接的访问机制对于通过实例变量和它的关联存取方法是一种补充。  
通常使用存取方法来访问一个对象的属性。取方法（即 getter）返回一个属性的值。存方法（即 setter）设置一个属性的值。在OC当中你还可以直接访问一个属性的底层的实例变量。以任何方式访问一个对象的属性都是直接的，但是需要调用一个属性特定的方法或者变量名。随着属性的增加或变更，这些存取这些属性的方法的代码也要变更。作为对比，一个符合 KVC 的对象提供了一种简单的消息接口，它可以贯穿所有这些属性。  
KVC 是一个很多其他 Cocoa 技术的底层基础，比如 KVO，Cocoa 绑定，Core Data 和 AppleScript 功能。KVC 还可以在某些情况下帮助你简化代码。  

### 使用符合 KVC 的对象

当对象继承自 NSObject（直接或间接）时就会采用了 KVC，同时遵守了 NSKeyValueCoding 协议，并为基本方法提供了一个默认的实现。这样的一个对象能够让其他的对象通过一个简洁的消息接口做如下事情：  

* 访问对象属性。协议列举的方法，类似通用的取方法 valueForKey: 和通用的存方法 setValue:forKey:，通过对象的属性名或key，将其参数化为字符串来访问。这些方法的默认实现和相关方法使用了 key 来定位和与底层数据交互，这在《访问对象属性》中有相关描述。
* 操作集合属性。访问方法对于对象的集合属性（比如 NSArray 对象）所做的工作的默认实现就像其他的属性一样。此外，如果一个对象给一个属性定义了一个集合存取方法，它就开启了键值对访问集合内容的能力。这通常比直接访问并让你通过标准接口与自定义集合对象进行交互更加高效，如《访问集合属性》中描述的方法。
* 对于集合对象调用集合操作符。当访问一个复合 KVC 的对象的集合属性时，你可以在 key 字符串中插入一个集合操作符，在《使用集合操作符》中有相关描述。集合操作符会通知默认的 NSKeyValueCoding 的 getter 方法在集合上实现一个动作，并返回一个新的或者筛选过的集合的版本，或者一个单一的值来表示某些集合的特征。
* 访问非对象的属性。协议的默认实现会检测非对象属性，包括标准量和结构体，并自动的对其进行封包和解包，作为对象用在协议的接口中，这在《展示非对象值》中有相关描述。此外，协议声明了一个方法允许遵循的对象为 nil，通过 KVC 接口设置给一个非对象的属性提供一个合适的行为。
* 通过 key 路径访问属性。当你拥有一个层级的符合 KVC 的对象时，你可以使用基于方法的 key 路径层层调用，使用一个调用就能获取或设置在层级中的深层的值。

### 为一个对象采用 KVC

为了让你自定义的对象能够遵循 KVC，你需要确保它们采用了 NSKeyValueCoding 非正式协议，并实现了相应的方法，类似valueForKey: 作为通用的 getter 以及 setValue:forKey: 作为通用的 setter 方法。幸运的是，如上文所述，NSObject 遵循了该协议，并为这些方法提供了默认实现和基本方法。所以，如果你的对象是从 NSObject（或者它的众多子类）继承的，那么很多工作已经为你做好了。  
为了让默认的方法能够执行其工作，你要确保你的对象的存取方法和实例变量遵守一个特定的定义好的模式。这会让默认实现能够查找到你的对象的属性以便响应键值编码信息。随后你就可以选择扩展和自定义键值编码，通过提供方法来验证和处理某个特定的例子。

### Swift 中的 KVC

继承自 NSObject 的 Swift 对象或者它的子类之一的属性默认是符合键值编码的。鉴于在 OC 当中一个属性的存取方法和实例变量必须遵循某个特定模式，一个在 Swift 中声明的标准的属性自动的会确保这一点。另一方面，很多协议的功能要么不相关，要么使用在 OC中不存在的原生 Swift 构造或技术处理的更好。比如，由于所有的 Swift 的属性都是对象，你始终不用使用默认的实现来制定处理非对象的属性。  
所以，当 KVC 协议方法直接转移到 Swift 时，本指南主要聚焦在 OC 上，在你需要做的更多来确保稳定性以及 KVC 更常用的地方。在整个指南中都注意到了在 Swift 中要求采用明显不同方法的情况。  
更多关于使用 Cocoa 技术的 Swift，阅读《使用Cocoa和OC（Swift3）》。有关 Swift 的详细介绍，阅读《Swift 编程语言》（Swift3)。

### 其他的依赖KVC的Cocoa的技术

遵守 KVC 的对象能够广泛的参与 Cocoa 技术，这些技术依赖于这种访问，包括：  

* KVO。这种机制让对象能够通过在其他对象的属性的改变中注册异步通知驱动，如《KVO 编程指南》中所描述的那样。
* Cocoa 绑定。这个技术的集合完整实现了 MVC 范式，模型封装应用数据，视图展示和编辑数据，控制器协调两者。阅读《Cocoa 绑定编程话题》了解更多关于 Cocoa 绑定。
* Core Data。这个框架为和对象生命周期和对象图表管理相关的常见任务场景提供了一个通用的、自动的解决方案，包括持久化。你可以在《Core Data编程指南》中了解更多关于 Core Data。
* AppleScript。这个脚本语言能够直接控制可脚本控制的应用以及 macOS 的很多部分。Cocoa 的脚本化支持利用 KVC 来获取或设置可脚本化对象的信息。NSScriptKeyValueCoding 非正式协议中的方法提供了额外的功能与KVC结合使用，包括通过在多个键值中的索引获取和设置键值，以及强制转换一个键值给一个恰当的数据类型。《AppleScript概览》提供了一个关于 AppleScript 的高层的概览以及它相关的技术。

# KVC基本原理
## 访问对象的属性

一个对象通常会在其接口声明中指定属性，这些属性属于以下几种分类之一：  

* 特性。这些简单的值，比如一些标量，字符串，或者布尔值。类似 NSNumber 的值对象和其他的类似 NSColor 的不可变类型也可以考虑作为特性。
* 一对一的关系。这些可变对象有其自身的属性。一个对象的属性能够在对象本身不改变的情况下改变。比如，一个银行账户对象可能有个它自己的属性是 Person 对象的实例，该对象也有个地址属性。地址的持有者可能需要持有银行账户，在不改变拥有者的引用的情况下改变本身。银行账户的拥有者不会变更。只改变地址。
* 一对多的关系。这些是集合对象。通常使用 NSArray 或 NSSet 的实例来持有类似一个集合的内容，虽然自定义集合类也可以。

BankAccount 对象声明在清单2-1中，展示了属性的每种类型。  

清单2-1 BankAccount 对象的属性  

	@interface BankAccount : NSObject
 
	@property (nonatomic) NSNumber* currentBalance;              // An attribute
	@property (nonatomic) Person* owner;                         // A to-one relation
	@property (nonatomic) NSArray< Transaction* >* transactions; // A to-many relation
	 
	@end

为了维持封装性，一个对象通常在其接口中为属性提供存取方法。对象的作者可能会显式的编写这些方法，或者依赖编译器自动合成它们。不论哪种方法，使用这些存取方法的代码的作者都必须在编译之前将属性名写到代码中。存取器方法的名称会变为代码的静态部分然后被使用。比如，给定 清单2-1 中声明的银行账户对象，编译器会合成一个 setter 方法，让你给 myAccount 实例对象调用：  

	[myAccount setCurrentBalance:@(100.0)];

这很直接，但缺乏灵活性。一个符合KVC的对象，换句话说，会使用字符串标识符来提供一个更通用的机制访问对象的属性。  

### 使用 key 和 key 路径来定位一个对象的属性

key 是一个字符串，它会定位一个特定的属性。通常，按照惯例，key 代表的属性就是出现在代码中的属性名本身。key 都必须使用 ASCII 编码，可能不包含空格，通常开始是小写字母（虽然有例外，比如在很多类中都会看到的 URL 属性）。  
由于在清单2-1中的 BankAccount 类是符合 KVC 的，它会识别 owner，currentBalance, 和 transactions 等 key，这些都是属性名。除了调用 setCurrentBalance: 方法，你可以使用 key 设置它的值：  

	[myAccount setValue:@(100.0) forKey:@"currentBalance"];

实际上，你可以使用同样的方法设置所有的 myAccount 对象的属性，使用不同的 key 参数即可。由于参数是一个字符串，它可以在运行时变为可操作的变量。  
key path 是一个用点分隔符制定一系列来回的对象属性的字符串。这个串中的第一个 key 是关于接收者的，并且随后的每个 key 都和前一个属性的值相关。key path 在使用一个方法调用深入一组层级对象中很有用。  
比如，key path owner.address.street 用在一个银行账户实例时指的是存储在银行账户拥有者的地址中的街道名称，假设  Person 和 Address 类也是符合 KVC 的。  

> 注意  
> 在Swift中，你可以使用 #keyPath 表达式来代替使用字符串来表达一个 key 或 key path。这也提供了编译时的检查，这在《结合 Cocoa 和 OC（Swift 3）使用Swift指南》中的 Keys 和 Key Paths 段落有相关描述。

### 使用 keys 获取属性值

当一个对象遵守 NSKeyValueCoding 协议的时候，该对象就是符合 KVC 的。一个继承自 NSObject 的对象，它会提供协议基本方法的默认实现，自动的以某种默认行为遵循该协议。这样的一个对象至少实现了以下几种基本的基于 Key 的获取方法：  

* valueForKey:-通过 key 参数返回属性名的值。如果通过 key 不能够根据《存取器检索模式》中描述的规则找到属性名的话，对象会给其本身发送 valueForUndefinedKey: 消息。valueForUndefinedKey: 的默认实现是产生一个 NSUndefinedKeyException 异常，但其子类可以重写这个行为并更好的处理这种情况。
* valueForKeyPath:-给相关接收者返回指定 key path 的值。任何在 key path 序列中不符合 KVC 的特定 key——意思是valueForKey: 的默认实现不能够找到存取器方法——会收到一条 valueForUndefinedKey: 消息。
* dictionaryWithValuesForKeys:-给接收者返回相关的 keys 的数组值。该方法会调用每个在数组中的 key 的 valueForKey: 。返回的 NSDictionary 包含所有在数组中的 key 的值。

>	注意  
	集合类的对象，比如 NSArray, NSSet, 和 NSDictionary，不能包含 nil 作为值。你可以使用 NSNull 对象代表 nil 值。NSNull 会提供一个单独的实例给对象的属性表示 nil 值。dictionaryWithValuesForKeys: 的默认实现以及相关的 setValuesForKeysWithDictionary: 会在 NSNull（在字典的参数中）和 nil（在存储的属性中）之间自动转换。

当你使用 key path 来定位一个属性时，如果 key path 中的最终 key 是对多关系（即它引用了集合），返回值会是一个根据 key到对多 key 的右侧的包含了所有值的集合。比如，请求 key path transactions.payee 的值会返回一个包含所有交易的所有payee 对象的数组，这在 key path 中对于可变数组也有效。accounts.transactions.payee 这个 key path 会返回所有账户中所有交易的所有 payee 对象。

### 使用 Keys 设置属性值

和 getters 方法一样，符合 KVC 的对象也会根据 NSObject 的 NSKeyValueCoding 协议基于默认行为的实现提供一组小的通用的 setters：  

* setValue:forKey: -以给定值给相关对象的接受者根据特定 key 设置值。setValue:forKey: 的默认实现会自动的解包NSNumber 和 NSValue 对象为标量和结构体，然后将其赋值给属性。参见《表示非对对象值》了解封包和解包语法的细节。  
如果指定的 key 相关的属性，即接收 setter 的对象调用没有该属性的话，对象会发送一条 setValue:forUndefinedKey: 消息给其本身。setValue:forUndefinedKey: 的默认实现是生成一个 NSUndefinedKeyException 异常。不过子类可以重载该方法来处理自定义管理中的请求。
* setValue:forKeyPath: -根据指定 key path 相关的接收者设定给定值。任何在 key path 序列中的对象只要不符合给定 key 的 KVC 协议，就会收到一条 setValue:forUndefinedKey: 消息。
* setValuesForKeysWithDictionary: -使用指定字典中的值设置接受者的属性，使用字典的 key 来匹配属性。默认的 setValue:forKey: 调用的实现是每个键值对，根据需要用 nil 代替 NSNull 对象。

在默认实现中，当你试图用一个 nil 设置一个非对象的属性时，符合 KVC 的对象会给其自身发送一条 setNilValueForKey: 消息。 setNilValueForKey: 的默认实现是会生成一个 NSInvalidArgumentException 异常，但是对象可以重载该方法用一个默认值代替或者标记值代替，这在《处理非对象值》中有相关描述。

### 使用 Keys 来简化对象的访问

想要看下基于 key 的 getters 和 setters 是如何简化你的代码的，请参考如下示例。在 macOS 中，NSTableView 和 NSOutlineView 对象会给每行关联一个标识符字符串。如果在列表后的模型对象不符合  KVC，列表的数据源方法会强制检查每行的标识符，目的为了查找到正确的属性返回，如 清单2-2 所示。更甚者，在未来，当你添加另一个属性给你的模型对象时，本例中是 Person 对象，你必须再重新过一遍数据源方法，添加其他的条件来为新的属性和返回相关值来进行测试。

清单2-2 不使用 KVC 实现数据源方法  

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

另一方面，清单2-3 展示了一个更加简洁的同样的数据源方法的实现，它利用了符合 KVC 的 Person 对象。仅使用了 valueForKey: 获取，数据源方法使用列的标识符作为 key 返回了恰当的值。为了更加简短，也更加通用，由于需要在随后添加新行时能够持续作用，只要行的标识符始终符合模型对象的属性名即可。

清单2-3 使用 KVC 实现数据源方法 

	- (id)tableView:(NSTableView *)tableview objectValueForTableColumn:(id)column row:(NSInteger)row
	{
	    return [[self.people objectAtIndex:row] valueForKey:[column identifier]];
	}

## 访问集合属性

和暴露其他属性一样，符合 KVC 的对象会以同样的方式暴露它们的对多的属性。你可以使用 get 或 set 一个集合对象，就像你对其他的对象那样使用 valueForKey: 和 setValue:forKey:（或者同样的使用 key path）。不过，当你想要操作这些集合的内容的时候，通常使用协议定义的可变的代理方法更为高效。  
协议定义了三个不同的代理方法用于集合对象的访问，每个都有一个 key 和 key path 变体：  

* mutableArrayValueForKey: 和 mutableArrayValueForKeyPath: 这些会返回一个代理对象，它的行为表现的就像一个 NSMutableArray 对象。
* mutableSetValueForKey: 和 mutableSetValueForKeyPath: 这些会返回一个代理对象，它的行为表现的就像一个 NSMutableSet 对象。
* mutableOrderedSetValueForKey: 和 mutableOrderedSetValueForKeyPath: 这些会返回一个代理对象，它的行为表现的就像一个 NSMutableOrderedSet 对象。

当你操作协议对象的时候，给它添加对象，移除对象，或者替换它当中的对象，协议的默认实现会修改相应的底层属性。这比用valueForKey: 持有一个不可变的集合对象，创建一个修改内容的方法，然后用 setValue:forKey: 消息将其存储回对象更加高效。在很多情况下，它也比直接操作一个可变属性更加高效。这些方法对于集合对象中持有的对象符合 KVO 提供了额外的收益（参见《KVO 编程指南》了解细节）。

## 使用集合操作符

当你给一个符合 KVC 的对象发送 valueForKeyPath: 消息时，你可以在 key path 中嵌入一个集合操作符。集合操作符是一小组由符号@开头的关键字，它指定了一个操作来执行某种方式在数据返回之前进行操作。valueForKeyPath: 的默认实现是由 NSObject 实现这种行为。  
当一个 key path 包含一个集合操作符时，任何在操作符之前的 key path 部分被称作左 key path，表明操作相关的集合与消息接收者关联。如果你直接给一个集合对象发送消息，比如 NSArray 实例，左 key path 可能被省略。  
操作符之后的 key path 部分被称作右 key path，指定集合中操作符作用的属性。所有的集合操作符（除了 @count）都需要一个右 key path。如图 4-1 所示操作符 key path 格式。

图4-1 操作符key path格式  

![](https://developer.apple.com/library/archive/documentation/Cocoa/Conceptual/KeyValueCoding/art/keypath.jpg)

集合操作符展示了三种基本行为类型：  

* 聚合操作 以某种方式合并一个集合的对象，并返回一个对象，该对象通常会匹配右 key path 中命名的属性的数据类型。@count 操作符是一个例外——它没有右 key path，并始终返回一个 NSNumber 实例。
* 数组操作 返回一个 NSArray 实例，它包含某些集合中持有的对象的子集。
* 嵌套操作 作用于包含其他集合的集合中，根据操作符不同返回一个 NSArray 或 NSSet 实例，它会以某种方式将嵌套集合的对象结合起来。

### 示例数据

下述包含的代码块描述了你该如何调用每个操作符，以及结果是什么。这依赖于 BankAccount 类，展示在 清单2-1 中，它持有一个 Transaction 对象的数组。如 清单4-1 所示，每个都代表一个单一的支票簿实体。  

清单4-1 Transaction对象的接口声明  

	@interface Transaction : NSObject
	 
	@property (nonatomic) NSString* payee;   // To whom
	@property (nonatomic) NSNumber* amount;  // How much
	@property (nonatomic) NSDate* date;      // When
	 
	@end

出于讨论的目的，假设你的 BankAccount 实例有一个由 列表4-1 中所示数据组成的事物数据，并且由内部的 BankAccount 对象所调用。  

列表 4-1 Transactions 对象的示例数据  

payee 值  | amount 值格式化为货币 | date 值格式化为月日年
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

聚合操作符无论是在数组还是一组属性中都可用，它会产出一个反映集合的某些方面的值。

#### @avg

当你指定 @avg 操作符时，valueForKeyPath：会读取集合中每个元素右 key path 指定的属性。转换为一个 double 类型（代替0 或者 nil值），并计算它们的算术平均值。然后会返回一个存储在 NSNumber 实例中的结果。  
要获取列表4-1中的示例代码的平均值事物数量：                     
                                          
	NSNumber *transactionAverage = [self.transactions valueForKeyPath:@"@avg.amount"];

格式化后 transactionAverage 的结果是 ¥456.54。

#### @count

当你指定 @count 操作符的时候，valueForKeyPath：会返回一个 NSNumber 实例，它是集合中的元素个数。如果有右侧 key path会被省略。  
要获得 transactions 中 Transaction 的数量：  

	NSNumber *numberOfTransactions = [self.transactions valueForKeyPath:@"@count"];
	
numberOfTransactions 的值是 13。

#### @max

当你指定 @max 操作符的时候，valueForKeyPath：方法会沿着集合名称通过右侧 key path 和返回的最大值来进行寻找。检索行为的比较是使用的 compare: 方法，这在很多 Foundation 类中都有定义，比如 NSNumber 类。所以，通过右侧 key path 表示的属性必须持有一个对象，并能够有意义的响应这个消息。检索时会忽略集合条目的 nil 值。  
要获得日期值的最大值，即最近的交易日期，通过 列表4-1 中的交易列表：  

	NSDate *latestDate = [self.transactions valueForKeyPath:@"@max.date"];

格式化的 latestDate 值是 Jul 15, 2016。

#### @min

当你指定 @min 操作符的时候，valueForKeyPath：方法会沿着集合名称通过右侧 key path 和返回的最小值来进行寻找。检索行为的比较是使用的 compare: 方法，这在很多 Foundation 类中都有定义，比如NSNumber类。所以，通过右侧 key path 表示的属性必须持有一个对象，并能够有意义的响应这个消息。检索时会忽略集合条目的nil值。  
要获得日期值的最小值，即最早的交易日期，通过 列表4-1 中的交易列表：  

	NSDate *earliestDate = [self.transactions valueForKeyPath:@"@min.date"];

格式化的 earliestDate 值是 Dec 1, 2015。

#### @sum

当你指定 @sum 操作符时，valueForKeyPath：会读取集合中每个元素右 key path 指定的属性。转换为一个 double 类型（代替 0 或者 nil 值），并计算它们的和。然后会返回一个存储在 NSNumber 实例中的结果。  
要获取 列表4-1 中的示例代码的事物数量和：           

	NSNumber *amountSum = [self.transactions valueForKeyPath:@"@sum.amount"];

格式化的 amountSum 结果是 $5,935.00。

### 数组操作符

数组操作符会触发 valueForKeyPath: 方法，返回一个由右侧 key path 表示的相应地特定集合的对象的一组数组对象。  

>	重要：  
valueForKeyPath: 方法在使用数组操作符时，遇到任何子节点对象是 nil 的时候会产生异常。

#### @distinctUnionOfObjects

当你指定 @distinctUnionOfObjects 操作符的时候，valueForKeyPath：会创建并返回一个通过右侧 key path 指定的集合中相应属性的不同对象。  
要获取一个 payee 属性值的集合，省略重复值的 transactions 中的事物：  

	NSArray *distinctPayees = [self.transactions valueForKeyPath:@"@distinctUnionOfObjects.payee"];

结果 distinctPayees 数组会包含一个实例，即下述字符串： Car Loan, General Cable, Animal Hospital, Green Power, Mortgage。

>	注意  
@unionOfObjects 操作符提供类似行为，但不会移除重复对象。

#### @unionOfObjects

当你指定 @unionOfObjects 操作符的时候，valueForKeyPath：会创建并返回一个通过右侧 key path 指定的集合中相应属性的所有对象。与 @distinctUnionOfObjects 不同，重复的对象不会被移除。  
要获取一个 payee 属性值的集合，取到 transactions 中的事物：  

	NSArray *payees = [self.transactions valueForKeyPath:@"@unionOfObjects.payee"];

结果 payees 数组会下述字符串：Green Power, Green Power, Green Power, Car Loan, Car Loan, Car Loan, General Cable, General Cable, General Cable, Mortgage, Mortgage, Mortgage, Animal Hospital。注意重复。

>	注意  
@distinctUnionOfArrays 操作符提供类似行为，但会移除重复对象。

### 嵌套操作符

嵌套操作符是作用于嵌套集合的，即每个集合本身还包含了一个集合。  

>	重要  
valueForKeyPath: 方法在使用嵌套操作符时，遇到任何子节点对象是 nil 的时候会产生异常。

为后续介绍，假设有第二个数据数组叫做 moreTransactions，构成 列表4-2 中的数据，它是集合了原始的 transactions 数组（引自“示例数据”一节）为一个嵌套数组：  

	NSArray* moreTransactions = @[<# transaction data #>];
	NSArray* arrayOfArrays = @[self.transactions, moreTransactions];

列表4-2 假设 moreTransactions 数组中的 Transaction 数据  

payee 值  | amount值格式化为货币 | date 值格式化为月日年
------------- | ------------- | -------------
General Cable - Cottage  | $120.00 | Dec 18, 2015
General Cable - Cottage  | $155.00 | Jan 9, 2016
General Cable - Cottage  | $120.00 | Dec 1, 2016
Second Mortgage  | $1,250.00 | Nov 15, 2016
Second Mortgage  | $1,250.00 | Sep 20, 2016
Second Mortgage  | $1,250.00 | Feb 12, 2016
Hobby Shop  | $600.00 | Jun 14, 2016

#### @distinctUnionOfArrays

当你指定 @distinctUnionOfArrays 操作符时，valueForKeyPath：会创建并返回一个数组，该数组包含通过右侧 key path 所指定的结合所有集合相应属性的不同对象。  
要在所有的 arrayOfArrays：中的数组中获取不同的 payee 值：  
	
	NSArray *collectedDistinctPayees = [arrayOfArrays valueForKeyPath:@"@distinctUnionOfArrays.payee"];

结果 collectedDistinctPayees 数组包含以下值：Hobby Shop, Mortgage, Animal Hospital, Second Mortgage, Car Loan, General Cable - Cottage, General Cable, Green Power。

>	注意  
@unionOfArrays 操作符类似，但不移除重复对象。

#### @unionOfArrays

当你指定 @unionOfArrays 操作符时，valueForKeyPath：会创建并返回一个数组，该数组包含通过右侧 key path 所指定的结合所有集合相应的属性的不同对象，而不移除重复项。  
要在所有的 arrayOfArrays：中的数组中获取不同的 payee 值：  

	NSArray *collectedPayees = [arrayOfArrays valueForKeyPath:@"@unionOfArrays.payee"];

结果 collectedDistinctPayees 数组包含以下值：Green Power, Green Power, Green Power, Car Loan, Car Loan, Car Loan, General Cable, General Cable, General Cable, Mortgage, Mortgage, Mortgage, Animal Hospital, General Cable - Cottage, General Cable - Cottage, General Cable - Cottage, Second Mortgage, Second Mortgage, Second Mortgage, Hobby Shop。

>	注意  
@distinctUnionOfArrays 操作符类似，但移除重复对象。

#### @distinctUnionOfSets

当你指定 @distinctUnionOfSets 操作符时，valueForKeyPath：会创建并返回一个 NSSet 对象，该对象包含通过右侧 key path 所指定的结合所有集合相应的属性的不同对象，而不移除重复项。  
这个操作符的行为类似 @distinctUnionOfArrays，只不过它要的是一个 NSSet 实例，是一个包含 NSSet 对象的实例，而非一个 NSArray 包含 NSArray 的实例。同样的，它会返回一个 NSSet 实例。假设示例数据已经被存在一个集合而非数组中，示例调用和结果也会和 @distinctUnionOfArrays 展示的一样。

## 表示非对象值

KVC 协议方法的默认实现由 NSObject 提供，同时作用于对象和非对象属性。默认实现会自动的从对象参数或返回值到非对象属性之间进行转换。这让基于 key 签名的 getter 和 setter 能够保持不变，即使存储的属性是一个标量或者结构体。  

>	注意  
	由于所有 Swift 中的属性都是对象，本段落只应用于OC属性。

当你调用协议中的一个 getter 方法时，类似 valueForKey:，默认的实现会判断特定的访问方法或者实例变量（根据“存取搜索模式”中描述的规则支持的特定 key 和值）。若返回值不是一个对象，getter 会使用该值初始化一个 NSNumber 对象（对于标量而言），或一个 NSValue 对象（对于结构体而言）然后将其返回。  
默认的，类似 setValue:forKey: 的 setter 方法会根据存取属性或实例变量判断数据类型，给定一个特定的 key。若数据类型不是一个对象，setter 首先会发送一个适当的 `<type>Value` 消息给到来的值对象来提取底层数据，然后将其存储。  

>	注意  
	当你调用一个 KVC 协议的 setter 方法，设置一个 nil 值给非对象属性时，setter 并不会察觉，照常触发动作来应用。然后，它会发送一条 setNilValueForKey: 消息给对象接收者的 setter 调用。该方法的默认实现会产生 NSInvalidArgumentException 异常，但子类可以重写这个方法的行为，在“处理非对象值”中有相关描述，所以请设置标记值，或提供一个有意义的默认值。

### 封包和解包标量类型

列表5-1 列出了默认 KVC 使用 NSNumber 实例实现封装的标量类型。对于每种数据类型，列表都展示了用来从底层属性值创建一个 NSNumber 实例的方法到支持一个 getter 返回值。随后展示了在 set 操作中用来从 setter 输入参数扩展值的存取方法。  

列表5-1 NSNumber对象中的封装标量  

数据类型  | 创建方法 | 存取方法
------------- | ------------- | -------------
BOOL| numberWithBool:| boolValue(iOS 中) charValue(macOS 中)
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
> 在macOS中，由于历史原因，BOOL 被定义成 signed char 类型，KVC 并不能区分两者。因此，当 key 是 BOOL 类型时，你不应该传递一个类似 @“true” 或 @“YES” 的字符串值给 setValue:forKey: 方法。KVC会试图调用 charValue（由于 BOOL 本质上就是一个char），但 NSString 没有实现该方法，这会引起运行时错误。取而代之的，当 key 是 BOOL 类型时，传递 NSNumber 对象，类似 @(1) 或 @(YES)，作为参数传递给 setValue:forKey:。这种限制不应该应用在 iOS 中，在 iOS 中 BOOL 类型被定义为一个本地化的布尔类型 bool，KVC 会调用 boolValue，这在 NSNumber 对象或者一个格式为 NSString 的对象中都能够起作用。

### 封包和解包结构体

列表5-2 展示了默认存取方法用来封包和解包常见 NSPoint, NSRange, NSRect, 和 NSSize 等结构体的创建和存取方法。

列表5-2 使用 NSValue 封装常用结构体类型  

数据类型  | 创建方法 | 存取方法
------------- | ------------- | -------------
NSPoint | valueWithPoint:| pointValue
NSRange | valueWithRange:| rangeValue
NSRect | valueWithRect:(macOS 有效)| rectValue
NSSize | valueWithSize:| sizeValue

自动的封包解包并不限于 NSPoint, NSRange, NSRect, 和 NSSize。结构体类型（意思是在 OC 字符串编码中以{开头的类型）都能被以一个 NSValue 对象封包。比如，看下 清单5-1 中声明的结构体和类接口。  

列表5-1 一个使用自定义结构体的示例类  

	typedef struct {
	    float x, y, z;
	} ThreeFloats;
	 
	@interface MyClass
	@property (nonatomic) ThreeFloats threeFloats;
	@end

使用这个叫做 myClass 的类的实例，你就能使用 KVC 获取 threeFloats 的值：  
	
	NSValue* result = [myClass valueForKey:@"threeFloats"];

valueForKey: 的默认实现调用了 threeFloats 的 getter 方法，然后返回以 NSValue 对象封装的结果。  
同样的，你可以使用 KVC 设置 threeFloats 的值：  

	ThreeFloats floats = {1., 2., 3.};
	NSValue* value = [NSValue valueWithBytes:&floats objCType:@encode(ThreeFloats)];
	[myClass setValue:value forKey:@"threeFloats"];

解包的默认实现是使用 getValue: 消息，然后用结果的结构体调用 setThreeFloats:。

## 校验属性

KVC 协议还定义了方法来支持校验属性。就像你使用基于 key 的存取方法来读写一个符合 KVC 的对象的属性一样，你也可以通过 key (或 key path)校验属性。当你调用 validateValue:forKey:error:（或 validateValue:forKeyPath:error:）方法时，协议的默认实现会搜索接收验证消息的对象（或在 key path 末尾的对象）以寻找名字符合模式 `validate<Key>:error:` 的方法。如果对象没有这个方法，默认校验成功，默认的实现返回YES。如果一个指定属性的校验方法存在，默认实现返回该方法的调用。  

> 注意  
> 通常只在OC中使用这里描述的校验。在 Swift 中，属性的校验通常由依赖的编译器所处理，支持可选和强类型检查，当使用内置的willSet 和 didSet 属性检测任何运行时的 API 关联，如《Swift 编程语言(Swift 3)》中所描述的“属性检测”一节。  

由于指定属性的校验方法接收的值和 error 参数是引用方式的，校验有三个可能的结果：  

1. 校验方法视值对象为有效，并返回  YES，并且不用改变值或者 error。
2. 校验方法视值对象无效，但选择不修改它。在这种情况下，方法会返回NO，并设置 error 引用（如果调用者提供的话）为一个 NSError 对象，并解释失败的原因。
3. 校验方法视值对象无效，但创建一个新的、有效的作为替代。在这种情况下，方法会返回 YES，并且不触碰 error 对象。在返回前，方法会修改值的引用，将其指向一个新的值对象。当作出一个改变的时候，方法始终会创建一个新的对象，而非修改旧的，即使是值对象是可变的。

清单 6-1 展示了一个如何调用名称字符串校验的例子。  
清单 6-1 校验名称属性  

	Person* person = [[Person alloc] init];
	NSError* error;
	NSString* name = @"John";
	if (![person validateValue:&name forKey:@"name" error:&error]) {
	    NSLog(@"%@",error);
	}

### 自动校验

通常来讲，无论是 KVC 协议，还是其默认实现定义的任何机制都不会自动执行校验。而你应该确保在你的应用中的适当位置使用校验方法。  
某些其他的 Cocoa 技术会在某些情况下自动执行校验。比如，Core Data 会在管理对象上下文被保存的时候自动的执行校验（参见《Core Data 编程指南》）。同样的，在 macOS 中，Cocoa 绑定能够让你指定校验应该自动的发生（参见《Cocoa 绑定编程话题》了解更多信息）。

## 存取器搜索模式

由 NSObject 提供的 NSKeyValueCoding 协议的默认实现使用了一组明确定义规则调用对象的底层属性来映射基于 key 的存取器。这些协议方法使用了一个 key 参数来检索它们自身的实例对象的存取方法、实例变量以及相关的遵循某个命名规范的方法。虽然你很少修改这些默认检索，但是了解它是如何工作的还是很有帮助的，既可以跟踪 KVC 对象的行为，也有助于使你自己的对象符合要求。

> 注意
> 本段使用的 `<key>` 或者 `<Key>` 是作为 key 字符串的占位符出现在 KVC 协议函数的一个参数当中的，随后该参数将会被作为一个二次调用的方法或者变量名所检索。映射的属性名遵从占位符的情况。比如，对于 getter 的 `<key>` 或者 `<Key>` ，属性名会隐藏映射到 hidden 和 isHidden。

### 基本的 getter 的检索模式

valueForKey: 的默认实现会将一个key作为输入参数，承载着以下程序，在类的实例接收到 valueForKey: 调用的时候进行操作：  

1. 从名称类似 get`<Key>`, `<key>`, `is<Key>`, 或 `_<key>`的实例的存取方法中以这种顺序首先进行检索。如果找到，调用它，然后跳转到第五步作为结果。否则执行下一步。  
2. 如果没有直接查找到存取方法，沿着名称匹配模式 `countOf<Key>` 和 `objectIn<Key>AtIndex:` (相关方法由 NSArray  类最初定义) 以及 `<key>AtIndexes:` (对应 NSArray 的 objectsAtIndexes: 方法) 的实例进行查找。  
如果这些当中的第一个，或者至少在另外两个当中的一个被找到了，创建一个集合代理对象，该对象会响应所有的 NSArray 方法并将其返回。否则，执行步骤3。  
代理对象随后会转换任何它所接收的 NSArray 消息给一些 `countOf<Key>`, `objectIn<Key>AtIndex:`, 和 `<key>AtIndexes:` 消息的组合，给它创建的符合 KVC 协议的对象发消息。如果原对象也实现了名称类似 `get<Key>:range:` 的可选方法，代理对象也会在适当的时机使用它。实际上，代理对象会和符合 KVC 的对象共同协作，让底层属性表现的像一个 NSArray，即使它没有这个对象。
3. 如果没有找到简单的存取方法或者一组数组存取方法，会查找三个名为 `countOf<Key>`, `enumeratorOf<Key>`, 和 `memberOf<Key>:` 的方法（相关的原始方法被 NSSet 类定义）。  
如果三个方法都被找到，会创建一个集合代理对象，该对象会响应所有的 NSSet 方法并将其返回。否则，跳转到步骤4。  
这个代理对象随后会转换所有它所接收到的 NSSet 的消息，结合 `countOf<Key>`, `enumeratorOf<Key>`, 和 `memberOf<Key>:` 消息给到它所创建的对象。实际上，代理对象会和符合 KVC 的对象共同协作，让底层属性的表象像一个 NSSet，即使它没有这个对象。
4. 如果没有找到简单的存取方法或者一组集合存取方法，并且接收者的类方法 accessInstanceVariablesDirectly 返回的 YES，这时会按顺序检索名为 `_<key>`, `_is<Key>`, `<key>`, 或 `is<Key>` 的实例变量。如果找到，直接获取该实例变量的值，然后执行步骤5。否则，跳转到步骤6。
5. 如果接收到的属性值是一个对象指针，直接返回结果。  
如果值是一个 NSNumber 所支持的标量，将其存储为一个 NSNumber 实例，并将其返回。  
如果值是一个 NSNumber 不支持的标量，将其转换为 NSValue 对象，并将其返回。
6. 如果所有的 else 都失败了，调用 valueForUndefinedKey:。这默认会产生一个异常，但 NSObject 的子类可以提供指定 key 的行为。

### 基本的setter的检索模式

默认的 setValue:forKey: 实现是给定 key 和 value 作为输入参数，会尝试使用一个名为 key 的属性设置 value（对于非对象属性，会使用解包 value 的版本，如“展示非对象值”一节中所描述）内部对象会接收调用，使用步骤如下：  

1. 首先按顺序查找名为`set<Key>:` 或 `_set<Key>`的存取方法。如果找到了，调用它，传入输入值（或根据需要的解包值）并结束。
2. 如果没有直接查找到存取方法，若类方法 accessInstanceVariablesDirectly 返回 YES，按顺序查找名为 `_<key>`, `_is<Key>`, `<key>`, 或 `is<Key>` 的实例变量。如果找到，直接以输入值（或解包值）设置该实例变量并结束。
3. 上述存取器或实例变量都没找到，调用 setValue:forUndefinedKey:。这会默认生成一个异常，但 NSObject 的子类可以提供指定 key 的行为。

### 可变数组的检索模式

mutableArrayValueForKey: 的默认实现，给定一个key作为输入参数，返回一个可变代理数组给名为key的属性，让内部的对象接收存取器调用，使用如下步骤：  

1. 查找成对的名为 `insertObject:in<Key>AtIndex:` 和 `removeObjectFrom<Key>AtIndex:` 的方法（分别对应 NSMutableArray 的 insertObject:atIndex: 和 removeObjectAtIndex: 方法），或者是名为 `insert<Key>:atIndexes:` 和 `remove<Key>AtIndexes:` （分别对应 NSMutableArray 的 insertObjects:atIndexes: 和 removeObjectsAtIndexes: 方法）的方法。)  
若对象至少有一个插入和移除方法，这时会返回一个通过发送 `insertObject:in<Key>AtIndex:`, `removeObjectFrom<Key>AtIndex:`, `insert<Key>:atIndexes:`, 和 `remove<Key>AtIndexes:` 消息来响应NSMutableArray 的消息代理对象，消息发送给原 mutableArrayValueForKey: 的接收者。  
当对象接收到 mutableArrayValueForKey: 消息，并且实现了一个名为 `replaceObjectIn<Key>AtIndex:withObject:` 或 `replace<Key>AtIndexes:with<Key>:` 的可选的替代对象方法，代理对象会在适当的时机利用这些方法达到最佳性能。  
2. 如果对象没有可变数组方法，回开始查找名称匹配 `set<Key>:` 模式的存取方法作为替代。在这种情况下，返回一个响应 NSMutableArray 消息的代理对象，消息会发送到原来的 mutableArrayValueForKey: 的接收者。  

	> 注意   
	> 这个步骤所描述的机制要远比前一步骤低效，因为它可能包含重复创建新的集合对象，而非修改一个已经存在的。所以，你应该在设计你自己的复合 KVC 的对象时候避免。
3. 如果既没有可变数组方法，也没有存取方法被发现，当接收者的类方法 accessInstanceVariablesDirectly 返回 YES 时，会开始按顺序检索实例变量的名为 `_<key>` 或 `<key>` 方法。  
	如果发现了实例变量，返回一个代理方法，它会转发它所接收到的 NSMutableArray 消息给实例变量的值，这通常是一个 NSMutableArray 的实例，或者它的一个子类。  
4. 如果所有 else 都失败了，无论何时接收到 NSMutableArray 的消息，都会返回一个可变集合代理对象，并生成一个 setValue:forUndefinedKey: 消息给原  mutableArrayValueForKey: 消息的接收者。  
setValue:forUndefinedKey: 的默认实现会产生一个 NSUndefinedKeyException 异常，但它的子类可以重写该行为。

### 可变有序集合的检索模式

mutableOrderedSetValueForKey: 的默认实现会识别相同的简单存取方法，类似 valueForKey: 的有序集合存方法（参见《基本 getter 的默认检索模式》），并遵循相同的实例变量访问规则，但始终返回一个可变的集合代理对象，而非一个 valueForKey: 返回的不可变的集合。此外，它还做了以下几点：  

1. 检索名称类似 insertObject:in<Key>AtIndex: 和 removeObjectFrom<Key>AtIndex: 的方法（对应 NSMutableOrderedSet 类定义的两个方法），以及 insert<Key>:atIndexes: 和 remove<Key>AtIndexes: （对应 insertObjects:atIndexes: 和 removeObjectsAtIndexes:）。  
如果至少有一个插入方法和移除方法被查找到了，当 mutableOrderedSetValueForKey: 消息的原始接收者接收到 NSMutableOrderedSet 消息时，返回的代理对象会发送 insertObject:in<Key>AtIndex:, removeObjectFrom<Key>AtIndex:, insert<Key>:atIndexes:, 和 remove<Key>AtIndexes: 的消息集合。  
当原对象当中已经存在类似方法，代理对象还会使用类似 replaceObjectIn<Key>AtIndex:withObject: 或 replace<Key>AtIndexes:with<Key>: 的方法。
2. 如果可变集合方法没有被查找到，会检索名称类似 `set<Key>:` 的存取方法。在这种情况下，返回的代理对象每当接收到一条 NSMutableOrderedSet 的消息就会发送一条 `set<Key>:` 消息给 mutableOrderedSetValueForKey: 的原消息接收者。
> 注意  
本步骤描述的机制比前一步骤低效的多，因为它可能包含重复创建新的集合对象，而非修改一个已经存在的。所以，你应该尽量避免在设计你自己的 KVC 对象中使用。

3. 如果无论是可变集合消息或者是存取方法都没查找到，如果接收者的 accessInstanceVariablesDirectly 类方法返回 YES，会按顺序开始检索名称类似 `_<key>` 或 `<key>` 的实例变量。如果有一个这样的实例变量被查找到，返回的代理对象会转发任何它接收到的 NSMutableOrderedSet 的消息给实例变量的值，这和一个 NSMutableOrderedSet 的实例或者其子类类似。 
4. 如果所有的 else 都失败了，返回的代理对象会在接收到一个可变集合消息的时候发送一条 setValue:forUndefinedKey: 消息给原 mutableOrderedSetValueForKey: 消息的接收者。  
setValue:forUndefinedKey: 的默认实现是产生一个 NSUndefinedKeyException 异常，单对象可以重写这一行为。

### 可变集合的检索模式

mutableSetValueForKey: 的默认实现会给定一个 key 作为输入，返回一个可变代理集合，名为 key 的一个数组属性在其中接受存取方法调用，使用如下步骤：  

1. 检索名称类似 `add<Key>Object:` 和 `remove<Key>Object:` 的方法（分别对应 NSMutableSet 的 addObject: 和 removeObject: 方法）以及 `add<Key>:` 和 `remove<Key>:` （对应 NSMutableSet 的 unionSet: 和 minusSet:）。如果至少有一额增加方法和一个移除方法被查找到，返回一个代理对象会在接收到 NSMutableSet 消息的时候发送 `add<Key>Object:`, `remove<Key>Object:`, `add<Key>:`, 和 `remove<Key>:` 消息集合给原 mutableSetValueForKey: 的接收者。
2. 如果 mutableSetValueForKey: 的接收者的调用时一个 managed 对象，如果是非managed 对象的话，检索模式不会继续。参见《Core Data 编程指南》中的 管理对象存取方法 了解更多信息。
3. 如果可变集合方法没被查到，并且如果对象不是一个 managed 对象，会查找类似 `set<Key>:` 的存取方法。如果该方法被查找到，返回的代理对象会在接收到 NSMutableSet 消息的时候发送一条 `set<Key>:` 消息给 mutableSetValueForKey: 的消息接收者。
> 注意  
本步骤描述的机制比第一步骤低效的多，因为它可能包含重复创建新的集合对象，而非修改一个已经存在的。所以，你应该尽量避免在设计你自己的 KVC 对象中使用。

4. 如果可变集合方法和存取方法都没查到，并且如果接收者的 accessInstanceVariablesDirectly 类方法返回 YES，会按顺序开始检索名称类似 `_<key>` 或 `<key>` 的实例变量。如果有一个这样的实例变量被查找到，返回的代理对象会转发任何它接收到的 NSMutableSet 的消息给实例变量的值，这和一个 NSMutableSet 的实例或者其子类类似。
5. 如果所有的 else 都失败了，返回的代理对象会在接收到一个 NSMutableSet 消息的时候发送一条 setValue:forUndefinedKey: 消息给原 mutableSetValueForKey: 消息的接收者。  

# 采用KVC
## 实现基本的 KVC 合规

当给一个对象采用了 KVC，你就可以通过让你的对象继承自 NSObject（或其众多的子类之一）来获得 NSKeyValueCoding 协议的默认实现了。反过来说，默认的实现依赖于你定义你的对象的实例变量（或者 ivars）以及遵循特定的定义好的模式的存取方法了，这样，它就能够在接收到键值编码方法(比如 valueForKey: 和 setValue:forKey:)时通过字符串 key 关联属性。  
通常遵守 OC 中的标准模式，只需要使用 @property 语句，然后编译器会自动合成 ivar 和存取器方法。编译器默认遵循预期模式。  

> 注意  
> 在 Swift 中，直接以常用方式声明一个属性会自动生成适当的存取方法，你无需与 ivars 进行交互。更多关于 Swift 中的属性相关信息，阅读《Swift 编程语言指南》中的“属性”部分。有关 Swift 与 OC 属性交互的信息，阅读《使用 Swift 与 Cocoa 和 OC》中的访问属性一节。

如果你确实在 OC 中需要手动实现存取方法或者 ivars，遵循本章节中的指南来维护基本的遵循协议。在任何语言中要提供额外的功能来提高你的对象的集合属性，实现《定义集合方法》中的“实现方法”所描述的。要进一步提高你的对象的键值对校验，实现《增加校验》中所描述的方法。  

> 注意  
> 默认的 KVC 实现在 ivars 和 存取方法中作用的范围比本文描述的更广泛。如果你有遗留代码使用了其他变量或者存取方法的转换，请根据《存取方法的检索模式》中的检索描述进行检测来判断默认实现是否能够覆盖你的对象的属性。 

### 基本的 getters

要实现一个返回一个属性值的 getter 方法，这时可能需要添加一些额外的自定义工作，使用一个类似于属性的方法名，比如 title 字符串属性：  

	- (NSString*)title
	{
	   // Extra getter logic…
	 
	   return _title;
	}

对于处理布尔值的属性，你可以使用一个前缀是 is 的方法作为替代，比如对于 hidden 布尔属性：  
	
	- (BOOL)isHidden
	{
	   // Extra getter logic…
	 
	   return _hidden;
	}

当属性是一个标量或者是一个结构体时，KVC 的默认实现会以一个对象来封装该值，用来作为协议方法的接口，如《表示非对象值》中所描述的那样。你不需要做任何特殊的事情来支持这一行为。

### 基本的 setters

实现一个 setter 来存储一个属性的值，使用一个前缀为 set 的大写字母开头的属性。对于 hidden 属性：  

	- (void)setHidden:(BOOL)hidden
	{
	    // Extra setter logic…
	 
	   _hidden = hidden;
	}

> 警告  
> 永远不要在《校验属性》中描述的校验方法中调用 `set<Key>:` 方法。

当一个属性是一个非对象类型的时候，比如一个布尔值 hidden，协议的默认实现会检测底层数据类型，在该值应用在你的 setter 方法之前，从 setValue:forKey: 解包对象的值（在本例中是一个 NSNumber 实例），如《展示非对象值》中所描述的那样。你不需要自己在 setter 中处理这种情况。不过，如果有可能是一个 nil 值被写入到你的非对象属性中，你可以重写 setNilValueForKey: 来处理这种情况，如《展示非对象值》中所描述的那样。对于 hidden 属性而言，一个比较恰当的行为是直接将 nil 解释为 NO： 

	- (void)setNilValueForKey:(NSString *)key
	{
	    if ([key isEqualToString:@"hidden"]) {
	        [self setValue:@(NO) forKey:@”hidden”];
	    } else {
	        [super setNilValueForKey:key];
	    }
	}

如果时机合适的话，你可以提供上述方法重写，即使是在你允许编译器自动合成 setter 的时候。  

### 实例变量

当一个 KVC 的存取方法的默认实现不能够找到属性的存取方法时，它会检测类方法 accessInstanceVariablesDirectly 来看下类是否允许直接使用实例变量。默认的，该类方法返回 YES，不过你可以重写该方法返回 NO。  
如果你确实允许使用 ivars，要确保它们的命名是常用方式，使用属性名前缀是下划线(_)。通常来讲，编译器在自动合成属性的时候已经为你做了这件事，不过如果你直接使用 @synthesize 命令，你可以强制命名：  

	@synthesize title = _title;
	
在某些情况下，代替使用 @synthesize 指令或者直接让编译器自动合成一个属性，你可以使用 @dynamic 命令直接通知编译器你可能要在运行时提供 getter 和 setter 方法。你可能这么做来避免自动合成 getter，以便你能够提供集合存取方法作为替代，如《定义集合方法》中所描述的那样。在本例中你自己声明 ivar 作为接口声明的一部分：  
	
	@interface MyObject : NSObject {
	    NSString* _title;
	}
	 
	@property (nonatomic) NSString* title;
	 
	@end

## 定义集合方法

当你使用标准命名规则创建一个存取方法以及 ivars 时，如《实现基本的 KVC 合规》中所描述，KVC 协议的默认实现能够定位它以响应 KVC 消息。对于表现多种关系的集合对象，与其他属性一样，也是如此。不过，如果你实现了集合存取方法作为替代，或者作为附加，基本的集合属性的存取方法，你可以：  

- 模拟于 NSArray 或 NSSet 以外的类的多种关系。当你在你的对象中实现集合方法，默认的键值 getter 的实现会返回一个代理对象，该对象会调用这些方法以响应随后接收的 NSArray 或 NSSet 消息。底层的属性对象无需是 NSArray 或 NSSet 本身，因为代理对象使用你的集合方法提供了预期行为。
- 当转变一个对多关系的内容时达到增加性能的作用。代替了用基本的 setter 重复创建新的集合对象以响应每个变更，协议的默认实现使用了你的集合方法来修改底层属性。
- 提供遵从 KVO 访问你的对象的集合属性的内容的功能。更多关于 KVO 的信息，阅读《KVO 编程指南》。

你实现集合存取方法的两个分类中的其中一个，取决于你是否要让关系表现的像一个索引，有序集合（就像 NSArray 对象）或者无序的，唯一性的集合（就像 NSSet 对象）。另一方面，实现至少一个方法的集合来支持属性的读取，并添加额外的集合来允许修改集合内容。

> 注意  
>  在本章中没有描述 KVC 协议声明的方法。由 NSObject 提供的协议的默认实现会在你的遵循 KVC 的对象中进行查找，如《存取器检索模式》中所描述的那样，然后使用它们来处理 KVC 消息作为协议的一部分。

### 访问索引集合

你可以给有序关系添加索引存取方法给计数，取回，增加和替换对象等提供机制。底层对象通常是一个 NSArray 或 NSMutableArray 的实例，不过如果你提供了集合存取方法，你就能够让实现这些方法的对象的属性表现的像一个数组一样。  

#### 索引集合的getter

对于一个没有默认 getter 的集合属性而言，如果你提供了以下的索引集合 getter 方法，协议的默认实现会响应 valueForKey: 消息，返回一个代理对象表现的像是一个 NSArray，但调用的是如下的集合方法做的这件事。  

> 注意  
> 在现代 OC 当中，编译器给每个属性默认的合成了 getter，所以默认的实现不会创建一个只读的代理来使用本章节中的方法（注意《基本的 getter 的检索模式》中描述的存取方法的检索顺序）。你可以通过不声明属性（完全依赖一个 ivar）或者使用 @dynamic 声明一个属性（这标志着你打算在运行时支持存取方法）就能达到这一点。无论哪种方法，编译器都不会提供一个默认的 getter，默认的实现会使用如下方法。

* `countOf<Key>`

该方法会返回一个一对多关系中的对象的数量，NSUInteger类型。就像 NSArray 的原始方法 count。实际上，当底层的属性是一个 NSArray，你可以使用它来提供结果。  
比如，对于一对多关系，展示一系列银行交易并返回一个叫做 transactions 的 NSArray：  

	- (NSUInteger)countOfTransactions {
	    return [self.transactions count];
	}

* `objectIn<Key>AtIndex:` 或者 `<key>AtIndexes:`

第一个方法返回的对象是在对多关系中的指定索引，而第二个方法返回的对象的数组是 NSIndexSet 参数指定的索引集合的对象。这些分别对应 NSArray 的方法 objectAtIndex: 和 objectsAtIndexes:。你只需要实现其中一个。相应的 transactions 数组方法是：  

	- (id)objectInTransactionsAtIndex:(NSUInteger)index {
	    return [self.transactions objectAtIndex:index];
	}
	 
	- (NSArray *)transactionsAtIndexes:(NSIndexSet *)indexes {
	    return [self.transactions objectsAtIndexes:indexes];
	}

* `get<Key>:range:`

该方法是可选的，但可以增加性能。它会返回在一定指定范围内的对象的集合，相对应 NSArray 的方法 getObjects:range:。transactions 数组的实现是：  

	- (void)getTransactions:(Transaction * __unsafe_unretained *)buffer
               range:(NSRange)inRange {
	    [self.transactions getObjects:buffer range:inRange];
	}

#### 索引集合的改变

要用索引存取方法支持一个可变的对多关系需要实现一组不同的方法。当你提供这些 setter 方法时，默认的实现会响应 mutableArrayValueForKey: 消息，返回一个代理对象，行为表现的像 NSMutableArray 对象，但你可以用你的对象的方法来做这些事。这通常比直接返回一个 NSMutableArray 对象更高效。这还能让对多关系的内容符合 KVO（参见《KVO 编程指南》）。  
为了能够让你的的对象对于可变有序关系符合 KVC，实现下述方法：  

* `insertObject:in<Key>AtIndex:` 或 `insert<Key>:atIndexes:`

第一个方法接收要插入的对象和一个 NSUInteger 类型的指定的需要插入的索引。第二个方法插入一组对象到集合中，通过指定的 NSIndexSet 的索引。这与 NSMutableArray 的 insertObject:atIndex: 和 insertObjects:atIndexes: 方法类似。这些方法只有一个是必须实现的。  
对于一个 transactions 对象声明一个 NSMutableArray：  

	- (void)insertObject:(Transaction *)transaction
	  inTransactionsAtIndex:(NSUInteger)index {
	    [self.transactions insertObject:transaction atIndex:index];
	}
	 
	- (void)insertTransactions:(NSArray *)transactionArray
	              atIndexes:(NSIndexSet *)indexes {
	    [self.transactions insertObjects:transactionArray atIndexes:indexes];
	}
	
* `removeObjectFrom<Key>AtIndex:` 或 `remove<Key>AtIndexes:`  

第一个方法接收一个 NSUInteger 类型的值，指定需要从关系中移除的对象的索引。第二个方法接收一个 NSIndexSet 对象，指定需要从关系中移除的对象的索引集合。这些方法分别对应 NSMutableArray 的方法removeObjectAtIndex: 和 removeObjectsAtIndexes:。只需要实现这些方法的其中一个就行。   
对于 transactions 对象：  
	
	- (void)removeObjectFromTransactionsAtIndex:(NSUInteger)index {
	    [self.transactions removeObjectAtIndex:index];
	}
	 
	- (void)removeTransactionsAtIndexes:(NSIndexSet *)indexes {
	    [self.transactions removeObjectsAtIndexes:indexes];
	}

* `replaceObjectIn<Key>AtIndex:withObject:` 或者 `replace<Key>AtIndexes:with<Key>:`  

这些替代存取器提供代理对象，意在直接在集合中替代一个对象，无需连续的移除一个对象并添加另一个。它们对应 NSMutableArray 的方法 replaceObjectAtIndex:withObject: 和 replaceObjectsAtIndexes:withObjects:。当分析应用时，你可以选择性的提供这些方法，以显示性能问题。  
对于 transactions 对象：  

	- (void)replaceObjectInTransactionsAtIndex:(NSUInteger)index
                             withObject:(id)anObject {
	    [self.transactions replaceObjectAtIndex:index
	                              withObject:anObject];
	}
	 
	- (void)replaceTransactionsAtIndexes:(NSIndexSet *)indexes
	                    withTransactions:(NSArray *)transactionArray {
	    [self.transactions replaceObjectsAtIndexes:indexes
	                                withObjects:transactionArray];
	}

### 访问无序的集合

添加无序集合存取方法可以为无序关系中的对象的存取和修改提供机制。通常来讲，这种关系是一个 NSSet 或 NSMutableSet 对象的实例。不过，当你实现这些存取方法时，你就能够让任何类对于模型关系以及使用 KVC 操作了，就像该类有一个 NSSet 实例一样。  

#### 无序集合的获取

当你提供下述集合的获取方法来返回集合中对象的数量，迭代集合对象，以及检查一个对象是否已经存在于集合中时，协议的默认实现会反应 valueForKey: 消息，返回一个代理对象，表现的像一个 NSSet，但调用的是如下的集合方法来做的这些工作。  

> 注意  
> 在现代 OC 中，编译器会默认的给每个属性合成一个 getter，所以默认的实现不会创建一个只读的代理对象用到本章节的方法（注意 《基本的 getter 的检索模式》中的存取搜索顺序）。你可以声明一个属性（依赖于一个 ivar），或者声明一个 @dynamic 属性（这表示你打算在运行时支持存取方法的行为）就能够避免这一点。无论哪种方式，编译器都不会提供一个默认的 getter，默认的实现会使用下述方法。  

* `countOf<Key>`
	
这个必须实现的方法会返回关系中的元素数量，对应的 NSSet 的方法 count。当底层对象是一个 NSSet 时，你可以直接调用这个方法。比如，对于一个 NSSet 对象调用 employees，其中包含 Employee 对象的话：  
		
	-(NSUInteger)countOfEmployees {
	    return [self.employees count];
	}

* `enumeratorOf<Key>`

这个必须实现的方法会返回一个 NSEnumerator 实例，它用来迭代关系中的元素。参见《集合编程主题》中的“枚举：遍历一个集合的元素”部分了解更多关于枚举器的信息。该方法对应 NSSet 的 objectEnumerator 方法。对于 employees 集合：  

	-(NSEnumerator *)enumeratorOfEmployees {
	    return [self.employees objectEnumerator];
	}

* `memberOf<Key>:`

该方法会将一个需要比较的对象和集合的内容当作参数传递，并返回一个匹配的对象作为结果，如果没有查找到匹配的对象，返回nil。如果你手动实现了比较方法，通常使用 isEqual: 来比较对象。当底层对象是一个 NSSet 对象，你可以等价使用 member: 方法。

	-(Employee *)memberOfEmployees:(Employee *)anObject {
	    return [self.employees member:anObject];
	}

#### 无序集合的可变

用无序存取方法支持一个可变的对多关系需要实现额外的一些方法。实现可变的无序存取方法来让你的对象支持一个无序集合代理对象，以响应  mutableSetValueForKey: 方法。实现这些存取器比依赖于一个直接返回可变对象来在关系中作出改变数据要高效的多。这也让你的类对于集合对象符合来 KVO（参见《KVO编程指南》）。  
为了让一个可变的无序对多关系符合 KVC，需要实现以下方法：  

* `add<Key>Object:` 或 `add<Key>:`  

这些方法会给关系增加一个单独的元素或者一组元素。当添加一组元素给关系时，要确保相等的对象没有存在在关系当中。这些与 NSMutableSet 的方法 addObject: 和 unionSet: 类似。这两个方法只实现一个即可。对于 employees 集合：  

	- (void)addEmployeesObject:(Employee *)anObject {
	    [self.employees addObject:anObject];
	}
	 
	- (void)addEmployees:(NSSet *)manyObjects {
	    [self.employees unionSet:manyObjects];
	}

* `remove<Key>Object:` 或 `remove<Key>:`

这些方法会从关系中移除一个或一组元素。它们与 NSMutableSet 的  removeObject: 和 minusSet: 类似。只需要实现其中一个即可。比如：  

	- (void)removeEmployeesObject:(Employee *)anObject {
	    [self.employees removeObject:anObject];
	}
	 
	- (void)removeEmployees:(NSSet *)manyObjects {
	    [self.employees minusSet:manyObjects];
	}

* `intersect<Key>:`

该方法会接收一个 NSSet 参数，从关系中移除所有不是输入集合和集合本身的对象。这与 NSMutableSet 的方法 intersectSet: 等价。当分析有关集合内容的性能问题时你可以选择实现这个方法。比如：  

	- (void)intersectEmployees:(NSSet *)otherObjects {
	    return [self.employees intersectSet:otherObjects];
	}

## 处理非对象值

通常来讲，如同《展示非对象的值》中所描述的那样，你的符合 KVC 的对象会依赖于 KVC 自动封包和解包非对象属性的默认实现。不过，你可以重写默认行为。这样做最常见的原因是处理尝试存储一个 nil 值给非对象属性。  

> 注意  
> 由于在 Swift 中所有的属性都是对象，本章节只作用于 OC 属性。

如果你的复合 KVC 的对象通过 setValue:forKey: 消息接收到了一个 nil 作为值传递给非对象属性，那么默认实现是没有适当的、通用的操作过程的。它会给其自身发送 setNilValueForKey: 消息，这你可以重写。setNilValueForKey: 的默认实现会产生一个 NSInvalidArgumentException 异常，但你可以提供一个适当的，指定实现的行为。  
比如，清单10-1 中的代码是尝试将设置一个人的年龄为 nil 值替换为设置为0，这比一个浮点值更合适。注意重写的方法在不能够准确处理的某些 keys 时候会调用其对象的父类。  

清单10-1 setNilValueForKey: 的实现示例  

	- (void)setNilValueForKey:(NSString *)key
	{
	    if ([key isEqualToString:@"age"]) {
	        [self setValue:@(0) forKey:@”age”];
	    } else {
	        [super setNilValueForKey:key];
	    }
	}

> 注意  
> 对于向后兼容性，当一个对象重写了废弃的 unableToSetNilForKey: 方法，setValue:forKey: 会调用该方法代替 setNilValueForKey:。

## 增加校验

KVC 协议定义了方法来通过 key 或 key path 对于属性进行校验。这些方法的默认实现依赖于你定义的遵循名称模式的方法，近似于使用存取方法。尤其是你提供了 `validate<Key>:error:` 方法给任何属性以名称 key 来进行校验。默认实现会对其进行检索以便响应键编码的 validateValue:forKey:error: 消息。  
如果你不想讲一个校验方法应用在一个属性上，协议的默认实现会假设该属性的校验是成功的，无论值为什么。这意味着你选择了按照属性来进行验证。  

> 注意  
> 通常只在 OC 中使用这里描述的校验方法。在 Swift 中，属性的校验更加依赖于编译器所支持的复合语言习惯的可选项以及强类型检查，即使用内置的 willSet 和 didSet 属性监听来检测任何运行时 API 关联，如《Swift 编程语言(Swift 3)》中的“属性监听”段落所描述的。

### 实现校验方法

当你给一个属性提供校验方法时，该方法会通过引用接收到两个参数：需要校验的值对象以及用来返回错误信息的 NSError 对象。作为结果，你的校验方法可以采取以下三种行为之一：  

- 当值对象有效时，返回 YES，而无需替换值对象或者 error 对象。
- 当值对象无效时，你无需提供一个有效值作为替代，只需要设置 error 参数为一个能够表示失败原因的 NSError 对象，然后返回 NO 即可。
	
	> 重要  
	> 在尝试设置一个 error 引用对象之前永远都要检测它是否是 NULL。
- 当值对象无效时，但你知道一个有效的替代的话，创建一个有效的对象，将值引用复制给新的对象，然后返回 YES 无需修改 error 引用。如果你提供另一个值，应该始终返回一个新的对象而非修改一个已经经过校验的对象，即使是原对象是可变的。 

清单 11-1 展示了一个名为 name 的字符串属性校验方法，它会确保值对象不为nil，并且名字是最小长度。如果校验失败了，这个方法不会代替另一个值。  

清单 11-1 name属性校验方法
		
	-(BOOL)validateName:(id *)ioValue error:(NSError * __autoreleasing *)outError{
	    if ((*ioValue == nil) || ([(NSString *)*ioValue length] < 2)) {
	        if (outError != NULL) {
	            *outError = [NSError errorWithDomain:PersonErrorDomain
	                                            code:PersonInvalidNameCode
	                                        userInfo:@{ NSLocalizedDescriptionKey
	                                                    : @"Name too short" }];
	        }
	        return NO;
	    }
	    return YES;
	}


### 校验标量

校验方法会希望参数值是一个对象，并且如果是非对象的属性会被封装为 NSValue 或 NSNumber 对象，如《展示非对象值》中讨论的那样。清单 11-2 中的示例展示了一个标量属性 age 的校验方法。在这种情况下，一个潜在的无效条件，假设一个 nil 的 age 值，会被处理成创建一个有效值，并设置为0，然后返回 YES。你还可以再你自己的重写 setNilValueForKey: 方法中处理这种特定条件，因为你的类的调用者可能不会调用校验方法。  

清单 11-2 标量属性的校验方法
	
	- (BOOL)validateAge:(id *)ioValue error:(NSError * __autoreleasing *)outError {
	    if (*ioValue == nil) {
	        // Value is nil: Might also handle in setNilValueForKey
	        *ioValue = @(0);
	    } else if ([*ioValue floatValue] < 0.0) {
	        if (outError != NULL) {
	            *outError = [NSError errorWithDomain:PersonErrorDomain
	                                            code:PersonInvalidAgeCode
	                                        userInfo:@{ NSLocalizedDescriptionKey
	                                                    : @"Age cannot be negative" }];
	        }
	        return NO;
	    }
	    return YES;
	}

## 描述属性关系

类的描述信息提供了一种描述在一个类的属性中的一对一或一对多关系的方法。定义这些类的属性之间的关系能够在这些属性之间操作使用 KVC 时更加灵活和高效。

### 类描述

NSClassDescription 是一个提供获取关于一个类元数据接口的基本类。一个类的描述对象记录了在对象和类以及其他对象之间的指定类的可用对象属性和关系（一对一，一对多以及反过来）。比如 attributeKeys 方法会返回一个类的所有属性列表；toManyRelationshipKeys 和 toOneRelationshipKeys 两个方法会返回定义一对多和一对一关系的 key 数组；inverseRelationshipKey: 会根据提供的 key 从目标关系返回给指向接收者的指针的关系名称。  
NSClassDescription 不会定义用来定义关系的方法。具体的子类必须定义这些方法。一旦创建，你需要使用 NSClassDescription 的类方法 registerClassDescription:forClass: 注册一个类的描述。  
NSScriptClassDescription 是在 Cocoa 中唯一提供的 NSClassDescription 的具体子类。它封装了一个应用的脚本信息。

## 性能设计

KVC 很高效，尤其是当你依赖于默认实现来做大部分工作的时候，不过它比直接方法调用增加了一层微慢的转接。只有当你体会到它所提供的灵活性时再使用 KVC，或者让你的对象参与 Cocoa 所依赖的技术。

### 重写KVC方法

通常，在确保你的对象是继承自 NSObject 的时候，就能让它们符合 KVC 协议，然后提供指定属性的存取方法以及相关方法，如同本文中所描述的。 你应该很少需要重写默认的 KVC 存取方法的默认实现，比如 valueForKey: 和 setValue:forKey:，或者是类似 validateValue:forKey: 的这种基于 key 的校验方法。由于这些实现会缓存运行时环境信息来提高效率，如果你想通过重写它们来引入自定义逻辑，要确保在返回前调用默认父类的实现。  

### 优化一对多关系

当你实现一对多的关系时，存取器的索引形式在很多情况下都提供了性能保证，尤其是对于可变数组。参见《访问集合属性》以及《定义集合方法》部分了解进一步的信息。

## 合规检查表

本段中总结的下述步骤能够确保你的对象是复合 KVC 的。参见前一章节了解详情。  

### 属性和一对一关系匹配

对于每个 property，即一个属性或一对一关系：  

- 实现一个名为 `<key>` 或 `is<Key>` 的方法，或者创建一个名为 `<key>` 或 `_<key>` 的实例变量。在自动合成属性的时候，编译器通常会为你这么做了。  

		注意  
		虽然属性名通常以小写字母开头，但协议的默认实现对于大写字母开头也同样有效，比如 URL。

- 如果属性是可变的，实现 `set<Key>:` 方法。在自动合成属性的时候，编译器通常会为你这么做了。

		重要  
		如果你重写了默认的 setter，要确保不要调用任何协议的校验方法。


- 如果属性是个标量，重写 setNilValueForKey: 方法来优雅的处理当一个 nil 值赋值给标量属性的时候的情况。在自动合成属性的时候，编译器通常会为你这么做了。

### 索引一对多关系匹配

对于属性是有序的，一对多关系（比如 NSArray 对象）：  

- 实现名为 `<key>` 的方法，返回一个数组，或者名为 `<key>` 或 `_<key>` 的数组的实例变量。在自动合成属性的时候，编译器通常会为你这么做了。
- 或者作为替代，实现 `countOf<Key>` 方法和 `objectIn<Key>AtIndex:` 和 `<key>AtIndexes:` 方法中的其中一个或两个都实现。
- 可选的，实现 `get<Key>:range:` 方法来提高性能。

此外，如果属性是可变的：  

- 实现 `insertObject:in<Key>AtIndex:` 和 `insert<Key>:atIndexes:` 之一或都实现。
- 实现 `removeObjectFrom<Key>AtIndex:` 和 `remove<Key>AtIndexes:` 之一或都实现。
- 可选的，实现 `replaceObjectIn<Key>AtIndex:withObject:` 或 `replace<Key>AtIndexes:with<Key>:` 来提高性能。

### 无序一对多关系匹配

对于属性是无序的，一对多关系（比如 NSSet 对象）：  

- 实现名为 `<key>` 的方法，返回一个集合，或者名为 `<key>` 或 `_<key>` 的集合的实例变量。在自动合成属性的时候，编译器通常会为你这么做了。
- 或者作为替代，实现 `countOf<Key>`, `enumeratorOf<Key>` 和 `memberOf<Key>` 方法。

此外，如果属性是可变的：  

- 实现 `add<Key>Object:` 和 `add<Key>:` 之一或都实现。
- 实现 `remove<Key>Object:` 和 `remove<Key>:` 之一或都实现。
- 可选的，实现 `intersect<Key>:` 来提高性能。

### 校验

对于需要的属性选择加入校验方法：  

- 实现 validate<Key>:error: 方法，返回一个布尔值来表示值的校验结果，以及在恰当的时候返回一个 error 对象的引用。