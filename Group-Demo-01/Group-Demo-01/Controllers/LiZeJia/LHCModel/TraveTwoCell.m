//
//  TraveTwoCell.m
//  Group-Demo-01
//
//  Created by qianfeng on 16/4/9.
//  Copyright © 2016年 qianfeng. All rights reserved.
//

#import "TraveTwoCell.h"
#import "TraveTwoModel.h"
#import "UICreateModel.h"
#import "UIImageView+WebCache.h"
@interface TraveTwoCell ()

@property (nonatomic,strong) UIImageView * bgImageView;
@property (nonatomic,strong) UILabel * name;
@property (nonatomic,strong) UILabel * title;

@end
@implementation TraveTwoCell

-(UIImageView *)bgImageView{
    if (_bgImageView == nil) {
        _bgImageView = [UICreateModel imageViewWithFrame:CGRectMake(5, 5, XBScreenWidth-10, 200) image:nil];
        _bgImageView.layer.cornerRadius = 4;
        _bgImageView.layer.masksToBounds = YES;
        _bgImageView.userInteractionEnabled = YES;
        
        UITapGestureRecognizer * tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tap:)];
        [_bgImageView addGestureRecognizer:tap];
    }
    return _bgImageView;
}

- (void)tap:(UITapGestureRecognizer *)gesture{
    if (self.ImageViewClick) {
        self.ImageViewClick(self.model.ID);
    }
}

- (UILabel *)name{
    if (_name == nil) {
        _name = [UICreateModel labelWithFrame:CGRectMake(10, 130, 300, 50) text:nil textColor:[UIColor whiteColor] alignment:NSTextAlignmentLeft font:[UIFont boldSystemFontOfSize:21]];
    }
    return _name;
}

- (UILabel *)title{
    if (_title == nil) {
        _title = [UICreateModel labelWithFrame:CGRectMake(10, CGRectGetMaxY(_name.frame)-15, 300, 30) text:nil textColor:[UIColor whiteColor] alignment:NSTextAlignmentLeft font:[UIFont systemFontOfSize:20]];
    }
    return _title;
}

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self addUI];
    }
    return self;
}

- (void)addUI{
    [self.contentView addSubview:self.bgImageView];
    [self.bgImageView addSubview:self.name];
    [self.bgImageView addSubview:self.title];
}

- (void)setModel:(TraveTwoModel *)model{
    _model = model;
    [self.bgImageView sd_setImageWithURL:[NSURL URLWithString:model.image_url]];
    
    self.name.text = model.name;
    self.title.text = model.title;
}


@end