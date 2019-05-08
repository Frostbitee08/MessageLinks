platform :osx,'10.11'

workspace 'Messages.xcworkspace'
project 'MessageLinks/MessageLinks.xcodeproj'
project 'MessagesLauncher/MessagesLauncher.xcodeproj'

target 'MessageLinks' do
    project 'MessageLinks/MessageLinks.xcodeproj'
    pod 'Masonry'
    pod 'MessagesDatabase', :path => "MessagesDatabase/" 
end

target 'MessagesLauncher' do
    project 'MessagesLauncher/MessagesLauncher.xcodeproj'
    pod 'Masonry'
    pod 'MessagesDatabase', :path => "MessagesDatabase/" 
end
