Pod::Spec.new do |s|
  s.name             = 'CoreCollections'
  s.version          = '0.9.1'
  s.summary          = 'Library adapter for Collections (UITableView) UIKit'
  s.description      = <<-DESC
TODO: Add long description of the pod here.
                       DESC

  s.homepage         = 'https://bitbucket.org/vtb-privacy/corecollections'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'Skibin Alexander' => 'skibinalexander@gmail.com' }
  s.source           = { :git => 'https://github.com/skibinalexander/CoreCollections.git', :tag => s.version.to_s }

  s.ios.deployment_target = '11.0'
  s.swift_version = "5.0"
  s.source_files = 'CoreCollections/Classes/**/*'
end
