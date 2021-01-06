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

## 创建和安排一个Timer

### 持有Timers和对象生命周期

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