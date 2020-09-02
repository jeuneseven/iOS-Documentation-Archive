[Doing Basic Optimization to Reduce Your App’s Size 原文链接](https://developer.apple.com/documentation/xcode/reducing_your_app_s_size/doing_basic_optimization_to_reduce_your_app_s_size?language=objc)

# 做一些基本的优化来减小你的App大小

调整你的项目的构建设置，以及使用一些类似 bitcode 和 资源目录等技术在你的应用的开发生命周期中。

## 概览

在你评估了你的应用大小之后，你可以做一些基本的优化让其更小一些。如果你开始一个新的应用程序工程，可以通过选用类似资源目录或者bitcode等技术来创建一个固定的框架。早期通过采用这种技术，你可能会减少后续需要花费在优化上的可能性。  

![](https://docs-assets.developer.apple.com/published/03e280493c/dda8528d-7847-4b50-9d84-95b0fa7cc696.png)

### 为发布版本检查你的 target 的 Build Settings

在你检测了你的应用大小之后，你可能会发现它比你想象的要大。如果你不注意改变工程设置的话，就可能发生这种问题。发布配置的默认优化等级是 Fastest，Smallest [-Os]，这可以让你的编译二进制非常小。检查一下你的目标构建设置，确定你使用这种优化等级。

### 确定并移除无用的资源

其次，查看你的应用的IPA文件，查找一下你的应用程序是否包含无用的资源或者无用的文件。第一步遵循“缩小你的应用程序尺寸”中所描述的创建一个。然后遵循以下步骤：  
	
	1.打开Finder并找到你想要检测的IPA文件。
	2.把IPA文件的后缀改为ZIP。（一个IPA文件就是一个ZIP包，只是当解压的时候是一个特殊结构。）
	3.解压缩文件并进入Payloads目录，你也可以在Finder中打开ZIP文件，或者在终端里运行 unzip -lv /path/to/your/app.zip 。
	4.右键点击应用包，选择在包内容中展示。

在适当的位置从你的Xcode工程或目标中移除那些无用的文件。举例来说，确保你没有添加你的应用的README文件到目标中，移除无用的图片资源和头文件，等等。

### 为你的应用程序资源采用资源目录

资源目录能够让Xcode和App Store来优化你的应用的资源，这就能够显著的降低你的应用的尺寸。使用资源目录替代直接将你的资源放在你的应用包中；

### 开启bitcode

Bitcode 是一种Apple的技术，它能够让你重新编译你的应用来缩小其大小。当你上传你的应用到Apple Store Connect或者导出为Ad Hoc、开发或企业发布时就会重新编译。想了解更多关于Bitcode的相关内容，参见《发布选项》。

## 另请查阅

包大小优化“进行进一步的优化来降低你的应用大小”