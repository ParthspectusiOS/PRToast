
Pod::Spec.new do |s|
  s.name             = 'PRToast'
  s.version          = '0.0.1'
  s.summary          = 'use for custom toast message'
 
  s.description      = <<-DESC
Use for Custom toast with open top or bottom!
                       DESC
 
  s.homepage         = 'https://github.com/ParthspectusiOS/PRToast'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { '<Parth>' => '<parth.radadiya@spectusinfotech.com' }
  s.source           = { :git => 'https://github.com/ParthspectusiOS/PRToast.git', :tag => s.version.to_s }
  s.pod_target_xcconfig = { 'EXCLUDED_ARCHS[sdk=iphonesimulator*]' => 'arm64' }
  s.user_target_xcconfig = { 'EXCLUDED_ARCHS[sdk=iphonesimulator*]' => 'arm64' }
 
  s.ios.deployment_target = '13.0'
  s.source_files = 'PRToastView/*.{swift}'
 
end