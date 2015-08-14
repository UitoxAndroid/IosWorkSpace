#source 'https://github.com/CocoaPods/Specs.git'
#platform :ios, '8.0'
#use_frameworks!

# 使用現有的 workspace(NZ.xcworkspace), 不要生成新的!
workspace 'UitoxShopProduct.xcworkspace'
# 配置默認 xcodeproj, 路徑是相對於 Podfile 的路徑. 這是必須的, 否則會報Syntax錯誤.
xcodeproj 'ASAP/ASAP.xcodeproj'

## 下面就是配置各個Target了! 也就是說, CocoaPods 面向的主配置對象是Target而不
## 是Project. 當然你得指定該Target屬於那個Project, 否則會使用前面配置默認的.


# 配置UitoxFramework(Target)
target :ASAP do
xcodeproj 'ASAP/ASAP.xcodeproj'
source 'https://github.com/CocoaPods/Specs.git'
platform :ios, "8.0"
use_frameworks!
pod 'Alamofire', '~> 1.3'
pod 'ObjectMapper', '~> 0.15'
pod 'AlamofireObjectMapper', '~> 0.7'
end