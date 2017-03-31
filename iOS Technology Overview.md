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

# Cocoa Touch 层
Cocoa Touch 层包含了构件iOS app的很多重要的framework。这些framework决定了你的app如何表现。并且提供构件app的基础，以及一些关键技术的支持，例如多任务处理（并行），屏幕上的输入，推送通知，和很多高层级的系统服务。当你设计你的app时，你应该多研究这一层的相关技术以供满足你的需要。  
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
app能对UIview的对象的制定动态行为进行定制，这些对象必须要遵循UIDynamicItem协议。遵循这项协议的对象被称为动态对象。动态的特性与真实世界的行为特性相结合，增加了用户体验。UIKit动态性对以下几种行为提供支持：

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
自动布局帮助你使用很少的代码就能够构建动态的界面。使用自动布局，你要定义好如何渲染你的用户界面元素的规则。这些规则定义了比以往使用的springs and struts模式更为直观的关系。例如，你可以指定一个按钮与其父view的边一致相距20像素。  
使用自动布局的OC实体被称作约束。约束提供以下功能：

* 约束能够通过交换字符串即可固定，而无需更新你的布局。
* 约束能够提供左右映射的语言环境，就像希伯来语和阿拉伯语。
* 约束提供了一种更好的方式对view和controller层中的对象进行解耦。

一个view对象通常都会持有它固定的大小，它在父view中的位置，以及它相对于兄弟view的位置等信息。VC能够在这些值不符合要求时对其进行重写。  
关于自动布局的更多信息，请查看自动布局指南。
### Storyboards(故事版)
故事版是iOS推荐的你设计你app用户界面的方式。故事版能够让你在一个界面中从整体上设计你的用户界面，在这个界面中，你可以看到你所有的view和VC，并且能够了解他们之间是如何协作的。故事版的一个重要功能是能够定义依赖，依赖代表着从一个VC到另一个VC的过渡。  
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
有关如何使用本框架的类和使用方法，请参阅iOS地址簿编程指南，以及iOS地址簿UI框架索引。
### EventKit UI Framework(活动事件UI框架)
活动事件UI框架提供了标准的系统界面展示、编辑日历相关的事件。本框架基于事件相关的数据进行封装的，详情请参阅Event Kit Framework。  
有关本框架的更多类和方法信息，请参阅活动事件UI框架索引。
### GameKit Framework(游戏相关框架)
游戏相关框架实现了对游戏中心的支持，这能够让用户在线分享他们与游戏相关的信息。游戏中心提供了以下功能支持：  

* Aliases（别名化），让用户能够在线生成他们定制的人物角色。用户登陆到游戏中心，与其它的用户通过自己的网名来匿名的交流。玩家可以发送状态信息给那些他们标记为朋友的玩家。
* Leaderboards（排行榜），能够让你的app发送玩家的积分到游戏中心，并能够检索到该积分。你可以使用该功能展示你app中所有的最高分用户。
* Matchmaking（对垒），能够让登陆到游戏中心的在线用户进行多人对战。玩家无需在现实中也参与到多人对战中。
* Achievements（成绩单）能够让你记录你app的玩家在你的app中的进度。
* Challenges（挑战）能够让玩家与另一个好友玩家进行积分或成就的比拼（iOS6及以后更高版本支持）
* Turn-based gaming，能够生成将状态信息存储在iCloud中的拉锯战。
  
有关如何使用游戏相关框架，请参阅游戏中心编程指南以及游戏相关框架索引。
### iAd Framework(广告框架)
广告框架能够让你实现基于横幅图片展示的广告。广告以标准空间展示，这使得你能够随意的按照你的意愿展示你的用户界面。这些控件与苹果的广告服务器交互，并且已经将处理副文本的广告媒体加载、展示和响应广告的点击等功能封装好以供你调用。  
想了解更多如何在你的app中使用广告，请参阅广告编程指南以及广告框架索引。
### MapKit Framework(地图框架)
地图框架提供了一张能够随意移动的地图，让你能够将其嵌入你app的用户界面。除了提供基本的地图展示功能，你还可以通过框架提供的接口对地图界面以及展示进行定制。你可以使用大头针对感兴趣的位置进行标注，你还可以使用覆盖物点缀地图上的区域。例如，你可以使用覆盖物去绘制公共汽车线路，或者高亮标注附近的商店和宾馆。  
除了展示地图之外，地图框架与苹果的地图服务器相结合，使得导航更为容易。任何支持导航的app都可以将系统自带的地图app设置为代理。例如地铁线路导航这种提供特殊导航功能的app，可以在使用导航功能前就进行注册。app还可以想苹果的服务器请求步行或驾驶的导航信息，合并到他们自定义的导航信息中，来提供完整的点到点的用户体验。  
想了解更多地图框架的类，请参阅定位和地图编程指南，以及地图框架索引。
### Message UI Framework(短信UI框架)
短信UI框架为email和短信服务提供了支持。它由一个模态化展示在你的app中的VC界面构成。你可将邮件接收者、主题、内容以及任意的附件或你想包括在信息当中的内容都展示在这个VC中。当这个VC被展示出来后，用户在发送信息前可以通过该界面对信息进行编辑。  
想了解更多短信框架的类，请查阅短信UI框架索引。想了解更多如何使用该框架的类，请查阅iOS系统短信编程话题。
### Notification Center Framework(通知中心框架)
通知中心框架为生成在通知中心中可以浏览的小工具提供了支持。  
想了解更多如何生成通知中心小工具的相关信息，请查阅app扩展编程指南以及通知中心框架索引。
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
| UIKit graphics |UIKit定义了高层级的API以供支持图片的绘制以及贝塞尔曲线和view的动画的展现。此外，还提供了实现绘图的支持，UIKit中的view控件提供了一种快速有效的方式来渲染图片和基于文字的内容。view还可以支持动画，直接使用UIKit动力学框架可以提供更好的交互和反馈效果。 想查看更多UIKit框架相关信息，请参看UIKit框架索引。|
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
想查看更多的关于该框架的类和方法，请查阅资源库框架索引。
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

想了解更多有关AV Foundation的信息，请参见AV Foundation编程指南。有关AV Foundation框架的类文件，请参见AV Foundation框架索引。

### AVKit Framework
AVKit.framework利用AV Foundation框架中的对象来管理设备上视频的展示效果。当你想展示视频内容时，你可以将其当作Media Player库的替代品。  
想了解更多关于该框架的信息，请参看其头文件。
### Core Audio
Core Audio是一组框架的集合（列表2－4），它提供了对音频的原生控制。这些框架支持在你的app中生成、录制、混淆以及播放音频。你还可以使用这些框架操纵MIDI媒体内容或流媒体或MIDI内容到其它的app中。  
**列表2-4 Core Audio框架**  

| 框架名称  | 提供的服务 |
|:------------- |:---------------:|
| CoreAudio.framework | 通过CoreAudio定义音频数据类型。了解更多信息请查阅CoreAudio框架索引 |
| AudioToolbox.framework | 为音频文件和音频流提供回放以及录制服务。该框架还提供管理音频文件，播放系统警告声音以及触发某些设备的震动等功能。更多信息请参见AudioToolbox框架索引。 |
| AudioUnit.framework | 为使用内置的音频单元提供服务，即音频处理模块。该框架还提供将你的音频以组件的形式显示给可见的其它app。更多信息请参阅AudioUnit框架索引。 |
| CoreMIDI.framework | 提供一种标准的方式与MIDI设备交互，包括键盘和合成器。你可以使用该框架发送或接收MIDI信息，或者与周边的MIDI设备通过基于iOS的设备使用dock转接头或网络进行沟通。更多信息请参见CoreMIDI框架索引。 |
| MediaToolbox.framework | 提供audio tap相关接口 |

想了解更多关于Core Audio的信息，请参看Core Audio概览。想了解如何使用Audio Toolbox 框架播放音频，请参看Audio Queue Services编程指南。

### CoreAudioKit Framework
CoreAudioKit.framework提供了标准的view来管理app之间共享的的音频。一个view上显示其他链接的app的icon，另一个view上显示传输的控制，用户可以使用它来操纵由主app提供的音频。  
更多框架中的接口相关信息请参阅框架中的头文件。
### Core Graphics Framework
CoreGraphics.framework包含了Quartz 2D绘制的API接口。Quartz是OS X上一个高级的基于矢量绘制的引擎。它支持基于路径的绘制，抗锯齿渲染，渐变的，图片类型的，颜色类型的，坐标系转换以及PDF生成，展示和解析。尽管接口是C语言的，但是它经过基于对象的封装来展示呈现基本的绘制对象，使得存储和重用你的图形内容更为容易。  
更多如何使用Quartz来绘制内容的信息请查阅Quartz 2D编程指南以及Core Graphics框架索引。
### Core Image Framework
CoreImage.framework提供了一组强大功能的嵌入式滤镜，用来操作视频以及静态图片。你可以使用这套嵌入式的滤镜来润色或修正脸部图片、特写以及二维码扫描。这套滤镜的优势是它们以一种无损的方式操作，而不是直接操作你的原图，这使得原图毫无改变。这是因为这套滤镜是基于底层硬件优化的，这样更快并且有效率。  
更多有关滤镜的类和信息请参见Core Image框架。
### Core Text Framework
CoreText.framework提供了一套简单但是高性能的基于C封装的接口，你可以用它来对文字进行布局以及控制字体。那些不想使用TextKit但又相对文字处理能力要求很高的app可以使用这个框架。这套框架提供了一套复杂的文字布局引擎，包括文字环绕能力。它还支持高级的使用多种字体和渲染属性的文字样式。  
更多有关CoreText接口的信息，清参阅CoreText编程指南以及CoreText索引集合。
### Core Video Framework
CoreVideo.framework提供了缓冲以及缓冲池来支持Core Media框架（Core Media框架中提及）。大部分的app都不用直接使用这个库。
### Game Controller Framework

### GLKit Framework

### Image I/O Framework

### Media Accessibility Framework

### Media Player Framework

### Metal Framework

### OpenAL Framework

### OpenGL ES Framework

### Photos Framework

### Photos UI Framework

### Quartz Core Framework

### SceneKit Framework

### SpriteKit Framework

# Core Services Layer（核心服务层）
# Core OS Layer（核心系统层）
# 附录A：iOS Frameworks（iOS系统框架）
本附录包含了有关iOS系统框架的相关信息。这些系统框架提供了你所在开发平台的相关接口。在适用的情况下，本附录中的列表包含了所有类、方法、函数、类型或者常量的前缀。请避免在你的代码中使用这些前缀。   
## Device Frameworks（设备框架）  
列表A－1描述了基于iOS设备的标准类库框架。你可以在这个目录下找到这些类库：**<Xcode.app>Contents/Developer/Platforms/iPhoneOS.platform/Developer/SDKs/<iOS_SDK>/System/Library/Frameworks** **<Xcode.app>**在你的Xcode所在目录，**<iOS_SDK>**是你的target的指定SDK版本。"可使用最低版本"列出了该框架首次在哪个版本的iOS系统中出现。
  
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

## Simulator Frameworks

尽管在你编码的过程中应该尽量使用真机，但是在测试情况下，还是需要在模拟器上编译你的代码。真机和模拟器上的框架大部分都是完全相同的，但是还是有少量的区别的。例如，模拟器使用了一些OS X上的框架作为它自己的实现。此外，由于系统的局限性，一部分真机和模拟器的接口还是有一些区别的。  
想查看模拟器和真机的框架的接口区别，请查看模拟器使用指南。

## System Libraries

请知晓，在Core OS和Core Services层有一些特殊库代码是没有被封装成框架的。iOS在系统的**/usr/lib**路径下包含了很多动态库。动态库以它们的**.dylib**扩展作为分享的标示。这些库的头文件存放在  **/usr/include**路径下。  
每个班的iOS SDK都包含了一份本地分享库的备份而无须安装在系统上。这些拷贝存在你正在开发的系统中以便你能够从你Xcode工程中链接到。如果想查看一个iOS系统特殊版本的库列表的话，在这个路径下可以查看到：**<Xcode.app>/Contents/Developer/Platforms/iPhoneOS.platform/Developer/SDKs/<iOS_SDK>/usr/lib**，**<Xcode.app>**代表你Xcode所在目录，**<iOS_SDK>**代表你当前target的特殊版本的SDK。例如，iOS8 SDK版本的将会存在**/Applications/Xcode.app/Contents/Developer/Platforms/iPhoneOS.platform/Developer/SDKs/iPhoneOS8.0.sdk/usr/lib**目录下，相应的头文件存放在**/Applications/Xcode.app/Contents/Developer/Platforms/iPhoneOS.platform/Developer/SDKs/iPhoneOS8.0.sdk/usr/include**。  
iOS使用符号链接来指定大部分库的当前版本。当链接到一个动态分享库时，使用符号链接而不是普通链接来指向一个库特殊版本。库的版本在iOS系统当中是可能改变的；如果你的软件链接到了一个固定版本，那个版本不一定会在用户的系统中一直存在。