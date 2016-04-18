//
//  LHCTwoHeaderModel.h
//  Group-Demo-01
//
//  Created by qianfeng on 16/4/5.
//  Copyright © 2016年 qianfeng. All rights reserved.
//

#import "LHCBaseModel.h"

@interface LHCTwoHeaderModel : LHCBaseModel

@property (nonatomic,assign) NSInteger type;

@property (nonatomic,copy) NSString *img;

@property (nonatomic,strong) NSDictionary *object;

@end
