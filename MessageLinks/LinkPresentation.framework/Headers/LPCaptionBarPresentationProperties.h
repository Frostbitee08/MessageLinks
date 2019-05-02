//
//     Generated by class-dump 3.5 (64 bit) (Debug version compiled Jun  9 2015 22:53:21).
//
//     class-dump is Copyright (C) 1997-1998, 2000-2001, 2004-2014 by Steve Nygard.
//

#import <objc/NSObject.h>

@class LPCaptionRowPresentationProperties, LPImage, NSColor, NSNumber;

@interface LPCaptionBarPresentationProperties : NSObject
{
    LPImage *_leadingIcon;
    NSColor *_leadingIconMaskColor;
    LPImage *_trailingIcon;
    NSColor *_trailingIconMaskColor;
    LPImage *_belowLeadingIcon;
    NSColor *_belowLeadingIconMaskColor;
    long long _leadingAccessoryType;
    long long _trailingAccessoryType;
    LPCaptionRowPresentationProperties *_aboveTop;
    LPCaptionRowPresentationProperties *_top;
    LPCaptionRowPresentationProperties *_bottom;
    LPCaptionRowPresentationProperties *_belowBottom;
    NSNumber *_minimumHeight;
    struct CGSize _leadingIconSize;
    struct CGSize _trailingIconSize;
}

@property(retain, nonatomic) NSNumber *minimumHeight; // @synthesize minimumHeight=_minimumHeight;
@property(readonly, retain, nonatomic) LPCaptionRowPresentationProperties *belowBottom; // @synthesize belowBottom=_belowBottom;
@property(readonly, retain, nonatomic) LPCaptionRowPresentationProperties *bottom; // @synthesize bottom=_bottom;
@property(readonly, retain, nonatomic) LPCaptionRowPresentationProperties *top; // @synthesize top=_top;
@property(readonly, retain, nonatomic) LPCaptionRowPresentationProperties *aboveTop; // @synthesize aboveTop=_aboveTop;
@property(nonatomic) long long trailingAccessoryType; // @synthesize trailingAccessoryType=_trailingAccessoryType;
@property(nonatomic) long long leadingAccessoryType; // @synthesize leadingAccessoryType=_leadingAccessoryType;
@property(retain, nonatomic) NSColor *belowLeadingIconMaskColor; // @synthesize belowLeadingIconMaskColor=_belowLeadingIconMaskColor;
@property(retain, nonatomic) LPImage *belowLeadingIcon; // @synthesize belowLeadingIcon=_belowLeadingIcon;
@property(nonatomic) struct CGSize trailingIconSize; // @synthesize trailingIconSize=_trailingIconSize;
@property(retain, nonatomic) NSColor *trailingIconMaskColor; // @synthesize trailingIconMaskColor=_trailingIconMaskColor;
@property(retain, nonatomic) LPImage *trailingIcon; // @synthesize trailingIcon=_trailingIcon;
@property(nonatomic) struct CGSize leadingIconSize; // @synthesize leadingIconSize=_leadingIconSize;
@property(retain, nonatomic) NSColor *leadingIconMaskColor; // @synthesize leadingIconMaskColor=_leadingIconMaskColor;
@property(retain, nonatomic) LPImage *leadingIcon; // @synthesize leadingIcon=_leadingIcon;
- (void).cxx_destruct;
- (long long)rightAccessoryType;
- (long long)leftAccessoryType;
- (id)belowRightIconMaskColor;
- (id)belowRightIcon;
- (id)belowLeftIconMaskColor;
- (id)belowLeftIcon;
- (id)rightIconMaskColor;
- (id)rightIcon;
- (id)leftIconMaskColor;
- (id)leftIcon;
@property(readonly, nonatomic) BOOL hasAnyContent;
- (id)init;

@end

