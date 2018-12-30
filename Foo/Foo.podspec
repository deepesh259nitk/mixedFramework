Pod::Spec.new do |s|

  s.name         = "Foo"
  s.version      = "1.0.3"
  s.summary      = "This is a iOS framework containing both objective c and swift code"
  s.description  = "This is a iOS framework containing both objective c and swift code and shows how modules with with POD"
  s.homepage     = "https://github.com/deepesh259nitk/mixedFramework"
  s.license      = "MIT"
  s.author             = { "Deepesh" => "deepesh259nitk@gmail.com" }
  s.platform     = :ios, "11.0"
  s.source       = { :git => "https://github.com/deepesh259nitk/mixedFramework.git", :tag => "1.0.3" }
  #s.source_files  = "Foo/**/*.{h,m,swift}"
  #s.source_files  = "Foo/**/*.{modulemap}"
  #s.source_files  = "Foo/**/*.private.modulemap"
  # s.exclude_files = "Classes/Exclude"
  # s.public_header_files = "Foo/*.h"
  s.vendored_frameworks = 'Foo/universal-framework/Foo.framework'

end
