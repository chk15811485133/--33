//
//  TraveTwoModel.h
//  Group-Demo-01
//
//  Created by qianfeng on 16/4/9.
//  Copyright © 2016年 qianfeng. All rights reserved.
//

#import "JSONModel.h"

@interface TraveTwoModel : JSONModel

@property (nonatomic,copy) NSString<Optional> * destination_id;
@property (nonatomic,copy) NSString<Optional> * ID;
@property (nonatomic,copy) NSString * image_url;
@property (nonatomic,copy) NSString * name;
@property (nonatomic,copy) NSString * title;
@property (nonatomic,copy) NSString * updated_at;

@end
