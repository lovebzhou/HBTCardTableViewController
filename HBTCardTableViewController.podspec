#
# Be sure to run `pod lib lint HBTCardTableViewController.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see https://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = 'HBTCardTableViewController'
  s.version          = '0.1.4'
  s.summary          = 'A foldable card style UITableView for iOS, Objective-C'

# This description is used to generate tags and improve search results.
#   * Think: What does it do? Why did you write it? What is the focus?
#   * Try to keep it short, snappy and to the point.
#   * Write the description between the DESC delimiters below.
#   * Finally, don't worry about the indent, CocoaPods strips it!

  s.description      = <<-DESC
There are three main types of cell for the card UITableView:
- folder cell: as the root cell
- group cell: in foler or in group
- item cell: base class for custom

- container cell: subclass of item,
- grid: example for container cell, impl via UICollectionView
DESC

  s.homepage         = 'https://github.com/lovebzhou/HBTCardTableViewController'
  # s.screenshots     = 'www.example.com/screenshots_1', 'www.example.com/screenshots_2'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'lovebzhou' => 'lovebzhou@gmail.com' }
  s.source           = { :git => 'https://github.com/lovebzhou/HBTCardTableViewController.git', :tag => s.version.to_s }
  # s.social_media_url = 'https://twitter.com/<TWITTER_USERNAME>'

  s.ios.deployment_target = '8.0'

  s.source_files = 'HBTCardTableViewController/Classes/**/*'
  
  s.resource_bundles = {
    'HBTCardTableViewController' => ['HBTCardTableViewController/Assets/**/*.xcassets']
  }

  # s.public_header_files = 'Pod/Classes/**/*.h'
  # s.frameworks = 'UIKit', 'MapKit'
  # s.dependency 'AFNetworking', '~> 2.3'
end
