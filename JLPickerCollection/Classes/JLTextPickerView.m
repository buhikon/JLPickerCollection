//
//  JLTextPickerView.m
//
//  Version 0.1.1
//
//  Created by Joey L. Feb/18/2016.
//  Copyright (c) 2016 Joey L. All rights reserved.
//
//  https://github.com/buhikon/JLPickerCollection
//
#if ! __has_feature(objc_arc)
#error This file must be compiled with ARC. Either turn on ARC for the project or use -fobjc-arc flag
#endif

#import "JLTextPickerView.h"

@interface JLTextPickerView ()
@property (weak, nonatomic) IBOutlet UIControl *backgroundControl;
@property (weak, nonatomic) IBOutlet UIView *bottomView;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *bottomViewBottomSpacing;
@property (weak, nonatomic) IBOutlet UIPickerView *pickerView;
@property (strong, nonatomic) NSArray<NSString *> *dataArray;
@property (copy, nonatomic) JLTextPickerViewResult resultBlock;
@end

@implementation JLTextPickerView


+ (instancetype)instance
{
    @try {
        Class class = [self class];
        return [[NSBundle bundleForClass:class] loadNibNamed:NSStringFromClass(class) owner:nil options:nil][0];
    }
    @catch (NSException *exception) {
        return nil;
    }
}

#pragma mark  public methods

- (void)showPickerView:(NSArray<NSString *> *)strings
          currentIndex:(NSInteger)currentIndex
                onView:(UIView *)view
           resultBlock:(JLTextPickerViewResult)resultBlock {
    
    dispatch_async(dispatch_get_main_queue(), ^{
        self.frame = CGRectMake(0, 0, view.frame.size.width, view.frame.size.height);
        self.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
        self.dataArray = strings;
        self.resultBlock = resultBlock;
        [view addSubview:self];
        
        [self.pickerView selectRow:currentIndex inComponent:0 animated:NO];
        [self showViewAnimated:YES];
    });
}

#pragma mark - override

- (void)awakeFromNib
{
    [super awakeFromNib];
    
//    [self hideViewAction];
}

#pragma mark - accessor




#pragma mark - private methods

- (void)showView {
    [self showViewAnimated:NO];
}
- (void)showViewAnimated:(BOOL)animated {
    
    [self hideViewAction];
    
    [UIView animateWithDuration:0.3
                          delay:0.0
                        options:UIViewAnimationOptionCurveEaseInOut
                     animations:^{
                         [self showViewAction];
                     }
                     completion:^(BOOL finished) {
                         
                     }];
}
- (void)showViewAction {
    self.backgroundControl.alpha = 1.0;
    self.bottomViewBottomSpacing.constant = 0.0;
    [self setNeedsLayout];
    [self layoutIfNeeded];
}
- (void)hideView {
    [self hideViewAnimated:NO];
}
- (void)hideViewAnimated:(BOOL)animated {
    [UIView animateWithDuration:0.3
                          delay:0.0
                        options:UIViewAnimationOptionCurveEaseInOut
                     animations:^{
                         [self hideViewAction];
                     }
                     completion:^(BOOL finished) {
                         [self removeFromSuperview];
                     }];
}
- (void)hideViewAction {
    self.backgroundControl.alpha = 0.0;
    self.bottomViewBottomSpacing.constant = self.bottomView.frame.size.height * (-1.0);
    [self setNeedsLayout];
    [self layoutIfNeeded];
}

#pragma mark - event

- (IBAction)backgroundTapped:(id)sender {
    if(self.resultBlock) {
//        self.resultBlock(NO, -1, nil);
        
        NSInteger index = -1;
        NSString *name = nil;
        @try {
            index = [self.pickerView selectedRowInComponent:0];
            name = self.dataArray[index];
        }
        @catch (NSException *e) { NSLog(@"%@", e); }
        self.resultBlock(NO, index, name);
    }
    [self hideViewAnimated:YES];
}
- (IBAction)doneButtonTapped:(id)sender {
    if(self.resultBlock) {
        NSInteger index = [self.pickerView selectedRowInComponent:0];
        NSString *name = nil;
        @try {
            name = self.dataArray[index];
        }
        @catch (NSException *e) { NSLog(@"%@", e); }
        self.resultBlock(YES, index, name);
    }
    [self hideViewAnimated:YES];
}

#pragma mark - UIPickerViewDataSource, UIPickerViewDelegate

// returns the number of 'columns' to display.
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView {
    return 1;
}

// returns the # of rows in each component..
- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component {
    return self.dataArray.count;
}

- (nullable NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component {
    return self.dataArray[row];
}
- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component {

}

@end
