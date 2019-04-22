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
图1-1 以太包的结构
![](https://developer.apple.com/library/archive/documentation/NetworkingInternet/Conceptual/NetworkingConcepts/Art/structure_of_an_ethernet_packet.png)

# 网络层
![](https://developer.apple.com/library/archive/documentation/NetworkingInternet/Conceptual/NetworkingConcepts/Art/networking_layers.png)
## 连接层

## IP层

## 传输层

## 应用层
应用层位于协议栈的顶部。该层包含的协议有超文本传输协议（HTTP）和文件传输协议（FTP）。
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