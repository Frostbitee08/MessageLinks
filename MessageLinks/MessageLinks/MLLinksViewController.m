//
//  MLLinksViewController.m
//  CalculatorOverrides
//
//  Created by Rocco Del Priore on 4/28/19.
//  Copyright © 2019 Alexandre Colucci. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <Masonry/Masonry.h>

#include <LinkPresentation/LPLinkMetadata.h>
#include <IMCore/IMAttachment.h>
#include <IMCore/IMMessageChatItem.h>
#include <IMCore/IMMessage.h>
#include <IMCore/IMChat.h>

#import "MLLinksViewController.h"
#import "MLLinkAttachmentCellView.h"

@interface MLLinksViewController () <NSTableViewDataSource, NSTableViewDelegate>
@property (nonatomic, retain) NSArray<MLLink *> *links;
@property (nonatomic) NSTableView *tableView;
@property (nonatomic) NSTableColumn *column;
@end

@implementation MLLinksViewController

- (instancetype)initWithChat:(IMChat *)chat {
    self = [self init];
    if (self) {
        [self setupWithChat:chat];
    }
    return self;
}

- (instancetype)init {
    self = [super init];
    if (self) {
        self.view      = [[NSView alloc] init];
        self.links     = [[NSArray alloc] init];
        self.column    = [[NSTableColumn alloc] initWithIdentifier:@"ColumnOne"];
        self.tableView = [[NSTableView alloc] init];
     
        [self.column setWidth:300];
        [self.tableView addTableColumn:self.column];
        [self.tableView setDataSource:self];
        [self.tableView setDelegate:self];
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view.layer setBackgroundColor:[NSColor clearColor].CGColor];
    [self.view addSubview:self.tableView positioned:NSWindowAbove relativeTo:nil];
}

- (void)viewDidAppear {
    [super viewDidAppear];
    
    //Add TableView if Needed (Somestimes it's removed 🤷‍♂️)
    if (![self.view.subviews containsObject:self.tableView]) {
        [self.view addSubview:self.tableView positioned:NSWindowAbove relativeTo:nil];
    }
    
    //Set Constraints
    [self.tableView mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view);
    }];
    
    //Update Column's Width
    [self.column setWidth:self.view.bounds.size.width];
    
    //Hide Background Color
    [self.tableView setBackgroundColor:[NSColor clearColor]];
}

- (void)setupWithChat:(IMChat *)chat {
    //Declare Variables
    NSError *error;
    NSArray *links = [[MLChatDatabaseManager sharedInstance] linksForChat:chat error:&error];
    
    //Set New URLs
    self.links = [[NSArray alloc] initWithArray:links copyItems:true];
    
    //Reload Data
    [self.tableView reloadData];

    //Update our height
    CGFloat height = [self tableView:self.tableView heightOfRow:0]*self.links.count;
    [self.tableView.superview mas_updateConstraints:^(MASConstraintMaker *make) {
        make.height.equalTo(@(height));
    }];
}

#pragma mark - NSTableView Datasource

- (NSInteger)numberOfRowsInTableView:(NSTableView *)tableView {
    return self.links.count;
}

#pragma mark - NSTableView Delegate

- (CGFloat)tableView:(NSTableView *)tableView heightOfRow:(NSInteger)row {
    return 100;
}

- (NSView *)tableView:(NSTableView *)tableView viewForTableColumn:(NSTableColumn *)tableColumn row:(NSInteger)row {
    // Get an existing cell with the MyView identifier if it exists
    MLLinkAttachmentCellView *result = (MLLinkAttachmentCellView *)[tableView makeViewWithIdentifier:@"MLLinkAttachmentCellView" owner:self];
    
    // There is no existing cell to reuse so create a new one
    if (result == nil) {
        result = [[MLLinkAttachmentCellView alloc] initWithFrame:NSZeroRect];
        result.identifier = @"MLLinkAttachmentCellView";
    }
    
    //Initialize Variables
    MLLink *link = self.links[row];
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"MMM d, yyyy h:mm a"];
    
    //Set Properties
    if (link.imageFileUrl) {
        [result.linkImageView setImage:[[NSImage alloc] initWithContentsOfFile:link.imageFileUrl.path]];
    }
    else {
        [result.linkImageView setImage:nil];
    }
    if (link.title) {
        [result.titleTextField setStringValue:link.title];
        if (link.siteName) {
            [result.subtitleTextField setStringValue:link.siteName];
        }
        else {
            [result.subtitleTextField setStringValue:link.url.host];
        }
    }
    else {
        [result.titleTextField setStringValue:[link.url absoluteString]];
    }
    [result.dateTextField setStringValue:[formatter stringFromDate:link.date]];
    
    return result;
    
}

- (void)tableViewSelectionDidChange:(NSNotification *)notification {
    //Fetch URL
    NSURL *url = self.links[[self.tableView selectedRow]].url;
    
    //Open in the browser
    [[NSWorkspace sharedWorkspace] openURL:url];
    
    //Deselect Row
    [self.tableView deselectRow:[self.tableView selectedRow]];
}

@end
