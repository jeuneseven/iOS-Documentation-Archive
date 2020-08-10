[Doing Basic Optimization to Reduce Your App’s Size 原文链接](https://developer.apple.com/documentation/xcode/reducing_your_app_s_size/doing_basic_optimization_to_reduce_your_app_s_size?language=objc)

# 做一些基本的优化来减小你的App大小

调整你的项目的构建设置，以及使用一些类似 bitcode 和 资源目录等技术在你的应用的开发生命周期中。

## 概览

### 为发布版本检查你的 target 的 Build Settings

### 确定并移除无用的资源

### 为你的应用程序资源采用资源目录

### 开启bitcode

Bitcode 是一种Apple的技术，它能够让你重新编译你的应用来缩小其大小。当你上传你的应用到Apple Store Connect或者导出为Ad Hoc、开发或企业发布时就会重新编译。想了解更多关于Bitcode的相关内容，参见《发布选项》。