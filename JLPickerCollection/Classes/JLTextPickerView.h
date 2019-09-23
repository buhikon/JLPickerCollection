//
//  JLTextPickerView.h
//
//  Version 0.1.4
//
//  Created by Joey L. Feb/18/2016.
//  Copyright (c) 2016 Joey L. All rights reserved.
//
//  https://github.com/buhikon/JLPickerCollection
//

#import <UIKit/UIKit.h>

typedef void(^JLTextPickerViewResult)(BOOL success, NSInteger index, NSString *name);
typedef void(^JLTextPickerViewMultiResult)(BOOL success, NSArray<NSNumber *> *indexArray, NSArray<NSString *> *nameArray);

@interface JLTextPickerView : UIView

+ (instancetype)instance;

- (void)showPickerView:(NSArray<NSString *> *)strings
          currentIndex:(NSInteger)currentIndex
                onView:(UIView *)view
           resultBlock:(JLTextPickerViewResult)resultBlock;

- (void)showMultiColumnsPicker:(NSArray <NSArray <NSString *> *> *)arrayOfString
                currentIndexes:(NSArray <NSNumber *> *)arrayOfCurrentIndex
                        onView:(UIView *)view
                   resultBlock:(JLTextPickerViewMultiResult)resultBlock;

@end
