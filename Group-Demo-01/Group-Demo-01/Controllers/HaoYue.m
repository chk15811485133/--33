//
//  HaoYue.m
//  Group-Demo-01
//
//  Created by qianfeng on 16/4/6.
//  Copyright © 2016年 qianfeng. All rights reserved.
//

#import "HaoYue.h"

@implementation HaoYue

+ (instancetype)sharedUser {
    static HaoYue *_user = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _user = [[HaoYue alloc] init];
    });
    
    return _user;
}

@end
