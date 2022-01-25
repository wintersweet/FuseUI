//
//  FUDatePickerView.h
//  FUSEPRO
//
//  Created by tancheng on 2019/4/1.
//  Copyright © 2019 FUSENANO. All rights reserved.
//

#import <UIKit/UIKit.h>

@class FUDatePickerView;
@protocol FUDatePickerViewDelegate <NSObject>

@optional

- (void)cancelSelectedDatePickerView:(FUDatePickerView *_Nonnull)pickerView;

- (void)selectedDatePickerView:(FUDatePickerView *_Nonnull)pickerView selectedDate:(NSDate *_Nonnull)selectedDate;

@end


typedef enum : NSUInteger {
    FUDatePickerViewTypeYearMonth,
    FUDatePickerViewTypeYearMonthDay,
} FUDatePickerViewType;

NS_ASSUME_NONNULL_BEGIN

@interface FUDatePickerView : UIView

@property (nonatomic, copy) NSDate *selDefaultDate;

@property (nonatomic, weak) id <FUDatePickerViewDelegate> delegate;

+ (instancetype)instanceWithType:(FUDatePickerViewType)type;

@end

NS_ASSUME_NONNULL_END
