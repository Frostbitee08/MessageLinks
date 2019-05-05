//
//  MLLinksViewController.m
//  CalculatorOverrides
//
//  Created by Rocco Del Priore on 4/27/19.
//  Copyright © 2019 Alexandre Colucci. All rights reserved.
//

#import "MLAttachmentsWrapperViewController.h"

#import <Quartz/Quartz.h>
#import <Masonry/Masonry.h>

//HACK: This whole class exists because I don't want to break anything. It should probably be removed
@interface MLAttachmentsWrapperViewController ()
@property (nonatomic) NSViewController *rootViewController;
@end

@implementation MLAttachmentsWrapperViewController

- (instancetype)initWithRootViewController:(NSViewController *)viewController {
    self = [self init];
    if (self) {
        self.rootViewController = viewController;
    }
    return self;
}

- (instancetype)init {
    self = [super init];
    if (self) {
        self.view = [[NSView alloc] initWithFrame:NSMakeRect(0, 0, 300, 500)];
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self addChildViewController:self.rootViewController];
}

- (void)viewDidAppear {
    [super viewDidAppear];
    
    [self.view.layer setBackgroundColor:[NSColor clearColor].CGColor];
    
    //HACK: This timing attach as to exist otherwise it will crash on the second viewDidAppear. No idea Why.
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, 0.01 * NSEC_PER_SEC), dispatch_get_main_queue(), ^{
        [self.rootViewController.view removeFromSuperview];
        [self.view addSubview:self.rootViewController.view positioned:NSWindowAbove relativeTo:nil];
        
        [self.rootViewController.view mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.edges.equalTo(self.view);
        }];
    });
}

@end
