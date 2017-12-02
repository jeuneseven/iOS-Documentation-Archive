[Cocoa Core Competencies 原文链接](https://developer.apple.com/library/content/documentation/General/Conceptual/DevPedia-CocoaCore)

# Cocoa 核心能力（Cocoa Core Competencies）

## 辅助功能（Accessibility）

### 使用VoiceOver

### 相关文章
国际化（Internationalization）
### 详细讨论
辅助功能编程指南 (Accessibility Programming Guide for iOS)
### 示例代码工程
ImageMapExample
## 存取器方法（Accessor method）

### 命名规范

### 预读文章
键值编码（Key-value coding）
### 相关文章
内存管理（Memory management）
声明属性（Declared property）
### 详细讨论
使用存取器方法来获取或设置属性的值 (Use Accessor Methods to Get or Set Property Values)
## App ID

### 一个显式的App ID对应一款App

### 通配符App IDs对应多款App

## app代码签名（Application Code Signing）
为应用程序签名能够让系统判断到底是谁给这个应用程序签名，并且能够在应用程序被签名后验证该应用程序没有被修改。签名在提交到App Store之前是必须做的一项工作（无论是iOS还是Mac的应用）。从App Store或者Mac App Store上下载的应用程序，OS X和iOS系统都会验证其签名，确保运行的应用程序不是使用的无效的签名。这让用户能够相信该应用程序是从Apple的资源处签名的，并且在签名之后没有被修改过。  

![](https://developer.apple.com/library/content/documentation/General/Conceptual/DevPedia-CocoaCore/Art/application_code_signing_2x.png)  

Xcode在构建期间使用你的数字ID来给你的应用程序签名。这个数字ID是由一对公私钥和一个证书组成。私钥使用加密函数生成签名。证书由Apple颁发；它包含了公钥并将您标识为密钥对的所有者。  
为了能够给应用程序签名，你的数字ID的每个部分都必须是安装过了的。使用Xcode或者钥匙串访问来管理你的数字ID。根据你在你的开发团队中的角色，你在不同的场景下可能需要多个数字ID。举例来说，你在开发过程中使用的ID与你发布到App Store或者Mac App Store使用的ID是不同的。在OS X和iOS上使用的数字ID也是不同的。  
一款应用程序的代码是被它的签名保护着的，因为一旦app包当中的可执行代码更改了，那么它的签名就失效了。  
一款应用程序的签名是可以被移除的，并且应用程序是可以被其他的数字ID重签名的。比如Apple就会把App Store和Mac App Store上出售的app都重新签名。一个被充分测试过的开发环境的你的应用程序，也是能够被重新签名，然后提交到App Store或Mac App Store上的。因此，对签名的最好的解释是它并不是一款应用程序的证明，它其实是由签名人所做的一个变量标记。
### 预读文章
无
### 相关文章
App ID
### 详细讨论
配置ID和团队的设置（Configuring Identity and Team Settings）
## Block对象（Block object）

### 声明一个Block

### 创建一个Block

### Block变量

### 使用Block

### 比较操作

### 预读文章
消息（Message）
### 相关文章
枚举(Enumeration)
### 详细讨论
使用Blocks（Working with Blocks）
## 包（Bundle）
包是一种在文件系统当中的目录结构，它将可执行的代码和相关资源（例如图片和音频等）组织在一个地方。在iOS和OS X应用程序中，类库、插件以及其他类型的软件都是包。一个包是一种标准的层级目录结构，它包含可执行的代码和被代码使用的资源。Foundation和Core Foundation都包含了工具来定位和加载在包当中的代码和资源。  

> 注意：应用程序是第三方开发者能够在iOS上创建的唯一的包类型。

包给用户和开发者都带来了很多优势。它使得安装或者迁移一个应用程序或者其他地方的软件通过简单的从一个位置移动到另一个位置就可以做到。包还是国际化当中的一个很重要的元素。你可以将本地化的资源存储在一个特殊名称的子目录下的包当中；在编程时，只需要在该位置查询本地资源关联用户的语言配置即可。  
大部分类型的Xcode项目都会在你构建可执行代码的时候创建一个包给你。所以你基本上很少会需要自己创建一个包。不过即使是这样，理解包的结构以及如何访问它内在的代码和资源还是很重要的。
### 包的结构和内容
一个包可以包含可执行代码，图片，声音，nib文件，私有类库以及共享库，插件，可加载的包或任意其他类型的代码或资源。它还可以包含一个运行时配置的文件，叫做信息属性列表（Info.plist）。每个元素都在包的结构中有合适的位置。例如图片，声音以及nib文件这些资源都会存放在Resources这个子目录下。它们可以被本地化或者非本地化。本地化的文件（包括strings文件，这是一个本地化字符串的集合）放置在Resources子目录下，带有lproj扩展名以及与语言和可能的区域设置相对应的名称。

![](https://developer.apple.com/library/content/documentation/General/Conceptual/DevPedia-CocoaCore/Art/bundle_2x.png)

### 访问包资源
每个应用程序都有一个主包，它包含了应用程序的代码。当用户加载一个应用的时候，它会在主包当中找到代码和资源，然后将需要的立即加载到内存中。此后，应用程序就能够动态的（惰性的）从主包或者需要的次级包中加载代码和资源。  
对于程序代码而言，NSBundle类和Core Foundation的CFBundleRef类型提供了在包当中查找资源的方法。在OC当中，你首先必须获取一个NSBundle的实例对象，然后用它和实际的包相关联。如果相获取一个应用的主包，要调用类方法mainBundle。当给定文件名，扩展名以及（可选）一个包的子目录的时候，其他的NSBundle方法将返回路径给包资源。当你获取了一个资源的路径后，你可以使用适当的类加载它到内存中。
### 可加载的包
同应用程序的包一样，可加载的包将可执行的代码和相关资源封装，但由你在运行时决定什么时候加载。你可以使用可加载的包来设计高度模块化、可定制和可扩展的应用程序。每个可加载的包都有一个主类，它作为包的入口；当你加载包的时候，你必须为主类调用NSBundle，使用它返回的Class对象来创建一个类的实例。
### 预读文章
消息（Message）
### 相关文章
属性列表（Property list）
nib文件（Nib file）
### 详细讨论
关于包（About Bundles）
## 分类（Category）

### 声明

### 实现

### 预读文章
类的定义（Class definition）
### 相关文章
无
### 详细讨论
分类为已经存在的类添加函数（Categories Add Methods to Existing Classes）
## 类簇（Class cluster）
一组私有的、实体子类封装在一个公有、抽象的父类下的结构被称作类簇。以这种方式组成的类为用户提供了简单的接口，用户只看得到公共的接口结构。而在其下，抽象类会调用私有的子类，这些私有的子类大部分都会执行特定的任务。举个例子，一些比较通用的cocoa类是由类簇实现的，包括NSArray, NSString, 以及 NSDictionary。有很多种方式可以让它们用来表现它们内部的数据存储。对于任何特定实例，抽象类会根据实例正在初始化的数据选择最有效的类来使用。  
您可以像使用任何其他类一样的对类簇的实例进行创建和交互。而在幕后，当你创建一个公开类的实例的时候，该类会根据你的调用返回一个适当的基于子类创建方法的实例对象。（你不会、也不能够选择实例的实际类。）  
拿Foundation框架的NSString类作为示例，你可以创建三种不同的字符串对象：  

	NSString *string1 = @"UTF32.txt";
	NSString *string2 = [NSHomeDirectory() stringByAppendingPathComponent:string1];
	NSTextStorage *storage = [[NSTextStorage alloc] initWithString:string2];
	NSString *string3 = [storage string];

每个字符串都可能是一个不同的私有子类的实例（事实上，在OS X v10.5中，每一个都是）。虽然每个对象都是 NSString 的私有子类, 但将每个对象都视为 NSString 类的实例很方便。你使用的NSString类声明的实例方法就像NSString本身的一样。
### 收益
类簇的收益主要体现在效率上。实例管理的数据的内部表示可以根据创建或使用的方式进行调整。此外，即使底层实现改变了，你的代码依旧有效。
### 注意事项
类簇结构提供了一种介于简单和扩展之间的平衡：拥有少量的公共接口代替大量的私有接口，这使得在框架当中很容易上手和使用，但在任何类簇当中都很难创建子类。    
你创建的包涵类簇的类必须：  

* 是类簇抽象父类的子类
* 声明它本身的存储
* 重写子类的原始方法

很少会遇到需要创建子类的情况——比如在Foundation框架中的类簇——类簇的结构很明显是很有益的。你也可以使用组合来避免使用子类；通过在你自己的设计的对象中植入私有的类簇对象，你就能够创建一个组合对象。这种组合对象能够依赖类簇对象的基本函数属性，它只会以某种特定的方式拦截它所需要的信息。使用这种方法来减少你必须编写的代码量，并且让你能够利用Foundation框架提供的检测代码。
### 预读文章
无
### 相关文章
无
### 详细讨论
类簇（Class Clusters）
## 类定义（Class definition）

### 接口

### 实现

### 预读文章
无
### 相关文章
分类（Category）
存取器方法(Accessor method)
### 详细讨论
定义类（Defining Classes）
## 类方法（Class method）

### 子类

### 实例变量

### self

### 预读文章
无
### 相关文章
存取器方法(Accessor method)
### 详细讨论
定义类（Defining Classes）
## Cocoa (Touch)

### 类库

### 语言本身

### 预读文章
无
### 相关文章
根类(Root class)
Objective-C
### 详细讨论
无
## 编码惯例（Coding conventions）

### 预读文章
无
### 相关文章
内存管理(Memory management)
### 详细讨论
Cocoa编码指南(Coding Guidelines for Cocoa)
## 集合（Collection）

### 集合类

### 排序方案

### 预读文章
无
### 相关文章
枚举(Enumeration)
### 详细讨论
集合编程主题(Collections Programming Topics)
## 控制器对象（Controller object）

### 协调控制

### 视图控制器

### 媒体控制（OS X）

### 预读文章
模型-视图-控制器(Model-View-Controller)
消息（Message）
### 相关文章
模型对象（Model object）
代理（Delegation）
通知（Notification）
### 详细讨论
模型-视图-控制器(Model-View-Controller)
## 声明属性（Declared property）

### 预读文章
存取方法(Accessor method)
### 相关文章
无
### 详细讨论
属性封装了一个对象的值(Properties Encapsulate an Object’s Values)
## 委托（Delegation）

### 委托和cocoa框架

### 委托和通知

### 数据源

### 预读文章
类的定义(Class definition)
### 相关文章
通知(Notification)
协议(Protocol)
控制器对象(Controller object)
### 示例代码工程
代理和数据源(Delegates and Data Sources)
### 示例代码工程
iOS UITableView基础(UITableView Fundamentals for iOS)
## 动态绑定（Dynamic binding）
动态绑定决定了方法是在运行时而不是编译时被调用。动态绑定也被称作延迟绑定。在OC当中，所有的方法都是在运行时决定的。最终被决定要执行的代码是被方法名（选择器）和接收对象共同决定的。  
动态绑定允许多态。举例来说，假设一个集合对象包含了Dog, Athlete, 和 ComputerSimulation等。每个对象都有她自己的run方法的实现。在以下代码段当中，[anObject run]语句在运行时将会调用实际执行的代码。运行时系统使用选择器来判断run方法是由哪个类的anObject对象来最终调用的。  

	NSArray *anArray = [NSArray arrayWithObjects:aDog, anAthlete, aComputerSimulation, nil];
	id anObject = [anArray objectAtIndex:(random()/pow(2, 31)*3)];
	[anObject run];

本例阐述了OC的动态特性——这种功能在Cocoa当中到处都有。
### 预读文章
键值监听（Key-value observing）
选择器（Selector）
### 相关文章
无
### 详细讨论
使用对象（Working with Objects）
## 动态类型（Dynamic typing）
如果在编译时未检查变量所指向的对象的类型，则变量是动态类型的。OC使用id数据类型来表明该变量是一个没有指定类型的对象。这被称作动态类型。  
动态类型与静态类型相对，系统在其中显式标识对象在编译时所属的类。静态类型会在编译时期严格校验数据的完整性，作为完整性的交换，动态类型给予了编程极大的灵活性。通过对象的内省（查询动态类型，匿名对象的类），你仍旧可以在运行时校验对象的类型，从而确定它是适合于某种操作的。  
以下示例举例说明了使用多种不同动态类型的对象：  

	NSArray *anArray = [NSArray arrayWithObjects:@"A string", [NSDecimalNumber zero], [NSDate date], nil];
	NSInteger index;
	for (index = 0; index < 3; index++) {
	    id anObject = [anArray objectAtIndex:index];
	    NSLog(@"Object at index %d is %@", index, [anObject description]);
	}

被变量指针指向的对象在运行时必须响应相应的你发送给它的消息；否则，你的程序将会抛出异常。方法调用的实际实现是使用动态绑定来判断。
### isa指针
每个对象都有一个isa实例变量，它标示了该对象的类。运行时根据该指针来判断对象的实际类。
### 预读文章
无
### 相关文章
动态绑定（Dynamic binding）
异常处理（Exception handling）
### 详细讨论
使用对象（Working with Objects）
## 枚举（Enumeration）

### NSEnumerator

### 快速枚举

### 预读文章
集合（Collection）
### 相关文章
block对象（Block object）
### 详细讨论
使用更有效率的集合枚举技术（Use the Most Efficient Collection Enumeration Techniques）
## 异常处理（Exception handling）
异常处理是指管理非典型事件打断了正常程序运行的执行流程（例如不可识别的信息）的过程。如果没有适当的错误处理机制的话，程序遇到非典型事件的时候，将有很大可能被抛出的异常所终止，这些异常通常被称作exception。
### 异常的类型
异常被抛出是可能有多种可能的，有可能是硬件的，也可能是软件的问题。示例包括比如计算错误（比如被除数是0，下溢出或者上溢出），调用未定义的命令（比如调用一个未实现的方法）和试图访问超过一个集合范围的元素。
### 使用编译器指令处理异常
有四个编译器指令能够让你处理异常：  

* @try 代码块包含那些可能抛出异常的代码。
* @catch() 代码块包含处理从@try代码块中抛出异常的代码。你可以使用多个@catch()来接收多种不同类型的异常。
* @finally 代码块包含无论异常是否被抛出，最终都会执行的代码。
* @throw 指令会直接抛出异常，其本质上就是个OC对象。你可以使用NSException对象，不过一般不需要用到。

以下示例展示了你该如何使用这些指令在执行代码发生异常的时候进行处理：  

	Cup *cup = [[Cup alloc] init];
	@try {
   	 	[cup fill];
	}
	@catch (NSException *exception) {
	    NSLog(@"main: Caught %@: %@", [exception name], [exception  reason]);
	}
	@finally {
	    [cup release];
	}

### error信号量
尽管异常在很多编程环境中被用来控制程序流程或预示错误，但请不要在Cocoa 和 Cocoa Touch的应用程序中这样使用。你应当使用函数的返回值来指出有错误发生，并且以错误对象的形式提供更多的信息。更多信息，参见“错误处理编程指南”。
### 预读文章
无
### 相关文章
无
### 详细讨论
异常编程话题讨论（Exception Programming Topics）
## 类库（Framework）

### 预读文章
包(Bundle)
### 相关文章
无
### 详细讨论
类库编程指南（Framework Programming Guide）
## 信息属性列表（Information property list）

### 预读文章
属性列表(Property list)
包(Bundle)
### 相关文章
无
### 详细讨论
信息属性列表key值参考（Information Property List Key Reference）
## 初始化（Initialization）

### 初始化声明的方式

### 实现初始化函数

### 预读文章
对象的创建(Object creation)
消息(Message)
### 相关文章
多种初始化(Multiple initializers)
对象的拷贝(Object copying)
内存管理(Memory management)
### 详细讨论
对象是动态创建的（Objects Are Created Dynamically）
## 国际化（Internationalization）

### 预读文章
Cocoa (Touch)
### 相关文章
nib文件(Nib file)
对象的拷贝(Object copying)
值对象(Value object)
### 详细讨论
国际化和本地化（Internationalization and Localization）
## 内省机制（Introspection）
内省是指对象在运行时根据请求泄露其本质特征的内在能力。通过歌对象发送特定的逆袭，你可以询问对象有关它们作为对象本身的问题，OC运行时机制会给你提供答案。内省是编程时很重要的一个工具，因为它能够让你的程序更有效和健壮。以下是一些如何使用内省的示例：  

* 你可以调用内省方法作为运行时的检查机制来帮助你避免异常等情况，例如你给一个不能够接受某个消息的对象发送某个消息时就会发生异常。
* 你还可以使用内省来定位一个对象的继承关系，这将会为你提供对象的能力的基本信息。
![](https://developer.apple.com/library/content/documentation/General/Conceptual/DevPedia-CocoaCore/Art/introspection_2x.png)

### 内省信息的类型
NSObject类采用的NSObject协议定义了内省方法，产生了以下类型的对象信息：  

* 类的关系。如果想检查一个对象是直接还是间接的从一个特定的类继承的，你可以发送 isKindOfClass: 消息来判断结果。该方法会告诉你该对象是否是给定类的直接子类。你还可以使用class和superClass方法来获取对象的类或父类，然后在判断语句当中使用该结果。
* 消息响应。如果想检查一个对象的类或者父类是否实现了某方法，可以发送给该对象 respondsToSelector: 消息。参数是从使用 @selector 指令的方法签名构造的 SEL 类型值。举个例子：  
		
		BOOL doesRespond = [anObject respondsToSelector:@selector(writeToFile:atomically:)];
* 协议的一致性。如果一个类遵守一项正式协议，你可以预期它已经实现了协议定义的必须实现的方法，并且可以给它发送相应的信息。使用 conformsToProtocol: 方法来获取这一信息。你可以使用@protocol指令来指定此方法的参数。

### 预读文章
消息（Message）
### 相关文章
对象比较（Object comparison）
协议（Protocol）
选择器（Selector）
### 详细讨论
NSObject协议参考（NSObject Protocol Reference）
## 键值编码（Key-value coding）

### 对象属性和KVC

### 让一个类能够顺利使用KVC

### 预读文章
对象模型（Object modeling）
存取器方法(Accessor method)
### 相关文章
声明属性（Declared property）
### 详细讨论
键值编码编程指南（Key-Value Coding Programming Guide）
## 键值监听（Key-value observing）

### 实现KVO

### KVO是绑定中不可分割的一部分（OS X）

### 预读文章
键值编码（Key-value coding）
### 相关文章
模型－视图－控制器（Model-View-Controller）
动态绑定(Dynamic binding)
### 详细讨论
键值监听编程指南（Key-Value Observing Programming Guide）
### 示例代码工程
SourceView: Using NSOutlineView with NSTreeController
BindingsJoystick
## 内存管理（Memory management）

### 内存管理规定

### 内存管理的各方面

### 预读文章
对象创建（Object creation）
对象拷贝（Object copying）
### 相关文章
对象生命周期（Object life cycle）
### 详细讨论
高级内存管理编程指南（Advanced Memory Management Programming Guide）
## 消息（Message）

### 预读文章
无
### 相关文章
Objective-C
类的定义（Class definition）
选择器（Selector）
### 详细讨论
对象发送和接收消息（Objects Send and Receive Messages）
## 方法重写（Method overriding）

### 预读文章
无
### 相关文章
无
### 详细讨论
对象可以调用被其他父类实现的方法（Objects Can Call Methods Implemented by Their Superclasses）
## 模型对象（Model object）

### 一个设计良好的模型类

### 预读文章
模型-视图-控制器(Model-View-Controller)
类的定义(Class definition)
### 相关文章
编码惯例(Coding conventions)
声明属性(Declared property)
对象的拷贝(Object copying)
### 详细讨论
使用OC编程（Programming with Objective-C）
## 模型-视图-控制器（Model-View-Controller）
模型－视图－控制器（MVC）设计模式为一个应用当中的对象赋予了三种角色：模型，视图或者控制器。设计模式不仅定义了对象在应用程序当中扮演的角色，也定义了对象与其它对象进行交互的方式。这三种类型的对象的每一种都被一个抽象的边界与其它两种分隔开，并且通过这个边界与其它类型的对象进行交互。在一个应用当中的一个特定的MVC类型的对象的集合有时候被称作一个层——举例来说，模型层。  
对于Cocoa应用程序而言，MVC是非常重要的一种设计模式。采用这套设计模式的收益是显而易见的。在应用中的很多对象都能够被更好的复用，并且它们的接口也会被更好的定义。使用MVC模式设计的应用程序也会比其他的应用程序更容易扩展。此外，很多cocoa的技术和架构都是基于MVC的，并且它需要你的自定义对象能够扮演一个MVC当中的角色。    
![](https://developer.apple.com/library/content/documentation/General/Conceptual/DevPedia-CocoaCore/Art/model_view_controller_2x.png)  
### 模型类
模型对象封装了一个应用的指定数据，它定义了操作和处理数据的逻辑和计算。举例来说，一个模型对象可能表示一款应用当中的一个字符或者一个地址簿当中的一个联系人。一个模型对象可以与其他模型对象拥有一对一或者一对多的关系，正因为如此，有时候一款应用的模型层实际上是一个或多个对象的关系。大部分数据是应用的持续状态的一部分（无论该状态是被存储到文件还是数据库当中），它应该在数据被载入到应用当中后，存储到模型对象当中。由于模型对象表现了关于一个特定问题的相关信息，它也能够在相似的问题当中复用。理想情况下，一个模型对象应该与展示它的数据和允许用户编辑数据的界面没有直接的联系——它应该与用户界面和展示的问题是无关的。    
交互：创建或修改数据的视图层中的用户操作通过控制器对象进行通信, 并导致创建或更新模型对象。当一个模型对象改变的时候（比如通过网络获取到了新的数据），它会通知一个控制器对象，后者会更新相应的视图对象。
### 视图类
一个视图对象是一个应用当中用户能够看到的部分。一个视图对象知道如何绘制它本身以及响应用户的行为。视图对象的主要目的是展示从应用模型对象获取到的数据，并且将该数据变得可以编辑。尽管如此，视图对象在一个MVC应用当中，还是能够和模型对象解耦的。  
由于你对于视图对象的重用和重新配置，视图对象能够在应用之间保持一致性。无论UIKit还是AppKit框架都提供了大量的视图类的集合，在IB的库当中也提供了大量的视图对象可供调用。  
交互：通过应用程序的控制器对象，视图对象会获取到模型数据的变化，并且与用户发起交互——比如用户在一个输入框中输入文字——通过控制器对象处啊俺滴给一个应用的模型对象。
### 控制器类
一个控制器对象在一个或多个应用的视图对象和模型对象之间扮演了中间人的角色。
### 预读文章
消息（Message）
### 相关文章
模型对象（Model object）
控制器对象（Controller object）
### 详细讨论
模型-视图-控制器（Model-View-Controller）
## 多种初始化（Multiple initializers）

### 特定的初始化

### 预读文章
对象的创建（Object creation)
初始化(Initialization）
### 相关文章
声明属性（Declared property）
### 详细讨论
对象是动态创建的（Objects Are Created Dynamically）
## nib文件（Nib file）

### 预读文章
对象的归档(Object archiving)
对象之间的关系(Object graph)
### 相关文章
模型-视图-控制器（Model-View-Controller）
故事版（Storyboard）
### 详细讨论
nib文件（Nib Files）
## 通知（Notification）

### 通知对象

### 监听通知

### 发送通知

### 预读文章
选择器(Selector)
消息(Message)
### 相关文章
代理（Delegation）
模型-视图-控制器（Model-View-Controller）
单例（Singleton）
### 详细讨论
通知编程主题（Notification Programming Topics）
### 示例代码工程
HeadsUpUI
## 对象归档（Object archiving）

### key和连续归档

### 创建和解码key归档

### 预读文章
对象关系(Object graph)
对象编码(Object encoding)
### 相关文章
模型对象(Model object)
属性列表(Property list)
对象声明周期(Object life cycle)
### 详细讨论
归档和序列化编程指南（Archives and Serializations Programming Guide）
### 示例代码工程
Lister (for watchOS, iOS, and OS X)
## 对象比较（Object comparison）

### 实现比较逻辑

### 预读文章
消息(Message)
### 相关文章
内省(Introspection)
### 详细讨论
无
## 对象拷贝（Object copying）

### 对象拷贝的前提条件

### 内存管理的启示

### 预读文章
对象的创建(Object creation)
协议(Protocol)
### 相关文章
内存管理(Memory management)
对象的生命周期(Object life cycle)
### 详细讨论
NSCopying协议参考(NSCopying Protocol Reference)
## 对象创建（Object creation）

### 对象创建的格式

### 内存管理的启示

### 工厂方法

### 预读文章
消息(Message)
### 相关文章
初始化（Initialization）
内存管理（Memory management）
对象生命周期（Object life cycle）
### 详细讨论
使用对象(Working with Objects)
## 对象编码（Object encoding）

### 如何编解码一个对象

### key的相对连续归档

### 预读文章
类的定义(Class definition)
协议(Protocol)
### 相关文章
对象的归档（Object archiving）
属性列表（Property list）
对象生命周期（Object life cycle）
### 详细讨论
对象的编码解码(Encoding and Decoding Objects)
### 示例代码工程
Reducer
## 对象关系（Object graph）

### 相关文章
对象的归档（Object archiving）
nib文件（Nib file） 
## 对象生命周期（Object life cycle）

### 预读文章
对象的创建（Object creation）
对象的归档（Object archiving）
### 相关文章
内存管理（Memory management）
nib文件（Nib file）
对象的编码（Object encoding）
### 详细讨论
使用对象（Working with Objects）
## 对象建模（Object modeling）

### 预读文章
无
### 相关文章
模型-视图-控制器(Model-View-Controller)
## 对象的可变性（Object mutability）

### 接收可变对象

### 存储可变对象

### 预读文章
类的定义（Class definition）
消息（Message）
### 相关文章
内省（Introspection）
声明属性（Declared property）
### 详细讨论
对象的可变性（Object Mutability）
## 对象所有权（Object ownership）

### 预读文章
无
### 相关文章
无
### 详细讨论
通过关系和责任管理对象的关系（Manage the Object Graph through Ownership and Responsibility）
### 示例代码工程
无
## Objective-C

### 预读文章
无
### 相关文章
无
### 详细讨论
OC编程语言（Programming with Objective-C）
## 属性列表 （Property list）

### 属性列表类型和对象

### 最佳属性列表

### 属性列表序列化

### 预读文章
对象关系（Object graph）
容器类（Collection）
### 相关文章
对象的归档（Object archiving）
对象的可变性（Object mutability）
### 详细讨论
属性列表编程指南（Property List Programming Guide）
### 示例代码工程
People
## 协议（Protocol）

### 形式与非形式的协议

### 符合和才用一个正式协议

### 创建你自己的协议

### 预读文章
Objective-C
### 相关文章
分类（Category）
代理（Delegation）
内省（Introspection）
### 详细讨论
使用协议（Working with Protocols）
### 示例代码工程
LocateMe
## 根类（Root class）
根类不从任何类继承，它定义了继承链中其他所有对象的基本行为。所有继承链中的对象最终都是继承自根类。根类通常用做一个基类。  
OC当中的根类是NSObject类，它是Foundation框架的一部分。Cocoa 或 Cocoa Touch程序中的所有对象最终都是继承自NSObject。该类是通过其他类关联OC运行时的主要入口点。它还定义了对象的基本接口以及实现了对象的基本行为，包括内省，内存管理以及方法调用。Cocoa 和 Cocoa Touch对象拥有对象的能力很大程度上源自根类。  

![](https://developer.apple.com/library/content/documentation/General/Conceptual/DevPedia-CocoaCore/Art/root_class_2x.png)  

	注意：Foundation 框架还定义了其他的根类 NSProxy，不过该类很少用在Cocoa程序中，基本不会用在Cocoa Touch程序中。

根类NSObject遵循一项协议，同样名称为NSObject，这种设计有助于编程接口。协议指定了任何根类需要的基本编程接口。

### 预读文章
Cocoa (Touch)
### 相关文章
内省（Introspection）
内存管理（Memory management）
### 详细讨论
OC编程语言（Programming with Objective-C）
## 选择器（Selector）
一个selector代表一个对象用来执行的方法名，或者是当源代码被编译时替换的唯一标识。一个selector本身并不做任何事。它仅仅标识了一个方法。selector方法名与一个字符串的唯一区别是编译器会确保该selector是唯一的。
### 获取选择器
编译的selector是SEL类型的。通常有两种方式来获取一个selector：

* 在编译时，你可以使用编译程序指令@selector。
	
		SEL aSelector = @selector(methodName);
* 在运行时，你可以使用NSSelectorFromString函数，字符串为方法名：

		SEL aSelector = NSSelectorFromString(@"methodName");
当你希望代码在运行时发送可能不知道其名称的消息时, 可以使用从字符串创建的选择器。

### 使用选择器
可以使用带有 performSelector: 的选择器和其他类似方法调用方法。

	SEL aSelector = @selector(run);
	[aDog performSelector:aSelector];
	[anAthlete performSelector:aSelector];
	[aComputerSimulation performSelector:aSelector];

你应该在特殊的地方使用该技术，比如当你实现一个使用目标-动作设计模式对象的时候。通常，你会直接调用该方法。
### 预读文章
消息（Message）
### 相关文章
动态绑定（Dynamic binding）
### 详细讨论
使用Objects（Working with Objects）
## 单例（Singleton）
无论应用程序请求多少次，一个单例类始终都会返回同一个对象。一个标准的类会在调用者要求创建该类的对象时直接创建，无论调用多少次，而对于单例而言，每次这个过程都只会返回唯一的实例对象。一个单例对象会提供一个全局的访问接口来访问它的类的资源。单例一般用在需要控制的单点问题当中，例如某个类提供通用的服务或者资源。  

![](https://developer.apple.com/library/content/documentation/General/Conceptual/DevPedia-CocoaCore/Art/singleton_2x.png)  

你可以通过一个工厂方法来获取单例的全局实例变量。在该类第一次被请求创建实例变量的时候，会懒加载它唯一的实例变量，并且在那之后会确保没有任何其他的实例会被创建。单例类同样也会组织调用者拷贝、持有或者释放该实例。如果你发现你需要的话，你也可以创建自己的单例类。例如，如果在你的程序中，需要有一个类为其他的对象提供声音，你可能就需要一个单例了。  
有一些Cocoa的框架类是单例模式的。包括NSFileManager，NSWorkspace以及在UIKit中的UIApplication 和 UIAccelerometer。按照惯例，工厂方法的名称会以sharedClassType的格式返回单例的名称。比如，Cocoa框架中的示例：sharedFileManager，sharedColorPanel，和 sharedWorkspace。
### 预读文章
对象的创建（Object creation）
### 相关文章
对象的拷贝（Object copying）  
内存管理（Memory management）
### 详细讨论
无
## 统一类型标识（Uniform Type Identifier）

### 统一类型标识使用了反向系统域名惯例

### 统一类型标识在一个一致性的层级当中被声明

### OS X应用通过定义添加了新的统一类型标识在app包当中

### 预读文章
包（Bundle）  
属性列表（Property list）
### 相关文章
无
### 详细讨论
统一类型标识概览（Uniform Type Identifiers Overview）
### 示例代码项目
无
## 值对象（Value object）
值对象本质上是一个基本数据元素（例如字符串、数字或者日期）的面向对象的封装。在Cocoa中的常用类是NSString, NSDate, 和 NSNumber。值对象通常被认为是你创建的自定义的对象。  
值对象比常用的简单基本类型（比如char, NSTimeInterval, int, float, 或 double）提供更为丰富的行为：  

* 你可以将任意的值对象添加到集合中，比如NSArray 或 NSDictionary的实例。
* 使用NSString以及它的子类NSMutableString，你可以进行多种不同的字符串相关的操作。比如，你可以拼接字符串，切分字符串，在文件路径当中进行使用，转换大小写，以及搜索子串等。在所有的这些使用中，字符串对象都是以Unicode编码进行使用的。
* 使用NSDate，结合NSCalendar和其他相关的类，你可以进行复杂的日期计算，比如基于用户的日历确定两个时间点之间的月份或者天数，考虑时区和闰年的变量因素等。
* 使用NSNumber的子类NSDecimalNumber，你可以进行基于货币的计算。

### NSValue
NSValue为一个C或者OC数据项提供了简单的封装。它支持任意的标准类型，比如char, int, float, 或 double，同样支持指针，结构体以及对象的ID类型。它还能让你给容器类添加数据项，比如NSArray 和 NSSet，不过这需要元素必须是对象。这在你需要将指针，size或者矩形结构体（比如NSPoint, CGSize, 或 NSRect）添加到一个集合类中时非常有用。
### 预读文章
无