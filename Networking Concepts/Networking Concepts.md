[Networking Concepts 原文链接](https://developer.apple.com/library/content/documentation/NetworkingInternet/Conceptual/NetworkingConcepts/Introduction/Introduction.html#//apple_ref/doc/uid/TP40012487)

# 介绍 
由于在OSX和iOS上大部分的网络是基于TCP/IP交换协议的，所以你在开始编写代码之前，至少应该对于TCP/IP网络模型本身的原理有一个基本的理解。尽管你可以不用学习底层协议也能够执行一些高层的网络任务，但是知晓底层是如何运作的能够帮助你更好的理解为什么出错以及如何在出错的时候进行处理。
## 概览
因特网是一个互相连接的计算机和其他的世界上的提供交流的设备共同组成的巨大网络。当你浏览一个网页的时候，它的服务端的内容可能跨越了一个大洋。你的请求可能通过WiFi路由器，海底电缆，主干线，卫星连接或者由鸽子传递（RFC1149）。在高层，这些网络媒介都是等价的（不管性能特性）。不过，在底层，设备之间的通信是不同的方式进行的，取决于它们所沟通的屋里网络类型。  

![](https://developer.apple.com/library/archive/documentation/NetworkingInternet/Conceptual/NetworkingConcepts/Art/AboutNetworking.png)

在底层，当你访问一个网页的时候，你的电脑会将每个请求分为很小的块，叫做包，然后将每个包
## 另请参见
本文档是“网络概览”的协同手册，并解释了如何编写好的网络层代码。
# 网络术语

图1-1 以太包的结构
![](https://developer.apple.com/library/archive/documentation/NetworkingInternet/Conceptual/NetworkingConcepts/Art/structure_of_an_ethernet_packet.png)

# 网络层

## 连接层

## IP层

## 传输层

## 应用层

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