# Uncomment the next line to define a global platform for your project
# platform :ios, '9.0'
platform :osx,'10.11'

workspace 'Messages.xcworkspace'
project 'MessagesLauncher/MessagesLauncher.xcworkspace'
project 'MessageLinks/MessageLinks.xcodeproj'

target 'MessagesLauncher' do
  project 'MessagesLauncher/MessagesLauncher.xcworkspace'
  pod 'Masonry'
end

target 'MessageLinks' do
    project 'MessageLinks/MessageLinks.xcodeproj'
    pod 'HTMLKit'
    pod 'Masonry'
    pod 'FMDB'
end
