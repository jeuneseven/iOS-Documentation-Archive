[Run Loops 原文链接](https://developer.apple.com/library/archive/documentation/Cocoa/Conceptual/InputControl/InputControl.html#//apple_ref/doc/uid/10000062i)

# 介绍
## 本文档组织结构

本编程话题包含以下文章：  

* 运行循环：提供了运行循环是什么以及它是如何操作的概览。
* 输入模式：描述了输入模式是如何被运行循环用在区分输入源的。
* 获取运行循环：描述了如何获取当前运行循环对象。
* 添加输入源：描述了如何添加输入源到一个运行循环。
* 运行运行循环：描述了你进入运行循环的方式。

# 运行循环

事件驱动的应用程序会在一个运行循环中接收它们的事件。运行循环会监控应用程序的输入源并在输入源准备好执行处理的时候对其进行分发控制。当处理完成，控制权会传回给运行循环，并等待下一个事件。可能的事件包括窗口系统的鼠标和键盘事件，端口数据的抵达，计时器的启动和分发对象请求。  
NSRunLoop 类定义了编程接口给对象用来管理输入源，对象会从巡行循环接收信息。运行循环有两种常见类型的输入源：异步（输入以不规律的间隔到达）和同步（输入以规律的间隔到达）。NSPort对象代表异步输入源，NSTimer对象代表同步输入源。  
除了管理输入源，NSRunLoop还提供了对延迟操作（事件驱动而非时间驱动）的支持。NSWindow在较复杂的视图上使用延迟事件来执行屏幕的刷新。NSNotificationQueue 使用它来发送通知队列，配合NSPostASAP 和 NSPostWhenIdle模式。你还可以使用 NSRunLoop 的 performSelector:target:argument:order:modes: 方法来请求一个延迟操作；指示的方法会在接下来的运行循环中随后发送给目标。  
通常来讲，你的应用程序不会需要创建或明文的管理 NSRunLoop 对象。每个NSThread，包含在应用程序的主线程当中，都有一个自动为其创建的NSRunLoop对象。不过，只有在一个应用程序主线程中使用Application框架才会自动运行它的运行循环；其他的线程（或者Foundation框架工具）就得明确运行它的运行循环了。要访问当前线程默认的运行循环，使用 NSRunLoop 的类方法currentRunLoop。  
当一个NSRunLoop运行时，它会为每个输入模式获取源来判断是否有任何需要执行的操作。每次循环只有一个可以执行。如果没有输入源执行，NSRunLoop会等待操作系统的输入。运行循环会一直等待直到有输入或者超时——会在运行循环开始时提供——超出。在这个时间点下，NSRunLoop可能会返回或者继续，根据到底是哪个方法被用在了运行循环的不同来决定。

# 输入模式

运行循环可以在不同的模式下运行。模式会被定义为一个随机字符串，定义了一系列输入源，当运行循环在该模式中时会监听输入源。举例来说，当应用程序空闲时你可以有一个模式在运行，等待所有类型的事件来处理，二其他的只需要监听特定的端口，等待一个分发的对象请求的响应即可。在后者这种情况下，你无需处理键盘事件，因为应用程序尚未完成处理导致发出分布式对象请求的早期事件。  
NSRunLoop 定义了这个输入模式：  

输入模式  | 描述
------------- | -------------
NSDefaultRunLoopMode | 使用这种模式来处理输入源，而非NSConnections。这是最常用的运行循环模式。

此外，NSConnection定义了这种模式：  

输入模式  | 描述
------------- | -------------
NSConnectionReplyMode | 使用这种模式来指示NSConnection对象等待回复。你会很少用到这种模式。

NSApplication 定义了这些模式：  

输入模式  | 描述
------------- | -------------
NSModalPanelRunLoopMode | 当等待一个调试面板（比如NSSavePanel或者NSOpenPanel时）的输入时会使用这种模式。
NSEventTrackingRunLoopMode | 使用这种模式来做事件跟踪循环。

关联一系列的输入源给每个输入模式。源可以通过NSRunLoop的方法addPort:forMode:、addTimer:forMode:或者由NSConnection，NSPort，NSTimer提供的方法来添加到运行循环中。输入源可以被添加到不同的输入模式中。  
当添加一个输入源到某个模式时，你可以通过指定一个新的模式名来创建一个额外的模式。

# 获取运行循环

当使用一个用Application框架构建的应用时，运行循环会自动创建和运行。如果你需要访问这个运行循环，使用NSRunLoop的类方法currentRunLoop。  
其他的运行循环由其他的NSThread创建，并且也能够通过调用currentRunLoop从每个线程中访问到。这些运行循环不会有任何输入源，并且在线程开始时不会运行。你必须将输入源添加进去，然后自己启动。  

```
警告：NSRunLoop类通常不会考虑线程安全，它的方法应该只被在当前线程的上下文中调用。你不应该尝试调用一个NSRunLoop对象运行在不同线程中的方法，这样做可能会引起意想不到的结果。
```

# 添加输入源

在大部分情况下，输入源对象会将其本身根据需要添加到当前运行循环中，但是你可以手动将其添加以获得对其行为的更好的控制。  
举例来说，NSTimer类的方法 scheduledTimerWithTimeInterval:invocation:repeats:创建了一个新的计时器对象，然后将其以NSDefaultRunLoopMode模式添加到当前运行循环中。如果你使用timerWithTimeInterval:invocation:repeats: 创建计时器，你必须将其手动添加到运行循环中，使用 NSRunLoop 的实例方法addTimer:forMode:，该方法会让你能够指定不同的模式。  
NSPort对象通常作为 NSConnection 的一部分使用，它会根据需要自动的添加它收到的端口到适当的模式中。如果你有一个单独的端口对象，你可以用NSRunLoop的方法 addPort:forMode: 手动将其添加到运行循环中。  

# 运行运行循环



	[[NSRunLoop currentRunLoop] run];
