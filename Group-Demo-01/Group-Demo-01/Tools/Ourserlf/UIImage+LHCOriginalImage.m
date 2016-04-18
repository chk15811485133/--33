//
//  UIImage+LHCOriginalImage.m
//  Group-Demo-01
//
//  Created by qianfeng on 16/4/5.
//  Copyright © 2016年 qianfeng. All rights reserved.
//

#import "UIImage+LHCOriginalImage.h"

@implementation UIImage (LHCOriginalImage)

- (UIImage *)originalImage {
    
    //获取当前系统版本号
    //iOS 7 之后需要对图片进行一个原色的处理
    if (iOS_VERSION >= 7.0) {
        return [self imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    }
    
    return self;
}


@end
