[View Controller Programming Guide for iOS 原文链接](https://developer.apple.com/library/content/featuredarticles/ViewControllerPGforiPhoneOS/index.html#//apple_ref/doc/uid/TP40007457)

# 概览
## 视图控制器所扮演的角色
视图控制器是你的应用程序内部架构的基础。每个应用程序都至少含有一个视图控制器，大部分应用程序都有很多个。每个应用程序都会管理着一份你的应用程序的用户界面以及该用户界面与底层数据的交互。视图控制器同样也会改善不同的视图界面之间转换的过渡。  
由于它在你的应用程序当中扮演着如此重要的角色，视图控制器几乎会成为你做任何事的中心。UIViewController类定义了很多方法和属性来管理你的视图，处理事件，从一个视图控制器过渡到另一个以及协调你的应用程序的其他部分。你可以继承UIViewController（或者继承它的子类）然后添加自己需要实现的行为的代码即可。  
一共有两种类型的视图控制器：  

* 内容类的视图控制器管理着你的应用程序的分散的内容，它是你主要创建的视图控制器。
* 容器类视图控制器从其他的视图控制器收集信息（被称作子视图控制器）以一种简便的导航方式展示出来或者以不同的模态方式展示这些视图控制器的内容。

大部分应用程序是这两种类型视图控制器的混合体。
### 视图的管理
一个视图控制器的最重要的角色是管理视图的层级。每个视图控制器都拥有一个根视图，它将所有的视图控制器的内容都封装进去。通过这个根视图，你可以添加你需要展示的视图内容。图1-1展示了视图控制器和它的视图之间的内部关系。视图控制器将一直持有根视图，并且每个视图对于它的子视图都是强引用。  

图1-1 视图控制器和它的视图之间的关系  

![](https://developer.apple.com/library/content/featuredarticles/ViewControllerPGforiPhoneOS/Art/VCPG_ControllerHierarchy_fig_1-1_2x.png)

	注意：通常使用outlets来访问在你的视图控制器层级当中的其它视图。由于一个视图控制器管理着所有它的视图的内容，outlets能够让你持有你需要的视图的引用。outlets本身在视图被从故事版加载的时候自动连接到了实际的视图对象。  

内容类的视图控制器通过它本身来管理所有的视图。容器类的视图控制器管理它本身的视图以及一个或多个子视图的根视图。容器类本身不会管理它的子视图的内容。它仅仅管理根视图，调整尺寸并根据容器的设计来布局。图1-2展示了一个split视图控制器以及它的子视图之间的关系。split视图控制器管理了它的子视图的总体尺寸和位置，但是子视图控制器管理了这些视图的实际内容。

图1-2 视图控制器能够管理其它视图控制器的内容

![](https://developer.apple.com/library/content/featuredarticles/ViewControllerPGforiPhoneOS/Art/VCPG_ContainerViewController_fig_1-2_2x.png)  

更多关于管理你的视图控制器视图的相关信息，参见“管理视图布局”。

### 数据的封装
一个视图控制器在它管理的视图和你的应用程序的数据之间起到了一个调度的作用。UIViewController类的方法和属性能够让你管理你的应用程序的可视化部分。当你继承UIViewController类的时候，你可以添加任何你需要管理的数据的变量到你的子类当中。添加一个自定义的变量会创建一个类似于图1-3当中的关系，当视图控制器持有你的数据时，视图将会用它来展示那个数据。你要负责将数据从两者之间进行传递。  

图1-3 一个视图控制器在数据对象和视图对象之间进行调度

![](https://developer.apple.com/library/content/featuredarticles/ViewControllerPGforiPhoneOS/Art/VCPG_CustomSubclasses_fig_1-3_2x.png)

你应当在你的视图控制器和数据对象之间始终维护一个清晰的责任关系。大部分确认数据结构完整性的逻辑都应该在数据对象当中实现。视图控制器可能会需要验证从视图当中输入的内容，然后将其打包成你的数据需要的格式，但是你应该确保视图控制器在管理实际数据的过程中担任尽量少的角色。  
UIDocument对象是一种能够让数据与你的视图控制器分离的管理方式。文档对象是一个控制器对象，它知道如何永久存储一个可读写的数据。当你继承它时，你可以添加任何你需要的逻辑和方法来处理数据，你可以将其传递到一个视图控制器或者你的应用程序的其他部分。视图控制器可能会保留一份它接收到的数据的拷贝，以便将其更容易的更新到视图上，不过文档本身还是拥有实际的数据。
### 用户的交互
视图控制器是响应类型的对象，并且能够处理从响应者链条中传递过来的事件。尽管它能够这么做，但是视图控制器很少直接处理触摸事件。通常，是由视图来处理它们本身的触摸事件，然后将其结果发送给一个相关的代理方法或者目标对象，通常是一个视图控制器。所以大部分在视图控制器当中的事件都是使用代理方法或者目标函数来处理的。  
更多关于在视图控制器当中实现目标函数的相关信息，参见“处理用户交互”。更多关于处理其他类型的事件的相关信息，参见“iOS事件处理指南”。
### 资源的管理
视图控制器对其视图及其创建的任何对象承担全部责任。UIViewController类会自动的处理视图管理的大部分内容。举例来说，UIKit自动处理不再需要的视图相关的资源。在你的UIViewController子类当中，你应当管理所有由你创建的对象。  
当可用的内存较少的时候，UIKit会要求应用程序释放任何不再需要的资源。其中一种方式是调用你的视图控制器当中的didReceiveMemoryWarning方法。使用该方法来移除你不再需要的对象的引用或在以后重新创建。比如，你可以使用该方法移除缓存的数据。当发生低内存警告的时候，尽你所能的释放更多的内存是很重要的。应用程序如果消耗过多的内存的话，可能会被系统完全终止来释放内存。
### 自适应性
视图控制器要负责展示它的视图，并且要适配那些展示的视图来匹配底层环境。每款iOS的应用程序都应该能够运行在iPad上以及不同尺寸的iPhone手机上。使用一个单一的视图控制器来适配它的视图来改变空间所需更为简单，而不是为不同的设备提供很多的视图控制器和视图层级。  
在iOS上，视图控制器要处理各种粗细粒度的尺寸变更。当一个视图控制器的特性发生改变的时候会有粗粒度的变更。特性是用来描述整体环境的一种属性，比如展示的缩放。视图控制器有两个非常重要的特性就是垂直方向和水平方向的尺寸控制类，它们表示视图控制器在给定的尺寸当中有多少空间能够用来展示。你可以使用尺寸类的变更来作为改变你的视图布局的方式，如图1-4所示。当水平尺寸控制类为regular（分散对齐）的时候，视图控制器会利用额外的水平空间来布局它的内容。当水平尺寸控制类为compact（紧凑对齐）的时候，视图控制器会对其内容进行垂直布局。  

图1-4 适配视图来进行尺寸类变更
![](https://developer.apple.com/library/content/featuredarticles/ViewControllerPGforiPhoneOS/Art/VCPG_SizeClassChanges_fig_1-4_2x.png)  

在一个给定的尺寸类当中，随时都会发生很多的细粒度的尺寸变更。当用户将iPhone从竖直方向转为水平方向，尺寸类可能不会改变，而屏幕的尺寸通常会变更。当你使用自动布局的时候，UIKit自动的调整视图的尺寸和位置来匹配新的尺寸。视图控制器可以根据需要来进行额外的调整。  
更多关于自适应性的相关信息，参见“自适应模型”。
## 视图控制器的层级结构
你的应用程序当中的视图控制器之间的关系定义了每个视图控制器所需要的行为。UIKit框架期望你以规定的方式来使用视图控制器。维持视图控制器之间适当的关系，确保在视图控制器被需要的时候能够自动调用适当的行为发送给对应的视图控制器。如果你打破了规定的包含和展示关系，你的应用程序的某些部分将会不出意外的停止某些行为。
### 根视图控制器
根视图控制器是视图控制器层级的根节点。每个窗口都拥有一个根视图控制器，它的内容会填充该窗口。根视图控制器定义了最初能够被用户所见的内容。图2-1展示了根视图控制器和窗口之前的关系。由于窗口本身没有能够展示的内容，视图控制器的视图提供了所有它的内容来展示。  

图2-1 根视图控制器
![](https://developer.apple.com/library/content/featuredarticles/ViewControllerPGforiPhoneOS/Art/VCPG-root-view-controller_2-1_2x.png)  

UIWindow对象的rootViewController属性可以用来让根视图控制器访问。当你使用故事版来配置你的视图控制器的时候，UIKit会在启动的时候自动的设置这个属性的值。对于代码创建的窗口而言，你必须自己设置根视图控制器。
### 容器视图控制器
容器视图控制器使你可以更易于管理可重用的部分组装复杂的界面。一个容器视图控制器结合了一个或多个子视图控制器和一些自定义的视图内容来创建最终的界面。举例来说，一个UINavigationController对象展示了一个子视图控制器的内容和一个导航栏以及一个可选的工具栏，它们都是被导航控制器所管理的。UIKit包含了多种容器类的视图控制器，包括UINavigationController，UISplitViewController， 和 UIPageViewController。  
一个容器类视图控制器的视图会将给予它的空间全部填满。容器视图控制器通常在一个窗口当中作为根视图控制器（如图2-2所示），不过它们同样可以被模态展示或者作为其他容器的子视图控制器。容器负责将它的子视图布置到合适的位置。在视图当中，容器将两个子视图并排放置。尽管它依附于容器界面，子视图控制器会尽少的和容器以及并排的视图控制器关联。

图2-2 容器扮演根视图控制器的角色  
![](https://developer.apple.com/library/content/featuredarticles/ViewControllerPGforiPhoneOS/Art/VCPG-container-acting-as-root-view-controller_2-2_2x.png)

由于容器视图控制器管理着它的子类，UIKit为如何在自定义容器中设置这些子类定义了规则。关于如何创建一个自定义容器视图控制器的详细信息，参见“实现一个容器视图控制器”。
### 展现视图控制器
展现一个视图控制器会用它的新的内容取代当前视图控制器的内容，通常会隐藏之前视图控制器的内容。展示的形式通常用于展现新内容模式。举例来说，你可能会展示一个视图控制器来收集用户的输入。你还可以使用它来作为你的应用程序界面的一个通用的构建模块。  
当你展现一个视图控制器的时候，UIKit会在展现的的视图控制器和被展现的视图控制器之间建立关系，如图2-3所示。(这在从被展现的视图控制器返回展现的视图控制器之间是一对相反的关系。)这种关系是组成视图控制器层级关系的一部分，同样也是在运行时定位其他视图控制器的一种方式。  

图2-3 展现视图控制器
![](https://developer.apple.com/library/content/featuredarticles/ViewControllerPGforiPhoneOS/Art/VCPG-presented-view-controllers_2-3_2x.png)  

当有容器类视图控制器参与的时候，UIKit可能会修改展示链来简化你必须编写的代码。不同的展现样式会有不同的规则来决定它们如何被展示在屏幕上——举例来说，全屏的展现通常会覆盖整个屏幕。当你展现一个视图控制器的时候，UIKit会找到一个提供适合上下文的视图控制器用来展现。在大多数情况下，UIKit会选择最近的容器视图控制器，不过也可能会选择窗口的根视图控制器。在某些情况下，你还能够告诉UIKit哪个视图控制器定义了展现的上下文，并且它应该处理展现的逻辑。  
图2-4展示了为什么容器通常会为展现提供上下文。当执行全屏幕展现的时候，新的视图控制器需要覆盖整个屏幕。容器决定是否处理展现逻辑，子视图无需知道它的容器的边界。由于示例中的导航控制器涵盖整个屏幕, 因此它充当展现视图控制器并负责初始化展现逻辑。

图2-4 一个容器和一个展现的视图控制器
![](https://developer.apple.com/library/content/featuredarticles/ViewControllerPGforiPhoneOS/Art/VCPG-container-and-presented-view-controller_2-4_2x.png)  

更多关于展现的相关信息，参见“展现和转换过程”部分。
## 设计指南
视图控制器作为应用程序运行在iOS上的基本工具，UIKit对于视图控制器的基本架构使得创建复杂界面极为简单，而无需编写大量的代码。当实现你自己的视图控制器的时候，请采取以下的建议和指南以确保您不会执行可能干扰系统所期望的自然行为的操作。
### 尽量使用系统支持的视图控制器
很多iOS的框架都定义了视图控制器来让你用在你的应用程序当中。使用这些系统提供的视图控制器能够节省你的时间，并且能够为用户提供始终如一的体验。  
大部分系统的视图控制器都是为特定任务设计的。某些视图控制器提供访问用户的数据功能，比如通讯录。还有的视图控制器会提供访问硬件的功能，或者提供对于媒体管理进行相关调试的界面。比如UIKit当中的UIImagePickerController类展示了一个标准界面来拍摄照片和视频，并且可以用它来访问用户的相机胶卷。  
在你创建你自定义的视图控制器之前，最好先查看一下已有的框架当中是否存在你要执行的任务的相关视图控制器。  

* UIKit框架提供了视图控制器来展示警告框，拍摄视频和照片以及管理在iCloud上的文件。UIKit同样定义了很多容器视图控制器，你可以用来管理你的内容。
* GameKit提供了视图控制器来匹配玩家和管理排行榜，成就榜以及其它游戏相关的功能。
* Address Book UI（地址簿）框架提供了视图控制器来展示和选择通讯录相关信息。
* MediaPlayer（媒体）框架提供了视图控制器来播放和管理视频，还可以通过它来选择用户相册中的媒体数据。
* EventKit UI（日历）框架提供了视图控制器来展示和编辑用户的日历数据。
* GLKit框架提供了视图控制器来管理OpenGL渲染层。
* Multipeer Connectivity（多点连接）框架提供了视图控制器来检测其它用户的状态，并邀请连接。
* Message UI（消息）框架提供了视图控制器来编写邮件和短信息。
* PassKit框架提供了视图控制器展示护照和添加护照到护照本当中。
* Social框架提供了视图控制器来为twitter，Facebook和其它的社交媒体的发布信息进行排版。
* AVFoundation框架提供了视图控制器来展示媒体数据。
	
> 重要  
> 永远不要修改系统提供的视图控制器的视图层级。每个视图控制器都有它自己的视图层级，并且它会负责维护该层级的完整性。进行更改可能会将 bug 引入到代码中, 或阻止拥有视图控制器正常运行。在使用系统提供的视图控制器的时候，你应当一直依赖使用视图控制器提供的公共方法和属性来进行修改。

更多的使用特定的视图控制器的相关信息，参见相应的框架的相关文档。

### 尽量使每个视图控制器孤立
视图控制器应当始终是一个独立的对象。任何视图控制器都不应该知晓其它的视图控制器的内部工作以及视图结构。在两个视图控制器需要交互或者来回传递数据的情况下，它们应当使用明确定义的公共接口来做这件事。  
代理模式会在视图控制器的交互管理当中被频繁的使用。通过代理方式，一个对象会定义一个协议来与它相关的代理对象通信，任何对象都可以遵循协议。代理对象的类型的确定性并不重要。重要的是它实现了协议中的方法。
### 使用根视图的时候，将其仅作为其它视图的容器
应当使用你的视图控制器的根视图仅仅作为你的内容的容器。使用根视图作为容器会让你的视图拥有一个共用的父视图，这会让很多布局操作更为简单。很多自动布局的约束需要一个共用的父视图来对视图进行适当的布局。
### 要知晓你的数据的生命周期
在模型－视图－控制器这种设计模式当中，视图控制器所扮演的角色是促进数据在你的模型对象和你的视图对象之间移动。一个视图控制器可能会存储某些临时变量数据或者执行某些验证，但是它的主要责任是确保它的视图包含了确定的信息。你的数据对象要负责管理实际的数据，并且确保那些数据的完整性。  
一个数据与界面分离的例子是 UIDocument 和 UIViewController 类之间的关系。特别的是，没有默认的关系存在于它们两者之间。当一个UIViewController对象展示视图到屏幕上的时候，UIDocument对象负责加载和保存数据。当你在这两个对象之间建立联系的时候，要记住，视图控制器只为了效率才从document缓存信息。实际的数据依旧属于document对象。
### 要适应改变
应用程序很可能运行在各种iOS设备上，那么视图控制器也会被设计成适应不同尺寸的设备的屏幕。你可以使用你的视图控制器中内置的适配支持来响应尺寸类的变更，而无需使用不同的视图控制器来管理不同屏幕上的内容。UIKit会发送通知来给你适当的机会来放大或缩小来改变你的用户界面，而无需改变你的视图控制器当中的其它的代码。  
更多关于适配变更的相关信息，参见“适配模型”。
# 视图控制器的定义
## 定义你的子类
使用 UIViewController 的子类来展示你的应用程序的内容。大部分自定义的视图控制器都是内容视图控制器——意思是它们拥有所有相关视图和负责这些视图上的数据展示。相比之下，容器视图控制器不拥有全部的相关视图；这些视图当中的一部分被其他的视图控制器管理。定义内容类和容器类视图控制器的大部分步骤都是类似的，这会在后续章节当中进行讨论。  
对于内容视图控制器，比较通用的父类是以下几种：  

* 你的视图控制器主要是展示一个列表的时候，继承UITableViewController
* 你的视图控制器主要是展示一个表格的时候，继承UICollectionViewController
* 对于其他的视图控制器继承UIViewController

对于容器类视图控制器，父类取决于你是在修改一个已经存在的容器类还是创建你自己的。对于已经存在的容器，你可以任意选择已经存在的容器类来修改。对于你创建的新的容器视图控制器，通常继承于UIViewController。关于创建一个容器视图控制器的相关信息，参见“实现一个容器类视图控制器”。
### 定义你的UI
你可以使用Xcode的故事版来为你的视图控制器可视化的定制UI。尽管你可以使用代码的方式创建你的UI界面，但是故事版是一种非常好的方式来可视化的编辑你的视图控制器的内容，并且可以根据不同的环境定制视图层级（根据需要）。可视化的构建UI界面，能让你更快速的响应变化，让你无需构建和运行你的应用程序就能够看到结果。  
图4-1展示了一个故事版的例子。每个矩形的区域都代表了一个视图控制器以及它关联的视图。视图控制器之间的箭头代表了视图控制器的关系和转场。Relationships链接了一个容器视图控制器和它的子视图控制器。Segues让你能够在你的界面当中在视图控制器之间导航。    

图4-1 故事版处理一批视图控制器和视图
![](https://developer.apple.com/library/content/featuredarticles/ViewControllerPGforiPhoneOS/Art/storyboard_bird_sightings_2x.png)  

每个新建的工程都会有一个主故事版，它通常会包含一个或多个视图控制器。你可以通过从库中拖拽一个新的视图控制器到你的故事版中达到添加的目的。新的视图控制器在创建的时候不会关联它的相关类，所以你必须使用身份匹配功能来为它赋值。  
使用故事版编辑器可以做以下功能：  

* 为视图控制器的视图添加，调整以及配置。
* 连接接口和行为；参见“处理用户交互”。
* 在视图控制器之间创建关系和转场；参见“使用Segues”。
* 为不同的尺寸类定制布局和视图；参见“构建一个适配的界面”。
* 添加手势识别来处理用户与视图之间的交互；参见“iOS事件处理指南”。

如果你是使用故事版来构建你的界面的新手，你可以在“从现在开始开发iOS应用程序”中找到创建基于故事版的界面的步骤说明。
### 处理用户的交互
一款应用程序的响应者对象会处理外来事件并给予合适的执行方法。尽管视图控制器就是响应者对象，但它们很少直接处理触摸事件。通常，视图控制器会以以下几种方式来处理事件。  

* 视图控制器会定义响应方法来处理高优先级的事件。响应方法会响应：  
	* 指定的事件。控件和其他的视图会调用响应方法来报告指定的交互。
	* 手势。手势会调用一个响应方法来报告当前的手势状态。使用你的视图控制器来处理手势的状态变更或者响应完整的手势。
* 视图控制器会监听由系统或其他对象发出的通知。通知会报告状态的变化，这是视图控制器更新状态的一种时机。
* 视图控制器会担当其他对象的数据源或者代理。视图控制器通常被用来管理列表和表单视图的数据。你还可以使用它来作为一个对象（例如 CLLocationManager 对象）的代理，后者会发送地理位置的更新数据给它的代理。  

响应事件通常包含更新视图的内容，这需要关联这些视图。你的视图控制器是定义你稍后要修改的视图的绝佳位置。使用清单4-1当中的语句来声明你的outlets作为属性。清单中的自定义类定义了两个outlets（被称作IBOutlet关键字）以及一个动作方法（被称作IBAction返回类型）。outlets存储在故事版当中，关联到了一个按钮和一个输入框，动作方法会响应按钮的点击。  

清单4-1 在视图控制器类中定义outlets和actions  

> OBJECTIVE-C  
> @interface MyViewController : UIViewController  
> @property (weak, nonatomic) IBOutlet UIButton *myButton;  
> @property (weak, nonatomic) IBOutlet UITextField *myTextField;
> 
> -(IBAction)myButtonAction:(id)sender;
 
> @end  

> SWIFT  
> class MyViewController: UIViewController {  
>    @IBOutlet weak var myButton : UIButton!  
>    @IBOutlet weak var myTextField : UITextField!  
>      
>    @IBAction func myButtonAction(sender: id)  
> }

在你的故事版当中，记住要连接你的视图控制器的outlets 和 actions到相应的视图上。连接故事版中的outlets 和 actions能够确保它们在视图被加载的时候能够被正确的配置。关于如何在视图构建工具中创建outlets 和 actions的相关信息，参见“视图构建工具连接帮助指南”。关于如何处理你的应用程序中的事件的相关信息，参见“iOS事件处理指南”。

### 在运行时展示你的视图
故事版使得加载和展示你的视图控制器的视图的过程非常简单。UIKit在视图被需要的时候会自动从你的故事版当中加载视图。作为加载过程的一部分，UIKit会执行以下顺序的任务：  

1. 使用你的故事版文件中的相关信息初始化视图。
2. 连接所有的outlets 和 actions。
3. 将根视图赋值给视图控制器的view属性。
4. 调用视图控制器的awakeFromNib方法。当该方法被调用的时候，视图控制器的特征集合为空，并且它的视图很可能不在最终的位置上。
5. 调用视图控制器的viewDidLoad方法。使用该方法来添加或移除视图，修改布局约束以及为你的视图加载数据。

在显示一个视图控制器的视图到屏幕之前，UIKit给予了你一些额外的时机来准备这些视图显示到屏幕之前或之后。UIKit会以以下顺序执行任务：  

1. 调用视图控制器的 viewWillAppear: 方法让视图控制器知道它的视图将要被显示在屏幕上了。
2. 更新视图的布局。
3. 展示屏幕上的视图。
4. 当视图展示在屏幕上时，调用 viewDidAppear: 方法。

当你添加，删除或者修改视图的尺寸或者位置时，要记得添加和删除任何应用在视图上的约束。对视图层次结构进行与版式相关的更改会导致 UIKit 将版式标记为待更新。在下一个更新循环中，布局引擎会使用当前的布局约束计算视图的尺寸和位置并将这些变更加载到视图层次结构上。  
关于如何不通过故事版来创建视图，参见“UIViewController 类参考”中的视图管理相关信息。
### 管理视图布局
当视图的尺寸和位置改变的时候，UIKit会为你的视图层次结构更新布局相关的信息。对于使用自动布局配置的视图来说，UIKit的自动布局引擎会使用它来根据当前的约束更新布局。UIKit还会让其他相关的对象，比如正在展示的视图控制器，知晓布局的变更，以便作出相应的反应。  
在布局的过程中，UIKit会在几个节点通知你，你可以在这几个节点中执行与布局相关的额外的任务。使用这几个通知来修改你的布局约束，或者在布局约束已经被应用后做最终的布局调整。在布局的过程中，UIKit会对每个受影响的视图控制器执行以下操作：  

1. 根据需要更新视图控制器和它的视图的特征集合；参见“特性和尺寸变更合适发生？”
2. 调用视图控制器的 viewWillLayoutSubviews 方法。
3. 对当前的 UIPresentationController 对象调用 containerViewWillLayoutSubviews 方法。
4. 调用视图控制器根视图的 layoutSubviews 方法。该方法的默认实现会使用当前可用的约束来计算新的布局信息。该方法是贯穿视图层级结构的，它会调用每个子视图的layoutSubviews方法。
5. 将计算好的布局信息应用到视图上。
6. 调用视图控制器的 viewDidLayoutSubviews 方法。
7. 调用当前 UIPresentationController 对象的 containerViewDidLayoutSubviews 方法。

视图控制器可以使用viewWillLayoutSubviews 和 viewDidLayoutSubviews方法来执行额外的更新操作来影响布局过程。在布局之前，你可能需要添加或移除视图，更新视图的尺寸和位置，更新约束或更新其他与视图相关的属性。在布局之后，你可能会需要重新加载列表数据，更新其他视图的内容，或者为视图的尺寸和位置做出最终的调整。  
以下是几条高效的管理你的布局的建议：  

* 使用自动布局。你使用自动布局创建的约束可以灵活且容易适配你的内容到不同的屏幕尺寸上。
* 利用顶部和底部的布局建议。将内容放置在这些布局建议中将确保始终可见。顶部的布局元素存在在状态栏和导航栏的高度当中。同样的，底部的布局元素存在在页签栏和工具栏的高度中。
* 在添加或移除视图的时候记得要更新约束。如果你要自动的添加或删除视图，记得要更新相关的约束。
* 当你的视图控制器的视图在动画过程中移除临时约束。当一个视图在使用UIKit的核心动画时，应当在动画过程中移除你的约束并且在动画结束的时候添加回去。当你的视图的尺寸或位置在动画过程中发生改变的时候，要记得更新你的约束。

更多关于展示视图控制器和它们在视图控制器架构中所扮演的角色的相关信息，参见“展示和转场过程”。

### 高效的管理内存
虽然分配内存的大多数情况都是由你来决定，列表4-1列出了UIViewController中你最可能分配或释放内存的相关方法。大部分的释放操作都包含移除对象的强引用。为移除一个对象的强引用，应将该对象的属性和变量指针设置为nil。

列表4-1 分配和销毁内存的位置  

任务  | 方法  | 讨论 
------------- | -------------  | -------------
分配你的视图控制器所需的关键数据结构  | 初始化方法 | 您的自定义初始化方法 (无论它是名为 init 还是其他名字) 总是负责将视图控制器对象置于已知良好的状态。使用这些方法来分配需要的任何数据结构, 以确保正确的操作。
分配或加载需要显示在你的视图上的数据  | viewDidLoad | 使用viewDidLoad方法来加载你需要展示的数据。在调用此方法时，您的视图对象将被保证存在并处于已知的良好状态。
对于低内存通知做出反应  | didReceiveMemoryWarning | 使用该方法来释放所有与你的视图控制器相关的非必要的对象。尽可能多的释放更多的内存。
释放你的视图控制器所需的关键数据结构  | dealloc | 重写该方法，在当中执行最后时刻清理你的视图控制器类的相关内容。系统自动释放存储在实例变量和你的类的属性中的对象，所以你无需显式的释放这些对象。

## 实现一个容器视图控制器
容器视图控制器是一种从不同的视图控制器当中抽取内容到一个单一的用户界面的方式。容器视图控制器通常被用作简化导航和基于已有的内容创建新的用户界面。UIKit中的容器视图控制器的例子包括UINavigationController，UITabBarController，和 UISplitViewController，所有的这些都是优化你的用户界面的不同部分之间的导航的。
### 设计一个自定义的容器视图控制器
一个容器视图控制器在管理根视图和相关内容的时候是与内容类视图控制器几乎相同的。区别是容器视图控制器是从其他的视图控制器获取内容的。它获取的内容限于其他视图控制器的视图，视图是嵌入在视图控制器本身的视图层级中的。容器视图控制器会为任何嵌入的视图设置尺寸和位置，但原视图控制器仍旧管理着这些视图中的内容。  
当设计你自己的容器视图控制器的时候，要理解容器和被装载的视图控制器之间的联系。视图控制器之间的联系能够帮你知晓如何显示内容到屏幕上，以及如何在容器内部管理它们。在设计期间，要问问你自己以下的问题：  

* 容器所扮演的角色是什么，它的子控制器所扮演的角色是什么？
* 需要同时展示多少子视图？
* （如果不止一个子视图控制器的话）子视图控制器之间的关系是什么？
* 子视图控制器如何从容器中被添加或移除？
* 子视图控制器的尺寸和位置能够改变么？在什么情况下，这些改变会发生？
* 容器是否提供自己的任何装饰或与导航相关的视图？
* 容器和子视图控制器之间需要什么样的交流方式？是容器要通知特定的事件给它的子视图控制器还是通过UIViewController 类定义的标准函数？
* 容器的展示可以被配置成不同的方式么？如果可以的话，怎么做？

在你定义好了不同对象的角色之后，要实现一个容器视图控制器所要做的就很简单了。UIKit只要求你要在容器视图控制器和任何子视图控制器之间建立一个正式的父子关系。父子关系会确保孩子会收到任何系统相关的消息。除此之外，对于每个不同的容器而言，大部分真实的工作会发生在布局和管理孩子视图的过程中。你可以将视图放置在你的容器的任意位置，设置任何你想要的尺寸。你还可以添加自定义视图到视图层级中来提供装饰效果，或者辅助导航。
#### 示例：导航控制器
一个 UINavigationController 对象通过层级数据来支持导航。一个导航界面一次只展示一个子视图控制器。在界面的顶部会展示一个导航栏，它表示当前数据层级当中的位置，还会展示一个返回按钮用来返回上一层。向下一层级的导航交给子视图控制器，也可以由列表或按钮来实现。  
视图控制器之间的导航由导航控制器和它的孩子共同管理。当用户点击子视图控制器当中的一个按钮或者列表的一行时，子视图控制器会告诉导航控制器要将一个新的视图控制器压入当前视图。子视图控制器会处理新视图控制器的内容的相关配置，但导航控制器管理着转场动画。导航控制器还管理着导航栏，它有一个返回按钮，用来移除最上层的视图控制器。  
图5-1展示了导航控制器和它的视图之间的结构。大部分区域都被最上层的子视图控制器所填充，只有一小部分区域被导航栏所占据。  

图5-1 导航界面的结构
![](https://developer.apple.com/library/content/featuredarticles/ViewControllerPGforiPhoneOS/Art/VCPG_structure-of-navigation-interface_5-1_2x.png)  

无论什么环境下，一个导航控制器只会一次展示一个子视图控制器。导航控制器会调整它的子视图控制器来适应合适的位置。
#### 示例：分栏视图控制器
一个 UISplitViewController 对象会以主－从的方式来展示两个视图控制器的内容。在这种方式下，主视图控制器的内容决定了由另一个视图控制器展示的内容。两个视图控制器的展示区域是可配置的，但也受当前的环境影响。在比较宽松的区域下，分栏视图控制器能够并排展示两个子视图控制器或者根据需要隐藏主视图控制器。在比较紧凑的区域下，分栏视图控制器一次只能展示一个视图控制器。  
图5－2展示了分栏视图的界面结构以及它的视图在比较宽松的区域下的样子。分栏视图控制器在默认情况下只拥有它的容器本身。在这个例子当中，两个子视图控制器是并排展示的。两个子视图的大小是可配置的，这与主视图的大小一样。  

图5-2 一个分栏视图界面  
![](https://developer.apple.com/library/content/featuredarticles/ViewControllerPGforiPhoneOS/Art/VCPG-split-view-inerface_5-2_2x.png)

### 在IB中配置一个容器
在设计时创建一个父子关系的容器，需要将一个容器视图对象添加到你的故事版场景中，如图5-3所示。一个容器视图对象是一个占位符对象，它代表了一个子视图控制器的内容。使用该视图可以调整和定位子级的根视图, 使其与容器中的其他视图相对应。  

图5-3 添加一个容器视图到界面编辑器当中  
![](https://developer.apple.com/library/content/featuredarticles/ViewControllerPGforiPhoneOS/Art/container_view_embed_2x.png)

当你加载的视图控制器拥有一个或多个容器视图的时候，界面编辑器同样会加载与这些视图相关的子视图控制器。子视图控制器必须与父视图同一时间被初始化，以便在创建的时候就能够形成相应的父子关系。  
如果你不使用界面编辑器来设置你的父子容器关系的话，你必须通过代码的方式添加每个子控制器到你的容器视图控制器当中来创建这种关系，这在“添加一个子视图控制器到你的内容中”中有相关描述。
### 实现一个自定义的容器视图控制器
要实现一个容器视图控制器，你必须在你的视图控制器和它的子视图控制器之间建立联系。在你试图管理任何子视图控制器的视图之前你就应该建立这种父子关系。这样做能够让UIKit知道你的视图控制器在管理着子视图控制器的位置和大小。你可以通过界面编辑器或者编码的方式来创建这种关系，当你通过编码的方式创建父子关系的时候，你应当将显式的添加和移除视图控制器作为你的视图控制器设置的一部分。
#### 添加一个子视图控制器到你的内容中
如果要通过编码的方式包含一个子视图控制器到你的内容当中，需要在相关的视图控制器之间通过以下方式创建父子关系：  

* 调用容器视图控制器的 addChildViewController: 方法。该方法会告诉UIKit你的容器视图控制器现在已经接管了子视图控制器的视图。
* 添加子视图控制器的根视图到你的容器视图层级当中。永远要记得在这个过程中要设置子视图的大小和位置。
* 为子视图控制器的根视图添加约束来管理大小和位置。
* 调用子视图控制器的 didMoveToParentViewController: 方法。

清单5-1展示了一个容器如何将一个子视图控制器嵌入的过程。在创建了父子关系之后，一个容器要设置子视图的尺寸，并将子视图添加到它自己的视图层级当中。设置子视图的尺寸是非常重要的，这将确保视图能够在容器当中正确的展示出来。在添加视图之后，容器调用子视图的didMoveToParentViewController: 方法，来让子视图控制器有机会在它自己的视图当中来对视图进行调整。  

清单5-1 添加一个子视图控制器到容器中  
> -(void) displayContentController: (UIViewController*) content {  
	   [self addChildViewController:content];  
	   content.view.frame = [self frameForContentController];  
	   [self.view addSubview:self.currentClientView];  
	   [content didMoveToParentViewController:self];  
> }  

在这个例子当中，要注意，你只调用了子视图控制器的didMoveToParentViewController: 方法。这是因为addChildViewController: 方法为你调用了子视图控制器的willMoveToParentViewController: 方法。你必须要手动调用didMoveToParentViewController: 方法的原因是在你将子视图控制器的视图嵌入到你的容器视图层级之后，你就没有机会再调用该方法了。  
当使用自动布局的时候，要在讲子视图添加到容器视图层级之后设置容器视图和子视图之间的约束。你的约束应该只影响子视图控制器的根视图的大小和位置。不要改变根视图的内容或者任何子视图层级当中的其它视图。
#### 移除一个子视图控制器
要想将一个子视图控制器从你的容器当中移除，要通过以下几点来解除视图控制器之间的父子关系：  

* 调用子视图控制器的 willMoveToParentViewController: 方法，将值设置为nil。
* 移除你为子视图控制器配置的相关约束。
* 从你的视图层级当中移除子视图控制的根视图。
* 调用子视图控制器的 removeFromParentViewController 方法，这将终止父子关系。

移除一个子视图控制器将永久的隔断父子视图控制器之间的关系。你应该在不再需要一个子视图控制器的时机再移除它。举例来说，一个导航视图控制器不应当在当前的子视图控制器被创建并压入栈中的时候移除它。而仅应当在它移出栈的时候移除它。  
清单5-2为你展示了如何从容器当中移除一个子视图控制器。调用willMoveToParentViewController: 方法并设置为nil给了子视图控制器机会来响应准备被移除的过程。removeFromParentViewController方法同样会调用调用子视图控制器的didMoveToParentViewController: 方法，并传递给该方法nil值。设置父视图控制器为nil，最终从你的容器中解除了子视图控制器。  

清单5-2 从容器中移除子视图控制器  
> -(void) hideContentController: (UIViewController*) content {  
  		[content willMoveToParentViewController:nil];  
	   [content.view removeFromSuperview];  
	   [content removeFromParentViewController];  
>  }

#### 子视图控制器之间的转换
当你想要以动画的方式用一个子视图控制器替换另一个的话，要在转场动画过程中包括添加和移除子视图控制器两个操作。在动画开始之前，要确保两个子视图控制器都是你的容器视图控制器内容的一部分，但要让当前的子视图控制器知道它要被移除掉了。在动画过程中，将新的子视图控制器的视图移动到相应的位置，将旧的子视图控制器的视图移开。在动画完成后，要完成子视图控制器的移除操作。  
清单5-3 展示了如何使用动画的方式来将两个子视图控制器进行替换的示例。在这个例子当中，新的视图控制器被以动画的方式移动到已经存在的子视图控制器的矩形区域，后者将被移出屏幕。在动画完成后，在完成代码块中从容器中移除了子视图控制器。在这个例子当中，transitionFromViewController:toViewController:duration:options:animations:completion: 方法自动更新了容器的视图层级，所以你无需添加和删除视图。  

清单5-3 两个子视图控制器之间的转换  
	
		- (void)cycleFromViewController: (UIViewController*) oldVC
               toViewController: (UIViewController*) newVC {
	   // Prepare the two view controllers for the change.
	   [oldVC willMoveToParentViewController:nil];
	   [self addChildViewController:newVC];
 		
	   // Get the start frame of the new view controller and the end frame
	   // for the old view controller. Both rectangles are offscreen.
	   newVC.view.frame = [self newViewStartFrame];
	   CGRect endFrame = [self oldViewEndFrame];
 
	   // Queue up the transition animation.
	   [self transitionFromViewController: oldVC toViewController: newVC
        duration: 0.25 options:0
        animations:^{
            // Animate the views to their final positions.
            newVC.view.frame = oldVC.view.frame;
            oldVC.view.frame = endFrame;
        }
        completion:^(BOOL finished) {
           // Remove the old view controller and send the final
           // notification to the new view controller.
           [oldVC removeFromParentViewController];
           [newVC didMoveToParentViewController:self];
        }];
	}

#### 为子视图控制器管理显示更新
在添加一个子控制器到容器中后，容器会自动的向前发送显示相关的信息给子控制器。这通常是符合你想要的行为，因为这确保了所有的事件都被适当的发送。然而，有些时候的默认行为的的发送顺序可能不太符合你的容器所需。举例来说，如果多个子控制器同时改变它们视图的状态，你可能需要合并这些改变以便显示的回调以一种更符合逻辑的顺序在同一时间发生。  
为处理显示的回调，在你的容器中重写shouldAutomaticallyForwardAppearanceMethods 方法并且返回NO，就像清单5-4那样。返回NO会让UIKit知道你的容器视图控制器通知它的子控制器的显示变更了。  

清单5-4 禁止向前自动显示  

		- (BOOL) shouldAutomaticallyForwardAppearanceMethods {
		    return NO;
		}

当显示的转换发生的时候，视情况调用子控制器的方法 beginAppearanceTransition:animated: 或 endAppearanceTransition 方法。举例来说，如果你的容器只有一个子控制器，它被child属性所持有，你的容器应当向前发送这些消息给你的子控制器，见清单5-5所展示的。  

清单5-5 当容器出现或消失的时候，向前发送展示的信息  

		-(void) viewWillAppear:(BOOL)animated {
		    [self.child beginAppearanceTransition: YES animated: animated];
		}
 
		-(void) viewDidAppear:(BOOL)animated {
		    [self.child endAppearanceTransition];
		}
		 
		-(void) viewWillDisappear:(BOOL)animated {
		    [self.child beginAppearanceTransition: NO animated: animated];
		}
 
		-(void) viewDidDisappear:(BOOL)animated {
		    [self.child endAppearanceTransition];
		}

### 构建一个容器视图控制器的一些建议
设计，开发和测试一个新的容器视图控制器会花费很多时间。尽管单一的视图控制器的行为很简单，但控制器如果作为一个整体的话，会很复杂。请在设计实现你自己的容器类的时候考虑以下建议：  

* 仅访问子视图控制器的根视图。一个容器应当仅访问每个子控制器的根视图——这指的是子视图控制器的view属性所返回的视图。它永远不应当访问子视图控制器的其它视图。
* 子视图控制器应当尽可能少的了解其容器视图控制器。子视图控制器应当关注于它自己本身的内容。如果容器视图控制器允许其内行为被一个子视图控制器所影响的话，它应当使用代理设计模式来管理这些交互。
* 应当先使用较规则的视图来设计你的容器。使用较规则的视图（而不是子视图控制器的视图）将让你能够在一个比较简单的环境中测试布局约束和转场动画。当较规则的视图如你想象般运行的话，再将其替换为你的子视图控制器的视图。

### 一个子视图控制器的代理控制
容器视图控制器可以将其自身外观的某些方面委派给一个或多个其子视图控制器。你可以以代理的方式控制以下方面：  

* 让一个子视图控制器决定状态栏的样式。为了能够以代理来控制子视图控制器状态栏的显示，你需要在你的容器视图控制器当中重写一个或者全部方法：childViewControllerForStatusBarStyle 和 childViewControllerForStatusBarHidden。
* 让子视图控制器决定它的优先尺寸。以弹性布局的容器可以使用子视图控制器的preferredContentSize 属性来帮助子视图控制器决定它的尺寸。

## 支持辅助功能

### 将辅助语音提示指针移动到指定的元素

### 响应特定的辅助语音提示的手势

#### 移开

#### 魔法点击

#### 三指滚动

#### 增加和减少

### 监听辅助功能的通知

## 保存和恢复状态
在保存和回复状态的过程中，视图控制器扮演了一个非常重要的角色。状态的保存在你的应用程序被挂起之前记录了你的它的配置，所以它能够在应用程序随后被加载的时候恢复配置。返回一个已经配置好的应用程序会为用户节省时间，并且这也为用户提供了良好体验。  
保存和恢复过程基本是自动的，但你要让iOS知道你的应用程序的哪部分要被保存。保存你的应用程序的视图控制器的步骤如下：  

* (必须)给你想要恢复的视图控制器赋值恢复ID；参见“为保存的视图控制器进行标记”。
* (必须)告诉iOS如何在加载时创建或者定位新的视图控制器对象；参见“在加载时恢复一个视图控制器”。
* (可选)对于每个视图控制器，保存返回时指定的配置数据需要视图控制器自己进行配置；参见“编解码你的视图控制器的状态”。

关于保存和恢复过程的概述，参见“iOS应用程序编程指南”。
### 为保存的视图控制器进行标记
UIKit只在你告诉它要保存视图控制器时才进行保存。每个视图控制器都有个restorationIdentifier 属性，该属性默认为nil。设置该属性为一个有效的字符串会告诉UIKit该视图控制器以及它的视图需要被保存。你可以以编码的方式或者故事版文件的方式来赋值恢复ID。  
当赋值恢复ID的时候，要记得它所有的在视图控制器层级中的父视图控制器也被赋值恢复ID。在恢复过程中，UIKit先从窗口的根视图控制器开始，然后遍历视图控制器层级。如果在该层级当中一个视图控制器没有一个恢复ID的话，该视图控制器以及它所有的子视图控制器和保存的视图控制器都会被忽略。
#### 选择有效的恢复ID
UIKit会使用你的恢复ID来在随后重新创建视图控制器，所以你应当选择容易识别的ID作为这个字符串。如果UIKit不能够自动创建你的视图控制器的话，它会要求你来创建它，提供给你视图控制器的恢复ID和所有它的父视图控制器。这个ID链条表示视图控制器的恢复路径以及你决定哪个视图控制器是被需要的。恢复路径从根视图控制器开始包含每个视图控制器，直到包含那个被需要的视图控制器。  
恢复ID通常使用视图控制器的类名。如果你在很多地方使用同样的类的话，你可能需要赋值更有区分性的值了。举例来说，你可能会赋值一个基于视图控制器管理的数据的字符串。  
每个视图控制器的恢复路径必须唯一。如果一个容器视图控制器有两个子视图控制器的话，容器视图控制器必须给每个子视图控制器赋予一个唯一的恢复ID。在UIKit中的有些容器视图控制器会自动的销毁它的子视图控制器，这允许你为每个子视图控制器使用同样的恢复ID。举例来说，UINavigationController 类会为每个子视图控制器基于它在栈中的位置添加相关信息。关于给定的视图控制器的行为的相关信息，参见相关的类引用文件。  
关于你如何使用恢复ID和恢复路径来创建视图控制器的相关信息，参见“在启动时恢复一个视图控制器”。
#### 排除一组视图控制器
如果想从恢复过程中排除一组视图控制器的话，设置该组视图控制器的父视图控制的恢复ID为nil即可。图7-1展示了设置恢复ID为nil之后在视图层级中的影响。缺少保存数据会使视图控制器以后无法恢复。  

图7-1 从自动保存过程中排除一组视图控制器   

![](https://developer.apple.com/library/content/featuredarticles/ViewControllerPGforiPhoneOS/Art/state_vc_caveats_2x.png)  

排除一个或多个视图控制器不会将它们从随后的恢复中移除。在启动过程中，任何你的应用程序的视图控制器都还会被创建，如图7-2所示。即使是那些以默认配置重新创建的视图控制器也依旧是被创建的。  

图7-2 加载默认的一组视图控制器  

![](https://developer.apple.com/library/content/featuredarticles/ViewControllerPGforiPhoneOS/Art/state_vc_caveats_2_2x.png)  

从自动恢复过程中排除一组视图控制器不会影响你手动的恢复它们。在恢复归档中持有一个视图控制器的引用会保存该视图控制器以及它的相关状态信息。举例来说，如果在图7-1中的应用程序代理方法保存了导航视图控制器的三个子视图控制器的话，它们的状态也会被保存。在恢复过程中，应用程序的代理方法会重新创建这些视图控制器并将它们压入导航控制器的栈中。
#### 保存一个视图控制器的视图
有些视图拥有视图相关信息但与其父视图控制器无关。举例来说，一个滚动视图可能会有一个你想要保存的滚动到的位置。当视图控制器负责提供滚动视图的内容时，滚动视图本身应当负责保存其可见区域的状态。  
为保存一个视图的状态，应当做到以下几点：  

* 将一个合法的字符串赋值给视图的 restorationIdentifier 属性。
* 使用一个拥有合法恢复ID的视图控制器的视图。
* 对于表格和表单视图而言，应当将其数据源采用 UIDataSourceModelAssociation 协议。

将一个恢复ID赋值给一个视图会告诉UIKit它应当将该视图的状态保存归档。当视图控制器被随后恢复的时候，UIKit同样会恢复那些拥有恢复ID的视图的状态。
### 在启动时恢复一个视图控制器
在启动时，UIKit会视图恢复你的应用程序之前的状态。在这个时候，UIKit会要求你的应用程序创建（或定位）包含你之前保存的用户界面的视图控制器对象。当UIKit视图定位视图控制器的时候，它将以以下顺序进行检索：  

1. 如果视图控制器拥有恢复类的话，UIKit要求该类提供视图控制器。UIKit会调用相关恢复类的 viewControllerWithRestorationIdentifierPath:coder: 方法来检索视图控制器。如果该方法返回nil，那么UIKit会假定应用程序不想重新创建该视图控制器然后停止查找。
2. 如果视图控制器没有恢复类，UIKit要求应用程序的代理提供视图控制器。UIKit会调用应用程序代理类的 application:viewControllerWithRestorationIdentifierPath:coder: 方法来查找一个没有恢复类的视图控制器。若该方法返回nil，UIKit会隐式的对视图控制器进行查找。
3. 如果一个视图控制器拥有正确的恢复路径，UIKit会使用该对象。如果你的应用程序在启动时创建了视图控制器（不管是编码方式还是从一个故事版加载的）那么这些视图控制器都拥有恢复ID，UIKit会隐式的基于恢复路径对它们进行检索。
4. 如果视图控制器最初是由一个故事版文件加载的，UIKit会使用保存的故事版的相关信息来定位和创建视图控制器。UIKit会将视图控制器的故事版的相关信息保存到恢复归档当中。在恢复期间，UIKit会使用该信息来定位到相同的故事版文件然后实例化相关的视图控制器（若该视图控制器没有被其它手段查找到的话）。

将一个恢复类赋值给一个视图控制器会阻止UIKit隐式的检索该视图控制器。使用恢复类会在你真的要创建一个视图控制器的时候给你更多的控制权。举例来说，如果你的类决定该控制器不应该被重新创建，那么你的viewControllerWithRestorationIdentifierPath:coder: 方法可以返回nil。当没有恢复类被展示的时候，UIKit会尽可能的寻找或创建视图控制器并保存它。  
当使用恢复类的时候，你的viewControllerWithRestorationIdentifierPath:coder: 方法应当创建一个该类的实例对象，执行最小化的初始化，然后将处理后的对象返回。清单7-1展示了如何从一个故事版当中使用该方法来加载视图控制器的示例。由于视图控制器最初是从故事版加载的，该方法使用UIStateRestorationViewControllerStoryboardKey 为key来从归档当中回去故事版。要注意该方法并没有视图配置视图控制器的相关数据。当视图控制器的状态被解码之后才会发生该步骤。  

清单7-1 在恢复期间创建一个新的视图控制器  

		+ (UIViewController*) viewControllerWithRestorationIdentifierPath:(NSArray *)identifierComponents
                      coder:(NSCoder *)coder {
	   MyViewController* vc;
	   UIStoryboard* sb = [coder decodeObjectForKey:UIStateRestorationViewControllerStoryboardKey];
	   if (sb) {
	      vc = (PushViewController*)[sb 	instantiateViewControllerWithIdentifier:@"MyViewController"];
	      vc.restorationIdentifier = [identifierComponents lastObject];
	      vc.restorationClass = [MyViewController class];
	   }
	    return vc;
	}

当手动重新创建一个视图控制器的时候，重新赋值恢复ID和恢复类是一个应当养成的好习惯。还原恢复ID最简单的方法是从identifierComponents数组中获取最后一个元素然后将其赋值给你的视图控制器。  
对于启动时从你的应用程序主故事版中创建的对象而言，不要为每个对象创建新的实例对象。应该让UIKit隐式的查找这些对象或者使用你的应用程序的代理的 application:viewControllerWithRestorationIdentifierPath:coder: 方法来找到这些已经存在的对象。
### 编解码你的视图控制器的状态
对于每个要被保存的对象而言，UIKit会调用对象的 encodeRestorableStateWithCoder: 方法来给予对象一个时机来保存它的状态。在恢复过程中，UIKit会调用相应的 decodeRestorableStateWithCoder: 方法来解码该状态并将其应用到对象上。这两个方法是可选的，但我们推荐你在你的视图控制器中实现它。在以下几个方面你可能会用它们来保存和恢复某些状态信息：  

* 任何有关要被展示的数据（不是数据本身）
* 对于容器视图控制器而言，有关它的子视图控制器的相关信息。
* 有关当前选中的信息
* 对于视图控制器中有用户可配置的视图而言，可存储该视图的当前配置信息。

在你的编解码方法当中，你可以编码任何coder支持的对象和数据类型。除了视图和视图控制器之外的所有对象都必须采用NSCoding协议并应使用相应协议方法来编写它的状态。对于视图和视图控制器而言，coder 不会使用NSCoding协议来保存该对象的状态。取而代之的是，coder会保存该对象的恢复ID，将其添加到保存对象列表当中，后者将会调用对象的encodeRestorableStateWithCoder:方法。  
你的视图控制器的encodeRestorableStateWithCoder: 和 decodeRestorableStateWithCoder:方法在实现的时候必须在某个时间点调用super。调用super会给父类一个机会来保存和恢复一些额外的信息。清单7-2展示了这两个方法的实现示例，在这个例子中使用了一个数字值来标识指定的视图控制器。  

清单7-2 编解码一个视图控制器的状态

		- (void)encodeRestorableStateWithCoder:(NSCoder *)coder {
		   [super encodeRestorableStateWithCoder:coder];
 
		   [coder encodeInt:self.number forKey:MyViewControllerNumber];
		}
 
		- (void)decodeRestorableStateWithCoder:(NSCoder *)coder {
		   [super decodeRestorableStateWithCoder:coder];
	   		self.number = [coder decodeIntForKey:MyViewControllerNumber];
		}

Coder对象在编解码过程中并不是共享的。每个拥有保存状态的对象都会接收它自己的Coder对象。使用唯一的Coder意味着你无需担心你所使用的key与命名之间的冲突。不过，请不要使用UIApplicationStateRestorationBundleVersionKey，UIApplicationStateRestorationUserInterfaceIdiomKey，和 UIStateRestorationViewControllerStoryboardKey 等key值。这些key都是被UIKit用来保存你的视图控制器的状态信息的。  
有关实现视图控制器中编解码方法的额外信息，参见“视图控制器类参考文献”。
### 一些保存和存储你的视图控制器的建议
在你决定在你的视图控制器中支持状态的保存和恢复之后，请考虑以下的建议：  

* 要记住你并非需要保存所有的视图控制器。在某些情况下，保存一个视图控制器是没有必要的。举例来说，如果应用程序展示了一个更改，你可能想要取消操作然后将应用程序恢复到上一个屏幕内容。在这种情况下，你就不需要保存需要填写新的密码信息的那个视图控制器了。
* 避免在恢复过程中交换视图控制器类。状态保存系统将视图控制器的类进行编码保存。在恢复期间，如果你的应用程序返回一个与原对象的类不匹配的对象（或者不是它的子类），那么系统不会让视图控制器来解码任何状态信息。此外，将旧的视图控制器替换为一个完全的不同的视图控制器将不会恢复该对象的全部信息。
* 状态保存系统希望你正确的使用视图控制器。恢复过程依赖于你的视图控制器之间的包含关系来重新构建你的界面。如果你使用容器视图控制器不当的话，保存系统将不能够查找到你的视图控制器。举例来说，永远不要将一个视图控制器的视图嵌入到一个不同的视图当中，除非它是与当前视图控制器是包含的关系。

# 展示和转换
## 展示一个视图控制器
有两种方式能够将一个视图控制器展现在屏幕上：将其嵌入到一个容器视图控制器或者直接呈现出来。容器视图控制器为一款应用程序提供了主要导航，不过模态呈现一个视图控制器同样也是一种很重要的导航工具。你可以直接呈现一个新的视图控制器到当前视图控制器的顶部。比较典型的使用方式是当你想要实现模态界面的时候呈现一个视图控制器，不过你也可以将其用到其它的目的上。  
模态化展示视图控制器在UIViewController类中内置支持，它对所有的视图控制器对象而言都是可用的。你可以从任意视图控制器中模态展示另一个视图控制器，不过UIKit会重新调整请求一个不同的视图控制器。模态展示视图控制器会在两个视图控制器之间建立联系，原视图控制器被称作正在展示的视图控制器，新的视图控制器被称作被展示的视图控制器。这种关系是视图控制器层级中的组成部分，它将一直存在，直到被展示的视图控制器消失。
### 展示和转换过程
展示一个视图控制器是一种快速且简便将新的内容动态的呈现到屏幕上的方式。展示机制是内置在UIKit当中的，这让你能够使用内置的或者自定义的动画来展现一个新的视图控制器。内置的展现和动画需要很少的代码就可以实现，因为UIKit承担了所有的工作。你也可以通过编写很少的额外的代码来以自定义的方式在任意的视图控制器中展示。  
你可以以编码或者使用segues的方式来初始化展示视图控制器。如果你在设计阶段就知道你的应用程序的导航方式的话，segues是一种非常简单的方式来初始化展示。对于更动态的接口, 或者在没有专门的控件来启动segue的情况下，请使用UIViewController的相关方法来展示你的视图控制器。
#### 展示样式
视图控制器的“展示样式”管理着它在屏幕上的外观。UIKit定义了多种标准的展现样式，每种都有着特定的外观和意图。你还可以定义你自己定制的展现样式。当设计你的应用程序时，请尽量选择你想要的那种展现样式对应的场景，将其对应的合适的常量赋值给你想要展现的视图控制器的 modalPresentationStyle 属性。
##### 全屏展示样式
全屏展示样式会覆盖整个屏幕，阻止与被遮盖的底部内容进行交互。在宽松的水平环境中，会只有一种全屏样式完全覆盖底层内容。其余部分会统一变暗或变透明来让底层的视图控制器透过来显示一部分。在水平的紧凑环境下，全屏展示会自动的适配为 UIModalPresentationFullScreen 样式，并覆盖所有底部的内容。  
图8－1展示了在一个水平宽松环境下使用 UIModalPresentationFullScreen, UIModalPresentationPageSheet, 和 UIModalPresentationFormSheet 等样式来展示的样子。在图中，左上部的绿色视图控制器将展示右上方的蓝色视图控制器，每种展示样式的结果在下方展示。对于某些展示样式，UIKit会在两个视图控制器的内容之间插入一个较暗的视图。  

图8-1 全屏展示样式  

![](https://developer.apple.com/library/content/featuredarticles/ViewControllerPGforiPhoneOS/Art/VCPG_PresentationStyles%20_fig_8-1_2x.png)  

```
注意：当使用UIModalPresentationFullScreen样式来展示一个视图控制器的时候，UIKit通常会在转换动画结束后移除掉底层视图控制器的视图。你可以通过设定 UIModalPresentationOverFullScreen 样式来阻止移除视图。当展示的视图控制器拥有底层内容需要透过展示的区域时，你可能会用到该样式。
```

当使用一种全屏展示样式时，发起展示的视图控制器本身必须覆盖整个屏幕。若正在展示的视图控制器没有覆盖整个屏幕，UIKit会沿着视图控制器层级一直寻找，直到找到一个可以覆盖的视图控制器为止。若没能找到一个覆盖屏幕的中间的视图控制器的话，UIKit会使用窗口的根视图控制器。
##### 弹出样式
UIModalPresentationPopover样式会将视图控制器展示在一个弹出的视图中。对于展示额外的信息或者展示当前正在浏览或选中的对象的一组相关元素而言很有用。在水平的规律环境中，弹出视图会只覆盖屏幕的一部分，如图8-2所示。在水平紧凑环境下，弹出视图会默认使用 UIModalPresentationOverFullScreen 展示样式。轻触弹出视图的外部会自动让弹出视图消失。  

图8-2 弹出展示样式  

![](https://developer.apple.com/library/content/featuredarticles/ViewControllerPGforiPhoneOS/Art/VCPG_popover-style_2x.png)

由于在水平紧凑环境下弹出视图会自动适配为全屏展现，通常你需要修改你的弹出相关的代码来处理适配。在全屏模式下，你需要找到一种方式去消除展现的弹出框。你可以通过添加一个按钮，将弹出框嵌入到一个可以消除的容器视图控制器中或者改变适配行为其本身来做到。

更多关于如何配置弹出样式的提示，参见“在弹出视图中呈现一个视图控制器”。
##### 聚焦样式
UIModalPresentationCurrentContext 样式将会在你的用户界面上覆盖一个特定的视图控制器。当使用contextual样式时，你要设置你想覆盖的视图控制器的 definesPresentationContext 属性为YES。图8-3展示了一个只覆盖分离视图控制器的一个子视图控制器的展示情况。  

图8-3 聚焦展现样式  

![](https://developer.apple.com/library/content/featuredarticles/ViewControllerPGforiPhoneOS/Art/VCPG_CurrentContextStyles_2x.png)  

	注意：当使用UIModalPresentationFullScreen样式来展示一个视图控制器时，UIKit通常会在转场动画结束时将底层的视图控制器的视图移除。你可以通过指定UIModalPresentationOverCurrentContext样式来阻止移除这些视图。当展示的视图控制器拥有底层内容需要透过展示的区域时，你可能会用到该样式。  

定义了展现上下文的视图控制器也能够定义转场动画用在展现当中。通常UIKit使用展现的视图控制器的modalTransitionStyle属性来将视图控制器动画展示在屏幕上。若展示的视图控制器的 providesPresentationContextTransitionStyle 属性被设置为了YES，UIKit会使用它来代替视图控制器的modalTransitionStyle属性。  
当转换到了一个水平紧凑环境中时，当前的上下文样式将适配为 UIModalPresentationFullScreen 样式。若要改变这种情况，要使用适配的展现代理来指定一个不同的展现样式或视图控制器。
##### 自定义展示样式
UIModalPresentationCustom 样式能够让你使用自定义的方式来展示一个视图控制器。创建一个自定义的样式包含子类化 UIPresentationController 和使用它的方法来动画的展示自定义视图到屏幕上一集设置展示的视图控制器的尺寸和位置。由于被展现的视图控制器的特性的改变，展现的视图控制器同样会处理相应的适配问题。  
关于如何定义一个自定义的展现视图控制器的相关信息，参见“创建自定义展现”。
#### 转换样式
转换样式决定了用来呈现一个模态展示的视图控制器的动画类型。对于内建的转换样式，你可以给你要模态展示的视图控制器的modalTransitionStyle属性赋值一个标准转换样式。当你模态展示视图控制器的时候，UIKit会为该样式创建相关的动画。举例来说，图8-4展示了视图控制器标准的从下到上转场动画展示到屏幕上的过程。视图控制器B从屏幕外以动画的方式展现到视图控制器A的上面。当视图控制器B被消除的时候，动画效果是反过来的，B是从上往下滑动，然后展示出A。  

图8-4 一个视图控制器的转场动画  

![](https://developer.apple.com/library/content/featuredarticles/ViewControllerPGforiPhoneOS/Art/VCPG_SlideTransition_fig_8-1_2x.png)

你可以使用动画对象和转场代理来创建自定义转场方式。动画对象会创建转场动画来替换屏幕上的视图控制器。转场代理会在适当的时机支持动画对象作用于UIKit。更多关于如何实现自定义转场的相关信息，参见“自定义转场动画”。
#### 模态展示与显示一个视图控制器
UIViewController 类提供了两种方法来展示一个视图控制器：  

* showViewController:sender: 和 showDetailViewController:sender: 方法提供了非常灵活和适配的方式来展现视图控制器。这两个方法让模态展示的视图控制器来决定如何以更好的方法来处理展示过程。比如，一个容器视图控制器可能需要将一个视图控制器作为其子视图控制器所包含而非模态化的对其进行展现。默认的展现一个视图控制器的行为是模态化的。
* presentViewController:animated:completion: 方法将始终以模态化的方法来展现视图控制器。调用该方法的视图控制器可能最终不会处理展现过程，但展现过程始终是模态化的。该方法为水平紧凑环境适配了展现样式。

我们更推荐使用showViewController:sender: 和 showDetailViewController:sender: 这种方式来初始化展示。调用该方法的视图控制器无需知道任何关于视图控制器层级或当前视图控制器在视图层级中的位置等相关信息。这些方法同样使得在你的app中重用视图控制器更加简单而无需编写条件语句进行判断。
### 模态展示一个视图控制器
有多重方式来初始化展现一个视图控制器：  

* 使用segue自动的模态展现视图控制器。segue会使用你在界面编辑器当中设定的相关信息来实例化并展现视图控制器。关于如何配置segues的相关信息，参见“使用Segues”部分。
* 使用 showViewController:sender: 或 showDetailViewController:sender: 方法来展现视图控制器。在自定义的视图控制器当中，你可以将这些方法改造为更适合于你的视图控制器的方法。
* 调用 presentViewController:animated:completion: 方法来模态化展现视图控制器。

关于如何销毁你使用以上技术所展现的视图控制器的相关信息，参见“销毁一个展示的视图控制器”部分。
#### 显示视图控制器
当使用showViewController:sender: 和 showDetailViewController:sender:方法时，获取屏幕上的新的视图控制器的过程是很简单的：  

1. 创建你想要展示的视图控制器对象。当创建视图控制器时，你需要对其所要执行的任务所需的数据进行初始化。
2. 将新的视图控制器的 modalPresentationStyle 属性设置为所需的展现样式。该样式可能不会在最终的展现样式中使用。
3. 将师徒控制器的 modalTransitionStyle 属性设置为所需的转场动画样式。该样式可能不会在最终的动画中使用。
4. 调用当前视图控制器的 showViewController:sender: 和 showDetailViewController:sender: 方法。

UIKit会为适当的正在展示的视图控制器调用showViewController:sender: 和 showDetailViewController:sender: 方法。该视图控制器可以在随后决定如何更好的执行展现样式以及根据所需改变展现和转场样式。比如，一个导航控制器可能需要将视图控制器压入导航栈。  
关于展示视图控制器和模态化展现视图控制器的区别的相关信息，参见“模态展示和展现视图控制器的对比”部分。
#### 模态化展现视图控制器
当直接展现一个视图控制器时，你要告诉UIKit，你想如何将新的视图控制器展示以及以何种动画的方式呈现在屏幕上。  

1. 创建你想要展示的视图控制器对象。当创建视图控制器时，你要负责将其要执行的任务的所需数据进行初始化。  
2. 给新的视图控制器的 modalPresentationStyle 属性设置所需的展现样式。
3. 给视图控制器的 modalTransitionStyle 属性设置所需动画样式。
4. 在当前视图控制器中调用 presentViewController:animated:completion: 方法。

调用 presentViewController:animated:completion: 方法的视图控制器可能并非实际执行模态化展示的视图控制器。展现样式决定了该视图控制器如何被展示，包括被展示的视图控制器的特征所需。举例来说，一个全屏展现必须被一个全屏视图控制器所初始化。若当前被展现的视图控制器并不合适的话，UIKit会沿视图控制器层级寻找，直到找到一个为止。当完成一个模态化展示时，UIKit会更新受到影响的视图控制器的 presentingViewController 和 presentedViewController 属性。  
清单8-1 展示了如何以编码的方式展现一个视图控制器。当用户添加新功能时，应用程序会提示用户展现一个导航视图控制器的基本信息。导航视图控制器被选中，以便有标准位置来放置取消和完成按钮。使用导航控制器也使得以后扩展新的功能更为简单。你只需要将新的视图控制器压入导航栈即可。  

清单8-1 以编码的方式展现一个视图控制器  

	- (void)add:(id)sender {
	   // Create the root view controller for the navigation controller
	   // The new view controller configures a Cancel and Done button for the
	   // navigation bar.
	   RecipeAddViewController *addController = [[RecipeAddViewController alloc] init];
 
	   addController.modalPresentationStyle = UIModalPresentationFullScreen;
	   addController.transitionStyle = UIModalTransitionStyleCoverVertical;
	   [self presentViewController:addController animated:YES completion: nil];
	}

#### 在弹出框中展示一个视图控制器
在展示之前，弹出框需要额外的配置。在设置模态化展示样式给 UIModalPresentationPopover 之后，需要配置以下弹出框相关的属性：  

* 给你的视图控制器的 preferredContentSize 属性设置所需尺寸。
* 使用关联的 UIPopoverPresentationController 对象设置弹出框的锚点，这可以从视图控制器的 popoverPresentationController 属性访问。要只设置以下的其中之一：  
	* 设置 barButtonItem 属性给一个bar button item。
	* 设置 sourceView 和 sourceRect 属性给指定的一个视图的区域属性。

你可以使用 UIPopoverPresentationController 对象来根据所需调整弹出框。弹出框的展示控制器同样支持代理对象，你可以使用它来在展示过程中响应变更。比如，你可以使用代理来响应弹出框的显示，隐藏或调整在屏幕上的位置。更多关于该对象的相关信息，参见“UIPopoverPresentationController 类介绍”。
### 隐藏一个展示的视图控制器
若要隐藏一个展示的视图控制器，需要调用展示的视图控制器的 dismissViewControllerAnimated:completion: 方法。你也可以在被展示的视图控制器中调用该方法。当你在被展示的视图控制器中调用该方法时，UIKit会自动的向前请求展示的视图控制器。  
在隐藏一个视图控制器之前，要记得保存该视图控制器的相关信息。从视图控制器层级中消除一个视图控制器并将其从屏幕上移除。若你没有对于该视图控制器拥有强引用的话，消除它的时候要一并将其分配的内存一起释放。  
若被展示的视图控制器必须将数据返回给展示的控制器的话，可以使用代理设计模式来帮助这一过程。代理使得在你的APP中的不同部分复用视图控制器更为容易。通过代理，被展示的视图控制器存储了实现正式协议方法的代理对象的引用。当它获取结果时，被展示的视图控制器会调用代理对象的这些方法。以典型实现为例，展示的视图控制器将其本身作为被展示的视图控制器的代理。
### 展示一个在不同的故事版中定义的视图控制器
虽然你能够在同一个故事板中的视图控制器之间创建segues，但你不能在不同的故事板之间创建segues。当你想要在不同的故事板上展示一个视图控制器时，你必须在展示该视图控制器之前对其进行实例化，如清单8-2所示。该示例以模态化得形式展示视图控制器，不过你可以将其以导航控制器的方式展示，或以其他方式也可以。  

清单8-2 从一个故事板加载视图控制器  

	UIStoryboard* sb = [UIStoryboard storyboardWithName:@"SecondStoryboard" bundle:nil];
	MyViewController* myVC = [sb instantiateViewControllerWithIdentifier:@"MyViewController"];
 
	// Configure the view controller.
 
	// Display the view controller
	[self presentViewController:myVC animated:YES completion:nil];

在你的应用中创建多个故事板并非必须。不过，以下是几种可能用到多个故事板的情况：  

* 你们是一个大的编程团队，需要给不同的团队赋予不同部分的用户界面。每个团队都在不同的故事板文件中有其自己的用户界面部分以便最小化争议。
* 你已经购买或创建了一个预定义了多个视图控制器类型集合的库；这些视图控制器的内容都在故事板中被库所定义好。
* 你需要在一个外置屏幕上展示内容。在这种情况下，你可以将所有与备用屏幕关联的视图控制器保留在单独的故事板中。相同方案的另一种模式是编写自定义的segue。

## 使用Segues

### 在视图控制器之间创建Segue

### 在运行时修改一个Segue的行为

### 创建一个展开的Segue

### 用程序初始化一个Segue

### 创建一个自定义的Segue

#### 一个Segue的生命周期

#### 实现一个自定义的Segue

## 自定义转场动画

### 转场动画的顺序

#### 转场代理事件

#### 自定义动画顺序

#### 转场上下文对象

#### 转场的协调者

### 使用自定义动画展示一个视图控制器

### 实现转场代理方法

### 实现你的动画对象

#### 获取动画参数

#### 创建转场动画

#### 在动画结束后进行清理

### 为你的转场动画添加交互

### 在转场旁边创建动画

### 使用你的动画来展现一个展示控制器

## 创建自定义展示
UIKit将你的视图控制器的内容与展示和显示在屏幕的内容分离了。被展示的视图控制器被底层的展示控制器对象所管理，它管理着可视化样式，用来展示视图控制器的视图。一个展示控制器可能需要做到以下几点：  

* 设置被展示的视图控制器的尺寸。
* 添加自定义视图来改变被展示的内容的可视化部分。
* 对于任意其自定义视图提供转场动画的支持。
* 当变更发生在APP的环境中时，适配展示的可视化部分。

UIKit为标准展示样式提供了展示控制器。当你设置一个视图控制器的展示样式给UIModalPresentationCustom，并提供一个适当的转场代理时，UIKit会使用你的自定义展示控制器所代替。
### 自定义展现的过程
当你展示一个展示样式为 UIModalPresentationCustom 的视图控制器时，UIKit会寻找自定义展示控制器来管理展示的过程。作为展示过程的一部分，UIKit会调用展示控制器的方法，给予它时机来设定自定义视图和以动画的方式展示到位置。  
一个展示控制器会在动画对象旁协助实现整体的转换过程。动画对象会以动画的方式将视图控制器的内容展示在屏幕上，展示控制器会处理其他的内容。通常，你的展示控制器会动画展示其视图，但你也可以重写展示控制器的 presentedView 方法并让动画对象动画的展示所有或部分视图。  
在展示期间，UIKit会做以下事情：  

1. 调用转换代理的 presentationControllerForPresentedViewController:presentingViewController:sourceViewController: 方法来检索你的自定义展示控制器。
2. 如有的话，UIKit会为动画以及交互动画对象询问转换代理。
3. 调用你的展示控制器的 presentationTransitionWillBegin 方法。实现该方法时需要添加自定义视图到视图层级中，并需要为这些视图配置动画。
4. 从你的展示控制器获取 presentedView。该方法返回的视图会被动画对象动画的展示到指定位置。通常该方法返回被展示的视图控制器的根视图。不过你的展示控制器可以根据需要将该视图替换为一个自定义的背景视图。若你指定一个不同的视图，你必须将被展示的视图控制器的根视图嵌入到你的视图层级中。
5. 执行转场动画。转场动画包括被动画对象创建的主动画以及你配置的在主动画周边运行的其他动画。关于转场动画的相关信息，参见“转场动画序列”。在动画过程中，UIKit会调用你的展示控制器的 containerViewWillLayoutSubviews 和 containerViewDidLayoutSubviews 方法以便你能够根据需要调整你的自定义视图的布局。
6. 当转场动画结束时调用 presentationTransitionDidEnd: 方法。

在消失过程中，UIKit会做：  

1. 从当前可视化的视图控制器中获取你的自定义展示控制器。
2. 若有的话，为动画和交互动画对象查询转场代理。
3. 调用你的展示控制器的 dismissalTransitionWillBegin 方法。你在实现该方法时应当添加相关自定义视图到视图层级中，并为这些视图配置动画。
4. 从你的展示控制器获取已经展示的 presentedView。
5. 执行转场动画。转场动画包括被动画对象创建的主动画以及你配置的在主动画周边运行的其他动画。关于转场动画的相关信息，参见“转场动画序列”。在动画过程中，UIKit会调用你的展示控制器的 containerViewWillLayoutSubviews 和 containerViewDidLayoutSubviews 方法以便你能够移除自定义的约束。
6. 当转场动画结束时调用 dismissalTransitionDidEnd: 方法。

在展示过程期间，你的展示控制器的 frameOfPresentedViewInContainerView 和 presentedView   方法可能被调用多次，所以你的实现应当尽快返回。同样的，你的presentedView方法应当不要试图设置视图层级。视图层级应当在该方法被调用的时候就被配置好了。
### 创建一个自定义展示的控制器
若要实现一个自定义的展示样式，需继承 UIPresentationController 并增加相应的代码来创建视图和动画展示你的样式。当创建一个自定义展示控制器时，需要考虑以下问题：  

* 你需要添加什么视图？
* 你想要如何动画展示额外的视图到屏幕上？
* 被展示的视图控制器是什么尺寸？
* 展示样式如何在水平宽松和紧凑的尺寸类之间进行适配？
* 当展示完成时，展示的视图控制器应当被移除么？

所有的这些决策都需要重写UIPresentationController类的不同的方法。
#### 设置一个展示的视图控制器的大小
你可以修改被展示的视图控制器的矩形大小以便它能够填充有效区域。默认的，一个被展示的视图控制器与其容器视图的尺寸相同。若要改变矩形大小的话，需要重写你的展示控制器的 frameOfPresentedViewInContainerView 方法。  
清单11-1展示了当尺寸改变为只覆盖容器视图的右半部分的一个例子。在这个例子中，展示控制器使用了灰暗背景来遮盖容器的其他部分。  

清单11-1 改变被展示的视图控制器的尺寸  

	- (CGRect)frameOfPresentedViewInContainerView {
	    CGRect presentedViewFrame = CGRectZero;
   		 CGRect containerBounds = [[self containerView] bounds];
 
	    presentedViewFrame.size = CGSizeMake(floorf(containerBounds.size.width / 2.0),
                                         containerBounds.size.height);
   		 presentedViewFrame.origin.x = containerBounds.size.width -
                                    presentedViewFrame.size.width;
	    return presentedViewFrame;
	}

#### 管理和加载自定义视图的动画
自定义展示通常包含添加自定义视图来展示内容。使用自定义视图来实现纯粹的视觉装饰或用来添加实用的展示行为。举例来说，一个背景视图可能包含手势识别来记录特定的展示内容范围之外的事件。  
展示控制器需要负责创建和管理所有与展示相关的自定义视图。通常，你在初始化你的展示控制器时创建视图。清单11-2展示了一个自定义视图控制器的初始化方法，该方法创建了它自己的灰暗视图。该方法创建视图然后执行了一些最初的配置。  

清单11-2 初始化展示控制器  

	- (instancetype)initWithPresentedViewController:(UIViewController *)presentedViewController
                    presentingViewController:(UIViewController *)presentingViewController {
	    self = [super initWithPresentedViewController:presentedViewController
                         presentingViewController:presentingViewController];
   		 if(self) {
       	 // Create the dimming view and set its initial appearance.
	        self.dimmingView = [[UIView alloc] init];
   		     [self.dimmingView setBackgroundColor:[UIColor colorWithWhite:0.0 alpha:0.4]];
   	     [self.dimmingView setAlpha:0.0];
   		 }
	    return self;
	}

使用 presentationTransitionWillBegin 方法来讲你的自定义视图动画的展示到屏幕上。如清单11-3所示，在该方法中，配置你的自定义视图然后将其添加到容器视图中。无论是被展示还是展示的视图控制器都要使用transition coordinator（转场调度）来创建动画。不要在该方法中修改被展示的视图控制器的视图。

清单11-3 动画的将灰暗视图展示到屏幕上  

	- (void)presentationTransitionWillBegin {
    // Get critical information about the presentation.
    UIView* containerView = [self containerView];
    UIViewController* presentedViewController = [self presentedViewController];
 
    // Set the dimming view to the size of the container's
    // bounds, and make it transparent initially.
    [[self dimmingView] setFrame:[containerView bounds]];
    [[self dimmingView] setAlpha:0.0];
 
    // Insert the dimming view below everything else.
    [containerView insertSubview:[self dimmingView] atIndex:0];
 
    // Set up the animations for fading in the dimming view.
    if([presentedViewController transitionCoordinator]) {
        [[presentedViewController transitionCoordinator]
               animateAlongsideTransition:^(id<UIViewControllerTransitionCoordinatorContext>
                                            context) {
            // Fade in the dimming view.
            [[self dimmingView] setAlpha:1.0];
        } completion:nil];
    }
    else {
        [[self dimmingView] setAlpha:1.0];
    }
	}

清单11-4 处理取消展示事件  

	- (void)presentationTransitionDidEnd:(BOOL)completed {
    // If the presentation was canceled, remove the dimming view.
    if (!completed)
        [self.dimmingView removeFromSuperview];
	}

清单11-5 消除展示视图  

	- (void)dismissalTransitionWillBegin {
    // Fade the dimming view back out.
    if([[self presentedViewController] transitionCoordinator]) {
        [[[self presentedViewController] transitionCoordinator]
           animateAlongsideTransition:^(id<UIViewControllerTransitionCoordinatorContext>
                                        context) {
            [[self dimmingView] setAlpha:0.0];
        } completion:nil];
    }
    else {
        [[self dimmingView] setAlpha:0.0];
    }
	}
 
	- (void)dismissalTransitionDidEnd:(BOOL)completed {
    // If the dismissal was successful, remove the dimming view.
    if (completed)
        [self.dimmingView removeFromSuperview];
	}

### 将你的展示视图的控制权给UIKit
当展示一个视图控制器时，请按照以下步骤使用你的自定义展示控制器来显示它：  

* 设置被展示的视图控制器的 modalPresentationStyle 属性给UIModalPresentationCustom。
* 给被展示的视图控制器的 transitioningDelegate 属性赋值一个转场代理。
* 实现转场代理的 presentationControllerForPresentedViewController:presentingViewController:sourceViewController: 方法。 

当需要你的展示控制器时，UIKit会调用你的转场代理的presentationControllerForPresentedViewController:presentingViewController:sourceViewController: 方法。实现该方法应当与清单11-6一样简单。需要简单的创建你的展示控制器，配置它，然后将其返回。若该方法返回nil，UIKit会使用全屏展示样式来展示视图控制器。  

清单11-6 创建一个自定义展示控制器  

	- (UIPresentationController *)presentationControllerForPresentedViewController:
                                 (UIViewController *)presented
        presentingViewController:(UIViewController *)presenting
            sourceViewController:(UIViewController *)source {
 
 	   MyPresentationController* myPresentation = [[MyPresentationController]
   		    initWithPresentedViewController:presented 	presentingViewController:presenting];
 
   		 return myPresentation;
	}
### 适配不同尺寸的类
当展现于屏幕上时，UIKit会在底层的特性或容器视图发生改变的时候通知你的展现视图控制器。改变通常在设备旋转的时候发生，但很可能在其他时机发生。你可以使用特性和尺寸通知来调整你的展现自定义视图并在合适的时机更新你的展现样式。  
更多关于如何适配新特性和尺寸的相关信息，参见“构建一个适配的界面”
# 自适应性和尺寸的变化
## 自适应模型
一个能够自适应的界面是一个能够最佳利用可用区域的界面。能够自适应代表能够调整内容以便在任何iOS设备上都能够很好的适应。iOS上的自适应模型能够以简单但灵活的方式来重新布局和调整你的内容以便适应变化。当你使用该模型的时候，一款简单的app能够以极小的额外代码的代价来适配多种不同的屏幕尺寸（如图12-1所示）。  

图 12-1 适配不同的设备和屏幕方向  

![](https://developer.apple.com/library/content/featuredarticles/ViewControllerPGforiPhoneOS/Art/VCPG_Adaptive-Model_13-1_2x.png)

构建自适应界面的一个重要工具是自动布局。使用自动布局，你可以定义规则（被称作约束）来管理视图控制器中视图的布局。你可以通过在界面编辑器中的图形界面创建这些规则或通过编码的方式创建。当一个父视图的尺寸发生改变的时候，iOS会根据你指定的约束自动的调整你的其余的视图的尺寸和位置。  
特性（Traits）是另一个自适应模型的重要组件。特性描述了你的视图控制器和视图必须运行的环境。特性帮助你在用户界面的更高层次做出决策。
### 特性的作用
当单独使用约束已经不能够满足管理布局的时候，你的视图控制器还有几种机会来做出改变。视图控制器、视图和其他一些对象管理特性的集合, 这些特征指定与该对象关联的当前环境。列表12-1描述了这些特性，以及你如何使用它们来影响你的用户界面。  

列表12-1 特性

特性  | 示例  | 描述
------------- | -------------  | -------------
horizontalSizeClass  |  UIUserInterfaceSizeClassCompact  | 该属性会传递你的用户界面的宽度。使用它来做出一些粗粒度的布局决策，比如视图是否应该垂直布局，一个挨一个的展示，隐藏或者换一种方式展示。
verticalSizeClass  |  UIUserInterfaceSizeClassRegular  | 该属性会传递你的用户界面的高度。若你设计的界面需要将所有的内容都放到屏幕当中而不需要滚动的话，使用该特性来做出相应的决策。
displayScale  |  2.0  | 该属性会传递内容是展示在一个高清屏幕上还是一个标准的分辨率屏幕上。使用它（根据需要）来做出像素级别的决策或者选择一个图片的某个版本来展示。
userInterfaceIdiom  |  UIUserInterfaceIdiomPhone | 该特性提供向下兼容性以及传递你的应用所运行的设备的类型。请尽量避免使用该特性。对于布局相关的决策，请使用水平或垂直尺寸类来替代。

使用特性来觉得如何展示你的用户界面。当在界面编辑器中构建你的界面时，使用特性来改变你要展示的视图和图片，或者将其应用在不同的约束上。很多UIKit类，比如 UIImageAsset，会使用你所指定的特性来筛选它们所提供的信息。  
以下是一些小贴士，帮助你理解使用不同类型的特性：  

* 使用尺寸类来调整用户界面的整体。尺寸类发生改变时是一个添加或删除视图，添加或删除子视图控制器或改变你的布局约束的合适时机。你也可以使用已经存在的布局约束来让你的界面自动适配而无需做什么。
* 不要假设一个尺寸类会等同于一个视图的的指定宽高。你的视图控制器的尺寸类可能由于多种原因发生改变。举例来说，一个iPhone上的容器视图控制器可能会强制其子视图控制器水平放置，以不同的方式显示内容。
* 使用界面编辑器来为每个尺寸类来指定适当的不同的布局约束。使用界面编辑器来设置约束要比你自己添加和删除约束要简单的多。视图控制器通过在其故事版中应用适当的约束来自动处理尺寸类更改。更多关于为不同的尺寸类配置布局约束的相关信息参见“配置你的故事版来处理不同的尺寸类”。
* 避免使用即有信息来决定你的用户界面的布局或内容。运行在iPad和iPhone上的应用应当展现同样的信息，并且使用尺寸类来决定布局。

### 什么时候特性和尺寸变更会发生？

### 不同的机型会有默认的控制尺寸的类

## 构建和适配界面

### 适应特性的改变

#### 配置你的故事版来处理不同的尺寸类

#### 改变一个子视图控制器的特性

#### 适配一个呈现的视图控制器为一个新的样式

#### 实现适配窗口的一些建议

### 响应尺寸变更 