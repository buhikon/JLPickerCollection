//
//  JLViewController.m
//  JLPickerCollection
//
//  Created by Joey Lee on 01/05/2017.
//  Copyright (c) 2017 Joey Lee. All rights reserved.
//

#import "JLViewController.h"
#import "JLPickerCollection.h"

@interface JLViewController ()
@property (strong, nonatomic) NSArray *data;
@end

@implementation JLViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.data = @[
                  @[@"time picker",@"showTimePicker"],
                  @[@"time picker (locale KR)",@"showTimePickerWithLocaleKR"],
                  @[@"time picker (interval 30)",@"showTimePickerWithInterval"],
                  @[@"date picker",@"showDatePicker"],
                  @[@"date and time picker",@"showDateAndTimePicker"],
                  @[@"date and time picker (locale JP)",@"showDateAndTimePickerWithLocaleJP"],
                  @[@"text picker",@"showTextPicker"],
                  ];
}

#pragma mark - private methods

- (void)showTimePicker {
    JLDatePickerView *picker = [JLDatePickerView instance];
    picker.datePicker.datePickerMode = UIDatePickerModeTime;
    [picker showPickerViewWithDate:[NSDate date]
                           minDate:nil
                           maxDate:nil
                            onView:self.view
                       resultBlock:^(BOOL success, NSDate *date) {
                           NSLog(@"success : %d, date : %@", success, date);
                       }];
}
- (void)showTimePickerWithLocaleKR {
    JLDatePickerView *picker = [JLDatePickerView instance];
    picker.datePicker.datePickerMode = UIDatePickerModeTime;
    picker.datePicker.locale = [[NSLocale alloc] initWithLocaleIdentifier:@"ko_KR_POSIX"];
    [picker showPickerViewWithDate:[NSDate date]
                           minDate:nil
                           maxDate:nil
                            onView:self.view
                       resultBlock:^(BOOL success, NSDate *date) {
                           NSLog(@"success : %d, date : %@", success, date);
                       }];
}
- (void)showTimePickerWithInterval {
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
}


- (void)showDatePicker {
    JLDatePickerView *picker = [JLDatePickerView instance];
    picker.datePicker.datePickerMode = UIDatePickerModeDate;
    [picker showPickerViewWithDate:[NSDate date]
                           minDate:nil
                           maxDate:nil
                            onView:self.view
                       resultBlock:^(BOOL success, NSDate *date) {
                           NSLog(@"success : %d, date : %@", success, date);
                       }];
}
- (void)showDateAndTimePicker {
    JLDatePickerView *picker = [JLDatePickerView instance];
    picker.datePicker.datePickerMode = UIDatePickerModeDateAndTime;
    picker.datePicker.locale = [[NSLocale alloc] initWithLocaleIdentifier:@"ko_KR_POSIX"];
    [picker showPickerViewWithDate:[NSDate date]
                           minDate:nil
                           maxDate:nil
                            onView:self.view
                       resultBlock:^(BOOL success, NSDate *date) {
                           NSLog(@"success : %d, date : %@", success, date);
                       }];
}
- (void)showDateAndTimePickerWithLocaleJP {
    JLDatePickerView *picker = [JLDatePickerView instance];
    picker.datePicker.datePickerMode = UIDatePickerModeDateAndTime;
    picker.datePicker.locale = [[NSLocale alloc] initWithLocaleIdentifier:@"ja_JP_POSIX"];
    [picker showPickerViewWithDate:[NSDate date]
                           minDate:nil
                           maxDate:nil
                            onView:self.view
                       resultBlock:^(BOOL success, NSDate *date) {
                           NSLog(@"success : %d, date : %@", success, date);
                       }];
}

- (void)showTextPicker {
    [[JLTextPickerView instance] showPickerView:@[@"AAA",@"BBB",@"ccc",@"111",@"567"]
                                   currentIndex:2
                                         onView:self.view
                                    resultBlock:^(BOOL success, NSInteger index, NSString *name) {
                                        NSLog(@"success : %d, index : %d, name : %@", success, (int)index, name);
                                    }];
}

//=====================================================================================================

#pragma mark - UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.data.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell"];
    if(!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"Cell"];
    }
    cell.textLabel.text = self.data[indexPath.row][0];
    return cell;
}

#pragma mark - UITableViewDelegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    NSString *action = self.data[indexPath.row][1];
    SEL selector = NSSelectorFromString(action);
    
    if([self respondsToSelector:selector]) {
        NSInvocation *inv = [NSInvocation invocationWithMethodSignature:[self methodSignatureForSelector:selector]];
        [inv setTarget:self];
        [inv setSelector:selector];
        [inv invoke];
    }
}

@end
