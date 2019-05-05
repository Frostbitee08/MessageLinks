//
//  MLPreferencesManager.h
//  MessagesLauncher
//
//  Created by Rocco Del Priore on 5/4/19.
//  Copyright © 2019 Rocco Del Priore. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface MLPreferencesManager : NSObject

+ (instancetype)sharedInstance;

- (BOOL)startsAtLaunch;

- (BOOL)includeLinksInMenu;

- (void)setStartsAtLaunch:(BOOL)startsAtLaunch;

- (void)setInlcudeLinksInMenu:(BOOL)includeLinks;

@end

NS_ASSUME_NONNULL_END
