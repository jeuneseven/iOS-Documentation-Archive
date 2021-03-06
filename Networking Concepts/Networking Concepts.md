[Networking Concepts 原文链接](https://developer.apple.com/library/content/documentation/NetworkingInternet/Conceptual/NetworkingConcepts/Introduction/Introduction.html#//apple_ref/doc/uid/TP40012487)

# 介绍 

```
重要：这是一个预备文档。尽管技术方面已经评估过了，但并不是最终版本。Apple提供这些信息来帮助你了解相关信息和这里面描述的编程接口。这些信息可能会发生更改，根据本文档实施的软件应根据最终文档进行审核。有关此文档更新的信息，请转到Apple开发网站。在相关参考库当中，在出现的“文档文本”字段当中输入文档的标题。
```

由于在OSX和iOS上大部分的网络是基于TCP/IP交换协议的，所以你在开始编写代码之前，至少应该对于TCP/IP网络模型本身的原理有一个基本的理解。尽管你可以不用学习底层协议也能够执行一些高层的网络任务，但是知晓底层是如何运作的能够帮助你更好的理解为什么出错以及如何在出错的时候进行处理。
## 概览
因特网是一个互相连接的计算机和其他的世界上的提供交流的设备共同组成的巨大网络。当你浏览一个网页的时候，它的服务端的内容可能跨越了一个大洋。你的请求可能通过WiFi路由器，海底电缆，主干线，卫星连接或者由鸽子传递（RFC1149）。在高层，这些网络媒介都是等价的（不管性能特性）。不过，在底层，设备之间的通信是不同的方式进行的，取决于它们所沟通的屋里网络类型。  

![](https://developer.apple.com/library/archive/documentation/NetworkingInternet/Conceptual/NetworkingConcepts/Art/AboutNetworking.png)

在底层，当你访问一个网页的时候，你的电脑会将每个请求分为很小的块，叫做包，然后将每个包分发给一个特定的设备，叫做路由，路由会向前传递这些包给其他路由，以此类推，直到达到最终的服务端（不论它在哪）。返回是以同样的方式发送回来。在这个过程中的每一步，根据硬件所包含的不同，这些包都能够被分为不同的包，或打包成其他类型的包等等。  
本文档解释了互联网底层是如何运作的，不过是为程序员从一个适度较高的水平解释的。如果在阅读完本文档之后你想要了解不同的互联网技术，你可以找一些第三方的书籍来了解更多。此外，大部分的底层互联网技术都在RFCs(Request for Comment的缩写)的协议中描述到了。
## 另请参见
本文档是“网络概览”的协同手册，并解释了如何编写好的网络层代码。
# 网络术语
在网络术语中，host可以是任何连接到一个网络并提供网络交流的结点设备。一个主机可能是一个桌面电脑，一台服务器，一个iOS设备，一个运行在服务器上的虚拟机，或者甚至是一个位于你的桌面上的VoIP电话。它被称作主机是因为它主宰应用程序并运行它。  
同样的，基础结构设备是负责使用网络功能的任何设备。主机和基础结构设备之间的区别在于，基础结构设备通常传递主机发送的信息，而主机主要发送或接收其自己的信息。甚至有一些基础设施设备对TCP/IP网络是完全透明的，例如以太网集线器和交换机（稍后将对这些设备进行更多了解）。  
当一台主机通过网络发送数据时，它会将数据分为小块，称作包。这些包可以使不同长度的，能够达到被物理网络互相连接时允许的最大容量（同样，后续会有详细介绍）。  
一个包通常包含三个基本部分：头部会说明包会被发往哪里，负载部分包含实际数据，尾部标记包含校验信息来确保该包被正确的接收。一些类型的包会包含其校验信息作为头部的一部分，所以就不需要尾部标记了。比如以太网的包结构就是如此。  

图1-1 以太包的结构
![](https://developer.apple.com/library/archive/documentation/NetworkingInternet/Conceptual/NetworkingConcepts/Art/structure_of_an_ethernet_packet.png)

收到信息的主机会重新组装这些包，然后将它们提供给程序作为字节流或者一系列的信息，取决于不同的协议。程序可以通过发送数据来响应，该主机会将数据分为包，然后发送回第一台主机。  
当一个包包含另一个包的时候（通常是不同的类型），这被称作“封装”。比如，以太网的包（图1-1所示）包含一个TCP/IP包在其负载部分；TCP/IP包就被称作被封装在以太网包中。
# 网络层
TCP/IP网络模型由四个基本层构成：链接层，IP层（因特网协议层的缩写），传输层，以及应用层。这些层会在之后的章节中描述到。  

![](https://developer.apple.com/library/archive/documentation/NetworkingInternet/Conceptual/NetworkingConcepts/Art/networking_layers.png)
## 链接层
最底层叫做链接层，或者称作物理层。该层包含用来与附近的物理主机连接的实际硬件设备。链接层传输的是原始的包，通过物理网络从一台主机传输到另一台。   
大部分终端使用者只会直接碰到五中链接层：WiFi，蜂窝网络，以太网，蓝牙和火线。不过它们的数据传输的路径有很多种不同的类型。使用者可能通过基于DOCSIS的调制解调器或者基于VHDSL的DSL调制解调器来发送数据。这时用户的数据可能是通过SONET/SDH链接（用来作为中继）
或者使用IPoS（通过卫星的IP）或者IPoDVB（通过数字视频广播的IP）来发送的。  
网络接口是一系列的提供链接层内部连接的硬件。一台主机可以拥有很多网络接口。举例来说，你可能有一个或更多的（线路）以太网接口，一个WiFi接口，一个蓝牙接口，甚至一个蜂窝网络调制解调器（无论是通过USB接口添加到一台Mac还是iPhone或iPad上）。此外，某些软件也提供（虚拟）网络接口——VPN软件，虚拟环境（类似于OS X 10.4及更早的版本中的Classic环境），等等。  
每个网络接口通常会连接一个或多个额外的接口；它们之间的连接被称作link。尽管这些接口并不是以物理形式连接到另一个，但就操作系统和软件而言，链接等同于物理线路。举例来说，两台电脑通过以太网中心连接或者有一个链接在它们之间交换信息（由于中心和交换是可见的），但两台电脑是被一个网络路由分割开（由于操作系统必须要知道发送数据给路由而不是将其直接发送到主机——稍后将对路由器进行更多介绍）。
当编写软件时，除非你的软解直接与链接层进行交互（通过发送和接收原始包，配置网络接口，读取一个网络接口的硬件ID等等），否则操作系统在很大程度上隐藏了链接层之间的差异（尽管它不能将您与带宽、延迟或可靠性的差异完全隔离开来）。
## IP层
在链接层之上的是IP层。IP 层提供从一台主机到另一台主机的数据包传输，使数据包可以通过多个物理网络传递。  
IP层将路由的概念添加到图片中，这允许你将数据包发送到遥远的目的地。简单来说，数据包从一台主机通过物理连接传输到临近的路由，路由将数据包传输给另一个路由，以此类推，直到数据包达到目的地。返回的数据包也是通过类似的方式传输回去。数据包传输的路径称作route，数据包从一个路由传到另一个路由的每个链接称作hop。  
IP层对于抽象链接层的差异也有帮助。详细来说，不同的链接层支持的包的最大大小是不同的——称作最大传输单元（MTU）。为隐藏这种差异，IP层将包分为不同的片段——这种处理过程称作分段——然后在最终将其重新组装。（注意分段的应用只是作用于获取数据包然后将其拆分；在TCP/IP当中，发送主机包的TCP，但是由于它没有以离散数据包的形式启动，这就不会考虑进行分段了。）  
在大部分网络当中，网络用来发送单个包所花费的时间与MTU之前数据包的大小无关。例如，在以太网当中，无论你是发送一个100字节或1500字节长度的数据包，时间片是一样的。因此，反复对一个数据包进行分段会导致巨大的开销。  
举例来说，如果你通过网络发送一个1500字节的数据包，而MTU是1400字节，第三个网络的MTU是1300字节（这些数字都是任意的），你的1500字节的包将会首先被分解为1400字节的包和一个100字节的包。然后1400字节的包会被分解为一个1300字节的包和第二个100字节的包，最终三个包是一个整体（1300+100+100）。如果你发送1300字节的包和一个200字节的包的话，你的数据将会在最终的网络传输中节省三分之一的带宽。  
分段也有其他的开销。如果一个包的一个分段丢失了，那么整个包就丢失了。这意味着在网络当中有这很高的包丢失率，分段能够增加重传所需的速率（反过来又会使数据包丢失更糟糕）。  
为了避免这种问题，当执行TCP连接的时候，大部分的现代操作系统会使用一种称作路径MTU查找来判断从一台主机发送给另一台主机而无需分段的最大的数据包，因此能够最大化的利用可用带宽。如果你编写发送和接收原始数据包的代码的话，你应该考虑采取类似的步骤。不过，无论何地，你都应该使用TCP/IP，它会为你做这件事。
## 传输层
在IP层之上，你会发现有一些传输层存在。当编写网络代码时，你应该始终结合这些传输层来工作，或者与更高层的层级工作。  
这层最常见的两个协议是传输控制协议（TCP）和用户数据电报协议（UDP）。  
TCP和UDP对于从一台主机传输到另一台主机都提供了基本的数据传输，很像IP协议，但添加了端口号的概念。这些端口号能够让你在一个单一主机上通过提供一种方式来告诉接收主机来运行多种服务，接收主机的服务应该能够接收特定信息。  
像在其下的层级一样，UDP提供了不保证其数据能够到达目标的功能。如果你的数据使用了UDP，如果必要的话，你必须自己处理重新传输。UDP对于需要低延迟的情况是一个比较好的选择，比如实时游戏交流，因为如果客户端状态更新在几毫秒中不可用的话，数据就不在有用处了。不过，作为规则，你应该避免使用UDP，除非你必须支持一个它使用的已经存在的协议。  

	注意：由于UDP的包不会卡主等待前一个包的确认，如果你错误的使用UDP会引起严重的网络阻塞。如果你需要使用UDP，要确保如果你与另一个结点丢失了联系的话，要停止发送数据包一段时间。如果你传输高带宽的数据的话（比如实时音频或视频数据流），要确保设计好你的协议，以便每个结点能够判断接收失败的包的数量。同样，要确保两个结点在发生阻塞时自动缩减传输速率，并尽可能实现路径MTU查找。

与UDP不同，TCP添加了：

* 传递保证——使用TCP传输的数据是能够保证被以其发送的顺序接收到的（虽然可能链接失败）并且是完整的。如果数据不能够被传输，链接会在一个长时间的超时后被断掉。不过，在该时间点之前收到的所有的数据都保证是有序的，并且在中间没有丢失的片段。
* 阻塞控制——如果数据由于链接的过度使用而丢失，则发送主机会降低传输速度。
* 流程控制——当繁忙时，接收主机会告诉发送主机等到它准备好处理更多的数据。
* 基于数据流——你的软件应该将数据视为一系列字节而非一系列离散的记录（在UDP的说法中称作消息）。注意如果你想要使用TCP发送一系列离散的记录的话，你必须自己编码记录的包（举例来说，使用MIME多步消息编码）。
* 路径MTU查找——TCP会选择最大尺寸的数据包，以避免路由过程中的碎片化。

而作为对比，UDP支持三种TCP不支持的：  

* IPv4中的广播消息——
* 多播消息——
* 记录数据包的保留——

## 应用层
应用层位于协议栈的顶部。该层包含的协议有超文本传输协议（HTTP）和文件传输协议（FTP）。  
应用层如此命名是因为该层的细节是特指一个特定的应用或一类应用程序。换句话说，该层是直接受你的程序所控制的，无论你是自己实现你的应用层协议还是仅仅是要求操作系统代表你这么做。
# 理解潜在因素

# 寻址方案和域名

## 链接层寻址

## IP层寻址

## 域名系统

### 什么是域名？

### 查找名称

### 其他的DNS的使用

# 包路由和传递

## IPv4路由

## IPv6路由

## 防火墙和网络地址传输

# 动态地址分配

## 动态主机配置协议(DHCP)和DHCPv6

## 临近探查和IPv6地址分配

## 本地连接寻址和Bonjour