#
# Be sure to run `pod lib lint FWFaceAuth.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see https://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = 'FWFaceAuth'
  s.version          = '2.1.17'
  s.summary          = 'Librería para autenticación facial basada en FacePhi'
  s.static_framework = true

# This description is used to generate tags and improve search results.
#   * Think: What does it do? Why did you write it? What is the focus?
#   * Try to keep it short, snappy and to the point.
#   * Write the description between the DESC delimiters below.
#   * Finally, don't worry about the indent, CocoaPods strips it!

  s.description      = <<-DESC
  Librería que integra SelphID y Selphi para autenticación facial con identificación.
                       DESC

  s.homepage         = 'https://github.com/grupo-profuturo/'
  s.license          = { :type => 'MIT'}
  s.author           = { 'Grupo Profuturo' => 'ulises.perez@profuturo.com.mx' }
    s.source           = { :git => 'https://github.com/grupo-profuturo/ios-clientes-pod-spec.git', :tag => s.version.to_s }
  #s.source           = { :path => '.'}

  s.ios.deployment_target = '13.0'
  s.swift_version = '4.2'
  s.source_files = 'FWFaceAuth/Classes/**/*.swift'
  s.vendored_frameworks =  'FWFaceAuth/Frameworks/FPBExtractoriOS.framework', 'FWFaceAuth/Frameworks/FPhiWidgetCore.framework', 'FWFaceAuth/Frameworks/FPhiWidgetSelphi.framework'
  s.resource_bundles = {
     'FWFaceAuth' => "FWFaceAuth/**/*.{xib,strings,xcassets,zip,json,ttf}"
  }
  s.exclude_files = "FWFaceAuth/**/*.plist"
  s.dependency 'NVActivityIndicatorView', '~> 4.4.0'
  #s.dependency 'Firebase'
  s.dependency "Firebase/Analytics", '~> 6.24.0'
  s.dependency "Firebase/MLVision"
  s.dependency "Firebase/MLVisionTextModel"
  s.dependency "Microblink"
  s.dependency "FPhiSelphIDWidgetiOS"
  s.dependency "ZipZap"
  #s.dependency 'FPhiSelphIDWidgetiOS', '1.2.0'
  #s.public_header_files = 'Pod/Classes/**/*.h'
  # s.frameworks = 'UIKit', 'MapKit'


end
