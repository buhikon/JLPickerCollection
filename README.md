# JLPickerCollection

[![CI Status](http://img.shields.io/travis/Joey Lee/JLPickerCollection.svg?style=flat)](https://travis-ci.org/Joey Lee/JLPickerCollection)
[![Version](https://img.shields.io/cocoapods/v/JLPickerCollection.svg?style=flat)](http://cocoapods.org/pods/JLPickerCollection)
[![License](https://img.shields.io/cocoapods/l/JLPickerCollection.svg?style=flat)](http://cocoapods.org/pods/JLPickerCollection)
[![Platform](https://img.shields.io/cocoapods/p/JLPickerCollection.svg?style=flat)](http://cocoapods.org/pods/JLPickerCollection)

## Example

To run the example project, clone the repo, and run `pod install` from the Example directory first.

## Requirements

## Installation

JLPickerCollection is available through [CocoaPods](http://cocoapods.org). To install
it, simply add the following line to your Podfile:

```ruby
pod "JLPickerCollection"
```

## Usage
```
JLDatePickerView *picker = [JLDatePickerView instance];
picker.datePicker.datePickerMode = UIDatePickerModeTime;
picker.datePicker.minuteInterval = 30;
[picker showPickerViewWithDate:[NSDate date]
minDate:nil
maxDate:nil
onView:self.view
resultBlock:^(BOOL success, NSDate *date) {
NSLog(@"success : %d, date : %@", success, date);
}];
```

```
[[JLTextPickerView instance] showPickerView:@[@"AAA",@"BBB",@"ccc",@"111",@"567"]
currentIndex:2
onView:self.view
resultBlock:^(BOOL success, NSInteger index, NSString *name) {
NSLog(@"success : %d, index : %d, name : %@", success, (int)index, name);
}];
```

## Demo

[![](https://raw.github.com/buhikon/JLPickerCollection/master/demo.gif)](https://raw.github.com/buhikon/JLPickerCollection/master/demo.gif)

## Author

Joey Lee, slarinz@gmail.com

## License

JLPickerCollection is available under the MIT license. See the LICENSE file for more info.
