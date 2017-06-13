[App Programming Guide for iOS 原文链接](https://developer.apple.com/library/content/documentation/iPhone/Conceptual/iPhoneOSProgrammingGuide/Introduction/Introduction.html#//apple_ref/doc/uid/TP40007072)  

# 关于iOS app的发布
app应该和iOS结合的更好，确保为用户提供最佳的用户体验。除了为你的app提供更好的设计以及交互界面，更好的用户体验还包含很多其他因素。用户在使用app的时候，期望它消耗的电量更少、更快以及更具有交互性。app应该为所有最新发布的iOS设备做适配。实现所有的新功能看起来不太可能，但是iOS将对此对你提供帮助。  

![](https://developer.apple.com/library/content/documentation/iPhone/Conceptual/iPhoneOSProgrammingGuide/Art/ios_pg_intro_2x.png)  

本文档所描述的核心行为能够让你的app更好的在iOS上运行。你可能不需要实现本文档当中提到的所有功能，但是你应该在你创建的所有项目当中都考虑这些功能。  

	注意：开发iOS app需要一台基于intel处理器的苹果机，并且需要安装iOS SDK。关于如何获取iOS SDK，请移步“iOS开发者中心”。

## 概览
当你准备将你的idea变成一个app的时候，你要知道，在系统和你的app之间是有交互发生的。
### app应该支持key功能
系统希望每个app都有一些固定的资源文件和配置数据，比如一个app的logo和关于app能够做什么的一些信息。Xcode为每个新工程都提供了信息文件，但是你在提交你的app之前必须要支持资源文件，并且确保你的工程的信息文件是正确的。  

	`相关章节：预期的app行为`

### app应该明确定义执行路径
从用户启动加载app，到用户将它退出，app应该明确定义执行路径。在一个app的生命周期内，它应该能从前台转换到后台执行，它应该可以被终止和重新加载，它还应该可以被暂时休眠。每次转换到一个新的状态时，app都应该有相应的转变。一个在前台的app几乎可以做所有的事情，但是在后台的app只能做有限的一些事。你应该使用状态转换来调整你的app的响应的行为。  

	`相关章节：app生命周期，控制app状态转换策略`

### app必须高效的运行在一个多任务处理环境下
电池寿命、性能、快速响应一集极佳的用户体验对用户来说都是非常重要的。最小化你的app的耗电量能够让用户全天使用你的app而无需给设备充电，不过加载和运行的速度也是非常重要的。iOS多任务处理为用户期待的良好的电量消耗提供了支持，而这无需牺牲快速响应和用户体验，不过这需要app采用一些系统提供的行为。  

	`相关章节：后台执行，控制app状态转换策略`

### app之间的通信必须是遵循指定路径的
为了安全的需要，iOS app是运行在沙盒中的，并且限制了与其他app的交互。当你想与系统当中的其他app进行交互的时候，是有一些特殊方法可以做到的。  

	`相关章节：app之间的交互`

### 性能调试对于app来说是非常重要的
每个app执行的任务都是有相关的电量消耗的。app耗尽用户的电量为用户提供了非常不好的体验，并且相对于那些只需要充电一次就能够使用一整天的app来说，这种app更容易被删除。所以你要意识到不同操作的消耗以及利用好系统提供的节省电量的策略。  

	`相关章节：性能调试贴士`

## 如何使用本文档
本文档不是为iOS app开发入门者提供的。它是为那些想讲app发布到App Store之前，将app好好打磨的人提供的。使用本文档作为指南，理解你的app如何与系统进行交互，并且尽量让这些交互进行的流畅。  
## 预备知识
本文档为iOS app架构提供了相关的详细信息，为你展示了如何实现app级别的功能。我们假设你已经安装了iOS SDK，配置好了你的开发环境以及理解一些通过Xcode创建和实现你的app的知识。  
如果你是一个iOS app开发的新手，推荐阅读“开始开发iOS app（Swift）”。该文档提供了一步一步快速开发app的介绍。它还提供了从app创建到完成的亲身实践，为你展现了一个简单的app的创建以及快速运行。  
## 参考资料
如果你在学习关于iOS的知识，推荐阅读“iOS技术概览”来将相关的技术和功能加入到你的app当中。
# 预期的app行为
每个新建的Xcode项目都被配置好能够直接在模拟器或者设备上运行。但是在设备上能够运行不代表你已经准备好提交你的app到App Store了。每个app都应该进行大量的必需的配置，以便为用户带来更好的体验。定制化能够为从你的app使用的logo到架构级别的决定提供相关信息。本章讲述了所有app都应该关心的行为以及你应该尽早关心规划过程。  
## 提供所需的资源文件
每个你创建的app都应该拥有以下资源和元数据，以便能够在iOS设备上显示：  

* 一个信息属性列表文件。Info.plist文件包含了有关你的app的元数据，系统将会通过该文件与你的app进行交互。Xcode通过你的项目的配置和设置会自动为你生成该文件。如果你想直接查看或更改该文件的内容的话，你可以从你的工程的信息栏干这件事。关于如何更改该文件以及关于你应该包含的key的推荐，参见“信息属性列表文件”。  
* 一个app运行所需设备的声明。每个app都必须对于它运行所需要的硬件性能和功能进行声明。App Store会根据这项信息决定用户能否在指定的设备上运行你的app。你可以在你项目当中的信息栏中修改你的app运行所需的设备声明。关于如何配置这个key，参见“声明所需设备”。  
* 至少一个icon。系统将展示你的app的logo到用户的首页当中。系统也有可能将你的app的其他版本的icon展示在“设置”app或者搜索结果当中。关于如何展示app logo的相关信息，参见“app icon”。  
* 至少一个加载启动图。当一个app加载的时候，系统会展示一张临时的图片直到app能够展示在用户面前。这张临时图片就是你的app的加载图，它为用户提供了即时反馈，告诉用户，你的app正在加载，并且马上就准备好了。你必须为你的app至少提供一张加载图，此外，你还应该提供额外的加载图来处理特殊的场景。关于创建的你app的加载图的相关信息，参见“app加载图（默认启动图）”。

这些资源文件是所有app都必须要有的，但是你的app不仅仅要包含这些。你的app当中的Info.plist文件默认不包含很多的Xcode支持的key。很多很重要的key都是在你的app支持该功能的时候才需要添加的。举个例子，一个使用麦克风的app应该包含NSMicrophoneUsageDescription这个key，并且要提供给用户它为什么要使用麦克风的说明。
### app bundle
当你打包你的app的时候，Xcode将其打包为一个bundle。一个bundle是将一组相关资源整合到一个位置的在文件系统当中的一个目录。一个iOS的app bundel包含app执行文件以及支持的资源文件，例如app icons，图片文件，以及本地化内容。列表1-1列出了一个典型的iOS app bundle当中的内容，出于示范的目的，它叫做MyApp。这个示例仅出于示范的目的。一些在这个列表当中的文件将不会出现在你的app当中。  

列表1-1 一个典型的app bundle  

文件  | 示例 | 描述
------------- | ------------- | -------------
app执行文件  | MyApp | 执行文件包含了你的app的编译代码，你的app的执行文件是和你的app的名字减去.app后缀后的名字是相同的。这个文件是必须的。
信息属性列表文件  | Info.plist | Info.plist文件包含了你的app的配置信息。系统将根据该文件来决定如何和你的app进行交互。本文件是必须的，并且必须叫做Info.plist。更多相关信息，参见“信息属性列表文件”。
app icons  | Icon.png Icon@2x.png Icon-Small.png Icon-Small@2x.png | 你的app icon是被用来展示在用户设备的首页上的。其他的icon是被系统用来展示在适当的位置的。icon文件名中带有@2x代表它是展示在那些高清屏幕设备上的。一个app的icon文件是必须的。更多关于各种icon图片文件的信息，参见“app icons”。
加载图  | Default.png Default-Portrait.png Default-Landscape.png | 系统使用该文件作为加载你的app时临时的背景图。当你的app准备好展示它的内容给用户的时候，它将会被移除。至少需要一个启动图文件。更多关于指定的启动图文件的相关信息，参见“app启动图”。
故事版文件（或nib文件）  | MainBoard.storyboard | 故事版包含了展示在app当中的view和vc。在故事版当中的view是根据相关的展示它们的VC来组织的。故事版还定义了转换（也被叫做segues）能够让用户从一组view转换到另一组。主故事版的文件名是在你创建你的项目的时候由Xcode生成的。你可以在Info.plist文件的UIMainStoryboardFile key对应的value设置不同的文件名。使用nib文件的app可以将 UIMainStoryboardFile key 替换为 NSMainNibFile来指定主要的nib文件。故事版文件或者nib文件是可选的，但是我们推荐你使用。
Ad hoc 发布 icon  | iTunesArtwork | 如果你想以ad hoc的方式发布你的app的话，包括512 x 512像素的你的app icon的版本。这个icon通常从iTunes Connect提供给App Store。不过，由于ad hoc发布方式不是通过App Store，你的icon必须被你的app bundle代替。iTunes使用这个icon代表你的app。（你指定的文件必须和你提交到App Store的文件相同，如果你想以那种方式发布app到App Store的话）。这个icon的文件名必须是iTunesArtwork，并且没有文件名后缀。对于ad hoc发布方式来说，这个文件是必须的，对于其他方式来说是可选的。
设置bundle  | Settings.bundle | 如果你想通过设置app来展示你的app的配置参数的话，你必须包含一个设置bundle。这个bundle包含了属性列表数据以及其他的你的app定义的配置参数资源文件。设置app将会使用这个bundle当中提供的信息来为你的app配置界面。这个bundle是可选的。更多关于配置信息以及指定设置bundle的相关信息，参见“配置和设置编程指南”。
非局限资源文件  | sun.png mydata.plist | 非局限性的资源文件包含图片、声音文件、视频以及自定义的文件，这些文件都是你的app需要用到的。所有的这些文件都应该放置在你的app bundle的最上层。
本地化资源文件子目录  | en.lproj fr.lproj es.lproj | 本地化的资源文件必须放置在指定的语言工程目录下，名字由ISO 639-1语言缩写加上.lproj后缀组成。（比如en.lproj, fr.lproj, 和 es.lproj目录分别代表英语、法语和西班牙语）。一个iOS app应该是国际化的，并且为每种语言都包含相应的.lproj目录支持。除了为你的app自定义资源文件提供本地化的版本之外，你还可以通过在指定的语言工程路径下放置相同名称的文件来本地化你的app icon、启动图以及设置icon。更多相关信息，参见“国际化你的app”。

	注意：一个iOS app的bundle不能包含一个自定义的目录名字叫做“Resources”。

有关iOS app bundle的结构信息，参见“bundle编程指南”。有关如何从你的bundle加载资源文件，参见“资源文件编程指南”。
### 信息属性列表文件
Xcode通过你的工程的General, Capabilities, 和 Info等几个页签当中的信息在编译时为你的app生成信息属性列表文件（Info.plist）。Info.plist文件是一个结构性的文件，它包含了你的app配置的关键信息。它被iOS和App Store用来辨别你的app的功能以及定位关键资源。每个app都必须包含这个文件。  
尽管Xcode提供的Info.plist文件包含了很多必须的条目，大部分app都需要对其更改或者添加。无论何时，请使用General 和 Capabilities页签来配置你的app的相关信息。这些页签包含了大部分app可选的通用配置选项。如果你没有在这些页签中找到特殊的选项，请使用Info页签。  
对于那些Xcode没有在界面当中提供的定制化配置的选项，你必须使用Xcode属性列表编辑器来提供适当的key value值。在Info页签的自定义iOS target属性一段当中包含了Info.plist当中的条目摘要信息。默认的，Xcode展示的是打算实现的功能的可读版本描述，但是每个功能其实都是在Info.plist文件当中对应的一个唯一的key。大多数key是可选的或者很少用到的，但是有一小部分key是当你创建一个新的工程的时候应该考虑的：  

* 在Info页签当中声明你的app所需的环境。需要的设备功能段落包含了你的app需要运行的设备级别的功能描述信息。App Store会使用这个条目当中的信息来决定你的app的运行环境，并且将这些信息展现在那些不符合你的app所需运行环境的设备上。更多信息参见“声明所需设备信息”。
* 对于需要稳定Wi-Fi环境的app必须声明原因。如果你的app需要和服务器通过网络进行交互，你可以在你项目的Info页签当中添加Wi-Fi条目。这在Info.plist 文件中使用 UIRequiresPersistentWiFi key来表述。将这个key设置为YES可以将Wi-Fi从活跃状态转换到不活跃状态的时间延长一点。这个key对于那些需要使用网络和服务器进行交互的app建议使用。
* 报刊杂志类的app必须声明其本身。包含UINewsstandApp key的app表示你的app将从报刊app当中展示信息。
* 定义自定义文本类型的app必须声明那些文本类型。Info页签当中的文档类型段落指定了icons和你的app支持的文本格式的UTI信息。系统通过这个信息确认app能够处理指定的文件类型。更多关于为你的app添加文档支持的信息，参见“基于文档的iOS app编程指南”。
* app可以声明任何支持的自定义的URL schemes。Info页签当中的URL类型段落指定了你的app支持的自定义的URL schemes类型。app可以使用自定义的URL schemes来和其他的app进行交流。更多关于如何实现支持这一功能的相关信息，参见“使用URL schemes来和其他的app进行交互”。
* app在试图访问用户数据和某些app功能的时候必须提供使用描述（有时候称作“用途描述”）。当app涉及到访问用户隐私信息数据以及设备功能的时候，iOS将会为你的app向用户请求许可。app必须通过Info.plist当中的用途描述字段来向用户解释，为什么需要这个功能。如果你的app试图在没有提供用途描述的情况下获得访问权限的话，你的app将会终止运行。  
有关获取用户许可的数据和功能在列表1-2当中有相关描述。用途描述在“信息属性列表key文献”的“cocoa keys”一章有相关描述。

有关能够在Info.plist文件当中声明的键值对相关信息，参见“信息属性列表key文献”。
### 声明所需的设备功能
所有的app都应该声明它对于运行的设备的性能需求。Xcode在你的项目的Info页签中包含了所需设备能力的条目，并且以最低需求设备展示。你可以为你的app在这里添加额外的条目。所需设备能力的条目在Info.plist文件中相当于UIRequiredDeviceCapabilities 这个 key。  
UIRequiredDeviceCapabilities key对应的值可以是一个数组或者是个字典，它包含了你的app定义的支持的功能的key（或者是不支持的功能的key）。如果你指定该key的value是一个数组的话，那么存在key的对应的功能是必须的；缺失的key表示该功能不是必须的，并且app可以没有该功能也能够运行。如果你指定value是一个字典的话，每个字典当中的key必须对应布尔类型的值，无论该功能是必须的还是禁止的。true代表该功能必须，false代表该功能绝对不能在设备上出现。如果你的app有可选的功能的话，请不要在字典当中使用对应的key。
更多关于UIRequiredDeviceCapabilities key对应的可以包含的值的相关信息，参见“信息属性列表key参考文献”。
### app icon
每个app都必须提供一个icon用来展示在设备的首页和App Store当中。app实际上可能需要为多种情况指定多个icon。举个例子，app应该提供一个小的icon用来在搜索结果当中展示，并且应该提供一个高分辨率的icon用来在高清屏幕上展示。  
新的Xcode工程会为你的app icon图片包含一个图片集合的栏目。添加icon的时候，只需将对应的图片添加到对应的图片集合当中就可以了。在构建的时候，Xcode会将适当的key添加到你的Info.plist文件当中，并且将图片放置在你的app bundle当中。  
更多关于如何设计你的app icon、包括icon的尺寸的相关信息，参见“iOS人机交互指南”。
### app加载图（默认启动图）
当系统首次将一个app加载到一台设备上的时候，将会有一张临时的静态的加载图在屏幕上显示。这张图片就是你的启动图，它是Xcode项目当中的指定的资源文件。启动图给予了用户即时交互，它告诉用户，你的app正在加载，并且它给予你的app一定的准备时间来初始化你的用户界面。当你的app的window配置好了，并且准备好展示了，系统将会把启动图和window进行交换。  
当你的用户界面的最近的一张临时快照可用的时候，系统推荐使用该图片作为你的app的启动图。当你的app从前台转到后台的时候，系统会对你的app的用户界面做一张截图快照。当你的app返回前台的时候，将会使用该图片作为启动图。当用户杀死你的app或者你的app很久没有运行的情况下，系统将会丢弃快照，重新使用你的启动图。  
新的Xcode工程为你的app的启动图包含了图片集合条目。当需要添加启动图的时候，添加相关的图片到你的工程的图片集合的对应位置就可以了。在构建的时候，Xcode将添加相应的key到你的Info.plist文件当中，并且将启动图放置到你的app bundle当中。
更多关于如何设计你的app的启动图以及这些图片的尺寸的相关信息，参见“iOS人机交互指南”。
## 支持用户隐私
为用户隐私进行设计是非常重要的。大部分iOS设备都包含了用户不想展现在app或者外部设备上的隐私数据。如果你的app不太恰当的访问或者使用数据，用户很可能删除你的app。  
访问用户或者设备的数据只能在用户知情同意之后。此外，还应该采用适当的步骤保护用户和设备的数据以及显式的告知用户你在使用它。有一些比较好的方式推荐你使用：  

* 参阅政府或工业指导资料，包括以下文档：  
	* 联邦贸易委员会关于移动设备的隐私：“移动设备隐私公开性原则：通过透明建立信任”
	* EU数据保护委员会关于保护移动设备数据的报告：http://ec.europa.eu/justice/data-protection/article-29/documentation/opinion-recommendation/files/2013/wp202_en.pdf
	* 日本内阁关于智慧型手机的隐私举措：  
		* 智慧型手机隐私举措：  
		  英文版：http://www.soumu.go.jp/main_sosiki/joho_tsusin/eng/presentation/pdf/Initiative.pdf  
		  日文版：http://www.soumu.go.jp/main_content/000171225.pdf
		* 智慧型手机隐私举措2：  
		  英文版：http://www.soumu.go.jp/main_sosiki/joho_tsusin/eng/presentation/pdf/Summary_II.pdf  
		  日文版：http://www.soumu.go.jp/main_content/000247654.pdf
	* 加州州检察院推荐的关于移动设备的隐私：“隐私：推荐移动生态系统使用”    
这些报告帮助保护了用户的隐私。你还应该查看你公司的法律顾问文档。
* 对于敏感数据以及设备数据要取得用户的授权，当你的app需要这些数据的时候，这些数据被iOS系统授权设置。你必须提供一个描述性字符串（有时候称作使用说明）在你的app的Info.plist文件当中，该字符串用来解释为什么你的app需要这些你要试图访问的数据和资源。被iOS系统授权设置保护的数据包括：定位、联系人、日历事件、提醒事件、照片、媒体库以及很多其他类型的数据；参见列表1-2。在用户不同意访问这些数据的情况下，你应该提供合理的回调行为。
* 应该为用户展示浅显易懂的该数据将会被如何使用的描述。举例来说，当你提交你的app到App Store的时候，应该提供一个URL作为你的隐私协议或者陈述，并且作为iTunes Connect 元数据的一部分。你还可以在你的app描述当中解释总结隐私协议。  
更多关于在iTunes Connect当中提供你的app隐私协议的相关信息，参见“在iTunes Connect中添加一个app”。
* 给予用户对于用户或设备数据的控制权。为用户提供设置选项，这样用户就可以决定那些敏感信息是否需要被访问。
* 尽可能少的请求用户或者设备的信息来完成任务。不要由于一些不明显的原因或者不必要的原因或者仅仅是你觉得以后可能会用到这种原因请求或者收集数据。
* 在你的app当中使用合理的步骤保护你收集的用户和设备的信息。当你在本地存储信息的时候，应当尝试使用iOS数据保护功能（在“使用磁盘加密功能保护用户数据”中有相关描述）将数据以加密格式存储。当你通过网络将用户或者设备的信息传输的时候，请使用app安全传输机制（在NSAppTransportSecurity中有相关描述）。
* 如果你的app用到了ASIdentifierManager类的话，你必须对advertisingTrackingEnabled这个属性的值提起重视。如果该属性被用户设置为NO的话，那么ASIdentifierManager类只能用于有限的一些广告内容。“有限的广告内容”的意思是仅仅出于广告的目的使用频率统计、归属地、转换事件、独立用户估算、广告诈骗保护、以及调试功能，其他使用广告支持的API的将会被Apple允许。
* 如果你还没有准备好这么做的话，请停止使用UIDevice类提供的uniqueIdentifier属性，它代表唯一设备标示。该属性在iOS5之后就被废除了，并且App Store不再接受使用该标示的新的app或者旧的app更新。取而代之的是，app应该视情况而定使用UIDevice类的identifierForVendor属性或者ASIdentifierManager类的advertisingIdentifier属性。
* 如果你的app支持音频录入的话，请在你确实打算用到录制功能的时候才配置你的音频模块。不要在你还没准备好立刻使用录制功能的启动加载时就配置你的音频录制模块。系统将会在app配置音频录制模块的时候提示用户，并且为用户提供选项是否同意你的app录制音频。

列表1-2列出了iOS上支持的授权资源和数据类型。对每个条目列表都展现了用途描述key以及用来检查授权状态的API。  

	重要：当你的app试图使用被保护的内容时，系统将会通过一个提示框提示用户，并且获取用户的授权。从iOS10开始，你的Info.plist必需包含用途描述，用来展示在系统的提示框当中。如果你的app试图访问受保护的数据，而你并没有提供相应的用途描述的话，你的app将会推出。（这个行为同样适用于iMessage app，你必须在访问设备的摄像头和麦克风之前包含在列表1-2当中列出的相应的key）

对于一些受保护的数据和资源，iOS的框架提供了专用的API来检查和请求授权，这也在列表1-2当中罗列出来了。  
由于用户可以通过设置app随时改变授权，请在任何时候访问这些条目之前都检查授权状态（对于某些功能而言，比如运动类或者HomeKit，不要使用专用的API来检查系统授权状态，具体详见列表1-2）。  

列表 1-2 被系统授权设置保护的数据和资源

数据和资源  | Info.plist中的用途描述key | 系统授权API
------------- | ------------- | -------------
蓝牙外设  | NSBluetoothPeripheralUsageDescription | 使用蓝牙外设之前，请使用CBCentralManager类的state属性来检查系统授权状态。
日历数据  | NSCalendarsUsageDescription | 在访问日历数据之前，使用EKEventStore类的authorizationStatusForEntityType: 方法来检查系统授权状态。
相机  | NSCameraUsageDescription | 使用设备的相机之前，使用AVCaptureDeviceInput类的deviceInputWithDevice:error:方法来检查系统授权状态。
联系人  | NSContactsUsageDescription | 访问联系人数据之前，使用CNContactStore类的authorizationStatusForEntityType:方法来检查系统授权状态。
健康数据分享  | NSHealthShareUsageDescription | 访问健康类数据前，使用HKHealthStore类的authorizationStatusForType: 方法来检查系统授权状态。请求授权的话，使用requestAuthorizationToShareTypes:readTypes:completion:方法。
健康数据更新  | NSHealthUpdateUsageDescription | 请求健康数据前，使用HKHealthStore类的authorizationStatusForType:方法来检查系统授权状态。请求授权的话，使用requestAuthorizationToShareTypes:readTypes:completion:方法。
HomeKit  | NSHomeKitUsageDescription | 当你的app首次访问HMHomeManager类的属性时，系统会给用户展示一个请求授权的请求。
定位  | NSLocationAlwaysUsageDescription, NSLocationWhenInUseUsageDescription | 访问地理位置数据前，使用CLLocationManager类的authorizationStatus方法来检查系统授权状态。请求授权的话，使用requestWhenInUseAuthorization 或者 requestAlwaysAuthorization 方法。
麦克风 | NSMicrophoneUsageDescription | 使用设备的麦克风之前，使用AVAudioSession类的recordPermission方法来检测系统授权状态。请求授权的话，使用requestRecordPermission:方法。
运动 | NSMotionUsageDescription | 访问加速器之前，使用CMMotionActivityManager类的queryActivityStartingFromDate:toDate:toQueue:withHandler:方法，并检测CMErrorNotAuthorized这个error来检测系统授权状态。
音乐和媒体库 | NSAppleMusicUsageDescription | 访问媒体库之前，使用ALAssetsLibrary类的authorizationStatus方法来检测系统授权状态。
照片 | NSPhotoLibraryUsageDescription | 访问照片库之前，使用PHPhotoLibrary类的authorizationStatus方法来检测系统授权状态。
提醒事项 | NSRemindersUsageDescription | 访问提醒事项数据前，使用EKEventStore类的authorizationStatusForEntityType:方法来检查系统授权状态。
Siri | NSSiriUsageDescription | 使用Siri前，使用INPreferences类的 siriAuthorizationStatus方法来检测系统授权状态。为你的app请求使用SiriKit，使用requestSiriAuthorization:方法。
语音识别 | NSSpeechRecognitionUsageDescription | 使用语音识别前，使用SFSpeechRecognizer类的authorizationStatus方法来检测系统授权状态。为你的app请求使用语音识别授权，使用requestAuthorization方法。
电视服务提供商 | NSVideoSubscriberAccountUsageDescription | 访问用户视频服务订阅信息之前，使用VSAccountManager类的checkAccessStatusWithOptions:completionHandler:方法来检测系统授权状态。请求授权的话，使用enqueueResourceAuthorizationRequest:completionHandler:方法。

列表1-2的内容对于app的隐私访问行为只是一个开始，并不是一个完整的列表。这个列表将随着iOS系统的更新而更新。
## 国际化你的app
由于iOS的应用程序是在很多国家发布的，本地化你的app内容将帮助你获取更多的用户。用户更喜欢使用那些使用本地语言的本地化的应用程序。当你将你的用户界面内容分解为资源文件的时候，本地化内容与之相比就是很简单的一个过程了。  
在本地化你的内容之前，你必须将你的app国际化，以便它能够更好的促进本地化进程。国际化你的app包含分解你的用户界面内容为本地化资源文件以及提供指定的语言项目目录(.lproj)来存储该内容。这也意味着当你使用语言包以及本地化内容的时候，应该使用适当的技术（比如日期和数字格式化）。  
对于完全国际化的app来说，本地化的过程会生成新的语言包资源文件添加到你的工程当中。一个典型的iOS app需要以下几种类型文件的本地化版本：  

* 故事版文件（或者nib文件）——故事版文件能够包含文本标签和其他的需要本地化的内容。你可能还需要调整用户界面当中文本标签的位置来适应文本的长度。（同样的，nib文件也需要包含需要本地化的文本以及调整更新界面）。
* 字符串文件——字符串文件（所以它的文件名字的后缀是.strings）包含了你的app当中展示的静态文本的本地化版本。
* 图片文件——你应该避免本地化图片文件，除非图片包含文化特异性的内容。无论何时，你都应该避免在你的图片文件当中直接保存文本内容。对于那些在你的app当中需要用到和加载的图片，将文本保存在字符串文件当中，在运行时将该文本与你的基于图像的内容结合起来。
* 音视频文件——你应该避免本地化多媒体文件，除非它们包含语言的特殊性或者文化的特异性内容。举个例子，你可以本地化一个视频文件，它包含画外音解说。

更多关于本地化和国际化过程的相关信息，参见“国际化和本地化指南”。关于在你的app当中使用适当的资源文件的相关信息，参见“资源文件编程指南”。
# app生命周期
app是一个你自己的代码与系统框架相互调用的复杂的集合体。系统框架提供了基础的框架供所有的app运行，你的代码为你的app提供了定制化的基础架构，让你的app成为你想要的样子。为了能够有效的做到这一点，了解一些iOS的架构以及它是如何运作的是比较有帮助的。  
iOS系统框架的实现是依赖于MVC以及代理模式这种设计模式的。了解这些设计模式对于成功构建一个app至关重要。这同样对于OC编程语言和功能也会更加熟悉。如果你是一个iOS开发新手，请阅读“开始开发iOS app（Swift）”，这是一篇iOS app和OC语言的介绍文章。
## main函数
每个基于C的app的入口点都是一个main函数，iOS app也不例外。唯一的例外是对于iOS app而言，你无需自己编写main函数。Xcode将为你的基本工程创建该函数。清单2－1展示了该函数的例子。大多数情况下，你都不应该更改Xcode提供的main函数的实现。  

清单 2-1 iOS app的main函数  

>  #import <UIKit/UIKit.h>  
  #import "AppDelegate.h"  
int main(int argc, char * argv[])  
{  
    @autoreleasepool {  
        return UIApplicationMain(argc, argv, nil, NSStringFromClass([AppDelegate class]));  
    }  
}

main函数当中做的唯一的一件事是它控制了UIKit框架。UIApplicationMain函数通过创建你的app的核心对象来控制这一过程，从可用的 storyboard文件加载你的app的用户界面，调用你自己的代码以便你能够做自己想要的初始化工作，然后将app放入运行循环。你唯一需要做的就是提供 storyboard文件以及自定义初始化代码。
## app的结构
在启动期间，UIApplicationMain函数设置了几个关键的对象，然后开始app的运行。每个iOS app的核心都是一个UIApplication对象，它的作用是促进系统和app当中其他对象的沟通。图2-1展示了大部分app当中的通用对象，当列表2-1列出了每个对象扮演的角色。首先要注意的是，iOS app使用的是MVC架构。这个设计模式将app的数据与业务逻辑从展现它们的界面分离开来。这个架构对于创建能够运行在不同设备和不同屏幕尺寸上的app至关重要。  

图2-1 iOS app当中的关键对象  

![](https://developer.apple.com/library/content/documentation/iPhone/Conceptual/iPhoneOSProgrammingGuide/Art/core_objects_2x.png)  

列表2-1 iOS app当中的对象扮演的角色  

对象  | 描述
------------- | -------------
UIApplication对象 | UIApplication对象管理着事件循环以及高层的app行为。当一些关键的app转换场景以及特殊的场景（比如收到推送通知）发生的时候，它还会将这些事件传达给它的代理，这个代理是你自己定义的对象。请直接使用UIApplication对象，不要继承它。
App delegate对象 | app delegate是你的代码的核心。这个对象与UIApplication对象一起管理着app的初始化、状态转换和很多高层级的app行为。该对象在每个app当中仅出现一个，所以它被用来设置app的初始化数据结构。
文档和数据模型对象 | 数据模型对象存储了你的app的内容，并且是针对你的app的。举个例子，一个银行类的app可能会有一个数据库用来包含金融交易数据，然而一个绘图类的app可能保存一个图片对象或者保留一系列的绘画操作命令来创建图片。（在后一种情况下，一个图片仍旧是一个数据对象，因为它仅仅是一个图片数据的容器）。app还可以使用文档对象（继承自 UIDocument类）来管理一些或者所有的数据模型对象。文档对象不是必需的，但是它提供了一种简便方式来组织属于一个文件或者文件夹的数据。更多关于文档的相关信息，参见“基于文档的app编程指南”。
VC对象 | vc对象管理着你的app展示在屏幕上的内容。一个vc管理着一个单一的view以及一组子view。当展示出来的时候，vc通过初始化它的view到window上使之变得可用。UIViewController类是所有的vc对象的基类。它为加载view、展现view、旋转view以适应设备的旋转以及很多其他标准的系统行为提供了默认的实现。UIKit 以及其他的系统框架定义了额外的vc类来实现标准系统界面，比如图片选择器、页签界面以及导航界面。关于如何使用vc的相关信息，参见vc编程指南。
UIWindow对象 | UIWindow对象是屏幕上一个或多个view的协调者。大部分app都只有一个window用来展示内容到主屏幕上，不过app可以拥有一个额外的window用来展示内容到外接设备上。当改变你的app的内容的时候，你应当使用一个vc来改变对应的window上的view的显示。你永远不应该替换window本身。除了管理view之外，window还与UIApplication对象合作为你的view和vc传递事件。
view和control对象，以及layer对象 | view和control对象提供了你的app内容的可视化界面。view是一个在指定的矩形区域绘制内容以及在该区域响应事件的对象。Controls是一些响应实现常见的界面对象的view，包括按钮，输入框以及开关等。UIKit框架提供了标准的view来展示多种不同类型的内容。你还可以通过集成UIView或者它的子类来实现定制化的view。除了结合了view和control之外，app还可以将核心动画层加入到它们的view和control层级当中。Layer对象是数据对象的视觉展现表达。view使用layer对象在背后的场景当中渲染它们的内容。你还可以添加自定义的layer对象到你的界面来实现复杂的动画或者其他类型的复杂的视觉效果。

一个iOS app与其他app的区别是它管理的数据（以及它关联的业务逻辑）以及它展现给用户的数据。大部分与UIKit对象的交流没有定义你的app，但是帮助你改善了它的行为。举例来说，你的app的代理方法让你能够知道你的app什么时候会改变状态，你的代码应该能够响应对应的状态。
## 主运行循环
一个app的主运行循环处理了所有的用户相关的事件。UIApplication对象在启动时设置了主运行循环，并且使用它来处理事件以及处理基于view的界面更新。顾名思义，主运行循环处理的是app的主线程。这种方式保证了当接收到用户相关的事件的时候被连续的处理。  
图2-2展示了主运行循环的架构以及用户的行为事件如何在你的app当中运转。当用户与一台设备交互的时候，与这些交互相关的事件由系统生成并且通过一个UIKit设置的特殊的接口传输到app。事件由app内部进行排队然后一个一个分发到主运行循环执行。UIApplication对象是第一个接收到事件的对象，它会决定该如何处理。一个触摸事件通常被分发到主window对象，然后它会依次分发给view来响应触摸事件的发生。其他的事件可能对于不同的app对象而言传输路径稍有不同。  

图 2-2 在主运行循环中处理事件  

![](https://developer.apple.com/library/content/documentation/iPhone/Conceptual/iPhoneOSProgrammingGuide/Art/event_draw_cycle_a_2x.png)

iOS app当中可以传递很多种类型的事件。常用的事件在列表2-2当中列出来了。你的app当中会有很多种这些类型的事件通过主运行循环传递，不过有些不是这样的。有些事件被传递给了代理对象或者传递给了一个你提供的block。关于如何处理多种类型的事件（包括触摸，远程控制，动作，加速器以及陀螺仪事件）的相关信息，参见“UIKit apps事件处理指南。”  

列表2-2 iOS app的常用事件类型  

事件类型  | 传递给…… | 注意
------------- | ------------- | -------------
触摸 | 事件发生时候的view对象 | view就是响应者对象。任何触摸事件都不是被view持有的，而是沿着响应者链条向下传递来处理。
远程控制 震动事件 | 第一响应者对象 | 远程控制事件是由媒体回放控制的，并且由耳机和其他设备产生的。
加速器 陀螺仪 磁力计 | 你指派对象 | 和加速器、陀螺仪、磁力计硬件相关的事件会传送给你指派的对象
定位 | 你指派对象 | 你应当使用Core Location框架来注册接收定位事件。更多关于Core Location的相关信息，参见“定位以及地图编程指南”。
重新绘制 | 需要更新的view | 重新绘制事件并不包含事件对象，但是会直接调用view绘制它本身。iOS的绘制的架构在“iOS绘制和打印指南”中有相关描述。

有些事件，比如触摸和远程控制事件，是被你的app的响应者对象管理的。响应者对象在你的app当中随处可见。（UIApplication对象，你的view对象，以及你的VC对象都是响应者对象的例子）大部分事件以一个指定的响应者对象作为目标，但是如果想处理事件的话也可以被传递给其他的响应者对象（通过响应者链条）。举个例子，一个view不想处理事件它可以将事件传递给它的父view或者传递给一个VC。  
触摸事件发生在控件（比如按钮）上时与触摸事件发生在很多其他类型的view上的处理方式很不相同。只有有限的一些交互是发生在控件上的，所以这些交互被封装为action信息然后发送给对应的target对象。target-action设计模式在你的app当中使用控件来触发执行自定义代码变得简单。
## app的执行状态
在任何时刻，你的app都是处在列表2-3列出的状态之一当中。系统将你的app从一个状态转换到另一个状态来响应事件的发生贯穿系统始终。举个例子，当用户点击home键的时候，当有电话打入的时候，或者任何其他的能够打断的事件发生的时候，当前正在运行的app都会改变状态来响应。图2-3展示了一个app从一种状态转换到另一种状态的路径。  

列表2-3 app状态  

状态  | 描述
------------- | ------------- 
没有运行 | app没有加载或者虽然运行了但是被系统终止了
非活跃状态 | app正在前台运行，但是当前没有接收到事件（也可能在执行其他代码）一个app通常在从一个不同的状态转换的时候短暂的处于这种状态。
活跃状态 | app正在前台运行并且在接收事件。这是前台运行的app的常态。
后台运行 | app在后台，并且在执行代码。大部分app在它们被挂起的过程中会短暂的进入这一状态。不过，如果app请求额外的执行时间的话，它会在这种状态下停留一段时间。此外，一个app被直接加载到后台也会进入这种状态而不是进入到非活跃状态。关于如何在后台执行代码的相关信息，参见“后台执行”。
挂起 | app在后台，但是没有执行代码。系统会将app自动转移到这种状态并且在这样做之前不会通知它们。当被挂起的时候，app停留在内存当中，并且没有执行任何代码。当内存比较低的情况发生的时候，系统将清理挂起的app，并且不会提前通知，来为前台运行的app提供更多空间。

图2-3 iOS app当中的状态改变  

![](https://developer.apple.com/library/content/documentation/iPhone/Conceptual/iPhoneOSProgrammingGuide/Art/high_level_flow_2x.png)  

大部分状态的转换都伴随着相应的你的app delegate对象的方法调用。这些方法是你适当的响应状态改变的机会。这些方法在下面列出，并且附带一些你可能使用他们的摘要信息。  

* application:willFinishLaunchingWithOptions:——这个方法是你的app在加载过程当中的第一次执行代码的机会。
* application:didFinishLaunchingWithOptions:——在你的app展现在用户之前，该方法允许你执行最终的初始化。
* applicationDidBecomeActive:——让你的app知道将要变为前台的app了。在该方法中做最后一刻的准备。
* applicationWillResignActive:——让你知道你的app已经从前台app转换过来了。使用该方法让你的app进入静止状态。
* applicationDidEnterBackground:——让你知道你的app正在后台运行并且随时可能被挂起。
* applicationWillEnterForeground:——让你知道你的app已经从后台状态脱离并且准备进入到前台了，但是还没有到活跃状态。
* applicationWillTerminate:——让你知道你的app将被终止。如果你的app被挂起的话，该方法不会被调用。

## app终止
app必须准备好随时被终止并且不应该等到保存用户数据或者执行其他的关键任务。系统发起的终止过程是一个app的生命周期当中正常的一部分。系统通常终止app来回收内存为其他用户加载的app腾出空间，不过系统也会在必要时终止那些不合常规或者不响应事件的app。  
挂起的app在它们被终止的时候将不会收到任何通知；系统将杀掉进程然后回收相应的内存。如果一个app运行在后台，并且没有被挂起的话，系统在终止app之前将调用 app delegate 的applicationWillTerminate:方法。当设备重启的时候，系统也不会调用该方法。  
除了系统会终止你的app，用户也会在多任务处理界面当中直接杀掉你的app。用户发起的终止过程与终止挂起的app的效果相同。app进程被杀死，并且app不会接收到任何信息。
## 多线程和并发性
系统在主线程创建你的app，你还可以根据需要创建其他的线程来执行其他的任务。对于iOS app而言，首选的技术是使用GCD，operation对象以及其他的异步编程接口，而不是自己去创建管理线程。类似GCD这样的技术能够让你定义你想做的工作以及你想执行操作的顺序，不过由系统去决定何时才是使用CPU来执行这些操作的最佳时机。你必须编写让系统处理线程管理的简化代码，确保这些代码的正确性，提供整体性能的提高。  
当考虑线程和并发的时候，请考虑一下情况：  

* 涉及view，动画以及其他UIKit类的，必须发生在主线程当中。不过有一些例外——举个例子，基于图片的操作常常发生在后台线程——不过当不确定的时候，假设该任务需要发生在主线程上。
* 冗长的任务（或者潜在的冗长的任务）应该永远在后台线程执行。所有涉及到网络访问、文件访问或者其他的大量的数据处理的过程都应该使用GCD或者operation对象异步执行。
* 在启动过程中，尽可能将任务移出主线程。在启动的时候，你的app应该利用有限的时间尽快设置用户界面。只有和构建用户界面相关的任务才应该在主线程执行。其他的任务都应该异步执行，当准备好界面之后，尽快展示给用户。

更多关于使用GCD和operation对象来执行任务的相关信息，参见“并发编程指南”。
# 后台执行
当用户不太频繁的使用你的app的时候，系统将把你的app移动到后台模式。对于大多数app而言，后台模式只是app转移到挂起模式之间的一个短暂的状态。挂起app是一种增加电池寿命的方式，他也让系统能够将宝贵的系统资源转移到用户注意的前台app当中。  
大多数app都很容易就转移到挂起模式，但是出于某些很正常的原因，app也可以在后台运行。一款旅行类的app很可能需要通过时间来记录用户的位置，以便它能够在地图上展示用户的轨迹。一款音频类的app很可能在锁屏的时候依旧需要播放音乐。其他的app也很可能希望在后台下载数据以便减少給用户展现内容的延迟。当你发现你有必要将你的app在后台运行的时候，iOS能够高效的帮助你这么做，并且不会消耗系统资源以及用户的电池电量。iOS提供的这种技术分为三种类型：  

* app在前台开始了一个比较简短的任务，请求一段时间来完成，然后app被移到了后台。
* app在前台初始化下载任务，可以将这些任务切换给系统管理，所以当下载内容的时候，app可以被挂起或者终止。
* app需要运行在后台来支持某种特殊类型的任务，app可以声明对于这些后台执行模式的支持。

应当避免在后台处理任务，除非这样做可以提升用户体验。app在用户加载其他的app或者由于设备锁定不能够使用的时候会移到后台。不管是什么情况，用户都会告诉你的app，你现在暂时不会做什么我需要的工作了。在这种情况下继续运行只会耗费设备的电量并且会让用户被迫中止你的app。所以应当尽量避免在后台工作。
## 执行有限长度的任务
移到后台的app希望它们能够尽快进入静止状态以便能够被系统挂起。如果你的app是在执行任务当中，并且需要一些额外的时间来完成任务的话，你可以调用UIApplication对象的 beginBackgroundTaskWithName:expirationHandler: 或着 beginBackgroundTaskWithExpirationHandler: 方法来请求一些额外的时间。不管调用这些方法的哪个，都会延迟你的app被临时挂起，给予你的app一些额外的时间来完成工作。一旦完成那些工作，你的app必须调用 endBackgroundTask: 方法来让系统知道工作已经完成，可以被挂起了。  
每个调用beginBackgroundTaskWithName:expirationHandler: 或者 beginBackgroundTaskWithExpirationHandler:方法的任务都会生成一个唯一的token来关联相关的任务。当你的app完成任务的时候，你必须调用endBackgroundTask: 方法与相关的token来让系统知道任务已经完成了。对于后台任务而言，调用endBackgroundTask:方法失败会导致你的app终止。如果你在任务开始的时候提供了终止方法的话，系统会调用该方法，然后给予你最后的机会终止任务，避免app被杀掉。  
你无须等到你的app移到后台之后才指定后台任务。一个比较好的设计是在开始任务前就调用beginBackgroundTaskWithName:expirationHandler: 或者 beginBackgroundTaskWithExpirationHandler: 方法，然后在你完成任务后立刻调用 endBackgroundTask: 方法。你甚至可以在你的app运行在前台的时候就采用这种模式。  
清单3-1展示了如何在你的app转到后台运行的时候开始一个长时间运行的任务。在这个示例当中，请求开始一个后台任务包含了一个终止处理回调，以免任务运行的过久。任务本身被提交到一个分发队列异步执行，所以applicationDidEnterBackground: 方法可以正常返回。使用block简化了需要关注引用任何重要变量的代码，比如后台任务的ID。bgTask变量是一个存储了指向当前后台任务ID的类的成员变量，并且在使用方法之前就被初始化了。  

清单 3-1 在退出前开始一个后台任务  
> -(void)applicationDidEnterBackground:(UIApplication *)application  
{  
    bgTask = [application beginBackgroundTaskWithName:@"MyTask" expirationHandler:^{  
        // Clean up any unfinished task business by marking where you  
        // stopped or ending the task outright.  
        [application endBackgroundTask:bgTask];  
        bgTask = UIBackgroundTaskInvalid;  
    }];  
    // Start the long-running task and return immediately.  
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{  
        // Do the work associated with the task, preferably in chunks.  
        [application endBackgroundTask:bgTask];  
        bgTask = UIBackgroundTaskInvalid;  
    });  
}  

	注意：在开始一个任务前，永远应当提供一个终止回调方法，不过如果你想要知道你的app还剩多少时间运行的话，获取 UIApplication 的 backgroundTimeRemaining 属性就可以了。

在你自己的终止回调方法当中，你可以包含额外的代码关闭你的任务。不过，任何你包含的代码都不能花费过长的时间来执行，因为当你的终止回调方法被调用的时候，你的app已经非常接近要被终止的时机了。出于这个原因，你应当执行最小限度的清理状态信息以及终止任务的代码。
## 在后台下载内容
当下载文件的时候，app应该使用NSURLSession类的对象来开始下载，以便让系统能够在app被挂起或者终止的时候管理下载过程。当你为后台传输配置一个NSURLSession对象的时候，系统在一个单独的进程当中管理这些传输过程，并且将状态以通用的方式通知给你的app。如果你的app在传输过程中被终止了，系统将会在后台继续下载内容，并且当下载完毕或者当一个或很多个任务需要你的app注意的时候加载你的app。  
为了支持后台传输内容，你必须适当的配置你的NSURLSession对象。首先你必须要创建一个NSURLSessionConfiguration对象，设置它的几个属性。然后将该对象传递给NSURLSession的初始化方法来初始化你自己的session。  
创建一个支持后台下载的configuration对象的过程如下：  

1. 使用NSURLSessionConfiguration 类的backgroundSessionConfigurationWithIdentifier:方法创建一个configuration对象。
2. 设置configuration对象的sessionSendsLaunchEvents属性为YES。
3. 如果你的app在前台的时候就开始下载，推荐将configuration 的discretionary也设置为YES。
4. 配置其余的configuration对象的属性。
5. 使用configuration创建你自己的NSURLSession对象。

一旦配置完毕，你的NSURLSession对象将无需干涉上传下载任务，系统将在适当的时机做这件事。如果在你的app还在运行的时候（不论在前台还是后台）下载完了，session对象都会通知它的代理对象。如果内容还没有下载完，系统就中止了你的app，那么系统会自动的继续在后台管理任务。如果用户杀掉了你的app，系统将取消所有的未下载的任务。  
当和后台的session相关的所有的任务都完成了，系统将重新启动一个中止的app（假设sessionSendsLaunchEvents属性被设置为了YES，并且用户没有强制杀死app）并且调用app delegate的application:handleEventsForBackgroundURLSession:completionHandler: 方法。（系统也会在需要鉴权或者其他的需要引起你的app重视的任务相关事件的时候重新启动你的app）如果你实现了该代理方法的话，使用提供的ID以及和之前同样的配置来创建一个新的NSURLSessionConfiguration和NSURLSessionConfiguration对象。系统会重新连接你创建的新的session对象和之前的任务，并且将之前任务的状态告知给session对象的代理方法。
## 实现一直运行的任务
对于那些需要更多执行时间来实现的任务，你必须请求允许在后台运行它们而不被挂起。在iOS当中，只有几种特殊的app类型能够被允许在后台运行：  

* 在后台给用户播放能够听到内容的app，比如音乐播放器app
* 在后台录制音频的app
* 需要一直获取用户位置的，比如导航类app
* 需要支持IP电话的
* 需要定期下载和处理新内容的
* 需要定期从外接设备接受更新的

实现这些服务的app必须声明支持这些服务，并且使用系统框架来实现这些服务的相关方面。声明这些服务让系统能够知道你用到了哪些服务，不过某些情况下这也让系统框架能够避免你的app被挂起。
### 声明你的app支持后台任务
支持某些类型的后台运行必须在app使用它之前进行声明。在Xcode5以及之后的版本中，你可以在工程设置当中的“Capabilities”页签栏当中声明你的app支持的后台模式。将后台模式的选项添加到Info.plist文件当中的UIBackgroundModes key当中。选择一个或者多个选项添加相关的后台模式值到对应的key上。列表3-1列出了你可以指定的后台模式以及Xcode在你的app当中的Info.plist中赋值给UIBackgroundModes的值。  

列表 3-1 app后台模式  

Xcode后台模式 | UIBackgroundModes对应值 | 描述
------------- | ------------- | ------------- 
音频和AirPlay | audio | app在后台时为用户播放或者录制音频内容。（内容包括音频流或者使用AirPlay的视频内容）用户必须在首次使用麦克风之前允许app使用该权限；更多信息参见“支持用户隐私”。
位置更新 | location | app跟踪用户的位置信息，甚至在后台运行的时候。
网络IP电话 | voip | app为用户提供通过网络打电话的能力。
新闻杂志下载 | newsstand-content | app属于新闻杂志类的app，在后台下载新闻杂志内容。
外部设备连接 | external-accessory | app与外部硬件设备链接，硬件设备需要定期通过“外部设备框架”来更新内容。
使用蓝牙外部设备 | bluetooth-central | app与外部蓝牙设备链接，蓝牙设备需要定期通过“核心蓝牙框架”来更新内容。
充当蓝牙设备 | bluetooth-peripheral | app通过外部模式的核心蓝牙框架来支持蓝牙连接。使用该模式需要用户授权；更多信息参考“支持用户隐私”。
后台下载 | fetch | app定期从网络下载少量更新。
远程通知 | remote-notification | 当收到通知后，app希望开始下载内容。使用该通知使得展示推送通知相关的内容延迟最小化。

前文所述的每个模式都让系统知道你的app应该在适当的时机被唤醒或者加载以响应相关的事件。举个例子，一款app开始播放音乐，然后移到后台需要时间来执行填充音频输出流的代码。打开音频模式告诉系统框架，它需要在适当的间隔下继续播放。如果app没有选择这个模式的话，在app移到后台的时候，任何音频播放或者录制都会被app停止。
### 跟踪用户的位置

### 后台播放或录制音频

### 实现网络电话app

### 适时的获取小量的数据

### 使用推送来激活下载

### 在后台下载报刊内容

### 与外部的配件进行交互

### 与蓝牙配件进行交互

## 当在后台运行的时候获取用户的注意
通知是在app被挂起、在后台或者没有运行的时候获取用户注意的一种方式。app可以使用本地的通知来展示提示框、播放声音、app icon上的未读提示或者三者都有。举个例子，一个闹钟类的app可能用本地通知来播放一个闹铃然后展示一个提示框来取消闹钟。当一个通知发送给用户之后，用户必须决定收到的信息是否要授权将app返回到前台。（如果app已经在前台运行的话，那么本地通知应该发送给app本身，而不是给用户。） 
如果想按照预定时间展示本地通知的话，创建一个UILocalNotification类的实例对象，配置通知的相关参数，然后使用UIApplication类的方法来进行配置。本地通知对象包含了各种通知信息的内容（声音、提示或者红点）以及时间设置（合适的时机）来交付通知。UIApplication类的方法为立即展示通知还是预定展示提供了选项。  
清单3-2展示了用户使用日期和时间设置一个闹铃的例子。该示例只设置了一个闹铃并且在设置一个新闹铃之前取消了之前的闹铃。（你的app可以在给定时间内设置展示128个本地通知，每个通知都可以在指定的间隔下重复。）闹铃本身由警示框和一个声音文件组成，声音文件可以在app没有运行或者在后台运行的时候由闹铃唤起。如果app在前台运行中，app的代理事件application:didReceiveLocalNotification:方法会被调用。  

清单3-2 设置一个闹钟提醒  

> - (void)scheduleAlarmForDate:(NSDate*)theDate  
{. 
    UIApplication* app = [UIApplication sharedApplication];  
    NSArray*    oldNotifications = [app scheduledLocalNotifications];  
    // Clear out the old notification before scheduling a new one.  
    if ([oldNotifications count] > 0). 
        [app cancelAllLocalNotifications];  
    // Create a new notification.  
    UILocalNotification* alarm = [[UILocalNotification alloc] init];  
    if (alarm)  
    {  
        alarm.fireDate = theDate;  
        alarm.timeZone = [NSTimeZone defaultTimeZone];  
        alarm.repeatInterval = 0;  
        alarm.soundName = @"alarmsound.caf";  
        alarm.alertBody = @"Time to wake up!";  
        [app scheduleLocalNotification:alarm];  
    }  
}  

与本地通知一起使用的声音文件和推送通知的需求相同。自定义的声音文件必需包含在你的app主程序包当中，并且必需是以下格式的其中一种：Linear PCM, MA4, µ-Law, 或者 a-Law。你还可以指定UILocalNotificationDefaultSoundName为默认的设备播放警告声音。当通知被发送，声音播放的时候，系统会在支持震动的机型上发起震动。  
你还可以使用UIApplication类的方法来取消设定好的通知或者一系列通知。更多关于这些方法的信息，参见“UIApplication类参考”。更多关于配置本地通知的相关信息，参见“本地和远程通知编程指南”。
## 理解当你的app加载到后台的时候

## 做一个能够在后台响应的app

## 在后台运行之外的选择

# app状态转换策略控制

## 在加载的时候发生了什么？

### 加载循环

### 以水平模式加载

### 在第一次加载的时候，安装app指定的数据文件

## 当你的app被打断的时候，你应该做什么？

### 响应临时的打断

## 当你的app进入前台的时候，你应该做什么？

### 准备好处理消息队列

### 处理iCloud变更

### 处理地理位置变更

### 处理app设置变更

## 当你的app进入到后台的时候，你应该做什么？

### 后台转换循环

### 为app快照做准备

### 减少你的内存占用

# 实现定制的app功能策略

## 隐私策略

### 使用磁盘加密来保护数据

### 你app的用户唯一ID

## 考虑限制条件

## 支持多个iOS版本

## 通过启动图保存你的app的界面

### 在你的app当中授权状态保留和恢复

### 保存和恢复的过程

### 在你排除一组VC的时候，发生了什么？

### 实现状态保留和恢复的核对表

### 在你的app当中授权状态保留和恢复

### 保存你的VC的状态

### 保存你的视图的状态

### 保存你的app的高水平的状态

### 保存和恢复状态信息的一些小贴示

## 开发网络电话app的一些小贴示

### 使用Reachability接口来提高用户体验

# app内部通讯

## 支持AirDrop

### 发送文件和数据给其他的app

### 接收发送给你的app的文件和数据

## 与app之间使用URL Schemes进行通信

### 给其他的app发送URL

### 实现自定义的URL Schemes

### 当一个URL打开的时候，展示一个自定义的加载图

# 性能调试提示

## 减少你的app的电源消耗

## 高效的使用内存

### 检测低内存警告

### 减少你的app的内存占用

### 精致的分配你的内存

## 调整你的网络层代码

### 有效率的网络层贴士

### 使用Wi-Fi

### 飞行模式警告

## 改善你的文件管理

## 更高效的使用app备份

### app备份最佳实践

### 在app升级期间保存文件

## 清理主线程的工作