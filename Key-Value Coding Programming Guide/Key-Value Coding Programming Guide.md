[Key-Value Coding Programming Guide](https://developer.apple.com/library/archive/documentation/Cocoa/Conceptual/KeyValueCoding/index.html#//apple_ref/doc/uid/10000107-SW1)

# 开始
## 关于KVC

KVC是一种通过NSKeyValueCoding非正式协议启动的机制，遵循该协议的对象会提供它属性的间接访问。当一个对象符合KVC时，它的属性是可以通过字符串参数以一个精确、唯一的消息接口进行寻址的。这种间接的访问机制对于通过实例变量和它的关联存取方法是一种补充。  
通常使用存取方法来访问一个对象的属性。取方法（即getter）返回一个属性的值。存方法（即setter）设置一个属性的值。在OC当中你还可以直接访问一个属性的底层的实例变量。以任何方式访问一个对象的属性都是直接的，但是需要调用一个属性特定的方法或者变量名。随着属性的增加或变更，这些存取这些属性的方法的代码也要变更。作为对比，一个符合KVC的对象提供了一种简单的消息接口，它可以贯穿所有这些属性。  
KVC是一个很多其他Cocoa技术的底层原理，比如KVO，cocoa绑定，Core Data和AppleScript功能。KVC还可以在某些情况下帮助你简化代码。  

### 使用符合KVC的对象

当对象继承自NSObject（直接或间接）时就会采用了KVC，同时遵守了NSKeyValueCoding协议并为基本方法提供了一个默认的实现。这样的一个对象能够让其他的对象通过一个简洁的消息接口做如下事情：  

* 访问对象属性。协议列举的方法，类似通用的取方法 valueForKey: 和通用的存方法 setValue:forKey:，通过对象的属性名或key，将其参数化为字符串来访问。这些方法的默认实现和相关方法使用了key来定位和与底层数据交互，这在《访问对象属性》中有相关描述。
* 操作集合属性。访问方法对于对象的集合属性（比如NSArray对象）所做的工作的默认实现就像其他的属性一样。此外，如果一个对象给一个属性定义了一个集合存取方法，它就开启了键值对访问集合内容的能力。这通常比直接访问并让你通过标准接口与自定义集合对象进行交互更加高效，如《访问集合属性》中描述的方法。
* 对于集合对象调用集合操作。当访问一个复合KVC的对象的集合属性时，你可以在key字符串中插入一个集合操作符，在《使用集合操作符》中相关描述。集合操作符会通知默认的NSKeyValueCoding的getter方法在集合上实现一个动作，并返回一个新的或者筛选过的集合的版本，或者一个单一的值来表示某些集合的特征。
* 访问非对象的属性。协议的默认实现会检测非对象属性，包括标准量和结构体，并自动的对其进行封包和解包作为对象用在协议的接口中，这在《展示非对象值》中有相关描述。此外，协议声明了一个方法允许遵循的对象为当一个nil通过KVC接口设置给一个非对象的属性这种情况提供一个合适的行为。
* 通过key路径访问属性。当你拥有一个层级的符合KVC的对象时，你可以使用基于方法的key路径层层调用，使用一个调用就能获取或设置在层级中的深层的值。

### 为一个对象采用KVC

为了让你自定义的对象能够遵循KVC，你需要确保它们采用了NSKeyValueCoding非正式协议，并实现了相应的方法，类似valueForKey: 作为通用的 getter 以及 setValue:forKey: 作为通用的setter方法。幸运的是，如上文所述，NSObject 遵循了该协议，并为这些方法提供了默认实现和基本方法。所以，如果你的对象是从NSObject（或者它的众多子类）获得的，那么很多工作已经为你做好了。  
为了让默认的方法能够执行其工作，你要确保你的的对象的存取方法和实例变量遵守一个特定的定义好的模式。这会让默认实现能够查找到你的对象的属性以便相应键值编码信息。随后你就可以选择扩展和自定义键值编码，通过提供方法来验证和处理某个特定的例子。

### Swift中的KVC

继承自NSObject的Swift对象或者它的子类之一的属性默认是符合键值编码的。鉴于在OC当中，一个属性的存取方法和实例变量必须遵循某个特定模式，一个在Swift中声明的标准的属性自动的会确保这一点。另一方面，很多协议的功能要么不相关，要么使用在OC中不存在的原生Swift构造或技术处理的更好。比如，由于所有的Swift的属性都是对象，你始终不用使用默认的实现来制定处理非对象的属性。  
所以，当KVC协议方法直接转移到Swift时，本指南主要聚焦在OC上，在你需要做的更多来确保稳定性以及KVC更常用的地方。在整个指南中都注意到了在Swift中要求采用明显不同方法的情况。  
更多关于使用Cocoa技术的Swift，阅读《使用Cocoa和OC（Swift3）》。有关Swift的详细介绍，阅读《Swift编程语言》（Swift3)。

### 其他的依赖KVC的Cocoa的技术

遵守KVC的对象能够广泛的参与Cocoa技术，这些技术依赖于这种访问，包括：  

* KVO。这种机制让对象能够通过在其他对象的属性的改变中注册异步通知驱动，如《KVO编程指南》中所描述的那样。
* Cocoa绑定。这个技术的集合完整实现了MVC范式，模型封装应用数据，视图展示和编辑数据，控制器协调两者。阅读《Cocoa绑定编程话题》了解更多关于Cocoa绑定。
* Core Data。这个框架为和对象生命周期和对象图表管理相关的常见任务场景提供了一个通用的、自动的解决方案，包括持久化。你可以在《Core Data编程指南》中阅读关于Core Data。
* AppleScript。这个脚本语言能够直接控制可脚本控制的应用以及macOS的很多部分。Cocoa的脚本化支持利用KVC来获取或设置可脚本化对象的信息。NSScriptKeyValueCoding 非正式协议中的方法提供了额外的功能与KVC结合使用，包括通过在多个键值中的索引获取和设置键值，以及强制转换一个键值给一个恰当的数据类型。《AppleScript概览》提供了一个关于AppleScript的高层的概览以及它相关的技术。

# KVC基本原理
## 访问对象的属性

一个对象通常会在其接口声明中指定属性，这些属性属于以下几种分类之一：  

* 特性。这些事简单的值，比如一些标量，字符串，或者布尔值。类似NSNumber的值对象和其他的类似NSColor的不可变类型也可以考虑作为特性。
* 对一的关系。这些可变对象有其自身的属性。一个对象的属性能够在对象本身不改变的情况下改变。比如，一个银行账户对象可能有个它自己的属性是Person对象的实例，该对象也有个地址属性。地址的持有者可能需要持有银行账户，在不改变拥有者的引用的情况下改变本身。银行账户的拥有者不会变更。只改变地址。
* 对多的关系。这些是集合对象。通常使用NSArray或NSSet的实例来持有类似一个集合的内容，虽然自定义集合类也可以。

BankAccount对象声明在清单2-1中，展示了属性的每种类型。  

清单2-1 BankAccount对象的属性  

	@interface BankAccount : NSObject
 
	@property (nonatomic) NSNumber* currentBalance;              // An attribute
	@property (nonatomic) Person* owner;                         // A to-one relation
	@property (nonatomic) NSArray< Transaction* >* transactions; // A to-many relation
	 
	@end

为了维持封装性，一个对象通常在其接口中为属性提供存取方法。对象的作者可能会显式的编写这些方法，或者依赖编译器自动合成它们。不论哪种方法，使用这些存取方法的代码的作者都必须在编译之前将属性名写到代码中。存取器方法的名称会变为代码的静态部分然后使用。比如，给定清单2-1中声明的银行账户对象，编译器会合成一个setter方法，让你给myAccount实例对象调用：  

	[myAccount setCurrentBalance:@(100.0)];

这很直接，但缺乏灵活性。一个符合KVC的对象，换句话说，会使用字符串标识符来提供一个更通用的机制访问对象的属性。  

### 使用key和key路径来定位一个对象的属性

key是一个字符串，它会定位一个特定的属性。通常，按照惯例，key代表的属性就是出现在代码中的属性名本身。key都必须使用ASCII编码，可能不包含空格，通常开始是小写字母（虽然有例外，比如在很多类中都会看到的URL属性）。  
由于在清单2-1中的BankAccount类是符合KVC的，它会识别key owner，currentBalance, 和 transactions，这些都是属性名。除了调用 setCurrentBalance: 方法，你可以使用key设置它的值：  

	[myAccount setValue:@(100.0) forKey:@"currentBalance"];

实际上，你可以使用同样的方法设置所有的myAccount对象的属性，使用不同的key参数即可。由于参数是一个字符串，它可以在运行时变为可操作的变量。  
key path是一个用点分隔符制定一系列来回的对象属性的字符串。这个串中的第一个key是关于接受者的，并且随后的每个key都和前一个属性的值相关。key path在使用一个方法调用深入一组层级对象中很有用。  
比如，key path owner.address.street用在一个银行账户实例时指的是存储在银行账户拥有者的地址中的街道名称，假设Person和Address类也是符合KVC的。  

```
注意  
在Swift中，你可以使用 #keyPath 表达式来代替使用字符串来表达一个key或key path。这也提供了编译时的检查，这在《结合Cocoa和OC（Swift 3）使用Swift指南》中的Keys 和 Key Paths段落有相关描述。
```

### 使用keys获取属性值

当一个对象遵守NSKeyValueCoding协议的时候，该对象就是符合KVC的。一个继承自NSObject的对象，它会提供协议根本方法的默认实现，自动的以某种默认行为遵循该协议。这样的一个对象至少实现了以下几种基本的基于Key的获取方法：  

* valueForKey:-通过key参数返回属性名的值。如果通过key不能够根据《存取器检索模式》中描述的规则找到属性名的话，对象会给其本身发送valueForUndefinedKey:消息。valueForUndefinedKey: 的默认实现是产生一个NSUndefinedKeyException异常，但其子类可以重写这个行为并更好的处理这种情况。
* valueForKeyPath:-给相关接收者返回指定key path的值。任何在key path序列中不符合KVC的特定key——意思是valueForKey: 的默认实现不能够找到存取器方法——会收到一条valueForUndefinedKey: 消息。
* dictionaryWithValuesForKeys:-给接收者返回相关的keys的数组值。该方法会调用每个在数组中的key的 valueForKey: 。返回的NSDictionary包含所有在数组中的key的值。

```
注意  
集合类的对象，比如NSArray, NSSet, 和 NSDictionary，不能包含nil作为值。你可以使用NSNull对象代表nil值。NSNull会提供一个单独的实例给对象的属性表示nil值。dictionaryWithValuesForKeys: 的默认实现一机相关的 setValuesForKeysWithDictionary: 会在NSNull（在字典的参数中） 和 nil（在存储的属性中）之间自动转换。
```

当你使用key path来定位一个属性时，如果key path中的最终key是多对多关系（即它引用了集合），返回值会是一个根据key到对多key的右侧的包含了所有值的集合。比如，请求key path transactions.payee的值会返回一个包含所有交易的所有payee对象的数组，这在key path中对于可变数组也有效。accounts.transactions.payee 这个 key path会返回所有账户中所有交易的所有payee对象。

### 使用Keys设置属性值

和getters方法一样，符合KVC的对象也会根据NSObject的NSKeyValueCoding协议基于默认行为的实现提供一组小的通用的setters：  

* setValue:forKey: -以给定值给相关对象的接受者根据特定key设置值。setValue:forKey:的默认实现会自动的解包NSNumber和NSValue对象为标量和结构体，然后将其赋值给属性。参见《表示非对对象值》了解封包和解包语法的细节。  
如果指定的key相关的属性，即接收setter的对象调用没有该属性的话，对象会发送一条 setValue:forUndefinedKey: 消息给其本身。setValue:forUndefinedKey: 的默认实现是生成一个NSUndefinedKeyException异常。不过子类可以重载该方法来处理自定义管理中的请求。
* setValue:forKeyPath: -根据指定key path相关的接收者设定给定值。任何在key path序列中的对象只要不符合给定key的KVC协议，就会收到一条 setValue:forUndefinedKey: 消息。
* setValuesForKeysWithDictionary: -使用指定字典中的值设置接受者的属性，使用字典的key来匹配属性。默认的 setValue:forKey: 调用的实现是每个键值对，根据需要用nil代替NSNull对象。

在默认实现中，当你试图用一个nil设置一个非对象的属性时，符合KVC的对象会给其自身发送一条 setNilValueForKey: 消息。 setNilValueForKey: 的默认实现是会生成一个NSInvalidArgumentException异常，但是对象可以重载该方法用一个默认值代替或者标记值代替，这在《处理非对象值》中有相关描述。

## 访问集合属性

## 使用集合操作符

## 表示非对象值

## 校验属性

## 存取器搜索模式

# 采用KVC
## 获取基本的KVC合规

## 定义集合方法

## 处理非对象值

## 增加校验

## 描述属性关系

## 性能设计

## 合规检查表