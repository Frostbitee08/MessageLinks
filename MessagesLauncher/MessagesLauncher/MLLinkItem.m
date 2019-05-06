//
//  MLLinkItem.m
//  MessagesLauncher
//
//  Created by Rocco Del Priore on 5/5/19.
//  Copyright © 2019 Rocco Del Priore. All rights reserved.
//

#import "MLLinkItem.h"
#import "MLLinkItemView.h"

@interface MLLinkItem ()
@property (nonatomic) MLLink *link;
@end

@implementation MLLinkItem

- (instancetype)initWithLink:(MLLink *)link target:(nullable id)target action:(nullable SEL)selector keyEquivalent:(NSString *)charCode {
    self = [super initWithTitle:link.url.absoluteString action:selector keyEquivalent:charCode];
    if (self) {
        //Initialize Local Variables
        MLLinkItemView *contentView = [[MLLinkItemView alloc] initWithFrame:NSMakeRect(0, 0, [MLLinkItemView intrinsicContentSize].width, [MLLinkItemView intrinsicContentSize].height)];
        NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
        
        //Set Properties
        [formatter setDateFormat:@"MMM d, h:mm a"];
        [contentView.dateTextField setStringValue:[formatter stringFromDate:link.date]];
        if (link.imageFileUrl) {
            [contentView.linkImageView setImage:[[NSImage alloc] initWithContentsOfFile:link.imageFileUrl.path]];
        }
        else {
            [contentView.linkImageView setImage:nil];
        }
        if (link.title) {
            [contentView.titleTextField setStringValue:link.title];
        }
        else {
            [contentView.titleTextField setStringValue:[link.url absoluteString]];
        }
        if (link.siteName) {
            [contentView.subtitleTextField setStringValue:link.siteName];
        }
        else {
            [contentView.subtitleTextField setStringValue:link.url.host];
        }
        
        //Set Instance Variables
        [self setLink:link];
        [self setTarget:target];
        [self setView:contentView];
    }
    return self;
}

@end
