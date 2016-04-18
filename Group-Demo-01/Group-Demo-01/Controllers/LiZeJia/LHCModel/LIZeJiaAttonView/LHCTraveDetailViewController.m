//
//  LHCTraveDetailViewController.m
//  Group-Demo-01
//
//  Created by qianfeng on 16/4/9.
//  Copyright © 2016年 qianfeng. All rights reserved.
//

#import "LHCTraveDetailViewController.h"
#import "TraveTwoModel.h"
#import "TraveTwoCell.h"
#import "SpecialViewController.h"
@interface LHCTraveDetailViewController ()


@end

@implementation LHCTraveDetailViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    
}

- (void)addTableView{
    [super addTableView];
    if (self.ID == nil) {
        self.tableView.frame = CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height-170);
    }else{
        self.tableView.frame = CGRectMake(0, -64, self.view.frame.size.width, self.view.frame.size.height);
    }
    
}
- (void)addScrollView{
    
}

- (void)loadData{
    [super loadData];
    if (self.ID == nil) {
        NSString * path = [NSString stringWithFormat:kYouji2_url,1];
        [self loadDataWithPath:path];
    }else{
        NSString * paths = [NSString stringWithFormat:kZhuanti_url,self.ID,1];
        [self loadDataWithPath:paths];
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
    
    NSArray * array = [TraveTwoModel arrayOfModelsFromDictionaries:data];
    
    for (int i = 0; i < array.count; i++) {
        TraveTwoModel * model = array[i];
        model.ID = data[i][@"id"];
    }
    
    [self.dataSource addObjectsFromArray:array];
    
    [self.tableView reloadData];
    [super paseData:data];
}

- (void)loadMoreData{
    [super loadMoreData];
    if (self.ID == nil) {
        NSString * path = [NSString stringWithFormat:kYouji2_url,self.currentPage];
        [self loadDataMoreWithPath:path];
    }else{
        NSString * paths = [NSString stringWithFormat:kZhuanti_url,self.ID,self.currentPage];
        [self loadDataMoreWithPath:paths];
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
    NSArray * array = [TraveTwoModel arrayOfModelsFromDictionaries:data];
    
    for (int i = 0; i < array.count; i++) {
        TraveTwoModel * model = array[i];
        model.ID = data[i][@"id"];
    }
    
    [self.dataSource addObjectsFromArray:array];
    
    [self.tableView reloadData];
    [super paseMoreData:data];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.dataSource.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    TraveTwoCell * cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (cell == nil) {
        cell = [[TraveTwoCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
    }
    cell.model = self.dataSource[indexPath.row];
    TraveTwoModel * model = self.dataSource[indexPath.row];
    cell.ImageViewClick = ^(NSString * ID){
        SpecialViewController * special = [[SpecialViewController alloc]init];
        special.ID = ID;
        special.model = model;
        special.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:special animated:YES];
    };
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 210;
}















































@end
