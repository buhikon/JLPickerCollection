#
# Be sure to run `pod lib lint JLPickerCollection.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see http://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = 'JLPickerCollection'
  s.version          = '0.1.2'
  s.summary          = 'date picker and picker view with simple interface.'

# This description is used to generate tags and improve search results.
#   * Think: What does it do? Why did you write it? What is the focus?
#   * Try to keep it short, snappy and to the point.
#   * Write the description between the DESC delimiters below.
#   * Finally, don't worry about the indent, CocoaPods strips it!

  s.description      = "it's really easy to show date picker or picker view with simple interface based on block."

  s.homepage         = 'https://github.com/buhikon/JLPickerCollection'
  # s.screenshots     = 'www.example.com/screenshots_1', 'www.example.com/screenshots_2'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'Joey Lee' => 'slarinz@gmail.com' }
  s.source           = { :git => 'https://github.com/buhikon/JLPickerCollection.git', :tag => s.version.to_s }
  # s.social_media_url = 'https://twitter.com/<TWITTER_USERNAME>'

  s.ios.deployment_target = '8.0'

  s.source_files = 'JLPickerCollection/Classes/**/*'
  s.resource_bundles = {
    'JLPickerCollection' => ['JLPickerCollection/Classes/*.xib']
  }
  s.resources = ["classes/JLDatePickerView.xib","classes/JLTextPickerView.xib"]

  # s.public_header_files = 'Pod/Classes/**/*.h'
  # s.frameworks = 'UIKit', 'MapKit'
  # s.dependency 'AFNetworking', '~> 2.3'
end
