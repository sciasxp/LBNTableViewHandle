//
//  TableViewDataHandler.m
//  Dicas GP
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

@end

@implementation LBNTableViewHandle

- (instancetype)initWithItems:(NSArray *)items
                CellIdentifier:(NSString * (^)(id item))cellIdentifier
                ConfigureCell:(void (^)(id cell, id item, NSIndexPath *indexPath))configureCellBlock
                DeleteCell:(void (^)(UITableView *tableView, NSIndexPath *indexPath, id item))deleteCellBlock
                HeightForItem:(CGFloat (^)(id item))heightCellBlock
                DidSelect:(void (^)(NSIndexPath *indexPath, id item))didSelectCellBlock
{
    self = [super init];
    
    if (self) {
        
        _items = items;
        _cellIdentifierForItem = cellIdentifier;
        _configureCellBlock = configureCellBlock;
        _deleteCellBlock = deleteCellBlock;
        _heightForItem = heightCellBlock;
        _didSelectCellBlock = didSelectCellBlock;
    }
    
    return self;
}

- (instancetype)init {
    
    self = [self initWithItems:nil CellIdentifier:nil ConfigureCell:nil DeleteCell:nil HeightForItem:nil DidSelect:nil];
    
    return self;
}

#pragma mark - Private

- (id)itemAtIndexPath:(NSIndexPath*)indexPath {
    
    return self.items[(NSUInteger)indexPath.row];
}

#pragma mark - TableViewDataSource

- (NSInteger)tableView:(UITableView*)tableView numberOfRowsInSection:(NSInteger)section {
    
    return self.items.count;
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

- (void)tableView:(nonnull UITableView *)tableView didSelectRowAtIndexPath:(nonnull NSIndexPath *)indexPath {
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
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
