//
//     Generated by class-dump 3.5 (64 bit) (Debug version compiled Jun  9 2015 22:53:21).
//
//     class-dump is Copyright (C) 1997-1998, 2000-2001, 2004-2014 by Steve Nygard.
//

#import <objc/NSObject.h>

#import <LinkPresentation/LPCSSText-Protocol.h>
#import <LinkPresentation/LPHTMLAttributeText-Protocol.h>

__attribute__((visibility("hidden")))
@interface LPPointUnit : NSObject <LPCSSText, LPHTMLAttributeText>
{
    double _value;
}

@property(readonly, nonatomic) double value; // @synthesize value=_value;
- (id)_lp_HTMLAttributeText;
- (id)_lp_CSSText;
- (id)initWithValue:(double)arg1;

@end

