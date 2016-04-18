//
//  TraveDiaryCell.m
//  Group-Demo-01
//
//  Created by qianfeng on 16/4/9.
//  Copyright © 2016年 qianfeng. All rights reserved.
//

#import "TraveDiaryCell.h"
#import "TraveDiaryModel.h"
#import "TraveDiaryTwoModel.h"
#import "UICreateModel.h"
#import "UIImageView+WebCache.h"
#define kScreen [UIScreen mainScreen].bounds.size
@interface TraveDiaryCell ()

@property (nonatomic,strong) UIImageView * bgImageView;
@property (nonatomic,strong) UILabel * title;
@property (nonatomic,strong) UILabel * other;
@property (nonatomic,strong) UIImageView * head;

@end

@implementation TraveDiaryCell

- (void)setFrame:(CGRect)frame{
    CGRect rect = frame;
    rect.origin.y += 5;
    frame = rect;
    [super setFrame:frame];
}

- (UIImageView *)bgImageView{
    if (_bgImageView == nil) {
        _bgImageView = [UICreateModel imageViewWithFrame:CGRectMake(5, 3, kScreen.width-10, 170-6) image:nil];
        _bgImageView.layer.cornerRadius = 4;
        _bgImageView.layer.masksToBounds = YES;
        _bgImageView.userInteractionEnabled = YES;
        
        UITapGestureRecognizer * gesture = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tap:)];
        [_bgImageView addGestureRecognizer:gesture];
    }
    return _bgImageView;
}

- (void)tap:(UITapGestureRecognizer *)gesture{
    if (self.bgImageViewTap) {
        self.bgImageViewTap(self.model.ID);
    }
}

- (UILabel *)title{
    if (_title == nil) {
        _title = [[UILabel alloc]init];
        _title.textColor = [UIColor whiteColor];
        _title.textAlignment = NSTextAlignmentLeft;
        _title.font = [UIFont boldSystemFontOfSize:18];
        _title.numberOfLines = 0;
        _title.lineBreakMode = NSLineBreakByWordWrapping;
    }
    return _title;
}

- (UILabel *)other{
    if (_other == nil) {
        _other = [UICreateModel labelWithFrame:CGRectMake(5, CGRectGetMaxY(self.title.frame), 200, 20) text:nil textColor:[UIColor whiteColor] alignment:NSTextAlignmentLeft font:[UIFont systemFontOfSize:15]];
    }
    return _other;
}

- (UIImageView *)head{
    if (_head == nil) {
        _head = [UICreateModel imageViewWithFrame:CGRectMake(5, 170-60, 50, 50) image:nil];
        _head.layer.cornerRadius = 25;
        _head.layer.masksToBounds = YES;
        _head.layer.borderWidth = 2;
        _head.layer.borderColor = [UIColor colorWithWhite:0.9 alpha:1].CGColor;
        _head.userInteractionEnabled = YES;
        UITapGestureRecognizer * tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(headClick:)];
        [_head addGestureRecognizer:tap];
    }
    return _head;
}

- (void)headClick:(UITapGestureRecognizer *)gesture{
    
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self addUI];
    }
    return self;
}

- (void)addUI{
    self.contentView.backgroundColor = [UIColor colorWithWhite:0.9 alpha:1];
    [self.contentView addSubview:self.bgImageView];
    [self.bgImageView addSubview:self.title];
    [self.bgImageView addSubview:self.other];
    [self.bgImageView addSubview:self.head];
}

- (void)setModel:(TraveDiaryModel *)model{
    _model = model;
    
    [self.bgImageView sd_setImageWithURL:[NSURL URLWithString:model.front_cover_photo_url]];
    self.title.text = model.name;
    
    CGRect rect = [self.title.text boundingRectWithSize:CGSizeMake(280, 1000) options:NSStringDrawingUsesLineFragmentOrigin attributes:[NSDictionary dictionaryWithObjectsAndKeys:self.title.font,NSFontAttributeName, nil] context:nil];
    self.title.frame = CGRectMake(5, 5, 280, rect.size.height);
    self.other.frame = CGRectMake(5, CGRectGetMaxY(self.title.frame), 200, 20);
    
    self.other.text = [NSString stringWithFormat:@"%@/%@天/%@图",model.start_date,model.days,model.photos_count];
    TraveDiaryTwoModel * model2 = model.user;
    
    [self.head sd_setImageWithURL:[NSURL URLWithString:model2.image]];
}

@end

