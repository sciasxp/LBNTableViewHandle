//
//  TableViewDataSource.h
//
//  Created by Luciano Bastos Nunes on 04/09/14.
//  Copyright (c) 2014 Tap4Mobile. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LBNTableViewHandle : NSObject <UITableViewDataSource, UITableViewDelegate, UISearchBarDelegate>

@property (nonatomic, strong) id<NSFastEnumeration> items;
@property (nonatomic, readwrite) bool enableDeselectOnDidSelect;

- (instancetype)initWithItems:(id<NSFastEnumeration>)items CellIdentifier:(NSString * (^)(id item))cellIdentifier ConfigureCell:(void (^)(id cell, id item, NSIndexPath *indexPath))configureCellBlock DeleteCell:(void (^)(UITableView *tableView, NSIndexPath *indexPath, id item))deleteCellBlock HeightForItem:(CGFloat (^)(id item))heightCellBlock DidSelect:(void (^)(NSIndexPath *indexPath, id item))didSelectCellBlock ViewForSectionHeader:(UIView * (^)(NSInteger section, id item))viewForSectionHeader HeightForHeader:(CGFloat (^)(NSInteger, id))heightForHeader NS_DESIGNATED_INITIALIZER;

@end