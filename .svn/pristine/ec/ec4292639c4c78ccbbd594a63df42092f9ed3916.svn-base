//
//  LHCNavigationBar.m
//  Group-Demo-01
//
//  Created by qianfeng on 16/4/9.
//  Copyright © 2016年 qianfeng. All rights reserved.
//

#import "LHCNavigationBar.h"

@implementation LHCNavigationBar

- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        
        for (UIView * view in self.subviews) {
            if ([view isKindOfClass:NSClassFromString(@"_UINavigationBarBackground")]) {
                self.bgView = view;
            }
        }
    }
    return self;
}

- (void)show{
    [UIView animateWithDuration:0.2 animations:^{
        self.bgView.hidden = NO;
    }];
}

- (void)hidden{
    self.bgView.hidden = YES;
}
















@end
