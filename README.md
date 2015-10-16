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
self.mainTableViewHandle = [[LBNTableViewHandle alloc] initWithItems:<NSARRAY WITH THE ITENS TO BE SHOWN IN THE TABLE VIEW> CellIdentifier:^NSString *(id item) {

return <RETURN CELL IDENTIFIER,	AS IN YOUR TABLEVIEWCELL AT STORYBOARD, FOR AN ITEM>;

} ConfigureCell:^(id cell, id item, NSIndexPath *indexPath) {

<CONFIGURE YOUR CELL>

} DeleteCell:<NOT USED IN THIS VERSION KEEP IT NIL> HeightForItem:^CGFloat(id item) {

return <RETURN CELL HEIGHT FOR AN ITEM>;

} DidSelect:^(NSIndexPath *indexPath, id item) {

<WHAT TO DO WHEN A ITEM IS SELECTED IN THE LIST>

}];

self.mainTableView.dataSource = self.mainTableViewHandle;
self.mainTableView.delegate = self.mainTableViewHandle;
```
OBS: Everything in between "<>" are instructions and have to be replaced by your code.

## Usage Example

```objective-c
#import LBNTableViewHandle.h

@interface MainTableViewController ()
	@property (nonatomic, week) IBOutlet UITableView *mainTableView;
	@property (nonatomic, strong) LBNTableViewHandle *mainTableViewHandle;
@end

@implementation MainViewController

- (void)viewDidLoad {

	self.mainTableViewHandle = [[LBNTableViewHandle alloc] initWithItems:@[@"Title 1", @"Title 2"] CellIdentifier:^NSString *(id item) {

		return @"MyCellIdentifier";

	} ConfigureCell:^(id cell, id item, NSIndexPath *indexPath) {

		UITableViewCell *cell = cell;
		cell.title = item[indexPath.row];

	} DeleteCell:nil HeightForItem:^CGFloat(id item) {

		return 44;

	} DidSelect:^(NSIndexPath *indexPath, id item) {

		[tableView deselectRowAtIndexPath:indexPath animated:YES];

	}];

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
