//
//  AppDelegate.m
//  MessagesLauncher
//
//  Created by Rocco Del Priore on 5/1/19.
//  Copyright © 2019 Rocco Del Priore. All rights reserved.
//

#import "AppDelegate.h"

#import "MLLaunchTracker.h"
#import "MLMenuItemManager.h"

@interface AppDelegate ()
@property (nonatomic, retain) MLLaunchTracker *tracker;
@property (nonatomic, retain) MLMenuItemManager *manager;
@property (weak) IBOutlet NSWindow *window;
@end

@implementation AppDelegate

- (void)applicationDidFinishLaunching:(NSNotification *)aNotification {
    self.tracker = [[MLLaunchTracker alloc] init];
    self.manager = [[MLMenuItemManager alloc] init];
    
    [self.tracker startTracking];
}

@end
