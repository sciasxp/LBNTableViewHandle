//
//  TableViewDataSource.h
//  Dicas GP
//
//  Created by Luciano Bastos Nunes on 04/09/14.
//  Copyright (c) 2014 Tap4Mobile. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TableViewDataSource : NSObject <UITableViewDataSource, UITableViewDelegate, UISearchBarDelegate>

@property (nonatomic, strong) NSArray *items;

- (instancetype)initWithItems:(NSArray *)items CellIdentifier:(NSString * (^)(id item))cellIdentifier ConfigureCell:(void (^)(id cell, id item, NSIndexPath *indexPath))configureCellBlock DeleteCell:(void (^)(UITableView *tableView, NSIndexPath *indexPath, id item))deleteCellBlock HeightForItem:(CGFloat (^)(id item))heightCellBlock DidSelect:(void (^)(NSIndexPath *indexPath, id item))didSelectCellBlock NS_DESIGNATED_INITIALIZER;

@end
