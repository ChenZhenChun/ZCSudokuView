Pod::Spec.new do |s|
#name必须与文件名一致
s.name              = "ZCSudokuView"

#更新代码必须修改版本号
s.version           = "1.0.5"
s.summary           = "a sudoku view used on iOS."
s.description       = <<-DESC
It is a sudoku view used on iOS, which implement by Objective-C.
DESC
s.homepage          = "https://github.com/ChenZhenChun/ZCSudokuView"
s.license           = 'MIT'
s.author            = { "ChenZhenChun" => "346891964@qq.com" }

#submodules 是否支持子模块
s.source            = { :git => "https://github.com/ChenZhenChun/ZCSudokuView.git", :tag => s.version, :submodules => true}
s.platform          = :ios, '7.0'
s.requires_arc = true

#source_files路径是相对podspec文件的路径
s.default_subspecs    = 'ZCSudokuView'

#核心模块
s.subspec 'ZCSudokuView' do |ss|
ss.source_files = 'ZCSudokuView/*.{h,m}'
ss.public_header_files = 'ZCSudokuView/*.h'
end

#子模块IJShareView（分享视图控件）
s.subspec 'IJShareView' do |ss|
ss.source_files = 'ZCSudokuView/IJShareView/*.{h,m}'
ss.public_header_files = 'ZCSudokuView/IJShareView/*.h'
ss.dependency 'ZCSudokuView/ZCSudokuView'
end

#子模块XJSearchBar（搜索框控件）
s.subspec 'XJSearchBar' do |ss|
ss.source_files = 'ZCSudokuView/XJSearchBar/*.{h,m}'
ss.public_header_files = 'ZCSudokuView/XJSearchBar/*.h'
ss.dependency 'ZCSudokuView/ZCSudokuView'
end

#子模块image(存放图片)
#s.subspec 'image' do |ss|
#ss.resources = 'ZCSudokuView/image/*.png'
#end

s.frameworks = 'Foundation', 'UIKit'

# s.ios.exclude_files = 'Classes/osx'
# s.osx.exclude_files = 'Classes/ios'
# s.public_header_files = 'Classes/**/*.h'

end
