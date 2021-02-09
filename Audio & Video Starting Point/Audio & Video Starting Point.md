[Audio & Video Starting Point](https://developer.apple.com/library/archive/referencelibrary/GettingStarted/AudioVideoStartingPoint_iOS/index.html#//apple_ref/doc/uid/TP40007298)

iOS中的多媒体技术能够让你访问iPhone，iPad和iPod touch上复杂的音视频功能。特定的类能够让你很容易就能添加基本功能，比如iPod曲库回放和电影拍摄，而丰富的多媒体APIs支持更高级的解决方案。  

![](https://developer.apple.com/library/archive/referencelibrary/GettingStarted/AudioVideoStartingPoint_iOS/Art/startingPoint_AudioVideo.jpg)

根据所需选择正确的技术：  

* 要在用户的iPod曲库中播放音频项目，或者播放本地或流媒体电影，使用Media Player框架。该框架中的类会自动的自持发送音视频给AirPlay设备，比如Apple TV。
* 要想给你的应用添加图片或者视频录像，应采用UIKit框架中的专用类和函数。
* 对于基本的录音和回放，包括立体声平移，同步和计量，使用AV Foundation框架中的音频类。
* 要添加高性能定位的音频回放到你的基于OpenGL的游戏或者其他应用中，需要用好开源OpenAL API（公开音频库）。
* 要直接操作音视频数据——类似VoIP，流，虚拟音乐工具，或者MIDI（音乐工具数字化界面）等高性能或者高级解决方案——使用AV Foundation框架，Assets库框架，不同的Core Audio框架（包括Core Audio, Audio Toolbox, 和 Audio Unit框架）以及Core MIDI框架。  

# 快速建立和运行

通过查看以下资源能够让你对于iOS音频开发有所熟悉：  

* 阅读《多媒体编程指南》中的“使用音频”部分了解iOS设备的音频开发。要确保理解“基础：音频编码，支持的音频格式和音频会话”中介绍的音频会话对象的重要性。
* 查看“avTouch”示例代码工程，它展示了如何使用 AVAudioPlayer 类来播放音频；“SpeakHere”工程，它演示了基本的录制和回放；以及“Audio UI Sounds (SysSound)”工程，它演示了如何调用震动马达并播放警告和用户界面声效。
* 下载并探索“AddMusic”示例代码工程，查看如何添加iPod库回放到你的应用的演示。
* 阅读《MPVolumeView类参考》来了解如何快速添加AirPlay功能给你的应用。

快速建立和运行iOS视频开发是通过以下资源：  

* 阅读《多媒体编程指南》中的“使用视频”部分，了解iOS设备上的视频录制和回放概括。
* 阅读“MoviePlayer”示例代码项目，它展示了MPMoviePlayerController类在播放本地或者流视频内容上的作用；以及“PhotoPicker: Using UIImagePickerController to Select Pictures and Take Photos”项目，它展示了使用UIKit框架展示视频和图片录像。
* 继续通过阅读《iOS摄像头编程话题》来了解如何拍照和录像，以及浏览照片库，使用 UIImagePickerController 类。

# 在音频开发方面成为专家

通过阅读《音频会话编程指南》来完整了解音频会话对象以及它们是如何决定你的应用的音频行为的。同样要阅读“声音”部分，它解释了你的应用应该如何处理声音和用户预期。  
无论你采用iOS的哪种音频技术，用户都期待在多任务UI中能够使用系统传输控件来播放和暂停你的应用的音频。要了解如何支持这项功能，阅读《iOS事件处理指南》中的“多媒体远程控制”。  
阅读《iPod库访问编程指南》结合《媒体播放器框架参考》来完全利用iPod库。  
要了解如何使用OpenAL播放音频，查看“oalTouch”项目。  
要播放流媒体音频内容，比如从网络连接中获取到的，使用“Playback”中描述到的AVPlayer对象。你还可以通过使用MPMoviePlayerController类播放特定网络音频文件；示例代码参照“MoviePlayer”。  
要播放立体声平移，同步和计量的音频文件，使用 AVAudioPlayer 类。要录制音频，使用 AVAudioRecorder 类。当你不需要直接访问音频数据的时候，Apple推荐这些类来控制音频回放和录制。  
要开始直接处理音频数据，阅读《核心音频概览》中的“核心音频概要”部分，了解架构，编程规范和核心音频的使用。  
如果你要创建VoIP（互联网协议通话）应用或者虚拟音乐工具，你就需要用到iOS上的高性能音频了。解决方案就是audio units，iOS音频插件技术。音频单元同样提供了高级功能，包含混合和均衡。阅读《iOS音频单元主持指南》了解如何使用音频单元。查看“Audio Mixer (MixerHost)”和“Mixer iPodEQ AUGraph Test”示例代码工程。  
要创建MIDI应用来连接硬件键盘或者一款iOS设备的合成器，参考“Core MIDI框架参考”以及“MFi program”。  

# 在视频开发方面成为专家

要使用Media Player框架和UIImagePickerController类中没有的功能，要阅读 AVFoundation 编程指南。 AV Foundation，由Assets库和Core Media框架支持，提供了工具来定制音频解决方案，包括基于轨道的编辑，编码转换和直接从摄像头和麦克风访问数据。  
查看“AVCam-iOS: Using AVFoundation to Capture Images and Movies”示例代码工程了解如何使用AV Foundation框架拍摄静止照片和视频。“AVCam”演示了几种AV Foundation类中重要的使用方法。查看“AVPlayerDemo”项目了解如何从iPod库中播放视频。  