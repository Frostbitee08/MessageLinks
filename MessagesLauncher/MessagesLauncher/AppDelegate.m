//
//  AppDelegate.m
//  MessagesLauncher
//
//  Created by Rocco Del Priore on 5/1/19.
//  Copyright © 2019 Rocco Del Priore. All rights reserved.
//

#import "AppDelegate.h"

@interface AppDelegate ()

@property (weak) IBOutlet NSWindow *window;
@end

@implementation AppDelegate

- (void)applicationDidFinishLaunching:(NSNotification *)aNotification {
    NSString *messagesPath = @"/Applications/Messages.app/Contents/MacOS/Messages";
    if ([[NSFileManager defaultManager] fileExistsAtPath:messagesPath]) {
        [self launchApplicationWithPath:messagesPath andBundleIdentifier:@"com.apple.messages"];
    }
}

-(void)launchApplicationWithPath:(NSString*)inPath andBundleIdentifier:(NSString*)inBundleIdentifier {
    if (inPath != nil) {
        // Run Messages.app and inject our dynamic library
        NSString *dyldLibrary = [[NSBundle bundleForClass:[self class]] pathForResource:@"MessageLinks" ofType:@"dylib"];
        NSString *launcherString = [NSString stringWithFormat:@"DYLD_INSERT_LIBRARIES=\"%@\" \"%@\" &", dyldLibrary, inPath];
        system([launcherString UTF8String]);
        
        // Bring it to front after a delay
        [self performSelector:@selector(bringToFrontApplicationWithBundleIdentifier:) withObject:inBundleIdentifier afterDelay:1.0];
    }
}

-(void)bringToFrontApplicationWithBundleIdentifier:(NSString*)inBundleIdentifier {
    // Try to bring the application to front
    NSArray* appsArray = [NSRunningApplication runningApplicationsWithBundleIdentifier:inBundleIdentifier];
    if ([appsArray count] > 0) {
        [[appsArray objectAtIndex:0] activateWithOptions:NSApplicationActivateIgnoringOtherApps];
    }
    
    // Quit ourself
    [[NSApplication sharedApplication] terminate:self];
}


@end
