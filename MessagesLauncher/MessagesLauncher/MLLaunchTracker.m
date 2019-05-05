//
//  MLLaunchTracker.m
//  MessagesLauncher
//
//  Created by Rocco Del Priore on 5/4/19.
//  Copyright © 2019 Rocco Del Priore. All rights reserved.
//

#import "MLLaunchTracker.h"

@interface MLLaunchTracker ()
@property (nonatomic) NSTimer *timer;
@property (nonatomic) pid_t injectedProcess;
@property (nonatomic) BOOL isFirstScan;
@property (nonatomic) BOOL shouldCaptureProcessIdentifier;
@end

@implementation MLLaunchTracker

- (instancetype)init {
    self = [super init];
    if (self) {
        self.isFirstScan = true;
        self.injectedProcess = -1;
        self.shouldCaptureProcessIdentifier = false;
    }
    return self;
}

- (void)startTracking {
    self.timer = [NSTimer scheduledTimerWithTimeInterval:0.2
                                                  target:self
                                                selector:@selector(checkRunningApplications)
                                                userInfo:nil
                                                 repeats:YES];
}

- (void)stopTracking {
    [self.timer invalidate];
    self.timer = nil;
    self.isFirstScan = true;
    self.injectedProcess = -1;
    self.shouldCaptureProcessIdentifier = false;
}

- (void)checkRunningApplications {
    NSString *bundleId = @"com.apple.iChat";
    for (NSRunningApplication *application in [NSRunningApplication runningApplicationsWithBundleIdentifier:bundleId]) {
        if ([application.bundleIdentifier isEqualToString:bundleId]) {
            if (self.injectedProcess != application.processIdentifier && self.shouldCaptureProcessIdentifier) {
                self.injectedProcess = application.processIdentifier;
                self.shouldCaptureProcessIdentifier = false;
            }
            else if (self.injectedProcess != application.processIdentifier && !self.shouldCaptureProcessIdentifier) {
                //Initiate Variables
                NSString *messagesPath = @"/Applications/Messages.app/Contents/MacOS/Messages";
                NSString *dyldLibrary = [[NSBundle bundleForClass:[self class]] pathForResource:@"MessageLinks" ofType:@"dylib"];
                NSString *launcherString = [NSString stringWithFormat:@"DYLD_INSERT_LIBRARIES=\"%@\" \"%@\" &", dyldLibrary, messagesPath];
                
                //Kill Current App
                kill([application processIdentifier], SIGKILL);
                
                //Reset Should Capture Process Identifier
                self.shouldCaptureProcessIdentifier = true;
                
                //Launch New App
                system([launcherString UTF8String]);
                
                //Bring to forefront if it was already running
                if (!self.isFirstScan) {
                    [self performSelector:@selector(bringToFrontApplicationWithBundleIdentifier:) withObject:bundleId afterDelay:0.5];
                }
            }
            self.isFirstScan = false;
        }
    }
}

-(void)bringToFrontApplicationWithBundleIdentifier:(NSString*)inBundleIdentifier {
    // Try to bring the application to front
    NSArray* appsArray = [NSRunningApplication runningApplicationsWithBundleIdentifier:inBundleIdentifier];
    if ([appsArray count] > 0) {
        [[appsArray objectAtIndex:0] activateWithOptions:NSApplicationActivateIgnoringOtherApps];
    }
}


@end
