//
//  MLLinkItemView.m
//  MessagesLauncher
//
//  Created by Rocco Del Priore on 5/5/19.
//  Copyright © 2019 Rocco Del Priore. All rights reserved.
//

#import <Masonry/Masonry.h>

#import "MLLinkItemView.h"
#import "MLImageView.h"

@interface MLLinkItemView ()

@property (nonatomic) NSImageView *linkImageView;

@property (nonatomic) NSTextField *dateTextField;

@property (nonatomic) NSTextField *titleTextField;

@property (nonatomic) NSTextField *subtitleTextField;

@end

@implementation MLLinkItemView

+ (NSSize)intrinsicContentSize {
    return NSMakeSize(250, 90);
}

- (instancetype)initWithFrame:(NSRect)frameRect {
    self = [super initWithFrame:frameRect];
    if (self) {
        //Instantiate Member Variables
        self.linkImageView     = [[MLImageView alloc] init];
        self.titleTextField    = [[NSTextField alloc] init];
        self.subtitleTextField = [[NSTextField alloc] init];
        self.dateTextField     = [[NSTextField alloc] init];
        
        //Instantiate Local Variables
        NSStackView *stackView = [[NSStackView alloc] init];
        
        //Set Properties
        [stackView setAlignment:NSLayoutAttributeLeft];
        [stackView setOrientation:NSUserInterfaceLayoutOrientationVertical];
        [stackView addArrangedSubview:self.titleTextField];
        [stackView addArrangedSubview:self.subtitleTextField];
        
        //Add Subviews
        [self addSubview:self.dateTextField positioned:NSWindowAbove relativeTo:nil];
        [self addSubview:stackView positioned:NSWindowAbove relativeTo:self.dateTextField];
        [self addSubview:self.linkImageView positioned:NSWindowAbove relativeTo:stackView];
        
        //Set Constraints
        [self.linkImageView mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(self).offset(10);
            make.left.equalTo(self).offset(10);
            make.height.width.equalTo(@(60));
        }];
        [self.dateTextField mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(self).offset(-15);
            make.top.equalTo(self).offset(5);
            make.height.equalTo(@(15));
            make.width.equalTo(@(150));
        }];
        [stackView mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.top.bottom.equalTo(self.linkImageView);
            make.right.equalTo(self).offset(-10);
            make.left.equalTo(self.linkImageView.mas_right).offset(5);
        }];
    }
    return self;
}

- (void)layout {
    [super layout];
    
    for (NSTextField *field in @[self.titleTextField, self.dateTextField, self.subtitleTextField]) {
        [field setBezeled:NO];
        [field setEditable:NO];
        [field setSelectable:NO];
        [field setBackgroundColor:[NSColor clearColor]];
        [field setDrawsBackground:false];
    }
    
    [self.titleTextField setAlignment:NSTextAlignmentLeft];
    [self.subtitleTextField setAlignment:NSTextAlignmentLeft];
    [self.dateTextField setAlignment:NSTextAlignmentRight];
}

- (void)drawRect:(NSRect)rect {
    if ([[self enclosingMenuItem] isHighlighted]) {
        [[NSColor colorWithDeviceRed:0.1804 green:0.3412 blue:0.7647 alpha:1.0] set];
    }
    else {
        [[NSColor clearColor] set];
    }
    NSRectFill(rect);
}

- (void)mouseUp:(NSEvent *)event {
    NSMenu *menu = self.enclosingMenuItem.menu;
    [menu cancelTracking];
    [menu performActionForItemAtIndex:[menu indexOfItem:self.enclosingMenuItem]];
}

@end
