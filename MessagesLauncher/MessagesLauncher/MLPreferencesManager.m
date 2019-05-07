//
//  MLPreferencesManager.m
//  MessagesLauncher
//
//  Created by Rocco Del Priore on 5/4/19.
//  Copyright © 2019 Rocco Del Priore. All rights reserved.
//


static NSString *kStartAtLaunch   = @"startAtLaunch";
static NSString *kShowLinksInMenu = @"showLinksInMenu";

#import "MLPreferencesManager.h"

@interface MLPreferencesManager ()
@property (nonatomic, retain) NSMutableDictionary *preferences;
@property (nonatomic, retain) NSString *preferencesPath;
@end

@implementation MLPreferencesManager

#pragma mark - Initializers

+ (instancetype)sharedInstance {
    static dispatch_once_t onceToken;
    static MLPreferencesManager *instance = nil;
    dispatch_once(&onceToken, ^{
        instance = [[self alloc] init];
    });
    return instance;
}

- (instancetype)init {
    if (self) {
        self.preferencesPath = [[NSHomeDirectory() stringByAppendingPathComponent:@"Library/Application Support/MessageLinks"] stringByAppendingString:@"/Settings.plist"];
        if ([[NSFileManager defaultManager] fileExistsAtPath:self.preferencesPath]) {
            [self readPeferencesFromFile];
        }
        else {
            [self createPreferencesFile];
        }
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


- (BOOL)isLaunchAtStartup {
    // See if the app is currently in LoginItems.
    LSSharedFileListItemRef itemRef = [self itemRefInLoginItems];
    // Store away that boolean.
    BOOL isInList = itemRef != nil;
    // Release the reference if it exists.
    if (itemRef != nil) CFRelease(itemRef);
    
    return isInList;
}

#pragma mark - Actions

- (void)createPreferencesFile {
    NSString *preferencesDirectoryPath = [self.preferencesPath stringByDeletingLastPathComponent];
    BOOL launchAtStartup = [self isLaunchAtStartup];
    BOOL includeLinks = TRUE;
    BOOL isDirectory;
    
    self.preferences = [@{kStartAtLaunch: @(launchAtStartup),
                        kShowLinksInMenu: @(includeLinks)} mutableCopy];
    
    if (![[NSFileManager defaultManager] fileExistsAtPath:preferencesDirectoryPath isDirectory:&isDirectory]) {
        [[NSFileManager defaultManager] createDirectoryAtPath:preferencesDirectoryPath withIntermediateDirectories:TRUE attributes:nil error:nil];
        [self writePreferencesToFile];
    }
}

- (void)readPeferencesFromFile {
    self.preferences = [[NSMutableDictionary alloc] init];
    NSDictionary *preferences = [[NSDictionary alloc] initWithContentsOfFile:self.preferencesPath];
    
    if ([[preferences allKeys] count] > 0) {
        NSArray *keys = [preferences allKeys];
        for (unsigned int index = 0; index<[keys count]; index++ ) {
            [self.preferences setObject:[preferences objectForKey:[keys objectAtIndex:index]] forKey:[keys objectAtIndex:index]];
        }
    }
}

- (void)writePreferencesToFile {
    [self.preferences writeToFile:self.preferencesPath atomically:YES];
}

#pragma mark - Accessors

- (BOOL)startsAtLaunch {
    if ([self.preferences.allKeys containsObject:kStartAtLaunch]) {
        return [[self.preferences objectForKey:kStartAtLaunch] boolValue];
    }
    return false;
}

- (BOOL)includeLinksInMenu {
    if ([self.preferences.allKeys containsObject:kShowLinksInMenu]) {
        return [[self.preferences objectForKey:kShowLinksInMenu] boolValue];
    }
    return false;
}

#pragma mark - Setters

- (void)setStartsAtLaunch:(BOOL)startsAtLaunch {
    [self.preferences setObject:@(startsAtLaunch) forKey:kStartAtLaunch];
    [self writePreferencesToFile];
}

- (void)setInlcudeLinksInMenu:(BOOL)includeLinks {
    [self.preferences setObject:@(includeLinks) forKey:kShowLinksInMenu];
    [self writePreferencesToFile];
}


@end
