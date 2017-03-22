原文：https://developer.apple.com/library/content/documentation/Miscellaneous/Conceptual/iPhoneOSTechOverview/Introduction/Introduction.html#//apple_ref/doc/uid/TP40007898

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

