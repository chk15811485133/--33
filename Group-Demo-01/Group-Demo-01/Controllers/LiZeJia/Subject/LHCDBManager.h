//
//  LHCDBManager.h
//  Group-Demo-01
//
//  Created by qianfeng on 16/4/9.
//  Copyright © 2016年 qianfeng. All rights reserved.
//

#import <Foundation/Foundation.h>

@class TraveDiaryModel;
@class LHCMessage;
@interface LHCDBManager : NSObject

+(id)defaultDBManager;

-(void)saveHotModel:(NSData *)model;

-(NSArray *)allHotModel;

-(void)deleteHotModel:(TraveDiaryModel *)model;


@end
