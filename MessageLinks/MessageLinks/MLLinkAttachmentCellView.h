//
//  MLLinkAttachmentCellView.h
//  CalculatorOverrides
//
//  Created by Rocco Del Priore on 4/28/19.
//  Copyright © 2019 Alexandre Colucci. All rights reserved.
//

#import <Cocoa/Cocoa.h>

NS_ASSUME_NONNULL_BEGIN

@interface MLLinkAttachmentCellView : NSTableCellView

@property (nonatomic, readonly) NSImageView *linkImageView;

@property (nonatomic, readonly) NSTextField *dateTextField;

@property (nonatomic, readonly) NSTextField *titleTextField;

@property (nonatomic, readonly) NSTextField *subtitleTextField;

@end

NS_ASSUME_NONNULL_END
