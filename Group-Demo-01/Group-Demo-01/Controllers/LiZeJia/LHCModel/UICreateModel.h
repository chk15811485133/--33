//
//  UICreateModel.h
//  Group-Demo-01
//
//  Created by qianfeng on 16/4/9.
//  Copyright © 2016年 qianfeng. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface UICreateModel : NSObject
+(UILabel*)labelWithFrame:(CGRect)frame
                     text:(NSString*)text
                textColor:(UIColor*)textColor
                alignment:(NSTextAlignment)alignment
                     font:(UIFont*)font;

+(UIButton*)buttonWithFrame:(CGRect)frame
                      title:(NSString*)title
                      image:(UIImage*)image
                     target:(id)target
                     select:(SEL)select;


+(UIImageView*)imageViewWithFrame:(CGRect)frame
                            image:(UIImage*)image;

@end
