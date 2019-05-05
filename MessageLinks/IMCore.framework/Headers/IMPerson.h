//
//     Generated by class-dump 3.5 (64 bit) (Debug version compiled Jun  9 2015 22:53:21).
//
//     class-dump is Copyright (C) 1997-1998, 2000-2001, 2004-2014 by Steve Nygard.
//

#import <objc/NSObject.h>

@class ABAddressBook, ABPerson, CNContact, NSArray, NSData, NSString;

@interface IMPerson : NSObject
{
    BOOL _registered;
    ABPerson *_abPerson;
    ABAddressBook *_customBook;
    NSString *_uniqueID;
    CNContact *_cnContact;
}

+ (void)_setCachedQueriesEnabled:(BOOL)arg1;
+ (id)_initialABPropertyLabelForProperty:(id)arg1;
+ (id)personWithABPerson:(id)arg1;
+ (id)existingABPeopleWithInstantMessageAddress:(id)arg1 onServices:(id)arg2 allowSubstringMatch:(BOOL)arg3;
+ (id)existingABPersonWithInstantMessageAddress:(id)arg1 onServices:(id)arg2 allowSubstringMatch:(BOOL)arg3;
+ (id)existingABPersonWithFirstName:(id)arg1 andLastName:(id)arg2 andNickName:(id)arg3 orEmail:(id)arg4 orNumber:(id)arg5;
+ (id)existingABPersonWithFirstName:(id)arg1 andLastName:(id)arg2 andNickName:(id)arg3 orEmail:(id)arg4 orNumber:(id)arg5 countryCode:(id)arg6 identifier:(int *)arg7;
+ (id)existingABPersonWithFirstName:(id)arg1 andLastName:(id)arg2 andNickName:(id)arg3 orEmail:(id)arg4 orNumber:(id)arg5 identifier:(int *)arg6;
+ (id)existingABPersonWithFirstName:(id)arg1 andLastName:(id)arg2 orEmail:(id)arg3 orNumber:(id)arg4;
+ (id)existingABPersonForPerson:(id)arg1;
+ (id)existingABPersonWithFirstName:(id)arg1 andLastName:(id)arg2 orEmail:(id)arg3;
+ (id)existingABPersonWithFirstName:(id)arg1 lastName:(id)arg2;
+ (id)allPeople;
@property(retain, nonatomic) CNContact *cnContact; // @synthesize cnContact=_cnContact;
@property(readonly, nonatomic) BOOL _registered; // @synthesize _registered;
@property(retain, nonatomic, setter=_setUniqueID:) NSString *uniqueID; // @synthesize uniqueID=_uniqueID;
@property(retain, nonatomic, setter=_setCustomBook:) ABAddressBook *_customBook; // @synthesize _customBook;
@property(readonly, nonatomic) ABPerson *_abPerson; // @synthesize _abPerson;
- (void).cxx_destruct;
- (unsigned long long)hash;
@property(readonly, nonatomic) unsigned long long status;
@property(readonly, nonatomic) NSData *imageDataWithoutLoading;
@property(retain, nonatomic) NSData *imageData;
- (void)_abPersonChanged:(id)arg1;
@property(readonly, nonatomic) NSArray *groups;
- (id)description;
- (BOOL)isEqual:(id)arg1;
- (BOOL)isEqualToIMPerson:(id)arg1;
- (BOOL)containsHandle:(id)arg1 forServiceProperty:(id)arg2;
- (void)appendID:(id)arg1 toProperty:(id)arg2;
- (void)save;
@property(readonly, nonatomic) NSArray *mobileNumbers;
@property(retain, nonatomic) NSArray *phoneNumbers;
- (id)allHandlesForProperty:(id)arg1;
- (void)setValues:(id)arg1 forProperty:(id)arg2;
- (void)setValues:(id)arg1 forIMProperty:(id)arg2;
- (id)valuesForProperty:(id)arg1;
- (id)_valuesAndLabelsForProperty:(id)arg1;
- (id)valuesForIMProperty:(id)arg1;
@property(readonly, nonatomic) BOOL isInAddressBook;
@property(copy, nonatomic) NSArray *emails;
@property(readonly, nonatomic) NSArray *allEmails;
- (id)emailHandlesForService:(id)arg1;
- (id)emailHandlesForService:(id)arg1 includeBaseEmail:(BOOL)arg2;
- (void)setFirstName:(id)arg1 lastName:(id)arg2;
@property(copy, nonatomic) NSString *lastName;
@property(copy, nonatomic) NSString *firstName;
@property(readonly, nonatomic) NSString *fullName;
@property(copy, nonatomic) NSString *nickname;
@property(readonly, nonatomic) NSString *name;
@property(readonly, nonatomic) NSString *displayName;
@property(readonly, nonatomic) NSString *abbreviatedName;
@property(readonly, nonatomic) NSString *companyName;
@property(readonly, nonatomic) BOOL isCompany;
- (void)dealloc;
- (void)finalize;
@property(readonly, copy, nonatomic) NSString *cnContactID;
@property(readonly, nonatomic) ABPerson *abPerson;
- (id)initWithABPerson:(id)arg1;
- (id)init;
- (id)imHandleRegistrarGUID;
- (id)idsAddresses;

@end
