platform :osx,'10.11'

workspace 'Messages.xcworkspace'
project 'MessageLinks/MessageLinks.xcodeproj'
project 'MessagesLauncher/MessagesLauncher.xcodeproj'
project 'MessagesDatabase/MessagesDatabase.xcodeproj'

target 'MessageLinks' do
    project 'MessageLinks/MessageLinks.xcodeproj'
    pod 'HTMLKit'
    pod 'Masonry'
    pod 'FMDB'
end

target 'MessagesLauncher' do
    project 'MessagesLauncher/MessagesLauncher.xcodeproj'
    pod 'Masonry'
end

target 'MessagesDatabase' do
    project 'MessagesDatabase/MessagesDatabase.xcodeproj'
    pod 'HTMLKit'
    pod 'FMDB'
end
