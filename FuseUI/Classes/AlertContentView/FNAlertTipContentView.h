//
//  FNAlertTipContentView.h
//  FUSEPRO
//
//  Created by tancheng on 2019/1/18.
//  Copyright © 2019 FUSENANO. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface FNAlertTipContentView : UIView
@property (weak, nonatomic) IBOutlet UIImageView *tipImg;
@property (weak, nonatomic) IBOutlet UILabel *titleLab;
@property (weak, nonatomic) IBOutlet UILabel *msgLab;
@property (weak, nonatomic) IBOutlet UIButton *cancelBtn;

@property (nonatomic, copy) void(^cancelAction)(void);

+ (FNAlertTipContentView *)alert:(NSString *)title tipImg:(UIImage *)image msg:(NSString *)msg;

@end

NS_ASSUME_NONNULL_END
