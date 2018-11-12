[A Short Practical Guide to Blocks 原文链接](https://developer.apple.com/library/content/featuredarticles/Short_Practical_Guide_Blocks/index.html#//apple_ref/doc/uid/TP40009758)

# Blocks精简实用指南

Blocks是一种强大的C语言级别的功能，它是Cocoa应用程序开发的一部分。它类似于“closures”和“lambdas”，你在其他的脚本语言或编程语言中（比如Ruby，Python和Lisp）可能找到类似的功能。尽管blocks语法和存储的细节乍一看比较模糊，但你会发现它实际上很容易融入你的工程代码。  
以下章节从一个顶部的视角讨论了blocks的一些功能，并展示了它们使用的一些典型方式。若要查看详细的blocks的描述，请参考“Blocks编程主题”。  

## 内容：
* 为什么使用Blocks？
* 系统框架APIs中的Blocks
* Blocks和并发

## 为什么使用Blocks？
Blocks是一种封装了一组任务的对象——或者用不那么抽象的术语来说，就是一段代码——这些代码可以在任何时候执行。它们本质上是轻量的匿名函数，它可以被当做函数的参数进行传递，也可以从其他函数和方法中返回。Blocks本身有一组类型参数列表，也可以声明返回类型。你也可以将一个block赋值给一个变量，然后你可以将其当做一个函数进行调用。  
脱字符(^)被用来作为blocks的句法标记。举例来说，以下代码声明了一个带有两个整形变量和返回一个整型值的block。它将参数列表放到第二个脱字符后，并将实现体放到大括号中，最后将其赋值给Multiply变量：  

	int (^Multiply)(int, int) = ^(int num1, int num2) {
	    return num1 * num2;
	};
	int result = Multiply(7, 4); // Result is 28.

作为方法或函数的参数，blocks可以作为一种类型的回调并可以被作为一种限于方法或函数的代理。通过在block中传递，调用的代码能够定制化方法或函数的行为。当被调用时，方法或函数会执行一些工作，并在适当的时机回调调用的代码——通过block——从它当中请求额外的信息或获得应用程序特定的行为。  
blocks作为函数和方法的参数的一个优势是它们能够在调用的时间点提供给调用者以回调。由于这部分代码无需再分离的函数或方法中实现，你的实现体将会很简单并易于被理解。以NSNotification的通知为例。在“传统”方法中，对象将其本身添加为通知的监听者，然后另外再实现一个方法（被addObserver:..方法中的选择器所识别）来处理通知：  

	-(void)viewDidLoad {
	   [super viewDidLoad];
	    [[NSNotificationCenter defaultCenter] addObserver:self
        selector:@selector(keyboardWillShow:)
        name:UIKeyboardWillShowNotification object:nil];
	}
 
	-(void)keyboardWillShow:(NSNotification *)notification {
   		 // Notification-handling code goes here.
	}


而使用addObserverForName:object:queue:usingBlock:方法的话，你就能将通知处理的代码在方法调用中一起合并了：  

	-(void)viewDidLoad {
    	[super viewDidLoad];
	    [[NSNotificationCenter defaultCenter] addObserverForName:UIKeyboardWillShowNotification
         object:nil queue:[NSOperationQueue mainQueue] usingBlock:^(NSNotification *notif) {
             // Notification-handling code goes here. 
   		 }];
	}

blocks的一个比其他回调更有价值的地方是block会在其局部词法范围内共享数据。若你实现了一个方法，并在该方法内定义了一个block，block会和函数以及全局变量一样有权访问方法中的本地变量和参数（包括栈变量），包括实例变量。默认的，这种权限是只读的，不过若你使用__block修饰符来定义一个变量的话，你就可以在block中修改这个变量的值了。即使在方法或函数的闭合block已经返回了，它的局部已经销毁，只要对于block还有引用，它的局部变量也会作为block对象的一部分继续存在下去。

## 系统框架APIs中的Blocks
一个使用blocks的明显的原因是系统框架中的函数和方法使用blocks作为参数的数量明显增多。以下列出六个系统框架中使用blocks的方法示例：  

* 完成回调
* 通知回调
* 错误回调
* 枚举
* 视图动画和过渡
* 排序

以下各段落会详细描述每个示例。不过在开始前，我们先看一个在系统框架方法中block声明的解释的快速概览。我们先考虑一下NSSet类的以下方法：  

	- (NSSet *)objectsPassingTest:(BOOL (^)(id obj, BOOL *stop))predicate

block的声明显示该方法传递给block（对于每个枚举元素）一个动态类型的对象以及一个布尔值类型的引用；block会返回一个布尔值。（这些参数和返回值实际上是什么会在“枚举”一节提到。）当实现该block时，要以脱字符（^）开始，然后加上括号和参数列表；最后加上大括号和block代码本身。

	[mySet objectsPassingTest:^(id obj, BOOL *stop) {
	    // Code goes here: Return YES if obj passes the test and NO if obj does not pass the test.
	}];

### 完成和错误处理
完成处理回调是指当系统框架方法完成任务时，客户端能够执行一些方法。通常客户端会使用完成回调来释放某些状态或者更新用户界面。一些系统方法能够让你以blocks的形式来实现完成回调（而非代理或通知的形式）。  
UIView类有几个动画和视图转换的类方法使用了完成回调的block参数。（“UIView动画和过度”一段给出了这些方法的概述。）清单1-1中列出的示例展示了animateWithDuration:animations:completion:方法的实现。该方法的完成回调处理在动画结束后的几秒后重置了视图的初始位置和透明度（alpha值）。  

清单1-1 一个完成回调处理block  

	- (IBAction)animateView:(id)sender {
	    CGRect cacheFrame = self.imageView.frame;
	    [UIView animateWithDuration:1.5 animations:^{
	        CGRect newFrame = self.imageView.frame;
	        newFrame.origin.y = newFrame.origin.y + 150.0;
	        self.imageView.frame = newFrame;
	        self.imageView.alpha = 0.2;
	    }
	                     completion:^ (BOOL finished) {
	                         if (finished) {
	                             // Revert image view to original.
	                             self.imageView.frame = cacheFrame;
	                             self.imageView.alpha = 1.0;
	                         }
	    }];
	}

有些系统框架方法有错误回调，这种block参数与完成回调类似。当由于某些错误的条件造成无法完成某些任务时，方法会调用它们（并传递NSError对象参数）。通常你都需要实现一个错误处理来通知用户有错误。  

### 通知处理
NSNotificationCenter的方法addObserverForName:object:queue:usingBlock:能够让你在设置监听时就能够实现通知的处理。清单1-2展示了你在调用该方法时需为通知定义一个block处理。同时，作为通知处理方法，会传递一个NSNotification对象。该方法同样会传递一个NSOperationQueue实例对象，以便你的应用程序能够指定一个执行上下文来运行block处理。  

清单1-2 添加一个对象为监听并使用block来处理通知  

	- (void)applicationDidFinishLaunching:(NSNotification *)aNotification {
	    opQ = [[NSOperationQueue alloc] init];
	    [[NSNotificationCenter defaultCenter] addObserverForName:@"CustomOperationCompleted"
	             object:nil queue:opQ
	        usingBlock:^(NSNotification *notif) {
	        NSNumber *theNum = [notif.userInfo objectForKey:@"NumberOfItemsProcessed"];
	        NSLog(@"Number of items processed: %i", [theNum intValue]);
	    }];
	}

### 枚举

### 视图动画和过渡

### 排序

## Blocks和并发