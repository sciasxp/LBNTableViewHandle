# LBNTableViewHandle

[![CI Status](http://img.shields.io/travis/Luciano Bastos Nunes/LBNTableViewHandle.svg?style=flat)](https://travis-ci.org/Luciano Bastos Nunes/LBNTableViewHandle)
[![Version](https://img.shields.io/cocoapods/v/LBNTableViewHandle.svg?style=flat)](http://cocoapods.org/pods/LBNTableViewHandle)
[![License](https://img.shields.io/cocoapods/l/LBNTableViewHandle.svg?style=flat)](http://cocoapods.org/pods/LBNTableViewHandle)
[![Platform](https://img.shields.io/cocoapods/p/LBNTableViewHandle.svg?style=flat)](http://cocoapods.org/pods/LBNTableViewHandle)

## Usage

Include the file LBNTableViewHandle.h in your class:
```objective-c
#include LBNTableViewHandle.h
```

After that you need to create a global property to keed the reference that can be made this way:
```objective-c
@property (nonatomic, strong) LBNTableViewHandle *mainTableViewHandle;
```

And this is how you use it:
```objective-c
self.mainTableViewHandle = [[LBNTableViewHandle alloc] initWithItems:<NSARRAY WITH THE ITENS TO BE SHOWN IN THE TABLE VIEW> CellIdentifier:^NSString *(id item) {

return <RETURN CELL IDENTIFIER FOR AN ITEM>;

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

## Observations

You can use this class to simplefy your code in case you need to use tableview inside another tableview. Simple crete to instances of LBNTableViewHandle and attibute then to the respective table datasource and delegate.

## Installation

LBNTableViewHandle is available through [CocoaPods](http://cocoapods.org). To install
it, simply add the following line to your Podfile:

```ruby
pod "LBNTableViewHandle"
```

## Author

Luciano Bastos Nunes, sciasxp@gmail.com

## License

LBNTableViewHandle is available under the MIT license. See the LICENSE file for more info.
