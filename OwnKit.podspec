Pod::Spec.new do |spec|
  spec.name         = "OwnKit"
  spec.version      = "0.2.9"
  spec.author       = { "ra1028" => "r.fe51028.r@gmail.com" }
  spec.homepage     = "https://github.com/ra1028"
  spec.summary      = "My own utility toolkit for ios"
  spec.source       = { :git => "https://github.com/ra1028/OwnKit.git", :tag => spec.version }
  spec.license      = { :type => "MIT", :file => "LICENSE" }
  spec.platform = :ios, '8.0'
  spec.source_files = "OwnKit", "OwnKit/**/*.{swift}"
  spec.requires_arc = true
  spec.ios.deployment_target = '8.0'
  spec.ios.frameworks = ['UIKit', 'Foundation']
end
