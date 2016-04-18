//
//  LHCChatTableViewCell.m
//  Group-Demo-01
//
//  Created by qianfeng on 16/4/11.
//  Copyright © 2016年 qianfeng. All rights reserved.
//

#import "LHCChatTableViewCell.h"

#import "LHCMessage.h"

@interface LHCChatTableViewCell ()

/**消息来源*/
@property (nonatomic,strong) UILabel *fromLabel;

@property (nonatomic,strong) UIImageView *fromImage;

/**目的消息*/
@property (nonatomic,strong) UILabel *toLabel;

@property (nonatomic,strong) UIImageView *toImage;

@end

@implementation LHCChatTableViewCell

- (void)setMessagess:(LHCMessage *)messagess{
    
    [self aboutFuYong];
    
    /**判断消息来源*/
    if ([messagess.from isEqualToString:self.friendID]) {//来自好友的信息
        self.fromLabel.text = messagess.messages;
        
        self.fromLabel.height = [messagess.messages boundingRectWithSize:CGSizeMake(SCREEN_WIDTH-120, FLT_MAX) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:FONT(18)} context:nil].size.height;
        
        [self fromImage];
        /**如果label高度大于图片高度*/
        if (self.fromLabel.maxY > 60) {
            self.cellHeight = self.fromLabel.maxY;
            return;
        }
    }
    else {//来自自己的信息
        self.toLabel.text = messagess.messages;
        
        self.toLabel.height = [messagess.messages boundingRectWithSize:CGSizeMake(SCREEN_WIDTH-120, FLT_MAX) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:FONT(18)} context:nil].size.height;
        [self toImage];
        if (self.toLabel.maxY > 60) {
            self.cellHeight = self.toLabel.maxY;
            return;
        }
    }
    self.cellHeight = 60;
}

- (void)aboutFuYong {
    for (UIView *view in self.contentView.subviews) {
        [view removeFromSuperview];
    }
    
    self.fromLabel = nil;
    self.fromImage = nil;
    self.toLabel = nil;
    self.toImage = nil;
}

#pragma mark ------------懒加载-----------
- (UIImageView *)fromImage {
    if (_fromImage== nil) {
        _fromImage = [[UIImageView alloc] initWithFrame:CGRectMake(10, 5, 50, 50)];
        
<<<<<<< .mine
        /**设置视图圆角*/
        _fromImage.layer.cornerRadius = 25;
        _fromImage.clipsToBounds = YES;
=======
        _fromImage.image = [UIImage imageNamed:@"youicon.jpg"];
>>>>>>> .r4171
        
        _fromImage.image = [UIImage imageNamed:@"111.jpg"];
        
        [self.contentView addSubview:_fromImage];
    }
    return _fromImage;
}

- (UILabel *)fromLabel {
    if (_fromLabel == nil) {
        _fromLabel = [[UILabel alloc] initWithFrame:CGRectMake(self.fromImage.maxX, 15, SCREEN_WIDTH-20-2*self.fromImage.width, 30)];
        
        [self.contentView addSubview:_fromLabel];
    }
    return _fromLabel;
}

- (UIImageView *)toImage {
    if (_toImage == nil) {
        _toImage = [[UIImageView alloc] initWithFrame:CGRectMake(SCREEN_WIDTH-60, 5, 50, 50)];
        
        /**设置视图圆角*/
        _toImage.layer.cornerRadius = 25;
        _toImage.clipsToBounds = YES;
        
        NSString *path_sandox = NSHomeDirectory();
        NSString *imagepath = [path_sandox stringByAppendingString:@"/Documents/flower.png"];
        
        UIImage *image = [UIImage imageWithContentsOfFile:imagepath];
        
        if (!image) {
            image = [UIImage imageNamed:@"111.jpg"];
        }
        
        _toImage.image = image;
        
        [self.contentView addSubview:_toImage];
    }
    return _toImage;
}

- (UILabel *)toLabel {
    if (_toLabel == nil) {
        _toLabel = [[UILabel alloc] init];
        
        _toLabel.width = SCREEN_WIDTH-120;
        
        _toLabel.x = 60;
        
        _toLabel.y = 15;
        
        _toLabel.numberOfLines = 0;
        
        _toLabel.textAlignment = NSTextAlignmentRight;
        
        [self.contentView addSubview:_toLabel];
    }
    return _toLabel;
}



@end