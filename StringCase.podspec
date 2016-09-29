#
# Be sure to run `pod lib lint StringCase.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see http://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = 'StringCase'
  s.version          = '0.1.0'
  s.summary          = 'String extension that allows you to easily switch between casings.'

  s.description      = <<-DESC
                       DESC

  s.homepage         = 'https://github.com/Rabursky/StringCase'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'Marcin Raburski' => 'rabursky@gmail.com' }
  s.source           = { :git => 'https://github.com/Rabursky/StringCase.git', :tag => s.version.to_s }

  s.ios.deployment_target = '8.0'

  s.source_files = 'StringCase/Classes/**/*'

  # s.public_header_files = 'Pod/Classes/**/*.h'
end
