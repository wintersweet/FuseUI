//
//  FUHotspotButton.m
//  FUSEPRO
//
//  Created by tancheng on 2019/3/27.
//  Copyright © 2019 FUSENANO. All rights reserved.
//

#import "FUHotspotButton.h"

@implementation FUHotspotButton

-(BOOL)pointInside:(CGPoint)point withEvent:(UIEvent*)event
{
    CGRect bounds = self.bounds;
    //扩大原热区直径至26，可以暴露个接口，用来设置需要扩大的半径。
    CGFloat widthDelta = MAX(26, 0);
    CGFloat heightDelta = MAX(26, 0);
    bounds = CGRectInset(bounds, -0.5 * widthDelta, -0.5 * heightDelta);
    return CGRectContainsPoint(bounds, point);
}

@end
