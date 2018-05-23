# 关于iOS中的事件处理
用户会以多种方式操作其iOS设备，比如触摸屏幕或摇晃设备。当用户操作硬件设备，设备将信息传递到你的APP的时候，iOS会拦截这一过程。你的APP响应这些事件越自然和直观的话，带给用户的体验就越强烈。
## 概览
事件是发送给APP的对象，它会通知后者用户的行为。在iOS当中，事件可以有多种形式：多点触摸事件，移动事件，以及控制多媒体事件。最后一种类型的事件被称作远程控制事件，因为它可以由外部设备发起。
### UIKit为你的app简化了检测手势
iOS APP会识别触摸事件并将其直观的反馈给用户，比如通过响应捏合手势来对内容进行缩放，比如滚动内容以响应轻扫手势。实际上，一些手势是很通用的，它们被内建在了UIKit当中。比如 UIControl 的子类 UIButton 和 UISlider 会响应特定的手势——点击按钮和拖拽滑块。当你配置这些控件的时候，当触摸事件发生时，它们会发送动作信息给目标对象。你还可以在视图上通过使用手势识别来应用目标-动作机制。当你将一个手势识别附加在视图上时，整个视图会表现的像一个控件——响应你所指定的手势。  
手势识别为复杂的时间处理逻辑提供了一个高层级的抽象。在APP当中，我们推荐你使用手势识别来实现触摸事件的相关处理，因为手势识别是强大、可重用以及可适配的。你可以使用任意内置的手势识别并对其行为定制化。或者你可以创建你自己的手势识别来识别新的手势。  
相关章节：“手势识别”
### 事件沿一个特定路径寻找对象来对其进行处理
当iOS识别到了一个事件，它会将其传递给看起来最接近能够处理事件的初始对象，比如触摸事件所发生的视图。若初始的对象不能够处理触摸事件的话，iOS会继续扩大范围查找能够拥有足够的上下文来处理事件的对象然后将事件传递给它。这个过程被称作“响应者链条”，iOS会沿链条传递事件，并且同时会传递相应事件的职责。这种设计模式会使事件处理更耦合和动态。  
相关章节：“事件传递：‘响应者链条’”
### UIEvent封装了触摸，移动或远程控制事件
很多事件是 UIEvent 类的实例对象。UIEvent对象会包含事件的相关信息，你的APP可以用它来决定如何响应事件。拿用户的动作举例来说，当手指触碰到屏幕并沿着屏幕滑动时，iOS会不断的给APP的处理事件的方法发送事件对象。每个事件对象都有一种类型——触摸，震动或远程操作——每种都有子类型。  
相关章节：“多点触摸事件”，“移动事件”，“远程控制事件”
### 当用户触摸视图时app会接收到多点触摸事件
根据你的app的不同，UIKit空间和手势识别可能会对于app的触摸事件处理的程度有所不同。即使你的app有自定义视图，你也可以使用手势识别。一般来说，当你的app响应视图本身的触摸事件紧紧耦合的话，你需要编写你自己的自定义触摸事件处理，比如根据触摸进行绘制。在这种情况下，你要负责底层的事件处理。你需要实现触摸事件方法，在这些方法中，你要对原始的触摸事件进行分析并做出适当的响应。  
相关章节：“多点触摸事件”
### 当用户移动其设备时app会接收到移动事件
移动事件提供了关于设备的位置，方向和移动相关的信息。通过响应移动事件，你能够为你的app添加一些精细但又有效的功能。加速计和陀螺仪数据能够让你监测到倾斜，旋转和振动。  
移动事件以多种不同的形式到来，当然你可以使用不同的框架来对其进行处理。当用户晃动设备的时候，UIKit会传递一个UIEvent对象给你的app。若你的app想以连续的高频率的接收加速计和陀螺仪数据的话，请使用Core Motion框架。
相关章节：”移动事件“
### 当用户操作多媒体控件时app会接收到远程控制事件
iOS控件和外部扩展会将远程控制事件发送给app。这些事件能够让用户控制音频和视频，比如通过耳机来调整音量等。处理多媒体远程控制事件能够让你的app响应这些类型的命令。
相关章节：“远程控制事件”
## 前置阅读
本文档假设你熟悉以下内容：  

* iOS app开发的基本概念
* 创建你的app用户界面的不同部分
* 视图和视图控制器是如何工作以及如何定制化它们的

若你不熟悉这些概念的话，请从“从今天开始开发iOS app”开始阅读。然后要阅读“iOS视图编程指南”和“iOS视图控制器编程指南”。
## 另请参见
iOS设备在提供触摸和设备的移动数据时是以相同的方式提供的，大部分iOS设备都拥有GPS和罗盘硬件来生成你的APP可能感兴趣的底层数据。“位置意识编程指南”讨论了如何接收和处理位置信息。  
对于一些高级的手势识别技术，比如平滑曲线和应用底滤波，参见WWDC2012：构建高级手势识别。  
在iOS文档库当中，很多示例代码工程都使用了手势识别和处理事件的代码。以下是一些工程：  

* “Simple Gesture Recognizers”工程是一个理解手势识别的很好的开始。这个应用展示了如何识别点击，轻扫和旋转手势。该应用会在触摸的位置通过展示和动画显示一张图片作为每个手势的响应。
* “Touches”包含了两个工程，模拟了如何处理多点触摸事件以及在屏幕上拖拽一个正方形。一个版本使用了手势识别，另一个使用了自定义触摸事件处理方法。后一个版本对于理解触摸阶段的事件特别有用, 因为当触摸出现时, 它会显示当前触摸屏。
* “MoveMe”展示了如何使用动画的方式来展示一个视图以响应触摸事件。查阅该示例工程会加深你对于自定义触摸事件处理的理解。

# 手势识别
手势识别会将底层的事件处理代码转换为高层的动作。它们是你附着在一个视图上的对象，它允许视图以一种控制的方式来响应动作。手势识别会截获触摸事件来决定它们是否与一个特定的手势相一致，比如轻扫，捏合或旋转。若它们识别到了被赋予的手势的话，它们会发送一个动作信息给目标对象。目标对象通常是视图的视图控制器，它会如图1-1那样响应手势。这种设计模式既有效又简单；你可以动态的决定视图应该响应什么动作，你也可以添加手势识别到一个视图上而不用子类化该视图。
## 使用手势识别简化事件处理
UIKit框架提供了内置的手势识别来检测常用的手势。你应当尽可能的使用预定义的手势识别，因为它们大大简化了你需要编写的代码量。此外，使用标准手势识别而非你自己编写的代码能够确保你的应用程序能够按照用户所期待的行为来运行。  
若你的应用程序想要识别一个独特的手势，比如对勾或画圆圈，你可以创建你自己的自定义手势识别。关于如何设计和实现你自己的手势别的相关信息，参见“创建自定义手势识别”（27页）。
### 内置的手势识别会识别常用的手势
当设计你的应用程序时，你需要考虑将何种手势开启。然后对于每个手势要决定在列表1-1当中的预定义手势识别是否能够满足要求。  

列表1-1 UIKit框架中的手势识别类  

手势  | UIKit类
------------- | -------------
点击（任意数量的点击）  | UITapGestureRecognizer
捏合或放大（对于一个视图的操作）  | UIPinchGestureRecognizer
平移或拖拽  | UIPanGestureRecognizer
轻扫（任意方向）  | UISwipeGestureRecognizer
旋转（手指以相反方向移动）  | UIRotationGestureRecognizer
长按（也被称作“触摸并持有”）  | UILongPressGestureRecognizer

你的应用程序应该以用户所期待的方式来对手势进行反馈。比如，捏合应当放大或缩小，而点击应当选中某物。关于如何恰当的使用手势的指南，参见“iOS用户界面指南”中的“应用程序响应手势而非点击”一章。
### 手势识别会附加到视图上
每个手势识别都会关联一个视图。而相反的，一个视图可以有多个手势识别，因为一个试图是可能响应多个手势的。若要手势识别发生在一个视图的触摸事件的话，你必须将手势识别附加到该视图上。当用户触摸该视图时，手势识别会在视图对象接受之前收到消息。作为结果，手势识别可以代表视图响应触摸事件。
### 手势会发送动作信息
当手势识别出了特定的手势，它会给它的目标发送动作消息。创建手势识别的时候，你要以一个目标和动作一起初始化。
#### 分离和连续的手势
手势有分离或连续的。一个分离的手势，例如点击，会只发生一次。而连续的手势，比如捏合，会持续一段时间。对于分离的手势，手势识别会给它的目标发送一个单一的动作消息。而连续的手势的手势识别会给它的目标持续发送消息，直到多点触摸停止，如图1-2所示。
## 使用手势识别响应事件
要将内建的手势识别加到你的应用程序中的话，需要做三件事：  

1. 创建并配置手势识别实例。该步骤包含赋值一个目标，动作以及赋值手势指定的一些属性（比如numberOfTapsRequired 需要多少次点击等）
2. 将手势识别附加到视图上。
3. 实现处理手势的动作方法。

### 使用界面编辑器来添加手势识别到你的app上

### 使用代码添加手势识别
你可以通过alloc和init的方式以代码的形式来创建UIGestureRecognizer的一个子类实例，比如UIPinchGestureRecognizer。当你初始化手势识别的时候，要指定目标对象和动作选择器，如清单1-2所示。通常，目标对象时视图的视图控制器。  
若你以代码的方式创建手势识别的话，你需要使用addGestureRecognizer:方法来将它附加在视图上。清单1-2创建了一个点击手势识别，指定手势识别一次点击，然后将手势识别对象附加到视图上。通常，在视图控制器的viewDidLoad方法当中创建手势识别，如清单1-2所示。

清单1-2 通过代码创建一个点击手势识别

	- (void)viewDidLoad {     [super viewDidLoad];
     // Create and initialize a tap gesture       UITapGestureRecognizer *tapRecognizer = [[UITapGestureRecognizer alloc]            initWithTarget:self action:@selector(respondToTapGesture:)];       // Specify that the gesture must be a single tap       tapRecognizer.numberOfTapsRequired = 1;       // Add the tap gesture recognizer to the view       [self.view addGestureRecognizer:tapRecognizer];       // Do any additional setup after loading the view, typically from a nib	  }

### 响应间断的手势
当你创建一个手势识别的时候，你需要将其连接到一个动作方法上。使用动作方法来响应你的手势识别出来的手势。清单1-3展示了一个响应间断的手势的例子。当用户点击手势识别附加的视图时，视图控制器会展示一个图片说“Tap”。showGestureForTapRecognizer:方法会从识别器的locationInView:属性获取位置，并将图片展示在该位置。  

	注意：接下来的三个代码例子都是从“Simple Gesture Recognizers”示例代码工程中找到的，你可以在该工程中查看更多的内容。

清单1-3 处理两次点击手势  

	- (IBAction)showGestureForTapRecognizer:(UITapGestureRecognizer *)recognizer {         // Get the location of the gesture        CGPoint location = [recognizer locationInView:self.view];         // Display an image view at that location        [self drawImageForGestureRecognizer:recognizer atPoint:location];         // Animate the image view so that it fades out         [UIView animateWithDuration:0.5 animations:^{             self.imageView.alpha = 0.0;	}]; }

每个手势识别都有其自己的一套属性。比如，在清单1-4当中，showGestureForSwipeRecognizer:方法使用轻扫手势识别的direction属性来决定用户是从左往右还是从右往左扫动的。然后使用该值来设置一个图片以相同的扫动方向淡出。  

清单1-4 向左或向右响应轻扫手势  

	// Respond to a swipe gesture	- (IBAction)showGestureForSwipeRecognizer:(UISwipeGestureRecognizer *)recognizer	{	// Get the location of the gesture	CGPoint location = [recognizer locationInView:self.view];	// Display an image view at that location	[self drawImageForGestureRecognizer:recognizer atPoint:location];	// If gesture is a left swipe, specify an end location	// to the left of the current location	if (recognizer.direction == UISwipeGestureRecognizerDirectionLeft) {	     location.x -= 220.0;	} else {	     location.x += 220.0;	}	// Animate the image view in the direction of the swipe as it fades out	[UIView animateWithDuration:0.5 animations:^{	     self.imageView.alpha = 0.0;   		  self.imageView.center = location;	}];
	}

### 响应连续的手势
连续的手势能够让你的应用程序即时的响应手势。比如，你的应用程序能够在用户捏合的时候进行缩放或者允许用户沿着屏幕拖拽一个对象。  
清单1-5展示了一个与手势相同旋转角度的“Rotate”图片，随后用户停止旋转，动画的将图片在旋转回水平的位置淡出处理。当用户旋转它的手指时，showGestureForRotationRecognizer:方法会被持续的调用，直到两个手指都离开屏幕。  

清单1-5 响应旋转手势

	// Respond to a rotation gesture
	- (IBAction)showGestureForRotationRecognizer:(UIRotationGestureRecognizer	*)recognizer {       // Get the location of the gesture       CGPoint location = [recognizer locationInView:self.view];       // Set the rotation angle of the image view to       // match the rotation of the gesture       CGAffineTransform transform = CGAffineTransformMakeRotation([recognizer	rotation]);	       self.imageView.transform = transform;   		    // Display an image view at that location  	     [self drawImageForGestureRecognizer:recognizer atPoint:location];	      // If the gesture has ended or is canceled, begin the animation	      // back to horizontal and fade out	      if (([recognizer state] == UIGestureRecognizerStateEnded) || (		[recognizer		state] == UIGestureRecognizerStateCancelled)) {           [UIView animateWithDuration:0.5 animations:^{                self.imageView.alpha = 0.0;                self.imageView.transform = CGAffineTransformIdentity;	}]; }	}

每当该方法被调用时，在drawImageForGestureRecognizer:方法当中，图片都会被设置为不透明。当手势结束时，图片在animateWithDuration:方法中被设置为透明的。showGestureForRotationRecognizer:方法通过检测手势识别的状态来判断手势是否结束。这些状态在“在有限状态机中进行手势识别操作”部分有更详细的解释。
## 定义手势识别的相互作用
通常，当你添加手势识别到你的应用程序时，你需要你需要指定手势识别之间如何进行相应或者手势识别如何相应你的应用程序的触摸事件相关代码。想要做到这些的话，你首先需要对于手势识别是如何工作的有一些了解。
### 手势识别是在一个有限状态机中进行操作的
手势识别是以一种预定义好的方式从一种状态转换到另一种。从每种状态移动到多种可能的下一个状态是基于他们遇到的特定条件。多重状态机的确定是基于手势识别是分离还是连续决定的，如图1-3所示。所有的手势识别都是从Possible状态开始的（UIGestureRecognizerStatePossible）。它们会解析它们所接收到的多点触摸事件序列，在解析过程中，它们要么识别，要么过滤该手势。过滤该手势意味着手势识别转换到Failed状态（UIGestureRecognizerStateFailed）。  
当一个间断的手势识别器识别了它的手势时，手势识别器会从Possible状态转换到Recognized状态（UIGestureRecognizerStateRecognized），然后识别结束。  
对于连续的手势，手势识别器会在手势第一次被识别时从Possible状态转换到Began（UIGestureRecognizerStateBegan）状态。然后它会从Began转换到Changed状态(UIGestureRecognizerStateChanged)，随着手势的发生，会继续从Changed移动到Changed状态。当用户的手指最终离开视图时，手势识别器会转换到Ended（UIGestureRecognizerStateEnded）状态，然后手势识别结束。注意Ended状态是Recognized状态的一个别名。  
一个连续的手势的识别同样能够从Changed转换到Canceled状态（UIGestureRecognizerStateCancelled）当手势识别判断手势不在符合预期模型时就会发生。  
每当一个手势识别状态改变时，手势识别器都会给其目标发送一个动作信息，除非它转换至Failed或Canceled状态。此外，一个间断的手势识别器只会在从Possible转换到Recognized状态时才会给目标发送一个单一的动作信息。而连续的手势识别器会在它的手势状态发生改变时发送多个动作信息。  
当手势识别器达到Recognized（或Ended）状态时，它会将状态重置为Possible。将状态转换为Possible不会触发发送动作信息。
### 与其它的手势识别进行交互

### 与其它的用户界面控制进行交互

## 手势识别拦截了原始的触摸事件

### 一个事件包含了所有当前多点触摸序列的相关触摸信息

### 在触摸处理方法中app会接收到触摸事件

## 调整发送到视图的触摸事件

### 手势在识别一个触摸事件时会第一时间接收

### 影响触摸事件传递到视图

## 创建自定义手势识别

### 为自定义手势识别实现触摸事件处理方法

### 重新设置一个手势识别状态

# 事件传递：响应者链条

## 当一个触摸事件发生时Hit-Testing会返回给视图

## 响应者链由响应者对象构成

## 响应者链会沿一个特定路径传递

# 多点触摸事件

## 创建UIResponder的子类

## 在你的子类当中实现触摸事件处理方法

## 跟踪触摸事件的位置

## 检索触摸对象

## 处理轻触事件

## 处理轻扫和拖拽事件

## 处理复杂的多点触摸序列

## 指定自定义触摸事件行为

## 通过重写Hit-Testing来拦截触摸事件

## 转发触摸事件

## 处理多点触摸事件的最佳实践

# 移动事件

## 通过UIDevice获取当前设备的方向

## 通过UIEvent检测震动事件

### 为移动事件标记第一响应

### 实现移动处理方法

## 为移动事件设置和监测必需的硬件功能

## 通过Core Motion捕获设备的移动

### 选择移动事件更新频率

### 使用Core Motion处理加速计事件

### 处理自转率数据

### 处理包装过的设备移动数据

# 远程控制事件

## 让你的app准备好处理远程控制事件

## 处理远程控制事件

## 在一台设备上测试远程控制事件