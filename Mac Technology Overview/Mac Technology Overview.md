[Mac Technology Overview](https://developer.apple.com/library/archive/documentation/MacOSX/Conceptual/OSX_Technology_Overview/About/About.html#//apple_ref/doc/uid/TP40001067)

# 简介
## 关于为 Mac 开发

OS X 操作系统融合了稳定的核心一级先进的技术来帮助你交付世界级的产品给 Mac 平台。知晓这些技术是什么，如何使用它们，能够帮助你在访问关键 OS X 功能时精简你的开发过程。  

![](https://developer.apple.com/library/archive/documentation/MacOSX/Conceptual/OSX_Technology_Overview/art/MacBookProDesktop_2x.png)

### 概览

本指南为你介绍了开发 Mac 软件的潜力边界，描述了你可以用来软件开发的多种技术，并为你指出了关于这些技术的信息源。它并不描述用户级别的系统功能或者对于软件开发没有影响的功能。  

#### OS X 在每一层都有一个关键技术的层级架构

有必要看一下 OS X 的实现是作为一个层级的集合的。最底层的操作系统提供了基础服务给所有软件依赖。随后的一层包含了更多的复杂服务和构建（或补充）下一层级的技术。  

图 1-1 OS X 的层级  

![](https://developer.apple.com/library/archive/documentation/MacOSX/Conceptual/OSX_Technology_Overview/art/osx_architecture-layers_2x.png)

底层技术更加专注于它提供的服务。通常来讲，高层的技术会将底层提供的技术纳入常见的应用行为。比较好的规则是使用高等级的编程接口来达成你的应用的目标。以下是 OS X 层的简介。  

- Cocoa（应用）层
- 媒体层
- 核心服务层
- 核心系统层
- 内核和驱动层

相关章节：[Cocoa 应用层](https://developer.apple.com/library/archive/documentation/MacOSX/Conceptual/OSX_Technology_Overview/CocoaApplicationLayer/CocoaApplicationLayer.html#//apple_ref/doc/uid/TP40001067-CH274-SW1)，[媒体层](https://developer.apple.com/library/archive/documentation/MacOSX/Conceptual/OSX_Technology_Overview/MediaLayer/MediaLayer.html#//apple_ref/doc/uid/TP40001067-CH273-SW1)，[核心服务层](https://developer.apple.com/library/archive/documentation/MacOSX/Conceptual/OSX_Technology_Overview/CoreServicesLayer/CoreServicesLayer.html#//apple_ref/doc/uid/TP40001067-CH270-BCICAIFJ)，[核心系统层](https://developer.apple.com/library/archive/documentation/MacOSX/Conceptual/OSX_Technology_Overview/CoreOSLayer/CoreOSLayer.html#//apple_ref/doc/uid/TP40001067-CH9-SW1)，[内核和驱动层](https://developer.apple.com/library/archive/documentation/MacOSX/Conceptual/OSX_Technology_Overview/SystemTechnology/SystemTechnology.html#//apple_ref/doc/uid/TP40001067-CH207-BCICAIFJ)

#### 你可以为 Mac 创建多种类型的软件

使用开发者工具和系统框架，你可以为 Mac 开发大量不同的软件，包括以下内容：

- 应用。
- 框架和库。
- 命令行工具和后台常驻程序。
- 应用插件和可加载的包。
- 系统插件。

相关章节：[为 Mac 平台创建软件产品](https://developer.apple.com/library/archive/documentation/MacOSX/Conceptual/OSX_Technology_Overview/SoftwareProducts/SoftwareProducts.html#//apple_ref/doc/uid/TP40001067-CH206-TPXREF101)

#### 当移植一款 Cocoa Touch 应用时，要意识到 API 的类似和不同

Cocoa 和 Cocoa Touch 应用的技术栈的基础是有很多类似的。一些系统框架在每个平台都是相同（或者几乎是相同的），包括 Foundation, Core Data, 和 AV Foundation。这种 API 的共性让迁移任务——比如从你的 Cocoa Touch 应用迁移数据模型——容易很多。  
其他迁移任务更加具有挑战，因为它们依赖于在不同平台上影响的不同的框架。比如，端口控制器对象和审查用户界面更加依赖于任务，因为它们依赖于 AppKit 和 UIKit，这两个分别是在 Cocoa 和 Cocoa Touch 层的主要应用框架。

相关章节：[从 Cocoa Touch 迁移](https://developer.apple.com/library/archive/documentation/MacOSX/Conceptual/OSX_Technology_Overview/MigratingFromCocoaTouch/MigratingFromCocoaTouch.html#//apple_ref/doc/uid/TP40001067-CH8-SW1)

### 另请参阅

Apple 为开发者提供了工具和额外信息来支持你的开发功能。  
Xcode，苹果的集成开发环境，帮助你设计，创建，调试及优化你的软件。你可以从 Mac App Store 下载 Xcode。  
关于 OS X 的开发工具概览，参见 [Xcode 苹果开发者网页](https://developer.apple.com/xcode/)，关于 Xcode 功能概览，阅读 [Xcode 概览](https://developer.apple.com/library/archive/documentation/ToolsLanguages/Conceptual/Xcode_Overview/index.html#//apple_ref/doc/uid/TP40010215)。  
OS X 开发者库包含了文档，示例代码，指南和其他你编写 OS X 软件的时候所需的信息。你可以从 [苹果开发者网站](https://developer.apple.com/library/mac/navigation/) 或 Xcode 中访问 OS X 开发者库。在 Xcode 中，选择 帮助 > 文档和 API 参考 来查看文档和其他再管理中心窗口中的资源。  
除了 OS X 开发者库，还有其他不同类型的软件信息资源来给 Mac 开发：

- 苹果开源项目。Apple 制作来 OS X的主要部分——包括 UNIX 核心——可以在开发者社区中见到。要了解有关苹果在开源开发中的提交，参见 [开源开发资源](https://developer.apple.com/opensource/)。要了解更多的专题开源工程，比如 Bonjour 和 WebKit，参见 [Mac OS 形成](http://www.macosforge.org)。
- BSD。伯克利软件分发系统(BSD)是基于 UNIX 的基础，是 OS X 核心环境的一部分。很多优秀的有关 BSD 和 UNIX 的书籍在书店中都可以找到。你也可以查找到额外的覆盖 BSD 变体的信息——比如，[FreeBSD 工程](http://www.freebsd.org)
- 第三方书籍。在 Mac app 中在线有很多优秀的开发书籍，以及书店中的技术部分。

# 为 Mac 平台创建软件产品

# Cocoa 应用层

# 媒体层

# 核心服务层

# 核心系统层

# 核心和驱动层

# 从 Cocoa Touch 迁移

# 附录