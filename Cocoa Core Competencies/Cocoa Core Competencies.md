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
存取器方法是一个实例方法，它能够对一个对象的属性的值进行获取或设置。在Cocoa的术语中，一个检索对象的属性的值的方法被称作“getter”方法；一个改变对象的属性的值的方法被称作“setter”方法。这些方法通常成对出现，为获取或设置一个对象的属性的值来提供API。  
你应该使用存取器方法而非直接访问状态数据，因为存取器方法提供了一个抽象层。以下是两点存取器提供的功能：  

* 当一个属性的表现形式和存储方式发生改变的时候，你无需重写你的代码。
* 存取器方法通常会在一个值被检索或设置的时候实现。比如，setter方法经常会实现内存管理的代码并且通知其它对象一个值发生改变了。

### 命名规范
由于这种模式非常重要，Cocoa为命名存取器方法定义了一些命名规则。给定一个属性以类型（type）和名称（name），你应当以以下格式实现存取器：

	- (type)name;
	- (void)setName:(type)newName;

一种例外的情况是该属性是一个布尔值。比如拿一个属性名为isName的getter方法举例：

	- (BOOL)isHidden;
	- (void)setHidden:(BOOL)newHidden;
	
这种命名规则非常重要，因为其他的Cocoa功能会依赖于它，尤其是KVC（键值编码）。Cocoa不会使用getName，因为Cocoa中以“get”开头的方法表示该方法会以引用的方式返回值。
### 预读文章
键值编码（Key-value coding）
### 相关文章
内存管理（Memory management）
声明属性（Declared property）
### 详细讨论
使用存取器方法来获取或设置属性的值 (Use Accessor Methods to Get or Set Property Values)
## App ID
App ID是一个两个字符串所组成的用来区分一个开发团队的一款或多款apps的标识符。该字符串由一个Team ID和一个bundle ID检索字符串所组成，使用句点（.）分割为两部分。Team ID由Apple提供用来作为一个特定开发团队的唯一标识，而bundle ID检索字符串由你提供，用来匹配一款或一组bundle ID的app。  

![](https://developer.apple.com/library/content/documentation/General/Conceptual/DevPedia-CocoaCore/Art/app_ids_2x.png)  

有两种类型的App IDs：一种叫做“确定的app id”，用来表示一款app，还有一种叫做“通配符app id”，用来表示一组app。

### 一个显式的App ID对应一款App
对于一个确定的app id匹配一款app而言，app id中的Team ID必须等于与app相关的Team ID，并且bundle ID检索符业必须等于app的bundle ID。bundle ID是一个app的唯一标识符，并且它无法被其他团队所使用。
### 通配符App IDs对应多款App
一个通配符App ID会在它的bundle ID检索串的末尾包含一个星号。星号取代了一部分或者所有的检索串的bundle ID。

![](https://developer.apple.com/library/content/documentation/General/Conceptual/DevPedia-CocoaCore/Art/app_ids_wildcard_2x.png)

当使用bundle ID检索串匹配bundle IDs的时候，星号被看作通配符。对于一个通配符app id来匹配一组app而言，bundle ID必须与bundle ID检索串中的星号前所有字符精确匹配。星号匹配了所有保留在bundle ID中的字符串。星号必须至少匹配bundle ID中的一个字符。下表展示了一个bundle ID检索串与一些bundle ID匹配和不匹配的情况。

com.domain.*  |   | bundle id 检索符
------------- | ------------- | -------------  
 com.domain.text | ![](https://developer.apple.com/library/content/documentation/General/Conceptual/DevPedia-CocoaCore/Art/checkmark_2x.png) | 星号对应text
com.domain.icon  | ![](https://developer.apple.com/library/content/documentation/General/Conceptual/DevPedia-CocoaCore/Art/checkmark_2x.png) | 星号对应icon
com.otherdomain.database  | ![](https://developer.apple.com/library/content/documentation/General/Conceptual/DevPedia-CocoaCore/Art/x_2x.png) | 无法匹配
com.domain  | ![](https://developer.apple.com/library/content/documentation/General/Conceptual/DevPedia-CocoaCore/Art/x_2x.png) | 无法匹配
com.domain.  | ![](https://developer.apple.com/library/content/documentation/General/Conceptual/DevPedia-CocoaCore/Art/x_2x.png) | 无法匹配

对于通配符App ID匹配一款app而言，Team ID必须相匹配，bundle ID必须与使用通配符规则的bundle ID检索符相匹配。
### 相关文章
无
### 详细讨论
app分发指南
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
block（块）是一个C语言级别的语法，它是一个运行时的功能，能够让你将函数表达式作为参数进行传递，随意的存储并被多线程所使用。函数表达式能够被引用并且能够通过本地变量所存储访问。在其他编程语言或环境中，一个block对象通常被称作闭包或者lambda。当你需要创建一组任务的时候（代码段）你就可以使用block，它们可以作为值来进行传递。block为编程语言提供了更灵活和更强大的功能。在写回调函数或执行一个集合类中所有对象的操作时就可以使用它。  
### 声明一个Block
在大多数情况下，使用block都是直接使用的，所以你无需声明它。不过，声明的语法与函数指针的标准语法类似，不过你要用脱字符(^)替代星号指针(*)。举个例子，以下语句声明了一个变量aBlock，它引用了一个block，该block需要三个参数，返回值为float类型：  

	float (^aBlock)(const int*, int, float);

### 创建一个Block
使用脱字符(^)作为block的开始，以分号作为block表达式的结尾。下例展示了一个简单的block，它赋值给之前声明的block变量(oneFrom):  

	int (^oneFrom)(int);
	oneFrom = ^(int anInt) {
   		 return anInt - 1;
	};

末尾的分号与一个标准C语句的末尾的分号一样是必须的。  
若你不需要声明一个block表达式的返回值，它能够自动的从block的内容中推导出。
### Block变量
你可以使用__block存储修饰符与声明在闭包词法范围内的上下文中声明，表示block中被引用的变量是可变的。任何改变都会发生在闭包语法范围内，包括任何其他的定义在相同的闭包语法范围中的block。  
### 使用Block
若你声明了一个block作为变量，你可以使用它作为函数，以下示例会输出9。  

	printf("%d\n", oneFrom(10));

不过，通常你会将block作为一个参数传递给一个函数或方法。在这种情况下，你会直接创建一个block。  
下例展示了一个NSSet对象是否包含一个本地变量指定的单词，若包含的话，会将另一个本地变量（found）设置为YES（然后停止检索）。在这个例子中，found被声明为__block变量。

	__block BOOL found = NO;
	NSSet *aSet = [NSSet setWithObjects: @"Alpha", @"Beta", @"Gamma", @"X", nil];
	NSString *string = @"gamma";
 
	[aSet enumerateObjectsUsingBlock:^(id obj, BOOL *stop) {
   		 if ([obj localizedCaseInsensitiveCompare:string] == NSOrderedSame) {
       	 *stop = YES;
	        found = YES;
   		 }
	}];
	// At this point, found == YES

在这个例子中，block被包含在方法的参数列表中。block同样能够用做一个堆本地变量。
### 比较操作
在Cocoa环境中，一个你经常执行的block的操作是比较两个对象——比如给一个数组的内容进行排序。OC语言定义了一个block类型——NSComparator——用来执行这些比较。
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
使用分类能够为已经存在的类定义额外的方法——即使是你无法获取到源代码的类——而不用继承它。通常使用分类来为Cocoa框架中已经定义好的类来添加方法。添加的方法会被子类所继承，并且在运行时表现与原类的方法一致，是无法进行区分的。你还可以将分类用到你自己的类当中：  

* 将你自己的类的实现分离到不同的文件中——比如，你可以将一个大类的方法分组到不同的分类中，然后将分类放到不同的文件中。
* 声明私有方法。

通过在一个分类名下声明一个方法将方法添加到头文件中，在同样的名称下将方法在实现文件中进行定义来添加一个方法到问类。分类名表示该方法是一个已经存在的类在其他位置的扩展，而非一个新类。
### 声明
一个分类的头文件的声明很像一个类的头文件的声明——只有一点不同，该分类名被放在括号中，在类名之后，而子类不会这么做。一个分类必须导入它要扩展的类的头文件。  

	#import "SystemClass.h"
 
	@interface SystemClass (CategoryName)
	// method declarations
	@end

一个常用的命名规则是使用类名＋分类名来对分类进行命名。意思是文件名为：SystemClass+CategoryName.h。  
若你使用分类来为你自己的类声明私有方法的话，你可以将声明放在 @implementation 块前：  

	#import "MyClass.h"
 
	@interface MyClass (PrivateMethods)
	// method declarations
	@end
 
	@implementation MyClass
	// method definitions
	@end

### 实现
若你使用分类来为你自己的类声明私有方法的话，你可以将实现放在 你自己的类的 @implementation 块中。若你使用分类来扩展一个你没有源码的类或者拆分你自己的类的实现的话，你可以将实现放在一个命名为 < ClassName >+CategoryName.m的文件中，同样的，你要导入它自己的头文件。所以一个分类的实现可能会看起来像这样：  

	#import "SystemClass+CategoryName.h"
 
	@implementation SystemClass ( CategoryName )
	// method definitions
	@end

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
一个类的定义是类的对象在使用类的某个文件或语句的说明文档。一个类的定义最少由两部分组成：一个公共接口以及一个私有的实现文件。通常将接口和实现分为两个文件——头文件和实现文件。通过将公共和私有的代码进行分离，你可以将类的接口视作独立的整体。  
通常使用类名对接口和实现文件进行命名。由于需要包含在其他资源文件中，头文件的名称通常以.h作为扩展名。实现体的文件通常以.m作为扩展名，表示它所包含的是OC的源代码。举个例子，MyClass类会在MyClass.h中声明，MyClass.m中定义。
### 接口
在接口中，你可以做以下事情：  

* 命名类和其父类。你的类可能需要声明它所遵循的协议（参见Protocol）。
* 声明类的实例变量。
* 声明类所支持的方法和属性（参见声明属性）。

在接口文件中，首先需要导入所需的类库。（通常是Cocoa/Cocoa.h）使用@interface编译器指令在头文件的最开始声明类，以@end指令结尾。  

	#import <Cocoa/Cocoa.h>
 
	@interface MyClass : SuperClass {
   		 int integerInstanceVariable;
	}
	+ (void)aClassMethod;
	- (void)anInstanceMethod;
 	
	@end

### 实现
在类的头文件中声明方法，在实现文件中定义方法（编写代码来实现它们）。  
在头文件中，你首先需要导入需要的头文件。（至少应当包含你的类的头文件）以@implementation编译器指令作为实现类的开始，以@end指令作为结尾。

	#import "MyClass.h"
 
	@implementation MyClass
 
	+ (void)aClassMethod {
   		 printf("This is a class method\n");
	}
 
	- (void)anInstanceMethod {
   		printf("This is an instance method\n");
	    printf("The value of integerInstanceVariable is %d\n", 	integerInstanceVariable);
	}
 
@end

### 预读文章
无
### 相关文章
分类（Category）
存取器方法(Accessor method)
### 详细讨论
定义类（Defining Classes）
## 类方法（Class method）
类方法是一个作用于类对象的方法，而非类的实例对象。在OC中，以+号标记在方法的声明和实现之前表示该方法为类方法：

	+ (void)classMethod;

若要发送一个消息给一个类的话，需要将类名作为消息的接收者放在消息表达式中：  

	[MyClass classMethod];
	
### 子类
你可以给声明了同样方法的子类发送类方法消息。比如，NSArray声明了类方法 array，它返回一个新的数组实例对象。你也可以使用NSMutableArray的同样的方法，它是NSArray的子类：  

	NSMutableArray *aMutableArray = [NSMutableArray array];

在这种情况下，新的对象是NSMutableArray的实例对象，而非NSArray。
### 实例变量
类方法不能够直接引用实例变量。例如，给定以下类的声明：  

	@interface MyClass : NSObject {
	    NSString *title;
	}
	+ (void)classMethod;
	@end

你不可以在classMethod当中引用title。  
### self
在一个类方法的实现体中，self指的是类对象本身。你可以像这样实现一个工厂方法：  

	+ (id)myClass {
	    return [[[self alloc] init] autorelease];
	}

在该方法当中，self代表类要发送的消息。若你创建了一个MyClass的子类：

	@interface MySubClass : MyClass {
	}
	@end

然后发送了一个myClass消息给子类：  

	id instance = [MySubClass myClass];

在运行时，myClass方法的实现中，self将会表示MySubClass类（并且该方法回返回一个子类的实例对象）。
### 预读文章
无
### 相关文章
存取器方法(Accessor method)
### 详细讨论
定义类（Defining Classes）
## Cocoa (Touch)
Cocoa 和 Cocoa Touch分别是OS X和iOS的应用程序开发者环境。Cocoa 和 Cocoa Touch都包含了OC运行时和两个核心类库：  

* Cocoa，包含了Foundation 和 AppKit 框架，用来开发运行在OS X上的应用程序。
* Cocoa Touch包含了Foundation 和 UIKit 框架，用来开发运行在iOS上的应用程序。

```
注意：术语“Cocoa”通常用来指代机遇OC运行时的对象和类，以及继承自根类NSObject的类和对象。术语“Cocoa” 或 “Cocoa Touch”也会在使用各自平台的编码界面进行应用程序开发时使用到。
```
### 类库
Foundation框架实现了根类NSObject，它定义了基本对象的基本行为。它的实现类还包括基本类型（比如字符串和数字）和集合（比如数组和字典）。Foundation还提供了国际化的工具，对象持久化，文件管理和XML过程处理等。你可以使用这些类来访问低层的系统实体和服务，比如端口，线程，锁和进程。Foundation基于Core Foundation框架，它发布了一个程序 (ANSI C) 接口。  
你可以使用AppKit 和 UIKit 框架来开发一个应用程序的用户界面。这两个框架功能相同但是基于不同平台的。它们都包含了类来处理事件，绘制，图片处理，文字处理，排版和应用内数据传递等。它们同样也包括用户界面元素，比如列表视图，滑块，按钮，输入框和警告框等。  
### 语言本身
OC是开发Cocoa 和 Cocoa Touch 应用程序的主要语言。不过，Cocoa 和 Cocoa Touch 的代码工程可能会包含C++和ANSI C的代码。此外，你可以使用脚本语言通过OC运行时的连接机制来开发Cocoa应用程序，比如PyObjC和RubyCocoa。
### 预读文章
无
### 相关文章
根类(Root class)
Objective-C
### 详细讨论
无
## 编码惯例（Coding conventions）
编码惯例是一组帮助确保效率和API使用的一致性以及API命名的意志性的指南。若你在编写代码时遵循编码惯例，你会更少的遇到问题，比如运行时异常。若你遵循命名规范，那么你命名的方法、函数、常量或者其他的符号都会被需要和你一起开发的开发者更好的理解。  
定义在Cocoa框架中的方法——举例来说Foundation，AppKit和UIKit——在不同情况下表现在某些方面。比如：  

* 若方法无法创建或找到对象的话，通常会返回nil。它不会直接返回一个状态码。
* 执行一个操作的方法会返回一个布尔值表明成功或失败。
* 若一个方法使用一个集合对象——比如NSArray, NSDictionary, 或 NSSet对象——作为参数，不会指定nil作为默认值或没有值，而是传一个空集合对象。
* 若你需要显式的管理编码内存，请遵循内存管理的指南和实践。

以下是一些API命名惯例的例子：  

* 清晰与简洁同样重要，但清晰不应为简洁作出牺牲。
* 避免命名有歧义。
* 在表明动作的方法或函数中使用动词来命名。
* 使用前缀来为类名或其他与类相关的符号进行命名，比如函数或数据类型。

### 预读文章
无
### 相关文章
内存管理(Memory management)
### 详细讨论
Cocoa编码指南(Coding Guidelines for Cocoa)
## 集合（Collection）
集合是一个Foundation框架中的对象，它主要是用来以数组、字典和集合的形式来存储对象。
### 集合类
主要的几种集合类——NSArray, NSSet, 和 NSDictionary——同时拥有几种通用功能：  

* 它们只持有对象，但对象可以是任何类型。拿NSArray实例来说，它可以包含猫、狗或树袋熊或者任何这些的组合。
* 它们对于它们的元素强引用。
* 它们是不可变的，但都各自有可变的子类能够让你改变集合的内容。
* 你可以使用NSEnumerator或快速枚举来对其内容进行迭代。

Cocoa同样也提供了三个类——NSPointerArray, NSHashTable, 和 NSMapTable——这些类都与之前的集合类类似，但在以下几个方面不同：  

* 它们不止能够存储对象。
* 它们对于对象还提供内存管理选项。
* 它们是可变的。

Cocoa集合对象能够持有任意顺序的对象，通常不用创建特定的集合类来包含一种特定的类型的对象。
### 排序方案
集合存储和出售特定排序方案中的其他对象：  

* NSArray和它的可变子类NSMutableArray使用以从0开始的索引。在其他环境下，一个数组可能被称作vector, table, 或 list。NSPointerArray与NSMutableArray类似，但它能够持有NULL值（能够算做对象的个数）。你还能够直接设置指针数组的个数（对于数组你就不能这么做了）。
* NSDictionary和其可变子类NSMutableDictionary使用的是键值对。在其他环境下，一个字典可能被称作hash table 或 hash map。NSMapTable与NSMutableDictionary类似，但提供不同的选项，尤其是在垃圾回收环境下支持弱引用关系。
* NSSet和其可变子类NSMutableSet提供了对象的无序存储。Cocoa同样提供了NSCountedSet，它是NSMutableSet的子类，它能够记住每个对象被添加到集合中多少次。NSHashTable与NSMutableSet类似，但提供了不同的选项，通常是在垃圾回收环境下支持弱引用关系。

### 预读文章
无
### 相关文章
枚举(Enumeration)
### 详细讨论
集合编程主题(Collections Programming Topics)
## 控制器对象（Controller object）
一个控制器对象在一个或多个视图对象和一个或多个模型对象之间扮演协调者或中间人的角色。在MVC设计模式中，一个控制器对象（或简单来说，一个控制器）会解释视图对象中的用户的动作和目的——比如当用户轻触或点击一个按钮或在一个输入框中输入了文字——并将新数据或改变的数据传输给模型对象。当模型对象改变时——举例来说，用户打开了一个存储在文件系统中的文档——控制器对象将新模型数据传递给视图对象以便后者能够展示它。控制器还是视图对象获取模型对象变更（反之亦然）的渠道。控制器对象还能够为应用程序和管理其他对象的生命周期进行设置和协调任务。Cocoa框架提供了三种主要的控制器类型：协调控制器，视图控制器（iOS）和媒体控制器（OS X）。  

![](https://developer.apple.com/library/content/documentation/General/Conceptual/DevPedia-CocoaCore/Art/controller_object_2x.png)  

### 协调控制器
协调控制器统揽和管理整个应用程序（或一部分）的函数。它们通常是应用程序特定逻辑的注入部分。一个协调控制器包含了各种各样的函数，包含：  

* 响应代理消息和监听通知
* 响应动作消息（当用户轻触或点击时被按钮等控件发送）
* 在对象和执行的启动任务之间建立联系，比如当应用程序启动时
* 管理“拥有”的对象的生命周期

协调控制器通常是NSObject子类的实例对象。在OS X中，若一个Cocoa应用程序使用了文档结构，协调控制器通常是一个 NSWindowController 或 NSDocumentController 的对象。在iOS应用程序中，视图控制器通常包含了协调控制器的作用。  
### 视图控制器
UIKit 和 AppKit 框架同时提供了视图控制器类（iOS和OS X分别提供），但这些类的特性不同。在AppKit中，视图控制器是一个 NSViewController 类的子类的实例对象。视图控制器拥有在一个nib文件中的视图归档，该视图表示一个数据对象。视图控制器管理着它的视图的子视图的连接和更新。  
在UIKit中，视图控制器管理着一个充满屏幕内容的视图；它持有该视图并创建或从一个nib文件中加载它。控制器管理着该视图的展示并负责随后app中的视图的过渡。（大部分情况下，下个视图都从右部滑入。）导航栏和页签栏以及其他相关的展示行为都被视图控制器对象所管理和实现。视图控制器还能够展示模态视图，响应低内存警告以及当设备的方向改变时旋转视图。  
iOS中的视图控制器是 UIViewController 类的子类的实例对象。UIKit提供了多种 UIViewController 的子类来做特定用途，比如UITableViewController。你最好通过扩展框架中已有的视图控制器的类来协调模型和视图之间的数据。视图控制器通常为框架对象的多种类型作为代理或数据源。  
### 媒体控制器（OS X）
媒体控制器简化了视图对象和模型对象之间的数据流。当用户改变了一个展示在视图对象中的值时，媒体控制器自动的将新的值传输给一个模型对象来存储；当一个模型的属性改变了它的值时，媒体控制器会确保相应的视图对象展示值的变更。不像其他类型的控制器对象，媒体控制器时能够高度复用的。正因为此（以及其他原因），媒体控制器是Cocoa绑定技术的中心组件。你可以从界面编辑器中拖拽一个媒体控制器然后配置控制器对象和视图对象和模型对象之间的绑定关系。一个媒体控制器通常是抽象的 NSController 类的子类的实例对象。
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
一个声明的属性为一个类的访问和实现（可选）方法提供了一个简短语法。你可以在方法的声明列表的任意位置声明一个属性，只要是一个类的接口或者在一个协议或分类当中都可以。你应当使用以下语法：  

	@property (<#attributes#>) <#type#> <#name#>;

使用关键字@property作为声明属性的开始。随后使用括号括上可选的属性特性，属性特性定义了存储特性以及其他属性的行为。（参考定义描述属性列表的文档来描述这些特性。）  
每个属性声明以类型说明符和一个名称作为结尾，比如：  

	@property(copy) NSString *title;

该语句等同于声明了以下存取方法：  

	- (NSString *)title;
	- (void)setTitle:(NSString *)newTitle;

除了声明存取方法，你还可以指示编译器来合并存取方法的实现（或通知编译器你的类将在运行时合成它们）。  
使用 @synthesize 语句在类的实现体中告知编译器来创建匹配你在属性中声明的实现。  

	@interface MyClass : NSObject
	{
   		 NSString *title;
	}
	@property(copy) NSString *title;
	@end
 
	@implementation MyClass
	@synthesize title;
	@end

使用@dynamic语句来告知编译器在无法找到被@property声明实现的存取方法时不要提示警告。  

	@implementation MyClass
	@dynamic title;
	@end

### 预读文章
存取方法(Accessor method)
### 相关文章
无
### 详细讨论
属性封装了一个对象的值(Properties Encapsulate an Object’s Values)
## 委托（Delegation）
当一个对象在程序中代表或协调另一个对象时，委托是一种简单并有效的设计模式。委托的对象持有其他对象的引用——委托——并在适当的时机发送消息给它。消息会通知委托一个事件，委托的对象会处理该事件或持有该事件。委托可能需要通过更新界面或本身的状态或者其他应用程序中的对象来响应消息，在某些情况下，它可以返回一个可能影响即将发生的事件被处理的值。委托的主要价值是允许你能够简单的给几个不同的对象定制行为到一个集中的对象上。  
### 委托和Cocoa框架
委托对象通常是一个框架对象，委托通常是一个自定义的控制器对象。在一个可控的内存环境中，委托对象持有一个委托的弱引用；在垃圾回收的环境下，接收者持有一个委托的强引用。在Foundation, UIKit, AppKit, 和其他 Cocoa 和 Cocoa Touch 的框架中有着大量的委托模式。  
一个委托的例子就是AppKit框架的NSWindow类的实例对象。NSWindow声明了一个协议，该方法是 windowShouldClose:。当用户点击一个窗口的关闭按钮时，窗口对象将发送windowShouldClose: 给它的委托要求它确认关闭窗口。委托会返回一个布尔值，用来控制窗口对象的行为。  

![](https://developer.apple.com/library/content/documentation/General/Conceptual/DevPedia-CocoaCore/Art/delegation_2x.png)

### 委托和通知
大部分Cocoa框架类当中的委托都自动的注册了一个被委托对象发送的通知的监听。委托仅需要实现一个被框架类声明的通知方法来接收一个特有的通知消息。比如上述的例子中，一个窗口对象会发送一个NSWindowWillCloseNotification 通知给其监听，但会发送一个 windowShouldClose: 消息给其代理。
### 数据源
数据源与委托几乎相同。区别是与委托对象之间的关系。数据源是被委托来管理数据而非用户界面。被委托的对象通常是一个视图对象，比如列表视图，会持有一个它的数据源然后不定时的询问该数据源数据如何展示。一个数据源与委托类似，必须遵守一个协议并实现该协议所要求实现的最少的必须方法。数据源负责管理模型对象给予委托视图的内存。
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
枚举是一个顺序操作一个对象的元素的过程——通常是一个集合——一次至多顺序操作一个。枚举也被称作迭代。当你枚举一个对象时，通常一次选择对象中的一个元素然后对其执行操作。对象通常是一个数组或一个集合。从最简单的概念来讲，你可以使用一个标准C语言的for循环来枚举一个数组中的内容，如以下例子所示：  

	NSArray *array = // get an array;
	NSInteger i, count = [array count];
	for (i = 0; i < count; i++) {
   		 id element = [array objectAtIndex:i];
	    /* code that acts on the element */
	}

使用for循环效率较低，并且需要一个有序集合的元素。枚举更为通用。所以Cocoa提供了两种额外的方法来枚举对象——NSEnumerator类和快速枚举。  
### NSEnumerator
在一些Cocoa类中，包括集合类，能够被要求提供一个枚举器以便让你能够通过持有一个实例对象来检索元素，比如：  

	NSSet *aSet = // get a set;
	NSEnumerator *enumerator = [aSet objectEnumerator];
	id element;
 
	while ((element = [enumerator nextObject])) {
   		 /* code that acts on the element */
	}

不过通常来说，使用NSEnumerator类是为了代替快速枚举。
### 快速枚举
某些Cocoa类，包括集合类，遵守了NSFastEnumeration协议。你可以使用一个类似于标准C语言的for循环的语句来持有一个实例对象对其进行元素的检索，如下例所述：  

	NSArray *anArray = // get an array;
	for (id element in anArray) {
   		 /* code that acts on the element */
	}

就像名称所建议的那样，快速枚举是比其他形式的枚举更为有效的枚举方式。
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
类库是一种bundle（结构化的目录），它包含了与资源相关的动态共享库，比如nib文件，图片文件以及头文件。当你开发一款应用程序时，你的工程会链接到一个或多个类库上。比如，iPhone应用程序工程默认会链接到Foundation, UIKit, 和 Core Graphics 等类库上。你的代码通过应用程序接口（API）会有访问类库的能力，API是由类库通过其头文件公布的。由于类库内容是动态共享的，多个应用程序都可以同时访问类库的代码和资源。系统会根据需要将一个类库的代码和资源加载到内存中，并在所有的应用程序之间共享一份资源的拷贝。  

![](https://developer.apple.com/library/content/documentation/General/Conceptual/DevPedia-CocoaCore/Art/framework_2x.png)

由于一个类库是一个bundle（包），你可以通过使用 NSBundle 类来访问其内容，或者通过程序中的Core Foundation中的CFBundle。你可以在OS X上创建自己的类库，但第三方类库在iOS上不允许创建。在OS X上，你可以在Finder当中浏览类库的内容。当为不同的平台开发的时候，你还可以在Xcode应用程序中查看类库的头文件。  

```
注意：本章所引用的详细讨论的文档特指OS X。若你使用的是iOS开发引用库的话，该链接无效。
```

### 预读文章
包(Bundle)
### 相关文章
无
### 详细讨论
类库编程指南（Framework Programming Guide）
## 信息属性列表（Information property list）
一个信息属性列表是一个结构化的文字，它阐述了一款应用程序或其他可执行文件的配置信息。操作系统会在运行时从信息属性列表中提取数据并以适当的方式对其进行处理。举例来说，当iOS和OS X（分别的）系统在主屏幕或Finder中列出应用程序时，操作系统会从已经安装的应用程序的信息属性列表中获取这些应用程序的名称。  
信息属性列表的内容是被结构化的XML，它的根节点是一个字典。该字典包含了一连串的键值对或属性，key是一个key元素，value是一个表明值的数据类型的元素。  

![](https://developer.apple.com/library/content/documentation/General/Conceptual/DevPedia-CocoaCore/Art/plist_2x.png)  

来看一个简单的键值对的例子：  

	<key>CFBundleDisplayName</key>
	<string>Mail</string>

在一个信息属性列表中的属性包括展示的名称，包ID，包图标，包的版本号，支持的操作系统以及文档类型。  
一个信息属性列表的文件名必须是Info.plist，文件大小写也必须是这样。文件中的文字必须是UTF-8编码。当你构建一款应用程序或其他包的时候，文件必须放置在包当中的一个指定位置。  
当你使用Xcode（主要使用的应用程序）来创建一款应用程序或其他包的项目的时候，Xcode会在你的项目的资源文件夹下创建一个名为ProjectName-Info.plist的文件。（当你运行你的项目的时候，该工具会拷贝该文件到包当中并命名为Info.plist。）Xcode会为你配置ProjectName-Info.plist文件中的部分属性，但通常你都需要再额外的添加一些。你可以在Xcode编辑器中通过直接选中文件来对信息属性列表进行编辑。你也可以在目标检查器的边栏中编辑某些属性。
### 预读文章
属性列表(Property list)
包(Bundle)
### 相关文章
无
### 详细讨论
信息属性列表key值参考（Information Property List Key Reference）
## 初始化（Initialization）
初始化是对象创建的阶段，它通过为对象设置一个合理的初始值来创建一个新的对象。初始化应当始终发生在分配内存之后。它被初始化方法（或简单来说初始器）所执行，你应当始终调用一个新分配内存的对象。初始器还可以执行其他的将对象设置为有用的状态的执行步骤，比如加载资源和分配堆内存。  
### 初始化声明的方式
按照惯例，初始器以init作为名称的开始。它会返回一个动态数据类型（id），若初始化未成功的话，会返回nil。一个初始器可以包括一个或多个特定的初始值的参数。  
以下是一个NSString类的初始器的声明例子：  

	- (id)initWithData:(NSData *)data encoding:(NSStringEncoding)encoding

### 实现初始化函数
一个类通常会为其对象实现初始器，但这并非必要的。若一个类没有实现一个初始器的话，Cocoa会调用距离类最近的父类的初始器。不过，子类通常会定义其自己的初始器或重写其父类的初始器来添加和子类相关的初始化内容。若一个类没有实现初始器的话，它第一步应当调用其父类的初始器。该步骤确保了对象在继承链条上（从根对象开始）的一系列初始化。NSObject类声明了init方法作为默认的对象初始器，所以它会最后调用但首先返回。  

![](https://developer.apple.com/library/content/documentation/General/Conceptual/DevPedia-CocoaCore/Art/initialization_2x.png)

实现一个初始器方法的基本步骤如下：  

1. 调用父类的初始器并检查它的返回值。（使用保留字super指代父类。）若值不为nil，父类的初始器会返回一个有效值，以便你继续进行初始化。
2. 将值赋值给对象的实例变量。在内存管理的代码中，若这些值是对象的，视情况对其进行copy 或retain。
3. 返回初始化后的对象，若初始化未成功，返回nil。

以下是一个遵从这些步骤的初始化示例，初始化它的date实例变量为当前日期：  

	- (id)init {
 	   if (self = [super init]) { // equivalent to "self does not equal nil"
        date = [[NSDate date] retain];
	    }
   	 return self;
	}

在示例代码中，若其父类返回nil的话，该方法会跳过初始化，然后返回值给其调用者。  
一个类可能会拥有多个初始器。当初始数据拥有多种样式或某个特定的初始器时，为了方便起见，为提供默认值就会有这种情况发生。在这种情况下，其中一个初始化方法被称作指定初始器，它将会提供所有的需要初始化的参数。  
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
KVC是一种使用字符串标识符来间接的访问一个对象的属性和关系的机制。它支撑着或与Cocoa编程的几种特殊机制和技术有关, 其中包括Core Data、应用程序脚本类型、绑定技术以及已声明属性的语言特征。(脚本类型和绑定是OS X的Cocoa特有。)你还可以使用KVC来简化你的编码。  
### 对象属性和KVC
键值编码 (或 KVC) 的核心是属性的通用概念。属性引用了一个对象所封装的一组状态。一个属性可以是两种通用状态中的一种：作为一个属性（比如name, title, subtotal, 或 textColor）或与其他对象所关联。关系可以是一对一或一对多。一对多的关系的值通常是一个数组或集合，情况根据关系是有序还是无序的有所不同。  
KVC通过一个key值定位一个对象的属性，key是一个字符串。key通常与对象所定义的访问方法名或实例变量名相关。key必须遵循一些特定的惯例：必须是ASCII编码，开头以小写字母开始，必须没有空格。key路径是一串以点号连接的key值，用于指定要遍历的对象属性序列。序列中的第一个key的属性用来指定对象（下图中的employee1），随后的key值代表之前的一个属性的属性值。  

![](https://developer.apple.com/library/content/documentation/General/Conceptual/DevPedia-CocoaCore/Art/key_value_coding_2x.png)  

### 让一个类能够顺利使用KVC
NSKeyValueCoding非正式协议使得KVC成为可能。它的两个方法——valueForKey: 和 setValue:forKey:——非常重要，因为当给定一个key值时，它们被用来获取和设置一个属性的值。NSObject为这些方法提供了默认的实现，若一个类遵从KVC协议的话，那么它就可以依赖默认的实现。  
如何使得一个属性的KVC能够顺利使用取决于该属性是一个特性、一个一对一的关系或者一个一对多的关系。对于特性和一对一的关系，类必须在给定的首选项顺序中至少实现下列任一项（key引用属性的key）：  

1. 类声明了名为key的属性。
2. 类要实现名为key的取方法，若该属性是可变的，要实现setKey:方法。（若属性是一个布尔值，取方法名称为isKey。）
3. 类要声明一个key或_key的实例变量。

为一对多的关系顺利实现KVC是一个更为复杂的过程。请参考本文档末尾的KVC描述来了解该过程。
### 预读文章
对象模型（Object modeling）
存取器方法(Accessor method)
### 相关文章
声明属性（Declared property）
### 详细讨论
键值编码编程指南（Key-Value Coding Programming Guide）
## 键值监听（Key-value observing）
KVO是一种当一个对象的属性发生改变时能够接收通知的机制。键值监听（或称作KVO）可以作为一款应用内聚的重要因素。它是在与模型-视图-控制器设计模式一致的应用程序中设计的对象之间的一种通信方式。举例来说，你可以使用它来同步模型、视图和控制器层的对象的状态。通常，控制器对象会监听模型对象，视图会监听控制器对象或模型对象。  

```
注意：尽管UIKit框架的类通常不支持KVO，你还是能够自己实现你的应用程序的自定义对象的KVO，包括自定义的视图。
```

![](https://developer.apple.com/library/content/documentation/General/Conceptual/DevPedia-CocoaCore/Art/kvo_2x.png)  

通过KVO，一个对象能够监听任意其他对象的属性，包括简单属性，一对一关系和一对多关系。一个对象可以找出属性的当前值和前一个数值。对于一对多关系的监听而言，将不仅会发送关于改变类型的相关信息，还会通知哪个对象涉及到改变了。  
作为通知机制，KVO与提供的NSNotification 和 NSNotificationCenter 类类似，但这是有本质区别的。与一个中心对象向注册了监听的所有对象发送广播的机制不同，KVO会在属性值发生改变时直接通知监听对象。  
### 实现KVO
根类NSObject对于KVO提供了一个基本实现，通常你不需要重写它。因此所有的Cocoa对象内置KVO的能力。若要接收KVO通知的话，你必须做以下事情：  

* 你必须确保所观察的类是符合你要观察的属性的键值观察。符合KVO需要被监听的对象同样要遵守KVC，并且还要允许对属性进行自动监听通知或对属性实现手动监听。
* 为一个值可能发生改变的对象添加监听。通过调用 addObserver:forKeyPath:options:context: 来实现。监听者是你的应用程序中的其他对象。
* 在监听者对象中，实现 observeValueForKeyPath:ofObject:change:context: 方法。当被监听的对象的属性发生改变时，该方法将会被调用。

### KVO是绑定中不可分割的一部分（OS X）
Cocoa绑定是一种OS X的技术，它能够让你将应用程序中模型和视图层中的值保持同步而无需编写大量的胶水代码。通过界面编辑器，你可以在视图的属性和一部分数据之间建立中介联系，“绑定”它们，这样在其中一个值发生改变时将会反馈给另一个。KVO，KVC和键值绑定都是Cocoa绑定的很有用的技术。
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
一个控制器对象在一个或多个应用的视图对象和模型对象之间扮演了中间人的角色。控制器对象会是一个模型层和视图层相互之间传递数据变更的桥梁。控制器对象还能够为应用程序执行相关的配置和协调任务，以及管理其它对象的生命周期。  
交互：控制器对象将用户的行为进行解释，然后添加到视图对象当中，并将增加或改变的数据更新到模型层。当模型对象改变的时候，控制器对象会将新的模型对象传递给视图对象以便后者对齐进行展示。
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

### 符合和采用一个正式协议

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