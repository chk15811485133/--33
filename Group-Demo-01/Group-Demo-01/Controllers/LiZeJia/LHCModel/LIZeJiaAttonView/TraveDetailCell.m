//
//  TraveDetailCell.m
//  Group-Demo-01
//
//  Created by qianfeng on 16/4/9.
//  Copyright © 2016年 qianfeng. All rights reserved.
//

#import "TraveDetailCell.h"
#import "TrNotesTwoModel.h"
#import "TrPhotoModel.h"
#import "UIImageView+WebCache.h"
#define kScreen [UIScreen mainScreen].bounds.size
@interface TraveDetailCell ()

@property (nonatomic,strong) UILabel * Description;
@property (nonatomic,strong) UIImageView * ImageView;

@end

@implementation TraveDetailCell

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
    if (_ImageView == nil) {
        _ImageView = [[UIImageView alloc]init];
    }
    return _ImageView;
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
}

- (void)setModel:(TrNotesTwoModel *)model{
    self.Description.text = model.Description;
    CGRect rect = [self.Description.text boundingRectWithSize:CGSizeMake(kScreen.width-30, 1000) options:NSStringDrawingUsesLineFragmentOrigin attributes:[NSDictionary dictionaryWithObjectsAndKeys:self.Description.font,NSFontAttributeName, nil] context:nil];
    self.Description.frame = CGRectMake(15, 10, kScreen.width-30, rect.size.height);
    
    
    
    if (model.photo != nil) {
        TrPhotoModel * photo = model.photo;
        CGFloat width = [photo.image_width floatValue];
        CGFloat height = [photo.image_height floatValue];
        //CGFloat asize = [photo.image_file_size floatValue];
        
        if (model.Description == nil) {
            self.ImageView.frame = CGRectMake(10, 10, kScreen.width-20, (kScreen.width-20)*height/width);
        }else{
            self.ImageView.frame = CGRectMake(10, CGRectGetMaxY(self.Description.frame)+10, kScreen.width-20, (kScreen.width-20)*height/width);
        }
        
        [self.ImageView sd_setImageWithURL:[NSURL URLWithString:photo.url]];
        
        TrNotesTwoModel * tmodel = model;
        tmodel.heightCell = [NSString stringWithFormat:@"%f",CGRectGetMaxY(self.ImageView.frame)+10];
    }else{
        TrNotesTwoModel * tmodel = model;
        tmodel.heightCell = [NSString stringWithFormat:@"%f",CGRectGetMaxY(self.Description.frame)+10];
        self.ImageView.frame = CGRectMake(0, 0, 0, 0);
    }
    
    
}




















@end
