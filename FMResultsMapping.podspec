Pod::Spec.new do |s|
  s.name             = "FMResultsMapping"
  s.version          = "0.0.1"
  s.summary          = "FMResultSet extension which helps to obtain mapped results from SQLite."
  s.description      = <<-DESC
  Small, but usefull FMResultSet extenstion which helps to obtain the results from SQLite. Inspired by (boy, almost stolen from) EasyMapping.
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
  s.public_header_files = 'Pod/Classes/**/*.h'
  
  s.dependency 'FMDB'
end
