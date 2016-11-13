Pod::Spec.new do |s|
s.name             = "ZCSudokuView"
s.version          = "1.0.0"
s.summary          = "a sudoku view used on iOS."
s.description      = <<-DESC
It is a sudoku view used on iOS, which implement by Objective-C.
DESC
s.homepage         = "https://github.com/ChenZhenChun/ZCSudokuView"
s.license          = 'MIT'
s.author           = { "ChenZhenChun" => "346891964@qq.com" }
s.source           = { :git => "https://github.com/ChenZhenChun/ZCSudokuView.git", :tag => s.version.to_s}
s.platform     = :ios, '7.0'
s.requires_arc = true

s.source_files  = 'ZCSudokuView/**/*'
#s.resources = 'Assets'

# s.ios.exclude_files = 'Classes/osx'
# s.osx.exclude_files = 'Classes/ios'
# s.public_header_files = 'Classes/**/*.h'
s.frameworks = 'Foundation', 'UIKit'
end
