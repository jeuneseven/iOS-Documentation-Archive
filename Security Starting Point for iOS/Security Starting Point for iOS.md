[Security Starting Point for iOS](https://developer.apple.com/library/archive/referencelibrary/GettingStarted/GS_Security_iPhone/index.html#//apple_ref/doc/uid/TP40007302)

应用程序的安全是关于在读、窃取或者被恶意的人访问等方面保护用户的信息。安全不能够事后被添加到代码当中；必须在构建的时候就有。要维护你的用户信息的安全，你的iOS应用程序必须能够抵抗攻击，并且你必须保护你的用户数据在一个安全的环境中。  
iOS安全功能是由核心系统层实现，并且安全APIs是在系统架构的核心服务层中。

![](https://developer.apple.com/library/archive/referencelibrary/GettingStarted/GS_Security_iPhone/Art/security-layers.jpg)  

图1-1 安全APIs和系统架构

# 快速建立和运行

有关展示如何使用keychain来存储密码和其他秘钥的示例代码，以及如何在应用程序之间共享keychain，参见“GenericKeychain”。  
有关展示如何使用Security框架中的创建加密函数，参见“CryptoExercise”。  

# 成为专家

如果你想要学习为什么以及如何编写安全的代码，阅读《安全编码指南》。

# 安全的下载或发送数据