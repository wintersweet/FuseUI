#
# Be sure to run `pod lib lint FuseUI.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see https://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = 'FuseUI'
  s.version          = '1.0.3'
  s.summary          = 'A short description of FuseUI.'

# This description is used to generate tags and improve search results.
#   * Think: What does it do? Why did you write it? What is the focus?
#   * Try to keep it short, snappy and to the point.
#   * Write the description between the DESC delimiters below.
#   * Finally, don't worry about the indent, CocoaPods strips it!

  s.description      = <<-DESC
TODO: Add long description of the pod here.
                       DESC

  s.homepage         = 'https://github.com/wintersweet/FuseUI'
  # s.screenshots     = 'www.example.com/screenshots_1', 'www.example.com/screenshots_2'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'wintersweet' => 'hudongdong@fuse.co.id' }
  s.source           = { :git => 'https://github.com/wintersweet/FuseUI.git', :tag => s.version.to_s }
  # s.social_media_url = 'https://twitter.com/<TWITTER_USERNAME>'

  s.ios.deployment_target = '9.0'
  
#  s.subspec 'Resource' do |b|
#      core_dir = "FuseUI/Classes/AlertContentView/"
#      b.source_files = core_dir + "/*.{h,m}"
#      b.ios.resource = 'FuseUI/Assets/*.xib'
#    end
  

#  s.source_files = 'FuseUI/Classes/**/*.{h,m}'
  s.subspec 'AlertContentView' do |t|
      t.source_files = 'FuseUI/Classes/AlertContentView/*'
     end
  s.subspec 'FUDatePicker' do |t|
      t.source_files = 'FuseUI/Classes/FUDatePicker/*.{h,m}'
     end
  s.subspec 'FUHotspotButton' do |t|
      t.source_files = 'FuseUI/Classes/FUHotspotButton/*.{h,m}'
     end
  s.subspec 'FUWebController' do |t|
      t.source_files = 'FuseUI/Classes/FUWebController/*.{h,m}'
     end
  
  s.resource_bundles = {
    'FuseUI' => ['FuseUI/Assets/*.xib']
  }

  # s.public_header_files = 'Pod/Classes/**/*.h'
  # s.frameworks = 'UIKit', 'MapKit'
  # s.dependency 'AFNetworking', '~> 2.3'
  # s.dependency 'FuseGroupsKits' ,'1.0.5'
end
