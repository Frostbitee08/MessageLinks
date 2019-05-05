//
//  MLLink.m
//  CalculatorOverrides
//
//  Created by Rocco Del Priore on 4/30/19.
//  Copyright © 2019 Alexandre Colucci. All rights reserved.
//

#import "MLLink.h"

@interface MLLink ()

@property (nonatomic, retain) NSURL *url;

@property (nonatomic, retain) NSDate *date;

@end

@implementation MLLink

- (id)copyWithZone:(NSZone *)zone {
    id copy = [[[self class] alloc] init];
    if (copy) {
        [copy setHasAttachedMetadata:self.hasAttachedMetadata];
        [copy setTitle:[self.title copyWithZone:zone]];
        [copy setUrl:[self.url copyWithZone:zone]];
        [copy setDate:[self.date copyWithZone:zone]];
        [copy setSiteName:[self.siteName copyWithZone:zone]];
        [copy setSummary:[self.summary copyWithZone:zone]];
        [copy setImageFileUrl:[self.imageFileUrl copyWithZone:zone]];
    }
    return copy;
}

- (instancetype)initWithURL:(NSURL *)url date:(NSDate *)date {
    self = [super init];
    if (self) {
        self.hasAttachedMetadata = false;
        self.url = url;
        self.date = date;
    }
    return self;
}

@end
