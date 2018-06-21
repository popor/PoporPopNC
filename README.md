# PoporPopNC

[![CI Status](https://img.shields.io/travis/wangkq/PoporPopNC.svg?style=flat)](https://travis-ci.org/wangkq/PoporPopNC)
[![Version](https://img.shields.io/cocoapods/v/PoporPopNC.svg?style=flat)](https://cocoapods.org/pods/PoporPopNC)
[![License](https://img.shields.io/cocoapods/l/PoporPopNC.svg?style=flat)](https://cocoapods.org/pods/PoporPopNC)
[![Platform](https://img.shields.io/cocoapods/p/PoporPopNC.svg?style=flat)](https://cocoapods.org/pods/PoporPopNC)

## Example

To run the example project, clone the repo, and run `pod install` from the Example directory first.

## Requirements

## Installation

PoporPopNC is available through [CocoaPods](https://cocoapods.org). To install
it, simply add the following line to your Podfile:

```ruby
pod 'PoporPopNC'
```

在UINavigationController点击返回或者侧滑手势的时候,拦截系统函数,方法在PoporPopCheckDelegate中.
本来是使用QMUI_iOS的,但是QMUI_iOS的触发机制有问题,方法名称是模仿的QMUI.
经过几个月的使用,没有发生导航栏和vc不同步的bug.
允许修改允许修改返回按钮文字和按钮
允许修改是否允许push same vc

## Author

wangkq, 908891024@qq.com

## License

PoporPopNC is available under the MIT license. See the LICENSE file for more info.
