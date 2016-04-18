//
//  SpecialCell.m
//  Group-Demo-01
//
//  Created by qianfeng on 16/4/9.
//  Copyright © 2016年 qianfeng. All rights reserved.
//

#import "SpecialCell.h"
#import "SpecialDetailModel.h"
#import "SpecialNoteModel.h"
#import "SpecialAttModel.h"
#import "UIImageView+WebCache.h"
@interface SpecialCell ()
@property (nonatomic,strong) UILabel * Description;
@property (nonatomic,strong) UIImageView * ImageView;
@property (nonatomic,strong) UILabel * alabel;

@end

@implementation SpecialCell

- (UILabel *)Description{
    if (_Description == nil) {
        _Description = [[UILabel alloc]init];
        _Description.textAlignment = NSTextAlignmentLeft;
        _Description.textColor = [UIColor blackColor];
        _Description.font = [UIFont systemFontOfSize:15];
        _Description.numberOfLines = 0;
        _Description.lineBreakMode = NSLineBreakByWordWrapping;
    }
    return _Description;
}

- (UIImageView *)ImageView{
    if(_ImageView == nil){
        _ImageView = [[UIImageView alloc]init];
    }
    return _ImageView;
}

- (UILabel *)alabel{
    if(_alabel == nil){
        _alabel = [[UILabel alloc]init];
        _alabel.textAlignment = NSTextAlignmentLeft;
        _alabel.textColor = [UIColor blackColor];
        _alabel.font = [UIFont boldSystemFontOfSize:17];
    }
    return _alabel;
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self addUI];
    }
    return self;
}

- (void)addUI{
    [self.contentView addSubview:self.Description];
    [self.contentView addSubview:self.ImageView];
    [self.contentView addSubview:self.alabel];
}

- (void)setModel:(SpecialDetailModel *)model{
    _Model = model;
    self.Description.text = model.Description;
    CGRect rect = [self.Description.text boundingRectWithSize:CGSizeMake(XBScreenWidth-30, 1000) options:NSStringDrawingUsesLineFragmentOrigin attributes:[NSDictionary dictionaryWithObjectsAndKeys:self.Description.font,NSFontAttributeName, nil] context:nil];
    
    SpecialDetailModel * dModel = model;
    
    
    
    if (![model.image_url isEqualToString:@""]) {
        CGFloat width = [model.image_width floatValue];
        CGFloat height = [model.image_height floatValue];
        
        self.ImageView.frame = CGRectMake(15, 10, XBScreenWidth-30, (XBScreenWidth-30)*height/width);
        [self.ImageView sd_setImageWithURL:[NSURL URLWithString:model.image_url]];
        
        
        self.Description.frame = CGRectMake(15, CGRectGetMaxY(self.ImageView.frame), XBScreenWidth-30, rect.size.height);
    }else{
        self.Description.frame = CGRectMake(15, 10, XBScreenWidth-30, rect.size.height);
        self.ImageView.frame = CGRectMake(0, 0, 0, 0);
    }
    
    if (![model.title isEqualToString:@""]) {
        
        self.alabel.frame = CGRectMake(15, 10, 270, 30);
        self.alabel.text = [NSString stringWithFormat:@"| %@",model.title];
        
        self.Description.frame = CGRectMake(15, CGRectGetMaxY(self.alabel.frame)+5, XBScreenWidth-30, rect.size.height);
    }else{
        self.alabel.frame = CGRectMake(0, 0, 0, 0);
    }
    
    
    dModel.heightCell = [NSString stringWithFormat:@"%f",CGRectGetMaxY(self.Description.frame)+10];
    
    
}

@end
