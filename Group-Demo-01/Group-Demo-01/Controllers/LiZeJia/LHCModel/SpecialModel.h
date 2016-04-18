//
//  SpecialModel.h
//  Group-Demo-01
//
//  Created by qianfeng on 16/4/9.
//  Copyright © 2016年 qianfeng. All rights reserved.
//

#import "JSONModel.h"
#import "SpecialDetailModel.h"
@interface SpecialModel : JSONModel

@property (nonatomic,strong) NSArray<SpecialDetailModel> * article_sections;
@property (nonatomic,copy) NSString<Optional> * ID;
@property (nonatomic,copy) NSString<Optional> * image_url;
@property (nonatomic,copy) NSString<Optional> * name;
@property (nonatomic,copy) NSString<Optional> * title;
@property (nonatomic,copy) NSString<Optional> * updated_at;


@end
