//
//  MLPreferencesWindowContentViewController.m
//  MessagesLauncher
//
//  Created by Rocco Del Priore on 5/4/19.
//  Copyright © 2019 Rocco Del Priore. All rights reserved.
//

#import <Masonry/Masonry.h>

#import "MLPreferencesWindowContentViewController.h"
#import "MLPreferencesManager.h"

@interface MLPreferencesWindowContentViewController ()
@end

@implementation MLPreferencesWindowContentViewController

- (instancetype)init {
    self = [super init];
    if (self) {
        //Instantiate Local Variables
        NSView *leftView = [[NSView alloc] init];
        NSView *rightView = [[NSView alloc] init];
        NSStackView *stackView = [[NSStackView alloc] init];
        NSButton *startAtLogin = [[NSButton alloc] init];
        NSButton *includeMenuLinks = [[NSButton alloc] init];
        
        //Instantiate Member Variables
        self.view = [[NSView alloc] initWithFrame:NSMakeRect(0, 0, 600, 300)];
        self.title = @"Preferences";
        
        //Set Variables
        [stackView setAlignment:NSLayoutAttributeLeft];
        [stackView setOrientation:NSUserInterfaceLayoutOrientationVertical];
        [startAtLogin setButtonType:NSButtonTypeSwitch];
        [startAtLogin setTitle:@"Start at Login"];
        [startAtLogin setTarget:self];
        [startAtLogin setAction:@selector(startAtLoginAction:)];
        [startAtLogin setState:[[MLPreferencesManager sharedInstance] startsAtLaunch] ? NSControlStateValueOn : NSControlStateValueOff];
        [includeMenuLinks setButtonType:NSButtonTypeSwitch];
        [includeMenuLinks setTitle:@"Include Links in Menu Bar"];
        [includeMenuLinks setTarget:self];
        [includeMenuLinks setAction:@selector(includeLinksAction:)];
        [includeMenuLinks setState:[[MLPreferencesManager sharedInstance] includeLinksInMenu] ? NSControlStateValueOn : NSControlStateValueOff];
        
        //Add Subviews
        [stackView addArrangedSubview:startAtLogin];
        [stackView addArrangedSubview:includeMenuLinks];
        [self.view addSubview:leftView];
        [self.view addSubview:rightView];
        [rightView addSubview:stackView];
        [self.view mas_makeConstraints:^(MASConstraintMaker *make) {
            make.height.greaterThanOrEqualTo(@(300));
            make.width.greaterThanOrEqualTo(@(600));
        }];
        [leftView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(rightView.mas_left).offset(-20);
            make.left.equalTo(self.view).offset(20);
            make.top.bottom.equalTo(rightView);
        }];
        [rightView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.bottom.equalTo(self.view).offset(-20);
            make.top.equalTo(self.view).offset(20);
            make.width.equalTo(@(200));
        }];
        [stackView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.top.equalTo(rightView).offset(10);
            make.bottom.right.equalTo(rightView).offset(-10);
        }];
    }
    return self;
}

#pragma mark - Helpers

- (LSSharedFileListItemRef)itemRefInLoginItems {
    LSSharedFileListItemRef itemRef = nil;
    NSURL *itemUrl = nil;
    
    // Get the app's URL.
    NSURL *appUrl = [NSURL fileURLWithPath:[[NSBundle mainBundle] bundlePath]];
    // Get the LoginItems list.
    LSSharedFileListRef loginItemsRef = LSSharedFileListCreate(NULL, kLSSharedFileListSessionLoginItems, NULL);
    if (loginItemsRef == nil) return nil;
    // Iterate over the LoginItems.
    NSArray *loginItems = (__bridge NSArray *)LSSharedFileListCopySnapshot(loginItemsRef, nil);
    for (int currentIndex = 0; currentIndex < [loginItems count]; currentIndex++) {
        // Get the current LoginItem and resolve its URL.
        LSSharedFileListItemRef currentItemRef = (__bridge LSSharedFileListItemRef)[loginItems objectAtIndex:currentIndex];
        if (LSSharedFileListItemResolve(currentItemRef, 0, (__bridge CFURLRef) itemUrl, NULL) == noErr) {
            // Compare the URLs for the current LoginItem and the app.
            if ([itemUrl isEqual:appUrl]) {
                // Save the LoginItem reference.
                itemRef = currentItemRef;
            }
        }
    }
    // Retain the LoginItem reference.
    if (itemRef != nil) CFRetain(itemRef);
    CFRelease(loginItemsRef);
    
    return itemRef;
}

#pragma mark - Actions

- (void)startAtLoginAction:(NSButton *)button {
    //Get launchAtLogin
    BOOL launchAtLogin = button.state == NSOnState;
    
    // Get the LoginItems list.
    LSSharedFileListRef loginItemsRef = LSSharedFileListCreate(NULL, kLSSharedFileListSessionLoginItems, NULL);
    if (loginItemsRef == nil) return;
    if (launchAtLogin) {
        // Add the app to the LoginItems list.
        CFURLRef appUrl = (__bridge CFURLRef)[NSURL fileURLWithPath:[[NSBundle mainBundle] bundlePath]];
        LSSharedFileListItemRef itemRef = LSSharedFileListInsertItemURL(loginItemsRef, kLSSharedFileListItemLast, NULL, NULL, appUrl, NULL, NULL);
        if (itemRef) CFRelease(itemRef);
    }
    else {
        // Remove the app from the LoginItems list.
        LSSharedFileListItemRef itemRef = [self itemRefInLoginItems];
        LSSharedFileListItemRemove(loginItemsRef,itemRef);
        if (itemRef != nil) CFRelease(itemRef);
    }
    CFRelease(loginItemsRef);
    
    [[MLPreferencesManager sharedInstance] setStartsAtLaunch:launchAtLogin];
}

- (void)includeLinksAction:(NSButton *)button {
    //Get launchAtLogin
    BOOL includeLinks = button.state == NSOnState;
    
    //Set Preferences
    [[MLPreferencesManager sharedInstance] setInlcudeLinksInMenu:includeLinks];
}

@end
