//
//     Generated by class-dump 3.5 (64 bit) (Debug version compiled Jun  9 2015 22:53:21).
//
//     class-dump is Copyright (C) 1997-1998, 2000-2001, 2004-2014 by Steve Nygard.
//

#import <objc/NSObject.h>

@class NSCache, NSDictionary, NSHashTable, NSMutableDictionary;
@protocol OS_dispatch_queue, SGSuggestionsServiceContactsProtocol;

@interface IMSuggestionsService : NSObject
{
    NSObject<SGSuggestionsServiceContactsProtocol> *_connection;
    NSCache *_cache;
    NSObject<OS_dispatch_queue> *_queue;
    NSMutableDictionary *_pending;
    NSDictionary *_localTable;
    NSHashTable *_handlesToRetry;
    id _newContactNotificationToken;
    struct __CFRunLoopObserver *_notificationObserver;
}

+ (id)sharedInstance;
- (void).cxx_destruct;
- (void)scheduleFetchIfNecessaryForHandle:(id)arg1;
- (void)_startRequestForDisplayName:(id)arg1 queue:(id)arg2;
- (void)fetchSuggestedRealNameForDisplayName:(id)arg1 queue:(id)arg2 block:(CDUnknownBlockType)arg3;
- (id)suggestedNameFromCache:(id)arg1 wasFound:(char *)arg2;
- (void)stopUsingLocalLookups;
- (void)startUsingLocalLookupsWithTable:(id)arg1;
- (BOOL)_maybeEmailAddress:(id)arg1;
- (BOOL)_maybePhoneNumber:(id)arg1;
- (void)dealloc;
- (id)init;

@end

