Pod::Spec.new do |s|
  s.name             = 'CoreCollections'
  s.version          = '1.0.0'
  s.summary          = 'Library adapter for Collections (UITableView) UIKit'
  s.description      = 'Usefull fraemwork collections'

  s.homepage         = 'https://github.com/skibinalexander/CoreCollections.git'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'Skibin Alexander' => 'skibinalexander@gmail.com' }
  s.source           = { :git => 'https://github.com/skibinalexander/CoreCollections.git', :tag => s.version.to_s }

  s.ios.deployment_target = '12.0'
  s.swift_version = "5.5"
  s.source_files = 'Sources/CoreCollections/**/*'
end
