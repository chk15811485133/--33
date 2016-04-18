//
//  TraveTwoCell.h
//  Group-Demo-01
//
//  Created by qianfeng on 16/4/9.
//  Copyright © 2016年 qianfeng. All rights reserved.
//

#import <UIKit/UIKit.h>
@class TraveTwoModel;
@interface TraveTwoCell : UITableViewCell

@property (nonatomic,strong) TraveTwoModel * model;
@property (nonatomic,copy) void (^ImageViewClick)(NSString *);

@end
