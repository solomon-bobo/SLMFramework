#
#  Be sure to run `pod spec lint SLMFramework.podspec' to ensure this is a
#  valid spec and to remove all comments including this before submitting the spec.
#
#  To learn more about Podspec attributes see http://docs.cocoapods.org/specification.html
#  To see working Podspecs in the CocoaPods repo see https://github.com/CocoaPods/Specs/
#

Pod::Spec.new do |s|

  # ―――  Spec Metadata  ――――――――――――――――――――――
  #
  #  These will help people to find your library, and whilst it
  #  can feel like a chore to fill in it's definitely to your advantage. The
  #  summary should be tweet-length, and the description more in depth.
  #

  s.name         = "SLMFramework"
  s.version      = "0.0.1"
  s.summary      = "A short description of SLMFramework."
  s.description  = <<-DESC
                   A longer description of SLMFramework in Markdown format.

                   * Think: Why did you write this? What is the focus? What does it do?
                   * CocoaPods will be using this to generate tags, and improve search results.
                   * Try to keep it short, snappy and to the point.
                   * Finally, don't worry about the indent, CocoaPods strips it!
                   DESC

  s.homepage     = "https://github.com/solomon-bobo/SLMFramework"
  s.license      = "MIT"
  s.authors      = { "solomon" => "solomon.bobo.su@gmail.com" }

  s.source       = { :git => "https://github.com/solomon-bobo/SLMFramework.git", :tag => "0.0.1" }

  s.source_files  = "SLMFramwork.{h,m}"
  s.frameworks   = "CommonCrypto", "CoreGraphics"
end
