# 涂鸦 智慧居住 iOS SDK 示例

 [English](README.md) | [中文版](README-zh.md)

---

本示例演示了如何使用智慧居住 iOS SDK 构建智能住宅应用程序。智慧居住 iOS SDK 分为多个功能组，包括用户注册流程、站点管理、App 通行管理和密码通行管理。


## 运行环境

- Xcode 12.0及以上版本
- iOS 12.0及以上版本

## 运行示例

1. 智慧居住 iOS SDK 通过 [CocoaPods](http://cocoapods.org/) 进行集成，需要安装 CocoaPods 才能运行本示例，如果你没有安装  CocoaPods，可以通过以下命令安装 CocoaPods:

```bash
sudo gem install cocoapods
pod setup
```

2. Clone或者下载本示例源码，打开终端并进入**Podfile**所在的文件夹路径下，然后在终端执行以下命令:

```bash
pod install
```

3. 运行本示例需要**AppKey**、**SecretKey** 和 **安全图片**，你可以前往 [涂鸦智能 IoT 平台](https://developer.tuya.com/cn/) 注册成为开发者，并通过以下步骤获取：

   1. 登录 [涂鸦智能 IoT 平台](https://iot.tuya.com/)，在左侧导航栏面板分别选择： **App** -> **SDK 开发**
   2. 点击 **创建APP** 进行创建应用.
   3. 填写必要的信息，包括应用名称、Bundle ID等
   4. 点击创建好的应用，在**获取密钥**面板，可以获取 SDK 的 AppKey，AppSecret，安全图片等信息

4. 打开本示例工程的 `TuyaSmartResidenceSDKSample-iOS-ObjC.xcworkspace` 
5. 在 **AppDelegate.m** 中将AppKey、SecretKey替换为你的AppKey和SecretKey

```objective-c
#define APP_KEY @"<#AppKey#>"
#define APP_SECRET_KEY @"<#SecretKey#>"
```
6. 下载**安全图片**并重命名为`t_s.bmp`，将安全图片拖拽到 `Info.plist`所在的文件夹下
7. 如果你想在模拟器上调试（在 M1 芯片的 MacBook 上），请在 Pods project 中加入下图所示内容
    
    <img alt="Pods" src="https://airtake-public-data-1254153901.cos.ap-shanghai.myqcloud.com/content-platform/hestia/1638348535b9dac74712e.png" width="900">
    
**注意**: Bundle ID、 AppKey、AppSecret和安全图片必须跟你在 [涂鸦智能 IoT 平台](https://iot.tuya.com/)创建的应用保持一致，如果不一致则无法正常运行本示例工程。

## 开发文档

关于智慧居住 iOS SDK 的更多信息，请参考： [智慧居住 App SDK](https://developer.tuya.com/cn/docs/app-development).
