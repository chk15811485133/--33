//
//  LHCTwoFooterModel.h
//  Group-Demo-01
//
//  Created by qianfeng on 16/4/5.
//  Copyright © 2016年 qianfeng. All rights reserved.
//

#import "LHCBaseModel.h"

@interface LHCTwoFooterModel : LHCBaseModel

/**标题*/
@property (nonatomic,strong) NSString *domainName;

/**内容*/
@property (nonatomic,strong) NSArray *posts;

@end
