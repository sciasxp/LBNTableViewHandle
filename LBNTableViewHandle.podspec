#
# Be sure to run `pod lib lint LBNTableViewHandle.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see http://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = "LBNTableViewHandle"
  s.version          = "0.0.1"
  s.summary          = "A Small implementation for TableView dalegate and datasource that will handle most of the boiler plate code."

# This description is used to generate tags and improve search results.
#   * Think: What does it do? Why did you write it? What is the focus?
#   * Try to keep it short, snappy and to the point.
#   * Write the description between the DESC delimiters below.
#   * Finally, don't worry about the indent, CocoaPods strips it!  
  s.description      = <<-DESC
                        This pod encapsulate the methods of UITableViewDataSource and UITableViewDelegate, so you can concentrate on the logic instead of the boiler plate code.
                        The use of this pod make uses of blocks to make your code simpler and more readable.
                       DESC

  s.homepage         = "https://github.com/sciasxp/LBNTableViewHandle"
  # s.screenshots     = "www.example.com/screenshots_1", "www.example.com/screenshots_2"
  s.license          = 'MIT'
  s.author           = { "Luciano Bastos Nunes" => "sciasxp@gmail.com" }
  s.source           = { :git => "https://github.com/sciasxp/LBNTableViewHandle.git", :tag => s.version.to_s }
  s.social_media_url = 'br.linkedin.com/pub/luciano-bastos-nunes/16/712/695/'

  s.platform     = :ios, '7.1'
  s.requires_arc = true

  s.source_files = 'Pod/Classes/**/*'
  s.resource_bundles = {
    'LBNTableViewHandle' => ['Pod/Assets/*.png']
  }

  # s.public_header_files = 'Pod/Classes/**/*.h'
  # s.frameworks = 'UIKit', 'MapKit'
  # s.dependency 'AFNetworking', '~> 2.3'
end
