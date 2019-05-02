//
//     Generated by class-dump 3.5 (64 bit) (Debug version compiled Jun  9 2015 22:53:21).
//
//     class-dump is Copyright (C) 1997-1998, 2000-2001, 2004-2014 by Steve Nygard.
//

#import <AppKit/NSView.h>

@class NSImage;

@interface SOStaticImageView : NSView
{
    BOOL _imageIsOpaque;
    NSImage *_image;
}

@property BOOL imageIsOpaque; // @synthesize imageIsOpaque=_imageIsOpaque;
@property(retain, nonatomic) NSImage *image; // @synthesize image=_image;
- (void).cxx_destruct;
- (struct CGSize)intrinsicContentSize;
- (void)viewDidChangeBackingProperties;
- (void)updateLayer;
- (BOOL)isOpaque;
- (BOOL)wantsUpdateLayer;
- (id)initWithFrame:(struct CGRect)arg1;
- (id)initWithCoder:(id)arg1;
- (void)_commonSOStaticImageViewInit;

@end

