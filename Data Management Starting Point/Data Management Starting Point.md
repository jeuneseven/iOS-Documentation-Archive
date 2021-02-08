[Data Management Starting Point](https://developer.apple.com/library/archive/referencelibrary/GettingStarted/GS_DataManagement_iPhone/index.html#//apple_ref/doc/uid/TP40007299)

数据管理包含了创建和处理各种类型的数据，包括字符串，文本，原始数据，日期，集合，属性列表和XML数据。你还可以使用数据管理API来存储和访问本地数据库、文件、文件夹和软件包中的数据。  

![](https://developer.apple.com/library/archive/referencelibrary/GettingStarted/GS_DataManagement_iPhone/Art/DataManagementSP.png)

# 快速建立和运行

从开始阅读有关你要使用的对应数据类型的编程指南开始，参考《Foundation框架参考》OC类的详情以及《Core Foundation框架参考》基于C的API详情。你可以选择使用Foundation框架中的OC数据管理类或者Core Foundation框架的C不透明类型等效项目。  

* 阅读《数字和值编程话题》来了解对于数字和值数据类型的对象封装。
* 阅读《字符串编程指南》或者《Core Foundation字符串编程指南》来了解如何创建，搜索，组合以及绘制字符串。
* 阅读《元数据编程指南》或者《Core Foundation元数据编程指南》了解如何操作元数据。
* 若你的应用程序会追踪日期和时间，阅读《日期和时间编程指南》或者《Core Foundation日期和时间编程指南》。阅读《计时器编程话题》了解如何执行延时或定期动作。
* 阅读《集合编程话题》或者《Core Foundation集合编程话题》了解如何管理一组对象。

探索《Foundation框架参考》中的类也能够与文件系统交互。阅读《底层文件管理编程话题》中的方法和函数了解如何操作文件和文件夹。  

# 成为专家

一旦你在你的应用中使用过基本数据对象和类型，你可能就会想要修改和存储它们了。  
要了解数据的格式化，阅读《数据格式化指南》或者《Core Foundation数据格式化指南》。  
在《排序描述编程话题》中还描述了如何排序集合对象。  
阅读《谓词编程指南》了解如何在Cocoa中创建查询。谓词能够被用在结合中，而非只能够用在Core Data 或者 Spotlight中。  
还有很多种不同的方式来存储数据对象类型。阅读《归档和序列化编程指南》了解如何存储一系列相关的对象和值。  
阅读《软件包编程指南》了解如何访问存储在被称为软件包的文件结构中的数据。  
阅读《属性列表编程指南》或者《Core Foundation 属性列表编程指南》了解如何讲数据组织到命名值和值列表当中。你可以随意的存储一个属性列表为XML数据。参见示例代码工程“TheElements”，一个使用属性列表存储化学元素数据的原生应用。  
要了解如何使用Core Data 用于常规对象图管理和持久化，请遵循《Core Data Starting Point》中的建议概览。  

# 提供应用级的偏好设置

偏好设置是被设置用来配置应用程序的行为和展现的。  
阅读《iOS应用程序编程指南》中的“实现应用程序偏好设置”来了解如何使用系统提供的“设置”应用程序来展示应用程序级别的偏好设置。  
如果你需要比“设置”应用提供的更灵活的功能，你可以在你自己的应用程序中使用Foundation框架提供的NSUserDefaults类来管理偏好设置。更多信息，参见《偏好设置和设置编程指南》。如果你更倾向于使用Core Foundation，阅读《Core Foundation偏好设置编程话题》。  

# 访问通讯录信息

通讯录是一个用于联系人和其他私人信息的集中式的数据库。联系人信息对于类似email和聊天程序类的软件非常重要。  
阅读《iOS地址簿编程指南》了解如何在你的应用程序中利用联系人数据库。你不仅能够访问用户的联系人数据，还能够设计和实现该数据的你自己的属性和行为。参考《地址簿框架参考》了解详情。  
