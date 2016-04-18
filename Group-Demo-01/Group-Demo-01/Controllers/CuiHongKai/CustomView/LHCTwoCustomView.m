//
//  LHCTwoCustomView.m
//  Group-Demo-01
//
//  Created by qianfeng on 16/4/5.
//  Copyright © 2016年 qianfeng. All rights reserved.
//

#import "LHCTwoCustomView.h"
#import "LHCTwoFooterModel.h"
#import "UIImageView+WebCache.h"
#import "LHCTwoCustomView.h"
#import "UIView+frame.h"

#define LABEL_HEIGHT 40

@interface LHCTwoCustomView ()
//标题
@property (nonatomic,strong) UILabel *labelTitle;

@end

@implementation LHCTwoCustomView


- (void)setModel:(LHCTwoFooterModel *)model {
    _model = model;
    //标题
    self.labelTitle.text = model.domainName;
    //添加图片
    [self addImageView:model];
}
/**添加图片*/
- (void)addImageView:(LHCTwoFooterModel *)model {
    float width = self.width/2;
    float height = (self.height-self.labelTitle.height)/2;
    
    for (int i = 0; i < model.posts.count; i++) {
        UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(i%2*(width-1), i/2*(height-1)+40, width, height)];
        
        NSString *imageUrl = model.posts[i][@"image"];
        
        [imageView sd_setImageWithURL:[NSURL URLWithString:imageUrl]];
        
        [self addSubview:imageView];
    }
}

#pragma mark------------懒加载------------
- (UILabel *)labelTitle {
    if (_labelTitle == nil) {
        _labelTitle = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, self.width, LABEL_HEIGHT)];
        //居中对齐
        _labelTitle.textAlignment = NSTextAlignmentCenter;
        
        [self addSubview:_labelTitle];
    }
    return _labelTitle;
}

@end
