//
//  JLDatePickerView.m
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

#import "JLDatePickerView.h"

@interface JLDatePickerView ()
@property (weak, nonatomic) IBOutlet UIControl *backgroundControl;
@property (weak, nonatomic) IBOutlet UIView *bottomView;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *bottomViewBottomSpacing;
@property (weak, nonatomic) IBOutlet UIDatePicker *datePicker_;

@property (strong, nonatomic) NSArray<NSString *> *dataArray;
@property (copy, nonatomic) JLDatePickerViewResult resultBlock;
@end

@implementation JLDatePickerView

+ (instancetype)instance
{
    @try {
        Class class = [self class];
        return [[NSBundle bundleForClass:class] loadNibNamed:NSStringFromClass(class) owner:nil options:nil][0];
    }
    @catch (NSException *exception) {
        NSLog(@"%@", exception);
        return nil;
    }
}


+ (NSString*)bundlePathForPod:(NSString*)podName
{
    // search all bundles
    for (NSBundle* bundle in [NSBundle allBundles]) {
        NSString* bundlePath = [bundle pathForResource:podName ofType:@"bundle"];
        if (bundlePath) { return bundlePath; }
    }
    
    // search all frameworks
    for (NSBundle* bundle in [NSBundle allBundles]) {
        NSArray* bundles = [self recursivePathsForResourcesOfType:@"bundle" name:podName inDirectory:[bundle bundlePath]];
        if (bundles.count > 0) {
            return bundles.firstObject;
        }
    }
    // some pods do not use "resource_bundles"
    // please check the pod's podspec
    return nil;
}
+ (NSArray *)recursivePathsForResourcesOfType:(NSString *)type name:(NSString*)name inDirectory:(NSString *)directoryPath
{
    
    NSMutableArray *filePaths = [[NSMutableArray alloc] init];
    NSDirectoryEnumerator *enumerator = [[NSFileManager defaultManager] enumeratorAtPath:directoryPath];
    
    NSString *filePath;
    
    while ((filePath = [enumerator nextObject]) != nil){
        if (!type || [[filePath pathExtension] isEqualToString:type]){
            if (!name || [[[filePath lastPathComponent] stringByDeletingPathExtension] isEqualToString:name]){
                [filePaths addObject:[directoryPath stringByAppendingPathComponent:filePath]];
            }
        }
    }
    
    return filePaths;
}

#pragma mark  public methods

- (void)showPickerViewWithDate:(NSDate *)selectedDate
                       minDate:(NSDate *)minDate
                       maxDate:(NSDate *)maxDate
                        onView:(UIView *)view
                   resultBlock:(JLDatePickerViewResult)resultBlock {
    
    dispatch_async(dispatch_get_main_queue(), ^{
        if(selectedDate) {
            self.datePicker_.date = selectedDate;
        }
        else {
            self.datePicker_.date = [NSDate date];
        }
        self.datePicker_.minimumDate = minDate;
        self.datePicker_.maximumDate = maxDate;
        self.frame = CGRectMake(0, 0, view.frame.size.width, view.frame.size.height);
        self.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
        self.resultBlock = resultBlock;
        [view addSubview:self];
        
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

- (UIDatePicker *)datePicker {
    return self.datePicker_;
}

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
        self.resultBlock(NO, self.datePicker_.date);
    }
    [self hideViewAnimated:YES];
}
- (IBAction)doneButtonTapped:(id)sender {
    if(self.resultBlock) {
        self.resultBlock(YES, self.datePicker_.date);
    }
    [self hideViewAnimated:YES];
}

- (IBAction)datePickerValueDidChanged:(UIDatePicker *)sender {
}



@end
