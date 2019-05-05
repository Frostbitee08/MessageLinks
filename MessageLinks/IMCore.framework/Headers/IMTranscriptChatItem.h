//
//     Generated by class-dump 3.5 (64 bit) (Debug version compiled Jun  9 2015 22:53:21).
//
//     class-dump is Copyright (C) 1997-1998, 2000-2001, 2004-2014 by Steve Nygard.
//

#import <IMCore/IMChatItem.h>

@class NSString;

@interface IMTranscriptChatItem : IMChatItem
{
    NSString *_guid;
    unsigned char _contiguousType;
    unsigned char _attachmentContiguousType;
    unsigned int _contiguousLoaded:1;
}

@property(copy, nonatomic, setter=_setGUID:) NSString *guid; // @synthesize guid=_guid;
- (void)_setAttachmentContiguousType:(unsigned char)arg1;
- (void)_setContiguousType:(unsigned char)arg1;
- (void)_setContiguousLoaded:(BOOL)arg1;
- (BOOL)_isContiguousLoaded;
@property(readonly, nonatomic, getter=isContiguous) BOOL contiguous;
@property(readonly, nonatomic) unsigned char attachmentContiguousType;
@property(readonly, nonatomic) unsigned char contiguousType;
- (BOOL)isAttachmentContiguousWithChatItem:(id)arg1;
- (BOOL)isContiguousWithChatItem:(id)arg1;
- (id)copyWithZone:(struct _NSZone *)arg1;
- (BOOL)isEqual:(id)arg1;
- (unsigned long long)hash;
- (id)description;

@end
