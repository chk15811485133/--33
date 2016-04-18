//
//  LHCChatTableViewCell.h
//  Group-Demo-01
//
//  Created by qianfeng on 16/4/11.
//  Copyright © 2016年 qianfeng. All rights reserved.
//

#import <UIKit/UIKit.h>

@class LHCMessage;

@interface LHCChatTableViewCell : UITableViewCell

/**消息内容*/
@property (nonatomic,strong) LHCMessage *messagess;
/**朋友ID*/
@property (nonatomic,copy) NSString *friendID;

/**cell高*/
@property (nonatomic,assign) NSInteger cellHeight;

@end
