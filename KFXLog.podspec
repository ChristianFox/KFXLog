#
# Be sure to run `pod lib lint KFXLog.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see http://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = 'KFXLog'
  s.version          = '1.0.0.5'
  s.summary          = 'KFXLog is a customisable logging library written in Objective-C.'

# This description is used to generate tags and improve search results.
#   * Think: What does it do? Why did you write it? What is the focus?
#   * Try to keep it short, snappy and to the point.
#   * Write the description between the DESC delimiters below.
#   * Finally, don't worry about the indent, CocoaPods strips it!

  s.description      = <<-DESC
A customisable logging library that will help you format and standardise your log messages. Because really, is there anything sexier than standardised log messages?
Logs to four different mediums: Console, Text Files, Alerts, as well as to a web service through use of a protocol.
Configure different logging rules and formatting for each medium.
Set which mediums to log to for different build configurations. Eg. Console for debug, Console & File for AdHoc and File & Service for Release.
Log messages are very customisable at a global level: show date or not, show sender as class, description, debugDescription or never, set bullet point for each log message and much more.
Log messages are prefixed to make it easy to filter out the noise and focus on the messages you want.
                       DESC

  s.homepage         = 'https://github.com/ChristianFox/KFXLog'
  # s.screenshots     = 'www.example.com/screenshots_1', 'www.example.com/screenshots_2'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'Christian Fox' => 'christianfox890@icloud.com' }
s.source           = { :git => "https://github.com/ChristianFox/KFXLog.git", :tag => s.version.to_s }
  # s.social_media_url = 'https://twitter.com/<TWITTER_USERNAME>'

  s.ios.deployment_target = '8.0'

  s.source_files = 'KFXLog/Classes/**/*'
  
  # s.resource_bundles = {
  #   'KFXLog' => ['KFXLog/Assets/*.png']
  # }

  # s.public_header_files = 'Pod/Classes/**/*.h'
  # s.frameworks = 'UIKit', 'MapKit'
  # s.dependency 'AFNetworking', '~> 2.3'
end
