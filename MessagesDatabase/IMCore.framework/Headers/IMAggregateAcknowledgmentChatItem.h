//
//     Generated by class-dump 3.5 (64 bit) (Debug version compiled Jun  9 2015 22:53:21).
//
//     class-dump is Copyright (C) 1997-1998, 2000-2001, 2004-2014 by Steve Nygard.
//

#import <IMCore/IMAssociatedMessageChatItem.h>

@class IMMessageAcknowledgmentChatItem, NSArray;

@interface IMAggregateAcknowledgmentChatItem : IMAssociatedMessageChatItem
{
    BOOL _latestIsFromMe;
    BOOL _includesMultiple;
    NSArray *_acknowledgments;
    IMMessageAcknowledgmentChatItem *_fromMeAcknowledgement;
    long long _latestAcknowledgmentType;
}

@property(readonly, nonatomic) long long latestAcknowledgmentType; // @synthesize latestAcknowledgmentType=_latestAcknowledgmentType;
@property(readonly, nonatomic) BOOL includesMultiple; // @synthesize includesMultiple=_includesMultiple;
@property(readonly, nonatomic) BOOL latestIsFromMe; // @synthesize latestIsFromMe=_latestIsFromMe;
@property(readonly, nonatomic) IMMessageAcknowledgmentChatItem *fromMeAcknowledgement; // @synthesize fromMeAcknowledgement=_fromMeAcknowledgement;
@property(readonly, copy, nonatomic) NSArray *acknowledgments; // @synthesize acknowledgments=_acknowledgments;
- (void).cxx_destruct;
- (id)copyWithZone:(struct _NSZone *)arg1;
- (BOOL)isEqual:(id)arg1;
- (unsigned long long)hash;
- (id)_initWithAcknowledgments:(id)arg1;
@property(readonly, nonatomic) BOOL includesFromMe;

@end

