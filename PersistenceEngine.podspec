#
# Be sure to run `pod lib lint PersistenceEngine.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see http://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = 'PersistenceEngine'
  s.version          = '0.2.5'
  s.summary          = 'Making life easier to manage and save Dictionaries & Structs into Core Data for persistence.'

# This description is used to generate tags and improve search results.
#   * Think: What does it do? Why did you write it? What is the focus?
#   * Try to keep it short, snappy and to the point.
#   * Write the description between the DESC delimiters below.
#   * Finally, don't worry about the indent, CocoaPods strips it!

  s.description      = <<-DESC
Dictionaries <> Core Data

Making life easier to manage and save Dictionaries & Structs into Core Data for persistence.

Written 100% purely in Swift 3.0

Easily store your dictionaries & structs in Core data using simple commands like:
`persistenceStore.insert(dictionary: myDict1, intoEntity: "TestEntity1")`

And read your dictionaries from Core Data using:
`let myNewDictArray = persistenceStore.dictionaryFrom(entity: "TestEntity1")`

Example code will show you how to save any struct into a dictionary automatically and recursively.
                       DESC

  s.homepage         = 'https://github.com/timothybowers/PersistenceEngine'
  # s.screenshots     = 'www.example.com/screenshots_1', 'www.example.com/screenshots_2'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'Timothy S Bowers' => 'timbigdev@gmail.com' }
  s.source           = { :git => 'https://github.com/timothybowers/PersistenceEngine.git', :tag => s.version.to_s }
  # s.social_media_url = 'https://twitter.com/<TWITTER_USERNAME>'

  s.ios.deployment_target = '10.0'

  s.source_files = 'PersistenceEngine/Classes/**/*'
  
  # s.resource_bundles = {
  #   'PersistenceEngine' => ['PersistenceEngine/Assets/*.png']
  # }

  # s.public_header_files = 'Pod/Classes/**/*.h'
  # s.frameworks = 'UIKit', 'MapKit'
  # s.dependency 'AFNetworking', '~> 2.3'
end
