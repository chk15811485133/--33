//
//  UICreateModel.m
//  Group-Demo-01
//
//  Created by qianfeng on 16/4/9.
//  Copyright © 2016年 qianfeng. All rights reserved.
//

#import "UICreateModel.h"

@implementation UICreateModel
+(UILabel*)labelWithFrame:(CGRect)frame text:(NSString *)text textColor:(UIColor *)textColor alignment:(NSTextAlignment)alignment font:(UIFont *)font
{
    UILabel * label = [[UILabel alloc]initWithFrame:frame];
    label.text = text;
    label.textColor = textColor;
    label.textAlignment = alignment;
    label.font = font;
    return label;
}

+(UIButton*)buttonWithFrame:(CGRect)frame title:(NSString *)title image:(UIImage *)image target:(id)target select:(SEL)select
{
    UIButton * button = [[UIButton alloc]init];
    button.frame = frame;
    [button setTitle:title forState:UIControlStateNormal];
    [button setImage:image forState:UIControlStateNormal];
    [button addTarget:target action:select forControlEvents:UIControlEventTouchUpInside];
    
    return button;
}

+(UIImageView*)imageViewWithFrame:(CGRect)frame image:(UIImage *)image
{
    UIImageView * imageView = [[UIImageView alloc]init];
    imageView.frame = frame;
    imageView.image = image;
    return imageView;
}

@end
