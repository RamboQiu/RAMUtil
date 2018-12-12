
Pod::Spec.new do |s|
  s.name             = 'RAMUtil'
  s.version          = '1.0.0'
  s.summary          = 'This is a util'
  s.description      = <<-DESC
TODO: Add long description of the pod here.
                       DESC

  s.homepage         = 'https://github.com/RamboQiu/RAMUtil.git'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'RamboQiu' => '625217640@qq.com' }
  s.source           = { :git => 'https://github.com/RamboQiu/RAMUtil.git', :tag => s.version.to_s }
  s.ios.deployment_target = '8.0'
  s.source_files = 'RAMUtil/**/*'
end

