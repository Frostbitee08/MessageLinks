//
//  MessageLinks.m
//  MessageLinks
//
//  Created by Rocco Del Priore on 5/1/19.
//  Copyright © 2019 Rocco Del Priore. All rights reserved.
//

#import <Masonry/Masonry.h>

#import "MessageLinks.h"
#import "MLAttachmentsWrapperViewController.h"
#import "MLLinksViewController.h"

#include <stdio.h>
#include <objc/runtime.h>
#include <Foundation/Foundation.h>
#include <AppKit/AppKit.h>
#include <IMCore/IMChat.h>
#include <SocialUI/SOChatDisplayController.h>
#include <SocialUI/SOAttachmentsTabViewController.h>
#include <SocialUI/SOAttachmentsViewController.h>
#include <SocialUI/SOPhotoAttachmentsViewController.h>

static IMP sOriginalImp = NULL;
static IMP sViewDidAppearImp = NULL;
static IMP sShouldSelectImp = NULL;
static IMP sDidSelectImp = NULL;
static IMP sSelectableImp = NULL;
static IMP sParseAndSetImp = NULL;
static IMP sChatItemsChangedImp = NULL;
static IMP sRepresentedObjectImp = NULL;

typedef NS_ENUM(NSInteger, MLOverride) {
    MLOverrideViewDidLoad = 0,
    MLOverrideViewDidAppear = 1,
    MLOverrideParseAndSetup = 2,
    MLOverrideChatItem = 3,
    MLOverrideRepresentedObject = 4,
    MLOverrideDidSelect = 5,
    MLOverrideShouldSelect = 6,
    MLOverrideAllows = 7
};


@implementation MessageLinks

+(void)load {
    Class originalClass = NSClassFromString(@"SOAttachmentsTabViewController");
    
    //View Did Load
    [MessageLinks loadWith:originalClass replacing:@selector(viewDidLoad) replacement:@selector(rdp_viewDidLoad) override:MLOverrideViewDidLoad];
    
    //View Did Appear
    [MessageLinks loadWith:originalClass replacing:@selector(viewDidAppear) replacement:@selector(rdp_viewDidAppear) override:MLOverrideViewDidAppear];
    
    //Did Select
    /*[MessageLinks loadWith:originalClass
     replacing:@selector(tabView:didSelectTabViewItem:)
     replacement:@selector(rdp_tabView:didSelectTabViewItem:)
     override:MLOverrideViewDidAppear];*/
    
    //Should Select
    [MessageLinks loadWith:originalClass
                 replacing:@selector(tabView:shouldSelectTabViewItem:)
               replacement:@selector(rdp_tabView:shouldSelectTabViewItem:)
                  override:MLOverrideShouldSelect];
    
    //Allowable Identifiers
    //    [MessageLinks loadWith:originalClass
    //                          replacing:@selector(toolbarSelectableItemIdentifiers:)
    //                        replacement:@selector(rdp_toolbarSelectableItemIdentifiers:)
    //                           override:MLOverrideAllows];
    
    //ParseAndSetAttachments
    //[MessageLinks loadWith:originalClass replacing:@selector(_parseAndSetAttachments:) replacement:@selector(rdp_parseAndSetAttachments:) override:MLOverrideParseAndSetup];
    
    //Chat Items
    //[MessageLinks loadWith:originalClass replacing:@selector(_chatItemsChanged:) replacement:@selector(rdp_chatItemsChanged:) override:MLOverrideChatItem];
    
    //Represeted Objects
    //[MessageLinks loadWith:originalClass replacing:@selector(setRepresentedObject:) replacement:@selector(rdp_setRepresentedObject:) override:MLOverrideRepresentedObject];
}

+ (void)loadWith:(Class)originalClass replacing:(SEL)originalSelector replacement:(SEL)replacementSelector override:(MLOverride)override {
    Method originalMeth = class_getInstanceMethod(originalClass, originalSelector);
    switch (override) {
        case MLOverrideViewDidLoad:
            sOriginalImp = method_getImplementation(originalMeth);
            break;
        case MLOverrideViewDidAppear:
            sViewDidAppearImp = method_getImplementation(originalMeth);
            break;
        case MLOverrideShouldSelect:
            sShouldSelectImp = method_getImplementation(originalMeth);
            break;
        case MLOverrideDidSelect:
            sDidSelectImp = method_getImplementation(originalMeth);
            break;
        case MLOverrideParseAndSetup:
            sParseAndSetImp = method_getImplementation(originalMeth);
            break;
        case MLOverrideChatItem:
            sChatItemsChangedImp = method_getImplementation(originalMeth);
            break;
        case MLOverrideRepresentedObject:
            sRepresentedObjectImp = method_getImplementation(originalMeth);
            break;
        case MLOverrideAllows:
            sSelectableImp = method_getImplementation(originalMeth);
            break;
    }
    
    Method replacementMeth = class_getInstanceMethod(NSClassFromString(@"MessageLinks"), replacementSelector);
    method_exchangeImplementations(originalMeth, replacementMeth);
}

- (void)rdp_viewDidLoad {
    //Run Original Method
    sOriginalImp(self, @selector(viewDidLoad), self);
    
    //Fetch Variables
    SOAttachmentsTabViewController *controller = (SOAttachmentsTabViewController *)self;
    
    //NOTE: This timing delay does need to be here.
    // The ChatDisplayController does not always exist at this point.
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.25 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^(void){
        SOChatDisplayController *chatDisplayController = controller.chatDisplayController;
        
        //Set Up Third View Controller
        MLLinksViewController *linksViewController = [[MLLinksViewController alloc] initWithChat:chatDisplayController.chat];
        MLAttachmentsWrapperViewController *rdpViewController = [[MLAttachmentsWrapperViewController alloc] initWithRootViewController:linksViewController];
        
        //Set Up 3rd Item
        NSTabViewItem *item = [[NSTabViewItem alloc] initWithIdentifier:@"Links"];
        item.label = @"Links";
        item.viewController = (NSViewController *)rdpViewController;
        
        //Add Thirs Item
        [controller addTabViewItem:item];
    });
}

- (void)rdp_viewDidAppear {
    //Run Original Method
    sViewDidAppearImp(self, @selector(viewDidAppear), self);
    
    //NOTE: This timing delay does need to be here.
    // The ChatDisplayController has not always updated by this point for some reason.
    // We could potentially find another method to swizzle here
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, 0.2 * NSEC_PER_SEC), dispatch_get_main_queue(), ^{
        if ([self isKindOfClass:[SOAttachmentsTabViewController class]]) {
            SOAttachmentsTabViewController *controller = (SOAttachmentsTabViewController *)self;
            if ([[[[controller tabViewItems] lastObject] identifier] isEqualToString:@"Links"]) {
                NSTabViewItem *item = [[controller tabViewItems] lastObject];
                if ([item.viewController isKindOfClass:[MLAttachmentsWrapperViewController class]]) {
                    MLAttachmentsWrapperViewController *wrapper = (MLAttachmentsWrapperViewController *)item.viewController;
                    if ([wrapper.rootViewController isKindOfClass:[MLLinksViewController class]]) {
                        MLLinksViewController *linksViewController = (MLLinksViewController *)wrapper.rootViewController;
                        SOChatDisplayController *chatDisplayController = controller.chatDisplayController;
                        
                        [linksViewController setupWithChat:chatDisplayController.chat];
                    }
                }
            }
        }
    });
}

- (BOOL)rdp_tabView:(NSTabView *)tabView shouldSelectTabViewItem:(NSTabViewItem *)tabViewItem {
    if ([tabViewItem.viewController isKindOfClass:[MLAttachmentsWrapperViewController class]]) {
        MLAttachmentsWrapperViewController *wrapperViewController = (MLAttachmentsWrapperViewController *)tabViewItem.viewController;
        if ([wrapperViewController.rootViewController isKindOfClass:[MLLinksViewController class]]) {
            MLLinksViewController *linksViewController = (MLLinksViewController *)wrapperViewController.rootViewController;
            
            return linksViewController.links.count > 0;
        }
    }
    return sShouldSelectImp(self, @selector(tabView:didSelectTabViewItem:), self);
}

- (void)rdp_tabView:(NSTabView *)tabView didSelectTabViewItem:(NSTabViewItem *)tabViewItem {
    sDidSelectImp(self, @selector(tabView:didSelectTabViewItem:), self);
    
    //SOAttachmentsTabViewController *controller = (SOAttachmentsTabViewController *)self;
}

- (void)rdp_parseAndSetAttachments:(id)arg1 {
    sParseAndSetImp(self, @selector(_parseAndSetAttachments:), self);
    
    NSAlert *alert = [NSAlert alertWithMessageText:@"RDP Code has been injected!" defaultButton:@"OK" alternateButton:nil otherButton:nil informativeTextWithFormat:@"Parse Attachments:"];
    [alert runModal];
}

- (void)rdp_chatItemsChanged:(id)arg1 {
    sChatItemsChangedImp(self, @selector(_chatItemsChanged:), self);
    
    NSAlert *alert = [NSAlert alertWithMessageText:@"RDP Code has been injected!" defaultButton:@"OK" alternateButton:nil otherButton:nil informativeTextWithFormat:@"rdp_chatItemsChanged:"];
    [alert runModal];
}

- (void)rdp_setRepresentedObject:(id)arg1 {
    sRepresentedObjectImp(self, @selector(setRepresentedObject:), self);
    
    NSAlert *alert = [NSAlert alertWithMessageText:@"RDP Code has been injected!" defaultButton:@"OK" alternateButton:nil otherButton:nil informativeTextWithFormat:@"rdp_setRepresentedObject:"];
    [alert runModal];
}


@end
