//
//  JLTextPickerView.m
//
//  Version 0.1.4
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
@property (strong, nonatomic) NSArray<NSArray <NSString *> *> *arrayOfStrings;
@property (copy, nonatomic) JLTextPickerViewResult resultBlock;
@property (copy, nonatomic) JLTextPickerViewMultiResult multiResultBlock;
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
        self.arrayOfStrings = @[strings];
        self.resultBlock = resultBlock;
        [view addSubview:self];
        
        [self.pickerView selectRow:currentIndex inComponent:0 animated:NO];
        [self showViewAnimated:YES];
    });
}

- (void)showMultiColumnsPicker:(NSArray <NSArray <NSString *> *> *)arrayOfString
                currentIndexes:(NSArray <NSNumber *> *)arrayOfCurrentIndex
                        onView:(UIView *)view
                   resultBlock:(JLTextPickerViewMultiResult)resultBlock {
    dispatch_async(dispatch_get_main_queue(), ^{
        self.frame = CGRectMake(0, 0, view.frame.size.width, view.frame.size.height);
        self.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
        self.arrayOfStrings = arrayOfString;
        self.multiResultBlock = resultBlock;
        [view addSubview:self];
        
        for(NSInteger i=0; i<arrayOfCurrentIndex.count; i++) {
            [self.pickerView selectRow:[arrayOfCurrentIndex[i] integerValue] inComponent:i animated:NO];
        }
        [self showViewAnimated:YES];
    });
}

#pragma mark - override

- (void)awakeFromNib
{
    [super awakeFromNib];
    [self updateViews];
//    [self hideViewAction];
}

- (void)traitCollectionDidChange:(UITraitCollection *)previousTraitCollection {
    [super traitCollectionDidChange:previousTraitCollection];
    [self updateViews];
}

#pragma mark - accessor




#pragma mark - private methods

- (void)updateViews {
    if (@available(iOS 12.0, *)) {
        if (self.traitCollection.userInterfaceStyle == UIUserInterfaceStyleDark) {
            self.bottomView.backgroundColor = UIColor.blackColor;
        } else {
            self.bottomView.backgroundColor = UIColor.whiteColor;
        }
    }
}
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
- (void)callbackWithSuccess:(BOOL)success {
    if(self.resultBlock) {
        NSInteger index = -1;
        NSString *name = nil;
        @try {
            index = [self.pickerView selectedRowInComponent:0];
            name = self.arrayOfStrings[0][index];
        }
        @catch (NSException *e) { NSLog(@"%@", e); }
        self.resultBlock(success, index, name);
    }
    if(self.multiResultBlock) {
        NSMutableArray *indexArray = [[NSMutableArray alloc] init];
        NSMutableArray *nameArray = [[NSMutableArray alloc] init];
        @try {
            for(NSInteger i=0; i<self.arrayOfStrings.count; i++) {
                NSInteger index = [self.pickerView selectedRowInComponent:i];
                NSString *name = self.arrayOfStrings[i][index];
                [indexArray addObject:@(index)];
                [nameArray addObject:name];
            }
        }
        @catch (NSException *e) { NSLog(@"%@", e); }
        self.multiResultBlock(success, indexArray, nameArray);
    }
}

#pragma mark - event

- (IBAction)backgroundTapped:(id)sender {
    [self callbackWithSuccess:NO];
    [self hideViewAnimated:YES];
}
- (IBAction)doneButtonTapped:(id)sender {
    [self callbackWithSuccess:YES];
    [self hideViewAnimated:YES];
}

#pragma mark - UIPickerViewDataSource, UIPickerViewDelegate

// returns the number of 'columns' to display.
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView {
    return self.arrayOfStrings.count;
}

// returns the # of rows in each component..
- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component {
    return self.arrayOfStrings[component].count;
}

- (nullable NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component {
    return self.arrayOfStrings[component][row];
}
- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component {

}

@end
