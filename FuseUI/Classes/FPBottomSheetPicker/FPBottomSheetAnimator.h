//
//  FPBottomSheetAnimator.h
//  FUSEPRO
//
//  Created by tancheng on 2020/5/14.
//  Copyright © 2020 FUSENANO. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface FPBottomSheetAnimator : NSObject <UIViewControllerAnimatedTransitioning>

@property (nonatomic, strong) UIColor *maskColor;

@property (nonatomic, assign) CGFloat contentHeight;

@end

NS_ASSUME_NONNULL_END
