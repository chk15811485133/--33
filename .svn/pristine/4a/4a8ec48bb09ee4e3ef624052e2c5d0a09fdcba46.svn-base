//
//  CSLNetRequest.m
//  LiveAssistant
//
//  Created by csl on 15/12/10.
//  Copyright © 2015年 CSL. All rights reserved.
//

#import "CSLNetRequest.h"
#import "Auxiliary.h"

@implementation CSLNetRequest
+(void) get:(NSString*)urlString complete:(CompleteCallBack)complete fail:(FailureCallBack)failure{

    
    //得到AFHTTPRequestOperationManager请求的单例
    AFHTTPRequestOperationManager * manager = [AFHTTPRequestOperationManager manager];
    
    //设置返回数据格式（二进制）
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    //请求
    [manager GET:urlString parameters:nil success:^(AFHTTPRequestOperation * _Nonnull operation, id  _Nonnull responseObject) {
        if (complete) {
            complete(responseObject);//调用block将请求数据返回
        }
    } failure:^(AFHTTPRequestOperation * _Nullable operation, NSError * _Nonnull error) {
        if (failure) {
            failure(error);//将错误信息返回
        }
    }];
}

+(void) post:(NSString*)urlString para:(NSDictionary*)paras complete:(CompleteCallBack)complete fail:(FailureCallBack)failure{

    //得到AFHTTPRequestOperationManager请求的单例
    AFHTTPRequestOperationManager * requestManager = [AFHTTPRequestOperationManager manager];
    
    //设置返回数据格式（二进制）
    requestManager.responseSerializer = [AFHTTPResponseSerializer serializer];
    
    //请求
    [requestManager POST:urlString parameters:paras success:^(AFHTTPRequestOperation *operation, id responseObject){
        if (complete) {
            complete(responseObject);
        }
    } failure:^(AFHTTPRequestOperation * __nullable operation, NSError *error){
        if (failure) {
            failure(error);
        }
    }];
}

@end
