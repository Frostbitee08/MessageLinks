//
//  MLLinksViewController.h
//  CalculatorOverrides
//
//  Created by Rocco Del Priore on 4/27/19.
//  Copyright © 2019 Alexandre Colucci. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import <SocialUI/SOAttachmentsViewController.h>
#import <SocialUI/SOPhotoAttachmentsViewController.h>
#import <SocialUI/SOContentAttachmentsViewController.h>

NS_ASSUME_NONNULL_BEGIN

@interface MLAttachmentsWrapperViewController : SOAttachmentsViewController

- (instancetype)initWithRootViewController:(NSViewController *)viewController;

@property (nonatomic, readonly) NSViewController *rootViewController;

@end

NS_ASSUME_NONNULL_END
