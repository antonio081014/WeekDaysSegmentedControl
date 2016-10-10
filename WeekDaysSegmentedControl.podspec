Pod::Spec.new do |s|
  s.name             = 'WeekDaysSegmentedControl'
  s.version          = '0.1.1'
  s.summary          = 'A Weekday SegmentedControl'

  s.homepage         = 'https://github.com/antonio081014/WeekDaysSegmentedControl'
  s.screenshots      = 'https://github.com/antonio081014/WeekDaysSegmentedControl/blob/master/Screenshots/Screenshot1.png', 'https://github.com/antonio081014/WeekDaysSegmentedControl/blob/master/Screenshots/Screenshot2.png'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'Antonio081014' => 'antonio081014@antonio081014.com' }
  s.source           = { :git => 'https://github.com/antonio081014/WeekDaysSegmentedControl.git', :tag => s.version.to_s }
  s.social_media_url = 'https://twitter.com/antonio081014'

  s.ios.deployment_target = '8.0'

  s.source_files = 'Source/*.swift'
  
  s.frameworks = 'UIKit'
  # s.dependency 'AFNetworking', '~> 2.3'
end
