#
# Be sure to run `pod lib lint PoporPopNC.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see https://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
    s.name             = 'PoporPopNC'
    s.version          = '0.0.1'
    s.summary          = 'hook UINavigationController pop action'
    
    # This description is used to generate tags and improve search results.
    #   * Think: What does it do? Why did you write it? What is the focus?
    #   * Try to keep it short, snappy and to the point.
    #   * Write the description between the DESC delimiters below.
    #   * Finally, don't worry about the indent, CocoaPods strips it!
    
    s.description      = '在UINavigationController点击返回或者侧滑手势的时候,拦截系统函数,方法在PoporPopCheckDelegate中.本来是使用QMUI_iOS的,但是QMUI_iOS的触发机制有问题,方法名称是模仿的QMUI.\
    \n允许修改允许修改返回按钮文字.\
    \n允许修改是否允许push same vc.'
    
    s.homepage         = 'https://github.com/popor/PoporPopNC'
    s.license          = { :type => 'MIT', :file => 'LICENSE' }
    s.author           = { 'popor' => '908891024@qq.com' }
    s.source           = { :git => 'https://github.com/popor/PoporPopNC.git', :tag => s.version.to_s }
    
    s.ios.deployment_target = '8.0'
    
    s.source_files = 'PoporPopNC/Classes/*.{h,m}'
    s.dependency 'PoporFoundation/NSObject'
    
    
end
