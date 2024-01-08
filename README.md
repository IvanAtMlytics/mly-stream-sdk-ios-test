# p2sp-sdk-ios
[![Language](https://img.shields.io/badge/Swift-5.0-green.svg?style=flat)](http://cocoapods.org/pods/MLYSDK)  

## Examples

To run the example project, clone the repo, and run `pod install` from the Example directory first.

## Requirements

## Installation

MLYSDK is available through [CocoaPods](https://cocoapods.org). To install
it, simply add the following line to your Podfile: 

### Cocoapods

```bash
pod 'MLYSDK' 
```

or

```bash
pod 'MLYSDK',:git => 'https://github.com/mlytics/mly-stream-sdk-avplayer.git'
```

## Usage Swift

### 1 - Prepare  ###
 
```swift
self.player = .init()
self.playerViewController = .init()

self.playerViewController.showsPlaybackControls = true
self.playerViewController.player = self.player
self.addChild(self.playerViewController)
self.view.addSubview(self.playerViewController.view)
``` 

### 2 - initialize  MLYDriver ###

```swift 
do {
    try MLYDriver.initialize { options in
        options.client.id = client_id 
    }
} catch {
    print(error)
}
```

### 3 - plugin  ###

```swift    
var plugin: MLYAVPlayerPlugin = .init()

self.plugin.adapt(self.playerViewController)
```


### 4 - Play Video  ###

```swift 
func playVideo() {
    let url = URL(string: play_m3u8)!
 
    let playerItem = AVPlayerItem(url: url)
    self.player.replaceCurrentItem(with: playerItem)
    self.player.play()
}
```

## Usage Objective-C

### 1 - Prepare  ###
 
```objective-c
_avplayer = [[AVPlayer alloc] init];
_avplayerController = [AVPlayerViewController new];
_avplayerController.showsPlaybackControls = true;
_avplayerController.view.backgroundColor = UIColor.darkGrayColor;
_avplayerController.player = _avplayer;

[self addChildViewController:_avplayerController];
[[self view] addSubview:_avplayerController.view];
``` 

### 2 - initialize  MLYDriver ###
```objective-c 
NSError *error = nil;
[MLYDriver initializeAndReturnError: &error :^(MLYDriverOptions *option) {
   [option client] setId:@"client_id"];
}];
if(error){
    NSLog(@"Error: %@", error.domain);
} 
```

### 3 - plugin  ###

```objective-c    
_plugin = [MLYAVPlayerPlugin alloc];
[_plugin adapt:_avplayerController];
```


### 4 - Play Video  ###

```objective-c 
func playVideo() {
    NSURL *url = [NSURL URLWithString:@"play_m3u8"];
    AVPlayerItem *item = [AVPlayerItem playerItemWithURL:url];
    [_avplayer replaceCurrentItemWithPlayerItem:item];
    [_avplayer play];
}
```


## XCode build archive

### 在MLYSDK源码项目中build
使用 Terminal cd 到 Example 示例项目文件夹，执行指令（执行之前先删除掉之前生成的文件）
```bash 
xcodebuild clean -workspace MLYSDK.xcworkspace -scheme MLYSDK

xcodebuild archive \
    -workspace MLYSDK.xcworkspace \
    -scheme MLYSDK  \
    -configuration Release \
    -sdk iphonesimulator \
    -destination='generic/platform=iOS Simulator' \
    -archivePath ../Archives/ios-simulator \
    ENABLE_BITCODE=NO \
    SKIP_INSTALL=NO \
    BUILD_LIBRARY_FOR_DISTRIBUTION=YES

xcodebuild archive \
    -workspace MLYSDK.xcworkspace \
    -scheme MLYSDK  \
    -configuration Release \
    -sdk iphoneos \
    -destination='generic/platform=iOS' \
    -archivePath ../Archives/ios-device \
    ENABLE_BITCODE=NO \
    SKIP_INSTALL=NO \
    BUILD_LIBRARY_FOR_DISTRIBUTION=YES

xcodebuild -create-xcframework \
    -framework ../Archives/ios-device.xcarchive/Products/Library/Frameworks/MLYSDK.framework \
    -framework ../Archives/ios-simulator.xcarchive/Products/Library/Frameworks/MLYSDK.framework \
    -output ../archive/MLYSDK.xcframework
```

or

### 使用 Terminal cd 到xcodebuild-xcframeworks.sh文件项目根目录找 执行下面指令
```bash 
sh ./xcodebuild-xcframeworks.sh
```

## CocoaPods 正式環境上版步驟 (包含 binary 搬移步驟)


![Image text](https://github.com/mlytics/p2sp-sdk-ios/blob/main/Documents/images/cocoapods.png?raw=true)
从上图来看，大概需要了解这几个流程：

* 我们的代码，需要push 到 trunk库中；
* trunk 会更新到 github的specs repo库
* 更新后，我们才能用pod install 安装我们push上去的代码


### 一、注册
执行命令：

```swift 
pod trunk register 邮箱 用户名 --verbose
```
然后你会收到一封确认邮件, 点击邮箱链接，即可完成注册

### 二、查看注册信息

```swift 
pod trunk me
```
可查看注册信息  

### 三、提交podspec文件到cocoapods

### 在poc项目中操作，把源MLYSDK中build好的文件挪到poc中更新上传

* 提交本地代码到Github，并打上tag

1.如果修改了SDK，需要在源代码SDK中编译xcframework文件

![Image text](https://github.com/mlytics/p2sp-sdk-ios/blob/main/Documents/images/buildsu.png?raw=true)  
![Image text](https://github.com/mlytics/p2sp-sdk-ios/blob/main/Documents/images/xcframework.png?raw=true) 

编译成功后会生成 .xcframework 文件

2.把最新SDK push 到Github，成功后对此次push打上tag再次push

注意：push之前需要更新本地 .podspec 的版本号，然后进行提交
          
```swift 
git add .
git commit -m""
git push  
```

例如：
![Image text](https://github.com/mlytics/p2sp-sdk-ios/blob/main/Documents/images/gitpush.png?raw=true)

3.给此次push添加tag标签

```swift 
git tag 标签
git push --tags
```

![Image text](https://github.com/mlytics/p2sp-sdk-ios/blob/main/Documents/images/tagpush.png?raw=true)
注意：这里一定要打tag，而且tag必须和podspec文件的版本号一致

然后执行，等待一段时间即可完成。

### push podspec文件

```swift 
pod trunk push 库名字.podspec --allow-warnings
```

例如：
![Image text](https://github.com/mlytics/p2sp-sdk-ios/blob/main/Documents/images/trunkpush.png?raw=true)

### 成功后可搜索到你的库

```swift 
pod search 库名字
```

例如：
![Image text](https://github.com/mlytics/p2sp-sdk-ios/blob/main/Documents/images/search1.png?raw=true)
![Image text](https://github.com/mlytics/p2sp-sdk-ios/blob/main/Documents/images/search2.png?raw=true)
如果搜索出来版本号不是最新版本请稍等几分钟后再试
