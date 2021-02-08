[Networking & Internet Starting Point](https://developer.apple.com/library/archive/referencelibrary/GettingStarted/GS_Networking_iPhone/index.html#//apple_ref/doc/uid/TP40007301)

iOS包含了多个框架和库让开发者添加网络和基于因特网的功能给它们的应用程序。开发者通过Foundation 和 Core Foundation 框架以及CFNetwork 和 BSD Sockets获得主要协议和服务。当你使用这些接口时，你不需要选择到底是使用Wi-Fi还是移动网络。接口会自动的访问底层设备硬件，选择最佳传输选项，并根据需要无缝的从一种网络转换到另一种。  

![](https://developer.apple.com/library/archive/referencelibrary/GettingStarted/GS_Networking_iPhone/Art/NetworkingInternet_SP.jpg)

# 快速建立和运行

在你开始编写代码前，阅读《文档传输策略》审视当为iOS编写网络应用程序时需要考虑的问题。选择你想要用来编写你的网络层代码的语言。iOS支持以C和OC编写网络层代码。你选择的语言很大程度上取决于使用的舒适度和从另一个平台移植已经存在的网络层代码。  
判断你是想要直接使用套接字还是使用抽象层。iOS对于大部分的套接字交互提供了便捷的封装，使得直接与套接字进行交互变得没有必要。这取决于你是想要使用Bonjour来发现已经存在的网络层服务还是注册一个新的网络。  
在你已经完成这些步骤之后，你最好准备好选择你要使用的网络层的API。  

# 称为专家

如果你在开发一款与网络层交互的应用程序，你需要熟悉iOS提供的APIs，以便你能够使用它们来访问网络协议和服务。如果你在开发的应用会与网络服务交互，举例来说，你可能会要选择Apple的Core Foundation 或 Foundation框架中基于HTTP的APIs。如果你编写的软件需要直接访问套接字，你需要理解不同的套接字APIs。

# 使用URLs下载资源

核心基础URL访问工具（CFURL），以及在其之上构建的NSURL，提供了一种方便的方式来下载单一文件或者其他从网页服务或者FTP服务中提供的资源。CFURL是基于C的APIs，它是Core Foundation框架的一部分。你还可以从《CFURL参考》中了解它们。NSURL是基于OC的APIs，它是Foundation框架的一部分。你可以从《NSURL类的OC参考》中了解它们。

# 使用HTTP和FTP流与Web和文件服务交互

如果你的应用程序需要与web服务器或者FTP服务器进行交互时的需要超出了CFURL 或者 NSURL的APIs提供的范围，你应该考虑使用CFHTTPStream和CFFTPStream APIs。这些提供了复杂的HTTP和FTP的请求支持，比如HTTP GET和POST请求，HTTP cookie 和请求头管理，FTP字典管理和FTP文件上传。  
要从整体上了解这些APIs，阅读《CFNetwork 编程指南》。有关API文档的详情，阅读《CFHTTPStream参考》和《CFFTPStream参考》。  

# 使用Sockets沟通

如果你的应用程序使用套接字，iOS在 Core Foundation 中提供了运行循环套接字整合APIs，也可以直接访问这些APIs构建的BSD套接字。如果你要为Mac OS X设计网络层应用程序并为iOS编写网络层应用程序，你可以使用同样的网络层APIs。如果你决定使用套接字层的CFNetwork APIs，你应该阅读《CFNetwork编程指南》和《CFNetwork编程参考》。  
尽管在iOS上BSD（POSIX）网络层APIs是可以使用的，你也应该尽量避免使用它们。若你想直接与套接字进行通信，则某些iOS的功能不起作用（比如按需VPN）。请改为使用CFStream套接字额外功能。要了解BSD (POSIX)网络，请阅读UNIX 套接字问答网页，了解示例代码和一般信息。有关API详细信息，阅读iOS手册中的socket(2)。  

# 注册和发现网络服务

你可以使用Bonjour注册网络服务或者探索网络服务器。要做到这一点，使用基于C的CFNetServices或者基于OC的NSNetServices API。这些API在《NSNetServices 和 CFNetServices 编程指南》中有所描述。有关API文档的详情，阅读《CFNetServices参考》和《NSNetService类参考》中的CFNetwork和Foundation有关该API的部分。
