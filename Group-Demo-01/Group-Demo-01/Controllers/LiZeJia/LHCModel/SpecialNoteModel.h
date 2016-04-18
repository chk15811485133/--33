//
//  SpecialNoteModel.h
//  Group-Demo-01
//
//  Created by qianfeng on 16/4/9.
//  Copyright © 2016年 qianfeng. All rights reserved.
//

#import "JSONModel.h"

@interface SpecialNoteModel : JSONModel
@property (nonatomic,copy) NSString<Optional> * ID;
@property (nonatomic,copy) NSString * trip_id;
@property (nonatomic,copy) NSString * trip_name;
@property (nonatomic,copy) NSString * user_name;


@end
