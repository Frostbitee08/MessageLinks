//
//  MLLinkItem.h
//  MessagesLauncher
//
//  Created by Rocco Del Priore on 5/5/19.
//  Copyright © 2019 Rocco Del Priore. All rights reserved.
//

#import <MessagesDatabase/MessagesDatabase.h>
#import <Cocoa/Cocoa.h>

NS_ASSUME_NONNULL_BEGIN

@interface MLLinkItem : NSMenuItem

- (instancetype)initWithLink:(MLLink *)link target:(nullable id)target action:(nullable SEL)selector keyEquivalent:(NSString *)charCode;

@property (nonatomic, readonly) MLLink *link;

@end

NS_ASSUME_NONNULL_END
