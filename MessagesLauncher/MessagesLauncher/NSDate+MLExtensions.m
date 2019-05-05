//
//  NSDate+MLExtensions.m
//  CalculatorOverrides
//
//  Created by Rocco Del Priore on 4/30/19.
//  Copyright © 2019 Alexandre Colucci. All rights reserved.
//

#import "NSDate+MLExtensions.h"

@implementation NSDate (MLExtensions)

+ (NSDate *)december31st2000 {
    return [NSDate dateWithTimeIntervalSince1970:86400*11323];
}

@end
