Pod::Spec.new do |s|
  s.name             = 'MLYSDK'
  s.version          = '0.1.39'
  s.summary          = 'MLYSDK'
  s.description      = 'MLYSDK 是一個 iOS 平台的流媒體開發工具包，提供豐富的功能和易於使用的 API。'
  s.homepage         = 'https://github.com/IvanAtMlytics/mly-stream-sdk-ios-test'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'mlytics' => 'rd@mlytics.com' }
  s.source           = { :git => 'https://github.com/IvanAtMlytics/mly-stream-sdk-ios-test.git', :tag => s.version.to_s }
  s.readme           = "https://github.com/IvanAtMlytics/mly-stream-sdk-ios-test"
  s.swift_version    = '5.0'
  s.ios.deployment_target = '14.0'
  s.ios.vendored_frameworks = 'Archives/MLYSDK.xcframework'
  
  s.dependency 'Mux-Stats-AVPlayer', '3.1.0'
  s.dependency 'GCDWebServer', '3.5.4'
  s.dependency 'Sentry', '7.31.3'
  s.dependency 'WebRTC-SDK', '=104.5112.16' 
  s.dependency 'SwiftCentrifuge', '0.5.5'
  s.dependency 'SwiftProtobuf', '1.21.0'
end
