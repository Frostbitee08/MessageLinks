//
//  MLLinksViewController.h
//  CalculatorOverrides
//
//  Created by Rocco Del Priore on 4/28/19.
//  Copyright © 2019 Alexandre Colucci. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import <MessagesDatabase/MessagesDatabase.h>

NS_ASSUME_NONNULL_BEGIN

@class IMChat;

@interface MLLinksViewController : NSViewController

@property (nonatomic, readonly) NSArray<MLLink *> *links;

- (instancetype)initWithChat:(IMChat *)chat;

- (void)setupWithChat:(IMChat *)chat;

@end

NS_ASSUME_NONNULL_END
