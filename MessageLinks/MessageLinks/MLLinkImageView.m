//
//  MLLinkImageView.m
//  CalculatorOverrides
//
//  Created by Rocco Del Priore on 5/1/19.
//  Copyright © 2019 Alexandre Colucci. All rights reserved.
//

#import "MLLinkImageView.h"

@interface MLLinkImageView ()
@property (nonatomic) NSImage *cachedImage;
@end

@implementation MLLinkImageView

- (instancetype)init {
    self = [super init];
    if (self) {
        [self customInit];
    }
    return self;
}

- (instancetype)initWithCoder:(NSCoder *)aDecoder {
    self = [super initWithCoder:aDecoder];
    if (self) {
        [self customInit];
    }
    return self;
}

- (instancetype)initWithFrame:(NSRect)frameRect {
    self = [super initWithFrame:frameRect];
    if (self) {
        [self customInit];
    }
    return self;
}

- (void)customInit {
    [super setImageScaling:NSImageScaleAxesIndependently];
    
    self.layer = [CALayer layer];
    [self.layer setCornerRadius:5];
    [self.layer setMasksToBounds:true];
    [self setWantsLayer:true];
    
    [self setEnabled:false];
}

- (void)setImageScaling:(NSImageScaling)newScaling {
    [super setImageScaling:NSImageScaleAxesIndependently];
}

- (void)setImage:(NSImage *)image {
    if (image == nil) {
        [super setImage:image];
        return;
    }
    
    if (CGRectEqualToRect(self.bounds, NSZeroRect)) {
        self.cachedImage = image;
        [super setImage:nil];
        return;
    }
    
    __weak MLLinkImageView *weakSelf = self;
    NSImage *scaleToFillImage = [NSImage imageWithSize:self.bounds.size flipped:NO drawingHandler:^BOOL(NSRect destinationRect) {
        NSSize imageSize             = [image size];
        NSSize imageViewSize         = weakSelf.bounds.size;
        NSSize newImageSize          = imageSize;
        CGFloat imageAspectRatio     = imageSize.height/imageSize.width;
        CGFloat imageViewAspectRatio = imageViewSize.height/imageViewSize.width;
        
        if (imageAspectRatio < imageViewAspectRatio) {
            newImageSize.width = imageSize.height / imageViewAspectRatio;
        }
        else {
            newImageSize.height = imageSize.width * imageViewAspectRatio;
        }
        
        NSRect sourceRect = NSMakeRect(imageSize.width/2.0-newImageSize.width/2.0,
                                       imageSize.height/2.0-newImageSize.height/2.0,
                                       newImageSize.width,
                                       newImageSize.height);
        
        [[NSGraphicsContext currentContext] setImageInterpolation:NSImageInterpolationHigh];
        
        [image drawInRect:destinationRect
                 fromRect:sourceRect
                operation:NSCompositeCopy
                 fraction:1.0
           respectFlipped:YES
                    hints:@{NSImageHintInterpolation: @(NSImageInterpolationHigh)}];
        
        return YES;
    }];
    
    [scaleToFillImage setCacheMode:NSImageCacheNever];
    
    [super setImage:scaleToFillImage];
}

- (void)layout {
    [super layout];
    
    if (!CGRectEqualToRect(self.bounds, NSZeroRect) && self.cachedImage) {
        [self setImage:self.cachedImage];
        self.cachedImage = nil;
    }
}
@end
