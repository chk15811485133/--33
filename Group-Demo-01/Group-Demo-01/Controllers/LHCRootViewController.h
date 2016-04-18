//
//  LHCRootViewController.h
//  Group-Demo-01
//
//  Created by qianfeng on 16/4/5.
//  Copyright © 2016年 qianfeng. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CSLNetRequest.h"

@interface LHCRootViewController : UIViewController 

@property(nonatomic,strong)  NSMutableArray * dataSource;//数据源
@property(nonatomic,assign) BOOL isLoadIndicator;//是否显示加载指示器


/**子类实现更新UI*/
- (void)updateUI;

/**子类实现得到在线消息*/
- (void)getMessage:(NSString *)txt withFrom:(NSString *)from;

/**子类实现得到离线消息*/
- (void)getOffLineMessages:(NSString *)message;

//数据请求，子类实现
-(void) request:(NSString*)method url:(NSString*)urlString para:(NSDictionary*)dict;

-(void) showIndicatorInView:(UIView*)parentView isDisplay:(BOOL)show;//是否显示指示器

-(void) parserData:(id)data;//数据解析

/**查找用户*/
- (void)selectOneUser:(NSString *)username;

/**添加好友*/
- (void)addFriend:(NSString *)friendUsername;

/**查看某个好友是否已添加*/
- (void)selectONeFriend:(NSString *)friendUsername;

/**查找好友*/
- (void)selectFriends;

/**删除好友*/
- (void)deleteFriend:(NSString *)friendUsername;

/**查找关注*/
- (void)selectUsers;

@end
