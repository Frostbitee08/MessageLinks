//
//  MLChatDatabaseManager.m
//  CalculatorOverrides
//
//  Created by Rocco Del Priore on 4/29/19.
//  Copyright © 2019 Alexandre Colucci. All rights reserved.
//

#import "NSDate+MLExtensions.h"

#import "MLChatDatabaseManager.h"

#import <FMDB/FMDB.h>

#include <LinkPresentation/LPLinkMetadata.h>
#include <LinkPresentation/LPImage.h>
#include <IMCore/IMAttachment.h>
#include <IMCore/IMMessageChatItem.h>
#include <IMCore/IMMessage.h>
#include <IMCore/IMChat.h>
#include <unistd.h>
#include <sys/types.h>
#include <pwd.h>
#include <assert.h>

NSString *RealHomeDirectory() {
    struct passwd *pw = getpwuid(getuid());
    assert(pw);
    return [NSString stringWithUTF8String:pw->pw_dir];
}

@interface MLChatDatabaseManager ()
@property (nonatomic, retain) FMDatabase *database;
@end

@implementation MLChatDatabaseManager

+ (instancetype)sharedInstance {
    static dispatch_once_t onceToken;
    static MLChatDatabaseManager *instance = nil;
    dispatch_once(&onceToken, ^{
        instance = [[self alloc] init];
    });
    return instance;
}

- (instancetype)init {
    self = [super init];
    if (self) {
        //Set Member Variables
        self.database = [self newDatabase];
        
        //Load RichLink bundle if we haven't already
        NSBundle *richLinkBundle = [NSBundle bundleWithPath:@"/System/Library/Messages/iMessageBalloons/RichLinkProvider.bundle"];
        if (![richLinkBundle isLoaded]) {
            [richLinkBundle load];
        }
    }
    return self;
}

- (FMDatabase *)newDatabase {
    NSString *path = [RealHomeDirectory() stringByAppendingString:@"/Library/Messages/chat.db"];
    NSURL *url = [NSURL fileURLWithPath:path];
    return [FMDatabase databaseWithPath:url.path];
}

- (LPLinkMetadata *)metadataWithPayload:(NSData *)payload {
    if (payload) {
        NSObject *object = [NSKeyedUnarchiver unarchiveObjectWithData:payload];
        SEL linkMetadataSelector = NSSelectorFromString(@"metadata");
        if ([object respondsToSelector:linkMetadataSelector]) {
            LPLinkMetadata *metadata = (LPLinkMetadata *)[object performSelector:linkMetadataSelector];
            if ([metadata isKindOfClass:[LPLinkMetadata class]]) {
                return metadata;
            }
        }
    }
    return nil;
}

- (BOOL)isDatabaseAccessible {
    if ([self.database isKindOfClass:[FMDatabase class]]) {
        if (![self.database isOpen]) {
            if (![self.database openWithFlags:0x00000001]) {
                return false;
            }
        }
    }
    else {
        //TODO: REMOVE THIS! Very bad, can lead to inifite loop
        self.database = [self newDatabase];
        return [self isDatabaseAccessible];
    }
    
    return true;
}

- (int)fetchRecipientHandleId:(NSString *)chatId {
    //Check DB Accessibility
    if (![self isDatabaseAccessible]) {
        return -1;
    }
    
    //Perform our query
    int result = -1;
    FMResultSet *resultSet = [self.database executeQuery:[NSString stringWithFormat:@"SELECT * FROM `handle` WHERE id = \"%@\"", chatId]];
    while ([resultSet next]) {
        result = [resultSet intForColumnIndex:0];
    }
    
    return result;
}

- (NSInteger)attachmentIdentifierForMessageIdentifier:(NSInteger)messageIdentifier {
    //Check DB Accessibility
    if (![self isDatabaseAccessible]) {
        return -1;
    }
    
    //Perform our query
    int result = -1;
    FMResultSet *resultSet = [self.database executeQuery:[NSString stringWithFormat:@"SELECT * FROM `message_attachment_join` WHERE message_id = \"%li\"", messageIdentifier]];
    while ([resultSet next]) {
        result = [resultSet intForColumnIndex:1];
    }
    
    return result;
}

- (NSURL *)urlForAttachment:(NSInteger)attachmentIdentifier {
    //Check DB Accessibility
    if (![self isDatabaseAccessible]) {
        return nil;
    }
    
    //Perform our query
    NSURL *result = nil;
    FMResultSet *resultSet = [self.database executeQuery:[NSString stringWithFormat:@"SELECT * FROM `attachment` WHERE ROWID = \"%li\"", attachmentIdentifier]];
    while ([resultSet next]) {
        NSString *path = [[resultSet stringForColumn:@"filename"] stringByReplacingOccurrencesOfString:@"~" withString:RealHomeDirectory()]; 
        if (path) {
            NSURL *url = [NSURL fileURLWithPath:path];
            if (url) {
                result = url;
            }
        }
    }
    
    return result;
}

- (NSArray<MLLink *> *)linksForChat:(IMChat *)chat error:(NSError **)error {
    //HACK: There may be a better way to determine whether this is a group chat
    if ([chat.chatIdentifier hasPrefix:@"chat"]) {
        return [self linksForGroupChat:chat error:error];
    }
    return [self linksForSingleChat:chat error:error];
}

- (NSArray<MLLink *> *)linksForSingleChat:(IMChat *)chat error:(NSError **)error {
    //Check DB Accessibility
    if (![self isDatabaseAccessible]) {
        //TODO: Set error here
        return nil;
    }
    
    //Create Intial Variables
    NSMutableArray *results = [NSMutableArray array];
    NSString *query = [[NSString stringWithFormat:@"SELECT * FROM `message` WHERE handle_id = %i", [self fetchRecipientHandleId:chat.chatIdentifier]]
                       stringByAppendingString:@" AND text LIKE '%http%'"];
    
    //Perform Our Query
    FMResultSet *resultSet = [self.database executeQuery:query];
    while ([resultSet next]) {
        //Fetch Variables
        NSString *dateString = [resultSet stringForColumn:@"date"];
        NSDate *date = [NSDate dateWithTimeInterval:[dateString integerValue]/1000000000.0 sinceDate:[NSDate december31st2000]];
        NSString *text = [resultSet stringForColumn:@"text"];
        NSData *payload = [resultSet dataForColumn:@"payload_data"];
        LPLinkMetadata *metadata = [self metadataWithPayload:payload];
        NSInteger messageId = [resultSet intForColumnIndex:0];
        NSInteger attachmentId = [self attachmentIdentifierForMessageIdentifier:messageId];
        NSURL *attachmentFileURL = [self urlForAttachment:attachmentId];
        
        //Parse for URLs
        NSDataDetector *detector = [NSDataDetector dataDetectorWithTypes:NSTextCheckingTypeLink error:nil];
        NSArray *matches = [detector matchesInString:text options:0 range:NSMakeRange(0, [text length])];
        NSSet *matchesSet = [NSSet setWithArray:matches];
        
        //Create links
        for (id result in matchesSet.allObjects) {
            MLLink *link = [[MLLink alloc] initWithURL:[result URL] date:date];
            link.imageFileUrl = attachmentFileURL;
            if (metadata) {
                link.hasAttachedMetadata = true;
                link.title = metadata.title;
                link.summary = metadata.summary;
                link.siteName = metadata.siteName;
            }
            [results addObject:link];
        }
    }
    
    //Sort Results
    [results sortUsingComparator:^NSComparisonResult(MLLink *obj1, MLLink *obj2) {
        return [obj2.date compare:obj1.date];
    }];
    
    //Return Values
    return results;
}

- (NSArray<MLLink *> *)linksForGroupChat:(IMChat *)chat error:(NSError **)error {
    //Check DB Accessibility
    if (![self isDatabaseAccessible]) {
        //TODO: Set error here
        return nil;
    }
    
    //Perform our query
    NSMutableArray *results = [NSMutableArray array];
    FMResultSet *resultSet = [self.database executeQuery:@"SELECT * FROM `message` WHERE text LIKE '%http%'"];
    while ([resultSet next]) {
        NSString *roomname = [resultSet stringForColumn:@"cache_roomnames"];
        if (roomname) {
            if ([roomname isEqualToString:chat.chatIdentifier]) {
                //Fetch Variables
                NSString *dateString = [resultSet stringForColumn:@"date"];
                NSDate *date = [NSDate dateWithTimeInterval:[dateString integerValue]/1000000000.0 sinceDate:[NSDate december31st2000]];
                NSString *text = [resultSet stringForColumn:@"text"];
                NSData *payload = [resultSet dataForColumn:@"payload_data"];
                LPLinkMetadata *metadata = [self metadataWithPayload:payload];
                
                //Parse for URLs
                NSDataDetector *detector = [NSDataDetector dataDetectorWithTypes:NSTextCheckingTypeLink error:nil];
                NSArray *matches = [detector matchesInString:text options:0 range:NSMakeRange(0, [text length])];
                NSSet *matchesSet = [NSSet setWithArray:matches];
                
                //Create links
                for (id result in matchesSet.allObjects) {
                    MLLink *link = [[MLLink alloc] initWithURL:[result URL] date:date];
                    if (metadata) {
                        link.hasAttachedMetadata = true;
                        link.title = metadata.title;
                        link.summary = metadata.summary;
                        link.siteName = metadata.siteName;
                    }
                    [results addObject:link];
                }
            }
        }
    }
    
    //Sort Results
    [results sortUsingComparator:^NSComparisonResult(MLLink *obj1, MLLink *obj2) {
        return [obj2.date compare:obj1.date];
    }];
    
    //Return Values
    return results;
}

- (NSArray<MLLink *> *)recentLinks:(NSInteger)numberOfRecentLinks error:(NSError **)error {
    //Check DB Accessibility
    if (![self isDatabaseAccessible]) {
        //TODO: Set error here
        return nil;
    }
    
    //Perform our query
    NSMutableArray *results = [NSMutableArray array];
    FMResultSet *resultSet = [self.database executeQuery:@"SELECT * FROM `message` WHERE text LIKE '%http%'"];
    while ([resultSet next]) {
        //Fetch Variables
        NSString *dateString = [resultSet stringForColumn:@"date"];
        NSDate *date = [NSDate dateWithTimeInterval:[dateString integerValue]/1000000000.0 sinceDate:[NSDate december31st2000]];
        NSString *text = [resultSet stringForColumn:@"text"];
        NSData *payload = [resultSet dataForColumn:@"payload_data"];
        LPLinkMetadata *metadata = [self metadataWithPayload:payload];

        //Parse for URLs
        NSDataDetector *detector = [NSDataDetector dataDetectorWithTypes:NSTextCheckingTypeLink error:nil];
        NSArray *matches = [detector matchesInString:text options:0 range:NSMakeRange(0, [text length])];
        NSSet *matchesSet = [NSSet setWithArray:matches];

        //Create links
        for (id result in matchesSet.allObjects) {
            MLLink *link = [[MLLink alloc] initWithURL:[result URL] date:date];
            if (metadata) {
                link.hasAttachedMetadata = true;
                link.title = metadata.title;
                link.summary = metadata.summary;
                link.siteName = metadata.siteName;
            }
            [results addObject:link];
        }
    }
    
    //Sort Results
    [results sortUsingComparator:^NSComparisonResult(MLLink *obj1, MLLink *obj2) {
        return [obj2.date compare:obj1.date];
    }];
    
    if (results.count > numberOfRecentLinks) {
        return [results subarrayWithRange:NSMakeRange(0, numberOfRecentLinks)];
    }
    
    //Return Values
    return results;
}

@end
