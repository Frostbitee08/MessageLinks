//
//     Generated by class-dump 3.5 (64 bit) (Debug version compiled Jun  9 2015 22:53:21).
//
//     class-dump is Copyright (C) 1997-1998, 2000-2001, 2004-2014 by Steve Nygard.
//

#import <AppKit/NSView.h>

@interface SOEtchedLine : NSView
{
    double _darkAlpha;
}

+ (void)drawLineAtPoint:(struct CGPoint)arg1 length:(double)arg2 darkAlpha:(double)arg3 flipped:(BOOL)arg4;
+ (void)drawLineAtPoint:(struct CGPoint)arg1 length:(double)arg2 flipped:(BOOL)arg3;
@property double darkAlpha; // @synthesize darkAlpha=_darkAlpha;
- (void)drawRect:(struct CGRect)arg1;
- (void)setFrame:(struct CGRect)arg1;
- (id)initAtPoint:(struct CGPoint)arg1 length:(double)arg2;
- (id)initWithFrame:(struct CGRect)arg1;

@end
