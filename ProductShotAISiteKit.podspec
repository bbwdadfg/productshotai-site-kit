Pod::Spec.new do |s|
  s.name         = 'ProductShotAISiteKit'
  s.version      = '0.1.0'
  s.summary      = 'URL helpers and metadata utilities for ProductShot AI.'
  s.description  = 'A tiny Swift helper for ProductShot AI canonical URLs and public page links.'
  s.homepage     = 'https://productshotai.app'
  s.license      = { :type => 'MIT', :file => 'LICENSE' }
  s.author       = { 'ProductShot AI' => 'support@productshotai.app' }
  s.source       = { :git => 'https://github.com/bbwdadfg/productshotai-site-kit.git', :tag => "cocoapods-v#{s.version}" }
  s.source_files = 'Sources/ProductShotAISiteKit/**/*.swift'
  s.swift_versions = ['5.9']
  s.ios.deployment_target = '13.0'
end
