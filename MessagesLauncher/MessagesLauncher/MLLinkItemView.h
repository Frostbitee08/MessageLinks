//
//  MLLinkItemView.h
//  MessagesLauncher
//
//  Created by Rocco Del Priore on 5/5/19.
//  Copyright © 2019 Rocco Del Priore. All rights reserved.
//

#import <Cocoa/Cocoa.h>

NS_ASSUME_NONNULL_BEGIN

@interface MLLinkItemView : NSView

+ (NSSize)intrinsicContentSize;

@property (nonatomic, readonly) NSImageView *linkImageView;

@property (nonatomic, readonly) NSTextField *dateTextField;

@property (nonatomic, readonly) NSTextField *titleTextField;

@property (nonatomic, readonly) NSTextField *subtitleTextField;

@end

NS_ASSUME_NONNULL_END
