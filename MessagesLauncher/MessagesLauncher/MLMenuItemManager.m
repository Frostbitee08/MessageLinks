//
//  MLMenuItemManager.m
//  MessagesLauncher
//
//  Created by Rocco Del Priore on 5/4/19.
//  Copyright © 2019 Rocco Del Priore. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import <MessagesDatabase/MessagesDatabase.h>

#import "MLLinkItem.h"
#import "MLMenuItemManager.h"
#import "MLPreferencesManager.h"
#import "MLPreferencesWindowContentViewController.h"

@interface MLMenuItemManager () <NSMenuDelegate>
@property (nonatomic, retain) MLPreferencesWindowContentViewController *contentViewController;
@property (nonatomic, retain) NSStatusItem *statusItem;
@property (nonatomic, retain) NSWindow *window;
@property (nonatomic, retain) NSMenu *menu;
@end

@implementation MLMenuItemManager

- (instancetype)init {
    self = [super init];
    if (self) {
        //Instantiate Member Variables
        self.statusItem = [[NSStatusBar systemStatusBar] statusItemWithLength:NSVariableStatusItemLength];
        self.menu = [[NSMenu alloc] initWithTitle:@"menu"];
        
        //Set Peroperties
        //[self.menu setDelegate:self];
        [self.statusItem setMenu:self.menu];
        [self.statusItem setTitle:@"ML"];
        [self.statusItem setEnabled:YES];
        [self.statusItem setHighlightMode:YES];
        
        [self menuWillOpen:self.menu];
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

- (void)clickLink:(MLLinkItem *)item {
    [[NSWorkspace sharedWorkspace] openURL:item.link.url];
}

#pragma mark - NSMenuDelegate

- (void)menuWillOpen:(NSMenu *)menu {
    //Remove Previous Items
    [self.menu removeAllItems];
    
    //Instantiate Local Varibales
    NSMenuItem *preferencesItem = [[NSMenuItem alloc] initWithTitle:@"Preferences" action:@selector(showPreferences) keyEquivalent:@""];
    NSMenuItem *quitItem = [[NSMenuItem alloc] initWithTitle:@"Quit MessageLinks" action:@selector(quitApplication) keyEquivalent:@""];
    NSError *error = nil;
    
    //Set Properties
    [preferencesItem setTarget:self];
    [quitItem setTarget:self];
    
    //Fetch Links
    if ([[MLPreferencesManager sharedInstance] includeLinksInMenu] || true) {
        for (MLLink *link in [[MLChatDatabaseManager sharedInstance] recentLinks:5 error:&error]) {
            MLLinkItem *item = [[MLLinkItem alloc] initWithLink:link
                                                         target:self
                                                         action:@selector(clickLink:)
                                                  keyEquivalent:@""];
            [self.menu addItem:item];
        }
    }
    
    //Add Items
    [self.menu addItem:[NSMenuItem separatorItem]];
    [self.menu addItem:preferencesItem];
    [self.menu addItem:quitItem];
}

@end
