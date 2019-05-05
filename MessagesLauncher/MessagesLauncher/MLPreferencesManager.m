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
        [self readPeferencesFromFile];
    }
    return self;
}

#pragma mark - Actions

//TODO: Refactor this
- (void)readPeferencesFromFile {
    self.preferences = [[NSMutableDictionary alloc] init];
    NSDictionary *tempDict = [[NSDictionary alloc] initWithContentsOfFile:self.preferencesPath];
    
    if ([[tempDict allKeys] count] > 0) {
        NSArray *keys = [tempDict allKeys];
        for (unsigned int g = 0; g<[keys count]; g++ ) {
            [self.preferences setObject:[tempDict objectForKey:[keys objectAtIndex:g]] forKey:[keys objectAtIndex:g]];
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
