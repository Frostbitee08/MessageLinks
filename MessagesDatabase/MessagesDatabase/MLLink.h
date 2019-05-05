//
//  MLLink.h
//  CalculatorOverrides
//
//  Created by Rocco Del Priore on 4/30/19.
//  Copyright © 2019 Alexandre Colucci. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface MLLink : NSObject <NSCopying>

@property (nonatomic, readonly) NSURL *url;

@property (nonatomic, readonly) NSDate *date;

@property (nonatomic, retain) NSURL *imageFileUrl;

@property (nonatomic, retain) NSString *title;

@property (nonatomic, retain) NSString *siteName;

@property (nonatomic, retain) NSString *summary;

@property (nonatomic) BOOL hasAttachedMetadata;

- (instancetype)initWithURL:(NSURL *)url date:(NSDate *)date;

@end

NS_ASSUME_NONNULL_END
