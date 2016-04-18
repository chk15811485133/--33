//
//  LHCDBManager.m
//  Group-Demo-01
//
//  Created by qianfeng on 16/4/9.
//  Copyright © 2016年 qianfeng. All rights reserved.
//

#import "LHCDBManager.h"
#import "FMDatabase.h"
#import "FMResultSet.h"
#import "TraveDiaryModel.h"

#import "LHCMessage.h"

@implementation LHCDBManager
{
    FMDatabase * _db;
}

+(id)defaultDBManager{
    static LHCDBManager * manager = nil;
    if (manager == nil) {
        manager = [[LHCDBManager alloc]init];
    }
    return manager;
}

-(id)init{
    self = [super init];
    if (self) {
        [self prepareDB];
    }
    return self;
}

- (void)prepareDB{
    
    NSString * dbPath = [NSHomeDirectory() stringByAppendingPathComponent:@"Documents/DB"];
    if (_db == nil) {
        _db = [FMDatabase databaseWithPath:dbPath];
    }
    [_db open];
    //    NSLog(@"%@",dbPath);
    [self createTableList];
    
}



- (void)createTableList{
    //    title;
    //    tag;
    //    city;
    //    destination;
    //    start_time;
    //    max_cost;
    //   club;
    //    cover;
    //    days;title varchar(100),tag text,city varchar(100),destination varchar(150),start_time varchar(100),max_cost varchar(100),club)
    NSString * sql1 = @"create table if not exists APP (ID integer primary key autoincrement,data blob );";
    BOOL success = [_db executeUpdate:sql1];
    if (success ) {
        NSLog(@"创建表成功");
    }
}


-(void)saveHotModel:(NSData *)model {
    NSString * sql = @"insert into APP (data) values (?);";
    
    BOOL success = [_db executeUpdate:sql,model];
    if (success) {
        NSLog(@"数据插入成功");
    }
}


- (NSArray *)allHotModel {
    NSString * sql = @"select * from APP;";
    FMResultSet * set  = [_db executeQuery:sql];
    NSMutableArray * temp = [[NSMutableArray alloc] init];
    while (set.next) {
        NSData * data = [set dataForColumn:@"data"];
        [temp addObject:data];
    }
    return temp;
}

-(void)deleteHotModel:(TraveDiaryModel *)model{
    NSString * sql = @"select * from APP;";
    FMResultSet * set = [_db executeQuery:sql];
    while (set.next) {
        NSData * data = [set dataForColumn:@"data"];
        
        TraveDiaryModel * modelll = [NSKeyedUnarchiver unarchiveObjectWithData:data];
        
        if ([model.ID isEqualToString:modelll.ID]) {
            NSInteger CID = [set intForColumn:@"ID"];
            
            NSString * sql2 = [NSString stringWithFormat:@"delete from APP where ID = %ld;",CID];
            
            BOOL success = [_db executeUpdate:sql2];
            if (success == YES) {
                NSLog(@"删除成功");
            }else{
                NSLog(@"删除失败");
            }
        }
    }
}







@end
