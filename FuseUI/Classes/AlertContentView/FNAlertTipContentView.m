//
//  FNAlertTipContentView.m
//  FUSEPRO
//
//  Created by tancheng on 2019/1/18.
//  Copyright © 2019 FUSENANO. All rights reserved.
//

#import "FNAlertTipContentView.h"

@implementation FNAlertTipContentView


+ (FNAlertTipContentView *)alert:(NSString *)title tipImg:(UIImage *)image msg:(NSString *)msg {
    
    FNAlertTipContentView *view = [[NSBundle mainBundle] loadNibNamed:@"FNAlertTipContentView" owner:nil options:nil].firstObject;
    view.titleLab.text = title;
    view.tipImg.image = image;
    view.msgLab.text = msg;
    return view;
}

- (IBAction)cancel:(UIButton *)sender {
    if (self.cancelAction) {
        self.cancelAction();
    }
}

@end
