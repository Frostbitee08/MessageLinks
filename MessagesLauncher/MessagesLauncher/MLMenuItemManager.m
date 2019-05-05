//
//  MLMenuItemManager.m
//  MessagesLauncher
//
//  Created by Rocco Del Priore on 5/4/19.
//  Copyright © 2019 Rocco Del Priore. All rights reserved.
//

#import <Cocoa/Cocoa.h>

#import "MLMenuItemManager.h"
#import "MLPreferencesWindowContentViewController.h"

@interface MLMenuItemManager ()
@property (nonatomic, retain) MLPreferencesWindowContentViewController *contentViewController;
@property (nonatomic, retain) NSStatusItem *statusItem;
@property (nonatomic, retain) NSWindow *window;
@property (nonatomic, retain) NSMenu *menu;
@end

@implementation MLMenuItemManager

- (instancetype)init {
    self = [super init];
    if (self) {
        NSMenuItem *preferencesItem = [[NSMenuItem alloc] initWithTitle:@"Preferences" action:@selector(showPreferences) keyEquivalent:@""];
        NSMenuItem *quitItem = [[NSMenuItem alloc] initWithTitle:@"Quit MessageLinks" action:@selector(quitApplication) keyEquivalent:@""];
        
        self.statusItem = [[NSStatusBar systemStatusBar] statusItemWithLength:NSVariableStatusItemLength];
        
        [preferencesItem setTarget:self];
        [quitItem setTarget:self];
        [self.statusItem setMenu:[[NSMenu alloc] initWithTitle:@"menu"]];
        [self.statusItem setTitle:@"ML"];
        [self.statusItem setEnabled:YES];
        [self.statusItem setHighlightMode:YES];
        [self.statusItem.menu addItem:preferencesItem];
        [self.statusItem.menu addItem:quitItem];
    }
    return self;
}

#pragma mark - Actions

- (void)showPreferences {
    self.window = nil;
    self.contentViewController = [[MLPreferencesWindowContentViewController alloc] init];
    self.window  = [NSWindow windowWithContentViewController:self.contentViewController];
    [self.window setContentViewController:self.contentViewController];
    [self.window setMinSize:CGSizeMake(600, 300)];
    [self.window makeKeyAndOrderFront:[NSApplication sharedApplication].delegate];
    NSWindowController *controller = [[NSWindowController alloc] initWithWindow:self.window];
    [controller showWindow:[NSApplication sharedApplication].delegate];
}

- (void)quitApplication {
    [[NSApplication sharedApplication] terminate:self];
}

@end
