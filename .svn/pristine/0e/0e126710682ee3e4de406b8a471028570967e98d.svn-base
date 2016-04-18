//
//  LHCSubjectViewController.m
//  Group-Demo-01
//
//  Created by qianfeng on 16/4/9.
//  Copyright © 2016年 qianfeng. All rights reserved.
//

#import "LHCSubjectViewController.h"
#import "TraveDiaryModel.h"
#import "TraveDiaryTwoModel.h"
#import "TraveDiaryCell.h"
#import "MJRefresh.h"
#import "TraveDetailViewController.h"
//首页游记第一页，更改page可获得加载更多游记
#define kYouji1_url @"https://chanyouji.com/api/trips/featured.json?page=%d"

#define kBookYouji_url @"https://chanyouji.com/api/destinations/trips/%@.json?month=0&page=%d"
@interface LHCSubjectViewController ()

@end

@implementation LHCSubjectViewController

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
}

- (void)addUI{
    [super addUI];
    if (self.ID == nil) {
        self.tableView.frame = CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height-170);
    }else{
        self.tableView.frame = CGRectMake(0, -64, XBScreenWidth, XBScreenHeight);
    }
    
}

- (void)addScrollView{
    
}

- (void)loadData{
    [super loadData];
    if (self.ID == nil) {
        NSString * path = [NSString stringWithFormat:kYouji1_url,1];
        
        [self loadDataWithPath:path];
    }else{
        [self loadDataWithPath:[NSString stringWithFormat:kBookYouji_url,self.ID,1]];
    }
}

- (void)loadDataWithPath:(NSString *)path{
    
    [self.manager GET:path parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        [self paseData:responseObject];
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"---------%@",error);
        [self.headView endRefreshing];
    }];
}

- (void)paseData:(id)data{
    if (self.dataSource != nil) {
        [self.dataSource removeAllObjects];
    }
    
    for (NSDictionary * dict in data) {
        TraveDiaryModel * dimodel = [[TraveDiaryModel alloc]initWithDictionary:dict error:nil];
        dimodel.ID = dict[@"id"];
        
        TraveDiaryTwoModel * twoModel = dimodel.user;
        twoModel.ID = dict[@"user"][@"id"];
        
        [self.dataSource addObject:dimodel];
    }
    
    
    [self.tableView reloadData];
    [super paseData:data];
}

- (void)loadMoreData{
    [super loadMoreData];
    if (self.ID == nil) {
        NSString * path = [NSString stringWithFormat:kYouji1_url,self.currentPage];
        
        [self loadDataMoreWithPath:path];
    }else{
        [self loadDataMoreWithPath:[NSString stringWithFormat:kBookYouji_url,self.ID,self.currentPage]];
    }
}

- (void)loadDataMoreWithPath:(NSString *)path{
    [self.manager GET:path parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        [self paseMoreData:responseObject];
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"---------%@",error);
        [self.footView endRefreshing];
    }];
}

- (void)paseMoreData:(id)data{
    for (NSDictionary * dict in data) {
        TraveDiaryModel * dimodel = [[TraveDiaryModel alloc]initWithDictionary:dict error:nil];
        
        dimodel.ID = dict[@"id"];
        
        TraveDiaryTwoModel * twoModel = dimodel.user;
        twoModel.ID = dict[@"user"][@"id"];
        
        [self.dataSource addObject:dimodel];
    }
    
    
    [self.tableView reloadData];
    
    [super paseMoreData:data];
}

#pragma mark -------协议方法------
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.dataSource.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    TraveDiaryCell * cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (cell == nil) {
        cell = [[TraveDiaryCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
    }
    cell.model = self.dataSource[indexPath.row];
    
    TraveDiaryModel * model = self.dataSource[indexPath.row];
    cell.bgImageViewTap = ^(NSString * ID){
        [self pushTraveDetailViewControllerWithID:ID WithModel:model];
    };
    
    return cell;
}

- (void)pushTraveDetailViewControllerWithID:(NSString *)ID WithModel:(TraveDiaryModel *)model{
    TraveDetailViewController * detail = [[TraveDetailViewController alloc]init];
    detail.ID = ID;
    detail.model = model;
    detail.navigationController.navigationBarHidden = YES;
    detail.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:detail animated:YES];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 170;
}



















@end
