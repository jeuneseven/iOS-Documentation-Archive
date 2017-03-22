原文链接：  
https://developer.apple.com/library/content/documentation/Miscellaneous/Conceptual/iPhoneOSTechOverview/Introduction/Introduction.html#//apple_ref/doc/uid/TP40007898

# iOS技术相关

iOS是运行在iPad，iPhone和iPod touch等设备上的操作系统。操作系统负责管理硬件设备以及提供实现app所需要的技术。操作系统也搭载了各种系统app，例如Phone，Mail，Safari等，用来提供一些标准系统服务给用户。  

iOS软件开发套件（简称SDK）包含大量的工具以及接口用来开发、安装、运行以及测试安装在iOS设备屏幕上的app。app使用iOS系统提供的Framework和OC开发并直接运行在iOS上。原生app与web app不同，原生app是被直接安装在设备上，因此对于用户始终可用，即使设备处于飞行模式。他们就在系统app的旁边，并且不论是app还是用户的数据都可以通过iTunes同步到用户的电脑上。  
> 注意：通过结合HTML，CSS，JS代码来开发web app是可行的。web类app是运行在Safari浏览器中，并且需要网络来连接到web服务器。本文档并不覆盖开发web app 的相关内容。有关基于Safari开发web app的相关内容请查看： Safari Web Content Guide。

## 前言  
iOS SDK提供了你开发iOS apps所需资源。多了解一些这些在SDK中的开发技术和工具有助于你更好的设计和实现你的app。

### iOS系统架构是以层级划分的
在高层级中，iOS在底层硬件和你开发的app之间扮演着一个调度者的角色。app不是直接与底层硬件直接对话的。而是通过一系列定义好的系统接口。这些接口能够保证即使在硬件能力不同的设备上，你的app依然能够同样运行。  
iOS技术的实现可以用层级来展示，如下图。底层包含了基本的服务和技术。高层级依赖于底层建立，并且提供了更为复杂的服务和技术。  

![Figure I-1  Layers of iOS](https://developer.apple.com/library/content/documentation/Miscellaneous/Conceptual/iPhoneOSTechOverview/Art/SystemLayers_2x.png)  

就像你构建你的代码一样，我们推荐你无论何时都尽量使用高层级的framework，而不是底层的。高层级的framework对于底层提供了更为面向对象的抽象封装。这些抽象的封装使得编码更容易。因为它减少了大量的你必须写的代码并将可能存在的复杂功能进行了封装，例如sockets和threads。你也可能会用到底层的API，不过这应该是高层的API没有暴露相关功能接口的时候。
> 相关章节：Cocoa Touch Layer, Media Layer, Core Services Layer, Core OS Layer  

### iOS 的开发技术是被封装为Framework的
Apple提供的大部分系统的接口都被封装为一个被称作Framework的包中。一个framework包含了动态分享库以及各种资源（例如头文件，图片，帮助app）用来支撑库。如果想使用framework的话，你需要将它添加到Xcode你的项目中。  
> 相关段落：iOS Frameworks

### 开发者文库是用来帮助你的
iOS开发者文库在开发过程中是很重要的资源。它包含了API参考文献，编程指南，发行说明，技术文档，示例代码以及很多其他的资源提供，这可以让你能够用最好的方式去开发你的app。  
你可以通过网页访问iOS开发文档口。也可以通过Xcode中的Documentation and API 在窗口中显示，使用Xcode可以浏览，搜索以及对文档添加书签。

## 如何使用这篇文档
《iOS技术相关》文档对于任何刚刚进入iOS开发的人来说都是一个引导。它提供了iOS开发技术、iOS开发过程中对于开发有用的工具、相关链接等等。你应该这样使用这篇文档：  

* 明确你在iOS当中的开发方向  
* 学习iOS软件开发相关技术，为什么你要使用它，以及什么时候使用它  
* 了解iOS开发平台的发展  
* 获取从其他平台迁移到iOS开发平台的一些技巧  
* 浏览你感兴趣的技术文章  

本文档并不提供对软件开发过程中无影响的用户功能级别的内容，并且也不会列出特殊硬件性能的iOS设备。新手阅读者应该能通过本文对iOS更加了解。有经验的开发者可使用本文档作为iOS开发技术的一个探索图。  

## 另请参见
如果你是一个iOS开发新手，本文只提供系统级别的一个概览。想学习更多相关iOS开发app的内容，请参见如下文档：  

* 开始使用swift开发iOS app提供了开发过程的指导，从如何设置你的系统，到如何提交你的app到App Store都有所涉猎。如果你是个iOS开发新手的话，这篇文章是个不错的开始。
* iOS人机交互指南提供了如何设计你的app的交互界面的相关信息。
* app发布指南从工具的角度描述了iOS开发的过程。这篇文档包含配置设备以及使用Xcode构建、运行、测 试你的app的介绍。  

如果你已经支付了iOS开发者计划的相应产品，你就可以在一台设备上开始开发了。当你登录后，你可以在iOS开发者中心获得Xcode以及iOS SDK的一份拷贝。