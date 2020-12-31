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

定时器由NSTimer对象代表。它们与NSRunLoop对象结合使用。NSRunLoop对象控制了循环，它会等待输入，并且它们使用定时器来判断它们应该等待的最大限度的时间。当定时器的时间限制已经度过，运行循环将会启动定时器（触发其消息被发送）然后检查新的输入。  


## 时间的准确性

## Timers的替代品

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