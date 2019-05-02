//
//  MessageLinks.h
//  MessageLinks
//
//  Created by Rocco Del Priore on 5/1/19.
//  Copyright © 2019 Rocco Del Priore. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MessageLinks : NSObject

- (void)patchedShowAbout;

- (BOOL)rdp_tabView:(NSTabView *)tabView shouldSelectTabViewItem:(NSTabViewItem *)tabViewItem;

- (void)rdp_viewDidAppear;

- (void)rdp_tabView:(NSTabView *)tabView didSelectTabViewItem:(NSTabViewItem *)tabViewItem;

@end
