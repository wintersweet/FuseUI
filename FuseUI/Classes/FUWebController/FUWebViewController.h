//
//  FUWebViewController.h
//  FUSEPRO
//
//  Created by tancheng on 2019/4/9.
//  Copyright © 2019 FUSENANO. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <WebKit/WebKit.h>
NS_ASSUME_NONNULL_BEGIN

@interface FUWebViewController : UIViewController

///自定义标题
@property (nonatomic, copy) NSString *customTitle;
///js调用oc，自定义交互
@property (nonatomic, weak) WKUserContentController *userContentController;

@end

NS_ASSUME_NONNULL_END
