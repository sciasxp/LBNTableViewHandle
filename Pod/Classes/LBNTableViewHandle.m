//
//  TableViewDataHandler.m
//
//  Created by Luciano Bastos Nunes on 04/09/14.
//  Copyright (c) 2014 Tap4Mobile. All rights reserved.
//

#import "LBNTableViewHandle.h"

@interface LBNTableViewHandle ()

@property (nonatomic, strong) void (^configureCellBlock) (id, NSDictionary *, NSIndexPath *);
@property (nonatomic, strong) void (^deleteCellBlock) (UITableView *, NSIndexPath *, NSDictionary *);
@property (nonatomic, strong) NSString * (^cellIdentifierForItem) (id);
@property (nonatomic, strong) CGFloat (^heightForItem) (id);
@property (nonatomic, strong) void (^didSelectCellBlock) (NSIndexPath *, id);
@property (nonatomic, strong) UIView * (^viewForHeader)(NSInteger, id);
@property (nonatomic, strong) CGFloat (^heightForHeader) (NSInteger, id);
@end

/*
 NSDictionary *sections = @{@"sections":@[@{@"headerConfig":@{},
 @"items":@[@"item 1", @"item 2"]}]};
 */

@implementation LBNTableViewHandle

- (instancetype)initWithItems:(id<NSFastEnumeration>)items
               CellIdentifier:(NSString * (^)(id item))cellIdentifier
                ConfigureCell:(void (^)(id cell, id item, NSIndexPath *indexPath))configureCellBlock
                   DeleteCell:(void (^)(UITableView *tableView, NSIndexPath *indexPath, id item))deleteCellBlock
                HeightForItem:(CGFloat (^)(id item))heightCellBlock
                    DidSelect:(void (^)(NSIndexPath *indexPath, id item))didSelectCellBlock
         ViewForSectionHeader:(UIView * (^)(NSInteger section, id item))viewForSectionHeader
              HeightForHeader:(CGFloat (^)(NSInteger, id))heightForHeader
{
    self = [super init];
    
    if (self) {
        
        _items = items;
        _cellIdentifierForItem = cellIdentifier;
        _configureCellBlock = configureCellBlock;
        _deleteCellBlock = deleteCellBlock;
        _heightForItem = heightCellBlock;
        _didSelectCellBlock = didSelectCellBlock;
        _viewForHeader = viewForSectionHeader;
        _heightForHeader = heightForHeader;
    }
    
    return self;
}

- (instancetype)init {
    
    self = [self initWithItems:nil CellIdentifier:nil ConfigureCell:nil DeleteCell:nil HeightForItem:nil DidSelect:nil ViewForSectionHeader:nil HeightForHeader:nil];
    
    return self;
}

#pragma mark - Private

- (id)itemAtIndexPath:(NSIndexPath*)indexPath {
    
    if ([(NSObject *)self.items isKindOfClass:[NSArray class]]) {
        
        return self.items[indexPath.row];
        
    } else {
        
        return self.items[@"sections"][indexPath.section][@"items"][indexPath.row];
    }
}

#pragma mark - TableViewDataSource

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    
    if (self.viewForHeader) {
        
        id item = self.items[@"sections"][section][@"headerConfig"];
        
        if ([[item allKeys] count]) {
            
            UIView *view = self.viewForHeader(section, item);
            
            return view;
        }
    }
    
    return nil;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    if ([(NSObject *)self.items isKindOfClass:[NSArray class]]) {
        
        return 1;
    }
    
    return [self.items[@"sections"] count];
}

- (NSInteger)tableView:(UITableView*)tableView numberOfRowsInSection:(NSInteger)section {
    
    if ([(NSObject *)self.items isKindOfClass:[NSArray class]]) {
        
        return [(NSArray *)self.items count];
    }
    
    return [self.items[@"sections"][section][@"items"] count];
}

- (UITableViewCell*)tableView:(UITableView*)tableView cellForRowAtIndexPath:(NSIndexPath*)indexPath {
    
    id item = [self itemAtIndexPath:indexPath];
    
    NSString *cellIdentifier = self.cellIdentifierForItem(item);
    
    id cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier
                                              forIndexPath:indexPath];
    
    
    if (self.configureCellBlock) {
        
        self.configureCellBlock(cell, item, indexPath);
    }
    
    return cell;
}

//- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
//
//    if (editingStyle == UITableViewCellEditingStyleDelete) {
//        // Delete the row from the data source
//
//        if (self.deleteCellBlock) {
//
//            self.deleteCellBlock(tableView, indexPath, (self.items)[indexPath.row]);
//        }
//    }
//    else if (editingStyle == UITableViewCellEditingStyleInsert) {
//        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
//    }
//}

#pragma mark - TableViewDelegate

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    CGFloat height = 44.0;
    
    if (self.heightForItem) {
        
        id item = [self itemAtIndexPath:indexPath];
        
        height = self.heightForItem(item);
        
    }
    
    return height;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    
    CGFloat height = 0.0f;
    
    NSDictionary *item = self.items[@"sections"][section][@"headerConfig"];
    
    if (self.heightForHeader) {
        
        height = self.heightForHeader(section, item);
    }
    
    return height;
}

- (void)tableView:(nonnull UITableView *)tableView didSelectRowAtIndexPath:(nonnull NSIndexPath *)indexPath {
    
    if (self.enableDeselectOnDidSelect) {
        
        [tableView deselectRowAtIndexPath:indexPath animated:YES];
    }
    
    if (self.didSelectCellBlock) {
        
        id item = [self itemAtIndexPath:indexPath];
        
        self.didSelectCellBlock(indexPath, item);
    }
}

#pragma mark - SearchBar Delegate Methods
/*
 -(void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText {
 [self filterContentForSearchText:searchText];
 }
 
 -(void)searchBarCancelButtonClicked:(UISearchBar *)searchBar {
 searchBar.text = @"";
 tableViewData = [originalTableViewData mutableCopy];
 [self.myTableView reloadData];
 
 [searchBar resignFirstResponder];
 }
 
 -(void)searchBarTextDidEndEditing:(UISearchBar *)searchBar {
 [searchBar resignFirstResponder];
 }
 
 - (void)filterContentForSearchText:(NSString *)searchText {
 if (searchText && searchText.length) {
 [tableViewData removeAllObjects];
 
 for (NSDictionary *dictionary in originalTableViewData)
 {
 for (NSString *thisKey in [dictionary allKeys]) {
 if ([thisKey isEqualToString:@"SearchKey1"] ||
 [thisKey isEqualToString:@"SearchKey2"] ) {
 
 if ([[dictionary valueForKey:thisKey] rangeOfString:searchText
 options:NSCaseInsensitiveSearch].location != NSNotFound) {
 [tableViewData addObject:dictionary];
 } // for (NSString *thisKey in allKeys)
 
 } // if ([thisKey isEqualToString:@"SearchKey1"] || ...
 } // for (NSString *thisKey in [dictionary allKeys])
 } // for (NSDictionary *dictionary in originalTableViewData)
 
 [self.myTableView reloadData];
 
 } // if (query && query.length)
 }
 */

@end
