Pod::Spec.new do |s|

  s.name         = "SLMFramework"
  s.version      = "0.0.1"
  s.summary      = "My frequently used functions and methods."
  s.description  = "My frequently used functions and methods."
  s.homepage     = "https://github.com/solomon-bobo/SLMFramework"
  s.license      = "MIT"
  s.authors      = { "solomon" => "solomon.bobo.su@gmail.com" }
  s.source       = { :git => "https://github.com/solomon-bobo/SLMFramework.git", :tag => "0.0.1" }
  s.source_files = "SLMFramework.h, Foundation+SLMFramework/**/*.{h,m}, RequestAndResponse/**/*.{h,m}, FunctionsAndMethods/**/*.{h,m}, UIKit+SLMFramework/**/*.{h,m}"
  s.frameworks   = "CommonCrypto", "CoreGraphics"
end
