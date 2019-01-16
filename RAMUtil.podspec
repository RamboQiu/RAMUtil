
Pod::Spec.new do |s|
  s.name             = 'RAMUtil'
  s.version          = '1.0.2'
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

  s.subspec 'RAMExport' do |es|
    es.source_files  = "RAMUtil/RAMExport/*.{h,m}"
    es.public_header_files = "RAMUtil/RAMExport/*.h"
  end

  s.subspec 'RAMLog' do |ls|
    ls.source_files = "RAMUtil/RAMLog/*.{h,m}"
    ls.public_header_files = "RAMUtil/RAMLog/*.h"
  end

  s.subspec 'RAMSafeCollection' do |ss|
    ss.source_files = "RAMUtil/RAMSafeCollection/*.{h,m}"
    ss.public_header_files = "RAMUtil/RAMSafeCollection/*.h"
  end

  s.subspec 'RAMMustOverrider' do |ms|
    ms.source_files = "RAMUtil/RAMMustOverrider/*.{h,m}"
    ms.public_header_files = "RAMUtil/RAMMustOverrider/*.h"
  end

  s.subspec 'RAMFrame' do |fs|
    fs.source_files = "RAMUtil/RAMFrame/*.{h,m}"
    fs.public_header_files = "RAMUtil/RAMFrame/*.h"
  end

  s.subspec 'RAMCellData' do |cs|
    cs.source_files = "RAMUtil/RAMCellData/*.{h,m}"
    cs.public_header_files = "RAMUtil/RAMCellData/*.h"
  end
  
  s.subspec 'RAMColor' do |cos|
      cos.source_files = "RAMUtil/RAMColor/*.{h,m}"
      cos.public_header_files = "RAMUtil/RAMColor/*.h"
  end
  
  s.subspec 'RAMImage' do |is|
      is.source_files = "RAMUtil/RAMImage/*.{h,m}"
      is.public_header_files = "RAMUtil/RAMImage/*.h"
  end
  
end

