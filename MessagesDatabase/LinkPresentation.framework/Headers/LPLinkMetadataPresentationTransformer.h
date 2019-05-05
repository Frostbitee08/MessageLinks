//
//     Generated by class-dump 3.5 (64 bit) (Debug version compiled Jun  9 2015 22:53:21).
//
//     class-dump is Copyright (C) 1997-1998, 2000-2001, 2004-2014 by Steve Nygard.
//

#import <objc/NSObject.h>

@class LPLinkMetadata, NSURL;

@interface LPLinkMetadataPresentationTransformer : NSObject
{
    BOOL _complete;
    BOOL _allowsTapToLoad;
    BOOL _forceMiniStyle;
    LPLinkMetadata *_metadata;
    NSURL *_URL;
}

@property(nonatomic) BOOL forceMiniStyle; // @synthesize forceMiniStyle=_forceMiniStyle;
@property(nonatomic) BOOL allowsTapToLoad; // @synthesize allowsTapToLoad=_allowsTapToLoad;
@property(nonatomic, getter=isComplete) BOOL complete; // @synthesize complete=_complete;
@property(copy, nonatomic) NSURL *URL; // @synthesize URL=_URL;
@property(copy, nonatomic) LPLinkMetadata *metadata; // @synthesize metadata=_metadata;
- (void).cxx_destruct;
- (id)presentationProperties;
- (id)unspecializedPresentationProperties;
- (id)backgroundColorForStyle:(long long)arg1;
- (id)videoForStyle:(long long)arg1;
- (id)imageForStyle:(long long)arg1 icon:(id *)arg2;
- (id)quotedTextForStyle:(long long)arg1;
- (id)bottomCaptionForStyle:(long long)arg1;
- (id)topCaptionForStyle:(long long)arg1;
- (id)mainCaptionBarForStyle:(long long)arg1;
- (long long)rendererStyle;
@property(readonly, copy, nonatomic) NSURL *canonicalURL;
@property(readonly, copy, nonatomic) NSURL *originalURL;

@end

