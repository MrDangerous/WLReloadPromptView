#WLReloadPromptView.podspec
Pod::Spec.new do |s|
  s.name         = "WLReloadPromptView"
  s.version      = "0.0.1"
  s.license      = 'MIT'
  s.summary      = "a reload prompt view for a bad network environment."
  s.homepage     = "https://github.com/zhwayne/WLReloadPromptView"
  s.author       = { "Wayne" => "mrzhwayne@163.com" }
  s.platform     = :ios, "7.0"
  s.ios.deployment_target = "7.0"
  s.source       = { :git => "https://github.com/zhwayne/WLReloadPromptView.git", :tag => s.version.to_s }
  s.source_files = 'Classes/*.{h,m}'
  s.requires_arc = true
end
