[Timer Programming Topics 原文链接](https://developer.apple.com/library/content/documentation/Cocoa/Conceptual/Timers/Timers.html#//apple_ref/doc/uid/10000061i)

# 介绍
## 介绍Timers

定时器提供了一种方式来执行延迟的行为或者定期的行为。定时器会等到一个特定的时间间隔渡过后，然后启动，发送一个特定的消息给一个特定的对象。举例来说，你可以创建一个定时器发送消息给一个控制器对象，告诉它要在某个特定时间间隔后更新一个特定值。  

## 概览

定时器会结合NSRunLoop对象进行工作。从结果来看，它们并不提供一个实时机制——它们的准确性有限。  
更多关于定时器的常识，参见“定时器”。  
有很多种方面可以使用定时器。当你创建一个定时器时，你必须将其配置以便知道什么消息要在什么时候发送给什么对象。你必须将其关联一个run loop对象，以便其进行启动——一些创建方法会自动的帮你做这件事。最后，如果你创建了一个重复的定时器，你必须在你想要它停止运行的时候令其失效。  
要了解更多使用定时器的信息，参见“使用定时器”。

# Timers

定时器会结合 NSRunLoop 对象进行工作。从结果来看，它们并不提供一种实时机制——它们的准确性有限。如果你只是想要在未来的某个时间点发送一条消息的话，你可以不必使用定时器。

## Timers和Run Loops

定时器由NSTimer对象表示。它们与NSRunLoop对象结合使用。NSRunLoop对象控制了循环，它会等待输入，并且它们使用定时器来判断应该等待的最大限度的时间。当定时器的时间限制已经度过，运行循环将会启动定时器（触发其消息被发送）然后检查新的输入。  
注册定时器的运行循环模式必须运行，定时器才能够被触发。对于使用Application或UIKit框架构建的应用，应用程序对象会为你在主线程运行一个循环。不过在辅助线程上，你必须自己运行一个循环——参见“运行循环”了解更多细节。  
每个运行循环的定时器都只能一次性在一个运行循环中注册，尽管它能够被添加到该运行循环中的不同的运行循环模式。  

## 时间的准确性

计时器并非一个实时机制；它只在一个计时器被添加到运行循环模式并且会检测计时器启动时间是否过了的时候才会启动。因为不同的输入源都是典型的运行循环消息，所以计时器的最高效的时间间隔方案是限制在50-100毫秒之间。如果计时器的触发时间发生在运行循环处于计时器没有被监视或者长时间没有被调用的情况下，则计时器不会被触发，直到下一次运行循环检测到计时器。所以，计时器开始的实际时间可能会是在预定的触发时间之后的重要时间段。  
重复的计时器会将其自己重新基于预定的开始时间安排，而非实际的开始时间。举例来说，如果一个计时器被排到了一个特定时间并且在这之后每五秒钟触发一次，那么计划的触发时间将会在原时间后每五秒钟间隔一次，即使实际的开始时间延迟了。如果开始时间延迟了，它会将之传递给一个或更多的计划触发时间，计时器在该时间间隔后只会触发一次；在触发之后，计时器随后会被重新计划，下次计划时间将会在未来的某个时间点。

## Timers的替代品

如果你只是想要在未来的某个时间点发送一个消息的话，你可以不必使用timer，可以使用performSelector:withObject:afterDelay: 和相关方法来直接调用一个方法和其他对象。一些其他的变体，比如performSelectorOnMainThread:withObject:waitUntilDone:，能够让你在一个指定线程中调用方法。你还可以使用 cancelPreviousPerformRequestsWithTarget: 和相关方法来取消一个延迟的消息。

# 使用Timers

使用一个计时器由几部分构成。当你创建一个计时器的时候，你必须对其配置以便在计时器开始的时候它会知道应该发送什么消息给什么对象。你必须将其关联到一个运行循环中，以便它准备好要开始——某些创建方法会自动为你做这件事。最后，如果你创建一个重复的计时器，你必须在你想要让其停止的时候将其设置为无效。  

## 创建和安排一个Timer

大体上说，有三种方法来创建一个计时器：  

1. 将一个计时器排入当前运行循环；
2. 创建一个计时器，随后将其注册进一个运行循环；
3. 以一个给定开始时间初始化一个计时器。

在所有情况下，你都要配置计时器，告诉它要开始的时候它应该发送什么消息给什么对象，以及它是否应该重复。使用这些方法，你可能还需要提供一个用户信息的字典。你可以将任意你想要的信息放到该字典当中，这样在计时器开始被调用的时候在方法的使用中可能会用到这些信息。  
有两种方法告诉一个计时器它应该发送什么消息以及它应该给哪个对象发送消息——通过分别指定，或者（某些情况下）通过使用 NSInvocation 的实例。如果你给消息直接指定一个selector，该方法的名称叫什么无所谓，但是它必须有以下签名：  

	- (void)targetMethod:(NSTimer*)theTimer

如果你创建一个invocation对象，你可以指定任意你想要的消息。（更多关于invocation对象，参见《发布对象编程话题》中的“使用NSInvocation”一节。）

### 持有Timers和对象生命周期

由于运行循环持有计时器，从对象的生命周期角度来看在你已经排上一个计时器之后通常不需要去持有一个计时器的引用。（由于计时器在你指定一个方法作为selector时就已经作为一个参数传递过去了，你可以在该方法当中的合适的时机使一个重复的计时器无效。）不过，在很多情况下，你可能还想要使计时器失效的选项——甚至可能在其开始之前就这样。在这种情况下，你需要持有一个计时器的引用，以便让你在任何适合的时机下停止它。如果你创建一个为被编排的计时器（参见“未被编排的计时器”），那么你必须对该计时器持有强引用，以便该计时器在你使用它之前不会被销毁。  
计时器对其target持有强引用。这意味着只要计时器有效，它的target将不会被销毁。那么必然的，这意味着计时器的target在尝试在它的dealloc方法当中要计时器无效的话将会没有效果——只要计时器还有效，dealloc 方法将不会被调用。

### Timer示例

	@interface TimerController : NSObject
	 
	// The repeating timer is a weak property.
	@property (weak) NSTimer *repeatingTimer;
	@property (strong) NSTimer *unregisteredTimer;
	@property NSUInteger timerCount;
	 
	- (IBAction)startOneOffTimer:sender;
	 
	- (IBAction)startRepeatingTimer:sender;
	- (IBAction)stopRepeatingTimer:sender;
	 
	- (IBAction)createUnregisteredTimer:sender;
	- (IBAction)startUnregisteredTimer:sender;
	- (IBAction)stopUnregisteredTimer:sender;
	 
	- (IBAction)startFireDateTimer:sender;
	 
	- (void)targetMethod:(NSTimer*)theTimer;
	- (void)invocationMethod:(NSDate *)date;
	- (void)countedTimerFireMethod:(NSTimer*)theTimer;
	 
	- (NSDictionary *)userInfo;
	 
	@end
	
	- (NSDictionary *)userInfo {
	    return @{ @"StartDate" : [NSDate date] };
	}
	 
	- (void)targetMethod:(NSTimer*)theTimer {
	    NSDate *startDate = [[theTimer userInfo] objectForKey:@"StartDate"];
	    NSLog(@"Timer started on %@", startDate);
	}
	 
	- (void)invocationMethod:(NSDate *)date {
	    NSLog(@"Invocation for timer started on %@", date);
	}


## 安排Timers

## 解除Timers

## 用一个日期初始化一个Timer

## 停止一个Timer