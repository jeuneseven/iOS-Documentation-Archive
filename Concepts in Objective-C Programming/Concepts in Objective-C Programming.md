[Concepts in Objective-C Programming 原文链接](https://developer.apple.com/library/content/documentation/General/Conceptual/CocoaEncyclopedia/Introduction/Introduction.html#//apple_ref/doc/uid/TP40010810)

# 关于Cocoa和Cocoa Touch的基本编程概念
很多Cocoa和Cocoa Touch框架的编程接口都是基于你对于概念的理解的。这些概念表达了很多框架的核心设计理念。通晓这些概念会让你的软件编程过程非常顺畅。  

![](https://developer.apple.com/library/content/documentation/General/Conceptual/CocoaEncyclopedia/Art/controller_object.jpg) 

## 概览
本文档阐述了Cocoa和Cocoa Touch框架的核心理念、设计模式以及基本运行机制。这些文章是按照字母排序的。  
## 如何使用本文档
如果你完整阅读本文档的话，你将会获取到关于Cocoa和Cocoa Touch应用开发环境的很多重要信息。然而，大部分文档的读者是以下两种：  

* 其他文档链接到本文档——尤其是那些准备开发iOS和OS X程序的开发者
* 一些内嵌的短文（一般出现在当你点击一个有波折号下划线的单词或短语时）链接到一篇文章作为"最终讨论"

## 预备知识
最好具备一些面向对象语言的编程经验
## 另请参阅
《OC编程语言》对于本文档覆盖的语言相关的概念提供了更为深入的讨论。
# 类簇
类簇是Foundation框架中广泛使用的一种设计模式。类簇将一组私有的实体子类集合在一个公有的抽象父类下。这些聚合在一起的类即简化了面向对象的框架的公开显式的架构又没有降低函数的丰富性。类簇是基于抽象工厂设计模式的。
## 没有类簇的情况：概念简单但是接口复杂
为了展示类簇的结构和优势，请假设构建一个类的层级，这个类定义的对象来存储多种不同类型的数据，char、int、float、double等。通常来讲，多种数据类型就意味着多种功能（例如他们可以互相转换，可以被表示为一个字符串），他们都需要被一个单一的类来表示。但是他们对于存储的需要是不同的，所以用同一个类来表达他们是很低效的。考虑到这种情况，图1-1设计了一种类的结构来解决这个问题。

图1-1 一个简单的number类的层级  

![](https://developer.apple.com/library/content/documentation/General/Conceptual/CocoaEncyclopedia/Art/cluster1.gif)

Number是一个父类，它声明了一些公有方法以供子类调用。但是它没有声明一个实例变量来保存一个数字。子类声明了接口变量并实现了被Number定义的接口。  
看上去这个设计似乎很简单。但是，如果用一种通用的方式修改这些基于C的数据类型到一个地方的话，这个类的结构看上去要像这样（见图1-2）：

图1-2 一个复杂的number类的层级  

![](https://developer.apple.com/library/content/documentation/General/Conceptual/CocoaEncyclopedia/Art/cluster2.gif)

如果概念比较简单的话（生成一个类来管理多种值），这会很容易扩展成很多的类。类簇的结构展现了一种设计模式，它大大简化了这一概念。

## 使用类簇的情况：概念简单接口也简单
使用类簇设计模式来解决这个问题，简化了类的层级，见图1-3（私有类以灰色显示）

图1-3 使用类簇的number类  

![](https://developer.apple.com/library/content/documentation/General/Conceptual/CocoaEncyclopedia/Art/cluster3.gif)

使用这个类的用户将会只看到一个公开的类，Number，那么它是如何实例化子类的属性呢？答案在于抽象了父类的实例化方法。

## 生成实例化
一个类簇中的抽象父类必须为生成私有的字类的实例声明方法。基于你调用的初始化方法为子类属性分配对象是父类的职责——你不应该去选择类的实例。  
在Foundation框架中，通常你是使用类方法或者alloc init方法来初始化一个对象。拿Foundation框架中的NSNumber举例来说，你应该发送这些消息来创建number对象。
> NSNumber *aChar = [NSNumber numberWithChar:’a’];  
NSNumber *anInt = [NSNumber numberWithInt:1];  
NSNumber *aFloat = [NSNumber numberWithFloat:1.0];  
NSNumber *aDouble = [NSNumber numberWithDouble:1.0];  

你无需在工厂方法的返回值处释放对象。很多类提供了标准的alloc和init方法来初始化对象，这需要你来管理对象的释放。  
每个返回的对象（aChar, anInt, aFloat, 和aDouble等）都有可能属于一个不同的私有子类（事实上也是如此）。尽管每个对象的类的从属关系已经隐藏了，在公有的接口中，存着被抽象父类生命的接口，NSNumber。可能没那么精确，但是这方便了aChar, anInt, aFloat, 和aDouble等对象成为NSNumber类等一个实例，因为他们通过NSNumber类方法初始化，并且通过NSNumber类声明的实例方法来存取。

## 类簇具有多个公开的父类
在上面的例子中，一个抽象的父类为很多私有的子类声明了很多公有的接口。这种属于类簇最纯粹的用法。很有可能（通常也是常有的情况），有两个（或者多个）抽象的公开类为类簇声明接口。这种情况在Foundation框架中很常见，列表1－1列出了包含类簇的清单：  

列表1-1 类簇和它们的公开超类  

| 类簇 | 公开超类 |
|:------------- |:---------------:|
| NSData | NSData/NSMutableData |
| NSArray | NSArray/NSMutableArray |
| NSDictionary | NSDictionary/NSMutableDictionary |
| NSString | NSString/NSMutableString |

其它类似这种情况的类簇也是存在的，但这清楚的阐述了两个抽象的节点如何以编程的形式在一个类簇中声明接口。在每个类簇中，一个公开的节点声明的方法，所有的类簇的对象都可以响应，另一个节点声明的方法智能被该类簇的对象访问和修改。  
类簇接口的分解性帮助面向对象的框架在编程上更为丰富。例如，想象一个对象表示一本书，声明了以下方法：  
> -(NSString *)title;

一个book对象可以反悔它本身的实例变量或者生成一个新的字符串对象然后返回它（这无所谓）。这清楚的表达了这个返回的字符串是无法被修改的。任何企图修改这个返回的对象都会引起编译器的报错。

## 在类簇中生成字类
类簇结构在简化和扩展性上做了取舍：拥有少量的公开类代替大量的私有的单个类，使得学习和使用一个框架中的类变得更容易，但是多少增加了在类簇中生成字类的难度。然而，如果很少生成字类的话，那么类簇的架构久很有用了。类簇在foundation框架中大量使用就是因为这种情况。  
如果你发现一个类簇没有提供你编程中要用到的函数，那么这时候一个字类可能就比较适合了。例如，假如你在NSArray类簇中希望生成一个数组对象来存储基于文件的内容而不是基于基于内存的内容。因为你需要修改底层类的存储机制，你最好生成一子类做这件事。  
另一方面，某些情况下可能对于类簇中的对象定义一个类更为合适（可能更方便）。假设你的程序需要在某些数据被修改的时候得到提示。在这种情况下，生成一个简单的类，该类包含foundation框架定义的包含数据的对象，这可能是比较好的方法。这个类的对象能够提示修改的数据，拦截消息，作用于消息，并且转发消息给内嵌的数据对象。  
总之，如果你需要管理你的对象的存储，生成一个子类。其他情况的话，生成一个复合对象，该对象包含一个标准的foundation框架的对象。后续章节会对这两种情况有更详细的介绍。

### 真正的子类

想要在一个类簇中新建一个类，你必须：  

* 生成一个类簇抽象父类的子类
* 声明它的存储
* 重载所有父类的初始化方法
* 重载父类的原始方法（详情如下）

第一，由于类簇的抽象基类是类簇这个层级唯一的公开节点。这意味着新的子类将会继承类簇的接口，但是不会继承实例变量，因为抽象基类是没有声明实例变量的。其次，子类必须声明任何它需要的实例变量。最后，子类必须重写它继承的方法来访问对象的实例变量。这些方法被称作原始方法。  
一个类的原始方法基于它的接口构建。例如，拿NSArray类举例，它声明了接口用来管理数组对象。在概念上来讲，一个数组可以存储一定数量的数据，每个元素都可以通过索引来访问。NSArray通过两个原始方法来表达它的抽象思维，count和objectAtIndex:。以这两个方法为基础，其他衍生的方法都能够被实现。列表1-2给出了两个衍生方法的例子。  

列表1-2 衍生方法以及他们可能的实现

| 衍生方法 | 可能的实现 |
|:------------- |:---------------:|
| lastObject | 通过调用[self objectAtIndex: ([self count] –1)]函数来查找最后一个元素 |
| containsObject: | 通过反复调用objectAtIndex:方法给每个数组的元素，每次增加索引，直到所有的数组中的元素都被遍历检测过 |

这种对于原始方法和衍生方法的分配，使得创建子类更为容易。你的子类必须重写继承的原始方法，使得所有继承的衍生方法都能够正常运作。  
原始-衍生之间的界限应用在了初始化对象的接口上。init...方法在子类当中需要被调用。  
通常来讲，一个类簇的抽象基类会定义一组init...和+className方法。就像“生成初始化”当中描述过的那样，抽象类决定了实体的子类实例化基于你选择的init...或者+ className方法。你可以认为抽象类声明了这些方法为了方便子类使用。抽象类没有实例变量，那么也就无需存在实例化方法了。  
你的子类应该定义它自己的init...方法（如果有必要的话，初始化它点实例变量）以及可能的类方法。它不应该依赖任何它继承的方法。为了维持继承响应链，它应该在它自己的初始化方法中调用它父类的初始化方法。它还应该重载所有它继承的初始化方法，并且以合理的方式实现他们。（参见“多种构造方法和初始化方法”关于初始化方法的讨论）在类簇中，抽象基类的初始化方法永远是init。
### 真正的子类：举个例子
假设你要创建一个NSArray的子类，名叫MonthArray，它会返回给定索引的月份的名称。不过，一个MonthArray类的对象不会实际存储月份数组的名称来作为实例变量。而是返回一个给定索引的名字的方法(objectAtIndex:)会返回一个字符串常量。此外，只有十二个字符串对象将会被分配内存，不论多少MonthArray对象会存在在应用程序中。  

MonthArray 类声明如下：  

```
#import <foundation/foundation.h>
@interface MonthArray : NSArray
{
}
 
+ monthArray;
- (unsigned)count;
- (id)objectAtIndex:(unsigned)index;
@end

```

注意MonthArray类没有声明init...方法，因为它没有实例变量要初始化。count和objectAtIndex:方法只是直接覆盖继承的原始方法，如上述所示。  
而MonthArray类的实现类似这样：  

```
#import "MonthArray.h"
 
@implementation MonthArray
 
static MonthArray *sharedMonthArray = nil;
static NSString *months[] = { @"January", @"February", @"March",
    @"April", @"May", @"June", @"July", @"August", @"September",
    @"October", @"November", @"December" };
 
+ monthArray
{
    if (!sharedMonthArray) {
        sharedMonthArray = [[MonthArray alloc] init];
    }
    return sharedMonthArray;
}
 
- (unsigned)count
{
 return 12;
}
 
- objectAtIndex:(unsigned)index
{
    if (index >= [self count])
        [NSException raise:NSRangeException format:@"***%s: index
            (%d) beyond bounds (%d)", sel_getName(_cmd), index,
            [self count] - 1];
    else
        return months[index];
}
 
@end
```

由于MonthArray覆盖了继承的原始方法，因此它继承的衍生方法将正常工作，而不会被覆盖。NSArray的 lastObject, containsObject:, sortedArrayUsingSelector:, objectEnumerator,以及其他方法对于MonthArray对象而言不会发生问题。  
### 复合对象
通过在你自己设计的类中添加一个私有的类簇对象，你就创建了一个复合对象。符合对象可以靠类簇对象实现其基本功能，只需在复合对象处理某些特定消息时才需要拦截消息。这种结构减少了你需要编写的代码量，并让你可以利用 Foundation 框架提供的测试代码。图1-4描述了这种结构。  

图 1-4 内置类簇对象的对象  

![](https://developer.apple.com/library/archive/documentation/General/Conceptual/CocoaEncyclopedia/Art/compositeobject.gif)  

符合对象必须声明其本身为一个类簇抽象父类的子类。作为一个子类，它必须重载父类原来的方法。它还可以重载派生的方法，但这并非必须的，因为派生的方法会通过原来的方法。  
NSArray 类的 count 方法就是个例子；在对象的实现方法中它可以被重载成这样：

```
- (unsigned)count {
    return [embeddedObject count];
}
```
不过，你的对象应该将它重载的方法的实现放在其自己的实现体中。

### 复合对象：举个例子
为展示符合对象的使用，假设你需要一个可变数组来测试某些验证条件来保证对于数组内容的修改。以下描述的示例类称作ValidatingArray，它包含一个标准的可变数组对象。ValidatingArray 重写了所有的父类声明的方法， 即NSArray 和 NSMutableArray。它还声明了array, validatingArray, 和 init方法，可以用来创建和初始化一个实例：  

```
#import <foundation/foundation.h>
 
@interface ValidatingArray : NSMutableArray
{
    NSMutableArray *embeddedArray;
}
 
+ validatingArray;
- init;
- (unsigned)count;
- objectAtIndex:(unsigned)index;
- (void)addObject:object;
- (void)replaceObjectAtIndex:(unsigned)index withObject:object;
- (void)removeLastObject;
- (void)insertObject:object atIndex:(unsigned)index;
- (void)removeObjectAtIndex:(unsigned)index;
 
@end
```
实现文件展示了在 ValidatingArrayclass 类的 init 方法中，内置的对象以及被创建并赋值给了embeddedArray变量。消息直接传递给数组，但并没有改变其内容而是转发给了内置的对象。能够改变内容的消息是被检查过的（以下是伪代码）并且只有在其通过了设定的验证测试之后才会被转发。  

```
#import "ValidatingArray.h"
 
@implementation ValidatingArray
 
- init
{
    self = [super init];
    if (self) {
        embeddedArray = [[NSMutableArray allocWithZone:[self zone]] init];
    }
    return self;
}
 
+ validatingArray
{
    return [[[self alloc] init] autorelease];
}
 
- (unsigned)count
{
    return [embeddedArray count];
}
 
- objectAtIndex:(unsigned)index
{
    return [embeddedArray objectAtIndex:index];
}
 
- (void)addObject:object
{
    if (/* modification is valid */) {
        [embeddedArray addObject:object];
    }
}
 
- (void)replaceObjectAtIndex:(unsigned)index withObject:object;
{
    if (/* modification is valid */) {
        [embeddedArray replaceObjectAtIndex:index withObject:object];
    }
}
 
- (void)removeLastObject;
{
    if (/* modification is valid */) {
        [embeddedArray removeLastObject];
    }
}
- (void)insertObject:object atIndex:(unsigned)index;
{
    if (/* modification is valid */) {
        [embeddedArray insertObject:object atIndex:index];
    }
}
- (void)removeObjectAtIndex:(unsigned)index;
{
    if (/* modification is valid */) {
        [embeddedArray removeObjectAtIndex:index];
    }
}
```

# 类工厂方法
类工厂方法是由类实现的一种给用户方便调用的方法。它将分配空间和初始化一步完成并返回创建好的对象。不过，用户并不拥有接收到的对象（基于每个对象的协议），并且不用负责释放它。这些方法都是这种形式：+(type)className...（className可包含任意前缀）。  
Cocoa提供了大量的示例，尤其是“值”相关的类。NSDate 类包含以下类工厂方法：  

> +(id)dateWithTimeIntervalSinceNow:(NSTimeInterval)secs;  
+(id)dateWithTimeIntervalSinceReferenceDate:(NSTimeInterval)secs;  
+(id)dateWithTimeIntervalSince1970:(NSTimeInterval)secs;

NSData 也提供了以下工厂方法：  

> +(id)dataWithBytes:(const void *)bytes length:(unsigned)length;  
+(id)dataWithBytesNoCopy:(void *)bytes length:(unsigned)length;  
+(id)dataWithBytesNoCopy:(void *)bytes length:(unsigned)length  
        freeWhenDone:(BOOL)b;  
+(id)dataWithContentsOfFile:(NSString *)path;  
+(id)dataWithContentsOfURL:(NSURL *)url;  
+(id)dataWithContentsOfMappedFile:(NSString *)path;

工厂方法不仅仅是带来了便利。他们不只是将分配空间和初始化合并了，并且分配空间还会通知初始化。举例来说，假设你必须初始化一组从属性列表文件中读取的对象，该文件对于集合的任意数量的元素（NSString对象、NSData对象、NSNumber对象等等）进行编码。在工厂方法指导要为该集合分配多少内存之前，必须读取该文件并缝隙属性列表，以确定有多少元素以及这些元素的对象类型。  
另一个工厂方法的目的是确保一个确定的类（比如NSWorkspace）能够提供一个单例实例。虽然 init... 方法能够确保在程序中的任意时刻只有一个实例对象存在，但还是需要优先级来分配原始的实例变量，然后在内存管理代码中需要释放该实例变量。换句话说，一个工厂方法，可以给你一种方式来避免盲目的分配内存给一个你可能用不到的对象，如以下示例所示：  

> static AccountManager *DefaultManager = nil;  
	+(AccountManager *)defaultManager {  
   		 if (!DefaultManager) DefaultManager = [[self allocWithZone:NULL] init];  
	    return DefaultManager;  
}

# 代理和数据源
代理是一种在某个对象在程序中遇到事件时，代表该对象或与其他对象进行协作的一种对象。代理对象通常是一个响应对象——意思是，该对象继承自AppKit中的NSResponder或者UIKit中的UIResponder——能够响应用户事件。代理就是一种代理控制用户界面来处理事件的对象，或者至少被要求以特定于应用程序的方式解释该事件。  
为更好的理解代理的价值，我们看下现成的Cocoa对象，比如一个输入框（NSTextField 或者 UITextField 的实例）或者一个列表（NSTableView 或者 UITableView的实例）。这些对象旨在以通用方式完成特定的角色功能；举例来说，AppKit 框架中的 window 对象会响应鼠标操作控制，处理诸如关闭，调整大小，移动物理窗口等事件。这种受限和泛型行为必然限制了对象对于事件是如何影响（或者将要影响）应用程序其他位置的内容的，尤其是当受影响的行为特定于你的应用程序时。代理为自定义对象提供了一种将应用程序特定行为传达到现成对象的方法。  
代理的编程机制是基于对象一个根据改变发生时协调它们本身的展现和状态机会，改变一般是伴随着用户行为发生的。更重要的是，代理能够让一个对象改变另一个对象的行为而无需继承自该对象。并且根据定义，它集成了泛型和代理对象不可能知道本身的应用程序特定逻辑。

## 代理是如何工作的

代理机制的设计是很简单的——参见 图 3-1。代理类有一个接口或属性，通常叫做 delegate；如果它是个接口，它包含方法来进行设定以及访问接口的值。它还会声明，但不会实现，一个或更多的方法来构成一个正式协议或非正式协议。正式协议使用可选方法——一种OC2.0的功能——一种首选方式，不过两种类型的协议都在Cocoa框架中的代理方式里有使用。  
在非正式协议中，代理类在NSObject类的分类上声明方法，代理仅实现那些它有兴趣与代理对象协调自身或影响该对象的默认值的方法和行为。如果代理类声明了一个正式协议，代理可能会选择实现标记为可选的方法，但必须实现标记为必须的方法。  
代理机制遵循常见的设计，参见图 3-1。

图3-1 代理的机制

![](https://developer.apple.com/library/archive/documentation/General/Conceptual/CocoaEncyclopedia/Art/delegation1.jpg)

协议的方法标志着事件的处理或者代理对象的预期。该对象期望与事件和事件代理之间进行沟通，或者对于即将发生的事件，请求输入或者从代理获取许可。举例来说，当一个用户点击OSX窗口的关闭按钮时，窗口对象会发送 windowShouldClose: 消息给其代理；这会给代理对于关闭或推迟关闭窗口以时机，比如，窗口会有数据必须保存（参见图3-2）。

图3-2 调用代理的一个真实序列

![](https://developer.apple.com/library/archive/documentation/General/Conceptual/CocoaEncyclopedia/Art/delegation2.jpg)

只有当代理实现了方法时，代理对象才会发送消息。最好在代理中先调用NSObject 的 respondsToSelector: 方法来进行判断。

## 代理消息的格式

代理方法有常规的格式。它们以执行代理的AppKit或UIKit对象的名称开头，这些对象执行代理——应用程序，窗口，控件等；此名称为小写，没有“NS”或者“UI”前缀。通常（但不总是）该对象的名称跟随辅助动词指示报告事件的时间状态。这个动词，换句话说，表示该事件将要发生（“Should” 或 “Will”）或者表示它是否刚发生（“Did” 或 “Has”）。这种时态区分有助于对预期返回值的和不需要返回值的进行分类。清单 3-1包含一些需要返回值的AppKit的代理方法。

清单 3-1 带有返回值的代理方法的示例

```
- (BOOL)application:(NSApplication *)sender
    openFile:(NSString *)filename;                        // NSApplication
- (BOOL)application:(UIApplication *)application
    handleOpenURL:(NSURL *)url;                           // UIApplicationDelegate
- (UITableRowIndexSet *)tableView:(NSTableView *)tableView
    willSelectRows:(UITableRowIndexSet *)selection;       // UITableViewDelegate
- (NSRect)windowWillUseStandardFrame:(NSWindow *)window
    defaultFrame:(NSRect)newFrame;                        // NSWindow
```

清单3-2 返回 void 的代理方法示例

```
- (void) tableView:(NSTableView*)tableView
    mouseDownInHeaderOfTableColumn:(NSTableColumn *)tableColumn;      // NSTableView
- (void)windowDidMove:(NSNotification *)notification;                 // NSWindow
- (void)application:(UIApplication *)application
    willChangeStatusBarFrame:(CGRect)newStatusBarFrame;               // UIApplication
- (void)applicationWillBecomeActive:(NSNotification *)notification;   // NSApplication
```

## 代理和应用的工具库

Cocoa 或 Cocoa Touch 应用程序的代理对象通常是一个响应者对象，比如 UIApplication， NSWindow，或者 NSTableView 对象。代理对象本身通常来讲（但并非必须）是一个自定义对象，它控制某些应用程序的部分（与控制器对象合作）。以下AppKit类定义了代理：

* NSApplication
* NSBrowser
* NSControl
* NSDrawer
* NSFontManager
* NSFontPanel
* NSMatrix
* NSOutlineView
* NSSplitView
* NSTableView
* NSTabView
* NSText
* NSTextField
* NSTextView
* NSWindow

### 成为工具类库的代理

一个框架的类或者任何其他实现声明了delegate和协议（通常是正式协议）的类。协议列出了需要代理实现的必须和可选的方法。

	@interface MyControllerClass : UIViewController <UIAlertViewDelegate> {

### 通过代理属性定位对象

	id winController = [[NSApp keyWindow] delegate];
	
	id appController = [NSApp delegate];

## 数据源
数据源很像代理，只是代理控制的是用户界面，而数据源控制的是数据。数据源是被NSView 和 UIView持有的一个接口对象，类似tableview这种表格视图需要一个数据源来构成其展示的数据。一个视图的数据源通常也扮演着它的代理的角色，不过它可以是任意对象。同代理一样，数据源必须实现非正式协议的一个或多个方法来支持视图所需的数据，并且需要做额外的实现来处理用户直接在某个视图中进行编辑的数据。
## 为一个自定义类实现代理

要为你的自定义类实现代理的话，要完成以下几个步骤：

* 在你的类的头文件中声明代理的存取方法。

```
- (id)delegate;
- (void)setDelegate:(id)newDelegate;
```

* 实现存取方法。在内存管理程序中，要避免循环引用，setter 方法不应该使用 retain 或者 copy 对你的 delegate 进行操作。

在垃圾回收环境中，循环引用并不是一个问题，你不应该使用__weak类型修饰符来修饰一个弱引用。更多关于循环引用，参见“高级内存管理编程指南”。更多关于弱引用在垃圾回收中的信息，参见“垃圾回收编程指南”一文中的“Cocoa垃圾回收概要”一章。  

```
- (id)delegate {
    return delegate;
}
 
- (void)setDelegate:(id)newDelegate {
    delegate = newDelegate;
}
```

* 实现存取方法。在内存管理的程序中，为了避免引用循环，setter 方法不应该持有或拷贝你的代理。

在垃圾回收环境下，循环引用将不会是个问题，你不应该让代理以弱引用（通过使用__weak类型修饰符）。更多关于循环引用相关信息，参见“高级内存管理编程指南”。更多关于在垃圾回收机制中的弱引用，参见“垃圾回收编程指南”中的“Cocoa垃圾收集概要”一节。  

* 声明一个正式或非正式协议包含正式接口。非正式协议是 NSObject 类的分类。如果你声明一个正式协议，要确保你用@optional 指令标记可选方法分组。  
  "代理消息的格式"对于命名你自己的代理方法给出了建议。
* 在调用一个代理方法之前，要确保代理实现了方法可以通过给其发送 respondsToSelector: 消息。

```
- (void)someMethod {
    if ( [delegate respondsToSelector:@selector(operationShouldProceed)] ) {
        if ( [delegate operationShouldProceed] ) {
            // do something appropriate
        }
    }
}
```

只有在正式协议或非正式协议方法中的可选方法中，才需要这种预防措施。

# 内省
内省是面向对象语言和环境中的很强大的功能，在OC和Cocoa中也不例外。内省是指对象在运行时将自身详细信息作为对象而向外暴露的能力。此类详细信息包括对象在继承树中的位置，是否遵循了一个特定的协议，以及是否响应一个特定的消息等等。NSObject 协议和类定义了很多的内省方法，你可以使用它来查询运行时对象的表现。  
如果正确使用的话，内省会让面向对象程序更加高效和健壮。还能够帮助你避免消息分发的错误，假设对象相等的错误判断，以及类似问题。以下段落展示了你在编码中如何高效的使用 NSObject 内省方法。  

## 判断继承关系

一旦你知道了一个对象的所属类，你对于该对象就能了解个大概了。你可能就知道了它能够做什么，它表示了什么属性，以及它能够接收什么样的消息。即使在经过内省之后，你对于一个对象所属的类依旧不熟悉，你也会知道不能够给它发某种消息了。  
NSObject 协议声明了几个方法来判断一个对象在类的层级结构中的位置。这些方法是以不同粒度来操作的。举例来说，class 和 superclass 实例方法会返回 Class 对象，分别表示类和父类。这些方法需要你比较两个 Class 对象。清单4-1展示了一个使用例子。

清单4-1 使用 class 和 superclass 方法

```
// ...
while ( id anObject = [objectEnumerator nextObject] ) {
    if ( [self class] == [anObject superclass] ) {
        // do something appropriate...
    }
}
```

> 注意：有时候你要使用 class 或 superclass 方法来为一个类消息获得一个适当的接收者。

更为常见的检测一个对象的类的从属关系，是使用发送 isKindOfClass: 或 isMemberOfClass: 消息。该方法会返回接收者是否是一个给定类的实例或者是否是继承自该类的任意类的实例。换句话说，isMemberOfClass:会告诉你接收者是否是一个指定类的实例。isKindOfClass:通常比较常用，因为从它你可以立刻知道你能够发送给对象的完整消息域。参考清单4-2的代码块。

```
if ([item isKindOfClass:[NSData class]]) {
    const unsigned char *bytes = [item bytes];
    unsigned int length = [item length];
    // ...
}
```

知晓了 item 继承自 NSData 类，代码就知道它能够发送NSData 的 bytes 和 length 消息了。如果假定item是一个 NSMutableData 的实例对象，则 isKindOfClass: 和 isMemberOfClass: 的区别就显而易见了。如果你使用 isMemberOfClass: 而非 isKindOfClass:，则条件语句块中的代码将永远不会执行，因为 item 并不是 NSData 的实例对象而是 NSMutableData的，是 NSData的一个子类。

## 方法实现和协议性能

还有两个 NSObject 的强大功能的内省方法是 respondsToSelector: 和 conformsToProtocol:。这两个方法会分别告诉你一个对象是否实现了一个指定的方法以及一个对象是否遵循了一个指定的协议（意思是是否采纳了协议，并且是否按需要实现了所有的协议方法）。  
在你的代码中可以经常见到这些方法。它能够让你在发送消息之前发掘某些潜在的匿名的对象是否能够适当的响应一个特定消息或者一系列消息。通过在发送消息之前进行检测，你就能够避免运行时收到不识别的选择器的异常结果。AppKit 框架实现了非正式协议——基于代理——通过检测代理是否实现了一个代理方法（使用 respondsToSelector:）来优先调用该方法。  

清单4-3 展示了如何在你的代码中使用 respondsToSelector: 方法。

清单4-3 使用 respondsToSelector:

```
- (void)doCommandBySelector:(SEL)aSelector {
    if ([self respondsToSelector:aSelector]) {
        [self performSelector:aSelector withObject:nil];
    } else {
        [_client doCommandBySelector:aSelector];
    }
}
```
清单4-4展示了你如何在代码中使用 conformsToProtocol: 方法。

清单4-4 使用conformsToProtocol:

```
// ...
if (!([((id)testObject) conformsToProtocol:@protocol(NSMenuItem)])) {
    NSLog(@"Custom MenuItem, '%@', not loaded; it must conform to the
        'NSMenuItem' protocol.\n", [testObject class]);
    [testObject release];
    testObject = nil;
}
```

## 对象的比较

尽管不是严格的自省方法，但是 hash 和 isEqual: 方法具有类似的作用。对于判定相等和比较对象等功能来说是不可缺少的运行时工具。但是，它们依赖于特定于类的比较逻辑，而非查询运行时有关对象的信息。  
hash 和 isEqual: 方法都声明在 NSObject 协议中，并且紧密相关。hash 必须被实现，并且要返回一个整型值，该整型值将会被用在一个哈希表结构体中作为地址。如果两个对象是相等的（被 isEqual: 方法判断），它们必须具有相同的哈希值。如果你的对象能够被包含进类似 NSSet 这样的集合类对象中，你需要定义 hash 并验证两个对象的常量是否相等，它们会返回相同的哈希值。NSObject 默认实现的 isEqual: 方法会直接检查指针是否相等。  
使用 isEqual: 方法是很直接的；它将接收者与作为参数提供的对象进行比较。对象的比较经常通知运行时决定如何处理对象。如清单4-5所示，你可以使用 isEqual: 方法决定是否执行操作，在这种情况下，可以保存已修改的用户首选项。  

清单4-5 使用isEqual:

```
- (void)saveDefaults {
    NSDictionary *prefs = [self preferences];
    if (![origValues isEqual:prefs])
        [Preferences savePreferencesToDefaults:prefs];
}
```

如果你创建了一个子类，你可能需要重写 isEqual: 方法，为指针是否相等添加更多的检查。子类可能定义了一个额外的属性，该属性在两个实例中必须具有相同的值才能将它们视为相等。比如，假设你创建了一个叫做 MyWidget 的 NSObject 的子类包含两个实例变量，name和data。这两个值必须同时相等才可以视为相等。清单4-6展示了你该如何为 MyWidget 类实现 isEqual: 方法。

清单4-6 重写isEqual:

```
- (BOOL)isEqual:(id)other {
    if (other == self)
        return YES;
    if (!other || ![other isKindOfClass:[self class]])
        return NO;
    return [self isEqualToWidget:other];
}
 
- (BOOL)isEqualToWidget:(MyWidget *)aWidget {
    if (self == aWidget)
        return YES;
    if (![(id)[self name] isEqual:[aWidget name]])
        return NO;
    if (![[self data] isEqualToData:[aWidget data]])
        return NO;
    return YES;
}
```

这个 isEqual: 方法首先检查了指针是否相等，然后检查了类是否相等，最后调用了一个对象比较。其名称表示了要比较涉及的对象类。这种类型的比较方法强制检查传入的对象的类型，是Cocoa种常见的约定；NSString 类的 isEqualToString: 方法以及 NSTimeZone 类的 isEqualToTimeZone: 方法只是两个示例。特定于此类的比较器是——isEqualToWidget:——执行检测name和data是否相等。  
在所有Cocoa框架中的 isEqualToType: 这种类型的方法，nil 不是一个合法的参数，并且实现这些方法时，在接收到nil后可能抛出异常。不过对于向后兼容性来说，isEqual: 方法会接收nil，并且返回NO。

# 对象的分配

# 对象的初始化

## 初始化的格式

	- (id)initWithArray:(NSArray *)array; (from NSSet)
	- (id)initWithTimeInterval:(NSTimeInterval)secsToBeAdded sinceDate:(NSDate *)anotherDate; (from NSDate)
	- (id)initWithContentRect:(NSRect)contentRect styleMask:(unsigned int)aStyle backing:(NSBackingStoreType)bufferingType defer:(BOOL)flag; (from NSWindow)
	- (id)initWithFrame:(NSRect)frameRect; (from NSControl and NSView)

	id anObject = [[MyClass alloc] init];
	if (anObject) {
   	 [anObject doSomething];
   	 // more messages...
	} else {
   	 // handle error
	}
	
	id myObject = [MyClass alloc];
	[myObject init];
	[myObject doSomething];
	
	id myObject = [[MyClass alloc] init];
	if ( myObject ) {
   	 [myObject doSomething];
	} else {
   	 // error recovery...
	}

## 初始化的问题

## 实现一个初始化

## 可变的初始化和指定初始化

# 模型-视图-控制器
模型-视图-控制器设计模式已经很古老了。至少在Smalltalk的早期它的变种就存在了。它是一种高级设计模式，因为它与应用程序的整体架构有关，并且会根据对象在应用程序中所扮演的角色对对象进行分类。它还是一个复合模式，因为它包含几个元素模式。  
面向对象的程序通过调整其设计的MVC设计模式，从多种方式受益。这些程序中的许多对象往往更可重用，并且它们的接口往往定义的更好。总体而言，这些程序更适应不断变化的需求——换句话说——它们比没有基于MVC的程序更容易扩展。此外，很多Cocoa中的技术和架构——比如绑定，文档体系结构和脚本性——都是基于MVC并且需要你的自定义对象扮演MVC中所定义的一个角色。

## MVC对象的角色和关系
MVC设计模式考虑到有三种类型的对象：模型，视图和控制器对象。MVC设计模式定义了三种对象在应用程序中所扮演的角色以及它们之间的联系。当设计一个应用程序时，一个主要的步骤就是选择（或创建一个自定义类）一个对象放入这三组之一当中。每个类型的对象都通过抽象边界和其他的部分分开了，并与跨越这些边界的其他类型的对象进行通信。

### 模型对象封装数据和基本行为
模型对象展现特定的信息。它们持有一个应用程序的数据并定义操纵该数据的行为。一个设计良好的MVC应用程序会将其所有的重要数据封装到模型对象中。一旦将数据加载到应用程序中，作为应用程序持久状态的一部分（无论该持久状态是否存储在文件或数据库中）的任何数据都应该驻留在模型对象中。由于模型对象代表着特定领域问题的信息，所以它们会更易于被重用。  
比较理想的情况是，一个模型对象对于呈现和展现它的用户界面没有显式的连接。举例来说，如果你有个模型对象用来表示一个人（假设你正在编写一个地址簿）你可能想要存储一个生日信息。那么存储在你的 Person 模型对象中就比较好。不过，存储一个日期格式的字符串或者其他有关如何显式该日期的信息可能在其他地方更好。  
在实际情况中，这种分割并非最优，还是有一些灵活的空间在的，但是通常来讲，一个模型对象不应该关心界面和展现问题。一个有一点例外的例子是绘制类的应用程序的模型对象会代表图形的展现。图形对象知晓如何绘制它们本身是很正常的，因为它们存在的主要目的就是定义一个可视化的事物。但即使在这个例子中，视图对象都不应该依赖于存在的一个特定视图或所有视图，并且它们也不应该负责知晓何时该绘制它们本身。它们应该通过视图对象来查询如何改展现它们并绘制本身。  
  
### 视图对象展现信息给用户
视图对象知道如何展现，且允许用户编辑从应用程序模型层拿到的数据。视图对象不应该负责存储它所展现的数据。（当然，这并不意味着视图永远不会存储它所展现的数据。视图可以缓存数据或者出于性能的原因执行类似的技巧。）视图对象视图可以负责一部分的模型对象，或者整个模型对象，或者多种不同的模型对象。视图有许多不同的种类。
### 控制器对象连接模型和视图

### 组合角色

## Cocoa控制器对象的类型

## MVC作为一个复合设计模式

图 7-1 传统版本的MVC作为复合设计模式  

![](https://developer.apple.com/library/archive/documentation/General/Conceptual/CocoaEncyclopedia/Art/traditional_mvc.gif)

图 7-2 Cocoa版本的MVC作为复合设计模式  

![](https://developer.apple.com/library/archive/documentation/General/Conceptual/CocoaEncyclopedia/Art/cocoa_mvc.gif)

图 7-3 协调作为一个nib文件的拥有者控制器

![](https://developer.apple.com/library/archive/documentation/General/Conceptual/CocoaEncyclopedia/Art/cocoa_mvc_coord.gif)

## MVC应用的设计指南

## Cocoa（osx）中的模型-视图-控制器

# 对象的模型化

## 实体

## 属性

## 关系

## 访问属性

### 键

### 值

### key路径

# 对象的可变
Cocoa对象都是有可变或不可变的。你不能够更改封装的不可变对象的值；一旦一个对象创建了，它所代表的值就会伴随对象的生命周期而存在。但是你可以在任意时刻改变一个可变对象所封装的值。以下章节阐述了一个对象类型有可变和不可变两种变体的原因，描述了相关特性以及对象可变的边际效应，并对于当对象可变时产生的问题如何处理给出了建议。  
## 为什么有可变和不可变对象的两种变体？
对象默认是可变的。大部分的对象都允许你通过setter方法来访问改变其封装的数据。举例来说，你可以改变一个 NSWindow 对象的大小、位置、标题、缓冲行为以及其他的特性。一个设计良好的模型对象——一个对象就表示一个消费记录——需要setter方法来改变其实例数据。  
Foundation框架通过引入一些有可变和不可变变体的类添加了一些细微差别。可变的子类通常是其不可变父类的子类，并且类名拥有“Mutable”。这些类包括以下：  

NSMutableArray
NSMutableDictionary
NSMutableSet
NSMutableIndexSet
NSMutableCharacterSet
NSMutableData
NSMutableString
NSMutableAttributedString
NSMutableURLRequest

```
注意：除了AppKit框架中的NSMutableParagraphStyle，Foundation框架当前已经定义了所有明确命名的可变类。不过，任何Cocoa框架都可能拥有其自己的可变和不可变的变体类。
```

## 使用可变对象编程

### 创建和转换可变对象

### 存储和返回可变实例变量

### 接收可变对象

#### 使用返回类型，而非内省

#### 对于接收的对象使用快照

### 集合中的可变对象
在集合对象中存储可变对象会引起问题。如果包含的对象发生突变，某些集合可能会变得无效甚至损坏，因为通过突变，这些对象可能会影响他们在集合中的放置方式。首先，如果更改的属性影响对象的哈希值或者 isEqual: 方法的结果，则哈希集合中键的对象（比如字典对象或集合对象）
# Outlets

# 接收器模式
接收器设计模式是用来解决应用程序执行上下文中发生的事件重定向到另一个执行上下文以进行处理的一般问题。这是一个混合模式。虽然它没有出现在GOF中，但它结合了该书中描述的命令、备忘录和代理设计模式的元素。这也是电车模式的变体（该书也未出现）；在此模式中，事件最初由蹦床对象接收，即所谓的事件，因为它会立即将事件退回或重定向到目标对象进行处理。
## 实践中的接收器模式

KVO通知调用了 observeValueForKeyPath:ofObject:change:context: 方法，它是被一个监听器实现的。

图 11-1 

![](https://developer.apple.com/library/archive/documentation/General/Conceptual/CocoaEncyclopedia/Art/receptionist.jpg)

清单 11-1 

	@interface RCReceptionist : NSObject {
	    id observedObject;
	    NSString *observedKeyPath;
	    RCTaskBlock task;
	    NSOperationQueue *queue;
	}


	typedef void (^RCTaskBlock)(NSString *keyPath, id object, NSDictionary *change);


	+ (id)receptionistForKeyPath:(NSString *)path
        object:(id)obj
         queue:(NSOperationQueue *)queue
          task:(RCTaskBlock)task;

清单 11-2  

	+ (id)receptionistForKeyPath:(NSString *)path object:(id)obj queue:(NSOperationQueue *)queue task:(RCTaskBlock)task {
	    RCReceptionist *receptionist = [RCReceptionist new];
	    receptionist->task = [task copy];
	    receptionist->observedKeyPath = [path copy];
	    receptionist->observedObject = [obj retain];
	    receptionist->queue = [queue retain];
	    [obj addObserver:receptionist forKeyPath:path
	             options:NSKeyValueObservingOptionNew | NSKeyValueObservingOptionOld context:0];
	    return [receptionist autorelease];
	}

清单 11-3  

	- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object
        change:(NSDictionary *)change context:(void *)context {
	    [queue addOperationWithBlock:^{
	        task(keyPath, object, change);
	    }];
	}

清单 11-4  

	RCReceptionist *receptionist = [RCReceptionist receptionistForKeyPath:@"value" object:model queue:mainQueue task:^(NSString *keyPath, id object, NSDictionary *change) {
            NSView *viewForModel = [modelToViewMap objectForKey:model];
            NSColor *newColor = [change objectForKey:NSKeyValueChangeNewKey];
            [[[viewForModel subviews] objectAtIndex:0] setFillColor:newColor];
        }];


## 何时该使用接收器模式

当你需要将任务退回到另一个执行上下文进行处理时，你可以采用接收器设计模式。

# 目标-动作

## 目标

## 动作

## AppKit框架中的目标-动作

### 控件、单元格和菜单项

### 设置目标和动作

### AppKit定义的动作

## UIKit中的目标-动作

# 无成本桥接

有大量的Core Foundation 和 Foundation 框架的数据类型都是可以用来交换使用的。

列表13-1 数据类型能够在 Core Foundation 和 Foundation 框架之间交换使用

```
NSLocale *gbNSLocale = [[NSLocale alloc] initWithLocaleIdentifier:@"en_GB"];
CFLocaleRef gbCFLocale = (CFLocaleRef) gbNSLocale;
CFStringRef cfIdentifier = CFLocaleGetIdentifier (gbCFLocale);
NSLog(@"cfIdentifier: %@", (NSString *)cfIdentifier);
// logs: "cfIdentifier: en_GB"
CFRelease((CFLocaleRef) gbNSLocale);
 
CFLocaleRef myCFLocale = CFLocaleCopyCurrent();
NSLocale * myNSLocale = (NSLocale *) myCFLocale;
[myNSLocale autorelease];
NSString *nsIdentifier = [myNSLocale localeIdentifier];
CFShow((CFStringRef) [@"nsIdentifier: " stringByAppendingString:nsIdentifier]);
// logs identifier for current locale
```

列表 13-1 能够在 Core Foundation 和 Foundation 框架之间用来转换的数据类型

| Core Foundation 类型 | Foundation类 | 可用 |
|:------------- |:---------------:|:---------------:|
| CFArrayRef | NSArray | OS X 10.0 |
| CFAttributedStringRef | 	NSAttributedString | OS X 10.4 |
| CFBooleanRef | 	NSNumber | OS X 10.0 |
| CFCalendarRef | 	NSCalendar | OS X 10.4 |
| CFCharacterSetRef | 	NSCharacterSet | OS X 10.0 |
| CFDataRef | 	NSData | OS X 10.0 |
| CFDateRef | 	NSDate | OS X 10.0 |
| CFDictionaryRef | 	NSDictionary | OS X 10.0 |
| CFErrorRef | 	NSError | OS X 10.5 |
| CFLocaleRef | 	NSLocale | OS X 10.4 |
| CFMutableArrayRef | 	NSMutableArray | OS X 10.0 |
| CFMutableAttributedStringRef | 	NSMutableAttributedString | OS X 10.4 |
| CFMutableCharacterSetRef | 	NSMutableCharacterSet | OS X 10.0 |
| CFMutableDataRef | 	NSMutableData | OS X 10.0 |
| CFMutableDictionaryRef | 	NSMutableDictionary | OS X 10.0 |
| CFMutableSetRef | 	NSMutableSet | OS X 10.0 |
| CFMutableStringRef | 	NSMutableString | OS X 10.0 |
| CFNullRef | 	NSNull | OS X 10.2 |
| CFNumberRef | 	NSNumber | OS X 10.0 |
| CFReadStreamRef | 	NSInputStream | OS X 10.0 |
| CFRunLoopTimerRef | 	NSTimer | OS X 10.0 |
| CFSetRef | 	NSSet | OS X 10.0 |
| CFStringRef | 	NSString | OS X 10.0 |
| CFTimeZoneRef | 	NSTimeZone | OS X 10.0 |
| CFURLRef | 	NSURL | OS X 10.0 |
| CFWriteStreamRef | 	NSOutputStream | OS X 10.0 |

```
注意：并非所有的数据类型都是能够无成本桥接的，即使是它的名字可能建议它这么做。举例来说，NSRunLoop 就和 CFRunLoopRef 并非无成本桥接，NSBundle 和 CFBundleRef 之间也是，NSDateFormatter 和 CFDateFormatterRef 之间也是。
```