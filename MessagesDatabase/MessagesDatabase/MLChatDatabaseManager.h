//
//  MLChatDatabaseManager.h
//  CalculatorOverrides
//
//  Created by Rocco Del Priore on 4/29/19.
//  Copyright © 2019 Alexandre Colucci. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "MLLink.h"

NS_ASSUME_NONNULL_BEGIN

@class IMChat;

@interface MLChatDatabaseManager : NSObject

+ (instancetype)sharedInstance;

- (NSArray<MLLink *> *)linksForChat:(IMChat *)chat error:(NSError **)error;

- (NSArray<MLLink *> *)recentLinks:(NSInteger)numberOfRecentLinks error:(NSError **)error;

@end

NS_ASSUME_NONNULL_END
