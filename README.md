# LBNTableViewHandle

[![CI Status](http://img.shields.io/travis/Luciano Bastos Nunes/LBNTableViewHandle.svg?style=flat)](https://travis-ci.org/Luciano Bastos Nunes/LBNTableViewHandle)
[![Version](https://img.shields.io/cocoapods/v/LBNTableViewHandle.svg?style=flat)](http://cocoapods.org/pods/LBNTableViewHandle)
[![License](https://img.shields.io/cocoapods/l/LBNTableViewHandle.svg?style=flat)](http://cocoapods.org/pods/LBNTableViewHandle)
[![Platform](https://img.shields.io/cocoapods/p/LBNTableViewHandle.svg?style=flat)](http://cocoapods.org/pods/LBNTableViewHandle)

## Installation

LBNTableViewHandle is available through CocoaPods](http://cocoapods.org). To install
simply add the following line to your Podfile:

```ruby
pod "LBNTableViewHandle"
```
## Whats new from version 0.0.3 to 0.1.0

Now you can pass an NSDictionary as item. And that dictionary may have multiple sections to it.

The default format for dictionary is:
```objective-c
@{@"sections":
    @[
        @{@"headerConfig":@{},
         @"items":@[id, id]
        }
    ]
};
```

###OBS
The old way to use this class passing a NSArray is still valid.

## Usage

Include the file LBNTableViewHandle.h in your class:
```objective-c
#import LBNTableViewHandle.h
```

After including LBNTableViewHandle.h in the class you will use it, you need to create a global property to keep reference to LBNTableViewHndle instance that can be made this way:
```objective-c
@property (nonatomic, strong) LBNTableViewHandle *mainTableViewHandle;
```

And this is how you can use it:
```objective-c
self.mainTableViewHandle = [[LBNTableViewHandle alloc] initWithItems:<NSARRAY WITH THE ITENS TO BE SHOWN IN THE TABLE VIEW OR A NSDICTIONARY WITH THE ABOVE FORMAT> CellIdentifier:^NSString *(id item) {

return <RETURN CELL IDENTIFIER,	AS IN YOUR TABLEVIEWCELL AT STORYBOARD, FOR AN ITEM>;

} ConfigureCell:^(id cell, id item, NSIndexPath *indexPath) {

<CONFIGURE YOUR CELL>

} DeleteCell:<NOT USED IN THIS VERSION KEEP IT NIL> HeightForItem:^CGFloat(id item) {

return <RETURN CELL HEIGHT FOR AN ITEM>;

} DidSelect:^(NSIndexPath *indexPath, id item) {

<WHAT TO DO WHEN A ITEM IS SELECTED IN THE LIST>

} ViewForSectionHeader:^UIView *(NSInteger section, id item) {

<CREATE AND RETURN THE VIEW THAT WILL BE A HEADER FOR THIS SECTION>

OBS: <<item>> is the content of headerConfig key

} HeightForHeader:^CGFloat(NSInteger section, id item) {

<RETURN THE HEIGHT FOR THIS SECTIONS HEADER>

OBS: <<item>> is the content of headerConfig key

}];

self.mainTableView.dataSource = self.mainTableViewHandle;
self.mainTableView.delegate = self.mainTableViewHandle;
```
OBS: Everything in between "<>" are instructions and have to be replaced by your code.

## Usage Example

```objective-c
#import LBNTableViewHandle.h

@interface MainViewController ()
	@property (nonatomic, week) IBOutlet UITableView *mainTableView;
	@property (nonatomic, strong) LBNTableViewHandle *mainTableViewHandle;
@end

@implementation MainViewController

- (void)viewDidLoad {

    NSDictionary *sections = 
    @{@"sections":
        @[
            @{@"headerConfig":@{@"title":@"Novidades"},
            @"items":@[@"Title 1", @"Title 2"]
            }
        ]
    };

	self.mainTableViewHandle = [[LBNTableViewHandle alloc] initWithItems:sections CellIdentifier:^NSString *(id item) {

		return @"MyCellIdentifier";

	} ConfigureCell:^(id cell, id item, NSIndexPath *indexPath) {

		UITableViewCell *cell = cell;
		cell.title = item[indexPath.row];

	} DeleteCell:nil HeightForItem:^CGFloat(id item) {

		return 44;

	} DidSelect:^(NSIndexPath *indexPath, id item) {

		

    } ViewForSectionHeader:^UIView *(NSInteger section, id item) {

        UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.mainTableView.frame.size.width, 24)];

        /* Create custom view to display section header... */
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(10, 5, self.mainTableView.frame.size.width, 18)];
        [label setFont:[UIFont boldSystemFontOfSize:12]];
        NSString *string = item[@"title"];

        [label setText:string];
        [view addSubview:label];
        [view setBackgroundColor:[UIColor colorWithRed:166/255.0 green:177/255.0 blue:186/255.0 alpha:1.0]]; //your background color...

        return view;

    } HeightForHeader:^CGFloat(NSInteger section, id item) {

        return 30.0f;
    }];
    
    self.enableDeselectOnDidSelect = YES;
	self.mainTableView.dataSource = self.mainTableViewHandle;
	self.mainTableView.delegate = self.mainTableViewHandle;
}

@end


```

## Observations

You can use this class to simplefy your code in case you need to use a tableview inside another tableview. Simply crete an instances of LBNTableViewHandle and attibute then to the respective table datasources and delegates.

## Author

Luciano Bastos Nunes, sciasxp@gmail.com

## License

LBNTableViewHandle is available under the MIT license. See the LICENSE file for more info.
