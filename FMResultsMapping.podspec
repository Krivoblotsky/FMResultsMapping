#
# Be sure to run `pod lib lint FMResultsMapping.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see http://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = "FMResultsMapping"
  s.version          = "0.0.1"
  s.summary          = "A short description of FMResultsMapping."

# This description is used to generate tags and improve search results.
#   * Think: What does it do? Why did you write it? What is the focus?
#   * Try to keep it short, snappy and to the point.
#   * Write the description between the DESC delimiters below.
#   * Finally, don't worry about the indent, CocoaPods strips it!  
  s.description      = <<-DESC
                       DESC

  s.homepage         = "https://github.com/Krivoblotsky/FMResultsMapping"
  s.license          = 'MIT'
  s.author           = { "Serg Krivoblotsky" => "krivoblotsky@me.com" }
  s.source           = { :git => "https://github.com/Krivoblotsky/FMResultsMapping.git", :tag => s.version.to_s }
  # s.social_media_url = 'https://twitter.com/Krivoblotsky'

  s.platforms = { :ios => '8.1', :osx => '10.8'}
  
  s.ios.deployment_target = "8.0"
  s.osx.deployment_target = "10.8"
  
  s.requires_arc = true

  s.source_files = 'Pod/Classes/**/*'
  s.resource_bundles = {
    'FMResultsMapping' => ['Pod/Assets/*.png']
  }

  s.public_header_files = 'Pod/Classes/**/*.h'
  s.dependency 'FMDB'
end
