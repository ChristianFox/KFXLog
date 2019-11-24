
Pod::Spec.new do |s|
  s.name             = 'KFXLog'
  s.version          = '2.0.1'
  s.summary          = 'KFXLog is a customisable logging library written in Objective-C.'

  s.description      = <<-DESC
A customisable logging library that will help you format and standardise your log messages. Because really, is there anything sexier than standardised log messages?
Logs to four different mediums: Console, Text Files, Alerts, as well as to a web service through use of a protocol.
Configure different logging rules and formatting for each medium.
Set which mediums to log to for different build configurations. Eg. Console for debug, Console & File for AdHoc and File & Service for Release.
Log messages are very customisable at a global level: show date or not, show sender as class, description, debugDescription or never, set bullet point for each log message and much more.
Log messages are prefixed to make it easy to filter out the noise and focus on the messages you want.
                       DESC

  s.homepage         = 'https://github.com/ChristianFox/KFXLog.git'
  s.source           = { :git => 'https://github.com/ChristianFox/KFXLog.git', :tag => s.version.to_s }


  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'Christian Fox' => 'christianfox@kfxtech.com' }

  s.ios.deployment_target = '8.2'
  s.watchos.deployment_target = '4.0'

  s.source_files = 'KFXLog/Classes/**/*'
  
end
