//
//     Generated by class-dump 3.5 (64 bit) (Debug version compiled Jun  9 2015 22:53:21).
//
//     class-dump is Copyright (C) 1997-1998, 2000-2001, 2004-2014 by Steve Nygard.
//

#import <LinkPresentation/LPSpecializationMetadata.h>

#import <LinkPresentation/LPLinkMetadataPresentationTransformerAdaptor-Protocol.h>
#import <LinkPresentation/LPLinkMetadataPreviewTransformerAdaptor-Protocol.h>

@class LPImage, NSString;

@interface LPiCloudFamilyInvitationMetadata : LPSpecializationMetadata <LPLinkMetadataPresentationTransformerAdaptor, LPLinkMetadataPreviewTransformerAdaptor>
{
    NSString *_title;
    NSString *_subtitle;
    NSString *_action;
    LPImage *_image;
}

+ (BOOL)supportsSecureCoding;
@property(retain, nonatomic) LPImage *image; // @synthesize image=_image;
@property(copy, nonatomic) NSString *action; // @synthesize action=_action;
@property(copy, nonatomic) NSString *subtitle; // @synthesize subtitle=_subtitle;
@property(copy, nonatomic) NSString *title; // @synthesize title=_title;
- (void).cxx_destruct;
- (void)populateLinkMetadataForBackwardCompatibility:(id)arg1;
- (id)copyWithZone:(struct _NSZone *)arg1;
- (void)encodeWithCoder:(id)arg1;
- (id)initWithCoder:(id)arg1;
- (id)previewImageForTransformer:(id)arg1;
- (id)previewSummaryForTransformer:(id)arg1;
- (id)presentationPropertiesForTransformer:(id)arg1;

@end

