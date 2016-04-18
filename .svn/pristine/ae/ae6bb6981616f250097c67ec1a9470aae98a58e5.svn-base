//
//  SpecialHeaderView.m
//  Group-Demo-01
//
//  Created by qianfeng on 16/4/9.
//  Copyright © 2016年 qianfeng. All rights reserved.
//

#import "SpecialHeaderView.h"
#import "TraveTwoModel.h"
#import "UICreateModel.h"
#import "UIImageView+WebCache.h"
@interface SpecialHeaderView ()

@property (nonatomic,strong) UIImageView * bgImageView;
@property (nonatomic,strong) UILabel * title;
@property (nonatomic,strong) UILabel * other;
@property (nonatomic,strong) UILabel * line;

@end

@implementation SpecialHeaderView

- (UIImageView *)bgImageView{
    if (_bgImageView == nil) {
        _bgImageView = [UICreateModel imageViewWithFrame:CGRectMake(0, 0, XBScreenWidth, self.frame.size.height) image:nil];
    }
    return _bgImageView;
}


- (UILabel *)title{
    if (_title == nil) {
        _title = [[UILabel alloc]init];
        _title.frame = CGRectMake((XBScreenWidth-200)/2, self.bgImageView.frame.size.height/2-30, 200, 30);
        _title.textColor = [UIColor whiteColor];
        _title.textAlignment = NSTextAlignmentCenter;
        _title.font = [UIFont boldSystemFontOfSize:20];
    }
    return _title;
}

- (UILabel *)line{
    if (_line == nil) {
        _line = [[UILabel alloc]init];
        _line.frame = CGRectMake((XBScreenWidth)/2-(XBScreenWidth-60)/2, CGRectGetMaxY(self.title.frame), XBScreenWidth-60, 15);
        _line.text = @"----------- 。-----------";
        _line.textAlignment = NSTextAlignmentCenter;
        _line.textColor = [UIColor whiteColor];
    }
    return _line;
}

- (UILabel *)other{
    if (_other == nil) {
        _other = [UICreateModel labelWithFrame:CGRectMake((XBScreenWidth-270)/2, CGRectGetMaxY(self.line.frame), 270, 20) text:nil textColor:[UIColor whiteColor] alignment:NSTextAlignmentCenter font:[UIFont systemFontOfSize:16]];
    }
    return _other;
}

- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        [self addUI];
    }
    return self;
}

- (void)addUI{
    [self addSubview:self.bgImageView];
    [self.bgImageView addSubview:self.title];
    [self.bgImageView addSubview:self.line];
    [self.bgImageView addSubview:self.other];
}

- (void)setModel:(TraveTwoModel *)model{
    [self.bgImageView sd_setImageWithURL:[NSURL URLWithString:model.image_url]];
    
    self.title.text = model.name;
    self.other.text = model.title;
}























@end
