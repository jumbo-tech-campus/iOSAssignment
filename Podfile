source 'https://github.com/CocoaPods/Specs.git'

use_frameworks!
platform :ios, '13.0'

def openSource
  pod 'SwiftLint', '~>0.27.0', :inhibit_warnings => true
end

target 'iOSAssignment' do
  openSource

  target 'iOSAssignmentTests' do
    inherit! :search_paths
  end
end