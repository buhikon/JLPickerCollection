//
//  JLDatePickerView.h
//
//  Version 0.1.2
//
//  Created by Joey L. Feb/18/2016.
//  Copyright (c) 2016 Joey L. All rights reserved.
//
//  https://github.com/buhikon/JLPickerCollection
//

#import <UIKit/UIKit.h>

typedef void(^JLDatePickerViewResult)(BOOL success, NSDate *date);

@interface JLDatePickerView : UIView

@property (readonly) UIDatePicker *datePicker;

+ (instancetype)instance;

- (void)showPickerViewWithDate:(NSDate *)selectedDate
                       minDate:(NSDate *)minDate
                       maxDate:(NSDate *)maxDate
                        onView:(UIView *)view
                   resultBlock:(JLDatePickerViewResult)resultBlock;

@end
