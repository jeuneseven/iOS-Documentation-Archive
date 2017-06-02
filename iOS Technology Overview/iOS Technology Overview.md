[iOS Technology Overview 原文链接]  (https://developer.apple.com/library/content/documentation/Miscellaneous/Conceptual/iPhoneOSTechOverview/Introduction/Introduction.html#//apple_ref/doc/uid/TP40007898)  

![](https://github.com/jeuneseven/iOS-Developer-Library-Translate/blob/master/iOS%20Technology%20Overview/iOS%20Technology%20Overview.png)

# iOS技术相关

iOS是运行在iPad，iPhone和iPod touch等设备上的操作系统。操作系统负责管理硬件设备以及提供实现app所需要的技术。操作系统也搭载了各种系统app，例如Phone，Mail，Safari等，用来提供一些标准系统服务给用户。  

iOS软件开发套件（简称SDK）包含大量的工具以及接口用来开发、安装、运行以及测试安装在iOS设备屏幕上的app。app使用iOS系统提供的Framework和OC开发并直接运行在iOS上。原生app与web app不同，原生app是被直接安装在设备上，因此对于用户始终可用，即使设备处于飞行模式。他们就在系统app的旁边，并且不论是app还是用户的数据都可以通过iTunes同步到用户的电脑上。  
> 注意：通过结合HTML，CSS，JS代码来开发web app是可行的。web类app是运行在Safari浏览器中，并且需要网络来连接到web服务器。本文档并不覆盖开发web app 的相关内容。有关基于Safari开发web app的相关内容请查看： Safari Web Content Guide。

## 前言  
iOS SDK提供了你开发iOS apps所需资源。多了解一些这些在SDK中的开发技术和工具有助于你更好的设计和实现你的app。

### iOS系统架构是以层级划分的
在高层级中，iOS在底层硬件和你开发的app之间扮演着一个调度者的角色。app不是直接与底层硬件直接对话的。而是通过一系列定义好的系统接口。这些接口能够保证即使在硬件能力不同的设备上，你的app依然能够同样的运行。  
iOS技术的实现可以用层级来展示，如下图。底层包含了基本的服务和技术。高层依赖于底层建立，并且提供了更为复杂的服务和技术。  

![Figure I-1  Layers of iOS](https://developer.apple.com/library/content/documentation/Miscellaneous/Conceptual/iPhoneOSTechOverview/Art/SystemLayers_2x.png)  

就像你构建你的代码一样，我们推荐你无论何时都尽量使用高层级的framework，而不是底层的。高层级的framework对于底层提供了更为面向对象的抽象封装。这些抽象的封装使得编码更容易。因为它减少了大量的你必须写的代码，并将可能存在的复杂功能进行了封装，例如sockets和threads。你也可能会用到底层的API，不过这应该是高层的API没有暴露相关功能接口的时候。
> 相关章节：Cocoa Touch Layer, Media Layer, Core Services Layer, Core OS Layer  

### iOS 的开发技术是被封装为Framework的
Apple提供的大部分系统的接口都被封装为一个被称作Framework的包中。一个framework包含了动态分享库以及各种资源（例如头文件，图片，帮助app）用来支撑库。如果想使用framework的话，你需要将它添加到Xcode你的项目中。  
> 相关段落：iOS Frameworks

### 开发者文库是用来帮助你的
iOS开发者文库在开发过程中是很重要的资源。它包含了API参考文献，编程指南，发行说明，技术文档，示例代码以及很多其他的资源，这可以让你能够用最好的方式去开发你的app。  
你可以通过网页访问iOS开发文档。也可以通过Xcode中的Documentation and API 在窗口中显示，使用Xcode可以浏览，搜索以及对文档添加书签。

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
* app发布指南从工具的角度描述了iOS开发的过程。这篇文档包含配置设备以及使用Xcode构建、运行、测 试你的app的相关介绍。  

如果你已经支付了iOS开发者计划的相应产品，你就可以在一台设备上开始开发了。当你登录后，你可以在iOS开发者中心获得Xcode以及iOS SDK的一份拷贝。  

# Cocoa Touch 层
Cocoa Touch 层包含了构件iOS app的很多重要的framework。这些framework决定了你的app如何表现。并且提供构建app的基础，以及一些关键技术的支持，例如多任务处理（并行），屏幕上的输入，推送通知，和很多高层级的系统服务。当你设计你的app时，你应该多研究这一层的相关技术以供满足你的需要。  
## 高层级的功能
以下段落描述了Cocoa Touch 层的一些重要相关技术。  
### App Extensions （app扩展）
在高于iOS8的系统上，提供了一个叫做app扩展的技术，能够让你在系统上选定的区域去扩展你的app，在该区域可以根据用户的习惯自定义一些功能。例如，你可以为用户提供一个分享内容到网页上的扩展功能。当用户安装并且启动这项扩展功能时，用户可以在他们当前正在使用的app中选择分享按钮。  
在Xcode中，你可以通过为指定的app添加一个预定义好的扩展模块来达到目的。当用户安装了一个包含扩展程序的app时，用户在“设置”中可以对该扩展进行操作。当用户在使用其他app时，系统会将可用的扩展在适当的位置显示出来，比如分享列表。  
iOS支持app的扩展在以下几个方面，被称为扩展点的是：  
* 分享。社交类网站以及其他实体类的分享内容。
* 行为。给当前内容执行一项任务。
* 小工具。提供简洁的更新或者在通知中心的“今天”模块提供一份简短的任务。
* 照片编辑。在“照片”应用中提供照片以及视频的编辑。
* 文档功能。提供了可被其他app调用的文档存储位置。app可使用文档浏览器打开或者移动被文档管理器管理的文档。
* 自定义键盘。在设备层级为所有的app提供了可取代系统键盘的自定义键盘。    

每个可扩展点都提供了相应的API。当你使用app扩展模版进行开发时，你会获取到一些该扩展点默认的函数以及属性列表设置。
如果想了解更多关于扩展程序方面的信息，请浏览app扩展开发指南。  
### Handoff（同步）  
Handoff是一种用户在不同的iOS、macOS设备间切换时提供连贯性以增强用户体验的功能。Handoff能够让用户在一台设备上进行操作，然后切换到另一台设备时，能够继续刚才的操作。例如，一个用户在Safari上浏览了一篇很长的文章，然后他切换到使用了同一个Apple ID登陆的iOS设备，那么那篇文章会自动同步到iOS设备上的Safari中，并且停留在刚才看到的位置。Handoff技术会让这种用户体验看起来接近于无缝的。  
如果你的app需要加入Handoff功能的话，需要添加foundation框架中的一个API。所有用户正在进行的操作都被封装为一个用户行为对象，这个对象包含了所有迁移到离一台设备上的用户当前状态的数据。当用户选择恢复那个状态时，这个对象会被发送给需要恢复状态的那台设备。每个用户行为对象都有一个回调对象以供在合适的时机更新用户状态的时候调用，例如刚刚提到的用户状态的对象在用户切换设备的时候被发送。  
如果保持一个状态所需要的数据要比传输一个用户状态对象要容易的话，那么被唤起的app可能会给原app开启一个传输流。基于文档的app会自动的保证用户在iCloud上操作的文档的持续性。  
想了解更多关于如何支持Handoff，清浏览Handoff编程指南。  
### Document Picker（文档选择器）
文本选择器给予了用户在你的app的沙盒外访问文件的权限。原理与app之间共享文档相同。它还提供了更复杂的工作流，因为用户很可能使用不同的app编辑同一份文档。  
文档选择器能够让你从很多不同的文档提供者中访问文件。例如，iCloud文档提供者给予用户访问其他app的存储在iCloud容器中的文档的权限。第三方的开发者可以通过（Storage Provider）文档供应扩展功能来提供额外的文档。  
想了解更多关于文档选择器的相关信息，清查看文档选择器编程指南。  
### AirDrop（无线传输）
airdrop能够让用户为距离较近的设备分享照片，文档，URLs以及其他类型的数据。能够通过airdrop发送文件给其他iOS设备是基于**UIActivityViewController**这个类来实现的。这个类展示了你指定分享内容的多种选项。如果你没有用到这个类的话，你应该考虑将这个类添加到你的接口中。  
如果想通过airdrop接收文件的话，你必须实现以下几点：    

* 在Xcode中为适当的文档类型作出支持的声明。（Xcode中在Info.plist文件中添加适当的key）系统会使用这些你添加的信息来判断你的app是否能够打开接收到的文件。
* 在appdelegate中实现application:openURL:sourceApplication:annotation:方法，系统会在接收到文件的时候调用这个方法。

系统在接收到文件后，会存储到你的app的沙盒中的**Documents/Inbox**目录下。如果你打算修改文件的话，你必须在系统将文件存储到这个目录之前将文件移动到其他目录。（系统只允许你在这个这个目录下读和删除文件）存储在这个目录下的文件是加密的，所以你必须处理如果iOS设备被锁定，你无法得到文件这种情况。  
想了解更多关于使用activity view controller类来分享文件的信息的话，请查阅：UIActivityViewController Class Reference。  
### TextKit
TextKit是一整套处理文字排版的高层API和类的封装集合。使用TextKit，你可以对文字进行段落、行列甚至页面级别的排版；你可以将文字浮动在图片周围的任意位置；你可以使用它来管理多种字体。如果你打算使用Core Text框架对文字进行渲染的话，你应该考虑使用TextKit代替。TextKit与所有UIKit中基于文本的控件相关，使用它能够让app生成、编辑、展示、以及存储文本更为容易，并且可能会使用更少的代码就能够达到效果。  
TextKit包含了一些新的UIKit类，扩展了一些已经存在的类，包括以下：  

* NSAttributedString 类扩展了一些功能支持新的属性。
* NSLayoutManager 类生成字形以及渲染的文本。
* NSTextContainer 类定义了文本能够渲染的范围。
* NSTextStorage 类定义了一些基本接口来管理基于文本的内容。

想了解更多关于TextKit的信息，请查看Text变成指南。  
### UIKit Dynamics(UIKit动力学)
app能对UIView的对象的指定动态行为进行定制，这些对象必须要遵循UIDynamicItem协议。遵循这项协议的对象被称为动态对象。动态的特性与真实世界的行为特性相结合，增加了用户体验。UIKit动态性对以下几种行为提供支持：

* UIAttachmentBehavior对象代表着两个动态对象或一个动态对象与一个点之间的连接。当一个对象或者一个点移动的时候，连带着另一个对象也会移动。但是这种连接不是完全线性的。一个联动的行为会具有阻尼和震动效果，这决定了在动画过程中的行为变化。
* UICollisionBehavior对象能够让动态的对象在指定的边角发生碰撞效果。并且能够让对象本身响应碰撞效果。
* UIGravityBehavior对象为动态对象提供了重力矢量效果。当动态对象与边界或另一个动态对象发生碰撞的时候，本对象能够提供在矢量方向上的加速重力效果。
* UIPushBehavior对象为动态对象提供了连续的或者一瞬间的矢量效果。
* UISnapBehavior对象为动态对象提供了对齐点。对象能够以一种配置好的效果对齐到某个点。例如，一个动态对象如果是依附于一个弹簧的话，它可以对齐到该弹簧。
  
当添加动态行为到一个动画对象上时，该动画对象变为可用状态，这个动画对象是UIDynamicAnimator类的一个实例对象。执行动态行为对象的上下文由动画调用者提供。一个动态对象可以有多种行为，但是所有的这些行为都必须由同一个动画对象实现。  
更多的你可以使用的内容，请查看：UIKit Framework 参考。
### Multitasking(多任务处理)
电池寿命是用户的iOS设备的很重要的一个方面，多任务处理模型是iOS设计的一个让app在给定的时间内做他们应该做的事情，并且将电池寿命发挥到最大限度的模型。当用户点击home键时，前台的app会移动到后台。如果app没有什么任务要执行的话，系统会将app从活跃状态转为挂起状态，这时app还会停留在内存中，但不会执行任何代码。app需要执行哪些类型的任务可以向系统在后台的执行时间询问，例如：  

* app可以在有限的时间内来完成一些重要的任务。
* app可以向系统请求时间来提供一些指定的服务，例如播放声音。
* app可以使用本地通知在指定的时间生成警告提醒，不论app是否在运行。
* app可以从网络定期的下载数据。
* 当有推送通知时，app可以下载数据。 

关于如何辅助iOS多任务处理模型，请查看iOS app编程指南。
### Auto Layout(自动布局)
自动布局帮助你使用很少的代码就能够构建动态的界面。使用自动布局，你要定义好如何渲染你的用户界面元素的规则。这些规则定义了比以往使用的springs and struts模式更为直观的关系。例如，你可以指定一个按钮与其父view的边一直相距20像素。  
使用自动布局的OC实体被称作约束。约束提供以下功能：

* 约束能够通过交换字符串即可固定，而无需更新你的布局。
* 约束能够提供左右映射的语言环境，就像希伯来语和阿拉伯语。
* 约束提供了一种更好的方式对view和controller层中的对象进行解耦。

一个view对象通常都会持有它固定的大小，它在父view中的位置，以及它相对于兄弟view的位置等信息。VC能够在这些值不符合要求时对其进行重写。  
关于自动布局的更多信息，请查看自动布局指南。
### Storyboards(故事版)
故事版是iOS推荐的设计你的app用户界面的方式。故事版能够让你在一个界面中从整体上设计你的用户界面，在这个界面中，你可以看到你所有的view和VC，并且能够了解他们之间是如何协作的。故事版的一个重要功能是能够定义依赖，依赖代表着从一个VC到另一个VC的过渡。  
你可以使用一个故事版文件来存储你所有的view和VC，你也可以使用多个故事版来组织部分界面。在编译阶段，Xcode会将故事版的内容分拆成单独的小文件加载，以此来提高性能。你的app不需要去管理这些小文件。UIKit提供了封装好的接口以供你的代码调用故事版的内容。  
关于更多的使用故事版构建你的用户界面，请查看Xcode概览。关于如何通过代码来控制你的故事版，请查看UIStoryboard Class 参考。
### UI State Preservation(保留UI状态)
状态保留功能为用户在使用你的app时，提供一种无缝体验，这种体验不论你的app运行与否。当系统接收到内存警告时，很可能必须决定关闭一个甚至多个在后台静默的app。当app从前台移动到后台时，它能够保存view或VC的状态。在下一个加载循环中，它可以用之前保留的状态信息来恢复view或VC到上一个配置的状态，让这些View，VC就像你的app从未退出一样。
关于如何为你的app添加状态保留的更多信息，请查阅iOS app编程指南。
### Apple Push Notification Service(推送服务)
推送服务能够提供一种提醒用户有新消息的服务，甚至当你的app没有在运行的情况下。你可以推送文字信息，添加一个角标到你的app logo上，或者在任何时候都可以发起语音提醒。这些信息让用户知道他们应该打开你的app来查看相关的信息。在iOS7以上的系统中，你甚至能够推送一条静默的信息，让你的app知道有新的内容可以下载了。  
从设计的角度来看，推送通知有两部分可以为iOS app服务。第一，app必须在请求到推送信息的第一时间将收到的推送信息交付。第二，在服务端，你必须将生成推送信息的服务程序放在首要位置。这个程序是保存在你本地的服务器里，并且与苹果的推送服务一起来出发推送信息。  
关于如何使用配置你的app的远程推送功能，请查阅本地以及远程推送通知编程指南。
### Local Notifications(本地通知)
本地通知补充了推送通知的渠道，它可以用来生成本地的通知，而不是依赖外部的服务器。app运行在后台时，可以通过本地的通知来提醒用户有重要的事件发生。例如，导航类的app在后台运行时，可以使用本地通知提醒用户该转弯了。app还可以使用定时的本地通知在未来启用，即使是app并没有运行的时候。  
本地通知的优势是它不依赖于你的app。当一个通知被埋下，系统会管理它的生命周期。当一个通知发生时候，你的app不一定必须在运行状态。  
关于如何使用本地通知，请查阅本地以及远程推送通知编程指南。
### Gesture Recognizers(手势)
手势包含几种基本类型，例如在你的app的视图中扫动或者捏合。由于与系统检测手势的方式相同，手势会为你的app提供与系统一样的功能。使用方法是，你需要添加一个手势识别器到你的view上，并且给予它一个可以执行的方法，这样当手势发生的时候就会调用。手势识别器会做一系列复杂的工作来跟踪最原始的触摸事件，并且决定何时将这些触摸事件组成既有的手势。  
所有的手势识别器都是基于 UIGestureRecognizer 类，这个类定义了基本的行为。UIKit提供了标准的手势识别器子类来检测，例如：点击、捏合、滑动、扫动、敲击、旋转。你还可以对你app需要的大部分手势进行裁剪。例如，你可以指定一个点击的手势检测到一定数量的点击之后，才执行你要它执行的方法。  
关于更多可用的手势，请参考iOS事件处理指南。
### Standard System View Controllers（一些标准的系统VC）
许多系统框架定义了很多标准的系统界面VC。无论何时使用系统提供的这些VC都要比你自己重新创建要好。我们推荐你在你的app中使用这些VC为用户呈现始终如一的用户体验。无论何时你想要实现以下功能，你都应该使用对应的框架中提供的VC：

* 展示或编辑联系人信息。推荐使用 Address Book UI框架中的VC。
* 生成或编辑日历事件。推荐使用EventKit UI框架中的VC。
* 撰写邮件或短信。推荐使用Message UI框架中的系统VC。
* 打开或预览一个文件的内容。推荐使用UIKit框架中的UIDocumentInteractionController类。
* 从用户图片库选择或拍摄照片。推荐使用UIKit框架中的UIImagePickerController类。
* 拍摄视频剪辑。推荐使用UIKit框架中的UIImagePickerController类。
  
关于如何模态化的展示、消除VC，请查看iOS VC编程指南。关于如何通过一个特殊的VC来展示界面，请查阅iOS VC目录。
## Cocoa Touch Frameworks
以下段落对Cocoa Touch层的框架以及提供的服务进行了介绍。
### Address Book UI Framework(地址簿UI框架)
本框架对外暴露OC代码接口，你可以调用它来展示系统界面，并可在展示的界面中新增联系人，编辑和选定已经存在的联系人。本框架简化了从你的app中展示联系人相关信息的大量工作，并且确保了其它app与你的app使用的都是同样的接口，从而保证了平台的一致性。  
有关如何使用本框架的类和使用方法，请参阅iOS地址簿编程指南，以及iOS地址簿UI框架参考。
### EventKit UI Framework(活动事件UI框架)
活动事件UI框架提供了标准的系统界面展示、编辑日历相关的事件。本框架基于事件相关的数据进行封装的，详情请参阅Event Kit Framework。  
有关本框架的更多类和方法信息，请参阅活动事件UI框架参考。
### GameKit Framework(游戏相关框架)
游戏相关框架实现了对游戏中心的支持，这能够让用户在线分享他们与游戏相关的信息。游戏中心提供了以下功能支持：  

* Aliases（别名化），让用户能够在线生成他们定制的人物角色。用户登陆到游戏中心，与其它的用户通过自己的网名来匿名的交流。玩家可以发送状态信息给那些他们标记为朋友的玩家。
* Leaderboards（排行榜），能够让你的app发送玩家的积分到游戏中心，并能够检索到该积分。你可以使用该功能展示你app中所有的最高分用户。
* Matchmaking（对垒），能够让登陆到游戏中心的在线用户进行多人对战。玩家无需在现实中也参与到多人对战中。
* Achievements（成绩单）能够让你记录你app的玩家在你的app中的进度。
* Challenges（挑战）能够让玩家与另一个好友玩家进行积分或成就的比拼（iOS6及以后更高版本支持）
* Turn-based gaming，能够生成将状态信息存储在iCloud中的拉锯战。
  
有关如何使用游戏相关框架，请参阅游戏中心编程指南以及游戏相关框架参考。
### iAd Framework(广告框架)
广告框架能够让你实现基于横幅图片展示的广告。广告以标准控件展示，这使得你能够随意的按照你的意愿展示你的用户界面。这些控件与苹果的广告服务器交互，并且已经将处理副文本的广告媒体加载、展示和响应广告的点击等功能封装好以供你调用。  
想了解更多如何在你的app中使用广告，请参阅广告编程指南以及广告框架参考。
### MapKit Framework(地图框架)
地图框架提供了一张能够随意移动的地图，让你能够将其嵌入你app的用户界面。除了提供基本的地图展示功能，你还可以通过框架提供的接口对地图界面以及展示进行定制。你可以使用大头针对感兴趣的位置进行标注，你还可以使用覆盖物点缀地图上的区域。例如，你可以使用覆盖物去绘制公共汽车线路，或者高亮标注附近的商店和宾馆。  
除了展示地图之外，地图框架与苹果的地图服务器相结合，使得导航更为容易。任何支持导航的app都可以将系统自带的地图app设置为代理。例如地铁线路导航这种提供特殊导航功能的app，可以在使用导航功能前就进行注册。app还可以想苹果的服务器请求步行或驾驶的导航信息，合并到他们自定义的导航信息中，来提供完整的点到点的用户体验。  
想了解更多地图框架的类，请参阅定位和地图编程指南，以及地图框架参考。
### Message UI Framework(短信UI框架)
短信UI框架为email和短信服务提供了支持。它由一个模态化展示在你的app中的VC界面构成。你可将邮件接收者、主题、内容以及任意的附件或你想包括在信息当中的内容都展示在这个VC中。当这个VC被展示出来后，用户在发送信息前可以通过该界面对信息进行编辑。  
想了解更多短信框架的类，请查阅短信UI框架参考。想了解更多如何使用该框架的类，请查阅iOS系统短信编程话题。
### Notification Center Framework(通知中心框架)
通知中心框架为生成在通知中心中可以浏览的小工具提供了支持。  
想了解更多如何生成通知中心小工具的相关信息，请查阅app扩展编程指南以及通知中心框架参考。
### PushKit Framework(推送框架)
PushKit为网络电话的app提供了注册支持。该框架替换了早期的网络电话app。想了解更多该框架的接口信息。与以往长链接造成的增加用户设备电量流失不同，当有电话接入时，你的app可以使用本框架来接收推送信息。请查阅该框架的头文件。
### Twitter Framework（社交分享框架）
Twitter框架已被社交分享框架取代，该框架能够通过Twitter服务器提供生成推文以及URL地址。想了解更多信息，请查阅：Social Framework
### UIKit Framework（UI基础框架）
UI基础框架提供了重要的基础框架来实现iOS设备上图文事件驱动的app，包括以下几个方面：  

* 基本的app管理以及基本构造，包括app的主进程
* 用户界面的管理，包括故事版和nib文件的相关支持
* 为你的用户界面相关内容封装VC模版
* 使用对象来展示标准的系统自带View和Control控件
* 支持触碰以及基于手势的事件的处理
* 支持包含iCloud集合的文档模型，相关文档：iOS基于文档的app编程指南
* 制图以及窗口支持，包括连接外部设备的展示，相关文档：iOS View编程指南
* 多任务支持，相关文档：多任务
* 渲染支持，相关文档：iOS绘图和渲染指南
* 支持自定义标准控件
* 支持文本和web内容
* 支持剪切、拷贝以及粘贴
* 支持用户界面内容的动画操作
* 可以通过URL scheme以及框架接口与系统中的其它app进行通信
* 无障碍选项，可以帮助残障人士
* 支持苹果推送服务，参阅：苹果推送服务
* 本地通知日程和交付，参阅本地通知
* PDF格式的文档生成
* 使用系统的键盘进行输入
* 定制化输入框，并使用系统键盘进行交互
* 通过email，twitter，FB以及其它服务来分享内容

除了提供基本的框架代码用来构建你的app之外，UIKit还提供了一些系统特有的功能，例如：  

* 内置的摄像头
* 用户的图片库
* 设备名称以及模型数据
* 电池状态信息
* 近距离传感器（近场传输）
* 通过附赠的耳机进行远程控制

有关UI基础框架更多类的介绍，请参阅UIKit Framework Reference。  

# Media Layer（媒体层）
媒体层包含了图形、音频和视频技术，你可以使用这些技术来实现你app的多媒体功能。使用这个层级的技术会增加你的app的视觉听觉体验。  
## Graphics Technologies （图形技术）
高质量的图片对所有的app来说都是很重要的一方面，iOS系统提供了很多的技术来帮助你来将它们显示在屏幕上。iOS图形技术提供很广泛的支持，与UIKit层的view结构无缝衔接来交付内容。你可以直接使用标准的view控件来交付高质量的界面，或者你也可以使用任何列表2-1中的技术来自定义你的view，使之更富有图片感。  

**列表2-1 iOS中的图片技术**  

| 技术名称  | 描述 |
|:------------- |:---------------:|
| UIKit graphics |UIKit定义了高层级的API以供支持图片的绘制以及贝塞尔曲线和view的动画的展现。此外，还提供了实现绘图的支持，UIKit中的view控件提供了一种快速有效的方式来渲染图片和基于文字的内容。view还可以支持动画，直接使用UIKit动力学框架可以提供更好的交互和反馈效果。 想查看更多UIKit框架相关信息，请参看UIKit框架参考。|
| Core Graphics framework |Core Graphics (又名Quartz)是为iOS app提供主要绘图渲染的引擎，并且提供了定制的2D矢量图和基于图片渲染的支持。尽管性能不及OpenGL ES渲染的更为迅速，该框架更为适合你用来渲染定制的2D图形和动态图片。想查阅更多信息，请参阅Core Graphics框架|
| Core Animation |Core Animation (Quartz Core框架的一部分)是优化你的app动画体验的基础技术。UIKit中的view使用Core Animation提供view层级的动画支持。当你想要更好的控制动画的行为时，你可以直接使用Core Animation。想查看更多信息，请查阅Quartz Core框架 |
| Core Image |Core Image对于操纵视频以及存储图片用一种更无损的方式提供更高级的支持|
| OpenGL ES and GLKit |OpenGL ES使用硬件加速接口对2D和3D提供更高级别的渲染。该框架一般被游戏开发者使用，或者想实现沉浸式图片渲染体验的开发者。该框架给予你对渲染的完全控制权，并且提供了想要实现丝滑般动画所需的帧率控制。想查更多信息，请查阅OpenGL ES框架。GLKit提供了一组OpenGL ES的OC级别的面向对象封装，想了解更多信息，请查阅GLKit框架|
| Metal |Metal通过A7 GPU提供了极低开销，但是极高能力去渲染图片和计算工作。Metal消除了很多性能瓶颈，例如传统图形API中计算代价高昂的状态确认。想了解更多信息，请参阅Metal框架|
| TextKit and Core Text |TextKit与UIKit的关联类库，它提供了文字排版和文字管理的很好的功能。如果你的app需要比较高级的文字操作的话，TextKit为view提供了无缝集成的API以供调用，想了解更多信息，请参阅TextKit框架。Core Text是底层的基于C的一套框架，使用它可以更好的控制排版和布局。想了解更多信息，请参阅Core Text框架。|
| Image I/O |Image I/O提供了读写大部分格式图片的接口。想了解更多信息，请参阅Image I/O看看框架。|
| Photos Library |Photos和PhotosUI两个框架使用用户图片、视频和多媒体的接口。在你想整合用户自己的内容到你的app中时，你可以使用该框架。想了解更多信息请参阅Photos和PhotosUI两个框架。|

iOS对运行在高清分辨率或者标准分辨率的app都提供内置的支持。对于基于矢量的绘制，系统的框架会自动的使用高清显示的额外像素去提升你的内容的顺滑感。如果你在你的app中使用图片的话，UIKit对于加载高清版本的图片自动提供支持。想了解更多如何支持高清屏幕的信息，请参见iOS app编程指南中的**app资源相关内容**  
## Audio Technologies（音频处理技术）

iOS音频技术与底层的硬件合作，为用户提供了丰富的音频体验。这些体验包括能够播放和录制高质量的音频，控制MIDI内容，以及与系统内置的声音进行交互。  
如果你的app使用到了音频的话，有以下几种技术你可能会用到。列表2-2中的框架描述了你可能用到的情况。

**列表2-2 iOS中的音频技术**  

| 技术名称  | 描述 |
|:------------- |:---------------:|
| Media Player framework |这个高层级的框架提供了封装简单的接口，可以用来访问用户的iTunes库以及播放音乐和专辑。当你想将音频整合进你的app，并且不太关心这些音频的回放行为的话，你应该使用这个框架。想了解更多信息，请参阅Media Player框架。|
| AV Foundation |AV Foundation是一套OC封装的管理音视频录制和回放的框架。当你录制音频或者想要更细粒度的控制音频回放进程的话，请使用这个框架。想了解更多信息请参阅AV Foundation框架|
| OpenAL |OpenAL是一套工业标准的技术，用来交付定制化的音频。游戏开发者会经常使用到这些跨平台的技术来产出高质量的音频。想了解更多信息，请参阅OpenAL 框架|
| Core Audio |Core Audio的接口既有简单又有复杂的，你可以使用这些接口来录制以及回放音频和MIDI文件。该框架是为那些想从更细粒度去控制音频的高级开发者准备的。想了解更多信息，请参阅Core Audio。|

iOS 支持很多工业标准以及苹果设备上的特殊格式的音频，包括以下这些：

* AAC
* Apple Lossless (ALAC)
* A-law
* IMA/ADPCM (IMA4)
* Linear PCM
* µ-law
* DVI/Intel IMA ADPCM
* Microsoft GSM 6.10
* AES3-2003

## Video Technologies (视频处理技术)
iOS视频处理技术对你的app中的静态视频内容以及网上的视频流的回放提供支持。对于能够录制视频的硬件设备，你还可以将录制视频的功能融入你的app。列表2-3列出了视频录制和回放相关技术。  

**列表2-3 iOS中的视频技术**  

| 技术名称  | 描述 |
|:------------- |:---------------:|
| UIImagePickerController | UIImagePickerController 是UIKit中的一个VC，用来选择用户的多媒体文件。你可以使用该类展示用户已经存在的照片、视频或让用户拍摄新的内容。想了解更多内容，请查阅iOS摄像头编程话题。|
| AVKit |AVKit框架提供了一组容易入手的接口来展示视频。对于全屏幕或部分屏幕播放视频以及回放功能，该框架都能很好的支持。想了解更多信息，请参阅AVKit框架。|
| AV Foundation |AV Foundation提供了视频播放和录制更高级的功能。在你想更好的控制视频展示和录制的情况下，可以使用这个框架。例如，增强现实类的app可以使用该框架与其他app提供的内容进行实时展示。想了解更多信息，请参阅AV Foundation框架。|
| Core Media |Core Media框架定义了一套底层接口数据类型来操作多媒体数据。大多数情况下你无需直接使用这个框架，单数如果你觉得无法更好的控制你的视频内容时，可以使用该框架。想了解更多内容，请查阅Core Media框架。|

iOS支持很多工业标准的视频以及压缩标准，包括以下：  

* H.264硬编码的视频，最高支持1.5Mbps，640*480像素，30帧／秒，基于低复杂度版本的H.264基本描述的AAC-LC，160 Kbps, 48 kHz, 立体声支持 .m4v, .mp4, 以及 .mov等格式。  
* H.264硬编码的视频，最高支持768Kbps，320*240像素，30帧／秒，最低支持 1.3级 AAC-LC 音频支持 160 Kbps, 48 kHz, 立体声支持 .m4v, .mp4, 以及 .mov等格式。
* MPEG-4格式的视频，最高支持2.5Mbps，640*480像素，30帧／秒，AAC-LC基本支持 160 Kbps, 48 kHz, 立体声支持.m4v, .mp4, and .mov等格式。
* 多种音频格式，包括在**音频相关技术**的列表中

## AirPlay (无线播放技术)
AirPlay技术能够让你的app中的音视频流通过Apple TV与第三方的接受者或播放者链接。AirPlay由大量的框架构成，UIKit、Media Player、AV Foundation、Core Audio等，所以大部分情况下，你几乎什么都不需要做就能够使用。任何你使用这些框架播放的内容都自动的经过Airplay发布认证。当用户选择使用Airplay播放你的内容时，系统会自动的接管。  
iOS还提供以下额外选项支持使用Airplay传送数据：  

* 扩展显示iOS设备上的内容，额外创建一个window对象，并赋值给任何通过Airplay链接到设备的UIScreen对象。当你的iOS设备上展示的内容与附加的屏幕上展示的内容不一致时，可以使用这项技术。
* Media Player框架中的回放相关的类自动支持AirPlay功能。你还可以使用Airplay播放当前正在播放的内容到Apple TV上。
* 使用AV Foundation框架中的AVPlayer类来管理你app中的音视频内容。当用户准许时，使用这个类可以将流量内容经由AirPlay播放。
* 对于基于网络的音视频，你可以在airplay属性中添加一个embed标签来标注，使得这些内容经由airplay播放。UIWebView类同样支持在AirPlay上使用媒体的回放功能。

想了解如何你的app中使用Airplay，请参阅Airplay概览。

## Media Layer Frameworks (多媒体层相关框架)
以下段落对媒体层和它们提供的服务进行了阐述。  
### Assets Library Framework (资源库框架)
AssetsLibrary.framework提供了由用户设备上照片app管理的音视频接口。使用该框架可以访问用户保存的图片集或任何倒入设备的专辑。你还可以保存新的音视频到用户的图片库中。  
想查看更多的关于该框架的类和方法，请查阅资源库框架参考。
### AV Foundation Framework
AVFoundation.framework提供了OC封装的接口，可以用来播放、录制和管理音视频内容。使用该框架可以将多媒体功能无缝的介入你的app界面中。你还可以使用该框架对媒体更好的控制。例如，你可以使用该框架播放多条音频，或者控制回放和录音过程的多个方面。  
该框架提供的服务包含以下方面：  

* 管理Audio session，包含向系统注册你的app具有音频能力
* 管理app的媒体库
* 支持编辑媒体内容
* 拍摄音视频能力
* 回放音视频能力
* 音轨管理
* 媒体项元数据管理
* 立体声管理
* 声音之间的精准同步
* OC封装的接口展示声音文件的属性细节，例如数据格式类型，采样率，以及信道个数
* 通过Airplay传递的流媒体

想了解更多有关AV Foundation的信息，请参见AV Foundation编程指南。有关AV Foundation框架的类文件，请参见AV Foundation框架参考。

### AVKit Framework
AVKit.framework利用AV Foundation框架中的对象来管理设备上视频的展示效果。当你想展示视频内容时，你可以将其当作Media Player库的替代品。  
想了解更多关于该框架的信息，请参看其头文件。
### Core Audio
Core Audio是一组框架的集合（列表2－4），它提供了对音频的原生控制。这些框架支持在你的app中生成、录制、混淆以及播放音频。你还可以使用这些框架操纵MIDI媒体内容或流媒体或MIDI内容到其它的app中。  
**列表2-4 Core Audio框架**  

| 框架名称  | 提供的服务 |
|:------------- |:---------------:|
| CoreAudio.framework | 通过CoreAudio定义音频数据类型。了解更多信息请查阅CoreAudio框架参考 |
| AudioToolbox.framework | 为音频文件和音频流提供回放以及录制服务。该框架还提供管理音频文件，播放系统警告声音以及触发某些设备的震动等功能。更多信息请参见AudioToolbox框架参考。 |
| AudioUnit.framework | 为使用内置的音频单元提供服务，即音频处理模块。该框架还提供将你的音频以组件的形式显示给可见的其它app。更多信息请参阅AudioUnit框架参考。 |
| CoreMIDI.framework | 提供一种标准的方式与MIDI设备交互，包括键盘和合成器。你可以使用该框架发送或接收MIDI信息，或者与周边的MIDI设备通过基于iOS的设备使用dock转接头或网络进行沟通。更多信息请参见CoreMIDI框架参考。 |
| MediaToolbox.framework | 提供audio tap相关接口 |

想了解更多关于Core Audio的信息，请参看Core Audio概览。想了解如何使用Audio Toolbox 框架播放音频，请参看Audio Queue Services编程指南。

### CoreAudioKit Framework
CoreAudioKit.framework提供了标准的view来管理app之间共享的的音频。一个view上显示其他链接的app的icon，另一个view上显示传输的控制，用户可以使用它来操纵由主app提供的音频。  
更多框架中的接口相关信息请参阅框架中的头文件。
### Core Graphics Framework
CoreGraphics.framework包含了Quartz 2D绘制的API接口。Quartz是OS X上一个高级的基于矢量绘制的引擎。它支持基于路径的绘制，抗锯齿渲染，渐变的，图片类型的，颜色类型的，坐标系转换以及PDF生成，展示和解析。尽管接口是C语言的，但是它经过基于对象的封装来展示呈现基本的绘制对象，使得存储和重用你的图形内容更为容易。  
更多如何使用Quartz来绘制内容的信息请查阅Quartz 2D编程指南以及Core Graphics框架参考。
### Core Image Framework
CoreImage.framework提供了一组强大功能的嵌入式滤镜，用来操作视频以及静态图片。你可以使用这套嵌入式的滤镜来润色或修正脸部图片、特写以及二维码扫描。这套滤镜的优势是它们以一种无损的方式操作，而不是直接操作你的原图，这使得原图毫无改变。这是因为这套滤镜是基于底层硬件优化的，这样更快并且有效率。  
更多有关滤镜的类和信息请参见Core Image框架。
### Core Text Framework
CoreText.framework提供了一套简单但是高性能的基于C封装的接口，你可以用它来对文字进行布局以及控制字体。那些不想使用TextKit但又相对文字处理能力要求很高的app可以使用这个框架。这套框架提供了一套复杂的文字布局引擎，包括文字环绕能力。它还支持高级的使用多种字体和渲染属性的文字样式。  
更多有关CoreText接口的信息，清参阅CoreText编程指南以及CoreText参考集合。
### Core Video Framework
CoreVideo.framework提供了缓冲以及缓冲池来支持Core Media框架（Core Media框架中提及）。大部分的app都不用直接使用这个库。
### Game Controller Framework
GameController.framework让你能在你的app中发掘和配置为iPhone／iPod／iPad制作的GameController类的硬件。GameController可以设备之间进行物理连接或者通过蓝牙无线连接。当有VC可用的时候GameController框架会通知你的app，并且指定哪个VC作为你的app的输入源。  
更多关于GameController的信息，请参阅GameController编程指南。
### GLKit Framework
GLKit.framework包含了一套基于OC的实用工具类，它大大简化了生成一个OpenGL ES app的工作量。GLKit支持app开发的四个关键方面：  

* GLKView 和 GLKViewController提供了一个OpenGL ES化的view的标准实现，并且与渲染循环相关联。这个view替你的app管理着底层的帧缓存区对象，你只需要在它上面进行绘制即可。
* GLKTextureLoader类为你的app提供图片的转换以及加载程序，使用它能够自动的加载纹理图片到你的上下文中。它能够进行同步或异步的加载图片。在异步加载的情况下，当纹理加载完到你的上下文中时，你的app要提供一个block以供完成时回调。
* GLKit框架提供矢量、矩阵以及四元体的实现，和矩阵的堆栈操作一样，提供相同的函数功能在OpenGL ES 1.1中。
* GLKBaseEffect, GLKSkyboxEffect和GLKReflectionMapEffect提供了已经存在的，可配置的图片着色器，它实现了通用的图片操作。特别是GLKBaseEffect类实现了OpenGL ES 1.1标准中提到的高亮和材料模型功能，大大简化了从 OpenGL ES 1.1迁移到 OpenGL ES新版本的工作量。

更多GLKit相关信息，请参阅GLKit框架参考。

### Image I/O Framework
ImageIO.framework提供了导入导出图片数据以及图片元数据的接口。该框架利用了所有在iOS中的 Core Graphics数据类型和函数，以及所有可用的标准图片类型。你还可以使用这个框架访问图片的Exif和IPTC等元数据属性。   
更多关于该框架的函数和数据类型信息，请参见 Image I/O参考集合。
### Media Accessibility Framework
MediaAccessibility.framework管理着你的媒体文件中的隐藏字幕的内容展示。该框架与设置共同管理着字幕的隐藏与显示工作。  
更多关于MediaAccessibility内容的信息，请参见该框架的头文件。
### Media Player Framework
MediaPlayer.framework为你的app播放音视频内容提供了高层级的支持。你可以使用该框架做以下事情：  

* 在用户的屏幕上播放视频或者通过AirPlay在其它设备上播放。你可以选择全屏或部分屏幕播放。
* 访问用户的iTunes音乐媒体库。你可以播放音频或者专辑，搜索歌曲，为用户展示媒体选择器界面。
* 配置和管理影片的回放。
* 显示正在播放的影片的信息到锁定屏幕上以及展示app切换界面。当内容通过AirPlay传输时，你还可以展示这些信息到Apple TV上。
* 检测视频内容已经通过AirPlay传输的状态。

更多MediaPlayer类的信息，请参见MediaPlayer框架参考，更多如何使用这些类来访问用户的iTunes媒体库，请参见iPod媒体库访问编程指南。
### Metal Framework
Metal通过A7 GPU卓越的高性能提供了极低开销但极高渲染和计算能力。Metal消除了很多的性能瓶颈，例如消耗巨大的状态确认，这在传统的图形API中是开销很大的。Metal旨在将高开销的状态转换以及编译操作与高消耗的敏感的关键路径计算渲染代码分离开。Metal提供了预编译着色，状态对象，以及明确的命令调度来确保你的app为GPU图片和计算任务提供最大的功效。这一设计原则延伸至过去你用来构建你的app所使用的工具上。当你的app构建时，Xcode将工程中的Metal着色对象编译至一个默认的库中，以减少这些着色对象在运行时的开销。  
制图、计算以及位传递命令被有效的无缝的结合起来工作。Metal被特别设计用来开发构建现代的架构，例如多任务处理、共享内存等，将这些与GPU的命令生成并行。  
使用Metal，你将会得到流式的API、统一的绘图和计算纹理的语言，以及基于Xcode的工具，所以你无需学习更多的框架、语言以及工具就能最大限度的为你的app或者游戏利用GPU。  
更多关于如何使用Metal，请参见Metal编程指南，Metal框架参考，以及Metal纹理语言指南。
### OpenAL Framework
开源音频资源库（简称OpenAL）接口是一组跨平台的标准交付音频接口。你可以使用该框架在需要定位音频输出的游戏或者其他程序中实现高性能、高质量的音频。由于OpenAL是一套跨平台的标准，你使用OpenAL在iOS上所编写的代码模块可以很容易的一知道其他平台上。  
更多有关OpenAL的信息，包括如何使用，请参见：http://www.openal.org
### OpenGL ES Framework
OpenGLES.framework提供接口来绘制2D和3D内容。这是一套基于C的框架，它与底层设备硬件合作，提供细颗粒度的图片控制以及高帧率的全屏幕沉浸式体验，例如游戏类app。你可以将OpenGL ES框架与EAGL接口结合使用，这在OpenGL ES 绘制回调和UIKit的窗口对象中提供接口。  
该框架支持OpenGL ES 1.1，2.0和3.0版本。规范2.0版本添加了碎片化和顶点着色功能，规范3.0版本添加了更多的功能，包括多重目标渲染以及转换反馈。  
更多如何在你的app中使用OpenGL ES，参见OpenGL ES编程指南。有关参考信息，请参见OpenGL ES 框架参考。
### Photos Framework
Photos.framework提供了一组新的API与照片和视频库进行交互，包括iCloud图片库，这些都是由“照片”app管理的。这个框架是替代资源库框架的更好的选择。核心功能包括线程安全的加载和缓存缩略图和全尺寸图片的架构，请求更改资源库，检测被其他app变更的资源项，以及恢复资源库的编辑内容等功能。  
更多有关该框架接口等相关信息，请查看Photos框架参考。
### Photos UI Framework
PhotosUI.framework让你能够在照片app中生成app扩展来编辑图片和视频资源。更多信息关于如何生成图片编辑扩展，请参阅app扩展编程指南。
### Quartz Core Framework
QuartzCore.framework包含了Core Animation的相关接口。Core Animation是一套高级影像合成技术，它使得生成基于view的动画这个过程变得高速且有效。影像合成引擎利用底层的硬件高效且实时的操纵你的view的内容。你只需要指定动画开始和结束的两个时间点，其他的由Core Animation去做就好了。由于Core Animation是嵌入到UIView的底层架构中的，所以它是一直可用的。  
更多如何在你的app中使用Core Animation的相关信息，请查看Core Animation编程指南以及Core Animation参考集合。
### SceneKit Framework
SceneKit是一套OC的框架，使用它能够构建简单的游戏以及使用3D效果丰富app的用户界面，这是一套结合了高性能渲染的引擎以及高层级的描述性的API。SceneKit在OS X 10.8版本上可用，现在在iOS上首次可用。底层的API（例如OpenGL ES）需要你去实现一套渲染算法，并且以一种严格的细节来展示一个场景。相比之下，SceneKit让你基于内容描述你的场景，通过几何结构、材料、彩光、摄像头等对象改变的描述来使得场景更为鲜活。  
SceneKit的3D物理引擎使用模拟重力、压力、刚性碰撞、连接等功能使得你的app或游戏更为鲜活。也使得添加以下高等行为更为容易，例如在场景中添加一辆汽车，或者为在一个场景中的对象添加支持半径重力的物理区域，电磁场或者干扰因素。  
使用OpenGL ES为一个场景添加一个额外的渲染内容，或者提供光影反射来替代或者增加SceneKit的渲染。你也可以添加基于着色的加工技术到SceneKit的渲染中，例如颜色分级或者屏幕区域的环境遮蔽。  
更多关于该框架的接口，请参见SceneKit框架参考。
### SpriteKit Framework
SpriteKit.framework为2D和2.5D的游戏提供了硬件加速动画。SpriteKit为大部分游戏提供了基础功能，包括图片渲染，动画系统，声音回放支持，物理模拟引擎。使用SpriteKit将你从自己创建事物中解放出来，并且让你能够将精力集中在设计你的内容以及高水平的交互上。  
在SpriteKit开发的app中，内容是被组织称为场景的。场景会包括有纹路的对象、视频、基于路径的形状，核心图片过滤，以及其他特殊效果。SpriteKit将持有这些对象，并且决定如何以最高效的方式将其渲染到屏幕上。当到了你的场景动画渲染时间时，你可以使用SpriteKit指定显示的你想表达的内容或者使用物理模拟引擎来为你的对象定义物理行为（例如重力，引力，排斥等）。
除SpriteKit框架之外，还有Xcode提供的工具来生成颗粒状的发射效果以及纹理地图集。你可以使用Xcode工具来管理app的资源，快速更新SpriteKit场景。
更多关于如何使用SpriteKit的信息，清参阅SpriteKit编程指南。有关如何使用SpriteKit构建一个app的示例，请查看代码：Explained Adventure。
# Core Services Layer（核心服务层）
核心服务层为app提供基础的系统服务。在这些服务中最重要的是Core Foundation 和 Foundation 两个框架，这两个框架定义了所有app需要用到的基本类型。这个层级的服务业包含一些单项技术支持，例如定位、iCloud、社交媒体以及网络层等。
## High-Level Features（高级功能）
以下段落介绍了一些核心服务层可用的高级功能。
### Peer-to-Peer Services (P2P服务)
多点链接框架通过蓝牙技术提供了P2P的连通。你可以使用P2P连接技术实现与近场设备进行通信会话。尽管P2P连接一般用在游戏中，你依旧可以将这一功能用在其他类型的app中。  
更多关于如何在你的app中使用P2P连接功能，请参见多点链接框架参考。
### iCloud Storage （iCloud存储）
iCloud存储技术能够让你app在一个集中的地方写入用户的数据和文档。用户能够通过他们的电脑或者iOS设备访问这些数据。使用iCloud能够让用户的文档无所不在，这意味着用户能够从任何他们的设备访问或者编辑这些文档，而无需同步或者传输这些文件。在用户的iCloud账户中保存文档还为用户提供了更多一层保护。即使用户丢了一台设备，只要文档在iCloud中存储了文档，那么这些文档就不会丢失。  
有两种方法能够使用iCloud存储，每一种都有不同的使用方式：  

* iCloud文档存储。使用这个功能能够将用户的文档和数据存储到iCloud账户中。
* iCloud key-value数据存储。使用这个功能能够在你app的实例对象中共享一小部分数据。
* CloudKit存储。当你生成公开的文档或者需要管理数据的传输时，你可以使用这个功能。

大部分app通过用户的iCloud账户来使用iCloud文档存储分享文档。（这是个用户想到iCloud存储就能够知晓的功能）用户比较关心哪些文档通过设备被分享了以及通过一个给定的设备他们能够看到并且管理这些文档。与此相反，iCloud key-value数据存储是用户看不到的。这反而是你的app中分享小量数据（几十KB左右）到其他实例变量的一种方法。app应该使用这个功能来存储一些非重要的数据，例如参数配置等。  
关于如何将iCloud整合进你的app中的概览，请查看iCloud设计指南。

### Block Objects (Block对象)
Block对象是一套C语言的数据结构，你可以将它并入你的C或OC代码中。一个block对象本质上来说就是一个匿名的函数，并且本身是携带数据的，在一些其他的编程语言中，有时这被称作closure或者lambda。block通常被用在回调或者在代码执行和关联数据的地方使用。  
在iOS中，block通常用在以下几种情景下：  

* 作为delegate或者delegate方法的替代品
* 作为回调函数使用
* 作为一次性的操作的实现体
* 为一个集合中的所有元素执行一项任务
* 与队列一起使用，执行异步任务等

对于block对象的介绍以及使用，请参见“一篇简短的block使用手册”。更多关于block的信息，请参见block编程主题。

### Data Protection （数据保护）
数据保护允许app利用一些设备中内置的加密机制来处理一些用户的敏感信息。当你的app标记一个特殊的文件需要保护时，系统会以一种加密的格式来存储那个文件到硬盘上。当设备锁定的时候，该文件对于你的app或者任何潜在的入侵者来说，都是无法访问的。但当设备被用户解锁后，你的app会得到一个生成的解码密钥来访问该文件。你也可以使用其他层的数据保护方式。  
实现数据保护机制要求你对于如何生成和管理你需要保护的数据要很清楚。app必须被设计成在数据生成的时候就能得到保护，并且在用户锁定或者解锁设备的时候准备好接受数据的改变。  
更多关于如何添加保护的数据到你的app中，请参见iOS app编程指南。
### File-Sharing Support (文件分享支持)
文件分享支持功能能够让app在iTunes 9.1以及更高版本中管理用户的数据文件。若一个app声明对于文件分享支持的话，那么`/Documents` 目录对于用户就是可用状态了。用户可以通过iTunes对于这个目录下的文件写入或者导出。这个功能并不能够让你的app与同一设备上的其他app共享文件，想共享文件的话，需要剪贴板或者文档交互管理对象才行。  
想要在你的app中支持分享文件功能的话，你需要做到以下几点：  

* 添加UIFileSharingEnabled key到你的Info.plist文件中，设置value为YES。
* 将你想要分享的文件放置在Documents目录下。
* 当用户将设备连接到电脑上时，iTunes会在选定的设备的App这个标签中展示文件分享部分。
* 用户可以添加文件到这个目录或者移动文件到桌面上。

当有文件添加到Documents目录下时，支持分享功能的app应该能够识别到，并且在适当的时机反馈。例如，你的app应该在界面上展示任何新添加的可用文件。永远不要在这个目录下给用户列出一堆文件，然后让他们决定应该怎么处理这些文件。  
更多关于UIFileSharingEnabled这个key的信息，请参见属性key列表信息相关参考。

### Grand Central Dispatch (GCD)
GCD是一套BSD级别的技术，你可以用它来管理你app中的任务执行。GCD提供了一套异步的编程模型，它高度优化了CPU核心，提供了简洁高效的支持，你可以用它来替代线程管理。GCD同样为很多底层的任务提供了简洁的替代品，例如读写文件操作符，实现timer，以及检测信号量和过程事件。  
更多关于如何在app中使用GCD，参见并发编程指南。更多关于GCD函数的使用，参见GCD参考。
### In-App Purchase (应用内支付)
应用内支付功能让你能够在你的app中出售特定的内容和服务，或者iTunes内容。这个功能应使用StoreKit框架实现，该框架能够让你通过用户的iTunes账户来发生金融相关的交易。你的app应处理所有交易的用户体验和服务展现内容。对于可下载的内容，你可以自己设置主机管理，或者由Apple来为你提供服务。  
对于支持应用内支付的相关信息，请查看应用内支付编程指南。关于StoreKit的额外信息，请参见StoreKit框架。
### SQLite
SQLite库能够让你嵌入一个轻量级的SQL数据库到你的app中，而无需运行一个分离的远程服务器数据库进程。在你的app中你就可以生成本地数据库文件，管理表以及记录到这些文件中。虽然这个库是通用设计的，但是依然经过优化了，并且提供快速访问数据库内容的能力。  
访问SQLite库的头文件存放在`<iOS_SDK>/usr/include/sqlite3.h`目录中，`<iOS_SDK>`代表你Xcode安装的target SDK目录。更多如何使用SQLite的相关信息，请查看SQLite软件库。
### XML Support（XML支持）
Foundation框架提供了NSXMLParser类来检索XML文档中的元素。并且由**libxml2**库提供操作XML内容的支持。这个开源的类库能够让你快速的解析或写入任意的XML数据，并且能够转换XML内容到HTML。  
访问libxml2库的头文件存放在`<iOS_SDK>/usr/include/libxml2/`目录下，`<iOS_SDK>`代表你Xcode安装的target SDK目录。更多关于如何使用**libxml2**库的信息，请查看libxml2文档。
## Core Services Frameworks (核心服务层相关类库)
以下章节描述了核心服务层以及它提供的服务。
### Accounts Framework (账户)
Accounts.framework为用户提供了一个单点登录的模型。单点登录提升了用户体验，它减少了用户多个账户的必要性。并且它为你简化了开发模型，你可以用它来管理账户的授权过程。你可以与社交框架一起使用这个框架。  
更多关于Accounts框架的信息，请参见Accounts框架参考。
### Address Book Framework （地址簿)
AddressBook.framework为程序提供了访问用户通讯录数据库的权限。如果你的app使用到了联系人相关的信息的话，你可以使用这个框架来访问和修改相关信息。例如，一个聊天类的app可能用这个框架来检索可能的联系人列表，并且生成一个聊天对话，然后把这些联系人展示在一个自定义的界面上。  
> 重要：访问用户的通讯录数据需要显示的向用户索取允许权限。因此app必须对于用户拒绝访问时有所准备。app最好在Info.plist文件中阐述为何需要访问通讯录的原因。  

更多关于地址簿框架的函数信息，请参见地址簿框架参考。

### Ad Support Framework （广告）
AdSupport.framework框架提供一个有广告需求的app使用的标识。该框架还会为用户是否退出了广告追踪提供一个标记。app需要在访问广告标识之前读取这个标记。  
更多关于该框架的信息，请查看AdSupport框架参考。
### CFNetwork Framework
CFNetwork.framework是一套高性能的使用面向对象抽象的基于C语言的接口，使用它来与网络协议交互。这些抽象让你能够通过协议栈来控制，并且使得使用底层的结构（例如BSD sockets）更为简单。你可以使用该框架简化各种操作，例如与FTP和HTTP服务器的交互，或者解决DNS主机方案。使用CFNetwork框架，你可以：  

* 使用BSD sockets
* 使用SSL或者TLS生成加密连接
* 提供DNS主机方案
* 与HTTP服务器交互，验证HTTP服务器以及HTTPS服务
* 与FTP服务器交互
* 发布、解决、浏览Bonjour服务

CFNetwork无论从理论还是物理上都是基于BSD sockets的。更多关于如何使用CFNetwork的信息，请查看CFNetwork编程指南以及CFNetwork框架参考。

### CloudKit Framework
CloudKit.framework为你的app和iCloud之间传输数据提供了支持。不像iCloud技术传输数据那么明显，CloudKit在传输发生的时候给予你控制权。你可以使用CloudKit管理所有数据类型。  
使用CloudKit的app能够直接将用户分享的数据存储到仓库中。这个公共的仓库是与app本身捆绑的，即使设备没有已经注册的iCloud账户都是可用的。作为app的开发者，你可以直接从这个容器中管理数据，并且能够从CloudKit提供的操作界面中看到所有用户做出的修改。  
更多关于该框架的类的信息，请查看CloudKit框架参考。
### Core Data Framework
CoreData.framework是一套管理MVC类app的数据模型的技术。Core Data用在那些数据模型已经高度结构化的app中的。你无需编码定义数据结构，使用Xcode中的图形界面工具就可以构建展现你的数据模型。在运行时，你的数据模型的实力对象会被创建、管理并且通过Core Data变得可用。  
通过为你管理你的app的数据模型，Core Data大大减少了你的app的代码量。Core Data还提供以下功能：  

* 对于存储对象数据到SQLite数据库中进行了优化
* NSFetchedResultsController类用来管理表视图结构
* 无需基本的文字编辑就能管理撤销／重做的操作
* 支持校验属性值
* 支持增量变化以及确保对象之间的固有关系
* 支持在内存中分组、筛选和管理数据

如果你打算开发一款新的app或者打算为一个已经存在的app提供重大升级的话，你应该考虑使用Core Data。关于在iOS app中使用Core Data的示例，请查看iOS Core Data指导。更多关于Core Data类的相关信息，请查看Core Data框架参考。

### Core Foundation Framework
CoreFoundation.framework是一套基于C的接口，它为iOS app提供了基本数据管理和服务的功能。该框架包含以下支持：  

* 集合类数据（数组、集合等等）
* 捆绑包
* 字符串管理
* 日期和时间管理
* block原始数据管理
* 参数配置管理
* URL和流操作
* 线程和run loop
* 端口和socket交互

Core Foundation框架与Foundation框架紧密相关，后者提供了相同基本功能的OC封装接口。当你需要混合Core Foundation类型和Foundation对象时，你可以使用在两个框架之间存在的"toll-free bridging(桥接)"技术。桥接意味着你可以在这两个框架的方法或函数中交换数据类型。桥接支持多种数据类型，包括集合和字符串数据类型。如果有对象关联的话，不论哪个框架的类和类型描述都能桥接。  
更多关于该框架的信息，请参见Core Foundation框架参考。

### Core Location Framework
CoreLocation.framework为app提供定位和标题信息。对于定位信息，该框架利用车载GPS、移动网络或者Wi-Fi收音机查询到用户当前的经纬度。你可以将这个技术应用到你的app中，为用户提供基于位置的信息。例如，你可以提供一项查询附近宾馆、商店或者运输设施的服务，基于用户当前的位置。Core Location还提供以下功能：  

* 在包含磁力计的iOS设备上提供访问基于指南针相关信息的能力
* 基于地理定位或者蓝牙指示提供区域检索能力
* 使用移动信号塔提供低功耗的位置监控服务
* 结合MapKit框架提升特殊情况下定位数据的质量，例如在开车过程中

更多关于使用Core Location收集位置信息以及标题信息的相关信息请参见定位和地图编程指南以及Core Location框架参考。
### Core Media Framework
CoreMedia.framework通过AV Foundation框架提供了底层的媒体类型。大部分app无须使用这个框架，对于那些需要对音视频内容的创建和展示需要进行精准控制的开发者提供支持。  
更多关于该框架的函数和数据类型，请参见CoreMedia框架参考。
### Core Motion Framework
CoreMotion.framework提供了一批接口来访问所有设备上基于运动的数据。该框架对于原始数据还是经过处理的加速器相关数据都使用一套基于block的接口来支持。对于内嵌陀螺仪的设备，你可以像处理那些经过处理的数据反射属性和自转速率数据来处理原始陀螺仪数据。你可以使用加速计和基于陀螺仪等数据嵌入到你的app的运动数据中以此来提升用户体验。对于带有计步器的硬件，你可以访问那些数据并且追踪健身相关的运动。  
更多关于该框架的类和方法相关信息，参见Core Motion框架参考。
### Core Telephony Framework
CoreTelephony.framework提供接口与移动式蜂窝设备的基于电话的信息进行交互。app可以使用这个框架查询有关用户移动服务提供商的相关信息。对于网络电话相关的app，例如VoIP类的app，也可以注册相关监听信息来检测相关信息。  
更多关于如何使用该框架类和方法的信息，请参见CoreTelephony框架参考。
### EventKit Framework
EventKit.framework提供接口来访问用户设备上的日历事件。你可以使用该框架做以下事情：  

* 获取已经存在的时间，并且在用户的日历上标示
* 添加事件到用户的日历上
* 为用户添加提醒事项，并且将之显示在提醒事项app上
* 为日历事件配置提醒闹钟，包括设置何时该闹钟应该响起

`重要：访问用户的日历和提醒事项需要提前向用户申请。所以app必须要做好用户不同意该权限的准备。我们也建议在Info.plist中添加说明你为什么需要该权限。`

更多关于如何使用该框架类和方法的信息，请参见EventKit框架参考以及EventKit UI框架。

### Foundation Framework
Foundation.framework提供了诸多在Core Foundation框架中的功能的OC封装，这在Core Foundation框架中有所阐述。Foundation提供了如下功能：  

* 集合类数据（数组、集合等等）
* 捆绑包
* 字符串管理
* 日期和时间管理
* block原始数据管理
* 参数配置管理
* URL和流操作
* 线程和run loop
* Bonjour
* 连接端口管理
* 国际化
* 正则表达式
* 缓存支持

更多关于该框架类的信息，参见Foundation框架参考。

### HealthKit Framework
HealthKit.framework是一套管理用户健康相关信息的全新框架。随着app数量的增加，设备对于健康和运动相关信息的追踪，很难为用户呈现他们正在做的事情。HealthKit框架使得app分享健康相关的数据更为容易，不论该数据是从连接到iOS设备的其他设备上传输过来还是用户自己输入的。用户的健康信息存储在一个集中且安全的区域。用户可以在健康app中看到这些数据。  
若你的app实现了对于HealthKit的支持，它将会为用户访问健康相关的信息，并将这些关于用户的信息提供给用户，而无需对特定的运动设备的追踪实现支持。用户将会决定哪些数据应该从你的app中分享。一旦数据被从你的app中分享了，你的app就可以注册数据变更相关的监听；当你的app被通知到时，你将会有很细粒度的控制权。例如，你可以要求当用户检测到血压的时候通知你的app，或者仅当用户的血压达到一个特殊的值时才通知你的app。  
更多关于该框架接口的信息，参见HealthKit框架参考。
### HomeKit Framework
HomeKit.framework是一套全新的框架，用它可以与用户家中的设备进行交互和控制。新的设备将会被介绍给家庭，提供更好的连接性以及更好的用户体验。HomeKit提供了一套标注的方式与那些设备进行交互。  
你的app可以使用HomeKit和用户家中的设备进行交互。使用你的app，用户可以发现他们家中的设备并且对其进行配置。他们还可以生成行为来控制那些设备。用户可以通过Siri组织行为和激活它。一旦配置生成，用户可以邀请其他的用户分享使用该设备。例如，用户可能会临时邀请一位客人访问。  
使用HomeKit配件模拟器来测试你的HomeKitapp和设备之间的联系。  
更多关于该框架接口的信息，参见HomeKit框架参考。
### JavaScript Core Framework
JavaScriptCore.framework为很多标准的JS对象提供了一套OC包装的类。使用这个框架来评估JS代码以及解析JSON数据。  
更多该框架的类的信息，请参看该框架的头文件。
### Mobile Core Services Framework
MobileCoreServices.framework定义了一套在同一类型标示中使用的底层类型。  
更多关于这些类型的信息，请参见同一类型标示参考。
### Multipeer Connectivity Framework（多点连接框架）
MultipeerConnectivity.framework提供了发现附近的设备并且能够无需互联网就能与这些设备通讯的功能。该框架使得生成多个会话更为容易，并且支持安全的有序的数据传输和实时的数据传输。使用这个框架，你的app能够与附近的设备进行无缝的数据交换。  
该框架提供编码和基于UI的选项来发现和管理网络服务。app可以嵌入MCBrowserViewController类到UI界面展示用户选择的对接的设备列表。同时还可以使用MCNearbyServiceBrowser类来编码查看管理对接设备。  
更多关于该框架的接口信息，参看MultipeerConnectivity框架参考。
### NewsstandKit Framework（报刊框架）
报刊app提供了一个集中的地方让用户浏览杂志和报纸。希望发表杂志和报纸的出版商可以通过报刊框架来生成他们自己的iOS app，这让你能够在后台生成新的杂志和报纸的下载。当你开始下载之后，系统会管理下载的进程，并且在下载完成后通知你的app。  
更多关于如何使用报刊框架来管理下载的相关内容，参见NewsstandKit框架参考。更多关于如何推送信息导你的app，参见本地和远程通知编程指南。
### PassKit Framework （钱包框架）
Passbook app为用户提供了一个存储优惠券、登记证、票据以及银行卡的地方。用户无需将物理的上述物品放置在此，只需将他们的电子版本存储在iOS设备中就能像以往那样使用了。PassKit.framework为你的app提供了OC的接口来整合这些项目。你可以使用该框架结合网络接口以及文件格式信息来生成和管理你的公司为你提供的执照。  
由你的公司通过网络服务器生成的这些执照将通过邮件、Safari浏览器或者你自己的app传送给用户的设备。对于执照本身，将会使用一种特殊的文件格式，在传输之前经过加密。文件格式ID相关信息已经由服务器提供，所以用户知晓该项服务是做什么的。很有可能还会包含一个二维码或者其他的你可以用来验证银行卡的找回或使用的相关信息。  
更多关于PassKit的相关信息以及如何将其添加进你的app，参见钱包开发者指南。
### Quick Look Framework（预览框架）
QuickLook.framework提供了一个直观的界面来预览那些你的app可能不支持的格式的文件内容。该框架是为那些从网上下载文件的app或从未知源得到的文件准备的。获取到文件后，你就可以在你的用户界面中使用该框架提供的VC来直接展示该文件的内容了。  
更多关于该框架类和方法的相关信息，参见iOS预览框架参考。
### Safari Services Framework
SafariServices.framework为以编程方式添加URL到用户的Safari阅读列表这一功能提供了支持。更多关于这个框架的类的信息，请参见该框架头文件。
### Social Framework (社交媒体框架)
Social.framework提供了一个简单的界面来访问用户的社交媒体账户。该框架替代了Twitter框架，添加了更多的社交媒体账户支持，包括Facebook，新浪微博以及其他的账户。app可以使用这个框架来上传状态更新以及图片到用户的账户中。该框架与账户框架协作，为用户提供了一个单点登录模型，并且确保访问用户的账户是经过验证的。  
更多关于社交媒体框架的相关信息，参见社交媒体框架参考。
### StoreKit Framework
StoreKit.framework为在你的iOS app中采购内容和服务提供支持，这被称作应用内支付。例如，你可以使用这一功能，让用户解锁一些额外的app功能。如果你是个游戏开发者的话，你可以使用它来提供额外的游戏等级。在各种情况下，StoreKit都会管理关于金融交易的各个方面，处理支付的请求需要通过用户的iTunes Store账户，并且会提供给你的app有关支付的相关信息。
StoreKit关注金融交易的方方面面，确保该项交易安全可靠的发生。你的app需要处理除了金融交易的方面，包括展示支付界面、下载（或解锁）适当的内容。这种分工给予了你对于交易界面用户体验的控制权。你决定何时何地展示什么交易内容给用户。你还要决定以何种方式传输才是对于你的app最佳。  
更多关于如何使用StoreKit框架的信息，参见应用内支付编程指南以及StoreKit框架参考。
### System Configuration Framework
SystemConfiguration.framework提供了一套可达性的接口，你可以使用它来判断一台设备的网络配置。你还可以使用它来判断是Wi-Fi还是蜂窝网络连接在使用，并且判断一个特定的主机服务器能否被访问。    
更多关于该框架的信息，请参见SystemConfiguration框架参考。关于如何使用这个框架去获取网络信息，请查看Reachability这个示例工程的代码。
### WebKit Framework
WebKit.framework让你能够在你的app中显示HTML内容。除了显示HTML外，你还可以提供基本的编辑支持，这样用户就能够替换文本以及操作文档内容以及属性，包括CSS属性。WebKit同样支持在一个HTML文档中生成和编辑DOM层的内容。例如，你可以提取一篇文章中的链接，修改它们，在它们显示到一个web view的文档中之前替换它们。  
更多关于这个框架的接口信息，请参见WebKit接口参考。

# Core OS Layer（核心系统层）
核心服务层包含了其他大部分技术所依赖的底层功能。即使你不会直接使用到这些技术在你的app中，大部分的框架都会使用到这些技术。当你需要与安全或者与硬件配件进行交互时，你应该使用这一层框架。
## Accelerate Framework (加速器框架)
Accelerate.framework包含接口来执行数字信号处理、线性代数以及图片计算处理。你可以通过重写你自己版本的该框架的接口来实现优化展现在iOS设备上的所有硬件配置。所以一旦你重写了，你要保证你的代码在所有设备上都能良好运行。  
更多关于加速器框架的相关函数信息，参见加速器框架参考。
## Core Bluetooth Framework (核心蓝牙模块)
CoreBluetooth.framework允许开发者接入指定的低功耗的蓝牙配件。该框架的OC接口允许你做以下事情：  

* 扫描你发现的蓝牙设备，可以与其连接或者断开连接
* 由你的app提供服务，将iOS设备变为其他蓝牙设备的一个外部设备
* 从iOS设备广播iBeacon信息
* 维持蓝牙设备的状态以及在你的app随后加载时恢复这些连接
* 当周围的蓝牙设备可用时通知你

更多关于如何使用核心蓝牙框架的相关信息，参见核心蓝牙编程指南以及核心蓝牙框架参考。

## External Accessory Framework （外部配件模块）
ExternalAccessory.framework对与iOS设备的硬件附件进行通讯提供了支持。附件可以通过30针的连接坞或者使用蓝牙无线连接。ExternalAccessory.framework提供了获取所有可用附件的信息的渠道以及创建会话的功能。连接后，你就可以自由的使用该配件支持的命令直接操作附件了。  
更多关于如何使用该框架的信息，参见外部配件编程话题，关于开发基于iOS设备的配件，请查看苹果开发者网站。
## Generic Security Services Framework （通用安全服务模块）
GSS.framework为iOS app提供了一套安全相关的服务。一些基础接口在IETF RFC 2743 和 RFC 4401有详细阐述。此外，还提供了标准接口，iOS包含额外的管理证书能力，虽然这并不标准，但这在很多app上都有需求。  
更多关于GSS.framework相关信息，参见头文件。
## Local Authentication Framework (本地鉴定模块)
LocalAuthentication.framework让你能够通过Touch ID来验证用户。有些app需要安全的访问它们所有的内容，有些其他的app需要安全的访问特定区域或者选定区域。不论哪种情况，你都可以要求用户在开始使用前进行验证。使用该框架会展示一个带有app特定原因的警告框给用户，警告框中会展示为什么用户需要验证。当你的app得到回应后，用户成功验证后你就可以做出反应了。  
更多关于该框架的接口信息，参见本地鉴定模块参考。
## Network Extension Framework （网络扩展模块）
NetworkExtension.framework对配置和控制VPN虚拟专用网络渠道提供了支持。使用该框架来生成VPN配置。你可以稍后手动打开VPN，也可以根据相应的规则在接收到特定事件后打开VPN。  
更多关于该框架的接口，参见该框架头文件。
## Security Framework （安全模块）
除了内置的安全功能，iOS还提供了一套显式的安全模块，你可以使用该框架来确保你的app管理的数据受到保护。该框架提供管理证书、公私钥以及信任政策的接口。它支持密码上使用的伪随机数。还支持存储证书以及在keychain中的密钥，后者是用来存储用户敏感数据的安全位置。  
通用加密库对对称加密、基于哈希的验证码以及摘要算法提供了额外的支持。摘要功能提供了iOS上不存在的OpenSSL库的替代函数。  
允许你在你自己生成的app之间共享keychain内容。分享的内容能够让你的多个app顺畅的交互。例如，你可以利用这一功能分享用户的密码或者其他元素（这可能需要你在不同的app中都向用户提交请求）。想在app之间分享数据，你必须在每个app的Xcode项目中进行相应的配置。  
更多有关该框架的函数和功能，参见Security Framework参考。关于如何访问keychain相关信息，参见keychain服务编程指南。关于在Xcode中设置配置相关信息，参见app发布指南中的添加配置项。关于你能配置的功能列表，参见keychain服务参考中的SecItemAdd函数相关内容描述。
## System（系统层）
系统层包含核心运行环境、驱动以及底层UNIX操作系统接口。系统核心本身基于Mach，它负责操作系统的各个方面。它管理着虚拟内存系统、线程、文件系统、网络层以及进程间通信。这一层的驱动程序还为可用的硬件设备和系统框架之间提供接口支持。出于安全考虑，只有有限的一部分系统类库和app能访问系统核心层和驱动。  
iOS提供了一组接口来访问很多底层的操作系统功能。你的app如果需要访问这些功能的话，需要用到**LibSystem**库。该库是基于C语言的，并且提供以下支持：  

* 并发控制（POSIX线程以及GCD）
* 网络层（BSD sockets 套件字）
* 文件系统访问权限
* 标准I／O
* Bonjour以及DNS服务
* 定位信息
* 内存分配
* 科学计算

大部分核心系统技术的头文件都存放在`<iOS_SDK>/usr/include/`中，`<iOS_SDK>`代表你的Xcode安装的目录。更多关于这些技术的相关函数信息，参见iOS手册。

## 64-Bit Support（64位支持）
iOS最初被设计成使用32位的架构在设备上支持二进制文件的。而在iOS7上，引入了编译、链接以及debug二进制的64位架构。所有的库和框架都已经为64位备好，意思就是它们可以在32位或64位的app上都能使用。当在64位上运行编译时，app会运行的更快，因为处理器会额外提供资源。  
iOS使用LP64模型，该模型被OS X和其他的64位UNIX操作系统所使用，这意味着在移植代码时会有更少的问题。更多关于iOS64位运行时以及如何编写64位app的相关信息，参见Cocoa Touch 64位迁移指南。
# 附录A：iOS Frameworks（iOS系统框架）
本附录包含了有关iOS系统框架的相关信息。这些系统框架提供了你所在开发平台的相关接口。在适用的情况下，本附录中的列表包含了所有类、方法、函数、类型或者常量的前缀。请避免在你的代码中使用这些前缀。   
## Device Frameworks（设备框架）  
列表A－1描述了基于iOS设备的标准类库框架。你可以在这个目录下找到这些类库：**<Xcode.app>Contents/Developer/Platforms/iPhoneOS.platform/Developer/SDKs/<iOS_SDK>/System/Library/Frameworks** "Xcode.app"是你的Xcode所在目录，"<iOS_SDK>""是你的target的指定SDK版本。"可使用最低版本"列出了该框架首次在哪个版本的iOS系统中出现。
  
**列表 A－1 设备框架**  

| 框架名称  | 可使用的最低版本  | 前缀 | 描述 |
|:------------- |:---------------:| -------------:| -------------:|
| Accelerate.framework(加速器) |4.0|cblas, vDSP|包含加速器数学计算和数字信号函数|
| Accounts.framework(账目) |5.0| AC |包含管理进入用户系统账户的权限接口|
| AddressBook.framework(地址簿) |2.0| AB |包含直接访问用户联系人数据库接口|
| AddressBookUI.framework(地址簿界面) |2.0| AB |包含显示系统定义的联系人选择编辑界面相关类|
| AdSupport.framework|6.0| AS |包含统计数据相关类|
| AssetsLibrary.framework |4.0| AL |包含访问用户照片和视频相关类|
| AudioToolbox.framework |2.0| AU, Audio |包含处理音频流以及播放和录音相关类|
| AudioUnit.framework |2.0| AU, Audio |包含加载和使用音频组相关类|
| AVFoundation.framework |2.2| AV |包含OC接口的播放和录制音视频相关类|
| AVKit.framework |8.0| AV |包含OC接口的播放和录制音视频相关类|
| CFNetwork.framework |2.0| CF |包含通过Wi-Fi和蜂窝式数据访问网络相关类|
| CloudKit.framework |8.0| CK |包含OC接口的加载和保存iCloud数据相关类|
| CoreAudio.framework |2.0| Audio |包含贯穿Core Audio数据类型相关类|
| CoreAudioKit.framework |8.0| CA |包含贯穿Core Audio数据类型相关类|
| CoreBluetooth.framework |5.0| CB |包含低功率蓝牙硬件相关类|
| CoreData.framework |3.0| NS |包含管理你的app数据模型相关类|
| CoreFoundation.framework |2.0| CF |包含软件服务基本原理，包括基本数据类型、字符串工具、集合工具、资源管理以及系统设置相关类|
| CoreGraphics.framework |2.0| CG |包含封装Quartz 2D的相关接口|
| CoreImage.framework |5.0| CI |包含操纵视频和静态图片的相关接口|
| CoreLocation.framework |2.0| CL |包含用户定位的相关接口|
| CoreMedia.framework |4.0| CM |包含低层级音视频相关接口|
| CoreMIDI.framework |4.2| MIDI |包含低层级处理MIDI数据相关接口|
| CoreMotion.framework |4.0| CM |包含重力加速度和陀螺仪相关接口|
| CoreTelephony.framework |4.0| CT |包含电话相关信息相关接口|
| CoreText.framework |3.2| CT |包含文字布局和渲染引擎相关接口|
| CoreVideo.framework |4.0| CV |包含管理视频帧内存的底层接口|
| EventKit.framework |4.0| EK |包含管理用户日历事件数据接口|
| EventKitUI.framework |4.0| EK |包含显示标准系统日历界面相关接口|
| ExternalAccessory.framework |3.0| EA |包含与附带硬件配件交互的相关接口|
| Foundation.framework |2.0| NS |包含管理字符串、集合以及底层数据类型的封装相关接口|
| GameController.framework |7.0| GC |包含与游戏相关硬件交互的接口|
| GameKit.framework |3.0| GK |包含管理P2P连接的接口|
| GLKit.framework |5.0| GLK |包含OC实用工具，用来构建复杂的OpenGL ES app相关接口|
| GSS.framework |5.0| gss |包含一些安全相关的标准集合|
| HealthKit.framework |8.0| HK |包含统计存储用户健康相关信息接口|
| HomeKit.framework |8.0| HM |包含与家中智能设备沟通相关服务接口|
| iAd.framework |4.0| AD |包含在展示广告相关类|
| ImageIO.framework |4.0| CG |包含读写图片数据相关类|
| IOKit.framework |2.0| N/A |包含设备使用的相关类，请不要直接使用本框架|
| JavaScriptCore.framework | 7.0 | JS |包含OC封装的调用JS代码以及解析JSON相关|
| LocalAuthentication.framework | 8.0 | LA |包含用户使用Touch ID验证相关接口|
| MapKit.framework | 3.0 | MK |包含在你的app中嵌入地图以及反向地理坐标相关类|
| MediaAccessibility.framework | 7.0 | MA |管理媒体文件中的隐藏字幕的显示，参见MediaAccessibility框架|
| MediaPlayer.framework | 2.0 | MP |包含用来展示全屏视频的接口，参见MediaPlayer框架|
| MediaToolbox.framework | 6.0 | MT |包含播放音频内容的接口|
| MessageUI.framework | 3.0 | MF |包含组合排序email信息的接口，参见MessageUI框架|
| Metal.framework | 8.0 | MTL |为app提供低开销的图片渲染引擎，参见Metal框架|
| MobileCoreServices.framework | 3.0 | UT |由系统提供统一的类型识别标识符。参见 Mobile Core 服务框架|
| MultipeerConnectivity.framework | 7.0 | MC |为实现设备间的P2P网络通信提供接口，参见MultipeerConnectivity框架|
| NetworkExtension.framework | 8.0 | NE |为配置使用VPN提供接口支持，参见NetworkExtension框架|
| NewsstandKit.framework | 5.0 | NK |为在后台下载杂志或报纸等内容提供接口支持，参见NewsstandKit框架|
| NotificationCenter.framework | 2.0 | NK |提供接口来实现通知中心小工具，参见NotificationCenter框架|
| OpenAL.framework | 2.0 | AL |包括OpenAL相关接口，OpenAL是一个跨平台的音频库。参加OpenAL框架。|
| OpenGLES.framework | 2.0 | EAGL, GL |包括OpenGLES相关接口，OpenGLES是OpenGL跨2D和3D图片渲染库平台的一个嵌入式版本。参见OpenGLES框架。|
| PassKit.framework | 6.0 | PK |包括生成票据、登记证、会员卡等物的数码版本功能的接口。参见PassKit框架。|
| Photos.framework | 8.0 | PH |包括访问和操作照片视频的接口。参见Photos框架。|
| PhotosUI.framework | 8.0 | PH |包括生成app扩展程序来访问和操作照片视频的接口。参见PhotosUI框架。|
| PushKit.framework | 8.0 | PK |提供了VoIP类的app注册的功能。参见PushKit框架。|
| QuartzCore.framework | 2.0 | CA |提供了Core Animation的接口。参见QuartzCore框架。|
| QuickLook.framework | 4.0 | QL |提供了预览文件相关接口。参见QuickLook框架。|
| SafariServices.framework | 7.0 | SS |支持在Safari中生成待阅读列表。参见SafariServices框架。|
| SceneKit.framework | 8.0 | SCN |支持生成3D图片接口。参见SceneKit框架。|
| Security.framework | 2.0 | CSSM, Sec |包含管理证书、公私钥以及信任文件的接口。参见Security框架。|
| Social.framework | 6.0 | SL |包含与社交媒体账户相关接口。参见Social框架。|
| SpriteKit.framework | 7.0 | SK |简化基于精灵的动画和渲染生成框架。参见SpriteKit框架。|
| StoreKit.framework | 3.0 | SK |包含控制应用内购买的交易相关的接口。参见StoreKit框架。|
| SystemConfiguration.framework | 2.0 | SC |测定设备网络配置相关接口。参见SystemConfiguration框架。|
| Twitter.framework | 5.0 | TW |包含通过twitter服务器发送推文相关接口。参见Twitter框架。|
| UIKit.framework | 2.0 | UI |包含构建iOS app用户界面层的类和方法。参见UIKit框架。|
| VideoToolbox.framework | 6.0 | VT |包含底层的常用压缩解压缩视频帧相关功能。|
| WebKit.framework | 8.0 | WK |为集成web页面浏览功能到app中提供支持。参见WebKit框架。|

## Simulator Frameworks

尽管在你编码的过程中应该尽量使用真机，但是在测试情况下，还是需要在模拟器上编译你的代码。真机和模拟器上的框架大部分都是完全相同的，但是还是有少量的区别的。例如，模拟器使用了一些OS X上的框架作为它自己的实现。此外，由于系统的局限性，一部分真机和模拟器的接口还是有一些区别的。  
想查看模拟器和真机的框架的接口区别，请查看模拟器使用指南。

## System Libraries

请知晓，在Core OS和Core Services层有一些特殊库代码是没有被封装成框架的。iOS在系统的 **/usr/lib** 路径下包含了很多动态库。动态库以它们的".dylib"扩展作为分享的标示。这些库的头文件存放在  **/usr/include** 路径下。  
每个iOS SDK都包含了一份本地分享库的备份而无须安装在系统上。这些拷贝存在你正在开发的系统中以便你能够从你Xcode工程中链接到。如果想查看一个iOS系统特殊版本的库列表的话，在这个路径下可以查看到：<Xcode.app>/Contents/Developer/Platforms/iPhoneOS.platform/Developer/SDKs/<iOS_SDK>/usr/lib，<Xcode.app>代表你Xcode所在目录，<iOS_SDK>代表你当前target的特殊版本的SDK。例如，iOS8 SDK版本的将会存在 /Applications/Xcode.app/Contents/Developer/Platforms/iPhoneOS.platform/Developer/SDKs/iPhoneOS8.0.sdk/usr/lib 目录下，相应的头文件存放在 /Applications/Xcode.app/Contents/Developer/Platforms/iPhoneOS.platform/Developer/SDKs/iPhoneOS8.0.sdk/usr/include。  
iOS使用符号链接来指定大部分库的当前版本。当链接到一个动态分享库时，使用符号链接而不是普通链接来指向一个库特殊版本。库的版本在iOS系统当中是可能改变的；如果你的软件链接到了一个固定版本，那个版本不一定会在用户的系统中一直存在。