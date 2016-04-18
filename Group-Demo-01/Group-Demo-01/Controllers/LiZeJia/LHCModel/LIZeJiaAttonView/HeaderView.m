//
//  HeaderView.m
//  Group-Demo-01
//
//  Created by qianfeng on 16/4/9.
//  Copyright © 2016年 qianfeng. All rights reserved.
//

#import "HeaderView.h"
#import "TraveDiaryModel.h"
#import "TraveDiaryTwoModel.h"
#import "UICreateModel.h"
#import "UIImageView+WebCache.h"
#define kScreen [UIScreen mainScreen].bounds.size
@interface HeaderView()

@property (nonatomic,strong) UIImageView * bgImageView;
@property (nonatomic,strong) UILabel * title;
@property (nonatomic,strong) UILabel * other;
@property (nonatomic,strong) UIImageView * head;

@end
@implementation HeaderView

- (UIImageView *)bgImageView{
    if (_bgImageView == nil) {
        _bgImageView = [UICreateModel imageViewWithFrame:CGRectMake(0, 0, kScreen.width, self.frame.size.height) image:nil];
    }
    return _bgImageView;
}



- (UILabel *)title{
    if (_title == nil) {
        _title = [[UILabel alloc]init];
        _title.frame = CGRectMake(CGRectGetMaxX(self.head.frame)+5, CGRectGetMaxY(self.bgImageView.frame)-50, 260, 20);
        _title.textColor = [UIColor whiteColor];
        _title.textAlignment = NSTextAlignmentLeft;
        _title.font = [UIFont boldSystemFontOfSize:18];
    }
    return _title;
}

- (UILabel *)other{
    if (_other == nil) {
        _other = [UICreateModel labelWithFrame:CGRectMake(CGRectGetMaxX(self.head.frame)+5, CGRectGetMaxY(self.title.frame)+5, 200, 20) text:nil textColor:[UIColor whiteColor] alignment:NSTextAlignmentLeft font:[UIFont systemFontOfSize:15]];
    }
    return _other;
}

- (UIImageView *)head{
    if (_head == nil) {
        _head = [UICreateModel imageViewWithFrame:CGRectMake(5, self.frame.size.height-60, 50, 50) image:nil];
        _head.layer.cornerRadius = 25;
        _head.layer.masksToBounds = YES;
        _head.layer.borderWidth = 2;
        _head.layer.borderColor = [UIColor whiteColor].CGColor;
        _head.userInteractionEnabled = YES;
        UITapGestureRecognizer * tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(headClick:)];
        [_head addGestureRecognizer:tap];
    }
    return _head;
}

- (void)headClick:(UITapGestureRecognizer *)gesture{
    
}

- (id)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        [self addUI];
    }
    return self;
}

- (void)addUI{
    [self addSubview:self.bgImageView];
    [self.bgImageView addSubview:self.head];
    [self.bgImageView addSubview:self.title];
    [self.bgImageView addSubview:self.other];
}

- (void)setModel:(TraveDiaryModel *)model{
    [self.bgImageView sd_setImageWithURL:[NSURL URLWithString:model.front_cover_photo_url]];
    TraveDiaryTwoModel * tmodel = model.user;
    [self.head sd_setImageWithURL:[NSURL URLWithString:tmodel.image]];
    
    self.title.text = model.name;
    self.other.text = [NSString stringWithFormat:@"%@/%@天/%@图",model.start_date,model.days,model.photos_count];
}






















@end
