//
//  MLLinkAttachmentCellView.m
//  CalculatorOverrides
//
//  Created by Rocco Del Priore on 4/28/19.
//  Copyright © 2019 Alexandre Colucci. All rights reserved.
//

#import <Masonry/Masonry.h>

#import "MLLinkAttachmentCellView.h"
#import "MLLinkImageView.h"

@interface MLLinkAttachmentCellView ()

@property (nonatomic) NSImageView *linkImageView;

@property (nonatomic) NSTextField *dateTextField;

@property (nonatomic) NSTextField *titleTextField;

@property (nonatomic) NSTextField *subtitleTextField;

@end

@implementation MLLinkAttachmentCellView {
    NSStackView *stackView;
}

- (instancetype) initWithFrame:(NSRect)frameRect {
    self = [super initWithFrame:frameRect];
    if (self) {
        self.linkImageView     = [[MLLinkImageView alloc] init];
        self.titleTextField    = [[NSTextField alloc] init];
        self.subtitleTextField = [[NSTextField alloc] init];
        self.dateTextField     = [[NSTextField alloc] init];
        
        stackView = [[NSStackView alloc] init];

        [stackView setAlignment:NSLayoutAttributeLeft];
        [stackView setDistribution:NSStackViewDistributionGravityAreas];
        [stackView setOrientation:NSUserInterfaceLayoutOrientationVertical];
        [stackView addView:self.titleTextField inGravity:NSStackViewGravityCenter];
        [stackView addView:self.subtitleTextField inGravity:NSStackViewGravityCenter];
        
        [self.titleTextField setFont:[NSFont systemFontOfSize:14 weight:NSFontWeightMedium]];
        [self.titleTextField setAlignment:NSTextAlignmentLeft];
        [self.subtitleTextField setAlignment:NSTextAlignmentLeft];
        [self.dateTextField setAlignment:NSTextAlignmentRight];
        [self.linkImageView.layer setCornerRadius:5];
        
        for (NSTextField *field in @[self.titleTextField, self.dateTextField, self.subtitleTextField]) {
            [field setBezeled:NO];
            [field setEditable:NO];
            [field setSelectable:NO];
            [field setBackgroundColor:[NSColor clearColor]];
        }
        
        [self addSubview:self.dateTextField positioned:NSWindowAbove relativeTo:nil];
        [self addSubview:stackView positioned:NSWindowAbove relativeTo:self.dateTextField];
        [self addSubview:self.linkImageView positioned:NSWindowAbove relativeTo:stackView];
        
        [self.linkImageView mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(self).offset(10);
            make.left.equalTo(self).offset(15);
            make.height.width.equalTo(@(70));
        }];
        [self.dateTextField mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(self).offset(-15);
            make.top.equalTo(self).offset(5);
            make.height.equalTo(@(15));
            make.width.equalTo(@(150));
        }];
        [stackView mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.linkImageView.mas_right).offset(10);
            make.top.bottom.equalTo(self.linkImageView);
            make.right.equalTo(self).offset(-15);
        }];
    }
    return self;
}

@end
