//
//  TrNotesTwoModel.h
//  Group-Demo-01
//
//  Created by qianfeng on 16/4/9.
//  Copyright © 2016年 qianfeng. All rights reserved.
//

#import "JSONModel.h"
@protocol  TrNotesTwoModel

@end

@class TrPhotoModel;
@interface TrNotesTwoModel : JSONModel

@property (nonatomic,copy) NSString<Optional> * col;
@property (nonatomic,copy) NSString<Optional> * Description;
@property (nonatomic,copy) NSString<Optional> * ID;


@property (nonatomic,strong) TrPhotoModel<Optional> * photo;

@property (nonatomic,copy) NSString<Optional> * heightCell;
@end
