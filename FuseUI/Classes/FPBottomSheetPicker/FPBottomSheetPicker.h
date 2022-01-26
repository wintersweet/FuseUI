//
//  FPBottomSheetPicker.h
//  FUSEPRO
//
//  Created by tancheng on 2020/5/14.
//  Copyright © 2020 FUSENANO. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol FPBottomSheetPickerDelegate <NSObject>

- (void)sheetPickerDidSelectItemAtIndex:(NSInteger)index;

@end

@protocol FPBottomSheetPickerDataSource <NSObject>

- (NSString *_Nullable)sheetPickerTitle;

- (NSString *_Nonnull)sheetPickerItemTitleForIndex:(NSInteger)index;

- (NSInteger)sheetPickerItemCount;

@end

NS_ASSUME_NONNULL_BEGIN

@interface FPBottomSheetPicker : UIView

@property (nonatomic, weak) id <FPBottomSheetPickerDelegate> delegate;

@property (nonatomic, weak) id <FPBottomSheetPickerDataSource> dataSource;

+(instancetype)defaultSheet;

- (void)show;

@end

NS_ASSUME_NONNULL_END
